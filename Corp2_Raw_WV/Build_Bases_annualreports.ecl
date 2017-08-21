 IMPORT tools, Corp2;

EXPORT Build_Bases_annualreports (
	STRING																								pfiledate,
	STRING																								pversion,	
	Boolean 																							pUseOtherEnvironment,
	DATASET(Corp2_Raw_WV.Layouts.annualreportsLayoutIn)		pInannualreports   	= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment:= FALSE).Input.annualreports.logical,
	DATASET(Corp2_Raw_WV.Layouts.annualreportsLayoutBase)	pBaseannualreports 	= IF(Corp2_Raw_WV._Flags.Base.annualreports, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.annualreports.qa, 	DATASET([], Corp2_Raw_WV.Layouts.annualreportsLayoutBase))
) := MODULE

	Corp2_Raw_WV.Layouts.annualreportsLayoutBase standardize_input(Corp2_Raw_WV.Layouts.annualreportsLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the annualreports update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInannualreports, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseannualreports;
	combined_dist := DISTRIBUTE(combined, HASH(record_did));
	combined_sort := SORT(combined_dist, record_did, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_WV.Layouts.annualreportsLayoutBase rollupBase(Corp2_Raw_WV.Layouts.annualreportsLayoutBase L,
																													Corp2_Raw_WV.Layouts.annualreportsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD, EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_WV.Filenames(pversion).Base.annualreports.New, baseactions, Build_annualreports_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_annualreports_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WV.Build_Bases_annualreports attribute')
									 );

END;
