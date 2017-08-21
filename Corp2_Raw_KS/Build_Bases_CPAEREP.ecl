IMPORT corp2, tools;

EXPORT Build_Bases_CPAEREP(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					puseprod,	
	DATASET(Corp2_Raw_KS.Layouts.CPAEREPLayoutIn)		pInCPAEREP   = Corp2_Raw_KS.Files(pfiledate,pUseProd).Input.CPAEREP.Logical,
	DATASET(Corp2_Raw_KS.Layouts.CPAEREPLayoutBase)	pBaseCPAEREP = IF(Corp2_Raw_KS._Flags.Base.CPAEREP, Corp2_Raw_KS.Files(,pUseOtherEnvironment := FALSE).Base.CPAEREP.qa, DATASET([], Corp2_Raw_KS.Layouts.CPAEREPLayoutBase))
) := MODULE

	Corp2_Raw_KS.Layouts.CPAEREPLayoutBase standardize_input(Corp2_Raw_KS.Layouts.CPAEREPLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the KS Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCPAEREP, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCPAEREP;
	combined_dist := DISTRIBUTE(combined, HASH(cnnumber));
	combined_sort := SORT(combined_dist, cnnumber, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_KS.Layouts.CPAEREPLayoutBase rollupBase(Corp2_Raw_KS.Layouts.CPAEREPLayoutBase L,
																										Corp2_Raw_KS.Layouts.CPAEREPLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																							 
	  SELF := L;
	END;
	
	baseCPAEREP := ROLLUP(	combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_KS.Filenames(pversion).Base.CPAEREP.New, baseCPAEREP, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_KS.Build_Bases_CPAEREP attribute')
									 );

END;