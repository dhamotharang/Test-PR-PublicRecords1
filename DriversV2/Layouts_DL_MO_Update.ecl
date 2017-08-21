EXPORT Layouts_DL_MO_Update := MODULE

// basic file record length 250
 EXPORT Layout_MO_Basic := RECORD
  STRING10 Unique_Key;
	STRING75 Filler1;
	STRING10 License_Number;           //  101 -  110
	STRING25 Last_Name;                //  111 -  135
	STRING15 First_Name;               //  136 -  150
	STRING12 Middle_Name;              //  151 -  162
	STRING3  Suffix;                   //  163 -  165
	STRING8  Date_of_Birth;            //  166 -  173
	STRING1  Gender;                   //  174 -  174
	STRING25 Address;                  //  175 -  199
	STRING20 City;                     //  200 -  219
	STRING2  State;                    //  220 -  221
	STRING5  Zip5;                     //  222 -  226
	STRING4  Zip4;                     //  227 -  230
	STRING25 Mailing_Address1;         //  231 -  255
	STRING25 Mailing_Address2;         //  256 -  280
	STRING20 Mailing_City;             //  281 -  300
	STRING2  Mailing_State;            //  301 -  302
	STRING9  Mailing_Zip;              //  303 -  311
	STRING3  Height;                   //  312 -  314
	STRING3  Weight;                   //  315 -  317
	STRING1  Eye_Color;                //  318 -  318
	STRING2  Operator_Status;          //  319 -  320
	STRING2  Commercial_Status;        //  321 -  322
	STRING2  Sch_Bus_Status;           //  323 -  324
	STRING1  Pending_Act_Code;         //  325 -  325
	STRING1  Must_Test_Ind;            //  326 -  326
	STRING1  Deceased_Ind;             //  327 -  327 
	STRING2  Prev_CDL_Class;           //  328 -  329
	STRING1  CDL_Ptr;                  //  330 -  330
	STRING1  PDPS_Ptr;                 //  331 -  331
	STRING1  MVR_Privacy_Code;         //  332 -  332
	STRING1  BRC_Status_Code;          //  333 -  333
	STRING8  BRC_Status_Date;          //  334 -  341
	STRING9  Filler2;                  //  342 -  350
 END;
 
 // Issues file record length 190
 EXPORT Layout_MO_Icissu := RECORD
  STRING1  Lic_Iss_Code;             //  351 -  351
	STRING2  License_Class;            //  352 -  353
	STRING8  Lic_Exp_Date;             //  354 -  361
	STRING12 Lic_Seq_Number;           //  362 -  373
	STRING2  Lic_Surrender_From;       //  374 -  375
	STRING2  Lic_Surrender_To;         //  376 -  377
	STRING25 New_Out_of_St_DL_Num;     //  378 -  402
	STRING10 License_Endorsements;     //  403 -  412
	STRING5  License_Restrictions;     //  413 -  417
	STRING5  Filler3;                  //  418 -  422
	STRING2  License_Trans_Type;       //  423 -  424
	STRING8  Lic_Print_Date;           //  425 -  432
	STRING10 Filler4;                  //  433 -  442
	STRING1  Permit_Iss_Code;          //  443 -  443
	STRING2  Permit_Class;             //  444 -  445
	STRING8  Permit_Exp_Date;          //  446 -  453
	STRING12 Permit_Seq_Number;        //  454 -  465
	STRING10 Permit_Endorse_Codes;     //  466 -  475
	STRING5  Permit_Restric_Codes;     //  476 -  480
	STRING5  Filler5;                  //  481 -  485
	STRING2  Permit_Trans_Type;        //  486 -  487
	STRING8  Permit_Print_Date;        //  488 -  495
	STRING2  Filler6;                  //  496 -  497
	STRING1  Non_Driver_Code;          //  498 -  498
	STRING8  Non_Driver_Exp_Date;      //  499 -  506
	STRING12 Non_Driver_Seq_Num;       //  507 -  518
	STRING2  Non_Driver_Trans_Type;    //  519 -  520
	STRING8  Non_Driver_Print_Date;    //  521 -  528
	STRING12  Filler7;                 //  529 -  540
	STRING8   Action_Surrender_Date;   //  541 -  548
	UNSIGNED4 Action_Counts;           //  549 -  551
	UNSIGNED4 Driv_Priv_Counts;        //  552 -  554
	UNSIGNED4 Conv_Counts;             //  555 -  557
	UNSIGNED4 Accidents_Counts;        //  558 -  560
	UNSIGNED4 AKA_Counts;              //  561 -  563
	STRING6   Filler8;                 //  564 -  569
 END;
	
 EXPORT Layout_MO_with_Clean := RECORD
	STRING8 process_date;
	Layout_MO_Basic;		
	Layout_MO_Icissu;
	STRING5  title;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5  name_suffix;
	STRING3  cleaning_score;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING25 v_city_name;
	STRING2  st;
	STRING5  cln_zip5;
	STRING4  cln_zip4;
	STRING4  cart;
	STRING1  cr_sort_sz;
	STRING4  lot;
	STRING1  lot_order;
	STRING2  dpbc;
	STRING1  chk_digit;
	STRING2  rec_type;
	STRING2  ace_fips_st;
	STRING3  county;
	STRING10 geo_lat;
	STRING11 geo_long;
	STRING4  msa;
	STRING7  geo_blk;
	STRING1  geo_match;
	STRING4  err_stat;
	STRING25 previous_dl_number;
  STRING2  previous_st;
	STRING24 old_dl_number;
 END;

 EXPORT	Layout_MO_With_Pdate 		:= RECORD
	STRING8 process_date;
	Layout_MO_Basic;
	STRING2  License_Class;             
	STRING8  Lic_Exp_Date;              
	STRING10 License_Endorsements;      
	STRING5  License_Restrictions;      
	STRING2  License_Trans_Type;        
	STRING8  Lic_Print_Date;            
	STRING5  title;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5  name_suffix;
	STRING3  cleaning_score;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING25 v_city_name;
	STRING2  st;
	STRING5  cln_zip5;
	STRING4  cln_zip4;
	STRING4  cart;
	STRING1  cr_sort_sz;
	STRING4  lot;
	STRING1  lot_order;
	STRING2  dpbc;
	STRING1  chk_digit;
	STRING2  rec_type;
	STRING2  ace_fips_st;
	STRING3  county;
	STRING10 geo_lat;
	STRING11 geo_long;
	STRING4  msa;
	STRING7  geo_blk;
	STRING1  geo_match;
	STRING4  err_stat;
	STRING25 previous_dl_number;
  STRING2  previous_st;
	STRING24 old_dl_number;
 END;

	
  // Actions file record length 120
 EXPORT Layout_MO_Actions := RECORD
  STRING10 Unique_Key;  
	STRING4 action_type;
  STRING18 action_case_num;
  STRING8 action_eff_date;
  STRING8 action_reinst_date;
  STRING3 action_status_code;
  STRING8 action_status_date;
  STRING2 action_state_offense;
  STRING8 action_offense_date;
  STRING9 action_tkt_num;
  STRING1 action_haz_mat_ind;
  STRING2 action_state;
  STRING7 action_filler1;
  STRING8 action_oos_eval_date;
  STRING3 action_acd_code;
  STRING1 action_wdraw_code;
  STRING1 action_wdraw_basis;
  STRING1 action_process_code;
  STRING1 action_extent_code;
  STRING8 action_wd_ref_num;
  STRING1 action_cdl_ind;
  STRING2 action_wdraw_id;
  STRING3 action_wd_bac_lvl;
  STRING13 action_filler2;
 END;

 EXPORT Layout_MO_Actions_Pdate := RECORD
   STRING8 process_date;
	 Layout_MO_Actions;		
 END;
 
  // Accidents file record length 50
 EXPORT Layout_MO_Accidents := RECORD
  STRING10 Unique_Key;
  STRING2 acci_state;
  STRING8 acci_date;
  STRING1 acci_sev_code;
  STRING1 acci_cmv_ind;
  STRING1 acci_haz_mat_ind;
  STRING18 acci_loc_num;
  STRING19 acci_filler2;
 END;

 EXPORT Layout_MO_Accidents_Pdate := RECORD
	  STRING8 process_date;
		Layout_MO_Accidents;		
 END;

 // Convictions/Points file record lenght 110
 EXPORT Layout_MO_Points := RECORD
  STRING10 Unique_Key;
	STRING4 conv_viol_code;
  STRING8 conv_pts_date;
  STRING8 conv_date;
  STRING9 conv_crt_loc;
  STRING3 conv_crt_type;
  STRING1 conv_cmv_ind;
  STRING1 conv_haz_mat_ind;
  STRING2 conv_pts_assessed;
  STRING1 conv_driv_imp_ind;
  STRING8 conv_viol_date;
  STRING9 conv_tkt_num;
  STRING8 conv_oos_eval_date;
  STRING18 conv_loc_num;
  STRING3 conv_acd_code;
  STRING8 conv_ref_num;
  STRING3 conv_pstd_speed;
  STRING3 conv_chrgd_speed;
  STRING1 conv_cdl_ind;
  STRING2 conv_id;
  STRING1 conv_sis;
  STRING3 conv_bac_lvl;
  STRING6 conv_filler2;
 END;
	
 EXPORT Layout_MO_Points_Pdate := RECORD
   STRING8 process_date;
	 Layout_MO_Points;		
 END;
	
	// DPRDPS file record lenght 40
 EXPORT Layout_MO_DPRDPS := RECORD
  STRING10 Unique_Key;
	STRING4 driv_priv_type;
  STRING8 driv_priv_eff_date;
  STRING8 driv_priv_exp_date;
  STRING3 driv_priv_sts_code;
  STRING8 driv_priv_sts_date;
  STRING9 dp_filler2;
 END;
	
 EXPORT Layout_MO_DPRDPS_Pdate := RECORD
	 STRING8 process_date;
	 Layout_MO_DPRDPS;		
 END;
 
 	// Cross referenc/AKA file record lenght 
 EXPORT Layout_MO_AKA := RECORD
   STRING10 Unique_Key;   
	 STRING2  AKA_Lic_State;
	 STRING25 AKA_Lic_Num;
	 STRING25 AKA_LName;
	 STRING15 AKA_FName;
	 STRING12 AKA_MName;
	 STRING3  AKA_Suffix;
	 STRING8  AKA_DOB;
	 STRING10 AKA_Filler2;
 END;
	
 EXPORT Layout_MO_AKA_Pdate := RECORD
	 STRING8 process_date;
	 Layout_MO_AKA;		
 END;
END;