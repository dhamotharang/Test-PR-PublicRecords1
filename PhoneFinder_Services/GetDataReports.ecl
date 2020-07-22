IMPORT dx_PhoneFinderReportDelta;
EXPORT GetDataReports(STRING Input_filename,
                      STRING Output_landingzone,
                      STRING working_directory) := FUNCTION
								
Input_csv_layout := Record
   STRING Company_ID;
   STRING8 Start_dt;
   STRING8 End_dt;
END;    
    
dInputReq := DATASET(Input_filename,Input_csv_layout ,CSV(HEADING(1)));

maxrecordsretained := 150000;

Returned_data := RECORD
  STRING10  phone_number;
  INTEGER1  phone_id;
  STRING32 phone_type;
  STRING64  listing_name;
  STRING16  risk_indicator;
  STRING  risk_indicator_text;
  UNSIGNED8  lexid;
  STRING128  full_name;
  STRING128  full_address;
  STRING64  city;
  STRING16  state;
  STRING10  zip;
  INTEGER1  verified_carrier;
END;    

Input_echo := RECORD
  STRING16 transaction_id;
  STRING8  transaction_date;
  STRING60  user_id;
  STRING16  company_Id;
  STRING60  reference_code;
  STRING32  phonefinder_type;
  STRING15  submitted_phonenumber;
  STRING20  submitted_firstname;
  STRING20  submitted_lastname;
  STRING20  submitted_middlename;
  STRING128  submitted_streetaddress1;
  STRING64  submitted_city;
  STRING16  submitted_state;
  STRING10  submitted_zip;
  UNSIGNED8  submitted_lexid;
END;  

Out_ReportStructure:= RECORD
  Input_Echo;
  DATASET(Returned_data)  Returned_data;
END;

ReportStructure:= RECORD
  Input_Echo;
  Returned_data;
END;
//If the client has to search for one day then they would just enter the start date, the end date would be blank. The check is for those cases

    Transaction_IDs := Join(dInputReq,dx_PhoneFinderReportDelta.Key_Transactions_CompanyId(),
                                    KEYED(LEFT.Company_ID != ''AND LEFT.Company_ID = RIGHT.Company_ID AND
                                    IF(LEFT.End_dt != '', (RIGHT.transaction_date BETWEEN LEFT.Start_dt and LEFT.End_dt), RIGHT.transaction_date = LEFT.Start_dt)),
                                    TRANSFORM(ReportStructure, SELF.Company_ID := LEFT. Company_ID,
                                                               SELF.transaction_id := RIGHT.transaction_id,
                                                               SELF.transaction_date := RIGHT.transaction_date,
                                                               SELF := []), LIMIT(0), KEEP(maxrecordsretained), LEFT OUTER);

    Transactions :=   Join(Transaction_IDs, dx_PhoneFinderReportDelta.Key_Transactions(),
                                    KEYED(LEFT.transaction_id = RIGHT.transaction_id),
                                    TRANSFORM(ReportStructure, SELF.transaction_id := LEFT.transaction_id,
                                                               SELF.phone_number := RIGHT.phonenumber,
                                                               SELF := RIGHT ,SELF := []), LIMIT(0), KEEP(maxrecordsretained), LEFT OUTER);
       
    Risk_Indicators := dx_PhoneFinderReportDelta.Key_RiskIndicators();
		Identities := dx_PhoneFinderReportDelta.Key_Identities();
		OtherPhones := dx_PhoneFinderReportDelta.Key_OtherPhones();

    Identitiesjoin := JOIN(Transactions, Identities,
                                    KEYED(LEFT.transaction_id = RIGHT.transaction_id),
                                    TRANSFORM(ReportStructure, SELF.lexid :=  RIGHT.lexid,
                                    SELF.full_name :=  RIGHT.full_name,
                                    SELF.full_address :=  RIGHT.full_address,
                                    SELF.city :=  RIGHT.city,
                                    SELF.state :=  RIGHT.state,
                                    SELF.zip :=  RIGHT.zip,
                                    SELF.verified_carrier :=  RIGHT.verified_carrier,                         
                                    SELF := LEFT,SELF := []), LIMIT(0), KEEP(maxrecordsretained), LEFT OUTER);

    PrimaryPhoneRiskIndicatorJoin := JOIN(Identitiesjoin, Risk_Indicators,
                              KEYED(LEFT.transaction_id = RIGHT.transaction_id) and
                                    RIGHT.phone_id = 0,
                                    TRANSFORM(ReportStructure, SELF.risk_indicator_text := RIGHT.risk_indicator_text,
                                              SELF.phone_id := RIGHT.phone_id,
                                              SELF := LEFT), LIMIT(0), KEEP(maxrecordsretained), LEFT OUTER);

    OtherPhonesJoin := JOIN(PrimaryPhoneRiskIndicatorJoin, OtherPhones,
                                   KEYED(LEFT.transaction_id = RIGHT.transaction_id),
                                   TRANSFORM(ReportStructure, SELF.phone_id := RIGHT.phone_id,
                                             SELF.risk_indicator := RIGHT.risk_indicator,
                                             SELF.phone_number   := RIGHT.phonenumber,
                                             SELF.listing_name   := RIGHT.listing_name,
                                             SELF.verified_carrier :=  RIGHT.verified_carrier,
                                             SELF.phone_type :=  RIGHT.phone_type,
                                             SELF.risk_indicator_text :=  '',
                                             SELF.lexid :=  0,
                                             SELF.full_name :=  '',
                                             SELF.full_address :=  '',
                                             SELF.city :=  '',
                                             SELF.state :=  '',
                                             SELF.zip :=  '',
                                             SELF := LEFT));    

    OtherPhonesRiskIndicatorJoin := JOIN(OtherPhonesJoin, Risk_Indicators,
                                             KEYED(left.transaction_id = RIGHT.transaction_id) AND
                                             LEFT.phone_id = RIGHT.phone_id,
                                             TRANSFORM(ReportStructure, SELF.risk_indicator_text  := RIGHT.risk_indicator_text,
                                             SELF := LEFT), LIMIT(0), KEEP(maxrecordsretained), LEFT OUTER);
                                        
    Transactions_with_other_phones := DEDUP(SORT(PrimaryPhoneRiskIndicatorJoin + OtherPhonesRiskIndicatorJoin, transaction_id, phone_id, phone_number, risk_indicator, risk_indicator_text),transaction_id, phone_id, phone_number, risk_indicator, risk_indicator_text);                                                                                                                                      
                                                                      
   ReportStructure RITransform(ReportStructure L, ReportStructure R):= TRANSFORM 
                                                   SELF.risk_indicator_text := IF(R.risk_indicator_text != '', TRIM(L.risk_indicator_text) +', '+ TRIM(R.risk_indicator_text), L.risk_indicator_text);   
                                                   SELF := L;
     END;

     Transactions_sorted := SORT(Transactions_with_other_phones, transaction_id, phone_number, -risk_indicator_text);
     Result_prefinal := ROLLUP(Transactions_sorted, RITransform(LEFT, RIGHT),transaction_id, phone_number);
     
     Out_ReportStructure prerollupTransform(Result_prefinal L):= TRANSFORM 

                                                   SELF.Returned_data := PROJECT(L, TRANSFORM(Returned_data,
                                                   SELF.phone_number:= LEFT.phone_number,
                                                   SELF.phone_id:= LEFT.phone_id,
                                                   SELF.risk_indicator:= LEFT.risk_indicator,
                                                   SELF.risk_indicator_text:= LEFT.risk_indicator_text,
                                                   SELF.listing_name:= LEFT.listing_name,
                                                   SELF.lexid:= LEFT.lexid,
                                                   SELF.full_name:= LEFT.full_name,
                                                   SELF.full_address:= LEFT.full_address,
                                                   SELF.city:= LEFT.city,
                                                   SELF.state:= LEFT.state,
                                                   SELF.zip:= LEFT.zip,
                                                   SELF.phone_type:= LEFT.phone_type,
                                                   SELF.verified_carrier:= LEFT.verified_carrier));
                                                   SELF := L;
     END;

    Final := PROJECT(Result_prefinal, prerollupTransform(LEFT));

    Out_ReportStructure tOutrollup(Final L, Final R):= TRANSFORM 
      SELF.Returned_data := DEDUP(SORT(L.Returned_data + R.Returned_data, phone_id, phone_number, lexid, full_name, full_address, city, state, zip, verified_carrier, risk_indicator, -risk_indicator_text), phone_id, phone_number, lexid, full_name, full_address, city, state, zip, verified_carrier, risk_indicator);
      SELF := L;
     END;
     
     Result := Rollup(SORT(Final, transaction_id, transaction_date), tOutrollup(LEFT, RIGHT), transaction_id, transaction_date, user_id, company_Id, reference_code);
		SEQUENTIAL(output(Result,,'~thor_data400::ReportingData::'+ WORKUNIT, XML('Row',HEADING('<Dataset>\n','</Dataset>\n'), TRIM), OVERWRITE, COMPRESSED),
                          FileServices.DeSpray('~thor_data400::ReportingData::'+ WORKUNIT, Output_landingzone, working_directory +'Results.xml' ,,,,TRUE));
		RETURN Result;
END;

