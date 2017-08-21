import _control;
//#option ('allowScopeMigrate', false);

export fCheckRoxiePackage(	 
	 string														pEmailAddresses
	,string														pPackageName
	,dataset(Layout_FilenameVersions.builds)	pall_superkeynames
	,string														pversion								= ''
	,string														pUseVersion							= 'qa'
	,boolean													pShouldUpdateRoxiePage	= true
	,string														pEnvironment						= ''		//	'N' - nonfcra, 'F' - FCRA
  ,string                           pupdateflag             = 'F'
) :=
function
  superorlogical := if(regexfind('[[:digit:]]',pUseVersion,nocase)  ,'L','S');
	
	lall_superkeynames	:= Tools.SlimFilenameDs.fOther(pall_superkeynames		, superorlogical);
	qa_superkeynames		:= Tools.fun_FilterSuperkeys(lall_superkeynames, pUseVersion);
	return fun_UpdateDOPS(pEmailAddresses, pPackageName, qa_superkeynames, pversion	,pShouldUpdateRoxiePage,pEnvironment,pupdateflag);
end;
