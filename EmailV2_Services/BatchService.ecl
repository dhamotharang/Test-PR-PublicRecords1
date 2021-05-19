// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================

EXPORT BatchService(useCannedRecs = 'false') := MACRO

  IMPORT AutoheaderV2, BatchShare, Doxie, EmailV2_Services, Royalty, WSInput;

  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

  WSInput.MAC_EmailSearchV2_BatchService();

  ds_xml_in := DATASET([], EmailV2_Services.Layouts.batch_email_input) : STORED('batch_in', FEW);
  batch_params := EmailV2_Services.IParams.getBatchParams();

  STRING SearchTier := '' : STORED('SearchTier');
  STRING EmailValidationType := '' : STORED('EmailValidationType');

  isValidSearchType := EmailV2_Services.Constants.SearchType.isValidSearchType(batch_params.SearchType);
  isAllowedValidation := EmailV2_Services.Constants.isAllowedValidation(SearchTier, EmailValidationType);
  isEmailageRestricted := EmailV2_Services.Constants.isEmailageValidation(EmailValidationType) AND batch_params.isDirectMarketing();

  IF(isEmailageRestricted OR ~isValidSearchType OR (batch_params.CheckEmailDeliverable AND ~isAllowedValidation), FAIL(303, doxie.ErrorCodes(303)));

  BatchShare.MAC_SequenceInput(ds_xml_in, ds_batch_in);

  batch_recs := EmailV2_Services.Batch_Records(ds_batch_in, batch_params, useCannedRecs);

  BatchShare.MAC_RestoreAcctno(ds_batch_in,batch_recs.Records, ds_output,,false);
  Royalty.MAC_RestoreAcctno(ds_batch_in, batch_recs.Royalties, royalties);

  OUTPUT(ds_output, NAMED('Results'));
  OUTPUT(royalties, NAMED('RoyaltySet'));

ENDMACRO;
