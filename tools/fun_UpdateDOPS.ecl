import _control, Roxiekeybuild,tools;
export fun_UpdateDOPS(	 
	 string									pEmailAddresses
	,string									pPackageName
	,dataset(Layout_Names)	pall_superkeynames
	,string									pversion								= ''
	,boolean								pShouldUpdateRoxiePage	= true
	,string									pEnvironment						= ''		//	'N' - nonfcra, 'F' - FCRA
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
														, Roxiekeybuild.updateversion(pPackageName, pversion, pEmailAddresses,,inenvment := pEnvironment)
									);
	
	return sequential(
		fileservices.sendemail(	 
									 pEmailAddresses
									,pPackageName + alert + pversion + ' on ' + _Control.ThisEnvironment.Name
									,roxieemailbody
									)
    ,output(roxieemailbody)
		,update_roxie
	);
end;
