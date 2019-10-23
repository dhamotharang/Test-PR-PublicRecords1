import STD; 
EXPORT _TraceBackKeys(string pversion) := module


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
    END;
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
END;	
shared ppath:='~thor_data400::key::BIPV2_ProxID::proxMatchSample::super' + pversion;
shared matchKeyPath:='~key::BIPV2_ProxID::prox_match::match_score' + pversion;
shared dsPScore:=dataset(ppath,{rec_m,UNSIGNED8 RecPtr {virtual(fileposition)}}, FLAT);
export PayloadProxMatchScoreKey := INDEX(dsPScore,{version,iternumber,proxid1,proxid2,RecPtr},{dsPScore},
		                                    matchKeyPath); 
//If the above has the skew issue, use the following:
/* shared dsPScoreA:=sort(dsPScore, version,iternumber,proxid1,proxid2,RecPtr,conf,
   											conf_prop,rcid1,rcid2,attribute_conf,
   											cnp_number_score, st_score,prim_range_derived_score,
   											ebr_file_number_score,active_duns_number_score,
   											hist_enterprise_number_score,hist_duns_number_score,
   											hist_domestic_corp_key_score,foreign_corp_key_score,
   											unk_corp_key_score,company_fein_score,company_phone_score,
   											active_enterprise_number_score,active_domestic_corp_key_score,
   											company_addr1_score,cnp_name_score,zip_score,company_csz_score,
   											prim_name_derived_score,sec_range_score,v_city_name_score,
   											cnp_btype_score,company_address_score,skew(1.0));
   export PayloadProxMatchScoreKey := INDEX(dsPScoreA,{version,iternumber,proxid1,proxid2,RecPtr},{dsPScoreA},
   		                                    '~key::BIPV2_ProxID::prox_match::match_score');  
*/																
export BldProxMatchScoreKey := BUILDINDEX(PayloadProxMatchScoreKey,OVERWRITE);
//-----------------------------------------------------------------------------------------------------------------------
shared ppath1:='~~thor_data400::key::BIPV2_ProxIDMj6::proxMatchSample::super' + pversion;
shared dsPScore1:=dataset(ppath1,{rec_mj,UNSIGNED8 RecPtr {virtual(fileposition)}}, FLAT);
shared matchMJ6KeyPath :='~key::BIPV2_ProxID::proxMj6_match::match_score'+ pversion;
export PayloadProxMj6MatchScoreKey := INDEX(dsPScore1,{version,iternumber,proxid1,proxid2,RecPtr},{dsPScore1},
		                                    matchMJ6KeyPath);  
//If the above has the skew issue, use the following:																				
/* shared dsPScore1A:=sort(dsPScore1,version,iternumber,proxid1,proxid2,RecPtr,conf,
      											conf_prop,rcid1,rcid2,attribute_conf, 
   												cnp_name_score,cnp_number_score,prim_range_score,prim_name_derived_score,
   											 st_score,zip_score,ebr_file_number_score,hist_duns_number_score,
   											 hist_domestic_corp_key_score,foreign_corp_key_score,unk_corp_key_score,
   											 company_phone_score,active_duns_number_score,active_domestic_corp_key_score,
   											 company_fein_score,active_enterprise_number_score,sec_range_score,
   											 v_city_name_score,hist_enterprise_number_score,company_csz_score,
   											 company_addr1_score,company_address_score,skew(1.0));																				
   export PayloadProxMj6MatchScoreKey := INDEX(dsPScore1A,{version,iternumber,proxid1,proxid2,RecPtr},{dsPScore1A},
   		                                    '~key::BIPV2_ProxID::proxMj6_match::match_score');																													
*/
export BldProxMj6MatchScoreKey := BUILDINDEX(PayloadProxMj6MatchScoreKey,OVERWRITE);
//----------------------------------------------------------------------------------------------------------------------
shared rec1:=Record
	string20 version;
	string6 iternumber;
	unsigned6 proxid_before;
	unsigned6 proxid_after;
end;
			
shared fpath:='~thor_data400::keep::BIPV2_ProxID::proxChange::super' + pversion;
shared ds:=dataset(fpath,{rec1,UNSIGNED8 RecPtr {virtual(fileposition)}}, FLAT);
shared KeyChangePath:='~key::BIPV2_ProxID::prox_changes::before_after' + pversion;
export PayloadProxChangeKey := INDEX(ds,{version,iternumber},{proxid_before,proxid_after},
		                                    KeyChangePath);  
//If the above has the skew issue, use the following:
/* shared dsA:=sort(ds,version, iternumber, proxid_before, proxid_after,skew(1.0));																				
   export PayloadProxChangeKey := INDEX(dsA,{version,iternumber},{proxid_before,proxid_after},
   		                                    '~key::BIPV2_ProxID::prox_changes::before_after');																				
*/																			
export BldProxChangeKey := BUILDINDEX(PayloadProxChangeKey,OVERWRITE);

shared fpath1:='~thor_data400::keep::BIPV2_ProxID::proxChangeMJ6::super'+ pversion;
shared ds1:=dataset(fpath1,{rec1,UNSIGNED8 RecPtr {virtual(fileposition)}}, FLAT);
shared KeyMJ6ChangePath:='~key::BIPV2_ProxID::proxMj6_changes::before_after'+pversion;
export PayloadProxMj6ChangeKey := INDEX(ds1,{version,iternumber},{proxid_before,proxid_after},
		                                    KeyMJ6ChangePath);  
//If the above has the skew issue, use the following:
/* shared ds1A:=sort(ds1,version, iternumber, proxid_before, proxid_after,skew(1.0));		
   export PayloadProxMj6ChangeKey := INDEX(ds1A,{version,iternumber},{proxid_before,proxid_after},
   		                                    '~key::BIPV2_ProxID::proxMj6_changes::before_after');  
*/
export BldProxMj6ChangeKey := BUILDINDEX(PayloadProxMj6ChangeKey,OVERWRITE);

export addToSuper :=SEQUENTIAL(
 STD.File.StartSuperFileTransaction(),
 STD.File.AddSuperFile('~key::BIPV2_ProxID::prox_changes::super',KeyChangePath),
 STD.File.AddSuperFile('~key::BIPV2_ProxID::proxmj6_changes::super',KeyMJ6ChangePath),
 STD.File.AddSuperFile('~key::BIPV2_ProxID::prox_match::match_score::super',matchKeyPath),
 STD.File.AddSuperFile('~key::BIPV2_ProxID::proxmj6_match::match_score::super',matchMJ6KeyPath),
 STD.File.FinishSuperFileTransaction()
);

export removeFromSuper :=SEQUENTIAL(
 STD.File.StartSuperFileTransaction(),
 if(STD.File.FileExists(KeyChangePath   ) ,STD.File.removeSuperFile('~key::BIPV2_ProxID::prox_changes::super'              ,KeyChangePath    )),
 if(STD.File.FileExists(KeyMJ6ChangePath) ,STD.File.removeSuperFile('~key::BIPV2_ProxID::proxmj6_changes::super'           ,KeyMJ6ChangePath )),
 if(STD.File.FileExists(matchKeyPath    ) ,STD.File.removeSuperFile('~key::BIPV2_ProxID::prox_match::match_score::super'   ,matchKeyPath     )),
 if(STD.File.FileExists(matchMJ6KeyPath ) ,STD.File.removeSuperFile('~key::BIPV2_ProxID::proxmj6_match::match_score::super',matchMJ6KeyPath  )),
 STD.File.FinishSuperFileTransaction()
);


export out:=sequential(removeFromSuper,BldProxChangeKey,BldProxMj6ChangeKey, BldProxMatchScoreKey,BldProxMj6MatchScoreKey, addToSuper);
end;