IMPORT tools, corp2;

EXPORT Build_Bases_Corporations(
	STRING																										pfiledate,
	STRING																										pversion,
	Boolean                                                   pUseOtherEnvironment,
	DATASET(Corp2_Raw_IN.Layouts.CorpCorporationsLayoutIn)		pInCorporations   	= Corp2_Raw_IN.Files(pfiledate,pUseOtherEnvironment).Input.CorpCorporations.Logical,
	DATASET(Corp2_Raw_IN.Layouts.CorpCorporationsLayoutBase)	pBaseCorporations 	= IF(Corp2_Raw_IN._Flags.Base.CorpCorporations, Corp2_Raw_IN.Files(,pUseOtherEnvironment := FALSE).Base.CorpCorporations.qa, 	DATASET([], Corp2_Raw_IN.Layouts.CorpCorporationsLayoutBase))
) := MODULE

	Corp2_Raw_IN.Layouts.CorpCorporationsLayoutBase standardize_input(Corp2_Raw_IN.Layouts.CorpCorporationsLayoutIn L) := TRANSFORM
	
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:=   L;
		
	end;

	// Take the IN Corporations update file,stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInCorporations, standardize_input(LEFT));
	
	// Combine Update with Previous Base.
 	combined 			:= workingUpdate + pBaseCorporations;
  combined_dist := DISTRIBUTE(combined, HASH(corp_packet_number));
  combined_sort := SORT(combined_dist, corp_packet_number, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);

	
	Corp2_Raw_IN.Layouts.CorpCorporationsLayoutBase rollupBase(Corp2_Raw_IN.Layouts.CorpCorporationsLayoutBase L,
																														 Corp2_Raw_IN.Layouts.CorpCorporationsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF										:= L;
		
	END;
	
	baseactions			 := ROLLUP( combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_IN.Filenames(pversion).Base.CorpCorporations.New, baseactions, Build_Corporations_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Corporations_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IN.Build_Bases_Corporations attribute')
									 );

END;
