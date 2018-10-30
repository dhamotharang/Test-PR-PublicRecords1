import STD;
EXPORT _ConstructTracebackFiles(string version_in, string iter_in) := Module
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
	shared combo:=version_in + '_' + iter_in;
	shared dotbase   := BIPV2_ProxID.In_DOT_Base;
  shared ds:=BIPV2_ProxID.Keys(dotbase,combo).MatchSample(Conf>=BIPV2_ProxID.Config.MatchThreshold);
  shared js:= project(ds, transform(rec_m, self.version:=version_in; self.iternumber:=iter_in; self:=left));
  shared fpath:='~thor_data400::key::proxid::match_sample::shortform::_' + iter_in + '_' + version_in;// '_279_20160617';
  export k1:=output(js,,fpath,COMPRESSED,OVERWRITE);
	
	shared MatchSampleSuperPath:='~thor_data400::key::BIPV2_ProxID::proxMatchSample::super'+version_in;
	
	shared	b0:=if(STD.File.SuperFileExists(MatchSampleSuperPath)=false,
			       STD.File.CreateSuperFile(MatchSampleSuperPath));
						 
  export k2:=STD.File.AddSuperFile(MatchSampleSuperPath,fpath);
	
	
	shared rec:=RECORD
  unsigned6 rcid;
  unsigned6 proxid_before;
  unsigned6 proxid_after;
  unsigned6 lgid3_before;
  unsigned6 lgid3_after;
  unsigned6 orgid_before;
  unsigned6 orgid_after;
  unsigned6 ultid_before;
  unsigned6 ultid_after;
  unsigned6 change_date;
 END;

       
 shared rec1:=Record
       string20 version;
       string6 iternumber;
       unsigned6 proxid_before;
       unsigned6 proxid_after;
      end;
  
	
      //ds:=dataset('~temp::proxid::BIPV2_ProxID::changes_it20160617_273',rec,thor);
	shared		dsf:=dataset('~temp::proxid::BIPV2_ProxID::changes_it' + combo,rec,thor);
  shared    dsf1:=table(dsf,{proxid_before,proxid_after});
  shared    dsf2:=dedup(dsf1,proxid_before,proxid_after,all);
  shared    dsf3:=dsf2(proxid_before<>proxid_after);
  shared    dsf4:=project(dsf3,transform(rec1, self.version:=version_in; self.iternumber:=iter_in; self:=left));
			
	shared		pth:='~temp::proxid::BIPV2_ProxID::changes::shortform::it' + combo;
      //output(dsf4,,'~temp::proxid::BIPV2_ProxID::changes::shortform::it20160617_273',compressed,overwrite);
	shared fpath5:='~thor_data400::keep::BIPV2_ProxID::proxChange::super' + version_in;
	export t1:=output(dsf4,,pth,compressed,overwrite);
	
	shared	b1:=if(STD.File.SuperFileExists(fpath5)=false,
			       STD.File.CreateSuperFile(fpath5));
						 
  export t2:=STD.File.AddSuperFile(fpath5,pth);
	export outKeyFiles:=SEQUENTIAL(k1,b0,k2,t1,b1,t2);
end;