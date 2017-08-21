IMPORT PRTE2_FCC, FCC, Data_Services;

EXPORT Files := MODULE

	EXPORT FCC_in	:= DATASET(Constants.IN_PREFIX + 'fcc::base_in', Layouts.FCC_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	
	EXPORT FCC_base_ext	:= DATASET(Constants.BASE_PREFIX + 'fcc', Layouts.FCC_Base_ext, THOR);
	
	EXPORT FCC_base_BIP	:= PROJECT(FCC_base_ext, FCC.Layout_FCC_base_bip);
	
	EXPORT FCC_base			:= PROJECT(FCC_base_ext, FCC.Layout_FCC_base);
	
	//Autokey file
	fcc.Layout_Payload forAutokey(fcc.Layout_FCC_base L, integer cnt) := TRANSFORM
		SELF.bdid := choose(cnt,l.licensee_bdid,l.dba_bdid,l.firm_bdid);
		SELF.did := choose(cnt,l.attention_did,l.attention_did,0);
		SELF.company := choose(cnt,l.clean_licensees_name,l.clean_dba_name,l.clean_firm_name);
		SELF.name.name_first := choose(cnt,l.attention_fname,l.attention_fname,'');
		SELF.name.name_middle := choose(cnt,l.attention_mname,l.attention_mname,'');
		SELF.name.name_last := choose(cnt,l.attention_lname,l.attention_lname,'');
		SELF.name.name_suffix := choose(cnt,l.attention_name_suffix,l.attention_name_suffix,'');
		SELF.addr.prim_range := choose(cnt,l.prim_range,l.prim_range,l.firm.prim_range);
		SELF.addr.predir := choose(cnt,l.predir,l.predir,l.firm.predir);
		SELF.addr.prim_name := choose(cnt,l.prim_name,l.prim_name,l.firm.prim_name);
		SELF.addr.addr_suffix := choose(cnt,l.addr_suffix,l.addr_suffix,l.firm.addr_suffix);
		SELF.addr.postdir := choose(cnt,l.postdir,l.postdir,l.firm.postdir);
		SELF.addr.unit_desig := choose(cnt,l.unit_desig,l.unit_desig,l.firm.unit_desig);
		SELF.addr.sec_range := choose(cnt,l.sec_range,l.sec_range,l.firm.sec_range);
		SELF.addr.p_city_name := choose(cnt,l.p_city_name,l.p_city_name,l.firm.p_city_name);
		SELF.addr.v_city_name := choose(cnt,l.v_city_name,l.v_city_name,l.firm.v_city_name);
		SELF.addr.st := choose(cnt,l.st,l.st,l.firm.st);
		SELF.addr.zip5 := choose(cnt,l.zip5,l.zip5,l.firm.zip5);
		SELF.addr.zip4 := choose(cnt,l.zip4,l.zip4,l.firm.zip4);
		SELF.addr.fips_state := choose(cnt,l.fips_state,l.fips_state,l.firm.fips_state);
		SELF.addr.fips_county := choose(cnt,l.fips_county,l.fips_county,l.firm.fips_county);
		SELF.addr.addr_rec_type := choose(cnt,l.addr_rec_type,l.addr_rec_type,l.firm.addr_rec_type);
		SELF.phone.phone10 := stringlib.stringfilter(choose(cnt,l.licensees_phone,l.licensees_phone,l.contact_firms_phone_number),'0123456789');
		SELF := l;
	END;

	EXPORT AK_search_file := normalize(FCC_base,3,forAutokey(left,counter));

END;