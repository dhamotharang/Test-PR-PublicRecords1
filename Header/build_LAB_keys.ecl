import RoxieKeyBuild,ut,idl_adl_mapping;
export build_LAB_keys(string filedate = version_build) := module

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(idl_adl_mapping.keys.key_rid,'~thor_data400::key::LAB.DID_RID','~thor_data400::key::LAB::'+filedate+'::DID_RID',b1);
export buildk
		:=
			sequential(
								b1
								);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::LAB.DID_RID','~thor_data400::key::LAB::'+filedate+'::DID_RID',m1);
export mv2blt
		:=
			sequential(
								m1
								);

ut.MAC_SK_Move_v2('~thor_data400::key::LAB.DID_RID', 'Q', q1);
export mv2qa
		:=
			sequential(
								q1
								);

end;