IMPORT tools, corp2;

EXPORT Build_Bases_mergers(
	STRING																							pfiledate,
	STRING																							pversion,
	Boolean                                             pUseOtherEnvironment,
	DATASET(Corp2_Raw_IN.Layouts.CorpmergersLayoutIn)		pInmergers   	= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.Corpmergers.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpmergersLayoutBase)	pBasemergers 	= IF(Corp2_Raw_IN._Flags.Base.Corpmergers, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.Corpmergers.qa, 	DATASET([], Corp2_Raw_IN.Layouts.CorpmergersLayoutBase))
) := MODULE

	Corp2_Raw_IN.Layouts.CorpmergersLayoutBase standardize_input(Corp2_Raw_IN.Layouts.CorpmergersLayoutIn L) := TRANSFORM
	
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:=   L;
		
	end;

	// Take the IN mergers update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInmergers, standardize_input(LEFT));
	
	// Combine Update with Previous Base.
 	combined 			:= workingUpdate + pBasemergers;
  combined_dist := DISTRIBUTE(combined, HASH(Merg_Non_Survivor_Packet,Merg_Survivor_Packet));
  combined_sort := SORT(combined_dist, Merg_Non_Survivor_Packet,Merg_Survivor_Packet, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_IN.Layouts.CorpmergersLayoutBase rollupBase(Corp2_Raw_IN.Layouts.CorpmergersLayoutBase L,
																												Corp2_Raw_IN.Layouts.CorpmergersLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_IN.Filenames(pversion).Base.Corpmergers.New, baseactions, Build_mergers_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_mergers_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IN.Build_Bases_mergers attribute')
									 );

END;
