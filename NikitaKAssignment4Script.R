

library(sangerseqR)
library(plyr)
library("BiocManager", "annotate", "genbankr")

#if loaded, unload package seqinr (interferes with sangerseqR functions)
detach("package:seqinr", unload = TRUE )

getwd()

#get all file names ending in ab1
fileNames <- Sys.glob("Data/*.ab1")

fileNames

#filter through quality control csv file
BPS <- read.csv("Data/BarcodePlateStats.csv")
BPSok <- subset(BPS,Ok == TRUE)
names<- BPSok$Chromatogram
names
#Test = possible sequences that are desirable
Test = paste(names, collapse = "|")
Test


All <- lapply(fileNames,function(x) {
  
  Pass = grepl(Test, basename(x))
  #if the sequence passses the Test, it goes on
  if(Pass == TRUE){
    ITS <- read.abif(x)
    ITSseq <- sangerseq(ITS)
    
    #paste the file basename with the primary sequences
    WW <- paste(basename(x),ITSseq@primarySeq)
    
    #sub out all "^"s with "" blank characters (> will be added in as a part of the write.fasta function)
    CC <- gsub("^", "", WW)
    
    T <- gsub(".ab1", ".ab1", CC) }
  })



All

#remove all NULL entitites in All list
Ball <- All[!sapply(All, is.null)]
Ball

#only get the list of the primary sequences
AllCC <- gsub(".*\\.ab1 ", "", Ball)
AllCC

#list of lists (to be properly proccessed by write.fasta)
Qal <-as.list(AllCC)
Qal

# only get the suitable sequence names
AllBB <- gsub("ab1.*", "ab1", Ball)
AllBB

#load seqinr package
library(seqinr)

#write fasta file "nikita.fasta"
write.fasta(Qal, AllBB, file.out = "nikita.fasta")


