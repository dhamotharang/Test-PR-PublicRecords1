import Ingenix_NatlProf, doxie, data_services;

// Provider Screening Batch Phase 2 enhancements
// Include taxids for businesses as well as people.
base_file := Ingenix_NatlProf.file_sanctions_cleaned_dided_dates(SANC_TIN<>'');

base_slim_rec := record
	base_file.SANC_TIN;
	base_file.Prov_Clean_fname;
	base_file.SANC_ID;
	base_file.SANC_BUSNME;
end;

base_slim := table(base_file, base_slim_rec);
base_ready := dedup(sort(base_slim, record), record);

export key_sanctions_taxid_name :=  
       index(base_ready, {l_taxid := (string10)SANC_TIN,
	                        l_fname := if(Prov_Clean_fname<>'',Prov_Clean_fname,SANC_BUSNME[1..20])},
											   {SANC_ID},
	           data_services.data_location.prefix() + 'thor_data400::key::ingenix_sanctions_taxid_name_' + Doxie.Version_SuperKey);