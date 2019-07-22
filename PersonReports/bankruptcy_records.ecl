// ================================================================================
// ====== RETURNS BANKRUPTCY RECORD FOR A GIVEN PERSON IN ESP-COMPLIANT WAY =======
// ================================================================================

IMPORT iesp, doxie, Doxie_Raw, BankruptcyV2_Services, fcra, suppress, FFD, PersonReports;

EXPORT bankruptcy_records (
  dataset (doxie.layout_references) dids,
  doxie.IDataAccess mod_access,
  $.IParam.bankruptcy in_params = module ($.IParam.bankruptcy) end,
  boolean IsFCRA = false,
  dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
) := MODULE


// V1 ----------------------------------------------------------------------------------------
  bk := Doxie_Raw.bk_legacy_raw (dids, , , , mod_access.ssn_mask, in_params.bk_party_type);
  // layout: doxie/Layout_BK_output_ext;
  EXPORT bankruptcy := if (IsFCRA, dataset ([], iesp.bankruptcy.t_BankruptcyReportRecord), iesp.transform_bankruptcy (bk));


// V2 ----------------------------------------------------------------------------------------
  // fetch main records
  // NB: layout of bankruptcy_raw results is not published; generally, it all comes from extended and modified
  //     bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing & layout_bankruptcy_search
  bankruptcies := BankruptcyV2_Services.bankruptcy_raw(IsFCRA).source_view (dids,in_ssn_mask := mod_access.ssn_mask,in_party_type := in_params.bk_party_type); 

  // FCRA implementation isn't there yet.
  EXPORT bankruptcy_v2 := if (IsFCRA, dataset ([], iesp.bankruptcy.t_BankruptcyReport2Record), iesp.transform_bankruptcy_v2(bankruptcies));

// V3 ----------------------------------------------------------------------------------------
  bk_v3 := doxie.bk_records_v3 (dids, mod_access.ssn_mask, in_params.bk_party_type, IsFCRA, flagfile, nonSS, slim_pc_recs, in_params.FFDOptionsMask, in_params.bk_suppress_withdrawn).format_v3;

  // only FCRA implementation exists
  EXPORT bankruptcy_v3 := if (IsFCRA, bk_v3);

END;
