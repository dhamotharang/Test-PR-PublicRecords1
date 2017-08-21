import _control,wk_ut,std,ut,WsDFU;

EXPORT Rename_File(
   string  psrcname   
  ,string  pdstname   
  ,boolean poverwrite = false
  ,string  pESp       = wk_ut._Constants.LocalEsp
) :=
function

	RenameInRecord :=
	record, maxlength(200)
		string   srcname    {xpath('srcname'    )} := psrcname  ;
		string   dstname    {xpath('dstname'    )} := pdstname  ;
		boolean  overwrite  {xpath('overwrite'  )} := poverwrite;
	end;
	

	RenameOutRecord :=
	record, maxlength(100000)
	
		string exception_code     {xpath('Exceptions/Exception/Code'    )};
		string exception_source   {xpath('Exceptions/Exception/Source'  )};
		string exception_msg      {xpath('Exceptions/Exception/Message' )};
    string dfuwuid            {xpath('wuid'                         )};
	end;

    myurl := 'http://' + pESp + ':8010/FileSpray';
    myesp := pESp;
    
		soap_results := SOAPCALL(
			 myurl
			,'Rename'
			,RenameInRecord
			,dataset(RenameOutRecord)
			,xpath('RenameResponse')
      ,literal
		);
		
  rename_description := 'wk_ut.Rename_File: Renaming ' + psrcname + ' to ' + pdstname + ' in ' + pESp + ' on date ' + ut.GetTimeDate() + ' in ' + workunit;
  superfileowners := WsDFU.LogicalFileSuperOwners(psrcname,pESp) /*: independent*/;
  ds_superowners := wk_ut.get_DS_Result(workunit,'wk_ut_Rename_File_Superfileowners',recordof(superfileowners));
  
  return sequential(
    output(superfileowners  ,named('wk_ut_Rename_File_Superfileowners'),all,overwrite)
   ,apply(ds_superowners ,output(WsDFU.RemoveSuperfile(name,psrcname,pESp) ,named('RemoveSuperfile_Results'),extend))
   ,output(soap_results  ,named('Rename_Results')  ,extend) 
   ,apply(ds_superowners ,output(WsDFU.AddSuperfile(name,pdstname,pESp) ,named('AddSuperfile_Results'),extend))
   ,output(WsDFU.SetFileDescription(pdstname,
         rename_description + '\n'
       + WsDFU.GetFileDescription(pdstname,pESp)
       ,pESp
     )  ,named('SetFileDescription_Results'),extend)
   ,STD.System.Log.addWorkunitInformation(rename_description  )
 );
end;

                                                                            