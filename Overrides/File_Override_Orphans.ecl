IMPORT data_services;

EXPORT File_Override_Orphans := MODULE

	EXPORT orphan_rec := RECORD
		STRING20 datagroup;
		STRING20 flag_file_ID;
		STRING12 DID;
		STRING100 recID;
	END;
    
	EXPORT orphan_file_name := '~thor_data400::lookup::override::orphans';

	EXPORT orphan_file := DATASET(orphan_file_name, orphan_rec, FLAT, OPT);

	EXPORT orphan_skip_datagroup_rec := RECORD
		STRING20 datagroup;
		BOOLEAN  skipFlag;
	END;
	
	EXPORT skip_datagroup_file_name := '~thor_data400::datagroup_lookup::override::orphans';

   EXPORT datagroup_lookup_filter_file := DATASET(skip_datagroup_file_name, orphan_skip_datagroup_rec, FLAT, OPT);

END;
