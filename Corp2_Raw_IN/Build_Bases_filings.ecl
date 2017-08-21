IMPORT tools, corp2;

EXPORT Build_Bases_filings(
	STRING																							pfiledate,
	STRING																							pversion,
	Boolean                                             pUseOtherEnvironment,
	DATASET(Corp2_Raw_IN.Layouts.CorpfilingsLayoutIn)		pInfilings   	= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.Corpfilings.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpfilingsLayoutBase)	pBasefilings 	= IF(Corp2_Raw_IN._Flags.Base.Corpfilings, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.Corpfilings.qa, 	DATASET([], Corp2_Raw_IN.Layouts.CorpfilingsLayoutBase))
) := MODULE

	Corp2_Raw_IN.Layouts.CorpfilingsLayoutBase standardize_input(Corp2_Raw_IN.Layouts.CorpfilingsLayoutIn L) := TRANSFORM
	
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:=   L;
		
	end;

	// Take the IN filings update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInfilings, standardize_input(LEFT));
	
	// Combine Update with Previous Base.
 	combined 			:= workingUpdate + pBasefilings;
  combined_dist := DISTRIBUTE(combined, HASH(fili_packet_number));
  combined_sort := SORT(combined_dist, fili_packet_number, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);

	
	Corp2_Raw_IN.Layouts.CorpfilingsLayoutBase rollupBase(Corp2_Raw_IN.Layouts.CorpfilingsLayoutBase L,
																												Corp2_Raw_IN.Layouts.CorpfilingsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_IN.Filenames(pversion).Base.Corpfilings.New, baseactions, Build_filings_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_filings_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IN.Build_Bases_filings attribute')
									 );

END;
