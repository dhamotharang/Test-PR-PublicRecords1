IMPORT corp2, tools;

EXPORT Build_Bases_Officer(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						puseprod,
	DATASET(Corp2_Raw_NH.Layouts.OfficerLayoutIn)			pInOfficer   		= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.Officer.Logical,
	DATASET(Corp2_Raw_NH.Layouts.OfficerLayoutBase)		pBaseOfficer 		= IF(Corp2_Raw_NH._Flags.Base.Officer, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.Officer.qa, DATASET([], Corp2_Raw_NH.Layouts.OfficerLayoutBase))
) := MODULE

	Corp2_Raw_NH.Layouts.OfficerLayoutBase standardize_input(Corp2_Raw_NH.Layouts.OfficerLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:= 	 L;
	end;

	// Take the NM Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInOfficer, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseOfficer;
	combined_dist := DISTRIBUTE(combined, HASH(officerid));
	combined_sort := SORT(combined_dist, officerid, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_NH.Layouts.OfficerLayoutBase rollupBase(	Corp2_Raw_NH.Layouts.OfficerLayoutBase L,
																											Corp2_Raw_NH.Layouts.OfficerLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate	(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate		(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baserollup			 					:= ROLLUP(combined_sort,
																			rollupBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_NH.Filenames(pversion).Base.Officer.New, baserollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NH.Build_Bases_Officer attribute')
									 );

END;
