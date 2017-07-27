import Business_Header, ut, address;

cu := BusData.File_Credit_Unions_base(name_last <> '');

Business_Header.Layout_Business_Contact_Full Translate_CU_To_BCF(cu l) := transform
self.source := 'CU';          // Source file type
self.vendor_id := trim(l.state) + l.charter;
self.dt_first_seen := (unsigned4)StringLib.GetDateYYYYMMDD();
self.dt_last_seen := (unsigned4)StringLib.GetDateYYYYMMDD();
self.city := l.p_city_name;
self.state := l.st;
self.county := l.fipscounty;
self.zip := (unsigned3)l.zip;
self.zip4 := (unsigned2)l.zip4;
self.phone := (unsigned6)address.CleanPhone(l.Phone);
self.title := l.name_prefix;
self.fname := l.name_first;
self.mname := l.name_middle;
self.lname := l.name_last;
self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
self.email_address := '';
self.company_title := '';
self.company_source_group := trim(l.state) + l.charter; // Source group
self.company_name := if (StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'CREDIT UNION', 1) > 0 or
                                              StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'C U ', 1) > 0 or
									 StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), ' C U', 1) > 0 or
									 StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'C.U.', 1) > 0 or
									 StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'C. U.', 1) > 0,
                         Stringlib.StringToUpperCase(l.CU_NAME),
					trim(Stringlib.StringToUpperCase(l.CU_NAME)) + ' CREDIT UNION');
self.company_prim_range := l.prim_range;
self.company_predir := l.predir;
self.company_prim_name := l.prim_name;
self.company_addr_suffix := l.addr_suffix;
self.company_postdir := l.postdir;
self.company_unit_desig := l.unit_desig;
self.company_sec_range := l.sec_range;
self.company_city := l.p_city_name;
self.company_state := l.st;
self.company_zip := (unsigned3)l.zip;
self.company_zip4 := (unsigned2)l.zip4;
self.company_phone := (unsigned6)address.CleanPhone(l.Phone);
self.record_type := 'C';          // Current/Historical indicator
self := l;
end;

cu_contacts_init := project(cu, Translate_CU_To_BCF(left));

export Credit_Unions_As_Business_Contact := cu_contacts_init : persist('TEMP::Credit_Unions_As_BC');