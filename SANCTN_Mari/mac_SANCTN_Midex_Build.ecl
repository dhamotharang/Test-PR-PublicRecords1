import SANCTN_Mari,RoxieKeyBuild,Scrubs_SANCTN_NPKeys;

export mac_SANCTN_Midex_Build(filedate) := MACRO
#uniquename(spray_data)
#uniquename(clean_data)
#uniquename(map_common)
#uniquename(aid_data)
#uniquename(did_data)
#uniquename(build_keys)
#uniquename(updatedops)
#uniquename(qa_samp)

// Spray the new files onto Thor
%spray_data% := SANCTN_Mari.proc_midex_build(filedate);

// Clean the incident and party data
%clean_data%     := parallel(SANCTN_Mari.clean_Midex_incident(filedate)
                             ,SANCTN_Mari.clean_Midex_party(filedate));											 
														 


//map cleaned data to the NonPublic SANCTN incident and party common schema
%map_common%     := parallel(
														 SANCTN_Mari.map_Midex_incident_common(filedate)
                             ,SANCTN_Mari.map_Midex_party_common(filedate)
														 ,SANCTN_Mari.map_Midex_incident_text(filedate)
														 ,SANCTN_Mari.map_Midex_codes(filedate)
														 ,SANCTN_Mari.map_party_text(filedate)
														 ,SANCTN_Mari.map_party_aka_dba(filedate)
														 );

//Add AID to data to incident and party
%aid_data%			:= SANCTN_Mari.proc_Midex_AID(filedate);

//Add DID and BDID fields to incident and party
%did_data%			:= parallel(SANCTN_Mari.proc_Midex_incident_DID(filedate)
														,SANCTN_Mari.proc_Midex_party_DID(filedate));
															
%build_keys%  := SANCTN_Mari.proc_build_keys(filedate);

%qa_samp%    := SANCTN_Mari.out_qa_Midex_samples;

SANCTN_Mari.Out_File_SANCTN_Mari_Stats_Population (SANCTN_Mari.files_SANCTN_common.incident_common
																									 ,SANCTN_Mari.files_SANCTN_common.incident_bip
																									 ,SANCTN_Mari.files_SANCTN_common.party_common
																									 ,SANCTN_Mari.files_SANCTN_common.party_bip																									 
																									 ,SANCTN_Mari.files_SANCTN_common.incident_text
																									 ,SANCTN_Mari.files_SANCTN_common.party_text
																									 ,SANCTN_Mari.files_SANCTN_common.incident_codes
																									 ,SANCTN_Mari.files_SANCTN_common.party_aka_dba
																									 ,filedate
																									 ,do_STRATA
																									 )

 sequential(
					 %spray_data%
					,%clean_data%
					,%map_common%
					,%aid_data%
					,%did_data%
					,%build_keys%
					,%qa_samp%
					,do_STRATA
					,Scrubs_SANCTN_NPKeys.fn_RunScrubs(filedate,'Harry.Gist@lexisnexis.com,Terri.Hardy-George@lexisnexis.com')
					);

ENDMACRO;

