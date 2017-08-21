IMPORT CMS_AddOn, tools, ut;

EXPORT Build_Base_Main(STRING                          pversion,
                       BOOLEAN                         pUseProd = FALSE,
                       STRING                          pFileEffectiveDate,
                       DATASET(CMS_AddOn.Layouts.Base) inBase) := MODULE;

	// Get standardized inputs.
	stdIn := CMS_AddOn.Standardize_Input_File(pversion, pFileEffectiveDate, CMS_AddOn.Files(, pUseProd).Input);

  // Transform input such that an input line with many primary codes becomes many records with a
	//   add-on code and primary code combination.
  expandedInput := CMS_AddOn.Get_Primary_Codes(stdIn);

  // Distribute input
	SHARED expandedInputDist := DISTRIBUTE(expandedInput, HASH64(AddOnCode, PrimaryCode));
	
  SHARED invalidTerminationDate := PROJECT(expandedInputDist(TerminationDateValid = FALSE),
	                                         CMS_AddOn.Layouts.Input);

	expandedInputSort := SORT(expandedInputDist(TerminationDateValid = TRUE),
	                          AddOnCode, PrimaryCode, RECORD,
														LOCAL);

  // If any duplicates are sent by the vendor, get the earliest non-zero effective date and the latest
	//   termination date that is not 99999999.  Only for records with valid termination dates.
	CMS_AddOn.Layouts.Input_Plus rollupInputDates(CMS_AddOn.Layouts.Input_Plus L,
	                                              CMS_AddOn.Layouts.Input_Plus R) := TRANSFORM
    SELF.Effective_Date   := (STRING)ut.EarliestDate((UNSIGNED)L.Effective_Date, (UNSIGNED)R.Effective_Date);
    SELF.Termination_Date := IF(L.Termination_Date = '99999999',
		                            R.Termination_Date,
															  IF(R.Termination_Date = '99999999',
															     L.Termination_Date,
																	 (STRING)ut.LatestDate((UNSIGNED)L.Termination_Date, (UNSIGNED)R.Termination_Date)));
																								 
	  SELF := L;
	END;

  SHARED finalInput := PROJECT(ROLLUP(expandedInputSort,
																		  rollupInputDates(LEFT, RIGHT),
																		  AddOnCode, PrimaryCode,
																		  LOCAL),
															 CMS_AddOn.Layouts.Input);

  // Distribute base
	inBaseDist := DISTRIBUTE(inBase, HASH64(PROC_CD_1, PROC_CD_2));

	workingAddOnUpdate := PROJECT(finalInput,
															  TRANSFORM(CMS_AddOn.Layouts.Base,
																				  SELF.PROC_CD_1                := LEFT.AddOnCode,
																				  SELF.PROC_CD_2                := LEFT.PrimaryCode,
																				  SELF.dt_vendor_first_reported := (UNSIGNED)pversion,
																				  SELF.dt_vendor_last_reported  := (UNSIGNED)pversion,

																				  SELF := LEFT,
																				  SELF := []));

  // Joining fully-processed input to base file to take care of when things are new, shared, and old.
	newAddOn := JOIN(workingAddOnUpdate, inBaseDist,
									 LEFT.PROC_CD_1 = RIGHT.PROC_CD_1 AND
										  LEFT.PROC_CD_2 = RIGHT.PROC_CD_2,
									 LEFT ONLY,
									 LOCAL);
	 
  existingAddOn := JOIN(workingAddOnUpdate, inBaseDist,
											  LEFT.PROC_CD_1 = RIGHT.PROC_CD_1 AND
													 LEFT.PROC_CD_2 = RIGHT.PROC_CD_2,
											  TRANSFORM(CMS_AddOn.Layouts.Base,
																  the_effective_date            := (STRING)ut.EarliestDate((UNSIGNED)LEFT.Effective_Date, (UNSIGNED)RIGHT.Effective_Date);
																  // Use a default date if the old effective is blank.
																  SELF.Effective_Date           := IF(RIGHT.Effective_Date = '',
																																		  '20130101',
																																		  the_effective_date),
																  SELF.Termination_Date         := IF(LEFT.Termination_Date = '99999999' AND RIGHT.Termination_Date = '99999999',
																																		  '99999999',
																																		  IF(RIGHT.Termination_Date = '99999999',
																																				 LEFT.Termination_Date,
																																				 IF(LEFT.Termination_Date = '99999999',
																																					  RIGHT.Termination_Date,
																																					  (STRING)ut.LatestDate((UNSIGNED)LEFT.Termination_Date, (UNSIGNED)RIGHT.Termination_Date)))),
																  SELF.dt_vendor_first_reported := ut.EarliestDate(LEFT.dt_vendor_first_reported, RIGHT.dt_vendor_first_reported),
																  SELF.dt_vendor_last_reported  := ut.LatestDate(LEFT.dt_vendor_last_reported, RIGHT.dt_vendor_last_reported),

																  SELF := LEFT),
											  LOCAL);

  oldAddOn := JOIN(workingAddOnUpdate, inBaseDist,
                   LEFT.PROC_CD_1 = RIGHT.PROC_CD_1 AND
									   LEFT.PROC_CD_2 = RIGHT.PROC_CD_2,
									 TRANSFORM(CMS_AddOn.Layouts.Base,
														 SELF.Effective_Date   := IF(RIGHT.Effective_Date = '',
														                             '20130101',
																												 RIGHT.Effective_Date),
														 SELF.Termination_Date := IF(RIGHT.Termination_Date IN ['', '99999999'],
														                             pFileEffectiveDate,
																												 RIGHT.Termination_Date),
														 
														 SELF := RIGHT),
									 RIGHT ONLY,
									 LOCAL);

  SHARED baseAddOn := SORT(newAddOn + existingAddOn + oldAddOn,
										       PROC_CD_1, PROC_CD_2);

	tools.mac_WriteFile(Filenames(pversion).Base.New, baseAddOn, Build_Base_File);

  // Customer needs an output file that follows their naming standard and doesn't have some fields.
	custBaseAddOn := PROJECT(baseAddOn, CMS_AddOn.Layouts.Reference_Add_On_For_Customer_base);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
	                                OUTPUT(finalInput, , '~thor_data400::persist::cms_addon::final_input', COMPRESSED, OVERWRITE),
	                                OUTPUT(invalidTerminationDate, , '~thor_data400::persist::cms_addon::invalid_termination_dates', COMPRESSED, OVERWRITE),
	                                OUTPUT(custBaseAddOn, , '~thor::base::qa::addon_codes_reference_data', COMPRESSED, OVERWRITE),
			                            Promote(pversion, pUseProd).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping CMS_AddOn.Build_Base_Main atribute'));

END;
