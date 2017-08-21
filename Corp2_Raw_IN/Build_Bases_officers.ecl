IMPORT tools, corp2;

EXPORT Build_Bases_officers(
	STRING																							pfiledate,
	STRING																							pversion,
	Boolean                                             pUseOtherEnvironment,
	DATASET(Corp2_Raw_IN.Layouts.CorpofficersLayoutIn)	pInofficers   	= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.Corpofficers.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpofficersLayoutBase)pBaseofficers 	= IF(Corp2_Raw_IN._Flags.Base.Corpofficers, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.Corpofficers.qa, 	DATASET([], Corp2_Raw_IN.Layouts.CorpofficersLayoutBase))
) := MODULE

	Corp2_Raw_IN.Layouts.CorpofficersLayoutBase standardize_input(Corp2_Raw_IN.Layouts.CorpofficersLayoutIn L) := TRANSFORM
	
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:=   L;
		
	end;

	// Take the IN officers update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInofficers, standardize_input(LEFT));
	
	// Combine Update with Previous Base.
 	combined 			:= workingUpdate + pBaseofficers;
  combined_dist := DISTRIBUTE(combined, HASH(offi_packet_number));
  combined_sort := SORT(combined_dist, offi_packet_number, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);

	
	Corp2_Raw_IN.Layouts.CorpofficersLayoutBase rollupBase( Corp2_Raw_IN.Layouts.CorpofficersLayoutBase L,
																													Corp2_Raw_IN.Layouts.CorpofficersLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_IN.Filenames(pversion).Base.Corpofficers.New, baseactions, Build_officers_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_officers_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IN.Build_Bases_officers attribute')
									 );

END;
