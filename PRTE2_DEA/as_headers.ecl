import header,business_header,mdr,_Validate,ut;

EXPORT as_headers := module
IMPORT DEA;

	EXPORT DEA_as_Header(dataset(dea.Layout_DEA_OUT_baseV2) pDEA = Files.File_DEAv2((unsigned6)DID!=0)) := FUNCTION
	  Header.Layout_New_Records map_to_person_header(files.File_DEAv2 le) := transform
		self.src                      	:= MDR.sourceTools.src_DEA;
		self.dt_first_seen 				:= if((integer)le.date_first_reported=0,0,(unsigned3)(le.date_first_reported[1..6]));
		self.dt_last_seen 				:= if((integer)le.date_last_reported=0,0,(unsigned3)(le.date_last_reported[1..6]));
		self.dt_vendor_first_reported 	:= if((integer)le.date_first_reported=0,0,(unsigned3)(le.date_first_reported[1..6]));
		self.dt_vendor_last_reported 	:= if((integer)le.date_last_reported=0,0,(unsigned3)(le.date_last_reported[1..6]));
		self.dt_nonglb_last_seen := if((integer)le.date_last_reported=0,0,(unsigned3)(le.date_last_reported[1..6]));
		self.did := (integer)le.did;//0;
		self.rid := 0;
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := '';
		self.rec_type := '2';
		self.vendor_id := le.Dea_Registration_Number;
		self.phone := '';
		self.ssn := '';
		self.dob := 0;
		self.title := le.title;
		self.fname := le.fname;
		self.lname := le.lname;
		self.mname := le.mname;
		self.name_suffix := le.name_suffix;
		self.prim_range := le.prim_range;
		self.predir := le.predir;
		self.prim_name := le.prim_name;
		self.suffix := le.addr_suffix;
		self.postdir := le.postdir;
		self.unit_desig := le.unit_desig;
		self.sec_range := le.sec_range;
		self.city_name := le.v_city_name;
		self.st := le.st;
		self.zip := le.zip;
		self.zip4 := le.zip4;
		self.county := le.county[3..5];
		string3 msa_temp := le.msa;
		self.cbsa := if(msa_temp!='',msa_temp + '0','');
		self.geo_blk := le.geo_blk;
		self.tnt := '';
		self.valid_ssn := '';
		self.jflag1 := '';
		self.jflag2 := '';
		self.jflag3 := '';
		self := le;
	  end;
	  DEA_to_header := project(pDEA ,map_to_person_header(left));
	  DEA_non_blank := DEA_to_header(prim_name <> '', zip<>'',
						lname <> '',
						length(trim(fname)) > 1);
	RETURN  dedup(DEA_non_blank,all);
END;

	EXPORT map_to_old_business_header := dea.fDEA_As_Business_Header(Files.File_DEAv2)(bdid>0);

	EXPORT map_to_old_business_contacts := dea.fDEA_As_Business_Contact(Files.File_DEAv2)(fname<>'' and lname<>'');

	EXPORT map_to_new_business_header  := dea.fDEA_As_Business_Linking(Files.File_DEAv2);

END;






