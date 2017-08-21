import DEA,lib_keylib,lib_fileservices,ut,Header;

export	DEA_as_Header(dataset(DEA.layout_DEA_Out_baseV2) pDEA = dataset([],DEA.layout_DEA_Out_baseV2), boolean pForHeaderBuild=false)
 :=
  function
	dDEAasSource	:=	if(pForHeaderBuild,header.Files_SeqdSrc().DEA,DEA.DEA_as_Source(pDEA,pForHeaderBuild));

	Header.Layout_New_Records Translate_DEA_to_Header(dDEAasSource l) := transform
		self.did := 0;
		self.rid := 0;
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := '';
		self.dt_first_seen := if((integer)l.date_first_reported=0,0,(unsigned3)(l.date_first_reported[1..6]));
		self.dt_last_seen := if((integer)l.date_last_reported=0,0,(unsigned3)(l.date_last_reported[1..6]));
		self.dt_vendor_first_reported := if((integer)l.date_first_reported=0,0,(unsigned3)(l.date_first_reported[1..6]));
		self.dt_vendor_last_reported := if((integer)l.date_last_reported=0,0,(unsigned3)(l.date_last_reported[1..6]));
		self.dt_nonglb_last_seen := if((integer)l.date_last_reported=0,0,(unsigned3)(l.date_last_reported[1..6]));
		self.rec_type := '2';
		self.vendor_id := l.Dea_Registration_Number;
		self.phone := '';
		self.ssn := '';
		self.dob := 0;
		self.title := l.title;
		self.fname := l.fname;
		self.lname := l.lname;
		self.mname := l.mname;
		self.name_suffix := l.name_suffix;
		self.prim_range := l.prim_range;
		self.predir := l.predir;
		self.prim_name := l.prim_name;
		self.suffix := l.addr_suffix;
		self.postdir := l.postdir;
		self.unit_desig := l.unit_desig;
		self.sec_range := l.sec_range;
		self.city_name := l.v_city_name;
		self.st := l.st;
		self.zip := l.zip;
		self.zip4 := l.zip4;
		self.county := l.county[3..5];
		string3 msa_temp := l.msa;
		self.cbsa := if(msa_temp!='',msa_temp + '0','');
		self.geo_blk := l.geo_blk;
		self.tnt := '';
		self.valid_ssn := '';
		self.jflag1 := '';
		self.jflag2 := '';
		self.jflag3 := '';
		 self := l;
	end;

	DEA_to_header := project(dDEAasSource,Translate_DEA_to_Header(left));

	DEA_non_blank := DEA_to_header(prim_name <> '', zip<>'',
					lname <> '',
					length(trim(fname)) > 1);

	DEA_dedup := dedup(DEA_non_blank,all);

    return DEA_dedup;
  end
 ;
