import std;
export Delete_File(string pname,unsigned cnt,unsigned ptotal_cnt) :=
function

  return
  sequential(
  if(fileservices.SuperFileExists(pname)
    ,Tools.mod_Utilities.removesuper	(pname,false)           //it is a superfile
    
    ,if(fileservices.FileExists(pname)
      ,if(count(fileservices.LogicalFileSuperOwners(pname)) = 0
      
        ,Tools.mod_Utilities.DeleteLogical(pname)               //not a member of superfiles, just delete
        
        ,sequential(                                            //it is a member of superfile(s), clear it from them and then delete
           fileservices.StartSuperFileTransaction()
          ,apply(fileservices.LogicalFileSuperOwners(pname)   ,fileservices.RemoveSuperFile('~' + name, pName))
          ,fileservices.finishSuperFileTransaction()
          ,Tools.mod_Utilities.DeleteLogical(pname)
        )
      )
    )
  )
  ,output(cnt,named('Number_Files_Deleted'),overwrite)
  ,STD.System.Log.addWorkunitInformation ('Number of files deleted so far: ' + (string)cnt + ' out of a total of ' + ptotal_cnt + ' files.')
  );
      
  // return
  // if(fileservices.SuperFileExists(pname)
    // ,Tools.mod_Utilities.removesuper	(pname,false)
    // ,Tools.mod_Utilities.DeleteLogical(pname)
  // );


end;
