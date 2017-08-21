import header,business_header,mdr,_Validate,ut;

EXPORT as_headers := module

	dForeclosureAsSource	:=	Files.BASE;

	Layout_Foreclosure_Change := record
	  dForeclosureAsSource;
		string5     title := '';
		string20    fname := '';
		string20    mname := '';
		string20    lname := '';
		string5     name_suffix := '';	
		unsigned6 	did := 0;
	end;

	Layout_Foreclosure_Change 	norm_foreclosure(dForeclosureAsSource c, unsigned1 did_cnt) := TRANSFORM
		self.title 				:= choose(did_cnt,c.name1_prefix,c.name2_prefix,c.name3_prefix,c.name4_prefix);
		self.fname 				:= choose(did_cnt,c.name1_first,c.name2_first,c.name3_first,c.name4_first);
		self.mname 				:= choose(did_cnt,c.name1_middle,c.name2_middle,c.name3_middle,c.name4_middle);
		self.lname 				:= choose(did_cnt,c.name1_last,c.name2_last,c.name3_last,c.name4_last);
		self.name_suffix 	:= choose(did_cnt,c.name1_suffix,c.name2_suffix,c.name3_suffix,c.name4_suffix);
		self.did 					:= choose(did_cnt,(integer)c.name1_did,(integer)c.name2_did,(integer)c.name3_did,(integer)c.name4_did); 
		self := c;
	END;

	Foreclosure_rec := NORMALIZE(dForeclosureAsSource,4,norm_foreclosure(left,counter));

map_to_person_header(dataset(recordof(Foreclosure_rec)) in_ds) := function
	Header.Layout_New_Records 	Translate_Foreclosure_to_Header(Layout_Foreclosure_Change l, integer c) := transform
		self.did 											:= l.did;
		self.rid 											:= 0;
		self.pflag1 									:= '';
		self.pflag2 									:= '';
		self.pflag3 									:= '';
		self.dt_first_seen 						:= if((integer)l.filing_date=0,0,(unsigned3)(l.filing_date[1..6]));
		self.dt_last_seen 						:= if((integer)l.recording_date=0,0,(unsigned3)(l.recording_date[1..6]));
		self.dt_vendor_first_reported := if((integer)l.process_date=0,0,(unsigned3)(l.process_date[1..6]));
		self.dt_vendor_last_reported 	:= if((integer)l.process_date=0,0,(unsigned3)(l.process_date[1..6]));
		self.dt_nonglb_last_seen 			:= if((integer)l.recording_date=0,0,(unsigned3)(l.recording_date[1..6]));
		self.rec_type 								:= '2';
		self.vendor_id 								:= l.foreclosure_id;
		self.phone 										:= '';
		self.ssn 											:= '';
		self.dob 											:= 0;
		self.title 										:= l.title;
		self.fname 										:= l.fname;
		self.lname 										:= l.lname;
		self.mname 										:= l.mname;
		self.name_suffix 							:= l.name_suffix;
		self.prim_range 							:= choose(c, l.situs1_prim_range, l.situs2_prim_range);
		self.predir 									:= choose(c, l.situs1_predir, l.situs2_predir);
		self.prim_name 								:= choose(c, l.situs1_prim_name, l.situs2_prim_name);
		self.suffix 									:= choose(c, l.situs1_addr_suffix,l.situs2_addr_suffix);
		self.postdir 									:= choose(c, l.situs1_postdir, l.situs2_postdir);
		self.unit_desig 							:= choose(c, l.situs1_unit_desig, l.situs2_unit_desig);
		self.sec_range 								:= choose(c, l.situs1_sec_range, l.situs2_sec_range);
		self.city_name 								:= choose(c, l.situs1_v_city_name, l.situs2_v_city_name);
		self.st 											:= choose(c, l.situs1_st, l.situs2_st);
		self.zip 											:= choose(c, l.situs1_zip, l.situs2_zip);
		self.zip4 										:= choose(c, l.situs1_zip4, l.situs2_zip4);
		self.county 									:= choose(c, l.situs1_fipscounty, l.situs2_fipscounty);
		string3 msa_temp := choose(c,l.situs1_msa,l.situs2_msa);
		self.cbsa 										:= if(msa_temp!='',msa_temp + '0','');
		self.geo_blk 									:= choose(c, l.situs1_geo_blk, l.situs2_geo_blk);
		self.tnt 											:= '';
		self.valid_ssn 								:= '';
		self.jflag1 									:= '';
		self.jflag2 									:= '';
		self.jflag3 									:= '';
		self.src											:= IF(l.deed_category = 'U',MDR.sourceTools.src_foreclosures, MDR.sourceTools.src_Foreclosures_Delinquent);
		self := l;
	end;

	foreclosure_to_header := normalize(Foreclosure_rec, 2, Translate_Foreclosure_to_Header(left, counter));
	foreclosure_non_blank := foreclosure_to_header(prim_name <> '', zip<>'',lname <> '',length(trim(fname)) > 1);
	foreclosure_dedup 		:= dedup(foreclosure_non_blank,all);
	return foreclosure_dedup;
  end;

export person_header_foreclosure_recs := map_to_person_header(Foreclosure_rec(did>0));

END;
