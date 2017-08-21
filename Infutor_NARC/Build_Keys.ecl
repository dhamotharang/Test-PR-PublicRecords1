/*2015-01-29T21:08:58Z (Jose Bello_Prod)

*/
import doxie, VersionControl,RoxieKeyBuild,ut,ProfileBooster;

export Build_Keys(string pversion, boolean pUseProd = false) :=
module

  RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(ProfileBooster.Key_Infutor_DID, '~thor_data400::key::mktattr::infutor_did', '~thor_data400::key::mktattr::'+pversion+'::infutor_did',bk);
  Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::mktattr::@version@::infutor_did', '~thor_data400::key::mktattr::'+pversion+'::infutor_did', mk);
  Roxiekeybuild.MAC_SK_Move('~thor_data400::key::mktattr::@version@::infutor_did','Q',mq);
																		  
	export full_build := sequential(bk,mk,mq);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping infutor_narc.Build_Keys atribute')
	);

end;