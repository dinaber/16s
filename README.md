# 16s
Contains 2 functions to find the 16s in your sequences:
##find16s- uses rnammer 1.2 to find a 16s in your full genome.
##get16s- using the taxon id downloads the 16s from rnacentral database (from greengenes).

Requirements:
    
    ##find16s-

    You need to download and follow installation instructions for rnammer   http://www.cbs.dtu.dk/services/RNAmmer/
      Potential Errors:
      1. Wrong Hmmer version
         Make sure you have the Hmmer 2.x version installed and change the path in the program file.
      2. You may end up with errors that say something along the lines of 
          FATAL: POSIX threads support is not compiled into HMMER; --cpu doesn't have any effect
          If you get this, you need to find the following in the core-rnammer script:
          system sprintf('%s --cpu 1 --compat ...... and so on
          Remove the two instances of –cpu 1 (not the whole sentence, just ‘–cpu 1’), and you should be good to go.
      3. Missing xml file, then enter:
          cpan XML::Simple module

     ##get16s-

     Download the .txt files : greengenes_id.txt and  urs_id.txt to the path you provide the function

 Read the help of the function and follow the input instructions. Make sure you understand the output in case of no result.
      


