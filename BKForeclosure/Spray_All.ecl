EXPORT Spray_All(STRING filedate) := MODULE


Spray_All := 
  PARALLEL(
	         BKForeclosure.Spray_UpdateFile(filedate).SprayFile,
           BKForeclosure.Spray_deleteFile(filedate).SprayFile,
           BKForeclosure.Spray_RefreshFile(filedate).SprayFile
					 );
// To set Deleted foreclosure records					 
Delete_flag  := BKForeclosure.fGetInputFile(filedate).do_all;

EXPORT spray_file  := SEQUENTIAL(Spray_All, Delete_flag);

END;