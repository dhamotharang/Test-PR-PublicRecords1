import doxie_files, doxie,ut,sanctn_mari,Data_Services;				 
									 
f_sanctn_party := SANCTN_Mari.files_SANCTN_DID.party_did;
layout_party_base	:= SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base;

KeyName 			:= 'thor_data400::key::sanctn::np::';

dsParty := project(f_sanctn_party,transform(layout_party_base-enh_did_src,
																						self.BATCH 				:= trim(left.BATCH,left,right);
																						self.INCIDENT_NUM	:= trim(left.INCIDENT_NUM,left,right);
																						self.PARTY_NUM		:= trim(left.PARTY_NUM,left,right);
																						self:=left));
		
export key_Midex_NP_party := index(dsParty
																	,{BATCH,INCIDENT_NUM,PARTY_NUM}
																	,{dsParty} 		//do not include this flag in the key file
																	,Data_Services.Data_Location.Prefix('sanctn')+ KeyName +doxie.Version_SuperKey+ '::party');
																	

