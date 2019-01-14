IMPORT Gateway, Phones, PhoneFinder_Services, STD, ut;
EXPORT GetZumigoIdentity_Records(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.Final)  dPhoneRecs,
                                 DATASET(PhoneFinder_Services.Layouts.BatchInAppendDID) dInBestInfo,
                                 PhoneFinder_Services.iParam.ReportParams         inMod,
                                 DATASET(Gateway.Layouts.Config) dGateways) := 

MODULE
   
   SHARED Ph_wireless := dPhoneRecs(phone <> '' AND typeflag != Phones.Constants.TypeFlag.DataSource_PV AND COC_description = PhoneFinder_Services.Constants.PhoneType.Wireless);

   // for phone search, we are sending upto 10 different identities per acct, by picking recent ones.
   Ph_wireless_ddp := DEDUP(SORT(Ph_wireless, acctno, phone, fname, lname, prim_range, prim_name, city_name, st, zip), acctno, phone, fname, lname, prim_range, prim_name, city_name, st, zip);
   SHARED PhoneSrch_wireless := TOPN(GROUP(SORT(Ph_wireless_ddp(phone = batch_in.homephone), acctno,  -dt_last_seen, dt_first_seen, seq), acctno), 10, acctno);
                                  
  
  // for pii search, sending in one primary wireless phone , if available, else one other phone per acct
  // sorting other phones(non primary) by score and dates 
    
   PII_wireless_pre := DEDUP(SORT(Ph_wireless(batch_in.homephone = ''), acctno, IF(isprimaryphone, 0, 1), -phone_score, -dt_last_seen, dt_first_seen), acctno);
     
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
   
   PII_wireless := JOIN(PII_wireless_pre, dInBestInfo, LEFT.acctno = RIGHT.acctno, in_addr(LEFT,RIGHT),LIMIT(0), KEEP(1));

   Phones_wireless := PII_wireless + PhoneSrch_wireless;
   

   Phones.Layouts.ZumigoIdentity.subjectVerificationRequest toZin(PhoneFinder_Services.Layouts.PhoneFinder.Final l) := TRANSFORM

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

   SHARED Zum_inrecs := PROJECT(Phones_wireless, toZin(LEFT));
  
   
   SHARED Zum_inMod := MODULE(Phones.IParam.inZumigoParams)
     EXPORT STRING20  Usecase             := PhoneFinder_Services.Constants.ZumigoConstants.Usecase;
     EXPORT STRING3   productCode         := PhoneFinder_Services.Constants.ZumigoConstants.productCode;
     EXPORT STRING8   billingId           := inMod.billingId;
     EXPORT STRING20 productName          := PhoneFinder_Services.Constants.ZumigoConstants.productName;
     
     EXPORT BOOLEAN NameAddressValidation := inMod.IncludeNameAddressValidation;
     EXPORT BOOLEAN NameAddressInfo       := EXISTS(PhoneSrch_wireless) AND inMod.IncludeNameAddressInfo;
     EXPORT BOOLEAN AccountInfo           := FALSE;
     EXPORT BOOLEAN CallHandlingInfo      := inMod.IncludeCallHandlingInfo;
     EXPORT BOOLEAN DeviceInfo            := inMod.IncludeDeviceInfo;  
     EXPORT BOOLEAN DeviceHistory         := inMod.IncludeDeviceHistory;
     EXPORT BOOLEAN DeviceChangeOption    := inMod.IncludeDeviceChangeInfo;
     EXPORT STRING10 optInType            := PhoneFinder_Services.Constants.ZumigoConstants.optInType;
     EXPORT STRING5  optInMethod         := PhoneFinder_Services.Constants.ZumigoConstants.optInMethod;
     EXPORT STRING3  optinDuration       := PhoneFinder_Services.Constants.ZumigoConstants.optinDuration;
     EXPORT STRING   optinId               := IF(Phones.Constants.Debug.Testing, '1', inMod.billingId);
     EXPORT STRING   optInVersionId        := '';
     EXPORT STRING15 optInTimestamp       := (STRING)STD.Date.CurrentDate(TRUE)+' '+(STRING)INTFORMAT(STD.Date.CurrentTime(TRUE),6,1);  
  
     EXPORT DATASET(Gateway.Layouts.Config) gateways := dGateways(Gateway.Configuration.IsZumigoIdentity(servicename));
   END; 
    

   Zumigo_Response := Phones.GetZumigoIdentity(Zum_inrecs, Zum_inMod, inMod.GLBPurpose, inMod.DPPAPurpose,,,,FALSE,FALSE);
   // getting zumigo error-free response
   EXPORT Zumigo_Hist := Zumigo_Response(source = Phones.Constants.GatewayValues.ZumigoIdentity AND device_mgmt_status = ''); 
   SHARED today := STD.Date.Today();
   // identity resolved from zumigo nameaddrinfo option & not resolved in PF search logic
   Zum_PhoneOwner := JOIN(dPhoneRecs, DEDUP(SORT(Zumigo_Hist,acctno),acctno),
                           LEFT.DID = RIGHT.LEXID,
                           TRANSFORM(Phones.Layouts.ZumigoIdentity.zOut, SELF := RIGHT),
                           RIGHT ONLY);
    
   
   PhoneFinder_Services.Layouts.PhoneFinder.Final  addZum(Phones.Layouts.ZumigoIdentity.zOut l) :=    TRANSFORM
  
      SELF.acctno := l.acctno;
      SELF.phone := l.submitted_phonenumber;
      SELF.did := l.lexid;
      SELF.fname := l.first_name;
      SELF.mname := l.middle_name;
      SELF.lname := l.last_name;
      SELF.prim_range  :=l.prim_range;
      SELF.predir      :=l.predir;
      SELF.prim_name   :=l.prim_name;
      SELF.suffix :=l.addr_suffix;
      SELF.postdir     :=l.postdir;
      SELF.unit_desig  :=l.unit_desig;
      SELF.sec_range   :=l.sec_range;
      SELF.city_name        :=l.city;
      SELF.st       :=l.state;
      SELF.zip         :=l.zip;
      SELF.PhoneOwnershipIndicator := TRUE; // identity returned from gateway is verified
      SELF.dt_first_seen := ut.date_math((STRING)today,-PhoneFinder_Services.Constants.ZumigoConstants.IdentityDateThreshold);
      SELF.dt_last_seen := (STRING)today;
      SELF.CallForwardingIndicator   := IF(Zum_inMod.CallHandlingInfo, 
                                       PhoneFinder_Services.Functions.CallForwardingDesc(l.call_forwarding),''); //get call forwarded value only when CallHandlingInfo is selected
      SELF.rec_source    := l.source;
      SELF.batch_in.acctno    := l.acctno;
      SELF.batch_in.homephone    := l.submitted_phonenumber;    // inputted acct and phone
      
      SELF := [];
  
   END;
    
  SHARED ZumIdentified_Owners := IF(Zum_inMod.NameAddressInfo, PROJECT(Zum_PhoneOwner, addZum(LEFT)));


   PhoneFinder_Services.Layouts.PhoneFinder.Final toZumValidated(PhoneFinder_Services.Layouts.PhoneFinder.Final l, Phones.Layouts.ZumigoIdentity.zOut r) := TRANSFORM

 
   SELF.CallForwardingIndicator   := IF(Zum_inMod.CallHandlingInfo AND r.acctno <>'', PhoneFinder_Services.Functions.CallForwardingDesc(r.call_forwarding),''); //get call forwarded value only when CallHandlingInfo is selected and a right record exists
   SELF.rec_source := r.source; // for royalty count
   SELF.imsi_changedate := r.imsi_changedate;
   SELF.imsi_ActivationDate := r.imsi_ActivationDate;
   SELF.iccid_changedthis_time := r.iccid_changedthis_time;
   SELF.iccid_seensince := r.iccid_seensince;
   SELF.imsi_changedthis_time := r.imsi_changedthis_time;
   SELF.imei_changedthis_time := r.imei_changed_this_time;
   SELF.imsi_seensince := r.imsi_seensince;
   SELF.imei_seensince := r.imei_seensince;
   SELF.imei_changedate := r.imei_changedate;
   SELF.loststolen := r.loststolen;
   SELF.loststolen_date := r.loststolen_date;
   
   NameAddrInfo_InputMatchedRec := Zum_inMod.NameAddressInfo AND l.did > 0 AND r.lexid > 0 AND l.did = r.lexid; // validating the record when zumigo resolved identity matched with pf resolved identity
   SELF.dt_last_seen := IF(NameAddrInfo_InputMatchedRec,(STRING)today, l.dt_last_seen);
    Isvalidated      := (r.first_name_score BETWEEN Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MIN AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX) AND 
                        (r.last_name_score BETWEEN Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MIN AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX) AND 
                        (r.addr_score  BETWEEN Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MIN AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX);
    
    SELF.PhoneOwnershipIndicator := NameAddrInfo_InputMatchedRec OR Isvalidated;
    SELF := l;
   END;

   PFIdentified_Owners := JOIN(dPhoneRecs, Zumigo_Hist,
                       LEFT.acctno = RIGHT.acctno AND
                       LEFT.seq    = RIGHT.sequence_number AND
                       LEFT.phone  = RIGHT.submitted_phonenumber,
                       toZumValidated(LEFT, RIGHT),
                       LEFT OUTER, KEEP(1),
                       LIMIT(0));              
	 
   Zumigo_GLI_Combined := PROJECT(GROUP(SORT(PFIdentified_Owners + ZumIdentified_Owners,acctno), acctno), TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.Final,
                                                                          SELF.seq := COUNTER,
                                                                          SELF := LEFT));                    

  
  EXPORT Zumigo_GLI := UNGROUP(Zumigo_GLI_Combined);
END;
