IMPORT tools, Corp2;

EXPORT Build_Bases(
  STRING																						pfiledate,
	STRING																						pversion,
	Boolean 																					pUseOtherEnvironment,
	DATASET(Corp2_Raw_ID.Layouts.vendorRawLayoutIn)		pInvendorRawFile   = Corp2_raw_ID.Files(pfiledate,pUseOtherEnvironment).Input.vendorRaw.logical,
	DATASET(Corp2_Raw_ID.Layouts.vendorRawLayoutBase)	pBasevendorRawFile = IF(_Flags.Base.vendorRaw, Corp2_Raw_ID.Files(,pUseOtherEnvironment := FALSE).Base.vendorRaw.qa, DATASET([], Corp2_Raw_ID.Layouts.vendorRawLayoutBase))) := MODULE
	
	Corp2_Raw_ID.Layouts.vendorRawLayoutBase standardize_input(Corp2_Raw_ID.Layouts.vendorRawLayoutIn L) := TRANSFORM
		
		self.action_flag				:='U';
		self.dt_first_received	:=(integer)pversion;
		self.dt_last_received		:=(integer)pversion;
		self 										:= L;
		
	end;

	// Take the ID Corp update file,stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInvendorRawFile, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBasevendorRawFile;
	combined_dist := DISTRIBUTE(combined, HASH(corp2.t2u(file_type + file_number + dup_number_indicator)));
	combined_sort := SORT(combined_dist, file_type , file_number, dup_number_indicator,RECORD,
												EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_ID.Layouts.vendorRawLayoutBase rollupBase(Corp2_Raw_ID.Layouts.vendorRawLayoutBase L,
																											Corp2_Raw_ID.Layouts.vendorRawLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	basevendorRaw := ROLLUP(combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT action_flag, dt_first_received, dt_last_received,
													LOCAL
											   );
	
	tools.mac_WriteFile(Corp2_Raw_ID.Filenames(pversion).Base.vendorRaw.New, basevendorRaw, Build_vendorRaw_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_vendorRaw_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_ID.Build_Bases attribute')
									 );

END;