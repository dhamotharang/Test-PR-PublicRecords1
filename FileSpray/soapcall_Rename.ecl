EXPORT soapcall_Rename(
   string  psrcname   
  ,string  pdstname   
  ,boolean poverwrite = false
  ,string  pESp       = _Config.LocalEsp
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

  import ut,Workman;
  
  #UNIQUENAME(SOAPCALLCREDENTIALS)
  #SET(SOAPCALLCREDENTIALS  ,ut.Credentials().mac_add2Soapcall())

  soap_results := SOAPCALL(
     myurl
    ,'Rename'
    ,RenameInRecord
    ,dataset(RenameOutRecord)
    ,xpath('RenameResponse')
    ,literal
  );

  soap_results_remote := SOAPCALL(
     myurl
    ,'Rename'
    ,RenameInRecord
    ,dataset(RenameOutRecord)
    ,xpath('RenameResponse')
    ,literal
   %SOAPCALLCREDENTIALS%
  );

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,soap_results  ,soap_results_remote);
  
  return returnresult;
  
end;