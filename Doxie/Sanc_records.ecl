import Prof_LicenseV2_Services;

export Sanc_records(dataset(doxie.layout_references) in_dids) := function
	ids := Prof_LicenseV2_Services.Prof_Lic_raw.get_sanc_ids_from_dids(in_dids);
	return doxie.ING_sanctions_report_records(set(ids,sanc_id),in_dids);
end;