function string = geneToGdfString(gene)

string = '';
frm = '%s  %s  %s  %d  %d  %d ';
string = sprintf(frm, gene.origin,gene.geneID,gene.chrom,gene.strand,gene.start,gene.stop);
for(j=1:numel(gene.exp))
    txt2 = sprintf('%f  ',gene.exp(j));
    string = [string txt2];
end
