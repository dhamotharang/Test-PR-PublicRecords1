import BIPV2_Files,STD,BIPV2; 
l_base    := BIPV2_Files.files_lgid3.Layout_LGID3;
l_common  := BIPV2.CommonBase.Layout;
EXPORT _ManageLgid3Indexes(dataset(l_base) beforeRestoreDS , dataset(l_common) afterRestoreDS, string version_in):=module
shared Change_rec:=RECORD
	string20 version;
	string20 iterNumber;
	unsigned6 lgid3_before;
	unsigned6 lgid3_after;
	unsigned6 seleid_before;
	unsigned6 seleid_after;
end;	
		
		shared ds_c:=join(beforeRestoreDS,afterRestoreDS,left.rcid=right.rcid, transform(Change_rec,
																												self.version:=version_in;
																												self.lgid3_before :=left.lgid3;
																												self.lgid3_after  :=right.lgid3;
																												self.seleid_before:=left.seleid;
																												self.seleid_after :=right.seleid;
																												self.iterNumber   :='P'+version_in), hash);
		shared ds_r:= ds_c(lgid3_before <> lgid3_after or seleid_before <> seleid_after);
		shared ds_r1:=dedup(ds_r,version,iterNumber,lgid3_before,lgid3_after,seleid_before,seleid_after,all);
		
		shared ppPath:='~thor_data400::BIPV2_LGID3::lgid3_changes::P' + version_in;
		shared act_post:=output(ds_r1,,ppPath,COMPRESSED,OVERWRITE);
		shared superChange:='~thor_data400::BIPV2_LGID3::lgid3_changes::super' + version_in;
		shared act2:=STD.File.AddSuperFile(superChange,ppPath);
		
		shared ds:=dataset(superChange,{Change_rec,UNSIGNED8 RecPtr {virtual(fileposition)}}, FLAT);
		
		shared superInit:='~thor_data400::BIPV2_LGID3::init_super::lgid3prox' + version_in;
		shared ds_init_lgid3prox:=dataset(superInit,
		             {string20 version, unsigned6 proxid,unsigned6 lgid3,UNSIGNED8 RecPtr {virtual(fileposition)}}, FLAT);
		shared keyLgid3ProxInit:='~key::BIPV2_LGID3::init_super::lgid3prox' + version_in;
		export PayloadInitLgid3ProxKey := INDEX(ds_init_lgid3prox,{version,lgid3},{proxid},
		                                    keyLgid3ProxInit);
		
		export BldInitLgid3ProxKey := BUILDINDEX(PayloadInitLgid3ProxKey,OVERWRITE);
		
		shared keyRcidLgid3Change:='~key::BIPV2_LGID3::lgid3_changes::rcid_lgid3' + version_in;
		export PayloadRcidLgid3Key := INDEX(ds,{version,iternumber,lgid3_after,lgid3_before},{seleid_before,seleid_after},
		                                    keyRcidLgid3Change);  
		export BldRcidLgid3Key := BUILDINDEX(PayloadRcidLgid3Key,OVERWRITE);
/*  		ds_iter:=dataset('~thor_data400::bipv2_proxid_mj6::final_iter',{string ss},thor);//borrow value from mj6
          siter:=ds_iter[1].ss;
   			 iter1:=(integer)siter + 1;
*/
	shared rr:=RECORD
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
	 END;
	 
		shared superMatch:='~thor_data400::BIPV2_LGID3::lgid3_match_sample_debug::super' + version_in;
		shared ds2:=dataset(superMatch,
				 {rr,UNSIGNED8 RecPtr {virtual(fileposition)}}, FLAT); //OVERWRITE;  Maybe also need a sort here.....
		shared keyMatchSamplelgid31lgid32Path:='~key::BIPV2_LGID3::lgid3_changes::lgid31lgid32_MatchSample' + version_in;
		export MatchSamplelgid31lgid32Key := INDEX(ds2,{version,iterNumber,lgid31,lgid32,RecPtr},
																							 {ds2},keyMatchSamplelgid31lgid32Path);
		export BldLgid31Lgid32Key := BUILDINDEX(MatchSamplelgid31lgid32Key,OVERWRITE);
		
export addToSuper :=SEQUENTIAL(
 STD.File.StartSuperFileTransaction(),
 STD.File.AddSuperFile('~key::BIPV2_LGID3::lgid3_changes::super',keyRcidLgid3Change),
 STD.File.AddSuperFile('~key::BIPV2_LGID3::lgid3_changes::lgid31lgid32_matchsample::super',keyMatchSamplelgid31lgid32Path),
 STD.File.AddSuperFile('~key::BIPV2_LGID3::init_super::lgid3prox::super',keyLgid3ProxInit),
 STD.File.FinishSuperFileTransaction()
);
		export out:=sequential(act_post,act2,BldRcidLgid3Key,BldLgid31Lgid32Key,BldInitLgid3ProxKey,addToSuper);
end;
