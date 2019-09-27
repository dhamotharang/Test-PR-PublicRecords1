IMPORT dops, dopsgrowthcheck; 

EXPORT fDOPSGrowthCheck( STRING pVersion ):= MODULE
	
	DopsDatasetName   := 'ExperianFEINKeys';
	GetDops           := dops.GetDeployedDatasets('P','B','N');
	OnlyExperian_Fein := GetDops(datasetname = DopsDatasetName);
	father_pVersion   := OnlyExperian_Fein[1].buildversion;
	Fein_current_file :='~thor_data400::key::experian_Fein::'+pVersion+'::linkids';
	Fein_father_file  :='~thor_data400::key::experian_Fein::'+father_pVersion+'::linkids';

	EXPORT GrowthCheck := SEQUENTIAL(
		DOPSGrowthCheck.CalculateStats(
			DopsDatasetName,                         // Package Name
			'experian_fein.Key_LinkIds.key',         // Key attribute
			'key_experian_fein_LinkIds',             // Nickname for identifying
			Fein_current_file,                       // Latest Key file
			'ultid,orgid,seleid,proxid,powid,empid,dotid', // Index Fields
			'source_rec_id',                         // Persistent Record ID field
			'',                                      // Persistent Email field
			'',                                      // Persistent Phone field
			'',                                      // Persistent SSN field
			'norm_tax_id',                           // Persistent FEIN field
			pVersion,                                // Latest version
			father_pVersion,                         // Previous version
			true,                                    // Flag for Publish Results in Superfile
			true                                     // Flag for Keys (true)
		),
		DOPSGrowthCheck.DeltaCommand(
			Fein_current_file,               // Latest Key file
			Fein_father_file,                // Previous Key file
			DopsDatasetName,                 // Package Name
			'key_experian_fein_LinkIds',     // Nickname for identifying
			'experian_fein.Key_LinkIds.key', // Key attribute
			'source_rec_id',                 // Persistent Record ID field
			pVersion,                        // Latest version
			father_pVersion,                 // Previous version   
			[
				'business_identification_number',
				'business_name',
				'business_address',
				'business_state',
				'business_city',
				'business_zip',
				'norm_tax_id',
				'bdid'
			],                               // Set of fields of interest for the delta
			true,                            // Flag for Publish Results in Superfile
			true                             // Flag for Keys (true)
		),
		DOPSGrowthCheck.ChangesByFieldMultiMatch (
			Fein_current_file,               // Latest Key file
			Fein_father_file,                // Previous Key file  
			DopsDatasetName,                 // Package Name
			'key_experian_fein_LinkIds',     // Nickname for identifying
			'experian_fein.Key_LinkIds.key', // Key attribute
			[
				'dt_vendor_first_reported',
				'dt_vendor_last_reported',
				'bdid',
				'prim_name',
				'addr_suffix',
				'rec_type',
				'err_stat',
				'ace_aid',
				'cart',
				'cr_sort_sz',
				' lot',
				' lot_order',
				'dbpc',
				' chk_digit',
				'geo_lat',
				' geo_long',
				' msa',
				' geo_blk',
				' geo_match',
				'prim_range',
				' predir',
				'postdir',
				' unit_desig',
				' sec_range',
				'p_city_name',
				' v_city_name',
				' st',
				' zip',
				' zip4',
				' fips_state',
				'fips_county',
				'ultid',
				'orgid',
				'seleid	',
				'proxid',
				'powid',
				'empid',
				'dotid',
				'ultscore',
				'orgscore',
				'selescore	',
				'proxscore',
				'powscore',
				'empscore',
				'dotscore',
				'ultweight',
				'orgweight',
				'seleweight',
				'proxweight',
				'powweight',
				'empweight',
				'dotweight'
			],               // matchfields
			'fp,bdid_score', // Fields to ignore
			pVersion,        // Latest version
			father_pVersion, // Previous version
			true,            // Flag for Publish Results in Superfile
			true             // Flag for Keys (true) 
		),
		DOPSGrowthCheck.PersistenceCheck(
			Fein_current_file,               // Latest Key file
			Fein_father_file,                // Previous Key file
			DopsDatasetName,                 // Package Name
			'key_experian_fein_LinkIds',     // Nickname for identifying
			'experian_fein.Key_LinkIds.key', // Key attribute
			'source_rec_id',                 // Persistent Record ID field
			[
				'dt_vendor_first_reported',
				'dt_vendor_last_reported',
				'bdid',
				' bdid_score',
				'prim_name',
				'addr_suffix',
				'	rec_type',
				'err_stat',
				'ace_aid',
				'cart',
				'cr_sort_sz',
				' lot',
				' lot_order',
				'dbpc',
				' chk_digit',
				'geo_lat',
				' geo_long',
				' msa',
				' geo_blk',
				' geo_match',
				'prim_range',
				' predir',
				'postdir',
				' unit_desig',
				' sec_range',
				'p_city_name',
				' v_city_name',
				' st',
				' zip',
				' zip4',
				' fips_state',
				'fips_county',
				'ultid',
				'orgid',
				'seleid	',
				'proxid',
				'powid',
				'empid',
				'dotid',
				'ultscore',
				'orgscore',
				'selescore	',
				'proxscore',
				'powscore',
				'empscore',
				'dotscore',
				'ultweight',
				'orgweight',
				'seleweight',
				'proxweight',
				'powweight',
				'empweight',
				'dotweight'
			],                                  // Fields making up the Persistent Rec ID
			['business_identification_number'], // Fields you want to distribute on
			pVersion,                           // Latest version
			father_pVersion,                    // Previous version
			true,                               // Flag for Publish Results in Superfile
			true                                // Flag for Keys (true)
		)
	);

END;
