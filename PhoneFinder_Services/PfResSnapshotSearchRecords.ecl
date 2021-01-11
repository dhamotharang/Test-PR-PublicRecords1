IMPORT iesp, doxie, dx_PhoneFinderReportDelta;

EXPORT PfResSnapshotSearchRecords (PhoneFinder_Services.Layouts.PFResSnapShotSearch dInput)  := FUNCTION
  
                                     
  //Pulling Records from the keys 
  by_companyid := JOIN(dInput.CompanyIds, dx_PhoneFinderReportDelta.Key_Transactions_CompanyId,
                       KEYED(LEFT.CompanyId = RIGHT.company_id AND 
                       (RIGHT.transaction_date = dInput.StartDate  OR (dInput.EndDate<>'' AND  RIGHT.transaction_date BETWEEN dInput.StartDate AND dInput.EndDate))),                       
                       TRANSFORM({PhoneFinder_Services.Layouts.delta_phones_rpt_transaction.transaction_id},
                       SELF := RIGHT), LIMIT(PhoneFinder_Services.Constants.PfResSnapshot.MaxRecords, FAIL(203, PhoneFinder_Services.Constants.PfResSnapshotErrorMessages.Companyid)));
  
  by_cmpid_refcode := JOIN(dInput.CompanyIds, dx_PhoneFinderReportDelta.Key_Transactions_CompanyRefCode,
                        KEYED(LEFT.CompanyId = RIGHT.company_id AND RIGHT.reference_code = dInput.ReferenceCode AND
                        (RIGHT.transaction_date = dInput.StartDate  OR (dInput.EndDate<>'' AND  RIGHT.transaction_date BETWEEN dInput.StartDate AND dInput.EndDate))),                       
                        TRANSFORM({PhoneFinder_Services.Layouts.delta_phones_rpt_transaction.transaction_id},
                        SELF := RIGHT), LIMIT(PhoneFinder_Services.Constants.PfResSnapshot.MaxRecords, FAIL(203, PhoneFinder_Services.Constants.PfResSnapshotErrorMessages.CmpId_Refrcode)));
 
  by_userid      := PROJECT(LIMIT(dx_PhoneFinderReportDelta.Key_Transactions_UserId(KEYED(user_id = dInput.UserID AND (transaction_date = dInput.StartDate  OR (dInput.EndDate<>'' AND  transaction_date BETWEEN dInput.StartDate AND dInput.EndDate)))),
                            PhoneFinder_Services.Constants.PfResSnapshot.MaxRecords, FAIL(203, PhoneFinder_Services.Constants.PfResSnapshotErrorMessages.UserId)), TRANSFORM({PhoneFinder_Services.Layouts.delta_phones_rpt_transaction.transaction_id}, SELF:=LEFT));
   
  by_refncode    := PROJECT(LIMIT(dx_PhoneFinderReportDelta.Key_Transactions_RefCode(KEYED(reference_code = dInput.ReferenceCode) AND (transaction_date = dInput.StartDate  OR (dInput.EndDate<>'' AND  transaction_date BETWEEN dInput.StartDate AND dInput.EndDate))),
                            PhoneFinder_Services.Constants.PfResSnapshot.MaxRecords, FAIL(203, PhoneFinder_Services.Constants.PfResSnapshotErrorMessages.ReferenceCode)), TRANSFORM({PhoneFinder_Services.Layouts.delta_phones_rpt_transaction.transaction_id}, SELF:=LEFT));
  
  by_phone       := PROJECT(LIMIT(dx_PhoneFinderReportDelta.Key_Transactions_Phone(KEYED(phonenumber = dInput.PhoneNumber) AND (transaction_date = dInput.StartDate  OR (dInput.EndDate<>'' AND  transaction_date BETWEEN dInput.StartDate AND dInput.EndDate))), 
                            PhoneFinder_Services.Constants.PfResSnapshot.MaxRecords, FAIL(203, PhoneFinder_Services.Constants.PfResSnapshotErrorMessages.PhoneNumber)), TRANSFORM({PhoneFinder_Services.Layouts.delta_phones_rpt_transaction.transaction_id}, SELF:=LEFT));
   
  by_lexid       := PROJECT(LIMIT(dx_PhoneFinderReportDelta.Key_Identities_LexId(KEYED(lexid = dInput.UniqueId)), 
                            PhoneFinder_Services.Constants.PfResSnapshot.MaxRecords, FAIL(203, PhoneFinder_Services.Constants.PfResSnapshotErrorMessages.LexId)), TRANSFORM({PhoneFinder_Services.Layouts.delta_phones_rpt_transaction.transaction_id}, SELF:=LEFT));
  
  SearchbyCompanyids := EXISTS(dInput.CompanyIds); 

  //Determining the search                           
  map_searchs := MAP(dInput.UniqueId <> 0      => by_lexid,
                     dInput.PhoneNumber <>'' AND dInput.StartDate <> '' => by_phone,
                     dInput.UserID    <>''   AND dInput.StartDate <> ''   => by_userid,
                     SearchbyCompanyids AND dInput.ReferenceCode<>'' AND dInput.StartDate <> '' => by_cmpid_refcode,
                     dInput.ReferenceCode <>'' AND dInput.StartDate <> '' => by_refncode,
                     SearchbyCompanyids  AND dInput.StartDate <> ''   => by_companyid                  
                     );
                                                                                                          
 iesp.phonefindertransactionsearch.t_PhoneFinderTransactionSearchRecord  t_trans ({PhoneFinder_Services.Layouts.delta_phones_rpt_transaction.transaction_id} l,
                                                                                   RECORDOF(dx_PhoneFinderReportDelta.Key_Transactions) r) := TRANSFORM
    SELF.TransactionId := r.transaction_id;
    SELF.TransactionDate := iesp.ECL2ESP.toDate((UNSIGNED)(r.transaction_date));
    SELF.UserId := r.user_id;
    SELF.ProductCode := r.product_code;
    SELF.CompanyId := r.company_Id;
    SELF.ReferenceCode := r.reference_code;
    SELF.PhoneFinderType := r.phonefinder_type;    
    SELF.PhoneFinderSearchParameters.UniqueId := (STRING)r.submitted_lexid;
    SELF.PhoneFinderSearchParameters.PhoneNumber :=r.submitted_phonenumber;
    SELF.PhoneFinderSearchParameters.Name.First := r.submitted_firstname;
    SELF.PhoneFinderSearchParameters.Name.Last := r.submitted_lastname;
    SELF.PhoneFinderSearchParameters.Name.Middle := r.submitted_middlename;
    SELF.PhoneFinderSearchParameters.Address.StreetAddress1 := r.submitted_streetaddress1;
    SELF.PhoneFinderSearchParameters.Address.City := r.submitted_city;
    SELF.PhoneFinderSearchParameters.Address.State := r.submitted_state;
    SELF.PhoneFinderSearchParameters.Address.Zip5 := r.submitted_zip;
    SELF.PrimaryPhone.PhoneNumber := r.phonenumber;
    SELF.PrimaryPhone.RiskIndicator := r.risk_indicator;
    SELF.PrimaryPhone.PhoneType := r.phone_type;
    SELF.PrimaryPhone.PhoneStatus := r.phone_status;
    SELF.PrimaryPhone.PortingCount := r.ported_count;
    SELF.PrimaryPhone.LastPortedDate := iesp.ECL2ESP.toDate((UNSIGNED)(r.last_ported_date));
    SELF.PrimaryPhone.OTPCount := r.otp_count;
    SELF.PrimaryPhone.LastOTPDate := iesp.ECL2ESP.toDate((UNSIGNED)(r.last_otp_date));
    SELF.PrimaryPhone.TotalSpoofedCount := r.spoof_count;
    SELF.PrimaryPhone.LastSpoofDate := iesp.ECL2ESP.toDate((UNSIGNED)(r.last_spoof_date));
    SELF.PrimaryPhone.PhoneForwarded := r.phone_forwarded;
    SELF.PrimaryPhone.CarrierName := r.carrier;
    SELF := [];
  END;
  
  //Joining Transaction Ids with the main Transaction Key
  dGet_trans_recs := JOIN(map_searchs, dx_PhoneFinderReportDelta.Key_Transactions,
                         KEYED(LEFT.transaction_id = RIGHT.transaction_id),
                         t_trans(LEFT, RIGHT),
                         LIMIT(0), KEEP(1));

   ds_wth_Src := RECORD
    string16 Transaction_Id;
    integer5 sequence_number;
    integer1 PhoneId;
    integer1 identity_id;
    UNSIGNED8 UniqueId;
    String Category;
    UNSIGNED2 totalsourcecount;
    BOOLEAN IsPhoneSearch;
  END;

  ds_wth_Src  t_srcs (iesp.phonefindertransactionsearch.t_PhoneFinderTransactionSearchRecord l,
                                                                                   RECORDOF(dx_PhoneFinderReportDelta.Key_Sources) r) := TRANSFORM
    SELF.transaction_id := r.transaction_id;
    SELF.sequence_number := r.sequence_number;
    SELF.PhoneId := r.Phone_Id;
    SELF.identity_id := r.identity_id;
    SELF.UniqueId := r.lexid;
    SELF.Category := r.Category;
    SELF.totalsourcecount    := (UNSIGNED)r.totalsourcecount;
    SELF.isPhoneSearch := l.PhoneFinderSearchParameters.PhoneNumber != '';
  END;

  //Joining Transaction Ids with the main Sources Key
  dGet_src_recs := JOIN(dGet_trans_recs, dx_PhoneFinderReportDelta.Key_Sources,
                         KEYED(LEFT.transactionid = RIGHT.transaction_id),
                         t_srcs(LEFT, RIGHT), LIMIT(0), KEEP(PhoneFinder_Services.Constants.PfResSnapshot.MaxSources));

 //Adding Source to Primary phone                   
 dNormSrc_Primary := DENORMALIZE(dGet_trans_recs, dGet_src_recs,
                                     LEFT.TransactionId = RIGHT.Transaction_Id  AND RIGHT.phoneid = 0 AND ~RIGHT.isPhoneSearch,
                                     GROUP,
                                     TRANSFORM(iesp.phonefindertransactionsearch.t_PhoneFinderTransactionSearchRecord,
                                     SELF.PrimaryPhone.SourceCategories := CHOOSEN(DEDUP((PROJECT(ROWS(RIGHT), TRANSFORM(iesp.share.t_StringArrayItem, SELF.Value := LEFT.Category))), ALL),iesp.constants.PfResSnapshot.MaxSrcCategories),
                                     SELF.PrimaryPhone.totalsourcecount := COUNT(ROWS(RIGHT)),
                                     SELF := LEFT), LIMIT(0));                                                                       

   InputCmpIds :=  SET(dInput.CompanyIds, Companyid);                      
 
  //Filtering the Records with additional search criteria and limiting to MaxSearchRecords
  dfiltered_recs := LIMIT(dNormSrc_Primary((~SearchbyCompanyids OR CompanyID IN InputCmpIds) AND
                           (dInput.UserID ='' OR UserID = dInput.UserID) AND 
                           (dInput.ReferenceCode =''  OR ReferenceCode = dInput.ReferenceCode) AND 
                           (dInput.PhoneNumber =''    OR PrimaryPhone.PhoneNumber = dInput.PhoneNumber) 
                           AND (dInput.StartDate= ''  OR (iesp.ECL2ESP.t_DateToString8(TransactionDate) = dInput.StartDate  OR (dInput.EndDate<>'' AND  iesp.ECL2ESP.t_DateToString8(TransactionDate) BETWEEN dInput.StartDate AND dInput.EndDate)))), 
                           PhoneFinder_Services.Constants.PfResSnapshot.MaxSearchRecords, FAIL(203, doxie.ErrorCodes(203)));
  
  //Adding Source Details to Identities                    
  identity_wth_tid_rec :=RECORD
    string16 transaction_id;
    integer5 sequence_number;
    iesp.phonefindertransactionsearch.t_PhoneIdentity;
  END;
     
   identity_wth_tid_rec  t_identity(RECORDOF(dx_PhoneFinderReportDelta.Key_Identities) r) := TRANSFORM
    SELF.transaction_id := r.transaction_id;
    SELF.sequence_number := r.sequence_number;
    SELF.UniqueId := (STRING)r.lexid;
    SELF.FullName := r.full_name;
    SELF.Address.StreetAddress1 := r.full_address;
    SELF.Address.City := r.city;
    SELF.Address.State := r.state;
    SELF.Address.Zip5 := r.zip;
    SELF.VerifiedCarrier := r.verified_carrier;
    SELF := []
   END;
     
   dGet_identity_recs := JOIN(dfiltered_recs, dx_PhoneFinderReportDelta.Key_Identities,
                              KEYED(LEFT.TransactionId = RIGHT.transaction_id) AND (dInput.UniqueId = 0 OR RIGHT.lexid = dInput.UniqueId),
                              t_identity(RIGHT),
                              LIMIT(PhoneFinder_Services.Constants.PfResSnapshot.MaxIdentities, SKIP));                    
    
    IdentityRec := RECORD
     string16 transaction_id;
     iesp.phonefindertransactionsearch.t_PhoneIdentity;
    END;
    
    dNormSrc_Identity := DENORMALIZE(dGet_identity_recs, dGet_src_recs,
                                     LEFT.Transaction_Id = RIGHT.Transaction_Id AND LEFT.sequence_number = RIGHT.identity_id AND RIGHT.isPhoneSearch,
                                     GROUP,
                                     TRANSFORM(IdentityRec,
                                     SELF.SourceCategories := CHOOSEN(DEDUP((PROJECT(ROWS(RIGHT), TRANSFORM(iesp.share.t_StringArrayItem, SELF.Value := LEFT.Category))), ALL),iesp.constants.PfResSnapshot.MaxSrcCategories),
                                     SELF.TotalSourceCount := COUNT(ROWS(RIGHT)),
                                     SELF := LEFT));
    
    otherphn_wth_tid_rec := RECORD
      string16 transaction_id;
      integer1 PhoneId;
      iesp.phonefindertransactionsearch.t_OtherPhone;
     END;
         
    otherphn_wth_tid_rec  t_otherphones(RECORDOF(dx_PhoneFinderReportDelta.Key_OtherPhones) r) := TRANSFORM
      SELF.PhoneId := r.Phone_Id;
      SELF.PhoneNumber := r.phonenumber;
      SELF.RiskIndicator := r.risk_indicator;
      SELF.PhoneType := r.phone_type;
      SELF.PhoneStatus := r.phone_status;
      SELF.ListingName := r.listing_name;
      SELF.PortingCode := r.porting_code;
      SELF.PhoneForwarded := r.phone_forwarded;
      SELF.VerifiedCarrier := r.verified_carrier;
      SELF.transaction_id := r.transaction_id;
      SELF := []
     END;
         
     dGet_otherphone_recs := JOIN(dfiltered_recs, dx_PhoneFinderReportDelta.Key_OtherPhones,
                                  KEYED(LEFT.TransactionId = RIGHT.transaction_id),
                                  t_otherphones(RIGHT),
                                  LIMIT(PhoneFinder_Services.Constants.PfResSnapshot.MaxOtherPhones, SKIP));                  
    
    
    dNormSrc_OtherPhn  := DENORMALIZE(dGet_otherphone_recs, dGet_src_recs,
                                     LEFT.Transaction_Id = RIGHT.Transaction_Id AND LEFT.phoneid = RIGHT.Phoneid AND ~RIGHT.isPhoneSearch AND RIGHT.Phoneid<>0,
                                     GROUP,
                                     TRANSFORM(otherphn_wth_tid_rec,
                                     SELF.SourceCategories := CHOOSEN(DEDUP((PROJECT(ROWS(RIGHT), TRANSFORM(iesp.share.t_StringArrayItem, SELF.Value := LEFT.Category))), ALL),iesp.constants.PfResSnapshot.MaxSrcCategories),
                                     SELF.TotalSourceCount := COUNT(ROWS(RIGHT)),
                                     SELF := LEFT));

   RIs_wth_tid_rec := RECORD
     string16 transaction_id;
     integer1 PhoneId;
     iesp.phonefindertransactionsearch.t_PhoneRiskIndicators;
   END; 
     
   RIs_wth_tid_rec tAppendRiskInd(RECORDOF(dx_PhoneFinderReportDelta.Key_RiskIndicators) r) :=
       TRANSFORM
       SELF.transaction_id := r.transaction_id,
        SELF.PhoneId := r.phone_id, 
        SELF.RiskId := r.risk_indicator_id, 
        SELF.Level := r.risk_indicator_level,
        SELF.RiskDescription := r.risk_indicator_text,
        SELF.Category := r.risk_indicator_category,
   END;
     
   dGet_primaryRIs := JOIN(dfiltered_recs, dx_PhoneFinderReportDelta.Key_RiskIndicators,
                                  KEYED(LEFT.TransactionId = RIGHT.transaction_id) and RIGHT.phone_id = 0,
                                  tAppendRiskInd(RIGHT),
                                  LIMIT(PhoneFinder_Services.Constants.PfResSnapshot.MaxRIs, SKIP));
 
   dGet_OthersRIs := JOIN(dNormSrc_OtherPhn, dx_PhoneFinderReportDelta.Key_RiskIndicators,
                          KEYED(LEFT.transaction_id = RIGHT.transaction_id) and RIGHT.phone_id = LEFT.PhoneId,
                          tAppendRiskInd(RIGHT),
                          LIMIT(PhoneFinder_Services.Constants.PfResSnapshot.MaxRIs, SKIP));                             
 
  //Denormalizing OtherPhoneRecs with OtherPhone RI's  
  dNormOtherPhones_RIs := DENORMALIZE(dNormSrc_OtherPhn, dGet_OthersRIs,
                                     LEFT.transaction_id = RIGHT.transaction_id and 
                                     LEFT.PhoneId = RIGHT.PhoneId,
                                     GROUP,
                                     TRANSFORM(otherphn_wth_tid_rec,
                                     SELF.RiskIndicators := CHOOSEN(SORT(PROJECT(ROWS(RIGHT), iesp.phonefindertransactionsearch.t_PhoneRiskIndicators), RiskId, Level, Category),iesp.Constants.PfResSnapshot.MaxRIs),
                                     SELF := LEFT));
  
  // Denormalizing Filtered Transaction Recs with Identity Recs  
  dNormIdentities := DENORMALIZE(dfiltered_recs, dNormSrc_Identity,
                                LEFT.TransactionId = RIGHT.transaction_id,
                                GROUP,
                                TRANSFORM(iesp.phonefindertransactionsearch.t_phonefindertransactionsearchrecord,
                                SELF.Identities := CHOOSEN(SORT(PROJECT(ROWS(RIGHT), iesp.phonefindertransactionsearch.t_PhoneIdentity), Uniqueid), iesp.Constants.PfResSnapshot.MaxIdentities),
                                SELF            := LEFT));
   // Denormalizing Transaction Recs and Identities with OtherPhone Recs and Other Phone RI's                           
  dNormOtherPhones := DENORMALIZE(dNormIdentities, dNormOtherPhones_RIs,
                                  LEFT.TransactionId = RIGHT.transaction_id,
                                  GROUP,
                                  TRANSFORM(iesp.phonefindertransactionsearch.t_phonefindertransactionsearchrecord,
                                  SELF.OtherPhones := CHOOSEN(SORT(PROJECT(ROWS(RIGHT),iesp.phonefindertransactionsearch.t_OtherPhone), Phonenumber), iesp.Constants.PfResSnapshot.MaxOtherPhones),
                                  SELF             := LEFT));
  //Final Denorm 
  dNormPrimaryRIs := DENORMALIZE(dNormOtherPhones, dGet_primaryRIs,
                                 LEFT.TransactionId = RIGHT.transaction_id,
                                 GROUP,
                                 TRANSFORM(iesp.phonefindertransactionsearch.t_phonefindertransactionsearchrecord,
                                 SELF.PrimaryPhone.RiskIndicators := CHOOSEN(SORT(PROJECT(ROWS(RIGHT),iesp.phonefindertransactionsearch.t_PhoneRiskIndicators), RiskId, Level, Category), iesp.Constants.PfResSnapshot.MaxRIs),
                                 SELF             := LEFT));


 final := SORT(dNormPrimaryRIs, CompanyId, TransactionDate.Year, TransactionDate.Month, TransactionDate.Day, UserId, ProductCode, ReferenceCode, TransactionId);

  return final;
  
END;
