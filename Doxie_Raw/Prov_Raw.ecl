import ingenix_natlprof, doxie_files, codes,Prof_LicenseV2_Services,doxie;

export Prov_raw(
		dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
		dataset(prof_licensev2_services.Layout_Search_Ids_Prov) Prov_Ids = dataset([], prof_licensev2_services.Layout_Search_Ids_Prov))
			:= FUNCTION


d := if(exists(dids), Prof_LicenseV2_Services.Prof_Lic_raw.get_prov_ids_from_dids(dids));

provs := d + prov_ids;

ret :=doxie.ING_provider_legacy.report_records(provs);

return ret;


END;
