IMPORT tools, corp2;

EXPORT Build_Bases_Corporations(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                             	pUseProd,              
	DATASET(Corp2_Raw_PA.Layouts.CorporationsLayoutIn)		pInCorporations   	= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.CorporationsPipeDelim,
	DATASET(Corp2_Raw_PA.Layouts.CorporationsLayoutBase)	pBaseCorporations 	= IF(Corp2_Raw_PA._Flags.Base.Corporations, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Corporations.qa, 	DATASET([], Corp2_Raw_PA.Layouts.CorporationsLayoutBase))
) := MODULE

	Corp2_Raw_PA.Layouts.CorporationsLayoutBase standardize_input(Corp2_Raw_PA.Layouts.CorporationsLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the PA Corporations update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorporations, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseCorporations;
	combined_dist := DISTRIBUTE(combined, HASH(corporationid));
	combined_sort := SORT(combined_dist, corporationid, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_PA.Layouts.CorporationsLayoutBase rollupBase(	Corp2_Raw_PA.Layouts.CorporationsLayoutBase L,
																											    Corp2_Raw_PA.Layouts.CorporationsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseCorporations			 := ROLLUP( combined_sort,
															      rollupBase(LEFT, RIGHT),
															      RECORD,
															      EXCEPT dt_last_received, dt_first_received,
															      LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_PA.Filenames(pversion).Base.Corporations.New, baseCorporations, Build_Corporations_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Corporations_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_PA.Build_Bases_Corporations attribute')
									 );

END;
