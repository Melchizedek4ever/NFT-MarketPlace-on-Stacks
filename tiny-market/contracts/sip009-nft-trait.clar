
;; title: sip009-nft-trait
;; version:
;; summary:
;; description:

;; traits
;;

;; token definitions
;; 

;; constants
;;

;; data vars
;;

;; data maps
;;

;; public functions
;;
(define-public (mint (recipient principal))
    (let ((token-id (+ (var-get token-id-nonce) u1)))
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (try! (nft-mint? stacksies token-id recipient))
        (asserts! (var-set token-id-nonce token-id) err-token-id-failure)
        (ok token-id)
    )
)

;; read only functions
;;

;; private functions
;;
