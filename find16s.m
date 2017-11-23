function [consensus, Score]=find16s(fastafile, output, outputfile, name, path2rnammer)
% find16s usess rnammer 1.2 to find the 16s genes in your input sequence and
% calculate the 16s consensus. if the consensus is smaller than 1000bp, the
% output is 0. 
%%%%%%%%%%%%%%
%##INPUT:
% fastafile- full path to the fastafile with the sequence
% output- 0: as a string, 1: as a file. for output 1 , 
% also provide output file and a name to be used as a header.
% path2rnammer- full path to the program.
%%%%%%%%%%%%%%
%##OUTPUT:
% the function returns the consensus if larger than 1000bp
% the function also returns the maximum score.
% If less than 3 16s are found the consensus returns the first one and the
% score set to -1.


        if nargin<5
            path2rnammer='/home/kishonylab/bin/rnnamer-1.2/';
        end

        [a,b]=system(['perl ' path2rnammer 'rnammer -S bac -m ssu -f bac16temp.fasta < ' fastafile]);
        f=fastaread('bac16temp.fasta');
        if length(f)>2
            SeqsMultiAligned = multialign(f);
            [consensus, Score] = seqconsensus(SeqsMultiAligned,'Alphabet', 'NT');
            Score=max(Score);
        else
            consensus=f(1).Sequence;
            Score=-1;
        end

        if length(consensus)<1000
            consensus=0;
        end

        if output==1
            fastawrite(outputfile ,name, consensus);
        end
        delete('bac16temp.fasta')        
    