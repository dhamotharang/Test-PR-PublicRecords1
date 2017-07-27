IMPORT prof_LicenseV2_Services;


// AMS: Advantage Medical Services DATA
EXPORT _Constants(

	BOOLEAN	pUseOtherEnvironment	= FALSE

) :=
MODULE

	EXPORT autokey_buildskipset := ['S'];
	/*
		'C' -- skip person keys altogether
          'P' -- skip person phone key
		      'S' -- skip ssn key

		
		'B' -- skip business keys altogether 
      		'Q' -- skip biz phone key
		      'F' -- skip Fein key

		'-' -- build zipPrlname key
	*/

	SHARED lTemplate(STRING ptype) := _Dataset(pUseOtherEnvironment).thor_cluster_files		+ ptype + '::'	+ _Dataset().name + '::@version@::'	;

	EXPORT FileTemplate		:= lTemplate('base'	);
	EXPORT keyTemplate		:= lTemplate('key'	);
	EXPORT autokeytemplate	:= keyTemplate + 'autokey::';
	EXPORT ak_qa_keyname    := _Dataset(pUseOtherEnvironment).thor_cluster_files + 'key::ams::qa::autokey::';
	EXPORT statsTemplate		:= lTemplate('stats');


   // AMS Autokey Search variables
	EXPORT          TYPE_STR	       := 'AK';
	EXPORT BOOLEAN  WORK_HARD        := TRUE; 
	EXPORT BOOLEAN  NO_FAIL          := TRUE;
	EXPORT BOOLEAN  USE_ALL_LOOKUPS  := TRUE;
	EXPORT          AUTOKEY_NAME     := AMS._Dataset().thor_cluster_files + 'key::' + AMS._Dataset().name + '::qa::autokey::';
	EXPORT          AUTOKEY_SKIP_SET := autokey_buildskipset;  // B: Skip Biz Data
		                                                             // Q: Skip Biz Phones
																					                       // F: Skip FEIN
																				                   // C: Skip Person Contact Data
                                                                 // P: Skip Personal Phones
																					                       // S: Skip SSN

   //DO NOT USE: STRING10 LOOKUP_TYPE     := 'PROV';   // NOTE:  uncommenting this line will cause 0 autokey results.
                                                       //        this is only good for INGENIX autokey searching.

   EXPORT ACTIVE                        := 'A';
   EXPORT AMS_JOIN_LIMIT                := 5000; // this is an arbitrary - or best guess number. 
   EXPORT AMS_JOIN_LIMIT_SMAll          := 1000;
   EXPORT AMS_JOIN_TAXID_LIMIT          := 100;
   EXPORT AMS_CHILD_DATASET_LIMIT       := 10;   // keep 10 for child datasets
	 EXPORT AMS_RETURN_LIMIT              := 100;  // used mainly for taxid searches to avoid OOM errors
   EXPORT AMS_CHILD_DATASET_LIMIT_LARGE := 100;
	 EXPORT CURRENT                       := 'C';
   EXPORT PROVIDER_TO_CYSTIC_FIBROSIS_TREATMENT_CENTER := '13'; 
   EXPORT PROVIDER_TO_GROUP             := '10';
   EXPORT PROVIDER_TO_GROUP_            := '11';
   EXPORT PROVIDER_TO_HOSPITAL          := '9';
 
   EXPORT NO_TIER_TYPE_AVAILABLE        := 0;
/*
Data from Ingenix is ranked via their tierTypeId. Most of the data has this field.  AMS does not have this field,
                       so we are uisng no tier available for all AMS data.
Ingenix TierTypeID -
Tier codes:
? Tier 1  – Data values submitted to Ingenix from originating government agencies (e.g., state licensure boards,
            Centers for Medicare and Medicaid Services), or data that has been verified correct.
? Tier 2  – The same data value was received from 5 or more sources
? Tier 3  – The same data value was received from 2-4 sources
? Tier 99 – The data value was received from a single source
? Tier 0  – No tier available
*/  

   
END;