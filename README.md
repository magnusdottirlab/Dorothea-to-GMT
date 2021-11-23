# Dorothea-to-GMT
This script takes the latest [dorothea](https://saezlab.github.io/dorothea/) dataset of Transcription Factor-Target interactions and transposes it into a .gmt file 
suitable for The Broad/UCSD's [GSEA](https://www.gsea-msigdb.org/gsea/index.jsp) program. GSEA is an alternative to the recommended tool VIPER. 

The file dorothea.R uses the dorothea R library to read in the dataset which is formatted as follows: 

|   |TF    |confidence|target |mor   |
|---|------|----------|-------|------|
| 1 |Ahr   |B         | Cyp1a1|      1|
| 2 |Ahr   |B         | Cyp1a2|      1|
| 3 |Ahr   |B         | Cyp1b1|      1|
| 4 |Ahr   |B         | Fos   |      1|
| 5 |Ahr   |B         | Myc   |      1|
| 6 |Ahr   |B         | Ugt1a7c|     1|
| 7 |Ahr   |B         | Ugt1a6a|     1|
| 8 |Ahr   |B         | Ugt1a6b|     1|
| 9 |Ahr   |B         | Asap1  |     1|
|10 |Ahr   |B         | Erg    |     1|
|11 |Ahr   |B         | Vgll4  |     1|
|12 |Ar    |A         | Abce1  |     1|
|13 |Ar    |A         | Acad12 |     1|
|14 |Ar    |A         | Acad10 |     1|
|15 |Ar    |A         | Ahsg   |     1|
|16 |Ar    |A         | Akr1b3 |     1|
|17 |Ar    |A         | Akt1   |     1|
|18 |Ar    |A         | Anapc10|     1|
|19 |Ar    |A         | Ap2m1  |     1|
|20 |Ar    |A         | Appbp2 |     1|

and the script rearranges it like this: 

|TF|Description |Targets| | | | | | | | | | |
|--|------------|-------|--|--|--|--|--|--|--|--|--|--|--|
|Ahr|  1     |Cyp1a1|Cyp1a2|Cyp1b1|Fos|Myc|Ugt1a7c|Ugt1a6a|Ugt1a6b|Asap1|Erg|Vgll4|
|Ar |  2     |Abce1|Acad12|Acad10|Ahsg|Akr1b3|Akr1b3|Akt1|Anapc10|Ap2m1|Appbp2|

The user can easily select the desired confidence level. See dorothea's [paper](https://genome.cshlp.org/content/29/8/1363) or the comments in the script for what each confidence level signifies. 

The supplied gmt file in this repository contains TF-Target interactions with A, B, C, and D grades. 

Dorothea only supports mouse and human. The code required for both is in the script, simply comment/uncomment the one you don't need. 

Note: The column that is suppose to be a description in the GMT file is currently just dummy numbers. The script may soon be updated so this field is a 
link to the TFs Reactome entry. 

