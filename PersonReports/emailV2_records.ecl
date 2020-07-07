IMPORT $, doxie, EmailV2_Services, Gateway, iesp;

EXPORT emailV2_records (DATASET(doxie.layout_references) dids,
                        $.IParam.emails in_params,
                        STRING DefaultSearchTier=EmailV2_Services.Constants.Basic) := FUNCTION

    email_params := MODULE(PROJECT(in_params, EmailV2_Services.IParams.EmailParams, OPT))
      _MaxResultsPerAcct := IF(in_params.MaxEmailResults<= iesp.Constants.SMART.MaxEmails,in_params.MaxEmailResults,iesp.Constants.SMART.MaxEmails);
      EXPORT UNSIGNED MaxResultsPerAcct := IF(_MaxResultsPerAcct>0, _MaxResultsPerAcct, 5);
      EXPORT STRING  SearchType := EmailV2_Services.Constants.SearchType.EAA;
      EXPORT BOOLEAN RequireLexidMatch := TRUE;
      EXPORT BOOLEAN  IncludeAdditionalInfo := FALSE;
      EXPORT UNSIGNED1 EmailQualityRulesMask := EmailV2_Services.Constants.Defaults.EmailQualityRules;
      STRING _SearchTier := in_params.EmailSearchTier;
      SHARED STRING SearchTier := IF(EmailV2_Services.Constants.isValidTier(_SearchTier), _SearchTier, DefaultSearchTier); // defaults to Basic for all reports except Smart Linx - req. EMAIL-273
      _isBasicTier := EmailV2_Services.Constants.isBasic(SearchTier);
      EXPORT STRING   RestrictedUseCase := IF (_isBasicTier,
                                               EmailV2_Services.Constants.RestrictedUseCase.NoRoyaltySources,
                                               EmailV2_Services.Constants.RestrictedUseCase.Standard);
      EXPORT BOOLEAN  CheckEmailDeliverable := EmailV2_Services.Constants.isPremium(SearchTier);
      UNSIGNED _MaxEmailsForDeliveryCheck := EmailV2_Services.Constants.Defaults.MaxEmailsToCheckDeliverable;
      EXPORT UNSIGNED MaxEmailsForDeliveryCheck := IF(CheckEmailDeliverable, _MaxEmailsForDeliveryCheck, 0);
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
    email_recs := PROJECT(res_row.Records(~is_rejected_rec),
                          EmailV2_Services.Transforms.xform_crs_email(LEFT)
                          );

    // Now combine results for output
    res := ROW({email_recs, res_row.Royalties}, EmailV2_Services.Layouts.crs_email_combined_rec);

  // OUTPUT(_recs, NAMED('EAArecords'));

  RETURn res;
END;
