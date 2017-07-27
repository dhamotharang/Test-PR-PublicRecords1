import Business_Header, ut, address;

cu := BusData.File_Credit_Unions_base;

Business_Header.Layout_Business_Header Translate_CU_To_BHF(cu l) := transform
self.source := 'CU';          // Source file type
self.source_group := trim(l.state) + l.charter;
self.vendor_id := trim(l.state) + l.charter;
self.dt_first_seen := (unsigned4)StringLib.GetDateYYYYMMDD();
self.dt_last_seen := (unsigned4)StringLib.GetDateYYYYMMDD();
self.dt_vendor_first_reported := (unsigned4)StringLib.GetDateYYYYMMDD();
self.dt_vendor_last_reported := (unsigned4)StringLib.GetDateYYYYMMDD();
self.company_name := if (StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'CREDIT UNION', 1) > 0 or
                                              StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'C U ', 1) > 0 or
									 StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), ' C U', 1) > 0 or
									 StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'C.U.', 1) > 0 or
									 StringLib.StringFind(Stringlib.StringToUpperCase(l.CU_NAME), 'C. U.', 1) > 0,
                         Stringlib.StringToUpperCase(l.CU_NAME),
					trim(Stringlib.StringToUpperCase(l.CU_NAME)) + ' CREDIT UNION');
self.city := l.p_city_name;
self.state := l.st;
self.county := l.fipscounty;
self.zip := (unsigned3)l.zip;
self.zip4 := (unsigned2)l.zip4;
self.phone := (unsigned6)address.CleanPhone(l.Phone);
self.phone_score := if(self.phone = 0, 0, 1);
self.current := true;          // Current/Historical indicator
self := l;
end;

cu_init := project(cu, Translate_CU_To_BHF(left));

export Credit_Unions_As_Business_Header := cu_init : persist('TEMP::CU_As_Business_Header');