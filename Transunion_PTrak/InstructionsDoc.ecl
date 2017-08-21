/*TUCS Build

-	FTP Monthly Files 
o	Monthly file location \\tapeload02b\k\people\tucs\
o	Create a directory (naming convention: yyyymmdd)  in //edata14/load01/TUCS/vendor/
o	FTP files to //edata14/load01/TUCS/vendor/<yyyymmdd>

-	Process Monthly Files Before Spraying to Thor
o	Unzip files : pkzipc –extract <filename>
o	Sometimes the vendor delivers files that are zipped twice; in that case unzip delivered files and resulting files until the result is 59 files starting with GROUP0.
o	Concatenate GROUP0 files to a single file (vendor.d00) : Cat GROUP0* > vendor.d00
  Delete GROUP0* files : rm GROUP0*
  Do the same as for the delete files, but give name 'delete.del00' to the file with the concatenated files
o	Do NOT spray file to Thor manually, the build will perform the spray.

-	Run the TUCS Build
o	Run attribute Transunion_ptrak.BWR_Transunion_Build for monthly incremental update ('', 'yyyymmdd');  
o	Run attribute Transunion_ptrak.BWR_Transunion_Build for full file update ('yyyymmdd', '');
   yyyymmdd is the build version

-	Update DOPS and Orbit pages.
*/
