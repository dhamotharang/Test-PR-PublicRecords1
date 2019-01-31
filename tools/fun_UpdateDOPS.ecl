import _control, dops,tools,wk_ut;
export fun_UpdateDOPS(	 
	 string									pEmailAddresses
	,string									pPackageName
	,dataset(Layout_Names)	pall_superkeynames
	,string									pversion								= ''
	,boolean								pShouldUpdateRoxiePage	= true
	,string									pEnvironment						= ''		//	'N' - nonfcra, 'F' - FCRA
  ,string                 pupdateflag             = 'F'
) :=
function
	
	roxieemailbody	:= fun_RoxieEmailBody(pall_superkeynames,pversion);
	alert						:= if(regexfind('keys', roxieemailbody[1..4], nocase), ' Package Completed ', ' ALERT KEY VERSION MISMATCH ');
	
	roxiefilename := 'pkgfile::'+pPackageName+'::'+pversion+'::';
	file_list := fileservices.LogicalFileList()(regexfind(roxiefilename	, name		, nocase));
	
	update_roxie := if(		regexfind('keys', roxieemailbody[1..4], nocase)
										and count(nothor(file_list)) = 0
										and pShouldUpdateRoxiePage
                    and tools._Constants.Isdataland = false
														, dops.updateversion(pPackageName, pversion, pEmailAddresses,,l_inenvment := pEnvironment,l_updateflag := pupdateflag)
									);
	
	return sequential(
		fileservices.sendemail(	 
									 pEmailAddresses
									,pPackageName + alert + pversion + ' on ' + _Control.ThisEnvironment.Name
									,	tools.fun_GetWUBrowserString() + '\n'
										+ roxieemailbody
									)
    ,output(roxieemailbody)
		,update_roxie
	);
end;
