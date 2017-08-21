import NPPES,lib_keylib,lib_fileservices,ut,Header;

export	NPPES_as_header(dataset(NPPES.layouts.KeyBuild) pNPPES = dataset([],NPPES.layouts.KeyBuild), boolean pForHeaderBuild=false)
 :=
  function
	dNPPESasSource	:=	NPPES.NPPES_as_Source(pNPPES,pForHeaderBuild);

	Header.Layout_New_Records Translate_NPPES_to_Header(dNPPESasSource l) := transform
		self.did := 0;
		self.rid := 0;
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := '';
		//src will be populated from macro call
		self.dt_first_seen := if((integer)l.dt_vendor_first_reported=0,0,(unsigned3)(l.dt_vendor_first_reported[1..6]));
		self.dt_last_seen := if((integer)l.dt_vendor_last_reported=0,0,(unsigned3)(l.dt_vendor_last_reported[1..6]));
		self.dt_vendor_first_reported := if((integer)l.dt_vendor_first_reported=0,0,(unsigned3)(l.dt_vendor_first_reported[1..6]));
		self.dt_vendor_last_reported := if((integer)l.dt_vendor_last_reported=0,0,(unsigned3)(l.dt_vendor_last_reported[1..6]));
		self.dt_nonglb_last_seen := if((integer)l.dt_vendor_last_reported=0,0,(unsigned3)(l.dt_vendor_last_reported[1..6]));
		self.rec_type := '1';  //this is current address
		self.vendor_id := l.NPI;
		self.phone := l.cleanLocationPhone;
		self.ssn := '';
		self.dob := 0;
		self.title := l.clean_name_provider.title;
		self.fname := l.clean_name_provider.fname;
		self.lname := l.clean_name_provider.lname;
		self.mname := l.clean_name_provider.mname;
		self.name_suffix := l.clean_name_provider.name_suffix;
		self.prim_range := l.clean_location_address.prim_range;
		self.predir := l.clean_location_address.predir;
		self.prim_name := l.clean_location_address.prim_name;
		self.suffix := l.clean_location_address.addr_suffix;
		self.postdir := l.clean_location_address.postdir;
		self.unit_desig := l.clean_location_address.unit_desig;
		self.sec_range := l.clean_location_address.sec_range;
		self.city_name := l.clean_location_address.v_city_name;
		self.st := l.clean_location_address.st;
		self.zip := l.clean_location_address.zip;
		self.zip4 := l.clean_location_address.zip4;
		self.county := l.clean_location_address.fips_county;
		string3 msa_temp := l.clean_location_address.msa;
		self.cbsa := if(msa_temp!='',msa_temp + '0','');
		self.geo_blk := l.clean_location_address.geo_blk;
		self.tnt := '';
		self.valid_ssn := '';
		self.jflag1 := '';
		self.jflag2 := '';
		self.jflag3 := '';
		self.RawAID := l.RawAID_Location;
		 self := l;
	end;

	NPPES_to_header := project(dNPPESasSource,Translate_NPPES_to_Header(left));

	NPPES_non_blank := NPPES_to_header(prim_name <> '', zip<>'',
									   lname <> '',
					                   length(trim(fname)) > 1);

	NPPES_dedup := dedup(NPPES_non_blank,all);

    return NPPES_dedup;
  end;
