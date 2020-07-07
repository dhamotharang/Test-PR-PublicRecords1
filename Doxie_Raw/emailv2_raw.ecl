IMPORT EmailV2_Services, doxie, iesp, Royalty;

EXPORT emailv2_raw (DATASET(doxie.layout_references) dids,
                        doxie.IDataAccess modAccess) := FUNCTION


    email_params := MODULE(PROJECT(modAccess, EmailV2_Services.IParams.EmailParams, OPT))
      EXPORT UNSIGNED MaxResultsPerAcct := iesp.Constants.Email.MAX_RECS;
      EXPORT STRING  SearchType := EmailV2_Services.Constants.SearchType.EAA;
      EXPORT BOOLEAN RequireLexidMatch      := TRUE;
      EXPORT BOOLEAN KeepRawData            := TRUE;
      EXPORT BOOLEAN IncludeAdditionalInfo  := FALSE;
       STRING _SearchTier := '' : STORED('EmailSearchTier');
      SHARED STRING SearchTier := IF(EmailV2_Services.Constants.isValidTier(_SearchTier), _SearchTier, EmailV2_Services.Constants.Basic); // defaults to Basic
      _isBasicTier := EmailV2_Services.Constants.isBasic(SearchTier);
      EXPORT STRING   RestrictedUseCase := IF (_isBasicTier,
                                               EmailV2_Services.Constants.RestrictedUseCase.NoRoyaltySources,
                                               EmailV2_Services.Constants.RestrictedUseCase.Standard);
   END;

    ds_in := PROJECT(dids, TRANSFORM(EmailV2_Services.Layouts.batch_in_rec,
                                     SELF.did := LEFT.did,
                                     SELF.acctno := EmailV2_Services.Constants.Defaults.SingleSearchAccountNo,
                                     SELF:=[]));

    eaa_recs := EmailV2_Services.EmailAddressAppendSearch(ds_in, email_params).Records;

     // final transform for records
    email_recs := CHOOSEN(PROJECT(eaa_recs(~is_rejected_rec),
                          EmailV2_Services.Transforms.xform_crs_raw(LEFT)
                         ), iesp.Constants.Email.MAX_RECS);


  // OUTPUT(eaa_recs, NAMED('EAArecords'));

  RETURN email_recs;
END;
