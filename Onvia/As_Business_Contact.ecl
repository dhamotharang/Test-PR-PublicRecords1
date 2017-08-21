#OPTION('multiplePersistInstances',FALSE);
IMPORT ut, Business_Header;

Onvia_base := onvia.Files.Thesample;

Business_Header.Layout_Business_Contact_Full Translate_Onvia_to_BCF(Onvia.layouts.TheSample  L) := 
TRANSFORM
	SELF.bdid					:= 0;
	self.company_source_group	:= '';
	self.vendor_id				:= (trim(l.zip) + trim(l.zip4) + trim(l.prim_name) + trim(l.Company))[1..34];
	self.dt_first_seen			:= 0;
	self.dt_last_seen			:= 0;
	self.source					:= 'OV';
	SELF.record_type			:= 'C';     // 'C' = Current, 'H' = Historical
	SELF.company_title			:= l.contact_title;
	SELF.title					:= l.title;
	SELF.fname					:= l.fname;
	SELF.mname					:= l.mname;
	SELF.lname					:= l.lname;
	SELF.name_suffix			:= l.name_suffix;
	SELF.name_score				:= Business_Header.CleanName(L.fname,L.mname,L.lname,L.name_suffix)[142];
	SELF.phone					:= (UNSIGNED6)((UNSIGNED8)stringlib.stringfilter(L.phone_number,'01234567889'));
	SELF.prim_range				:= L.prim_range;
	SELF.predir					:= L.predir;
	SELF.prim_name				:= L.prim_name;
	SELF.addr_suffix			:= L.addr_suffix;
	SELF.postdir				:= L.postdir;
	SELF.unit_desig				:= L.unit_desig;
	SELF.sec_range				:= L.sec_range;
	SELF.city					:= L.p_city_name;
	SELF.state					:= L.st;
	SELF.zip					:= (UNSIGNED3)L.zip;
	SELF.zip4					:= (UNSIGNED2)L.zip4;
	SELF.county					:= L.fips_county;
	SELF.msa					:= L.msa;
	SELF.geo_lat				:= L.geo_lat;
	SELF.geo_long				:= L.geo_long;
	SELF.company_name			:= l.Company; 
	SELF.company_prim_range		:= L.prim_range;
	SELF.company_predir			:= L.predir;
	SELF.company_prim_name		:= L.prim_name;
	SELF.company_addr_suffix	:= L.addr_suffix;
	SELF.company_postdir		:= L.postdir;
	SELF.company_unit_desig		:= L.unit_desig;
	SELF.company_sec_range		:= L.sec_range;
	SELF.company_city			:= L.p_city_name;
	SELF.company_state			:= L.st;
	SELF.company_zip			:= (UNSIGNED3)L.zip;
	SELF.company_zip4			:= (UNSIGNED2)L.zip4;
	SELF.company_phone			:= (UNSIGNED6)((UNSIGNED8)stringlib.stringfilter(L.phone_number,'01234567889'));
	SELF.email_address			:= l.contact_email;
END;

Onvia_Contacts := project(Onvia_base, Translate_Onvia_to_BCF(LEFT));


EXPORT As_Business_Contact := Onvia_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix), company_name != '', company_prim_name != '') : PERSIST('persist::Onvia::As_Business_Contact');