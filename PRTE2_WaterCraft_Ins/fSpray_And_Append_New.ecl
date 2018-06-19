/********************************************************************************************************** 
	Name: 			fSpray_And_Append_New
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			This does the following:
							1. Spray the new file from the landing zone
							2. Over write the last sprayed file (while keeping old copies)
							3. Expand the file to the full layout by applying default values
							4. Append the new records to the existing full dataset
							5. Overwrite the last expanded full data file with the latest combined dataset (while keeping old copies)
							5. Delete the sprayed file (since a copy is already maintained now - Step 2)
***********************************************************************************************************/

IMPORT RoxieKeyBuild, promotesupers, ut, PRTE2_Common, Address, STD;

EXPORT fSpray_And_Append_New(STRING lzFilePath, STRING fileVersion, BOOLEAN isProdBase=TRUE) := FUNCTION
	// spray file from landing zone
	sprayFile 									:= FileServices.SprayVariable(Constants.LandingZoneIP,		 									// file landing zone
																														lzFilePath,																	// path to file on landing zone
																														8192,																				// maximum record size
																														Constants.CSVSprayFieldSeparator,	// field separator(s)
																														Constants.CSVSprayLineSeparator,		// line separator(s)
																														Constants.CSVSprayQuote,						// text quote character
																														ThorLib.Group(),													// destination THOR cluster
																														Files.SubFile.Input_New_Slim,							// destination file
																														-1,												  								// -1 means no timeout
																															,													 		 						// use default ESP server IP port
																															,																					// use default maximum connections
																														TRUE,												 								// allow overwrite
																														TRUE,												  							// replicate
																														FALSE												  							// do not compress
																														);
	
	
	New_Slim_Subfile_Upper	:= PRTE2_Common.mac_ConvertToUpperCase(	Datasets.New_Slim_Subfile , fname, mname, lname);

	PickOne(STRING s1, STRING s2) := IF(TRIM(s1,left,right)<>'',TRIM(s1),TRIM(s2));
	
	// Expand the slim dataset to include default columns
	NewSlimInitialized						:= PROJECT(New_Slim_Subfile_Upper, 
																					TRANSFORM(Layouts.BaseInput_Slim_Common, 
																										bestHullNumber 	:= PickOne(LEFT.hull_number_main, LEFT.hull_number_cg);
																										bestSourceCode 	:= PickOne(LEFT.source_code_Main, LEFT.source_code_CG);
																										bestHistoryFlag 	:= PickOne(LEFT.history_flag_Main, LEFT.history_flag_Search);
																										today 							:= PRTE2_Common.Constants.TodayString; 
																										isValidLastReport := LEFT.date_vendor_last_reported<>'' AND STD.Date.IsValidDate((UNSIGNED4) LEFT.date_vendor_last_reported);
																										bestTodayDate			:= IF(isValidLastReport, LEFT.date_vendor_last_reported, today);
																										todayLess30				:= ut.date_math(bestTodayDate,-30);
																										todayLess60				:= ut.date_math(bestTodayDate,-60);
																										todayLess50				:= ut.date_math(bestTodayDate,-50);																										
																										todayL30Plus3y		:= ut.date_add('3Y', todayLess30);
																										BestRegistrationDate := PickOne(LEFT.registration_date, todayLess30);
																										BestRegistrationExpire := PickOne(LEFT.registration_expiration_date, todayL30Plus3y);
																										SELF.orig_ssn := LEFT.ssn;
																										SELF.Watercraft_key	:= PickOne(LEFT.Watercraft_key, bestHullNumber);
																										SELF.sequence_key	:= BestRegistrationExpire;		// Data team doesn't fill this
																										SELF.history_flag_Main	:= bestHistoryFlag;
																										SELF.history_flag_Search	:= bestHistoryFlag;
																										SELF.Hull_number_main	:= bestHullNumber;
																										SELF.Hull_number_CG	:= bestHullNumber;
																										SELF.source_code_main	:= bestSourceCode;
																										SELF.source_code_CG	:= bestSourceCode;
																										SELF.source_code_Search	:= bestSourceCode;
																										SELF.date_first_seen := PickOne(LEFT.date_first_seen, todayLess60);
																										SELF.date_last_seen := PickOne(LEFT.date_last_seen, BestRegistrationDate);
																										SELF.registration_date := BestRegistrationDate;
																										SELF.registration_expiration_date := BestRegistrationExpire;
																										SELF.date_vendor_first_reported := PickOne(LEFT.date_vendor_first_reported, todayLess50);
																										SELF.date_vendor_last_reported := PickOne(LEFT.date_vendor_last_reported, bestTodayDate);
																										
																										//TODO JAN 2018 - noticed that the DIDs in the old data aren't real - someday fix DIDs
																										SELF.did_score := IF(TRIM(LEFT.did,left,right)<>'','97','');
																										
																										// Data folks will be filling title,fname,mname... fields, but not orig_name, so back fill this
																										origNameCalc1 			:= PRTE2_Common.Functions.appendIF5(LEFT.title,LEFT.fname,LEFT.mname,LEFT.lname,LEFT.name_suffix);
																										origNameCalc  			:= ut.CleanSpacesAndUpper(origNameCalc1);
																										SELF.orig_name 		:= origNameCalc;
																										//Clean name for new records only
																										// should never happen but may as well...
																										notBusinessName			:= trim(LEFT.orig_fein) = '';
																										self.company_name	:= IF(trim(LEFT.orig_fein) != '', origNameCalc,'');

																										// Boca build overwrites all name clean fields when it does a name clean using orig_name, but do it so base file sees it too
																										cleanedName 				:= Address.CleanPersonFML73_fields(origNameCalc);
																										SELF.title						:= IF(notBusinessName,cleanedName.title,'');
																										SELF.fname						:= IF(notBusinessName,cleanedName.fname,'');
																										SELF.mname						:= IF(notBusinessName,cleanedName.mname,'');
																										SELF.lname						:= IF(notBusinessName,cleanedName.lname,'');
																										SELF.name_suffix		:= IF(notBusinessName,cleanedName.name_suffix,'');
																										SELF.name_cleaning_score:= IF(notBusinessName,cleanedName.name_score,'');

																										// Data folks will be filling orig_address fields so populate the clean fields.
																										origAddressLine	:= PRTE2_Common.Functions.appendIF(LEFT.orig_address_1,LEFT.orig_address_2);
																										cleanAddress			:= PRTE2_Common.Clean_Address.FromLine(origAddressLine, LEFT.orig_city, LEFT.orig_state, LEFT.orig_zip, '');
																										// Jan 2018 - decided to just leave orig_address_1 and 2 alone - keep as-is. (all orig_ fields leave as-is)
																										SELF.prim_range			:=	cleanAddress.prim_range;		//string10
																										SELF.predir						:=	cleanAddress.predir;				//string2
																										SELF.prim_name				:=	cleanAddress.prim_name;			//string28
																										SELF.suffix						:=	cleanAddress.addr_suffix;		//string4
																										SELF.postdir					:=	cleanAddress.postdir;				//string2
																										SELF.unit_desig			:=	cleanAddress.unit_desig;		//string10
																										SELF.sec_range				:=	cleanAddress.sec_range;			//string8
																										SELF.p_city_name			:=	cleanAddress.v_city_name;		//string25
																										SELF.v_city_name			:=	cleanAddress.v_city_name;		//string25
																										SELF.st									:=	cleanAddress.st;						//string2
																										SELF.zip5							:=	cleanAddress.zip;						//string5
																										SELF.zip4							:=	cleanAddress.zip4;					//string4
																										SELF.cart							:=	cleanAddress.cart;					//string4
																										SELF.cr_sort_sz			:=	cleanAddress.cr_sort_sz;		//string1
																										SELF.lot								:=	cleanAddress.lot;						//string4
																										SELF.lot_order				:=	cleanAddress.lot_order;			//string1
																										SELF.dpbc							:=	cleanAddress.dbpc;					//string2
																										SELF.chk_digit				:=	cleanAddress.chk_digit;			//string1
																										SELF.rec_type					:=	cleanAddress.rec_type;			//string2
																										SELF.ace_fips_st 		:=	cleanAddress.fips_state;		//string2
																										SELF.ace_fips_county 	:=	cleanAddress.fips_county;		//string3
																										SELF.geo_lat 					:=	cleanAddress.geo_lat;				//string10
																										SELF.geo_long 				:=	cleanAddress.geo_long;			//string11
																										SELF.msa								:=	cleanAddress.msa;						//string4
																										SELF.geo_blk					:=	cleanAddress.geo_blk;				//string7
																										SELF.geo_match				:=	cleanAddress.geo_match;			//string1
																										SELF.err_stat					:=	cleanAddress.err_stat;			//string4
																										SELF 										:= LEFT; 
																										SELF 										:= [];));

	// ***********************************************************************************************
	// *** before we save the Boca expanded layout, save the slim (Nancy's spreadsheet) version ******
	// ***********************************************************************************************
	Exist_Slim_Internal 		:= IF(isProdBase, Datasets.All_Slim_Internal_Prod, Datasets.All_Slim_Internal);
	New_All_Slim_Internal		:= Exist_Slim_Internal + NewSlimInitialized;
	
	// ******************************************************************************************
	// *** saving the slim (Nancy's spreadsheet) version of the data ****************************
	PromoteSupers.Mac_SF_BuildProcess(New_All_Slim_Internal, Files.SuperFile.Internal_All_Slim_Name, build_internal_base,,,TRUE);

	//TODO stop building the secondary slim once I know it's not needed.
	// associate to superfile (and move older files into older generation superfiles)
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(New_All_Slim_Internal,
																			 Files.Input_Prefix, 
																		   Files.New_Slim_Suffix, 
																			 fileVersion, buildNewFileSlim, 3);
	// ******************************************************************************************
	// **** OK, now work on preparing the final Boca version of the thor base file **************
	// ******************************************************************************************
	NewDataExpanded							:= PROJECT(NewSlimInitialized, 
																					TRANSFORM(Layouts.Base, 
																										SELF.persistent_record_id := COUNTER;
																										bestHullNumber 	:= PickOne(LEFT.hull_number_main, LEFT.hull_number_cg);
																										bestSourceCode 	:= PickOne(LEFT.source_code_Main, LEFT.source_code_CG);
																										bestHistoryFlag 	:= PickOne(LEFT.history_flag_Main, LEFT.history_flag_Search);
																										SELF.Source_code  	:= bestSourceCode; 
																										SELF.history_flag 	:= bestHistoryFlag;
																										SELF.Hull_number  	:= bestHullNumber;
																										SELF 										:= LEFT; 
																										SELF 										:= [];));

	
	// ******************************************************************************************
	// combine data into a single data set	
	AllToAppend := IF(isProdBase, Datasets.All_Prod, Datasets.All_Base);
	AllDataExpanded							:= AllToAppend + NewDataExpanded;
	
	// ******************************************************************************************
	// continue building the the old Mac_SF_BuildProcess_V2 because it matches the naming Boca expects
	// associate expanded file to superfile (and move older files into older generation superfiles)
	// ******************************************************************************************
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(AllDataExpanded,
																			 Files.Base_Prefix, 
																		   Files.AllData_Suffix, 
																			 fileVersion, buildBaseFile, 3);
	
	// delete sprayed file
	deleteSpray 								:= FileServices.DeleteLogicalFile(Files.SubFile.Input_New_Slim);

	sequentialSteps 						:= SEQUENTIAL(sprayFile,
																						buildNewFileSlim,
																						build_internal_base,
																						buildBaseFile,
																						deleteSpray);
	
	RETURN sequentialSteps;
	
END;