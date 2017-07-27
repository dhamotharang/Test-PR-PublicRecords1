import Business_Header, ut;

SEC_Broker_In := File_SEC_Broker_Dealer_BDID;

Business_Header.Layout_Business_Header Translate_SEC_To_BHF(Layout_SEC_Broker_Dealer_BDID l) := transform
self.source := 'SB';          // Source file type
self.source_group := l.CIK_NUMBER;
self.vendor_id := l.CIK_NUMBER;
self.dt_first_seen := (unsigned4)l.dt_first_reported;
self.dt_last_seen := (unsigned4)l.dt_last_reported;
self.dt_vendor_first_reported := (unsigned4)l.dt_first_reported;
self.dt_vendor_last_reported := (unsigned4)l.dt_last_reported;
self.company_name := Stringlib.StringToUpperCase(l.company_name);
self.city := l.p_city_name;
self.state := l.st;
self.zip := (unsigned3)l.zip;
self.zip4 := (unsigned2)l.zip4;
self.phone := 0;
self.fein := if(l.is_company_flag = x'0001', (unsigned4)l.IRS_TAXPAYER_ID, 0);
self.current := true;          // Current/Historical indicator
self := l;
end;

SEC_Broker_Init := project(SEC_Broker_In, Translate_SEC_To_BHF(left));

export SEC_Broker_Dealer_As_Business_Header := SEC_Broker_Init;