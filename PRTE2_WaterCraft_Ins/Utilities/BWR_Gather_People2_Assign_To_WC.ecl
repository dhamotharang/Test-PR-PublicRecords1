// PRTE2_WaterCraft_Ins.Utilities.BWR_Gather_People2_Assign_To_WC
IMPORT PRTE2_Header_Ins,PRTE2_WaterCraft_Ins,PromoteSupers;

TicketForProject := 'CT-1032';
G_PII := PRTE2_WaterCraft_Ins.Utilities.Files.FakePIIGatherDS;
G_WC := PRTE2_WaterCraft_Ins.Utilities.Files.ProdGatherMainDS;
WC	  := PRTE2_WaterCraft_Ins.Datasets.All_Slim_Internal_Prod;
GathStates := SET(G_WC,st_registration);

// new layouts add IDX_State to both, and uniqueCnt to a new WC Slim we'll output.
// Group by states, 
// create IDX_State, 
// then join them, 
// copy PII into the WC
// Save the WC as new records
// remove the gathered WC by the uniqueCnt, then save remaining gathered WC

	NewSlimInitialized	:= PROJECT(New_Slim_Subfile_Upper, 
										TRANSFORM(Layouts.BaseInput_Slim_Common, 
// *******************************************************************************************************************************
// HDR DATA:
// did,rid,phone,ssn,dob,title,fname,mname,lname,name_suffix
// prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,geo_blk,p_city_name,v_city_name,
// 		cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,geo_lat,geo_long,msa,geo_match,err_stat,
// dl_number

								// PII FIELDS:				(Assuming LEFT = HDR Data)						
										SELF.did := LEFT.did;
										SELF.title := LEFT.title;
										SELF.xSponsor := TicketForProject;
										SELF.xAmbest := '';
										SELF.fname := LEFT.fname;
										SELF.mname := LEFT.mname;
										SELF.lname := LEFT.lname;
										SELF.name_suffix := LEFT.name_suffix;
										SELF.dob := LEFT.dob;
										SELF.ssn := LEFT.ssn;
										SELF.gender := '';		// no gender in BHDR
										SELF.orig_city := LEFT.p_city_name;
										SELF.orig_state := LEFT.st;
										SELF.orig_zip := LEFT.zip;
										SELF.xZip4 := LEFT.zip4;
										SELF.xDLState := '';
										SELF.xDLN := LEFT.dl_number;
										SELF.orig_ssn := LEFT.ssn;
										SELF.name_cleaning_score := LEFT.name_cleaning_score;
										SELF.company_name := LEFT.company_name;

										SELF.orig_address_1 := ???
										SELF.orig_address_2 := ???
										SELF.prim_range := CleanAddr.prim_range;
										SELF.predir := CleanAddr.predir;
										SELF.prim_name := CleanAddr.prim_name;
										SELF.suffix := CleanAddr.suffix;
										SELF.postdir := CleanAddr.postdir;
										SELF.unit_desig := CleanAddr.unit_desig;
										SELF.sec_range := CleanAddr.sec_range;
										SELF.p_city_name := CleanAddr.p_city_name;
										SELF.v_city_name := CleanAddr.v_city_name;
										SELF.st := CleanAddr.st;
										SELF.zip5 := CleanAddr.zip5;
										SELF.zip4 := CleanAddr.zip4;
										SELF.county := CleanAddr.county;
										SELF.cart := CleanAddr.cart;
										SELF.cr_sort_sz := CleanAddr.cr_sort_sz;
										SELF.lot := CleanAddr.lot;
										SELF.lot_order := CleanAddr.lot_order;
										SELF.dpbc := CleanAddr.dpbc;
										SELF.chk_digit := CleanAddr.chk_digit;
										SELF.rec_type := CleanAddr.rec_type;
										SELF.ace_fips_st := CleanAddr.ace_fips_st;
										SELF.ace_fips_county := CleanAddr.ace_fips_county;
										SELF.geo_lat := CleanAddr.geo_lat;
										SELF.geo_long := CleanAddr.geo_long;
										SELF.msa := CleanAddr.msa;
										SELF.geo_blk := CleanAddr.geo_blk;
										SELF.geo_match := CleanAddr.geo_match;
										SELF.err_stat := CleanAddr.err_stat;
										SELF.bdid := CleanAddr.bdid;
										SELF.fein := CleanAddr.fein;
										SELF.did_score := CleanAddr.did_score;

								// BLANKS/MANGLES
										SELF.phone_1 := '';
										SELF.phone_2 := '';
										SELF.registration_number - mangle a little
										SELF.decal_number - mangle a little
										SELF.orig_fein := '';
										SELF.title_number - ??

										SELF.source_code_Main := LEFT.source_code
										SELF.hull_number_Main := LEFT.hull_number

// ********* ANY OF THIS TO KEEP???   ********************************************************************************************
											bestHullNumber 	:= PickOne(LEFT.hull_number_main, LEFT.hull_number_cg);
											bestSourceCode 	:= PickOne(LEFT.source_code_Main, LEFT.source_code_CG);
											bestHistoryFlag 	:= PickOne(LEFT.history_flag_Main, LEFT.history_flag_Search);
											today 				:= PRTE2_Common.Constants.TodayString; 
											isValidLastReport := LEFT.date_vendor_last_reported<>'' AND STD.Date.IsValidDate((UNSIGNED4) LEFT.date_vendor_last_reported);
											bestTodayDate		:= IF(isValidLastReport, LEFT.date_vendor_last_reported, today);
											todayLess30			:= ut.date_math(bestTodayDate,-30);
											todayLess60			:= ut.date_math(bestTodayDate,-60);
											todayLess50			:= ut.date_math(bestTodayDate,-50);																										
											todayL30Plus3y		:= ut.date_add('3Y', todayLess30);
											BestRegistrationDate := PickOne(LEFT.registration_date, todayLess30);
											BestRegistrationExpire := PickOne(LEFT.registration_expiration_date, todayL30Plus3y);
											
											SELF.orig_ssn 			:= LEFT.ssn;
											SELF.Watercraft_key	:= PickOne(LEFT.Watercraft_key, bestHullNumber);
											SELF.sequence_key		:= BestRegistrationExpire;		// Data team doesn't fill this
											SELF.history_flag_Main	:= bestHistoryFlag;
											SELF.history_flag_Search	:= bestHistoryFlag;
											SELF.Hull_number_main	:= bestHullNumber;
											SELF.Hull_number_CG	:= bestHullNumber;
											SELF.source_code_main	:= bestSourceCode;
											SELF.source_code_CG	:= bestSourceCode;
											SELF.source_code_Search	:= bestSourceCode;
											SELF.date_first_seen := PickOne(LEFT.date_first_seen, todayLess60);
											SELF.date_last_seen 	:= PickOne(LEFT.date_last_seen, BestRegistrationDate);
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
											notBusinessName		:= trim(LEFT.orig_fein) = '';
											self.company_name	:= IF(trim(LEFT.orig_fein) != '', origNameCalc,'');

											// Boca build overwrites all name clean fields when it does a name clean using orig_name, but do it so base file sees it too
											cleanedName 			:= Address.CleanPersonFML73_fields(origNameCalc);
											SELF.title				:= IF(notBusinessName,cleanedName.title,'');
											SELF.fname				:= IF(notBusinessName,cleanedName.fname,'');
											SELF.mname				:= IF(notBusinessName,cleanedName.mname,'');
											SELF.lname				:= IF(notBusinessName,cleanedName.lname,'');
											SELF.name_suffix		:= IF(notBusinessName,cleanedName.name_suffix,'');
											SELF.name_cleaning_score:= IF(notBusinessName,cleanedName.name_score,'');

											// Data folks will be filling orig_address fields so populate the clean fields.
											origAddressLine		:= PRTE2_Common.Functions.appendIF(LEFT.orig_address_1,LEFT.orig_address_2);
											cleanAddress			:= PRTE2_Common.Clean_Address.FromLine(origAddressLine, LEFT.orig_city, LEFT.orig_state, LEFT.orig_zip, '');
											// Jan 2018 - decided to just leave orig_address_1 and 2 alone - keep as-is. (all orig_ fields leave as-is)
											SELF.prim_range		:=	cleanAddress.prim_range;		//string10
											SELF.predir				:=	cleanAddress.predir;				//string2
											SELF.prim_name			:=	cleanAddress.prim_name;			//string28
											SELF.suffix				:=	cleanAddress.addr_suffix;		//string4
											SELF.postdir			:=	cleanAddress.postdir;				//string2
											SELF.unit_desig		:=	cleanAddress.unit_desig;		//string10
											SELF.sec_range			:=	cleanAddress.sec_range;			//string8
											SELF.p_city_name		:=	cleanAddress.v_city_name;		//string25
											SELF.v_city_name		:=	cleanAddress.v_city_name;		//string25
											SELF.st					:=	cleanAddress.st;						//string2
											SELF.zip5				:=	cleanAddress.zip;						//string5
											SELF.zip4				:=	cleanAddress.zip4;					//string4
											SELF.cart				:=	cleanAddress.cart;					//string4
											SELF.cr_sort_sz		:=	cleanAddress.cr_sort_sz;		//string1
											SELF.lot					:=	cleanAddress.lot;						//string4
											SELF.lot_order			:=	cleanAddress.lot_order;			//string1
											SELF.dpbc				:=	cleanAddress.dbpc;					//string2
											SELF.chk_digit			:=	cleanAddress.chk_digit;			//string1
											SELF.rec_type			:=	cleanAddress.rec_type;			//string2
											SELF.ace_fips_st 		:=	cleanAddress.fips_state;		//string2
											SELF.ace_fips_county :=	cleanAddress.fips_county;		//string3
											SELF.geo_lat 			:=	cleanAddress.geo_lat;				//string10
											SELF.geo_long 			:=	cleanAddress.geo_long;			//string11
											SELF.msa					:=	cleanAddress.msa;						//string4
											SELF.geo_blk			:=	cleanAddress.geo_blk;				//string7
											SELF.geo_match			:=	cleanAddress.geo_match;			//string1
											SELF.err_stat			:=	cleanAddress.err_stat;			//string4
											SELF := LEFT; 
											SELF := [];));
