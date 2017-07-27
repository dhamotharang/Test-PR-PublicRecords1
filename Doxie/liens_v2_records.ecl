import Doxie, LiensV2_Services, FCRA, ut, doxie_raw, Suppress, AutoStandardI, FFD;

// FCRA: note, default value for the flag-file is just a convenience.
//       If this attribute is called on FCRA-side, proper flag-file MUST be passed in.

export liens_v2_records (
  DATASET (doxie.layout_references) dids, 
  string1 in_party_type = '',
  boolean IsFCRA = false,
  dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
	) := FUNCTION

doxie.MAC_Header_Field_Declare(IsFCRA);

fcra_subj_only := false : stored ('ApplyNonsubjectRestrictions');
boolean isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
boolean returnByDidOnly := (fcra_subj_only OR isCollections) and isFCRA;
	
//ENTRP clean
raw_reg := LiensV2_Services.liens_raw.report_view.by_did (dids, ssn_mask_value, IsFCRA, in_party_type, application_type_value, false, slim_pc_recs, inFFDOptionsMask);

// ============ OVERRIDES (FCRA-version only) ===============
// Moved into its own function instead of having same code in multiple places
// Platform bug 62430 work around implemented in bug 60435.
raw_reg_fcra := LiensV2_Services.fn_applyFcraOverrides(raw_reg, flagfile, ssn_mask_value);

raw_res := if(isFCRA, raw_reg_fcra, raw_reg);

subject_recs := project(raw_res, 
													transform(LiensV2_Services.layout_ids, 
																		first_party := normalize(left.debtors, left.parsed_parties,
																														 transform(right))[1];
																		self.did := if(returnByDidOnly, (unsigned)dids[1].did,(unsigned)first_party.did), 
																		self.tmsid := left.tmsid,
																		self.acctno := left.acctno) );
																		
raw_res_nss := if(nonSS <> Suppress.Constants.NonSubjectSuppression.doNothing, 
									LiensV2_Services.fn_applyNonSubjectSuppression(raw_res, subject_recs, nonSS),
									raw_res);
									
// Run through amelioration process (fcra-neutral)
// ENTRP clean 
doxie_raw.MAC_ENTRP_CLEAN(raw_res_nss,orig_filing_date,raw_res_entrp);
final_res := if(ut.industryclass.is_entrp,raw_res_entrp,raw_res_nss);

RETURN if(JudgmentLienVersion in [0,2], final_res);

END;