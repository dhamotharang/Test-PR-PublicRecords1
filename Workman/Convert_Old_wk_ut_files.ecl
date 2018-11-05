/*
WorkMan.Convert_Old_wk_ut_files(sort(bipv2_build.files().workunit_history_.qa,-wuid));
*/


import wk_ut,WsDFU;
EXPORT Convert_Old_wk_ut_files(

  dataset(wk_ut.Layouts.wks_slim_filename) pWk_ut_files 

) :=
function

  ds_convert := project(pWk_ut_files  ,transform(layouts.wks_slim
    ,self.Build_name  := regexfind('^.*::(.*)$',left.__filename,1)
    ,self.owner       := WsDFU.GetOwner(left.__filename,left.esp)
    ,self             := left
    ,self             := []
  ));

  return ds_convert;

end;