IMPORT AID;
export Constants := MODULE

	export DEFAULT_THRESHOLD := 10;   // standard default penalty threshold
	EXPORT suffix_error_set := [AID.ACECommon.eErrStat.BadOrMissingSuffix];
	EXPORT DataPermissionMask_default  := '0000000000000';
	// The DataRestrictionMask string default below was moved from AutoStandardI.GlobalModule 
	// to here as part of the 10/06/2015 RR "pre-glb" changes in bug 183214.
	// It was previously revised so that the Experian Credit Header default value is 
	// not restricted (i.e. position 6=0), if no DataRestrictionMask value is input.
  // NOTE: Position 1 was left as "1" and positions 2-5 were left as blank to match the 
  // previous default value of "1" (which was the same as "1    " since it is a string).
	EXPORT DataRestrictionMask_default := '1    0';
	EXPORT GLBPurpose_default := 8;
		
	EXPORT STRING32 APPLICATION_TYPE_LE 	:= 'LE';
	EXPORT STRING32 APPLICATION_TYPE_GOV 	:= 'GOV';			
	EXPORT STRING32 APPLICATION_TYPE_COL  := 'COL';  //collection
	EXPORT STRING32 APPLICATION_TYPE_FCOL := 'FCOL'; //First-party collection
	EXPORT STRING32 APPLICATION_TYPE_TCOL := 'TCOL'; //Third-party collection
	EXPORT STRING32 APPLICATION_TYPE_TEST := 'TEST'; //test application type
	EXPORT STRING32 APPLICATION_TYPE_GCOL := 'GCOL'; // Government collection
	EXPORT STRING32 APPLICATION_TYPE_IRS := 'IRS'; // Government collection
	EXPORT STRING32 APPLICATION_TYPE_GELIG := 'GELIG'; // Government Eligibility

  EXPORT SET OF STRING32 COLLECTION_TYPES := [
    APPLICATION_TYPE_FCOL,
    APPLICATION_TYPE_TCOL,
    APPLICATION_TYPE_GCOL
  ];
	
	EXPORT SET OF STRING32 GOV_TYPES := [
		APPLICATION_TYPE_LE,
		APPLICATION_TYPE_GOV,
		APPLICATION_TYPE_GCOL,
		APPLICATION_TYPE_IRS,
		APPLICATION_TYPE_GELIG
	];

  EXPORT BOOLEAN   ALLOW_ALL_DEFAULT       := FALSE;
  EXPORT BOOLEAN   ALLOW_DPPA_DEFAULT      := FALSE;
  EXPORT BOOLEAN   ALLOW_GLB_DEFAULT       := FALSE;
  EXPORT UNSIGNED1 GLB_PURPOSE_DEFAULT     := GLBPurpose_default;
  EXPORT BOOLEAN   IGNORE_FARES_DEFAULT    := FALSE;
  EXPORT BOOLEAN   IGNORE_FIDELITY_DEFAULT := FALSE;
  EXPORT BOOLEAN   INCLUDE_MINORS_DEFAULT  := FALSE;
  EXPORT BOOLEAN   LNBRANDED_DEFAULT       := FALSE;
       

  EXPORT SECRANGE := MODULE
    export integer EXACT := 0;
    export integer EXACT_OR_BLANK := 1;
    export integer INCLUDES_ATOM := 2;
  END;
END;

