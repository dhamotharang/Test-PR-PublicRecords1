IMPORT tools, Corp2;

EXPORT Build_Bases_Businfo(
	STRING																								pfiledate,
	STRING																								pversion,
	Boolean 																						  pUseOtherEnvironment,
	DATASET(Corp2_Raw_UT.Layouts.BusinfoLayoutIn)					pInBusinfo   	= Corp2_Raw_UT.Files(pfiledate,pUseOtherEnvironment).Input.Businfo.Logical,
	DATASET(Corp2_Raw_UT.Layouts.BusinfoLayoutBase)				pBaseBusinfo 	= IF(Corp2_Raw_UT._Flags.Base.Businfo, Corp2_Raw_UT.Files(,pUseOtherEnvironment := FALSE).Base.Businfo.qa, 	DATASET([], Corp2_Raw_UT.Layouts.BusinfoLayoutBase))
) := MODULE

	Corp2_Raw_UT.Layouts.BusinfoLayoutBase standardize_input(Corp2_Raw_UT.Layouts.BusinfoLayoutIn L) := TRANSFORM
	
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:=   L;
		
	end;

	// Take the  Businfo update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInBusinfo, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseBusinfo;
	combined_dist := DISTRIBUTE(combined, HASH(Info_Entity_ID));
	combined_sort := SORT(combined_dist, Info_Entity_ID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_UT.Layouts.BusinfoLayoutBase rollupBase(Corp2_Raw_UT.Layouts.BusinfoLayoutBase L,
																										Corp2_Raw_UT.Layouts.BusinfoLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	baseactions	:= ROLLUP(combined_sort,
												rollupBase(LEFT, RIGHT),
												RECORD,
												EXCEPT action_flag, dt_first_received, dt_last_received,
												LOCAL);

	tools.mac_WriteFile(Corp2_Raw_UT.Filenames(pversion).Base.Businfo.New, baseactions, Build_Businfo_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Businfo_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_UT.Build_Bases_Businfo attribute')
									 );

END;
