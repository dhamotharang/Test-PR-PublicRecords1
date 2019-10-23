/*
  This will take a superfile and clean up all subfiles except the ones that have the current version in them.
  Cleaning up means putting all those subfiles into one subfile.
  this is to prevent very large numbers of subfiles in a superfile.

WorkMan.Cleanup_Super(
   pSuperFile_Dataset   := BIPV2_Build.files().workunit_history.qa                      //Superfile dataset that contains all the subfiles
  ,pSuperFile_Name      := BIPV2_Build.filenames().workunit_history.qa                  //Superfile name of above dataset
  ,pCurrent_Version     := '20150618a'                                                  //version date of current build(which will NOT be cleaned up)
  ,pSummary_Filename    := BIPV2_Build.filenames('20150618a').workunit_history.logical  //New logical filename for all cleaned up subfiles.
);
*/
import tools,std;
EXPORT Cleanup_Super(

   pSuperFile_Dataset   //Superfile dataset that contains all the subfiles
  ,pSuperFile_Name      //Superfile name of above dataset
  ,pCurrent_Version     //version date of current build(which will NOT be cleaned up)
  ,pSummary_Filename    //New logical filename for all cleaned up subfiles.

) :=
functionmacro

  import Workman;
  return Workman.Cleanup_Super(
     pSuperFile_Dataset  
    ,pSuperFile_Name     
    ,pCurrent_Version    
    ,pSummary_Filename   
  );


endmacro;