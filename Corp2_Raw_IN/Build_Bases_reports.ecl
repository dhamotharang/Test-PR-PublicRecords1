IMPORT tools, corp2;

EXPORT Build_Bases_reports(
	STRING																							pfiledate,
	STRING																							pversion,
	Boolean                                             pUseOtherEnvironment,
	DATASET(Corp2_Raw_IN.Layouts.CorpreportsLayoutIn)		pInreports   	= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.Corpreports.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpreportsLayoutBase)	pBasereports 	= IF(Corp2_Raw_IN._Flags.Base.Corpreports, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.Corpreports.qa, 	DATASET([], Corp2_Raw_IN.Layouts.CorpreportsLayoutBase))
) := MODULE

	Corp2_Raw_IN.Layouts.CorpreportsLayoutBase standardize_input(Corp2_Raw_IN.Layouts.CorpreportsLayoutIn L) := TRANSFORM
	
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:=   L;
		
	end;

	// Take the IN reports update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInreports, standardize_input(LEFT));
	
	// Combine Update with Previous Base.
 	combined 			:= workingUpdate + pBasereports;
  combined_dist := DISTRIBUTE(combined, HASH(Repo_Packet_Number));
  combined_sort := SORT(combined_dist, Repo_Packet_Number, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);

	
	Corp2_Raw_IN.Layouts.CorpreportsLayoutBase rollupBase(Corp2_Raw_IN.Layouts.CorpreportsLayoutBase L,
																												Corp2_Raw_IN.Layouts.CorpreportsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_IN.Filenames(pversion).Base.Corpreports.New, baseactions, Build_reports_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_reports_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IN.Build_Bases_reports attribute')
									 );

END;
