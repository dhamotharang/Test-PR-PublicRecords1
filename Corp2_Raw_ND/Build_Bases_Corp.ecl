IMPORT tools, corp2;

EXPORT Build_Bases_Corp(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					puseprod,	
	DATASET(Corp2_Raw_ND.Layouts.CorpLayoutIn)			pInCorp1   	= Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.Corp1.logical,
	DATASET(Corp2_Raw_ND.Layouts.CorpLayoutIn)			pInCorp2   	= Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.Corp2.logical,
	DATASET(Corp2_Raw_ND.Layouts.CorpLayoutBase)		pBaseCorp 	= IF(Corp2_Raw_ND._Flags.Base.Corp, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.Corp.qa, 	DATASET([], Corp2_Raw_ND.Layouts.CorpLayoutBase))
) := MODULE

	Corp2_Raw_ND.Layouts.CorpLayoutBase standardize_input(Corp2_Raw_ND.Layouts.CorpLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the Corp1 & Corp2 update files, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorp1 + pInCorp2, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseCorp;
	combined_dist := DISTRIBUTE(combined, HASH(CBSID));
	combined_sort := SORT(combined_dist, CBSID, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_ND.Layouts.CorpLayoutBase rollupBase( Corp2_Raw_ND.Layouts.CorpLayoutBase L,
																									Corp2_Raw_ND.Layouts.CorpLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseCorp			 := ROLLUP(	combined_sort,
														rollupBase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_last_received, dt_first_received,
														LOCAL);

	tools.mac_WriteFile(Corp2_Raw_ND.Filenames(pversion).Base.Corp.New, baseCorp, Build_Corp_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Corp_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_ND.Build_Bases_Corp attribute')
									 );

END;
