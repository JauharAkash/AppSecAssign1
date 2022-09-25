giftcardreader: giftcardreader.c
	gcc -o giftcardreader giftcardreader.c && ./giftcardreader 1 crash1.gft
	gcc -o giftcardreader giftcardreader.c && ./giftcardreader 1 crash2.gft
	gcc -o giftcardreader giftcardreader.c && ./giftcardreader 1 hang.gft


giftcardexamplewriter:
	gcc -o giftcardexamplewriter giftcardexamplewriter.c && ./giftcardexamplewriter
        
giftcardwriter_crash1:  
	gcc -o giftcardwriter_crash1 giftcardwriter_crash1.c && ./giftcardwriter_crash1

giftcardwriter_crash2:
	gcc -o giftcardwriter_crash2 giftcardwriter_crash2.c && ./giftcardwriter_crash2

