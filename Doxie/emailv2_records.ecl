IMPORT EmailV2_Services, Gateway, iesp, Royalty;

EXPORT emailv2_records (DATASET(doxie.layout_references) dids,
                        doxie.IDataAccess modAccess,
                        BOOLEAN _keepRaw = FALSE,
                        STRING default_SearchTier = EmailV2_Services.Constants.Basic) := FUNCTION

    email_params := MODULE(PROJECT(modAccess, EmailV2_Services.IParams.EmailParams, OPT))
      _MaxResultsPerAcct := 5 : STORED('MaxEmailResults');
      EXPORT UNSIGNED MaxResultsPerAcct := _MaxResultsPerAcct;
      EXPORT STRING  SearchType := EmailV2_Services.Constants.SearchType.EAA;
      EXPORT BOOLEAN IncludeHistoricData := FALSE;
      EXPORT BOOLEAN RequireLexidMatch := TRUE;
      EXPORT UNSIGNED1 EmailQualityRulesMask := EmailV2_Services.Constants.Defaults.EmailQualityRules;
      STRING _SearchTier := '' : STORED('EmailSearchTier');
      SHARED STRING SearchTier := IF(EmailV2_Services.Constants.isValidTier(_SearchTier), _SearchTier, default_SearchTier); // defaults to default_SearchTier
      _isBasicTier := EmailV2_Services.Constants.isBasic(SearchTier);
      EXPORT STRING   RestrictedUseCase := IF (_isBasicTier,
                                               EmailV2_Services.Constants.RestrictedUseCase.NoRoyaltySources,
                                               EmailV2_Services.Constants.RestrictedUseCase.Standard);
      EXPORT BOOLEAN  KeepRawData           := _keepRaw;
      EXPORT BOOLEAN  IncludeAdditionalInfo := FALSE;
      _isPremiumTier := EmailV2_Services.Constants.isPremium(SearchTier);
      EXPORT BOOLEAN  CheckEmailDeliverable := _isPremiumTier;
      UNSIGNED _MaxEmailsForDeliveryCheck := EmailV2_Services.Constants.Defaults.MaxEmailsToCheckDeliverable;
      EXPORT UNSIGNED MaxEmailsForDeliveryCheck := IF(CheckEmailDeliverable, _MaxEmailsForDeliveryCheck, 0);
      EXPORT BOOLEAN  KeepUndeliverableEmail := FALSE;
      EXPORT STRING   BVAPIkey := IF(CheckEmailDeliverable, EmailV2_Services.Constants.GatewayValues.BVAPIkey, '');
      EXPORT BOOLEAN  UseTMXRules := TRUE;
      EXPORT UNSIGNED MaxEmailsForTMXCheck := EmailV2_Services.Constants.Defaults.MaxEmailsForTMXcheck;
      EXPORT BOOLEAN SuppressTMXRejectedEmail := UseTMXRules;
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    END;

    ds_in := PROJECT(dids, TRANSFORM(EmailV2_Services.Layouts.batch_in_rec,
                                     SELF.did := LEFT.did,
                                     SELF.acctno := EmailV2_Services.Constants.Defaults.SingleSearchAccountNo,
                                     SELF:=[]));

    eaa_row := EmailV2_Services.EmailAddressAppendSearch(ds_in, email_params);
    res_row := EmailV2_Services.Functions.CalculateRoyalties(eaa_row);

     // final transform for records
    email_recs := CHOOSEN(PROJECT(res_row.Records(~is_rejected_rec),
                          EmailV2_Services.Transforms.xform_crs_email(LEFT)
                         ), iesp.Constants.Email.MAX_RECS);

    // Now combine results for output
    res := ROW({email_recs, res_row.Royalties}, EmailV2_Services.Layouts.crs_email_combined_rec);

  // OUTPUT(_recs, NAMED('EAArecords'));

  RETURn res;
END;
