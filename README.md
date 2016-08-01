# ledger-pricedb

Simple emacs package to generate and update a pricedb
file for ledger-cli (http://ledger-cli.org)

Stock tickers can be added from your ledger file and current prices
downloaded automatically using the Yahoo! finance API.

# Basic use and configuration
```elisp

(load-file "~/ledger-pricedb/ledger-pricedb.el")
(set 'ledger-pricedb--stocks '("VGTSX" "VFIFX" "VBTLX" "VTIAX" "VTSAX" "VTSMX" "NFLX" "VSMAX"))
(set 'ledger-pricedb--pricedb "~/ledger/.pricedb")

(global-set-key (kbd "C-c s") (lambda () (interactive) (ledger-pricedb-save-pricedb)))

```

# Output in pricedb:

```
P 2016/07/31 18:00:05 VGTSX $14.76
P 2016/07/31 18:00:05 VFIFX $30.19
P 2016/07/31 18:00:05 VBTLX $11.11
P 2016/07/31 18:00:05 VTIAX $24.70
P 2016/07/31 18:00:05 VTSAX $54.13
P 2016/07/31 18:00:05 VTSMX $54.11
P 2016/07/31 18:00:05 NFLX $91.65
P 2016/07/31 18:00:05 VSMAX $58.03
```
