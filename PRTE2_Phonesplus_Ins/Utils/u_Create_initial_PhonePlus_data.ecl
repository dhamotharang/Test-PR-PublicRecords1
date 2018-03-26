//***********************************************************************
// PRTE2_Phonesplus_Ins.u_Create_initial_PhonePlus_data
// Create initial data for PhonePlus
//***********************************************************************
IMPORT PRTE2_Phonesplus_Ins, PRTE2_Header_Ins, PRTE2_X_DataCleanse, PRTE_CSV, Address, PRTE2_Common,ut;
#workunit('name', 'Boca PRCT PhonesPlus Create initial data');

Layouts := PRTE2_Phonesplus_Ins.Layouts;
Files   := PRTE2_Phonesplus_Ins.Files;
u_Files   := PRTE2_Phonesplus_Ins.u_Files;

appendIf(STRING s1, STRING s2) := TRIM(IF(s1='', s2, TRIM(s1)+' '+TRIM(s2) ));
appendIf3(STRING s1, STRING s2, STRING s3) := appendIf(appendIf(s1,s2),s3);
appendIf4(STRING s1, STRING s2, STRING s3, STRING s4) := appendIf(appendIf3(s1,s2,s3),s4);
appendIf5(STRING s1, STRING s2, STRING s3, STRING s4, STRING s5) := appendIf(appendIf4(s1,s2,s3,s4),s5);

// Phase 1 - stick our MHDR header data DIDs into the Base PhonePlus empty layout creating x records. 

PhonesPlus_Layout := Layouts.Alpha_CSV_Layout;
PhonesPlus_DS 		:= Files.PhonesPlus_Base_SF_DS;
OUTPUT(PhonesPlus_DS, NAMED('PhonesPlus_DS'));
OUTPUT(COUNT(PhonesPlus_DS), NAMED('Count__PhonesPlus_DS'));

//---------------- Isolate Clean MHDR that have no duplicates did -----------------------------------

MHDR_Layout := PRTE2_X_Ins_DataCleanse.Layouts.Layout_Merged_IHDR_BHDR;
Dirty_MHDR := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_DS((INTEGER)addr_ind=1);

MHDR_dup_stat := RECORD
	string dup_stat;
	integer did;
END;
MHDR_dup_stat tr_add_status(MHDR_Layout L) := TRANSFORM
	SELF.dup_stat := '';
	SELF.did := L.did;
END;
MHDR_dup_statDS := PROJECT(Dirty_MHDR, tr_add_status(LEFT));

MHDR_dup_stat tr_dd_MHDR(MHDR_dup_stat L, MHDR_dup_stat R) := TRANSFORM
	SELF.dup_stat := IF(R.did = L.did, 'd','s');
	SELF.did := R.did;
END;
MHDR_dup_stat_info_DS := ITERATE(SORT(MHDR_dup_statDS, did), tr_dd_MHDR(LEFT, RIGHT));

Dirty_did_MHDR_DS := MHDR_dup_stat_info_DS(dup_stat = 'd');
Dirty_unique_did_MHDR_DS := DEDUP(SORT(Dirty_did_MHDR_DS,did));
Dirty_did_MHDR_set := set(Dirty_unique_did_MHDR_DS,did);

Only_Dirty_MHDR := Dirty_MHDR(did IN Dirty_did_MHDR_set);
MHDR := Dirty_MHDR(did NOT IN Dirty_did_MHDR_set);
//----------------- Clean MHDR created as MHDR -------------------------------------
OUTPUT(Only_Dirty_MHDR, NAMED('Only_Dirty_MHDR'));
OUTPUT(MHDR, NAMED('MHDR'));

// marge mising required records from MHDR to PhonePlus
VAL_HD	:= 37.66298241488333;
VAL_PC	:= VAL_HD + 31.94585978939667;
VAL_GH	:= VAL_PC + 12.4585195056309;
VAL_1 	:= VAL_GH + 8.024352642993389;
VAL_WP	:= VAL_1  + 4.517781087507513;
VAL_2 	:= VAL_WP + 2.863787201797706;
VAL_IN	:= VAL_2 	+ 2.50842674610018;
VAL_5 	:= VAL_IN + 0.01829061169031381;

PhonesPlus_Layout AddHederData(RECORDOF(MHDR) L) := TRANSFORM
	address1 := 	Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name, L.suffix, L.postdir, L.unit_desig, L.sec_range);
	cleanAddress	:= PRTE2_Common.Clean_Address.FromLine(address1, L.city_name, L.st, L.zip, L.zip4);
	boolean replaceClean			:= cleanAddress.err_stat[1] <> 'E';
	// -- populate problem fields ---------------------------------------------------------
	SELF.confidencescore	:= (( RANDOM() / 0xFFFFFFFF ) * 98 ) +1;				//unsigned integer2
	RV := ( RANDOM()  / 0xFFFFFFFF ) * VAL_5;
	SELF.vendor 					:= MAP(	RV<VAL_HD => 'HD',
																RV<VAL_PC => 'PC',
																RV<VAL_GH => 'GH',
																RV<VAL_1  => '1',
																RV<VAL_WP => 'WP',
																RV<VAL_2 => '2',
																RV<VAL_IN => 'IN',
																'5');									// string2
	// -- populate problem fields ---------------------------------------------------------
	SELF.l_did						:=	L.did;										//unsigned integer6
	// SELF.datevendorfirstreported := L.datevendorfirstreported;								//unsigned integer3
	// SELF.datevendorlastreported := L.datevendorlastreported;									//unsigned integer3
	SELF.datefirstseen 		:=	L.dt_first_seen;					//unsigned integer3
	SELF.datelastseen 		:=	L.dt_last_seen;						//unsigned integer3
	//SELF.dt_nonglb_last_seen := 0;										//unsigned integer3
	//SELF.glb_dppa_flag := '';													//string1
	//SELF.activeflag := '';														//string1
	//SELF.cellphoneidkey := '';												//string32
	//SELF.recordkey := '';															//string60
	//SELF.stateorigin := '';														//string2
	//SELF.sourcefile := '';														//string20
	//SELF.src := '';																		//string2
	SELF.origname 				:=	appendIf3(L.fname,L.mname,L.lname);													//string90
	SELF.nameformat 			:=	'F';											//string1
	SELF.address1					:= 	address1; 								//string25
	// Original didn't put CSZ in here so leave it blank.
	// SELF.address2					:=	IF(true, Address.Addr2FromComponents(cleanAddress.v_city_name, cleanAddress.st, cleanAddress.zip), '');		//string25
	//SELF.address3 := '';															//string25
	SELF.origcity					:=	L.v_city_name;		//string20
	SELF.origstate 				:=	L.st;						//string2
	SELF.origzip 					:=	L.zip;						//string9
	//SELF.country := '';																//string35
	SELF.dob 							:=	L.fb_dob;									//string8
	//SELF.agegroup := '';															//string10
	SELF.gender 					:=	L.fb_gender;							//string8
	//SELF.email := '';																	//string50
	SELF.homephone 				:=	L.phone;									//string10
	SELF.cellphone 				:=	IF(L.phone != '', L.phone[1] + '1' + L.phone[3..], '');			//string10
	//SELF.listingtype := '';														//string2
	//SELF.publishcode := '';														//string2
	//SELF.company := '';																//string80
	//SELF.origtitle := '';															//string25
	//SELF.registrationdate := 0;												//unsigned integer3
	//SELF.phonemodel := '';														//string20
	//SELF.ipaddress := '';															//string20
	//SELF.carriercode := '';														//string20
	//SELF.countrycode := '';														//string15
	//SELF.keycode := '';																//string15
	//SELF.globalkeycode := '';													//string15
	SELF.prim_range				:=	L.prim_range;		//string10
	SELF.predir						:=	L.predir;				//string2
	SELF.prim_name				:=	L.prim_name;			//string28
	SELF.addr_suffix			:=	L.addr_suffix;		//string4
	SELF.postdir					:=	L.postdir;				//string2
	SELF.unit_desig				:=	L.unit_desig;		//string10
	SELF.sec_range				:=	L.sec_range;			//string8
	SELF.p_city_name			:=	L.p_city_name;		//string25
	SELF.v_city_name			:=	L.v_city_name;		//string25
	SELF.state						:=	L.st;						//string2
	SELF.zip5							:=	L.zip;						//string5
	SELF.zip4							:=	L.zip4;					//string4
	SELF.cart							:=	L.cart;					//string4
	SELF.cr_sort_sz				:=	L.cr_sort_sz;		//string1
	SELF.lot							:=	L.lot;						//string4
	SELF.lot_order				:=	L.lot_order;			//string1
	SELF.dpbc							:=	L.dbpc;					//string2
	SELF.chk_digit				:=	L.chk_digit;			//string1
	SELF.rec_type					:=	L.rec_type;			//string2
	SELF.ace_fips_st 			:=	cleanAddress.fips_state;							//string2
	SELF.ace_fips_county 	:=	cleanAddress.fips_county;							//string3
	SELF.geo_lat 					:=	L.geo_lat;				//string10
	SELF.geo_long 				:=	L.geo_long;			//string11
	SELF.msa							:=	L.msa;						//string4
	SELF.geo_blk					:=	L.geo_blk;				//string7
	SELF.geo_match				:=	L.geo_match;			//string1
	SELF.err_stat					:=	L.err_stat;			//string4
	SELF.title						:=	L.title;									//string5
	SELF.fname						:=	L.fname;									//string20
	SELF.mname						:=	L.mname;									//string20
	SELF.lname						:=	L.lname;									//string20
	SELF.name_suffix			:=	L.name_suffix;						//string5
	//SELF.name_score := '';														//string3
	SELF.did							:=	L.did;										//unsigned integer6
	//SELF.did_score := '';															//string3
	//SELF.__internal_fpos__ := 0;											//unsigned integer8
	SELF := L;
	SELF := [];	
END;

NewBaseDS := PROJECT(MHDR, AddHederData(LEFT));
//OUTPUT(NewBaseDS, NAMED('New_PhonePlus_CT_CSV'));
OUTPUT(NewBaseDS,,u_Files.INITIAL_PPLUS_CSV_FILE, OVERWRITE , NAMED('INITIAL_PPLUS_CSV_FILE'));

rec := RECORD
	string DS_name;
	integer DS_count;
END;

DS_count := DATASET([	 {'MHDR',COUNT(MHDR)}
											,{'NewBaseDS',COUNT(NewBaseDS)}
											], rec);
OUTPUT(DS_count, NAMED('DS_count'));
/*
EXPORT_DS := SORT(NewBaseDS,l_did);
dateString			:= ut.GetDate;
desprayName 				:= 'PhonesPlus_NEW_TRIAL_'+dateString+'.csv';
LandingZoneIP 	:= PRTE2_Phonesplus_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Phonesplus_Ins.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;
lzFilePathGatewayFile	:= PRTE2_Phonesplus_Ins.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
*/