IMPORT tools, Corp2;

EXPORT Build_Bases_Entities(
	STRING																				pfiledate,
	STRING																				pversion,
	BOOLEAN                                       pUseOtherEnvironment,
	DATASET(Corp2_Raw_RI.Layouts.EntitiesIn)			pInEntities   	= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Entities.logical,
	DATASET(Corp2_Raw_RI.Layouts.EntitiesBase)		pBaseEntities 	= IF(Corp2_Raw_RI._Flags.Base.Entities, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Entities.qa, 	DATASET([], Corp2_Raw_RI.Layouts.EntitiesBase))
) := MODULE

	Corp2_Raw_RI.Layouts.EntitiesBase standardize_input(Corp2_Raw_RI.Layouts.EntitiesIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	end;

	// Take the Entities update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInEntities, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseEntities;
	combined_dist := DISTRIBUTE(combined, HASH(Entity_id));
	combined_sort := SORT(combined_dist, Entity_id, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_RI.Layouts.EntitiesBase rollupBase(Corp2_Raw_RI.Layouts.EntitiesBase L  ,Corp2_Raw_RI.Layouts.EntitiesBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_RI.Filenames(pversion).Base.Entities.New, baseactions, Build_Entities_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Entities_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_RI.Build_Bases_Entities attribute')
									 );

END;
