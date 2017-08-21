IMPORT ut, Business_Header,mdr;

export fGong_As_Business_Contact(dataset(Layout_bscurrent_raw) pFullGongFile) :=
function

//*************************************************************************
// Translate Contacts from Gong Business Records to Business Contact Format
//*************************************************************************


Gong_Business := pFullGongFile(listing_type_bus<>'', publish_code IN ['P','U']);

Business_Header.Layout_Business_Contact_Full_New Translate_Gong_to_BCF(Layout_bscurrent_raw L) := TRANSFORM
SELF.company_title := '';
SELF.title := L.name_prefix;
SELF.fname := L.name_first;
SELF.mname := L.name_middle;
SELF.lname := L.name_last;
SELF.name_suffix := L.name_suffix;
SELF.name_score := Business_Header.CleanName(L.name_first,L.name_middle,L.name_last,L.name_suffix)[142];
SELF.vl_id := (STRING34)(L.bell_id + L.group_id);
SELF.vendor_id := (QSTRING34)((STRING34)(L.bell_id + L.group_id));
SELF.zip := (UNSIGNED3)L.z5;
SELF.zip4 := (UNSIGNED2)L.z4;
SELF.phone := (UNSIGNED6)((UNSIGNED8)L.phone10);
SELF.addr_suffix := L.suffix;
SELF.city := L.v_city_name;
SELF.state := L.st;
SELF.county := L.county_code[3..5];
SELF.source := IF(L.listing_type_gov <> ''
                   OR ut.GovName(ut.CleanCompany(L.listed_name))
									, MDR.sourceTools.src_Gong_Government
									, MDR.sourceTools.src_Gong_Business
							);
SELF.record_type := 'C';
SELF.company_name := L.listed_name;
SELF.company_prim_range := L.prim_range;
SELF.company_predir := L.predir;
SELF.company_prim_name := L.prim_name;
SELF.company_addr_suffix := L.suffix;
SELF.company_postdir := L.postdir;
SELF.company_unit_desig := L.unit_desig;
SELF.company_sec_range := L.sec_range;
SELF.company_city := L.v_city_name;
SELF.company_state := L.st;
SELF.company_zip := (UNSIGNED3)L.z5;
SELF.company_zip4 := (UNSIGNED2)L.z4;
SELF.company_phone := (UNSIGNED6)((UNSIGNED8)L.phone10);
SELF.dt_first_seen := (UNSIGNED4)(L.filedate[1..8]);
SELF.dt_last_seen := (UNSIGNED4)(L.filedate[1..8]);
SELF.email_address := '';
SELF := L;
END;

Gong_Contacts := PROJECT(Gong_Business(name_last <> ''), Translate_Gong_to_BCF(LEFT));

return Gong_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

end;