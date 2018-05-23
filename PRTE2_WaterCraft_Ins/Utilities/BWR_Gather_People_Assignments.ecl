// PRTE2_WaterCraft_Ins.Utilities.BWR_Gather_People2_Assign_To_WC
IMPORT PRTE2_Header_Ins,PRTE2_WaterCraft_Ins,PromoteSupers,PRTE2_Common,Address;

TicketForProject := 'CT-1032';
G_PII_PerState := 10;	// need to know in order to mark gathered WC as used.

G_PII := PRTE2_WaterCraft_Ins.Utilities.Files.FakePIIGatherDS;
G_WC := PRTE2_WaterCraft_Ins.Utilities.Files.ProdGatherMainDS;
WC	  := PRTE2_WaterCraft_Ins.Datasets.All_Slim_Internal_Prod;
GathStates := SET(G_WC,st_registration);

// ***************** new layouts add IDX_State to both, and uniqueCnt to a new WC Slim we'll output.
// ***************** Group by states, 
GPIILay := {INTEGER IDX_State,RECORDOF(G_PII)};
GWCLay := { INTEGER IDX_State, RECORDOF(G_WC)};
GU_GPII := UNGROUP(PROJECT(GROUP(SORT(G_PII,st),st),TRANSFORM(GPIILay,SELF.IDX_State := COUNTER, SELF := LEFT)));
GU_GWC := UNGROUP(PROJECT(GROUP(SORT(G_WC,st_registration,HASH32(watercraft_key,Hull_number,sequence_key)
																			),st_registration
															),TRANSFORM({GWCLay},SELF.IDX_State := COUNTER, SELF := LEFT)
													)
										);
// ***************** then join them, 
// ***************** copy PII into the WC
	NewSlimInitialized	:= JOIN(GU_GPII, GU_GWC,
										LEFT.st=RIGHT.st_registration AND LEFT.idx_state=RIGHT.idx_state,
										TRANSFORM(PRTE2_WaterCraft_Ins.Layouts.BaseInput_Slim_Common, 
										SELF.did := (STRING)LEFT.did;
										SELF.xSponsor := TicketForProject;
										SELF.xAmbest := '';
										// Data folks will be filling title,fname,mname... fields, but not orig_name, so back fill this
										origNameCalc 			:= PRTE2_Common.Functions.appendIF5(LEFT.title,LEFT.fname,LEFT.mname,LEFT.lname,LEFT.name_suffix);
										SELF.orig_name 		:= origNameCalc;
										//Clean name for new records only
										// Boca build overwrites all name clean fields when it does a name clean using orig_name, but do it so base file sees it too
										cleanedName 			:= Address.CleanPersonFML73_fields(origNameCalc);
										SELF.title				:= cleanedName.title;
										SELF.fname				:= cleanedName.fname;
										SELF.mname				:= cleanedName.mname;
										SELF.lname				:= cleanedName.lname;
										SELF.name_suffix		:= cleanedName.name_suffix;
										SELF.name_cleaning_score:= cleanedName.name_score;
										SELF.dob := (STRING)LEFT.dob;
										SELF.ssn := LEFT.ssn;
										SELF.gender := '';		// no gender in BHDR
										SELF.orig_city := LEFT.p_city_name;
										SELF.orig_state := LEFT.st;
										SELF.orig_zip := LEFT.zip;
										SELF.xZip4 := LEFT.zip4;
										SELF.xDLState := '';
										SELF.xDLN := LEFT.dl_number;
										SELF.orig_ssn := LEFT.ssn;
										TmpAddr := PRTE2_Common.Functions.appendIf4(LEFT.suffix,LEFT.postdir,LEFT.unit_desig,LEFT.sec_range);
										SELF.orig_address_1 := PRTE2_Common.Functions.appendIf4(LEFT.prim_range,LEFT.predir,LEFT.prim_name,TmpAddr);
										SELF.orig_address_2 := PRTE2_Common.Functions.appendIfCSZ(LEFT.p_city_name,LEFT.st,LEFT.zip);
										cleanAddress		:= PRTE2_Common.Clean_Address.FromLine(SELF.orig_address_1, LEFT.p_city_name, LEFT.st, LEFT.zip, '');
										// Jan 2018 - decided to just leave orig_address_1 and 2 alone - keep as-is. (all orig_ fields leave as-is)
										SELF.prim_range	:=	cleanAddress.prim_range;		//string10
										SELF.predir			:=	cleanAddress.predir;				//string2
										SELF.prim_name		:=	cleanAddress.prim_name;			//string28
										SELF.suffix			:=	cleanAddress.addr_suffix;		//string4
										SELF.postdir		:=	cleanAddress.postdir;				//string2
										SELF.unit_desig	:=	cleanAddress.unit_desig;		//string10
										SELF.sec_range		:=	cleanAddress.sec_range;			//string8
										SELF.p_city_name	:=	cleanAddress.v_city_name;		//string25
										SELF.v_city_name	:=	cleanAddress.v_city_name;		//string25
										SELF.st				:=	cleanAddress.st;						//string2
										SELF.zip5			:=	cleanAddress.zip;						//string5
										SELF.zip4			:=	cleanAddress.zip4;					//string4
										SELF.cart			:=	cleanAddress.cart;					//string4
										SELF.cr_sort_sz	:=	cleanAddress.cr_sort_sz;		//string1
										SELF.lot				:=	cleanAddress.lot;						//string4
										SELF.lot_order		:=	cleanAddress.lot_order;			//string1
										SELF.dpbc			:=	cleanAddress.dbpc;					//string2
										SELF.chk_digit		:=	cleanAddress.chk_digit;			//string1
										SELF.rec_type		:=	cleanAddress.rec_type;			//string2
										SELF.ace_fips_st 	:=	cleanAddress.fips_state;		//string2
										SELF.ace_fips_county	:=	cleanAddress.fips_county;		//string3
										SELF.geo_lat 		:=	cleanAddress.geo_lat;				//string10
										SELF.geo_long 		:=	cleanAddress.geo_long;			//string11
										SELF.msa				:=	cleanAddress.msa;						//string4
										SELF.geo_blk		:=	cleanAddress.geo_blk;				//string7
										SELF.geo_match		:=	cleanAddress.geo_match;			//string1
										SELF.err_stat		:=	cleanAddress.err_stat;			//string4
										
										SELF.bdid := LEFT.bdid;
										SELF.fein := '';

								// BLANKS/MANGLES
										SELF.phone_1 := '';
										SELF.phone_2 := '';
										regok := TRIM(RIGHT.registration_number,LEFT,RIGHT)<>'';
										decalok := TRIM(RIGHT.decal_number,LEFT,RIGHT)<>'';
										SELF.registration_number := IF(regok,RIGHT.registration_number[1..3]+'I.'+RIGHT.registration_number[4..],'');
										SELF.decal_number := IF(decalok,RIGHT.decal_number[1..2]+'I.'+RIGHT.decal_number[3..],'');
										SELF.orig_fein := '';
										SELF.title_number := '';
										SELF.company_name := '';

										SELF.source_code_Main := RIGHT.source_code;
										SELF.hull_number_Main := RIGHT.hull_number;

										//TODO JAN 2018 - noticed that the DIDs in the old data aren't real - someday fix DIDs
										SELF.did_score := IF(TRIM((STRING)LEFT.did,left,right)<>'','97','');										

										SELF := LEFT; 
										SELF := [];
										));
GU_GPII;
NewSlimInitialized;

// ---------------------------------------------------------------------------------
dateString	:= PRTE2_Common.Constants.TodayString + '';
desprayName 			:= 'Watercraft_ReviewAllStateAdd_'+dateString+'.csv';
ExportDS					:= NewSlimInitialized;
lzFilePathBaseFile 	:= PRTE2_WaterCraft_Ins.Constants.SourcePathForCSV + desprayName;
LandingZoneIP 			:= PRTE2_WaterCraft_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_WaterCraft_Ins.Files.EXPORT_CSV_FILE;
PRTE2_Common.DesprayCSV(ExportDS, TempCSV, LandingZoneIP, lzFilePathBaseFile);
// ---------------------------------------------------------------------------------
// Later I need to append to base and save it.

// ***************** Save the WC as new records to the base file.
// ***************** mark the assigned WC by the uniqueCnt, then re-save gathered WC
AssignedWC_IDs := SET(GU_GWC(IDX_State<=G_PII_PerState),uniqueCnt);
markedWC := PROJECT(G_WC(uniqueCnt IN AssignedWC_IDs), TRANSFORM({G_WC},SELF.In_use := TicketForProject, SELF := LEFT));
NewG_WC := G_WC(uniqueCnt NOT IN AssignedWC_IDs) + markedWC;
OUTPUT(COUNT(G_WC));
OUTPUT(COUNT(NewG_WC));
// PromoteSupers.Mac_SF_BuildProcess(NewG_WC, Files.ProdGatherMainName, Build1,,,TRUE);
// Build1;
// ---------------------------------------------------------------------------------

