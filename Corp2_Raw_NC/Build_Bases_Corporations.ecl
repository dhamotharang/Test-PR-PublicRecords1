IMPORT tools, Corp2;

EXPORT Build_Bases_Corporations(
	STRING																										pfiledate,
	STRING																										pversion,
	Boolean 																									pUseOtherEnvironment,
	DATASET(Corp2_Raw_NC.Layouts.CorporationsLayoutIn)				pInCorporations   	= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.Corporations.logical,
	DATASET(Corp2_Raw_NC.Layouts.CorporationsLayoutBase)			pBaseCorporations 	= IF(Corp2_Raw_NC._Flags.Base.Corporations, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.Corporations.qa, 	DATASET([], Corp2_Raw_NC.Layouts.CorporationsLayoutBase))
) := MODULE

	Corp2_Raw_NC.Layouts.CorporationsLayoutBase standardize_input(Corp2_Raw_NC.Layouts.CorporationsLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	//Take the  Corporations update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInCorporations, standardize_input(LEFT));

	//Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorporations;
	combined_dist := DISTRIBUTE(combined, HASH(Corp_PitemID));
	combined_sort := SORT(combined_dist, Corp_PitemID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_NC.Layouts.CorporationsLayoutBase rollupBase(Corp2_Raw_NC.Layouts.CorporationsLayoutBase L,
																												 Corp2_Raw_NC.Layouts.CorporationsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NC.Filenames(pversion).Base.Corporations.New, baseactions, Build_Corporations_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Corporations_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NC.Build_Bases_Corporations attribute')
									 );

END;
