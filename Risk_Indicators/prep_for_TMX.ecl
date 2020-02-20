import risk_indicators, PublicRecords_KEL;

EXPORT prep_for_TMX(dataset(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) cleanInput,
                    string20 companyID = '',
                    string50 companyName = '',
                    string20 _OrgId = '',
                    string20 _ApiKey = '',
                    string50 _Policy = '',
                    string50 _EventType = '',
                    boolean _NoPIIPersistence = false,
                    boolean _DigitalIdReadOnly = false
                    ) := function

Risk_Indicators.layouts.layout_trustdefender_in prep(cleanInput le) := transform
  self.SessionId := trim('2067933A8E61C3616767047A42C727D6'),   
  self.OrgId := Trim(_OrgId);   //trim('ymyo6b64'),
  self.ApiKey := Trim(_ApiKey); //trim('dc1lautzmb0s44s4'),
  self.Policy := Trim(_Policy); //trim('Fraudpoint_test'),
  self.ApiType := Trim('AttributeQuery'),
  self.serviceType := Trim('session-policy'),
  self.Event_Type := Trim(_EventType);
  self.NoPIIPersistence := _NoPIIPersistence;
  self.DigitalIdReadOnly := _DigitalIdReadOnly;
  self.MerchantID := Trim(companyID);
  self.MerchantName := Trim(companyName); 
                        
  self.seq := le.G_ProcUID;
	self.historydate := (unsigned)le.P_InpClnArchDt[1..6];
	SELF.in_streetAddress := le.P_InpAddrLine1;
	SELF.in_city := le.P_InpAddrCity;
	SELF.in_state := le.P_InpAddrState;
	SELF.in_zipCode := le.P_InpAddrZip;
	SELF.in_country := '';
	self.fname := le.P_InpClnNameFirst;
	self.mname := le.P_InpClnNameMid;
	self.lname := le.P_InpClnNameLast;
	self.suffix := le.P_InpClnNameSffx; 
	self.ssn := le.P_InpClnSSN;
	self.dob := le.P_InpClnDOB;	
	self.phone10 := le.P_InpClnPhoneHome;
	self.wphone10 := le.P_InpClnPhoneWork;  
	self.prim_range := le.P_InpClnAddrPrimRng;
	self.predir := le.P_InpClnAddrPreDir;
	self.prim_name := le.P_InpClnAddrPrimName;
	self.addr_suffix := le.P_InpClnAddrSffx;
	self.postdir := le.P_InpClnAddrPostDir;
	self.unit_desig := le.P_InpClnAddrUnitDesig;
	self.sec_range := le.P_InpClnAddrSecRng;
	self.p_city_name := le.P_InpClnAddrCity;
	self.st := le.P_InpClnAddrState;
	self.z5 := le.P_InpClnAddrZip5;
	self.zip4 := le.P_InpClnAddrZip4;
	self.lat := le.P_InpClnAddrLat;
	self.long := le.P_InpClnAddrLng;
	self.addr_type := le.P_InpClnAddrType;
	self.addr_status := le.P_InpClnAddrStatus;
	self.county := le.P_InpClnAddrCnty;
	self.geo_blk := le.P_InpClnAddrGeo;
	SELF.dl_number := le.P_InpClnDL;
	SELF.dl_state := le.P_InpClnDLState ;
	SELF.email_address := le.P_InpClnEmail;
  self := le,
  self := [];
end;
  
input_prepped := project(cleanInput, prep(left));

return input_prepped;

end;
