IMPORT EASI, Business_Risk, ut, RiskWise, RiskWiseFCRA, Risk_Indicators, models;

EXPORT FP1409_2_0 (DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam) := FUNCTION

MODEL_DEBUG := false;
NULL := -999999999;

#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Integer ato_st_match_lvl;
			String ato_relatives_lvl;
			Integer sf_closest_rel_distance;
			String sf_add1_util_none;
			String sf_fp_divrisktype;
			Real ato_subscore0;
			Real ato_subscore1;
			Real ato_subscore2;
			Real ato_subscore3;
			Real ato_subscore4;
			Real ato_subscore5;
			Integer r_ato_st_match_lvl;
			Integer r_distaddraddr2;
			Integer r_ato_relatives_lvl;
			Integer r_sf_closest_rel_distance;
			Integer r_sf_add1_util_none;
			Integer r_sf_fp_divrisktype;
			Integer r_dec_tree_1;
			Integer r_dec_tree_2;
			Integer r_dec_tree_3;
			Integer r_dec_tree_4;
			Integer r_dec_tree_5;
			Integer r_dec_tree_6;
			Integer r_dec_tree_7;
			Integer r_dec_tree_8;
			Integer r_dec_tree_9;
			Integer r_dec_tree_10;
			Integer r_dec_tree_11;
			Integer r_dec_tree_12;
			Integer r_dec_tree_13;
			Integer r_dec_tree_14;
			Integer r_dec_tree_15;
			Integer r_dec_tree_16;
			Integer r_dec_tree_17;
			Integer r_dec_tree_18;
			Integer r_dec_tree_19;
			String sf_fp_idveraddressnotcurrent;
			Integer bv_inp_addr_house_number_match;
			String bf_add1_util_none;
			String fp1409_2_1;

			models.layout_modelout;
			Risk_Indicators.Layout_BocaShell_BtSt_Out clam;
			// Risk_Indicators.Layout_BocaShell_BtSt_Out bto;
			// Risk_Indicators.Layout_BocaShell_BtSt_Out sto;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		models.Layout_ModelOut doModel( clam le) := TRANSFORM
	#end
	
	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	
	//Ship to fields
	truedid_s                        := le.Ship_To_Out.truedid;
	did_s                            := le.Ship_To_Out.did;
	addrpop_s                        := le.Ship_To_Out.input_validation.address;
	add1_pop_s                       := le.Ship_To_Out.addrpop;
	add1_st_s                        := le.Ship_To_Out.address_verification.input_address_information.st;
	add2_st_s                        := le.Ship_To_Out.address_verification.address_history_1.st;
	add3_st_s                        := le.Ship_To_Out.address_verification.address_history_2.st;
	rel_count_s                      := le.Ship_To_Out.relatives.relative_count;
	rel_within25miles_count_s        := le.Ship_To_Out.relatives.relative_within25miles_count;
	rel_within100miles_count_s       := le.Ship_To_Out.relatives.relative_within100miles_count;
	rel_within500miles_count_s       := le.Ship_To_Out.relatives.relative_within500miles_count;
	rel_withinother_count_s          := le.Ship_To_Out.relatives.relative_withinother_count;
	util_adl_type_list_s             := le.Ship_To_Out.utility.utili_adl_type;
	fp_divrisktype_s                 := le.Ship_To_Out.fdattributesv2.divrisklevel;
	fp_idveraddressnotcurrent_s      := le.Ship_To_Out.fdattributesv2.idveraddressnotcurrent;
	
	//Bill to fields
	truedid                          := le.Bill_To_Out.truedid;
	did                              := le.Bill_To_Out.did;
	addrpop                          := le.Bill_To_Out.input_validation.address;
	util_adl_type_list               := le.Bill_To_Out.utility.utili_adl_type;
	add1_house_number_match          := le.Bill_To_Out.address_verification.input_address_information.house_number_match;
	add1_pop                         := le.Bill_To_Out.addrpop;
	add1_st                          := le.Bill_To_Out.address_verification.input_address_information.st;
	
	//Other BTST fields
	addrscore                        := if( trim(le.eddo.addrscore)='', NULL, (integer)le.eddo.addrscore);
	distaddraddr2                    := if( trim(le.eddo.distaddraddr2)='', NULL, (integer)le.eddo.distaddraddr2);
	btst_are_relatives               := le.eddo.btst_are_relatives;
	btst_relatives_in_common         := le.eddo.btst_relatives_in_common;
		
/* ***********************************************************
	 *                   Start ECL Code                        *
	 ************************************************************* */

ato_st_match_lvl := map(
    add1_st = ' ' and add1_st_s = ' ' or (Integer)truedid = 0 and (Integer)truedid_s = 0                                    => NULL,
    trim(StringLib.StringToUpperCase(add1_st), LEFT, RIGHT) = trim(StringLib.StringToUpperCase(add1_st_s), LEFT, RIGHT) or
		trim(StringLib.StringToUpperCase(add1_st), LEFT, RIGHT) = trim(StringLib.StringToUpperCase(add2_st_s), LEFT, RIGHT) or
		trim(StringLib.StringToUpperCase(add1_st), LEFT, RIGHT) = trim(StringLib.StringToUpperCase(add3_st_s), LEFT, RIGHT)     => 3,
    did != did_s                                                                                                            => 2,
    did = did_s                                                                                                             => 1,
                                                                                                                               0);

ato_relatives_lvl := map(
    did = 0 and did_s = 0    => '1. BOTH DID 0         ',
    did = 0                  => '2. NEW DID 0          ',
    did_s = 0                => '2. OLD DID 0          ',
    did = did_s              => '4. DIDS EQUAL         ',
    btst_are_relatives       => '5. RELATIVES          ',
    btst_relatives_in_common => '6. RELATIVES IN COMMON',
                                '7. NO RELATION');

sf_closest_rel_distance := map(
    not(truedid_s)                   => NULL,
    rel_count_s = 0                  => -1,
    rel_within25miles_count_s > 0    => 25,
    rel_within100miles_count_s > 0   => 100,
    rel_within500miles_count_s > 0   => 500,
    rel_withinOther_count_s > 0      => 1000,
                                        0);

sf_add1_util_none := map(
    not(add1_pop_s)            => ' ',
    util_adl_type_list_s = ''  => '1',
                                  '0');

sf_fp_divrisktype := if(not(truedid_s) or fp_divrisktype_s = '', '  ', trim(fp_divrisktype_s, LEFT));

ato_subscore0 := map(
    (ato_st_match_lvl in [1]) => 2.418133,
    (ato_st_match_lvl in [2]) => 0.476662,
    (ato_st_match_lvl in [3]) => -0.649550,
                                 0.000000);

ato_subscore1 := map(
    NULL < distaddraddr2 AND distaddraddr2 < 89 => -1.120990,
    89 <= distaddraddr2 AND distaddraddr2 < 279 => 0.384044,
    279 <= distaddraddr2                        => 0.836525,
                                                   -0.000000);

ato_subscore2 := map(
    (trim(ato_relatives_lvl) in ['4. DIDS EQUAL', '5. RELATIVES', '6. RELATIVES IN COMMON']) => -0.268354,
    (trim(ato_relatives_lvl) in ['7. NO RELATION'])                                          => 0.938425,
    (trim(ato_relatives_lvl) in ['1. BOTH DID 0', '2. NEW DID 0', '2. OLD DID 0'])           => 1.131181,
                                                                                                0.000000);

ato_subscore3 := map(
    NULL < sf_closest_rel_distance AND sf_closest_rel_distance < 100  => -0.161296,
    100 <= sf_closest_rel_distance AND sf_closest_rel_distance < 1000 => 0.488065,
    1000 <= sf_closest_rel_distance                                   => 1.115345,
                                                                         -0.000000);

ato_subscore4 := map(
    (sf_add1_util_none in ['0']) => -0.200998,
    (sf_add1_util_none in ['1']) => 0.368013,
                                    -0.000000);

ato_subscore5 := map(
    (sf_fp_divrisktype in [' '])                          => 0.000000,
    (sf_fp_divrisktype in ['1', '2', '3'])                => -0.027628,
    (sf_fp_divrisktype in ['4', '5', '6', '7', '8', '9']) => 0.800342,
                                                             0.000000);

r_ato_st_match_lvl := map(
    ato_subscore0 = 0.000000  => NULL,
    ato_subscore0 = -0.649550 => 1,
    ato_subscore0 = 0.476662  => 2,
                                 3);

r_distaddraddr2 := map(
    ato_subscore1 = -0.000000 => NULL,
    ato_subscore1 = -1.120990 => 1,
    ato_subscore1 = 0.384044  => 2,
                                 3);

r_ato_relatives_lvl := map(
    ato_subscore2 = 0.000000  => NULL,
    ato_subscore2 = -0.268354 => 1,
    ato_subscore2 = 0.938425  => 2,
                                 3);

r_sf_closest_rel_distance := map(
    ato_subscore3 = 0.000000  => NULL,
    ato_subscore3 = -0.161296 => 1,
    ato_subscore3 = 0.488065  => 2,
                                 3);

r_sf_add1_util_none := map(
    ato_subscore4 = 0.000000  => NULL,
    ato_subscore4 = -0.200998 => 1,
                                 2);

r_sf_fp_divrisktype := map(
    ato_subscore5 = 0.000000  => NULL,
    ato_subscore5 = -0.027628 => 1,
                                 2);

r_dec_tree_1 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 <= 2 and r_distaddraddr2 <= 1 and r_ato_relatives_lvl <= 2 and r_sf_add1_util_none <= 1, 1, 0);

r_dec_tree_2 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 <= 2 and r_distaddraddr2 <= 1 and r_ato_relatives_lvl <= 2 and r_sf_add1_util_none > 1, 1, 0);

r_dec_tree_3 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 <= 2 and r_distaddraddr2 <= 1 and r_ato_relatives_lvl > 2, 1, 0);

r_dec_tree_4 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 <= 2 and r_distaddraddr2 > 1 and r_ato_relatives_lvl <= 1 and r_sf_closest_rel_distance <= 1, 1, 0);

r_dec_tree_5 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 <= 2 and r_distaddraddr2 > 1 and r_ato_relatives_lvl <= 1 and r_sf_closest_rel_distance > 1 and r_sf_closest_rel_distance <= 2, 1, 0);

r_dec_tree_6 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 <= 2 and r_distaddraddr2 > 1 and r_ato_relatives_lvl <= 1 and r_sf_closest_rel_distance > 1 and r_sf_closest_rel_distance > 2, 1, 0);

r_dec_tree_7 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 <= 2 and r_distaddraddr2 > 1 and r_ato_relatives_lvl > 1, 1, 0);

r_dec_tree_8 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 > 2 and r_sf_fp_divrisktype <= 1 and r_ato_relatives_lvl <= 1 and r_sf_closest_rel_distance <= 2 and r_sf_add1_util_none <= 1 and r_sf_closest_rel_distance <= 1, 1, 0);

r_dec_tree_9 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 > 2 and r_sf_fp_divrisktype <= 1 and r_ato_relatives_lvl <= 1 and r_sf_closest_rel_distance <= 2 and r_sf_add1_util_none <= 1 and r_sf_closest_rel_distance > 1, 1, 0);

r_dec_tree_10 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 > 2 and r_sf_fp_divrisktype <= 1 and r_ato_relatives_lvl <= 1 and r_sf_closest_rel_distance <= 2 and r_sf_add1_util_none > 1, 1, 0);

r_dec_tree_11 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 > 2 and r_sf_fp_divrisktype <= 1 and r_ato_relatives_lvl <= 1 and r_sf_closest_rel_distance > 2, 1, 0);

r_dec_tree_12 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 > 2 and r_sf_fp_divrisktype <= 1 and r_ato_relatives_lvl > 1, 1, 0);

r_dec_tree_13 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 > 2 and r_sf_fp_divrisktype > 1 and r_sf_add1_util_none <= 1, 1, 0);

r_dec_tree_14 := if(r_ato_st_match_lvl <= 1 and r_distaddraddr2 > 2 and r_sf_fp_divrisktype > 1 and r_sf_add1_util_none > 1, 1, 0);

r_dec_tree_15 := if(r_ato_st_match_lvl > 1 and r_ato_st_match_lvl <= 2 and NULL < r_distaddraddr2 AND r_distaddraddr2 <= 2, 1, 0);

r_dec_tree_16 := if(r_ato_st_match_lvl > 1 and r_ato_st_match_lvl <= 2 and (r_distaddraddr2 > 2 or r_distaddraddr2 = NULL), 1, 0);

r_dec_tree_17 := if(r_ato_st_match_lvl > 1 and r_ato_st_match_lvl > 2 and NULL < r_distaddraddr2 AND r_distaddraddr2 <= 2, 1, 0);

r_dec_tree_18 := if(r_ato_st_match_lvl > 1 and r_ato_st_match_lvl > 2 and (r_distaddraddr2 > 2 or r_distaddraddr2 = NULL) and r_sf_add1_util_none <= 1, 1, 0);

r_dec_tree_19 := if(r_ato_st_match_lvl > 1 and r_ato_st_match_lvl > 2 and (r_distaddraddr2 > 2 or r_distaddraddr2 = NULL) and r_sf_add1_util_none > 1, 1, 0);

sf_fp_idveraddressnotcurrent := if(not(truedid_s) or fp_idveraddressnotcurrent_s = '', '  ', trim(fp_idveraddressnotcurrent_s, LEFT));

bv_inp_addr_house_number_match := if(not(add1_pop), NULL, (Integer)add1_house_number_match);

bf_add1_util_none := map(
    not(add1_pop)           => ' ',
    util_adl_type_list = '' => '1',
                               '0');

fp1409_2_1 := map(
    (addrscore in [90, 100])                                                    => 96,
    ((Integer)add1_pop = 0 or (Integer)addrpop = 0) and
		(sf_fp_idveraddressnotcurrent in ['0']) and (sf_add1_util_none in ['1'])    => 97,
    (Integer)add1_pop = 0 or (Integer)addrpop = 0                               => 96,
    ((Integer)add1_pop_s = 0 or (Integer)addrpop_s = 0) and
		(bv_inp_addr_house_number_match in [0]) and (bf_add1_util_none in ['1'])    => 98,
    (Integer)add1_pop_s = 0 or (Integer)addrpop_s = 0                           => 96,
    r_dec_tree_14 = 1                                                           => 11,
    r_dec_tree_18 = 1 or r_dec_tree_19 = 1                                      => 12,
    r_dec_tree_16 = 1                                                           => 13,
    r_dec_tree_17 = 1                                                           => 14,
    r_dec_tree_6 = 1 or r_dec_tree_12 = 1                                       => 15,
    r_dec_tree_7 = 1 or r_dec_tree_13 = 1 or r_dec_tree_15 = 1                  => 16,
    r_dec_tree_11 = 1                                                           => 17,
                                                                                   99);


	#if(MODEL_DEBUG)
		/* Model Input Variables */							
		self.ato_st_match_lvl                 := ato_st_match_lvl;
		self.ato_relatives_lvl                := ato_relatives_lvl;
		self.sf_closest_rel_distance          := sf_closest_rel_distance;
		self.sf_add1_util_none                := sf_add1_util_none;
		self.sf_fp_divrisktype                := sf_fp_divrisktype;
		self.ato_subscore0                    := ato_subscore0;
		self.ato_subscore1                    := ato_subscore1;
		self.ato_subscore2                    := ato_subscore2;
		self.ato_subscore3                    := ato_subscore3;
		self.ato_subscore4                    := ato_subscore4;
		self.ato_subscore5                    := ato_subscore5;
		self.r_ato_st_match_lvl               := r_ato_st_match_lvl;
		self.r_distaddraddr2                  := r_distaddraddr2;
		self.r_ato_relatives_lvl              := r_ato_relatives_lvl;
		self.r_sf_closest_rel_distance        := r_sf_closest_rel_distance;
		self.r_sf_add1_util_none              := r_sf_add1_util_none;
		self.r_sf_fp_divrisktype              := r_sf_fp_divrisktype;
		self.r_dec_tree_1                     := r_dec_tree_1;
		self.r_dec_tree_2                     := r_dec_tree_2;
		self.r_dec_tree_3                     := r_dec_tree_3;
		self.r_dec_tree_4                     := r_dec_tree_4;
		self.r_dec_tree_5                     := r_dec_tree_5;
		self.r_dec_tree_6                     := r_dec_tree_6;
		self.r_dec_tree_7                     := r_dec_tree_7;
		self.r_dec_tree_8                     := r_dec_tree_8;
		self.r_dec_tree_9                     := r_dec_tree_9;
		self.r_dec_tree_10                    := r_dec_tree_10;
		self.r_dec_tree_11                    := r_dec_tree_11;
		self.r_dec_tree_12                    := r_dec_tree_12;
		self.r_dec_tree_13                    := r_dec_tree_13;
		self.r_dec_tree_14                    := r_dec_tree_14;
		self.r_dec_tree_15                    := r_dec_tree_15;
		self.r_dec_tree_16                    := r_dec_tree_16;
		self.r_dec_tree_17                    := r_dec_tree_17;
		self.r_dec_tree_18                    := r_dec_tree_18;
		self.r_dec_tree_19                    := r_dec_tree_19;
		self.sf_fp_idveraddressnotcurrent     := sf_fp_idveraddressnotcurrent;
		self.bv_inp_addr_house_number_match   := bv_inp_addr_house_number_match;
		self.bf_add1_util_none                := bf_add1_util_none;
		self.fp1409_2_1                       := (STRING3)fp1409_2_1;

		SELF.seq 															:= le.Bill_To_Out.seq;
		SELF.score 														:= (STRING3)fp1409_2_1;
		
		self.clam                             := le;
		self := [];
	#else
		SELF.ri := [];
		SELF.seq := le.Bill_To_Out.seq;
		SELF.score := (STRING3)fp1409_2_1;
	#end
	END;

	model := project( clam, doModel(left) );
	
	RETURN(model);
END;
