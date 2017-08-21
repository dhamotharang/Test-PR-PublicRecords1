import STD; 
EXPORT _ConstructTracebackFiles(string version_in, string iter_in) := Module
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
	shared combo:=version_in + '_' + iter_in;
	shared dotbase   := BIPV2_ProxID_mj6.In_DOT_Base;

  shared ds:=BIPV2_ProxID_mj6.Keys(dotbase,combo).MatchSample(Conf>=BIPV2_ProxID_mj6.Config.MatchThreshold);
  shared js:= project(ds, transform(rec_mj, self.version:=version_in; self.iternumber:=iter_in; self:=left));
  shared fpath:='~thor_data400::key::proxid_mj6::match_sample::shortform::_' + iter_in + '_' + version_in;// '_277_20160617';
  export k1:=output(js,,fpath,COMPRESSED,OVERWRITE);
	
	shared fff:='~thor_data400::key::bipv2_proxidMj6::proxMatchSample::super' + version_in;
	shared	b1:=if(STD.File.SuperFileExists(fff)=false,
			       STD.File.CreateSuperFile(fff));
	
  export k2:=STD.File.AddSuperFile(fff,fpath);
	
	
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
        unsigned4 change_date;
       END;
       
 shared rec1:=Record
       string20 version;
       string6 iternumber;
       unsigned6 proxid_before;
       unsigned6 proxid_after;
      end;

      //ds:=dataset('~temp::proxid::bipv2_proxid_mj6::changes_it20160617_275',rec,thor);
		shared	dsf:=dataset('~temp::proxid::bipv2_proxid_mj6::changes_it' + combo,rec,thor);
    shared  dsf1:=table(dsf,{proxid_before,proxid_after});
    shared  dsf2:=dedup(dsf1,proxid_before,proxid_after,all);
    shared  dsf3:=dsf2(proxid_before<>proxid_after);
    shared  dsf4:=project(dsf3,transform(rec1, self.version:=version_in; self.iternumber:=iter_in; self:=left));
			
		shared	pth:='~temp::proxid::bipv2_proxid::MJ6changes::shortform::it' + combo;
      //output(ds4,,'~temp::proxid::bipv2_proxid::MJ6changes::shortform::it20160617_275',compressed,overwrite);
		shared	fpath5:='~thor_data400::keep::bipv2_proxid::proxChangeMJ6::super' + version_in;
	export t1:=output(dsf4,,pth,compressed,overwrite);
	shared	b2:=if(STD.File.SuperFileExists(fpath5)=false,
			       STD.File.CreateSuperFile(fpath5));
	
  export t2:=STD.File.AddSuperFile(fpath5,pth);
	export outKeyFiles:=SEQUENTIAL(k1,b1,k2,t1,b2,t2);
end;