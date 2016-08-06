;;; ledger-pricedb.el --- Simple extension to generate a pricedb file for ledger

;;; Commentary:
;; ledger-pricedb--stocks configures the list of ticker to get
;; ledger-pricedb--pricedb configures the location of the pricedb file
;; ledger-pricedb-get-prices fetches the tickers using the Yahoo API
;; ledger-pricedb-generate-pricedb generates a list of strings compatible with the format
;; ledger-pricedb-save-pricedb saves the file to disk

;;; Code:
(defvar ledger-pricedb--yahoo_uri nil)
(defvar ledger-pricedb--stocks nil)
(defvar ledger-pricedb--pricedb nil)

(set 'ledger-pricedb--yahoo_uri "http://download.finance.yahoo.com/d/quotes.csv?s=")

(defun ledger-pricedb-get-prices (uri tickers)
  "Get prices from Yahoo using URI for the http uri for the tickers specified in TICKERS."
  (split-string
   (with-current-buffer (url-retrieve-synchronously
                         (concat uri (mapconcat 'identity tickers "+") "&f=l1"))
     (goto-char (point-min))
     (re-search-forward "^\n")
     (delete-region (point) (point-min))
     (buffer-string)) "\n"))

(defun ledger-pricedb-generate-pricedb (prices)
  "Take a list of PRICES usually obtained by ledger-pricedb-get-prices and convert them into pricedb format."
  (cl-mapcar (lambda (x y) (format "P %s %s $%s" (format-time-string "%Y/%m/%d %H:%M:%S") y x))
             prices
             ledger-pricedb--stocks))

(defun ledger-pricedb-save-pricedb ()
  "Save the prices downloaded by generate-pricedb to the pricedb file."
  (interactive)
  (write-region "\n" nil  ledger-pricedb--pricedb 'append)
  (write-region (mapconcat 'identity (ledger-pricedb-generate-pricedb (ledger-pricedb-get-prices ledger-pricedb--yahoo_uri ledger-pricedb--stocks)) "\n") nil  ledger-pricedb--pricedb 'append)
  (write-region "\n" nil  ledger-pricedb--pricedb 'append))

(provide 'ledger-pricedb)
;;; ledger-pricedb.el ends here
