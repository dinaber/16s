function  [gene]=get16s(taxid, loc, dna, output, out_file) 
% To run you need the greengenes_id.txt and urs_id.txt files in loc folder.
%INPUTS-
% taxid- provide it with a string taxon id
% loc- full path to the folder with the input files and the output file (optional)
% dna- 0 if you want the RNA form, 1 if you want the DNA form (dna form
% possible only if output=0
% output- 0: get the sequence as a string, 1:get the sequence as a file, 
% 2: append the sequence to an existing file. Give out_file if output is 1 or 2

    %find the taxid and convert it to urs number. if appears more than
    %once, take the first.
    [status,out]=system(['grep -n -m 1 ^' taxid '$ ' loc 'greengenes_id.txt |cut -f1 -d:']) ;
    if isempty(out)
        disp('no such taxid')
        gene=0;
        return
    end
    [status1,out1]=system(['sed -n ' out(1:end-1) 'p ' loc 'urs_id.txt']);
    
    %get the corresponding 16s gene from rna-central and output according
    %to output status
    if output==0
        s=urlread(['http://rnacentral.org/api/v1/rna/' out1(1:end-1) '.fasta']);
        gene=cell2mat(regexp(s, '[A-Z]{30,}+', 'match'));
        if dna==1
            gene=rna2dna(gene);
        end
    elseif output==1
        [a,b]=system(['curl "http://rnacentral.org/api/v1/rna/' out1 '.fasta" > ' loc out_file]);
    else
        [a,b]=system(['curl "http://rnacentral.org/api/v1/rna/' out1 '.fasta" >> ' loc out_file]);
    end

        
