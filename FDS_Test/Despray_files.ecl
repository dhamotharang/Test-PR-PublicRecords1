import versioncontrol, _control, business_header,ut;

export Despray_files(

	 string		pversion
	,string		pServer					= _control.IPAddress.edata10
	,string		pMount					= '/prod_data_build_10/temp/'
	,boolean	pOverwrite			= false
	,boolean	pShouldDespray	= true
	,string		pFilter					= ''

) := 
function

	lDate_MMDDYYYY_i2(string pdate) :=
	function 
		return intformat(ut.Date_MMDDYYYY_i2(pdate),8,1);
	end;
	

	myfilestodespray := dataset([
		
		 {	 Filenames(pversion).out.Associates_Append.new 		+ 'PipeDelimited',pServer,pMount + 'lexisnexis_associates_app_' + lDate_MMDDYYYY_i2(pversion)}
		,{	 Filenames(pversion).out.Associates_Extract.new		+ 'PipeDelimited',pServer,pMount + 'lexisnexis_associates_ext_' + lDate_MMDDYYYY_i2(pversion)}
		,{	 Filenames(pversion).out.Employment_Append.new 		+ 'PipeDelimited',pServer,pMount + 'lexisnexis_employment_app_' + lDate_MMDDYYYY_i2(pversion)}
		,{	 Filenames(pversion).out.Employment_Extract.new		+ 'PipeDelimited',pServer,pMount + 'lexisnexis_employment_ext_' + lDate_MMDDYYYY_i2(pversion)}
		,{	 Filenames(pversion).out.Relatives_Append.new 		+ 'PipeDelimited',pServer,pMount + 'lexisnexis_relatives_app_'	+ lDate_MMDDYYYY_i2(pversion)}
		,{	 Filenames(pversion).out.Relatives_Extract.new		+ 'PipeDelimited',pServer,pMount + 'lexisnexis_relatives_ext_'	+ lDate_MMDDYYYY_i2(pversion)}

	], versioncontrol.Layout_DKCs.Input);

	lfilter := if(pfilter = '', true, regexfind(pfilter,myfilestodespray.logicalkeyname,nocase));

	return versioncontrol.fDesprayFiles(myfilestodespray(lfilter),,,'DesprayFDSInfo',pOverwrite,not pShouldDespray);

end;