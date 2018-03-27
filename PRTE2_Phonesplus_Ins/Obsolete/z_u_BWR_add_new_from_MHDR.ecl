// PRTE2_Phonesplus_Ins.u_BWR_add_new_from_MHDR
//To generate mising 12k records of initial data

IMPORT PRTE2_Phonesplus_Ins, PRTE2_Header_Ins, PRTE2_X_DataCleanse, PRTE_CSV;
Layouts := PRTE2_Phonesplus_Ins.Layouts;
Files   := PRTE2_Phonesplus_Ins.Files;
u_Files   := PRTE2_Phonesplus_Ins.u_Files;

appendIf(STRING s1, STRING s2) := TRIM(IF(s1='', s2, TRIM(s1)+' '+TRIM(s2) ));
appendIf3(STRING s1, STRING s2, STRING s3) := appendIf(appendIf(s1,s2),s3);
appendIf4(STRING s1, STRING s2, STRING s3, STRING s4) := appendIf(appendIf3(s1,s2,s3),s4);
appendIf5(STRING s1, STRING s2, STRING s3, STRING s4, STRING s5) := appendIf(appendIf4(s1,s2,s3,s4),s5);

PhonesPlus_Layout := Layouts.Alpha_CSV_Layout;
PhonesPlus_DS 		:= Files.PhonesPlus_Base_SF_DS;
OUTPUT(PhonesPlus_DS, NAMED('PhonesPlus_DS'));
OUTPUT(COUNT(PhonesPlus_DS), NAMED('Count__PhonesPlus_DS'));

MHDR_Layout := PRTE2_X_Ins_DataCleanse.Layouts.Layout_Merged_IHDR_BHDR;
MHDR := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_DS;
OUTPUT(MHDR, NAMED('MHDR'));
OUTPUT(COUNT(MHDR), NAMED('Count__MHDR'));


// marge mising required records from MHDR to PhonePlus
VAL_HD	:= 37.66298241488333;
VAL_PC	:= VAL_HD + 31.94585978939667;
VAL_GH	:= VAL_PC + 12.4585195056309;
VAL_1 	:= VAL_GH + 8.024352642993389;
VAL_WP	:= VAL_1  + 4.517781087507513;
VAL_2 	:= VAL_WP + 2.863787201797706;
VAL_IN	:= VAL_2 	+ 2.50842674610018;
VAL_5 	:= VAL_IN + 0.01829061169031381;

PhonesPlus_Layout  trGetMising(PhonesPlus_Layout L, MHDR_Layout R) := TRANSFORM
	// -- populate problem fields ---------------------------------------------------------
	SELF.confidencescore := (( RANDOM() / 0xFFFFFFFF ) * 98 ) +1;				//unsigned integer2
	RV := ( RANDOM()  / 0xFFFFFFFF ) * VAL_5;
	SELF.vendor := MAP(	RV<VAL_HD => 'HD',
											RV<VAL_PC => 'PC',
											RV<VAL_GH => 'GH',
											RV<VAL_1  => '1',
											RV<VAL_WP => 'WP',
											RV<VAL_2 => '2',
											RV<VAL_IN => 'IN',
											'5');									// string2
	// -- populate problem fields ---------------------------------------------------------
	SELF.l_did := R.did;											//unsigned integer6
//	SELF.datevendorfirstreported := 0;			//unsigned integer3				//field to be investigated (populated in initial 38K)
//	SELF.datevendorlastreported := 0;				//unsigned integer3				//field to be investigated (populated in initial 38K)
	SELF.datefirstseen := R.dt_first_seen;		//unsigned integer3
	SELF.datelastseen := R.dt_last_seen;			//unsigned integer3
//	SELF.dt_nonglb_last_seen := 0;					//unsigned integer3				//field to be investigated (populated in initial 38K)
//	SELF.glb_dppa_flag := '';								//string1									//field to be investigated (populated in initial 38K)
//	SELF.activeflag := '';									//string1									//field to be investigated (populated in initial 38K)
//	SELF.cellphoneidkey := '';							//string32
//	SELF.recordkey := '';										//string60
//	SELF.stateorigin := '';									//string2
//	SELF.sourcefile := '';									//string20
//	SELF.src := '';													//string2
	SELF.origname := appendIf3(R.fname,R.mname,R.lname);															//string90
//	SELF.nameformat := '';									//string1
	SELF.address1 := appendIf5(R.prim_range,R.predir,R.prim_name,R.suffix,R.postdir);	//string25
	SELF.address2 := appendIf(R.unit_desig,R.sec_range);															//string25
//	SELF.address3 := '';										//string25
	SELF.origcity := R.v_city_name;						//string20
	SELF.origstate := R.st;										//string2
	SELF.origzip := R.zip;										//string9
//	SELF.country := '';											//string35
	SELF.dob := (string) R.dob;								//string8
//	SELF.agegroup := '';										//string10
	SELF.gender := R.fb_gender;								//string8
//	SELF.email := '';												//string50
	SELF.homephone := R.phone;								//string10
	SELF.cellphone := R.phone[1] + '1' + R.phone[3..];	//string10
//	SELF.listingtype := '';									//string2									//field to be investigated (populated in initial 38K)
//	SELF.publishcode := '';									//string2
//	SELF.company := '';											//string80
//	SELF.origtitle := '';										//string25
//	SELF.registrationdate := 0;							//unsigned integer3
//	SELF.phonemodel := '';									//string20
//	SELF.ipaddress := '';										//string20
//	SELF.carriercode := '';									//string20
//	SELF.countrycode := '';									//string15
//	SELF.keycode := '';											//string15
//	SELF.globalkeycode := '';								//string15
	SELF.prim_range := R.prim_range;					//string10
	SELF.predir := R.predir;									//string2
	SELF.prim_name := R.prim_name;						//string28
	SELF.addr_suffix := R.addr_suffix;				//string4
	SELF.postdir := R.postdir;								//string2
	SELF.unit_desig := R.unit_desig;					//string10
	SELF.sec_range := R.sec_range;						//string8
	SELF.p_city_name := r.p_city_name;				//string25
	SELF.v_city_name := R.v_city_name;				//string25
	SELF.state := R.st;												//string2
	SELF.zip5 := R.zip;												//string5
	SELF.zip4 := R.zip4;											//string4
	SELF.cart := R.cart;											//string4
	SELF.cr_sort_sz := R.cr_sort_sz;					//string1
	SELF.lot := R.lot;												//string4
	SELF.lot_order := R.lot_order;						//string1
	SELF.dpbc := R.dbpc;											//string2
	SELF.chk_digit := R.chk_digit;						//string1
	SELF.rec_type := R.rec_type;							//string2
//	SELF.ace_fips_st := '';									//string2									//field to be investigated (populated in initial 38K)
//	SELF.ace_fips_county := '';							//string3									//field to be investigated (populated in initial 38K)
	SELF.geo_lat := R.geo_lat;								//string10
	SELF.geo_long := R.geo_long;							//string11
	SELF.msa := R.msa;												//string4
	SELF.geo_blk := R.geo_blk;								//string7
	SELF.geo_match := R.geo_match;						//string1
	SELF.err_stat := R.err_stat;							//string4
	SELF.title := R.title;										//string5
	SELF.fname := R.fname;										//string20
	SELF.mname := R.mname;										//string20
	SELF.lname := R.lname;										//string20
	SELF.name_suffix := R.name_suffix;				//string5
//	SELF.name_score := '';									//string3									//field to be investigated (populated in initial 38K)
	SELF.did := R.did;											//unsigned integer6
//	SELF.did_score := '';										//string3									//field to be investigated (populated in initial 38K)
//	SELF.__internal_fpos__ := 0;						//unsigned integer8
	
	SELF := R;
	SELF := [];
END;

PPlus_MHDR := JOIN(PhonesPlus_DS, MHDR,
										LEFT.l_did = RIGHT.did,
										trGetMising(LEFT,RIGHT),
										RIGHT ONLY);
OUTPUT(Files.PhonesPlus_Base_SF_DS + PPlus_MHDR,,u_Files.PPlus_MHDR_File, OVERWRITE, NAMED('PPlus_MHDR'));
OUTPUT(COUNT(PPlus_MHDR), NAMED('Count__NEW_INITIAL_DATA'));
OUTPUT(COUNT(u_Files.PPlus_MHDR_DS), NAMED('Count__ALL_INTIAL_DATA'));

//testing random distribution of vendor field
PP := PPlus_MHDR;
TRC := COUNT(PP);

vendor_rec := RECORD
	PP.vendor;
	GrpCount := COUNT(GROUP);
	dist := COUNT(GROUP)/TRC*100;
END;
vendor_table := TABLE(PP,vendor_rec,vendor,FEW);
OUTPUT(sort(vendor_table,-GrpCount), NAMED('vendor'));

confidencescore_rec := RECORD
	PP.confidencescore;
	GrpCount := COUNT(GROUP);
	dist := COUNT(GROUP)/TRC*100;
END;
confidencescore_table := TABLE(PP,confidencescore_rec,confidencescore,FEW);
OUTPUT(sort(confidencescore_table,-confidencescore), NAMED('confidencescore'));

