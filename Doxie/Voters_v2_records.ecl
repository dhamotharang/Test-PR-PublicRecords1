IMPORT VotersV2_Services;

EXPORT Voters_v2_Records(dataset(doxie.layout_references) in_dids, string6 ssn_mask='NONE') := function
	return VotersV2_Services.raw.report_view.by_did (in_dids, ssn_mask);
end;

