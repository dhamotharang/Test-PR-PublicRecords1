import BIPV2_Files, BIPV2, MDR, BIPV2_LGID3,ut,bipv2_build,wk_ut,tools,std,BIPV2_Tools,mdr,SALTTOOLS22; 


//EXPORT Get_Key(string version_in) := module
EXPORT Get_Key := module
//shared keyLgid3ProxInit:='~key::bipv2_lgid3::init_super::lgid3prox' + version_in; //for PayloadInitLgid3ProxKey

shared rec_InitLgid3Prox:=record
		string20 version;
		unsigned6 proxid;
		unsigned6 lgid3;
		UNSIGNED8 RecPtr {virtual(fileposition)}
end;

shared dsInit:=dataset([],rec_InitLgid3Prox); 
//export PayloadInitLgid3ProxKey:=index(dsInit,{version,lgid3},{proxid},keyLgid3ProxInit);
export PayloadInitLgid3ProxKey:=index(dsInit,{version,lgid3},{proxid},'~key::bipv2_lgid3::init_super::lgid3prox::super');
//-------------------------------------------------------------------------------------

//shared keyMatchSamplelgid31lgid32Path:='~key::bipv2_lgid3::lgid3_changes::lgid31lgid32_MatchSample' + version_in; //for MatchSamplelgid31lgid32Key

shared 	rec_Match:=RECORD
		string20 version;
    string20 iternumber;
		integer2 conf;
		unsigned6 lgid31;
		unsigned6 lgid32;
		integer2 conf_prop;
		unsigned6 rcid1;
		unsigned6 rcid2;
		string34 left_sbfe_id;
		integer2 sbfe_id_score;
		string34 right_sbfe_id;
		integer2 lgid3ifhrchy_score;
		integer2 active_duns_number_score;
		integer2 company_name_score;
		integer2 duns_number_score;
		integer2 duns_number_concept_score;
		integer2 company_fein_score;
		integer2 company_charter_number_score;
		integer2 cnp_number_score;
		integer2 company_inc_state_score;
		integer2 cnp_btype_score;
		UNSIGNED8 RecPtr {virtual(fileposition)};
	 END;

shared dsMatch:=dataset([],rec_Match); 
//export MatchSamplelgid31lgid32Key:=index(dsMatch,{version,iterNumber,lgid31,lgid32,RecPtr},
//																							 {dsMatch},keyMatchSamplelgid31lgid32Path);
export MatchSamplelgid31lgid32Key:=index(dsMatch,{version,iterNumber,lgid31,lgid32,RecPtr},
												{dsMatch},'~key::bipv2_lgid3::lgid3_changes::lgid31lgid32_matchsample::super');																							 
																							 
//----------------------------------------------------------------------------------

//shared keyRcidLgid3Change:='~key::bipv2_lgid3::lgid3_changes::rcid_lgid3' + version_in; //for PayloadRcidLgid3Key

shared Change_rec:=RECORD
	string20 version;
	string20 iterNumber;
	unsigned6 lgid3_before;
	unsigned6 lgid3_after;
	unsigned6 seleid_before;
	unsigned6 seleid_after;
	UNSIGNED8 RecPtr {virtual(fileposition)};
end;	

shared dsChange:=dataset([],Change_rec);
//export PayloadRcidLgid3Key:=index(dsChange,{version,iternumber,lgid3_after,lgid3_before},
//																					 {seleid_before,seleid_after},
//		                                       keyRcidLgid3Change); 
export PayloadRcidLgid3Key:=index(dsChange,{version,iternumber,lgid3_after,lgid3_before},
																					 {seleid_before,seleid_after},
		                                       '~key::bipv2_lgid3::lgid3_changes::super');																					 
																					 
//----------------------------------------------------------------------------------

//shared matchKeyPath:='~key::BIPV2_PROXID::prox_match::match_score' + version_in;
shared rec_m:=RECORD
     string20 version;
     string6 iternumber;
     integer2 conf;
     unsigned6 proxid1;
     unsigned6 proxid2;
     integer2 conf_prop;
     unsigned6 rcid1;
     unsigned6 rcid2;
     integer2 attribute_conf;
     integer2 cnp_number_score;
     integer2 st_score;
     integer2 prim_range_derived_score;//---
     integer2 ebr_file_number_score;
     integer2 active_duns_number_score;
     integer2 hist_enterprise_number_score;
     integer2 hist_duns_number_score;
     integer2 hist_domestic_corp_key_score;
     integer2 foreign_corp_key_score;
     integer2 unk_corp_key_score;
     integer2 company_fein_score;
     integer2 company_phone_score;
     integer2 active_enterprise_number_score;
     integer2 active_domestic_corp_key_score;
     integer2 company_addr1_score;
     integer2 cnp_name_score;
     integer2 zip_score;
     integer2 company_csz_score;
     integer2 prim_name_derived_score;
     integer2 sec_range_score; 
     integer2 v_city_name_score;
     integer2 cnp_btype_score;//-----
     integer2 company_address_score;
		 UNSIGNED8 RecPtr {virtual(fileposition)};
    END;

shared dsPScore:=dataset([],rec_m);
//export PayloadProxMatchScoreKey:=index(dsPScore,{version,iternumber,proxid1,proxid2,RecPtr},{dsPScore},
//																				matchKeyPath); 
export PayloadProxMatchScoreKey:=index(dsPScore,{version,iternumber,proxid1,proxid2,RecPtr},{dsPScore},
																				'~key::bipv2_proxid::prox_match::match_score::super');					
//-----------------------------------------------------------------------------------

//shared matchMJ6KeyPath :='~key::BIPV2_PROXID::proxMj6_match::match_score'+ version_in;
shared rec_mj:=RECORD
		string20 version;
		string6 iternumber;
		integer2 conf;
		unsigned6 proxid1;
		unsigned6 proxid2;
		integer2 conf_prop;
		unsigned6 rcid1;
		unsigned6 rcid2;
		integer2 attribute_conf;
		integer2 cnp_name_score;
		integer2 cnp_number_score;
		integer2 prim_range_score; //-----------------
		integer2 prim_name_derived_score;
		integer2 st_score;
		integer2 zip_score;
		integer2 ebr_file_number_score;
		integer2 hist_duns_number_score;
		integer2 hist_domestic_corp_key_score;
		integer2 foreign_corp_key_score;
		integer2 unk_corp_key_score;
		integer2 company_phone_score;
		integer2 active_duns_number_score;
		integer2 active_domestic_corp_key_score;
		integer2 company_fein_score;
		integer2 active_enterprise_number_score;
		integer2 sec_range_score;
		integer2 v_city_name_score;
		integer2 hist_enterprise_number_score;
		integer2 company_csz_score;
		integer2 company_addr1_score;
		integer2 company_address_score;
		UNSIGNED8 RecPtr {virtual(fileposition)};
END;	

shared dsPScore1:=dataset([],rec_mj);
//export PayloadProxMj6MatchScoreKey := INDEX(dsPScore1,{version,iternumber,proxid1,proxid2,RecPtr},{dsPScore1},
//		                                    matchMJ6KeyPath);
export PayloadProxMj6MatchScoreKey := INDEX(dsPScore1,{version,iternumber,proxid1,proxid2,RecPtr},{dsPScore1},
		                                    '~key::bipv2_proxid::proxmj6_match::match_score::super');																				
																				
//--------------------------------------------------------------------------------

//shared KeyChangePath:='~key::BIPV2_PROXID::prox_changes::before_after' + version_in;
shared rec1:=Record
	string20 version;
	string6 iternumber;
	unsigned6 proxid_before;
	unsigned6 proxid_after;
	UNSIGNED8 RecPtr {virtual(fileposition)};
end;

shared ds:=dataset([],rec1);
//export PayloadProxChangeKey := INDEX(ds,{version,iternumber},{proxid_before,proxid_after},
//		                                    KeyChangePath);
export PayloadProxChangeKey := INDEX(ds,{version,iternumber},{proxid_before,proxid_after},
		                                    '~key::bipv2_proxid::prox_changes::super');
				
//---------------------------------------------------------------------------------

//shared KeyMJ6ChangePath:='~key::BIPV2_PROXID::proxMj6_changes::before_after'+version_in;	
shared ds1:=dataset([],rec1);			
//export PayloadProxMj6ChangeKey := INDEX(ds1,{version,iternumber},{proxid_before,proxid_after},
//		                                    KeyMJ6ChangePath);
export PayloadProxMj6ChangeKey := INDEX(ds1,{version,iternumber},{proxid_before,proxid_after},
		                                    '~key::bipv2_proxid::proxmj6_changes::super');																				
																				
//----------------------------------------------------------------------------------


end;