﻿﻿IMPORT iesp, Std;

EXPORT Get_Reporting_Records(DATASET(iesp.phonefinder.t_PhoneFinderSearchRecord) pF_Records,
								     PhoneFinder_Services.iParam.ReportParams    inMod,
									 iesp.phonefinder.t_PhoneFinderSearchBy      pSearchBy
									 ) := FUNCTION
																 
	 transaction_rec_with_alerts := RECORD
        PhoneFinder_Services.Layouts.delta_phones_rpt_transaction;
        DATASET(iesp.phonefinder.t_PhoneFinderAlertIndicator) alerts;
	 END;
       
	 CurrentDate := (STRING)Std.Date.Today();
	 Timestamp := (STRING)STD.Date.CurrentTime();
	 Date := STD.date.ConvertDateFormat(CurrentDate, '%Y%m%d','%Y-%m-%d');
	 Time :=STD.date.ConvertTimeFormat(Timestamp, '%H%M%S', '%H:%M:%S');
	 TransactionType := inMod.TransactionType;
           
  STRING30 DataSource := (STRING1)(INTEGER)inMod.IncludeEquifax + (STRING1)(INTEGER)inMod.IncludeTargus +
                         (STRING1)(INTEGER)inMod.IncludeInhousePhones + (STRING1)(INTEGER)inMod.IncludeAccudataOCN +
                         (STRING1)(INTEGER)inMod.IncludeTransUnionPVS +  (STRING1)(INTEGER)inMod.IncludeTransUnionIQ411 + 
                         (STRING1)(INTEGER)inMod.UseInHousePhoneMetadata + (STRING1)(INTEGER)inMod.IncludeOTP + 
                         (STRING1)(INTEGER)inMod.IncludePorting + (STRING1)(INTEGER)inMod.IncludeSpoofing + 
                         (STRING1)(INTEGER)inMod.IncludeZumigoOptions + (STRING1)(INTEGER)inMod.NameAddressValidation +
                         (STRING1)(INTEGER)inMod.NameAddressInfo + (STRING1)(INTEGER)inMod.AccountInfo + (STRING1)(INTEGER)inMod.CallHandlingInfo +
                         (STRING1)(INTEGER)inMod.DeviceHistory + (STRING1)(INTEGER)inMod.DeviceInfo + (STRING1)(INTEGER)inMod.DeviceChangeInfo;
     
  transaction_rec_with_alerts xfm_Transaction(iesp.phonefinder.t_PhoneFinderSearchRecord R, INTEGER C) := TRANSFORM
	 SELF.transaction_id    	  := inMod.TransactionId;
	 SELF.transaction_date        := (STRING)Date +' '+ (STRING)Time;
	 SELF.User_Id           	  := IF(inMod.CompanyId <> '', inMod.BillingCode, inMod._Loginid);
	 SELF.Product_Code      	  := inMod.ProductCode;
	 SELF.Company_Id        	  := IF(inMod.CompanyId <> '', inMod.CompanyId, inMod._CompanyId);
	 SELF.source_code             := inMod.SourceCode;  
	 SELF.reference_code      	  := inMod.ReferenceCode;
	 SELF.phonefinder_type     	  := PhoneFinder_Services.Constants.MapTransCode2Type(TransactionType);
	 SELF.data_source     	      := DataSource;
	 SELF.carrier                 := R.PrimaryPhoneDetails.Carrier;
	 SELF.royalty_used            := ''; //TODO  PHPR-165
	 //SearchTerms
	 SELF.submitted_lexid   	 := pSearchBy.UniqueId;
	 SELF.submitted_phonenumber  := pSearchBy.PhoneNumber;
	 SELF.submitted_firstname    := pSearchBy.Name.first;
	 SELF.submitted_lastname   	 := pSearchBy.Name.last;
	 SELF.submitted_middlename   := pSearchBy.Name.Middle;
	 SELF.submitted_streetaddress1:= pSearchBy.Address.StreetAddress1;
	 SELF.submitted_city   		  := pSearchBy.Address.City;
	 SELF.submitted_state   	  := pSearchBy.Address.State;
	 SELF.submitted_zip   		  := pSearchBy.Address.Zip5;
	 SELF.PhoneNumber   		  := R.PrimaryPhoneDetails.Number;
	 SELF.Risk_Indicator       	  := R.PrimaryPhoneDetails.PhoneRiskIndicator;
	 SELF.phone_type       		  := R.PrimaryPhoneDetails._Type;
	 SELF.phone_status       	  := R.PrimaryPhoneDetails.PhoneStatus;
	 SELF.ported_count       	  := R.PrimaryPhoneDetails.PortingCount;
	 SELF.last_ported_date        := iesp.ECL2ESP.t_DateToString8(R.PrimaryPhoneDetails.LastPortedDate);
	 SELF.otp_count      		  := R.PrimaryPhoneDetails.OneTimePassword.OTPCount;
	 SELF.last_otp_date      	  := iesp.ECL2ESP.t_DateToString8(R.PrimaryPhoneDetails.OneTimePassword.LastOTPDate);
	 SELF.spoof_count   		  := R.PrimaryPhoneDetails.SpoofingData.TotalSpoofedCount;
	 SELF.last_spoof_date		  := iesp.ECL2ESP.t_DateToString8(R.PrimaryPhoneDetails.SpoofingData.LastEventSpoofedDate);
	 SELF.phone_forwarded      	  := R.PrimaryPhoneDetails.CallForwardingIndicator;
	 SELF.Alerts 				  := R.PrimaryPhoneDetails.AlertIndicators;
 END;	
   
  Transaction_Rec := PROJECT (pF_Records,  xfm_Transaction(LEFT, COUNTER));
		 
	 OtherPhones_with_alerts := RECORD
		PhoneFinder_Services.Layouts.delta_phones_rpt_otherphones;
		DATASET(iesp.phonefinder.t_PhoneFinderAlertIndicator) alerts;
	 END;
	 			
 	OtherPhones_with_alerts xfm_OtherPhones(iesp.phonefinder.t_PhoneFinderInfo R, INTEGER C) := TRANSFORM
        SELF.transaction_id    			:= inMod.TransactionId;
      	 SELF.sequence_number      := C;
      	 SELF.phone_id             := C;
      	 SELF.PhoneNumber          := R.Number;
   		 SELF.Risk_Indicator       := R.PhoneRiskIndicator;
      	 SELF.phone_type           := R._Type;
      	 SELF.phone_status         := R.PhoneStatus;
      	 SELF.listing_name         := R.ListingName;
      	 SELF.porting_code         := R.PortingCode;
      	 SELF.phone_forwarded      := R.CallForwardingIndicator;
      	 SELF.verified_carrier     := (INTEGER)R.PhoneOwnershipIndicator;
		 SELF.Alerts 			   := R.AlertIndicators;
   END;	
      
   OtherPhones_Rec := NORMALIZE(pF_Records, LEFT.OtherPhones, xfm_OtherPhones(RIGHT, COUNTER));
     																											
   PhoneFinder_Services.Layouts.delta_phones_rpt_identities xfm_Identities(iesp.phonefinder.t_PhoneIdentityInfo R, INTEGER C) := TRANSFORM
       SELF.transaction_id    	:= inMod.TransactionId;
       SELF.sequence_number     := C;
   	   SELF.lexid         		:= R.UniqueId;
       SELF.Full_name           := R.Name.Full;
       SELF.Full_Address        := R.RecentAddress.StreetAddress1;
       SELF.City         		:= R.RecentAddress.City;
       SELF.State         		:= R.RecentAddress.State;
       SELF.Zip         		:= R.RecentAddress.Zip5;
       SELF.verified_carrier   	:= (INTEGER)R.PhoneOwnershipIndicator;
   END;	
         
  Identity_Recs := NORMALIZE(pF_Records, LEFT.Identities, xfm_Identities(RIGHT, COUNTER)); 

  PhoneFinder_Services.Layouts.delta_phones_rpt_riskindicators xfm_PRiskInc(iesp.phonefinder.t_PhoneFinderAlertIndicator L, INTEGER C) := TRANSFORM
    SELF.transaction_id    		 := inMod.TransactionId,  
	SELF.Phone_Id 				 := 0,
	SELF.sequence_number    	 := C,
    SELF.risk_indicator_text 	 := L.messages,
    SELF.risk_indicator_category := L.Flag,
    SELF.risk_indicator_id		 := L.RiskId,
    SELF.risk_indicator_level	 := L.Level,
	SELF                         := [] 
  END;
    
  PrimaryPhone_Alerts := NORMALIZE(Transaction_Rec, LEFT.Alerts,	xfm_PRiskInc(RIGHT, COUNTER));
    
  PhoneFinder_Services.Layouts.delta_phones_rpt_riskindicators xfm_OpRiskInc(RECORDOF(OtherPhones_Rec) L, iesp.phonefinder.t_PhoneFinderAlertIndicator R, INTEGER C) := TRANSFORM
    SELF.transaction_id    		:= inMod.TransactionId,
	SELF.Phone_Id 				:= L.phone_id,
    SELF.sequence_number    	:= C,
    SELF.risk_indicator_text 	:= R.messages,
    SELF.risk_indicator_category:= R.Flag,
    SELF.risk_indicator_id		:= R.RiskId,
    SELF.risk_indicator_level	:= R.Level,
    SELF 						:= [] 
  END;
            		    		 
  OtherPhones_Alerts := NORMALIZE(OtherPhones_Rec, LEFT.Alerts,	xfm_OpRiskInc(LEFT, RIGHT, COUNTER)); 
     		   
  Final_RiskIndicators := PrimaryPhone_Alerts + OtherPhones_Alerts;    	             		
   PhoneFinder_Services.Layouts.delta_phones_rpt_Usage_records tFormat2PhoneFinderReport() :=		TRANSFORM
     SELF.delta_phones_rpt_transaction     := PROJECT(Transaction_Rec, PhoneFinder_Services.Layouts.delta_phones_rpt_transaction);	
     SELF.delta_phones_rpt_otherphones     := PROJECT(OtherPhones_Rec, PhoneFinder_Services.Layouts.delta_phones_rpt_otherphones);	
     SELF.delta_phones_rpt_identities      := Identity_Recs;
     SELF.delta_phones_rpt_riskindicators  := Final_RiskIndicators;	
   END;
               		
 dFormat2PhoneFinderReport := DATASET([tFormat2PhoneFinderReport()]);
   	
  return dFormat2PhoneFinderReport;														 
													 
end;
