IMPORT ut, Business_Header;

//*************************************************************************
// Translate Wither and Die Contacts to Common Business Header Contact Format
//*************************************************************************

Wither_init := wither_and_die.File_Wither_and_Die_In;

Business_Header.Layout_Business_Contact_Full Translate_Wither_to_BCF(Layout_Wither_and_Die_In L, INTEGER C) := TRANSFORM
SELF.bdid := 0;
self.vendor_id := if(l.VENDOR_ID != '', (trim(l.FILE_ID) + ',' + trim(l.VENDOR_ID))[1..34], 
			   if(l.VDI != '', (trim(l.FILE_ID) + ',' + trim(l.VDI))[1..34],
			   (trim(l.FILE_ID) + ',' + trim(l.cleaned_primary_name) + ',' + trim(l.cleaned_phone))[1..34]));
self.dt_first_seen := (unsigned4)l.dt_first_seen;
self.dt_last_seen := (unsigned4)l.dt_last_seen;
self.source := 'WT';
SELF.record_type := 'C';     // 'C' = Current, 'H' = Historical
SELF.company_title := '';

SELF.title 		:= CHOOSE(C, L.primary_name_title,  L.primary_name_title,  L.contact_name_title,  L.contact_name_title, 
						   L.primary_name_title,  L.primary_name_title,  L.contact_name_title,  L.contact_name_title);
SELF.fname 		:= CHOOSE(C, L.primary_name_first,  L.primary_name_first,  L.contact_name_first,  L.contact_name_first, 
						   L.primary_name_first,  L.primary_name_first,  L.contact_name_first,  L.contact_name_first);
SELF.mname 		:= CHOOSE(C, L.primary_name_middle, L.primary_name_middle, L.contact_name_middle, L.contact_name_middle, 
						   L.primary_name_middle, L.primary_name_middle, L.contact_name_middle, L.contact_name_middle);
SELF.lname 		:= CHOOSE(C, L.primary_name_last,   L.primary_name_last,   L.contact_name_last,   L.contact_name_last, 
						   L.primary_name_last,   L.primary_name_last,   L.contact_name_last,   L.contact_name_last);
SELF.name_suffix 	:= CHOOSE(C, L.primary_name_suffix, L.primary_name_suffix, L.contact_name_suffix, L.contact_name_suffix, 
						   L.primary_name_suffix, L.primary_name_suffix, L.contact_name_suffix, L.contact_name_suffix);
SELF.name_score 	:= CHOOSE(C, Business_Header.CleanName(L.primary_name_first,L.primary_name_middle,L.primary_name_last,L.primary_name_suffix)[142],
						   Business_Header.CleanName(L.primary_name_first,L.primary_name_middle,L.primary_name_last,L.primary_name_suffix)[142],
						   Business_Header.CleanName(L.contact_name_first,L.contact_name_middle,L.contact_name_last,L.contact_name_suffix)[142],
						   Business_Header.CleanName(L.contact_name_first,L.contact_name_middle,L.contact_name_last,L.contact_name_suffix)[142],
						   Business_Header.CleanName(L.primary_name_first,L.primary_name_middle,L.primary_name_last,L.primary_name_suffix)[142],
						   Business_Header.CleanName(L.primary_name_first,L.primary_name_middle,L.primary_name_last,L.primary_name_suffix)[142],
						   Business_Header.CleanName(L.contact_name_first,L.contact_name_middle,L.contact_name_last,L.contact_name_suffix)[142],
						   Business_Header.CleanName(L.contact_name_first,L.contact_name_middle,L.contact_name_last,L.contact_name_suffix)[142]);
SELF.phone := (UNSIGNED6)((UNSIGNED8)L.cleaned_phone);
SELF.prim_range 	:= L.bus_prim_range;
SELF.predir 		:= L.bus_predir;
SELF.prim_name 	:= L.bus_prim_name;
SELF.addr_suffix 	:= L.bus_addr_suffix;
SELF.postdir 		:= L.bus_postdir;
SELF.unit_desig 	:= L.bus_unit_desig;
SELF.sec_range 	:= L.bus_sec_range;
SELF.city 		:= L.bus_p_city_name;
SELF.state 		:= L.bus_st;
SELF.zip 			:= (UNSIGNED3)L.bus_zip;
SELF.zip4 		:= (UNSIGNED2)L.bus_zip4;
SELF.county		:= L.bus_fipscounty;
SELF.msa			:= L.bus_msa;
SELF.geo_lat		:= L.bus_geo_lat;
SELF.geo_long		:= L.bus_geo_long;

SELF.company_name 		:= CHOOSE(C, L.cleaned_primary_name, 	L.cleaned_primary_name, 	   L.cleaned_primary_name, 	L.cleaned_primary_name, 
							   L.cleaned_dba_name, 		L.cleaned_dba_name, 	   L.cleaned_dba_name, 		L.cleaned_dba_name); 
SELF.company_prim_range 	:= CHOOSE(C, L.bus_prim_range, 	L.mail_prim_range, 	   L.bus_prim_range, 	L.mail_prim_range, 
							   L.bus_prim_range, 	L.mail_prim_range, 	   L.bus_prim_range, 	L.mail_prim_range);
SELF.company_predir 	:= CHOOSE(C, L.bus_predir, 		L.mail_predir, 	   L.bus_predir, 		L.mail_predir, 
							   L.bus_predir, 		L.mail_predir, 	   L.bus_predir, 		L.mail_predir);
SELF.company_prim_name 	:= CHOOSE(C, L.bus_prim_name, 	L.mail_prim_name,      L.bus_prim_name, 	L.mail_prim_name, 
							   L.bus_prim_name, 	L.mail_prim_name,      L.bus_prim_name, 	L.mail_prim_name);
SELF.company_addr_suffix := CHOOSE(C, L.bus_addr_suffix, 	L.mail_addr_suffix,    L.bus_addr_suffix, 	L.mail_addr_suffix, 
							   L.bus_addr_suffix, 	L.mail_addr_suffix,    L.bus_addr_suffix, 	L.mail_addr_suffix);
SELF.company_postdir 	:= CHOOSE(C, L.bus_postdir, 		L.mail_postdir,        L.bus_postdir, 		L.mail_postdir, 
							   L.bus_postdir, 		L.mail_postdir,        L.bus_postdir, 		L.mail_postdir);
SELF.company_unit_desig 	:= CHOOSE(C, L.bus_unit_desig, 	L.mail_unit_desig,     L.bus_unit_desig, 	L.mail_unit_desig, 
							   L.bus_unit_desig, 	L.mail_unit_desig,     L.bus_unit_desig, 	L.mail_unit_desig);
SELF.company_sec_range 	:= CHOOSE(C, L.bus_sec_range, 	L.mail_sec_range,      L.bus_sec_range, 	L.mail_sec_range, 
							   L.bus_sec_range, 	L.mail_sec_range,      L.bus_sec_range, 	L.mail_sec_range);
SELF.company_city 		:= CHOOSE(C, L.bus_p_city_name, 	L.mail_p_city_name,    L.bus_p_city_name, 	L.mail_p_city_name, 
							   L.bus_p_city_name, 	L.mail_p_city_name,    L.bus_p_city_name, 	L.mail_p_city_name);
SELF.company_state 		:= CHOOSE(C, L.bus_st, 			L.mail_st, 		   L.bus_st, 			L.mail_st, 
							   L.bus_st, 			L.mail_st, 		   L.bus_st, 			L.mail_st);
SELF.company_zip 		:= CHOOSE(C, (UNSIGNED3)L.bus_zip, (UNSIGNED3)L.mail_zip, (UNSIGNED3)L.bus_zip, (UNSIGNED3)L.mail_zip, 
							   (UNSIGNED3)L.bus_zip, (UNSIGNED3)L.mail_zip, (UNSIGNED3)L.bus_zip, (UNSIGNED3)L.mail_zip);
SELF.company_zip4 		:= CHOOSE(C, (UNSIGNED2)L.bus_zip4,(UNSIGNED2)L.mail_zip4,(UNSIGNED2)L.bus_zip4,(UNSIGNED2)L.mail_zip4, 
							   (UNSIGNED2)L.bus_zip4,(UNSIGNED2)L.mail_zip4,(UNSIGNED2)L.bus_zip4,(UNSIGNED2)L.mail_zip4);
SELF.company_phone 		:= (UNSIGNED6)((UNSIGNED8)L.cleaned_phone);
SELF.email_address := '';
END;

Wither_Contacts := NORMALIZE(Wither_Init, 8, Translate_Wither_to_BCF(LEFT, COUNTER));


EXPORT Wither_and_Die_As_Business_Contact := Wither_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix), company_name != '', company_prim_name != '') : PERSIST('TEMP::Wither_Contacts_As_BC');