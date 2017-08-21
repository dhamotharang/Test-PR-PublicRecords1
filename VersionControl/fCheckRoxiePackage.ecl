import _control,tools;

export fCheckRoxiePackage(	 
	 string														pEmailAddresses
	,string														pPackageName
	,dataset(layout_versions.builds)	pall_superkeynames
	,string														pversion								= ''
	,string														pUseVersion							= 'qa'
	,boolean													pShouldUpdateRoxiePage	= true
	,string														pEnvironment						= ''		//	'N' - nonfcra, 'F' - FCRA
  ,string                           pupdateflag             = 'F'

) :=
  Tools.fCheckRoxiePackage(pEmailAddresses,pPackageName	,pall_superkeynames	,pversion,pUseVersion,pShouldUpdateRoxiePage,pEnvironment,pupdateflag);
