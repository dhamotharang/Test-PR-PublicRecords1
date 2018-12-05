import BIPV2_Files,STD;
l_base    := BIPV2_Files.files_lgid3.Layout_LGID3;
export _Lgid3Changes(string iter_in, string version_in,dataset(l_base) ih):=module
	rr:=RECORD
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
	 
rec:=RECORD
		unsigned6 rcid;
		unsigned6 lgid3_before;
		unsigned6 lgid3_after;
		unsigned6 seleid_before;
		unsigned6 seleid_after;
		unsigned6 orgid_before;
		unsigned6 orgid_after;
		unsigned6 ultid_before;
		unsigned6 ultid_after;
		unsigned4 change_date;
END;
Change_rec:=RECORD
	string20 version;
	string20 iterNumber;
	unsigned6 lgid3_before;
	unsigned6 lgid3_after;
	unsigned6 seleid_before;
	unsigned6 seleid_after;
end;	
		//string34 sbfe_id;
combo:=iter_in + '_' + version_in;	 
		//ds:=BIPV2_LGID3.matches(ih).IdChanges(lgid3_before<>lgid3_after or seleid_before<>seleid_after);		
		ds:=dataset('~temp::lgid3::BIPV2_LGID3::changes_it' + combo,BIPV2_LGID3.MatchHistory.id_shift_r,thor);
		ds1:=table(ds,{lgid3_before,lgid3_after,seleid_before, seleid_after});
		ds2:=dedup(ds1,lgid3_before,lgid3_after,seleid_before, seleid_after,all);
		ds3:=ds2(lgid3_before<>lgid3_after);
		ds4:=project(ds3,transform(Change_rec, self.version:=version_in; self.iternumber:=iter_in; self:=left));
		fpath:='~thor_data400::BIPV2_LGID3::lgid3_changes::iter::' + '_'+ iter_in + '_' + version_in;
		act1:=output(ds4,,fpath,COMPRESSED,OVERWRITE);
		
		superChange:='~thor_data400::BIPV2_LGID3::lgid3_changes::super' + version_in;
		act2:=STD.File.AddSuperFile(superChange,fpath);
		
		ds2f:=BIPV2_LGID3.Keys(ih).MatchSample(Conf>=BIPV2_LGID3.Config.MatchThreshold);
		js2:=project(ds2f, transform(rr, self.iterNumber :=iter_in; self.version:=version_in; self :=left));
		kpath:='~thor_data400::BIPV2_LGID3::lgid3_match_sample_debug::iter::_' + iter_in + '_' + version_in;
		act3:=output(js2,,kpath,COMPRESSED,OVERWRITE);
		
		superMatch:='~thor_data400::BIPV2_LGID3::lgid3_match_sample_debug::super' + version_in;
		act4:=STD.File.AddSuperFile(superMatch,kpath);
		
		export out:=SEQUENTIAL(act1,act2,act3,act4);
	end;
