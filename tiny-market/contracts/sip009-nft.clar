(impl-trait .sip009.nft-trait)

(define-non-fungible-token sip009-nft uint)

(define-constant MINT_PRICE u5000000) ;; 5 STX
(define-constant CONTRACT_OWNER tx-sender) 
;;principal that defined the contract, in this case, will also recieve the 5 STX

(define-constant ERR_NOT_TOKEN_OWNER (err u101))

(define-data-var last-token-id uint u0)
(define-data-var base-uri (string-ascii 100) "insert external string hash here")

(define-read-only (get-last-token-id)
    (ok (var-get last-token-id))
)

(define-read-only (get-token-uri (id uint))
    (ok (some (var-get base-uri)))      ;;ok cause its an optional, exxpecting something that hasnt been made yet
)

(define-read-only (get-owner (id uint))
    (ok (nft-get-owner? sip009-nft id))
)

(define-public (transfer (id uint) (sender principal) (receiver principal))
    (begin
        (asserts! (is-eq tx-sender sender) ERR_NOT_TOKEN_OWNER)
        (nft-transfer? sip009-nft id sender receiver)
    )
)

(define-public (mint)
    (let 
        (
            (id (+ (var-get last-token-id) u1))
        )
        (try! (stx-transfer? MINT_PRICE tx-sender CONTRACT_OWNER))  ;;pay mint fee/transfer STX
        (try! (nft-mint? sip009-nft id tx-sender ))     ;;create/mint a new nft
        (var-set last-token-id id)  ;;update/set our new "last token id"
        (ok id)     ;;will return new id
    )

)