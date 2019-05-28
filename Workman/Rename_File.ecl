import _control,std,ut,WsDFU,FileSpray;

EXPORT Rename_File(
   string  psrcname   
  ,string  pdstname   
  ,boolean poverwrite = false
  ,string  pESp       = _Config.LocalEsp
) :=
function

  rename_soap_results := FileSpray.soapcall_Rename(psrcname,pdstname,poverwrite,pESp);
  
  rename_description      := 'Workman.Rename_File: Renaming ' + psrcname + ' to ' + pdstname + ' in ' + pESp + ' on date ' + Workman.GetTimeDate() + ' in ' + workunit;
  superfileowners         := WsDFU.LogicalFileSuperOwners(psrcname,pESp) /*: independent*/;
  FsLogicalFileNameRecord := {  STRING name };
  ds_superowners          := Workman.get_DS_Result(workunit,'Workman_Rename_File_Superfileowners',FsLogicalFileNameRecord,pESp,true);
  
  return sequential(
    output(superfileowners    ,named('Workman_Rename_File_Superfileowners'),all,overwrite)
   ,output('maybe this works' ,named('need_space'),overwrite)
   ,apply(superfileowners ,output(WsDFU.RemoveSuperfile(name,psrcname,pESp) ,named('RemoveSuperfile_Results'),extend))
   ,output(rename_soap_results  ,named('Rename_Results')  ,extend) 
   ,apply(superfileowners ,output(WsDFU.AddSuperfile(name,pdstname,pESp) ,named('AddSuperfile_Results'),extend))
   ,output(WsDFU.SetFileDescription(pdstname,
         rename_description + '\n'
       + WsDFU.GetFileDescription(pdstname,pESp)
       ,pESp
     )  ,named('SetFileDescription_Results'),extend)
   ,STD.System.Log.addWorkunitInformation(rename_description  )
 );
end;

                                                                            