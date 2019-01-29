library(sangerseqR)
rbcL<-read.abif("./Data/DNA_Barcoding/1Ipos_F_P1815443_064.ab1") # Read
rbcLseq <- sangerseq(rbcL) # Extract
SeqX<-makeBaseCalls(rbcLseq) # Call 

