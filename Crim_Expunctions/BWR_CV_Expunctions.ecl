/*
-Orig data location - T:\court_criminal\court_ventures_expunges_cv_(ei)
-Save as \t delimted file.  CSV is problematic due to embedded commas.

- Ex:D20091016-170008
FTP to Unix directory of your choice 
Spray to Thor

-Run BWR

*/

export BWR_CV_Expunctions :=

Crim_Expunctions.fCleanCVExpunctions('Enter File Date Here');
