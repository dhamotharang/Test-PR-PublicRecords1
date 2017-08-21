import RoxieKeyBuild, ut;

export Proc_Build_Keys(string version) := function

RoxieKeyBuild.Mac_SK_BuildProcess_Local(infutorcid.Key_Infutor_Phone,'~thor_data400::key::infutorcid::'+version+'::phone','~thor_data400::key::infutorcid::phone',bPhone);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::infutorcid::'+version+'::phone','~thor_data400::key::infutorcid::phone',mPhone);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::infutorcid::phone', 'Q', mPhone_qa);

//

RoxieKeyBuild.Mac_SK_BuildProcess_Local(infutorcid.Key_Infutor_Phone_FCRA,'~thor_data400::key::infutorcid::'+version+'::phone_fcra','~thor_data400::key::infutorcid::fcra::phone',bPhone_fcra);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::infutorcid::'+version+'::phone_fcra','~thor_data400::key::infutorcid::fcra::phone',mPhone_fcra);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::infutorcid::fcra::phone', 'Q', mPhone_fcra_qa);

//

RoxieKeyBuild.Mac_SK_BuildProcess_Local(infutorcid.Key_Infutor_DID,'~thor_data400::key::infutorcid::'+version+'::did','~thor_data400::key::infutorcid::did',bDID);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::infutorcid::'+version+'::did','~thor_data400::key::infutorcid::did',mDID);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::infutorcid::did', 'Q', mDID_qa);

//

RoxieKeyBuild.Mac_SK_BuildProcess_Local(infutorcid.Key_Infutor_DID_FCRA,'~thor_data400::key::infutorcid::'+version+'::did_fcra','~thor_data400::key::infutorcid::fcra::did',bdid_fcra);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::infutorcid::'+version+'::did_fcra','~thor_data400::key::infutorcid::fcra::did',mDID_fcra);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::infutorcid::fcra::did', 'Q', mDID_fcra_qa);


run_keys := sequential(
				parallel(bPhone, bPhone_fcra, bDID, bDID_fcra),
				parallel(mPhone, mPhone_fcra, mDID, mDID_fcra),
				parallel(mPhone_qa, mPhone_fcra_qa, mDID_qa, mDID_fcra_qa),
				RoxieKeybuild.updateversion('InfutorcidKeys',version,'John.Freibaum@lexisnexis.com, cecelie.guyton@lexisnexis.com',,'N');
				RoxieKeybuild.updateversion('FCRA_InfutorcidKeys',version,'John.Freibaum@lexisnexis.com, cecelie.guyton@lexisnexis.com',,'F')
					);
					
return run_keys;
end;