import UCCv2_Services, fcra, FFD;

#STORED('IncludeMultipleSecured', true);
#STORED('ReturnRolledDebtors', true);

export UCCv2_Services.layout_ucc_rollup
	UCC_v2_Records(dataset(doxie.layout_references) in_dids, string6 ssn_mask='NONE', string1 in_party_type = '',
  boolean IsFCRA = false,
  dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
	) := 
function
	recs := UCCv2_Services.UCCRaw.report_view.by_did (in_dids, ssn_mask, in_party_type, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
	return project(recs, UCCv2_Services.layout_ucc_rollup);
end;
