﻿IMPORT Gateway, Phones, PhoneFinder_Services, STD;
EXPORT GetZumigoIdentity_Records(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.Final)  dPhoneRecs,
                                 DATASET(PhoneFinder_Services.Layouts.BatchInAppendDID) dInBestInfo,
                                 PhoneFinder_Services.iParam.ReportParams         inMod,
																 DATASET(Gateway.Layouts.Config) dGateways) := 

MODULE

   
   Ph_wireless := dPhoneRecs(phone <> '' AND typeflag != Phones.Constants.TypeFlag.DataSource_PV AND COC_description = PhoneFinder_Services.Constants.PhoneType.Wireless);

   // for phone search, we are sending upto 10 different identities per acct, by picking recent ones.
   Ph_wireless_ddp := DEDUP(SORT(Ph_wireless, acctno, phone, fname, lname, prim_range, prim_name, city_name, st, zip), acctno, phone, fname, lname, prim_range, prim_name, city_name, st, zip);
   PhoneSrch_wireless := TOPN(GROUP(SORT(Ph_wireless_ddp(phone = batch_in.homephone), acctno,  -dt_last_seen, dt_first_seen, seq), acctno), 10, acctno);
                                	
  
	// for pii search, sending in one primary wireless phone , if available, else one other phone per acct
	// sorting other phones(non primary) by score and dates 
  	
   PII_wireless_pre := DEDUP(SORT(Ph_wireless(batch_in.homephone = ''), acctno, if(isprimaryphone, 0, 1), -phone_score, -dt_last_seen, dt_first_seen), acctno);
     
		 // sending in best identities name/addr to first wireless phone 
   PhoneFinder_Services.Layouts.PhoneFinder.Final in_addr(PhoneFinder_Services.Layouts.PhoneFinder.Final l,
   	                                                       PhoneFinder_Services.Layouts.BatchInAppendDID r)
   := TRANSFORM
        
				    SELF.phone :=  l.phone;
        SELF.fname :=  r.name_first;
        SELF.mname :=  r.name_middle;
        SELF.lname := r.name_last;
        SELF.prim_range := r.prim_range;
        SELF.predir := r.predir;
        SELF.prim_name := r.prim_name;
        SELF.suffix := r.addr_suffix;
        SELF.postdir := r.postdir;
        SELF.unit_desig := r.unit_desig;
        SELF.sec_range := r.sec_range;
        SELF.city_name := r.p_city_name;
        SELF.st :=  r.st;
        SELF.zip :=  r.z5;
        SELF.zip4 :=  r.zip4;
        SELF := l;																				
   																																																																																																													
      END;
	 
   PII_wireless := JOIN(PII_wireless_pre, dInBestInfo, LEFT.acctno = RIGHT.acctno, in_addr(left,right),limit(0), keep(1));

   Phones_wireless := PII_wireless + PhoneSrch_wireless;


   Zum_inMod := MODULE(Phones.IParam.inZumigoParams)
/*      use_case := MAP(inMod.Usecase[1] = '1' => 'OTPCFD',
                       inMod.Usecase[2] = '1' => 'FCIP',
                       inMod.Usecase[3] = '1' => 'TCPA',
                       inMod.Usecase[4] = '1' => 'Geo Location',
   										'');
*/
		 EXPORT STRING20 Usecase              := PhoneFinder_Services.Constants.ZumigoConstants.Usecase;
		 EXPORT STRING3 	productCode          := PhoneFinder_Services.Constants.ZumigoConstants.productCode;
		 EXPORT STRING8	billingId             := inMod.billingId;
		 EXPORT STRING20 productName          := PhoneFinder_Services.Constants.ZumigoConstants.productName;
		 SHARED UNSIGNED1 consent_level       := inMod.LineIdentityConsentLevel;	
		 EXPORT BOOLEAN NameAddressValidation := consent_level = PhoneFinder_Services.Constants.ConsentLevels.FullConsumer and 
		                                         inMod.TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate; // Only nameaddrvalidation for ultimate transactions
		 EXPORT BOOLEAN	NameAddressInfo       := FALSE;
		 EXPORT BOOLEAN	AccountInfo           := FALSE;
		 EXPORT BOOLEAN	CarrierInfo           := FALSE;
		 EXPORT BOOLEAN	CallHandlingInfo      := IF(consent_level = PhoneFinder_Services.Constants.ConsentLevels.FullConsumer, TRUE, FALSE);
		 EXPORT BOOLEAN	DeviceInfo            := FALSE;
		 EXPORT BOOLEAN 	DeviceHistory        := (consent_level = PhoneFinder_Services.Constants.ConsentLevels.FullConsumer or 
			                                         consent_level = PhoneFinder_Services.Constants.ConsentLevels.SingleConsumer) and inMod.TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		 EXPORT BOOLEAN 	DeviceChangeOption   := (consent_level = PhoneFinder_Services.Constants.ConsentLevels.FullConsumer or 
		                                          consent_level = PhoneFinder_Services.Constants.ConsentLevels.SingleConsumer) and inMod.TransactionType = PhoneFinder_Services.Constants.TransType.Ultimate;
		 EXPORT STRING10 optInType            := PhoneFinder_Services.Constants.ZumigoConstants.optInType;
		 EXPORT STRING5 	optInMethod          := IF(consent_level= PhoneFinder_Services.Constants.ConsentLevels.FullConsumer or consent_level= PhoneFinder_Services.Constants.ConsentLevels.SingleConsumer, 
													                              PhoneFinder_Services.Constants.ZumigoConstants.optInMethod, '');
		 EXPORT STRING3 	optinDuration        := IF(consent_level= PhoneFinder_Services.Constants.ConsentLevels.FullConsumer or 
		                                            consent_level= PhoneFinder_Services.Constants.ConsentLevels.SingleConsumer, 
													PhoneFinder_Services.Constants.ZumigoConstants.optinDuration, '');
		 EXPORT STRING 	optinId               := IF(Phones.Constants.Debug.Testing, '1', inMod.billingId);
		 EXPORT STRING 	optInVersionId        := '';
		 EXPORT STRING15 optInTimestamp       := (STRING)STD.Date.CurrentDate(TRUE)+' '+(STRING)INTFORMAT(STD.Date.CurrentTime(TRUE),6,1);	
	
		 EXPORT DATASET(Gateway.Layouts.Config) gateways := dGateways(Gateway.Configuration.IsZumigoIdentity(servicename));
   END;	
    
   Phones.Layouts.ZumigoIdentity.subjectVerificationRequest toZin(PhoneFinder_Services.Layouts.PhoneFinder.Final l) := transform

     SELF.acctno := l.acctno;
     SELF.sequence_number    := l.seq;
     SELF.phone  := l.phone;
     SELF.lexid := l.did;
     SELF.nametype := 'FULL NAME';
     SELF.first_name := l.fname;
     SELF.last_name := l.lname;
     SELF.addresstype := 'FULL ADDRESS';
     SELF.prim_range := l.prim_range;
     SELF.predir := l.predir;
     SELF.prim_name := l.prim_name;
     SELF.addr_suffix := l.suffix;
     SELF.postdir := l.postdir;
     SELF.unit_desig := l.unit_desig;
     SELF.sec_range := l.sec_range;
     SELF.p_city_name := l.city_name;
     SELF.st := l.st;
     SELF.z5 := l.zip;
     SELF.zip4 := l.zip4;
     SELF.county_name := l.county_name;
     SELF := [];

   END;

   Zum_inrecs := PROJECT(Phones_wireless, toZin(LEFT));


   EXPORT Zumigo_Hist := Phones.GetZumigoIdentity(Zum_inrecs, Zum_inMod, inMod.GLBPurpose, inMod.DPPAPurpose);

   PhoneFinder_Services.Layouts.PhoneFinder.Final toZumValidated(PhoneFinder_Services.Layouts.PhoneFinder.Final l, Phones.Layouts.ZumigoIdentity.zOut r) := TRANSFORM


     SELF.PhoneOwnershipIndicator := (r.first_name_score BETWEEN Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MIN AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX) AND 
                                     (r.last_name_score BETWEEN Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MIN AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX) AND 
                                     (r.addr_score  BETWEEN Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MIN AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX);
                               
		 Validhit                       := r.source = Phones.Constants.GatewayValues.ZumigoIdentity AND R.device_mgmt_status = '';
     SELF.CallForwardingIndicator   := IF(Validhit, PhoneFinder_Services.Functions.CallForwardingDesc(r.call_forwarding),'');
     SELF.rec_source := r.source; // for royalty count
	 SELF.imsi_changedate := r.imsi_changedate;
	 SELF.imsi_ActivationDate := r.imsi_ActivationDate;
	 SELF.iccid_changedthis_time := r.iccid_changedthis_time;
	 SELF.iccid_seensince := r.iccid_seensince;
	 SELF.imsi_changedthis_time := r.imsi_changedthis_time;
	 SELF.imsi_seensince := r.imsi_seensince;
	 SELF.imei_seensince := r.imei_seensince;
	 SELF.imei_changedate := r.imei_changedate;
	 SELF.loststolen := r.loststolen;
	 SELF.loststolen_date := r.loststolen_date;
	 SELF := l;
   END;

   EXPORT Zumigo_GLI := JOIN(dPhoneRecs, Zumigo_Hist,
                       left.acctno = right.acctno AND
											 left.seq    = right.sequence_number AND
											 left.phone  = right.submitted_phonenumber,
											 toZumValidated(left, right),
											 LEFT OUTER, KEEP(1),
											 LIMIT(0));

END;