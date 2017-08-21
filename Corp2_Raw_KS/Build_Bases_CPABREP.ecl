IMPORT corp2, tools;

EXPORT Build_Bases_CPABREP(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					puseprod,
	DATASET(Corp2_Raw_KS.Layouts.CPABREPLayoutIn)		pInCPABREP   = Corp2_Raw_KS.Files(pfiledate,pUseProd).Input.CPABREP.Logical,
	DATASET(Corp2_Raw_KS.Layouts.CPABREPLayoutBase)	pBaseCPABREP = IF(Corp2_Raw_KS._Flags.Base.CPABREP, Corp2_Raw_KS.Files(,pUseOtherEnvironment := FALSE).Base.CPABREP.qa, DATASET([], Corp2_Raw_KS.Layouts.CPABREPLayoutBase))
) := MODULE

	Corp2_Raw_KS.Layouts.CPABREPLayoutBase standardize_input(Corp2_Raw_KS.Layouts.CPABREPLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the KS Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCPABREP, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCPABREP;
	combined_dist := DISTRIBUTE(combined, HASH(corp_number));
	combined_sort := SORT(combined_dist, corp_number, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_KS.Layouts.CPABREPLayoutBase rollupBase(Corp2_Raw_KS.Layouts.CPABREPLayoutBase L,
																										Corp2_Raw_KS.Layouts.CPABREPLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																							 
	  SELF := L;
	END;
	
	baseCPABREP := ROLLUP(	combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_KS.Filenames(pversion).Base.CPABREP.New, baseCPABREP, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_KS.Build_Bases_CPABREP attribute')
									 );

END;