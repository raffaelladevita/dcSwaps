# dcSwaps


usage:
dcSwaps.sh ttFile swapFile newttFile

applies swaps from swapFile to existing translation table (ttFile) creating new translation table (newttFile).
Translations tables should be in the standard format for upload to CCDB.
Swap file should contain: current sector/layer/component new sector/layer/component as example below:

     1     6    54     1     6    62
     1     1    54     1     1    62
     1     3    54     1     3    62
     1     5    54     1     5    62
     1     2    55     1     2    63
     1     4    55     1     4    63
     1     6    55     1     6    63
     1     1    55     1     1    63
     1     3    55     1     3    63
     1     5    55     1     5    63
     1     2    56     1     2    64
     1     4    56     1     4    64
     1     6    56     1     6    64
     1     1    56     1     1    64
     1     3    56     1     3    64
     1     5    56     1     5    64
     1     6    62     1     6    54
     1     1    62     1     1    54
     1     3    62     1     3    54
     1     5    62     1     5    54
     1     2    63     1     2    55
     1     4    63     1     4    55
     1     6    63     1     6    55
     1     1    63     1     1    55
     1     3    63     1     3    55
     1     5    63     1     5    55
     1     2    64     1     2    56
     1     4    64     1     4    56
     1     6    64     1     6    56
     1     1    64     1     1    56
     1     3    64     1     3    56
     1     5    64     1     5    56
