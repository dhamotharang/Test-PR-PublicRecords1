IMPORT tools, corp2;

EXPORT Build_Bases_Partnership(
	STRING																					    pfiledate,
	STRING																					    pversion,
	BOOLEAN																						  puseprod,	
	DATASET(Corp2_Raw_ND.Layouts.PartnershipLayoutIn)		pInPartnership   	= Corp2_Raw_ND.Files(pfiledate,pUseProd).Input.Partnership.logical,
	DATASET(Corp2_Raw_ND.Layouts.PartnershipLayoutBase)	pBasePartnership 	= IF(Corp2_Raw_ND._Flags.Base.Partnership, Corp2_Raw_ND.Files(,pUseOtherEnvironment := FALSE).Base.Partnership.qa, 	DATASET([], Corp2_Raw_ND.Layouts.PartnershipLayoutBase))
) := MODULE

	Corp2_Raw_ND.Layouts.PartnershipLayoutBase standardize_input(Corp2_Raw_ND.Layouts.PartnershipLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the Partnership update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInPartnership, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBasePartnership;
	combined_dist := DISTRIBUTE(combined, HASH(PAID));
	combined_sort := SORT(combined_dist, PAID, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_ND.Layouts.PartnershipLayoutBase rollupBase( Corp2_Raw_ND.Layouts.PartnershipLayoutBase L,
																									       Corp2_Raw_ND.Layouts.PartnershipLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	basePartnership			 := ROLLUP(	combined_sort,
															    rollupBase(LEFT, RIGHT),
															    RECORD,
															    EXCEPT dt_last_received, dt_first_received,
															    LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_ND.Filenames(pversion).Base.Partnership.New, basePartnership, Build_Partnership_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Partnership_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_ND.Build_Bases_Partnership attribute')
									 );

END;
