﻿import risk_indicators, PublicRecords_KEL;

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
                        
  self.seq := le.InputUIDAppend;
	self.historydate := (unsigned)le.inputarchivedateclean[1..6];
	SELF.in_streetAddress := le.inputstreetecho;
	SELF.in_city := le.inputcityecho;
	SELF.in_state := le.inputstateecho;
	SELF.in_zipCode := le.inputzipecho;
	SELF.in_country := '';
	self.fname := le.inputfirstnameclean;
	self.mname := le.inputmiddlenameclean;
	self.lname := le.inputlastnameclean;
	self.suffix := le.inputsuffixclean; 
	self.ssn := le.inputssnclean;
	self.dob := le.inputdobclean;	
	self.phone10 := le.inputhomephoneclean;
	self.wphone10 := le.inputworkphoneclean;  
	self.prim_range := le.InputPrimaryRangeClean;
	self.predir := le.InputPreDirectionClean;
	self.prim_name := le.InputPrimaryNameClean;
	self.addr_suffix := le.InputAddressSuffixClean;
	self.postdir := le.InputPostDirectionClean;
	self.unit_desig := le.InputUnitDesigClean;
	self.sec_range := le.InputSecondaryRangeClean;
	self.p_city_name := le.InputCityClean;
	self.st := le.InputStateClean;
	self.z5 := le.InputZip5Clean;
	self.zip4 := le.InputZip4Clean;
	self.lat := le.InputLatitudeClean;
	self.long := le.InputLongitudeClean;
	self.addr_type := le.InputAddressTypeClean;
	self.addr_status := le.InputAddressStatusClean;
	self.county := le.InputCountyClean;
	self.geo_blk := le.InputGeoblockClean;
	SELF.dl_number := le.InputDLClean;
	SELF.dl_state := le.InputDLStateClean ;
	SELF.email_address := le.InputEmailClean;
  self := le,
  self := [];
end;
  
input_prepped := project(cleanInput, prep(left));

return input_prepped;

end;
