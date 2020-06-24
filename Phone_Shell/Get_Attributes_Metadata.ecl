IMPORT Phone_Shell, RiskWise, Phones;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Get_Attributes_Metadata (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input) := FUNCTION

 Phones.Layouts.PhoneAttributes.BatchIn getMetadataInput(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
  SELF.phoneno := le.gathered_phone;
  SELF.acctno := (string)le.unique_record_sequence;
 END;

 Metadata_Input := PROJECT(Input, getMetadataInput(left));
 
 Metadata_Mod := MODULE(Phones.IParam.BatchParams)
  EXPORT UNSIGNED max_age_days := Phones.Constants.PhoneAttributes.LastActivityThreshold; // LERG6 last activity threshold
  EXPORT BOOLEAN  include_temp_susp_reactivate := FALSE;
 END;
 
 Metadata_Raw := Phones.GetPhoneMetadata_wLERG6(Metadata_Input, Metadata_Mod);
 
 Layout_PlusWorkingMetadata := RECORD
  Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
  STRING8 metadata_vendor_first_reported_dt := '';
  STRING8 metadata_vendor_last_reported_dt := '';
  STRING8 metadata_serv_event_date := '';
  STRING8 metadata_line_event_date := '';
 END;

 Layout_PlusWorkingMetadata getMetadata(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phones.Layouts.PhoneAttributes.Raw ri) := TRANSFORM
  SELF.Metadata.Meta_Most_Recent_Deact_Dt  := if((string)ri.deact_start_dt = '0','',(string)ri.deact_start_dt);
  SELF.Metadata.Meta_Most_Recent_React_Dt  := if((string)ri.react_start_dt = '0','',(string)ri.react_start_dt);
  SELF.Metadata.Meta_Most_Recent_Port_Dt   := if((string)ri.port_start_dt = '0','',(string)ri.port_start_dt);
  SELF.Metadata.Meta_Most_Recent_Swap_Dt   := if((string)ri.swap_start_dt = '0','',(string)ri.swap_start_dt);
  SELF.Metadata.Meta_Most_Recent_Active_Dt := if(ri.transaction_code = 'AS',if((string)ri.vendor_last_reported_dt = '0','',(string)ri.vendor_last_reported_dt),'');
  SELF.Metadata.Meta_Most_Recent_OTP_Dt    := if(ri.source = 'OT',if((string)ri.vendor_last_reported_dt = '0','',(string)ri.vendor_last_reported_dt),'');
  SELF.Metadata.Meta_Count_OTP_30  := ri.count_otp_30;
  SELF.Metadata.Meta_Count_OTP_60  := ri.count_otp_60;
  SELF.Metadata.Meta_Count_OTP_90  := ri.count_otp_90;
  SELF.Metadata.Meta_Count_OTP_180 := ri.count_otp_180;
  SELF.Metadata.Meta_Count_OTP_365 := ri.count_otp_365;
  SELF.Metadata.Meta_Count_OTP_730 := ri.count_otp_730;
  SELF.Metadata.Meta_Serv := ri.serv;
  SELF.Metadata.Meta_Line := ri.line;
  SELF.Metadata.Meta_Carrier_Name := ri.carrier_name;
  SELF.Metadata.Meta_Phone_Status := ri.phone_status;
  SELF.Metadata.Meta_High_Risk_Indicator := ri.high_risk_indicator;
  SELF.Metadata.Meta_Prepaid := ri.prepaid;
  
  // needed for sorting
  SELF.metadata_vendor_first_reported_dt := if((string)ri.vendor_first_reported_dt = '0','',(string)ri.vendor_first_reported_dt);
  SELF.metadata_vendor_last_reported_dt  := if((string)ri.vendor_last_reported_dt = '0','',(string)ri.vendor_last_reported_dt);
  // needed to help roll up serv and line
  SELF.metadata_serv_event_date := if(trim(ri.serv)='','',if((string)ri.event_date = '0','',(string)ri.event_date));
  SELF.metadata_line_event_date := if(trim(ri.line)='','',if((string)ri.event_date = '0','',(string)ri.event_date));
  
  SELF := le;
 END;
	
 Metadata := JOIN(Input, Metadata_Raw, 
                  TRIM(LEFT.Gathered_Phone) <> '' AND
                    LEFT.Gathered_Phone = RIGHT.phone AND
                    LEFT.Unique_Record_Sequence = (integer)RIGHT.acctno,
                  getMetadata(LEFT, RIGHT), 
                  KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
	
 // We want to keep the most recent record
 MetadataSorted := SORT(Metadata, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, -Metadata_Vendor_Last_Reported_Dt, -Metadata_Vendor_First_Reported_Dt);
	
 Layout_PlusWorkingMetadata rollMetadata(Layout_PlusWorkingMetadata le, Layout_PlusWorkingMetadata ri) := TRANSFORM
  SELF.Metadata.Meta_Most_Recent_Deact_Dt  := max(le.Metadata.Meta_Most_Recent_Deact_Dt, ri.MetaData.Meta_Most_Recent_Deact_Dt);
  SELF.Metadata.Meta_Most_Recent_React_Dt  := max(le.Metadata.Meta_Most_Recent_React_Dt, ri.MetaData.Meta_Most_Recent_React_Dt);
  SELF.Metadata.Meta_Most_Recent_Port_Dt   := max(le.Metadata.Meta_Most_Recent_Port_Dt, ri.MetaData.Meta_Most_Recent_Port_Dt);
  SELF.Metadata.Meta_Most_Recent_Swap_Dt   := max(le.Metadata.Meta_Most_Recent_Swap_Dt, ri.MetaData.Meta_Most_Recent_Swap_Dt);
  SELF.Metadata.Meta_Most_Recent_Active_Dt := max(le.Metadata.Meta_Most_Recent_Active_Dt, ri.MetaData.Meta_Most_Recent_Active_Dt);
  SELF.Metadata.Meta_Most_Recent_OTP_Dt    := max(le.Metadata.Meta_Most_Recent_OTP_Dt, ri.MetaData.Meta_Most_Recent_OTP_Dt);
  SELF.Metadata.Meta_Count_OTP_30  := max(le.Metadata.Meta_Count_OTP_30,ri.Metadata.Meta_Count_OTP_30);
  SELF.Metadata.Meta_Count_OTP_60  := max(le.Metadata.Meta_Count_OTP_60,ri.Metadata.Meta_Count_OTP_60);
  SELF.Metadata.Meta_Count_OTP_90  := max(le.Metadata.Meta_Count_OTP_90,ri.Metadata.Meta_Count_OTP_90);
  SELF.Metadata.Meta_Count_OTP_180 := max(le.Metadata.Meta_Count_OTP_180,ri.Metadata.Meta_Count_OTP_180);
  SELF.Metadata.Meta_Count_OTP_365 := max(le.Metadata.Meta_Count_OTP_365,ri.Metadata.Meta_Count_OTP_365);
  SELF.Metadata.Meta_Count_OTP_730 := max(le.Metadata.Meta_Count_OTP_730,ri.Metadata.Meta_Count_OTP_730);
  SELF.Metadata.Meta_Serv := map(le.metadata_serv_event_date = '' and ri.metadata_serv_event_date = '' => '',
                                 le.metadata_serv_event_date = ''                                      => ri.Metadata.Meta_Serv,
                                 ri.metadata_serv_event_date = ''                                      => le.Metadata.Meta_Serv,
                                 le.metadata_serv_event_date >= ri.metadata_serv_event_date            => le.Metadata.Meta_Serv,
                                                                                                          ri.Metadata.Meta_Serv);
  SELF.Metadata.Meta_Line := map(le.metadata_line_event_date = '' and ri.metadata_line_event_date = '' => '',
                                 le.metadata_line_event_date = ''                                      => ri.Metadata.Meta_Line,
                                 ri.metadata_line_event_date = ''                                      => le.Metadata.Meta_Line,
                                 le.metadata_line_event_date >= ri.metadata_line_event_date            => le.Metadata.Meta_Line,
                                                                                                          ri.Metadata.Meta_Line);
  SELF.Metadata.Meta_Carrier_Name := le.Metadata.Meta_Carrier_Name;
  SELF.Metadata.Meta_Phone_Status := le.Metadata.Meta_Phone_Status;
  SELF.Metadata.Meta_High_Risk_Indicator := max(le.Metadata.Meta_High_Risk_Indicator, ri.Metadata.Meta_High_Risk_Indicator);
  SELF.Metadata.Meta_Prepaid := max(le.Metadata.Meta_Prepaid, ri.Metadata.Meta_Prepaid);
  
  SELF.metadata_serv_event_date := max(le.metadata_serv_event_date, ri.metadata_serv_event_date);
  SELF.metadata_line_event_date := max(le.metadata_line_event_date, ri.metadata_line_event_date);
  
  SELF := le;
 END;
	
 final_rollup := ROLLUP(MetadataSorted, 
                        LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND 
                          LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND 
                          LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
                        rollMetadata(LEFT, RIGHT));
 
 // now can drop those extra attributes we needed for the rollup and get back to the true layout
 final := PROJECT(final_rollup, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF := LEFT));
 
 // Debug outputs
 //OUTPUT(Metadata_Raw, NAMED('Metadata_Raw'));
 //OUTPUT(Metadata, NAMED('Metadata_BeforeRoll'));
 //OUTPUT(MetadataSorted, NAMED('Metadata_BeforeRollSorted'));
 //OUTPUT(final_rollup, NAMED('Metadata_AfterRoll'));
 //OUTPUT(final, NAMED('Metadata_Final'));
 
 RETURN(final);
END;