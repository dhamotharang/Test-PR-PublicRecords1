import RoxieKeyBuild, ut, Orbit3, dops, DOPSGrowthCheck;

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

orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('Caller ID',(string)version,'N');

orbit_updatef := Orbit3.proc_Orbit3_CreateBuild_AddItem('FCRA Caller ID',(string)version,'F');

GetDops:=dops.GetDeployedDatasets('P','B','F');
OnlyInfutor:=GetDops(datasetname='FCRA_InfutorcidKeys');
father_version := OnlyInfutor[1].buildversion;
set of string Infutor_InputSet:=['did','phone','fname','lname','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','rec_type','county','geo_lat','geo_long','geo_blk','dt_first_seen','dt_last_seen'];
DeltaCommands:=sequential(
DOPSGrowthCheck.CalculateStats('FCRA_InfutorcidKeys','infutorcid.Key_Infutor_DID_FCRA','key_Infutor_did_FCRA','~thor_data400::key::infutorcid::'+version+'::did_fcra','did','persistent_record_id','','phone','','',version,father_version),
DOPSGrowthCheck.DeltaCommand('~thor_data400::key::infutorcid::'+version+'::did_fcra','~thor_data400::key::infutorcid::'+father_version+'::did_fcra','FCRA_InfutorcidKeys','key_Infutor_did_FCRA','infutorcid.Key_Infutor_DID_FCRA','persistent_record_id',version,father_version,Infutor_InputSet),
DOPSGrowthCheck.ChangesByField('~thor_data400::key::infutorcid::'+version+'::did_fcra','~thor_data400::key::infutorcid::'+father_version+'::did_fcra','FCRA_InfutorcidKeys','key_Infutor_did_FCRA','infutorcid.Key_Infutor_DID_FCRA','persistent_record_id','',version,father_version),
DopsGrowthCheck.PersistenceCheck('~thor_data400::key::infutorcid::'+version+'::did_fcra','~thor_data400::key::infutorcid::'+father_version+'::did_fcra','FCRA_InfutorcidKeys','key_Infutor_did_FCRA','infutorcid.Key_Infutor_DID_FCRA','persistent_record_id',Infutor_InputSet,Infutor_InputSet,version,father_version)
);


run_keys := sequential(
				parallel(bPhone, bPhone_fcra, bDID, bDID_fcra),
				parallel(mPhone, mPhone_fcra, mDID, mDID_fcra),
				parallel(mPhone_qa, mPhone_fcra_qa, mDID_qa, mDID_fcra_qa),
				dops.updateversion('InfutorcidKeys',version,'John.Freibaum@lexisnexis.com, cecelie.guyton@lexisnexis.com',,'N'),
				orbit_update,
				dops.updateversion('FCRA_InfutorcidKeys',version,'John.Freibaum@lexisnexis.com, cecelie.guyton@lexisnexis.com',,'F'),
				orbit_updatef,
				DeltaCommands
					);
		
return run_keys;
end;