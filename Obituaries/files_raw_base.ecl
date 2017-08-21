Import Obituaries;

EXPORT files_raw_base := MODULE

	EXPORT Tributes := dataset('~thor_data400::base::obituary_death_master',Obituaries.layouts.layout_reor_tribute,flat);

	EXPORT Obituary := DATASET('~thor_data400::base::obituarydata_death_master',Obituaries.layouts.Obituary_raw_base,flat);

END;