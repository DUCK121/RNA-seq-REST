#KEGG官网download的genenset转出gmt
#20200430
setwd("D:/codes-v1")
path2gene_file<-"D:/codes-v1/kegg2gene.txt"
tmp=read.table(path2gene_file,sep="\t",colClasses=c('character'))

library(org.Mm.eg.db)




#tmp=toTable(org.Hs.egPATH)
# first column is kegg ID, second column is entrez ID
GeneID2kegg_list<<- tapply(result_transcripts[,1],as.factor(result_transcripts[,2]),function(x) x)
kegg2GeneID_list<<- tapply(result_transcripts[,2],as.factor(result_transcripts[,1]),function(x) x)
head(GeneID2kegg_list)

sig.gene<-tmp
head(sig.gene)
gene<-sig.gene[,2]
head(gene)
gene.df<-bitr(gene, fromType = "ENTREZID", 
              toType = c("SYMBOL"),
              OrgDb = org.Mm.eg.db)
head(gene.df)
head(sig.gene)
names(sig.gene) <- c(" ","ENTREZID")
head(sig.gene)
result_transcripts<-merge(gene.df,sig.gene,by="ENTREZID")
head(result_transcripts)
result_transcripts<- result_transcripts[,-1]


#tmp=toTable(org.Hs.egPATH)
# first column is kegg ID, second column is entrez ID
GeneID2kegg_list<<- tapply(result_transcripts[,2],as.factor(result_transcripts[,1]),function(x) x)
kegg2GeneID_list<<- tapply(result_transcripts[,1],as.factor(result_transcripts[,2]),function(x) x)

kegg2symbol_list<-kegg2GeneID_list

write.gmt <- function(geneSet=kegg2symbol_list,gmt_file='kegg2symbol.gmt'){
  sink( gmt_file )
  for (i in 1:length(geneSet)){
    cat(names(geneSet)[i])
    cat('\tNA\t')
    cat(paste(geneSet[[i]],collapse = '\t'))
    cat('\n')
  }
  sink()
}
write.gmt(geneSet=kegg2symbol_list,gmt_file='kegg2symbol.gmt')
