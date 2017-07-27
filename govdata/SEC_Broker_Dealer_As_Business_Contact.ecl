import Business_Header, ut;

SEC_Broker_In := File_SEC_Broker_Dealer_In(lname <> '');

Business_Header.Layout_Business_Contact_Full Translate_SEC_To_BCF(Layout_SEC_Broker_Dealer_In l) := transform
self.source := 'SB';          // Source file type
self.vendor_id := l.CIK_NUMBER;
self.dt_first_seen := (unsigned4)l.dt_first_reported;
self.dt_last_seen := (unsigned4)l.dt_last_reported;
self.city := l.p_city_name;
self.state := l.st;
self.zip := (unsigned3)l.zip;
self.zip4 := (unsigned2)l.zip4;
self.phone := 0;
self.name_score := Business_Header.CleanName(l.fname, l.mname, l.lname, l.name_suffix)[142],
self.email_address := '';
self.company_title := 'BROKER';
self.company_source_group := l.CIK_NUMBER; // Source group
self.company_name := Stringlib.StringToUpperCase(l.company_name);
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
self.company_phone := 0;
self.record_type := 'C';          // Current/Historical indicator
self := l;
end;

SEC_Broker_Contact_Init := project(SEC_Broker_In, Translate_SEC_To_BCF(left));

export SEC_Broker_Dealer_As_Business_Contact := SEC_Broker_Contact_Init
	: persist('TEMP::SEC_Broker_Dealer_As_BC');