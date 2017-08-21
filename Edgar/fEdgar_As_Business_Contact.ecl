IMPORT ut, Business_Header,mdr;

export fEdgar_As_Business_Contact(dataset(Layout_Edgar_Contact_Base) pEdgarBase) :=
function

	//*************************************************************************
	// Translate Contacts from Edgar Contact Records to Business Contact Format
	//*************************************************************************

	Business_Header.Layout_Business_Contact_Full_New Translate_Edgar_to_BCF(Layout_Edgar_Contact_Base L) := TRANSFORM
	SELF.company_title := L.position;
	SELF.name_score := Business_Header.CleanName(L.fname,L.mname,L.lname,L.name_suffix)[142];
	SELF.vl_id := L.accession;
	SELF.vendor_id := L.accession;
	SELF.prim_range := L.bus_prim_range;
	SELF.predir := L.bus_predir;
	SELF.prim_name := L.bus_prim_name;
	SELF.addr_suffix := L.bus_addr_suffix;
	SELF.postdir := L.bus_postdir;
	SELF.unit_desig := L.bus_unit_desig;
	SELF.sec_range := L.bus_sec_range;
	SELF.city := L.bus_v_city_name;
	SELF.state := L.bus_st;
	SELF.zip := (UNSIGNED3)L.bus_zip;
	SELF.zip4 := (UNSIGNED2)L.bus_zip4;
	SELF.county := L.bus_county[3..5];
	SELF.msa := L.bus_msa;
	SELF.geo_lat := L.bus_geo_lat;
	SELF.geo_long := L.bus_geo_long;
	SELF.phone := (UNSIGNED6)((UNSIGNED8)L.bus_phone10);
	SELF.source := MDR.sourceTools.src_Edgar;
	SELF.record_type := 'C';
	SELF.company_name := L.companyName;
	SELF.company_source_group := L.cikcode;
	SELF.company_prim_range := L.bus_prim_range;
	SELF.company_predir := L.bus_predir;
	SELF.company_prim_name := L.bus_prim_name;
	SELF.company_addr_suffix := L.bus_addr_suffix;
	SELF.company_postdir := L.bus_postdir;
	SELF.company_unit_desig := L.bus_unit_desig;
	SELF.company_sec_range := L.bus_sec_range;
	SELF.company_city := L.bus_v_city_name;
	SELF.company_state := L.bus_st;
	SELF.company_zip := (UNSIGNED3)L.bus_zip;
	SELF.company_zip4 := (UNSIGNED2)L.bus_zip4;
	SELF.company_phone := (UNSIGNED6)((UNSIGNED8)L.bus_phone10);
	SELF.company_fein := (unsigned4)L.Companytaxid;
	SELF.dt_first_seen := (unsigned4)Version_Edgar_Company;
	SELF.dt_last_seen := (unsigned4)Version_Edgar_Company;
	SELF.email_address := '';
	SELF := L;
	END;

	Edgar_Contacts := PROJECT(pEdgarBase(lname <> ''), Translate_Edgar_to_BCF(LEFT));

	return Edgar_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

end;
