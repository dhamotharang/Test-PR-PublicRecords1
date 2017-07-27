IMPORT EASI, Business_Risk, ut, RiskWise, RiskWiseFCRA, Risk_Indicators;

EXPORT cdn1404_1_0 (GROUPED DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
										DATASET(Models.Layout_CD_CustomModelInputs) customInputs,
										BOOLEAN IBICID,
										BOOLEAN WantstoSeeBillToShipToDifferenceFlag) := FUNCTION

	MODEL_DEBUG := FALSE;
	
 /************************************************************************************
 * Build Easi census data                                                            *
 ************************************************************************************/
//saving time by using the address input rather than re-clean address
	layout_cd2iPlus := RECORD
		RiskWise.Layout_CD2I;
		string3 county := '';
		string7 geo_blk := '';
		string3 county2 := '';
		string7 geo_blk2 := '';
	END;

	layout_ineasi := record
		layout_cd2iPlus cd2i;
		recordof(EASI.Key_Easi_Census) easi;
		recordof(EASI.Key_Easi_Census) easi2;
	END;
	layout_model_in := RECORD
		Risk_Indicators.Layout_BocaShell_BtSt_Out bs;
		layout_ineasi census;
	END;
	layout_model_in join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
		SELF.bs := le;
		SELF.census.easi := ri;	
		self.census.cd2i.county := le.bill_to_out.shell_input.county;
		self.census.cd2i.state := le.bill_to_out.shell_input.st;
		self.census.cd2i.geo_blk := le.bill_to_out.shell_input.geo_blk;
		self.census.cd2i := le;
		self	:= [];
	END;	

	clam_with_bt_easi := join(clam, Easi.Key_Easi_Census,
				 keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 join2recs(left,right),
				 left outer,
				 ATMOST(keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 RiskWise.max_atmost),keep(1));		

	layout_model_in joinEm(clam_with_bt_easi le, Easi.Key_Easi_Census ri) := TRANSFORM
		self.census.easi2 := ri;
		self.census.cd2i.county2 := le.bs.ship_to_out.shell_input.county;
		self.census.cd2i.state := le.bs.ship_to_out.shell_input.st;
		self.census.cd2i.geo_blk2 := le.bs.ship_to_out.shell_input.geo_blk;
		self.census.cd2i := le;
		self := le;
	END;

	clam_with_easi := join(clam_with_bt_easi, Easi.Key_Easi_Census,
				keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				joinEm(left,right),
				left outer,
				ATMOST(keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				RiskWise.max_atmost),keep(1));

#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			INTEGER sysdate                   ;
			STRING pf_ship_mode               ;
			INTEGER pf_num_items              ;
			REAL pf_order_amount              ;
			REAL avg_pmt_amt                  ;
			STRING pf_pmt_type                ;
			BOOLEAN avs_name_ver              ;
			BOOLEAN avs_unvail                ;
			BOOLEAN avs_addr_ver              ;
			BOOLEAN avs_no_match              ;
			BOOLEAN avs_zip5_ver              ;
			STRING pf_avs_ver_lvl             ;
			Integer pf_cid_match              ;
			BOOLEAN valid_tm_account          ;
			BOOLEAN tm_not_us_time_zone_f     ;
			INTEGER tm_bad_reason_code_lvl    ;
			BOOLEAN tm_bad_reason_code_f      ;
			STRING ip_state                   ;
			INTEGER state_match_lvl           ;
			INTEGER b_hist_addr_match_i       ;
			REAL b_corraddrnamecount_d        ;
			REAL b_inq_count24_i              ;
			INTEGER b_corrrisktype_i          ;
			INTEGER s_inq_per_phone_i         ;
			INTEGER b_inq_count12_i           ;
			INTEGER s_add_invalid_i           ;
			REAL s_corrrisktype_i             ;
			INTEGER b_inq_retail_recency_d    ;
			REAL b_inq_per_addr_i             ;
			INTEGER s_phn_not_issued_i        ;
			INTEGER b_corrphonelastnamecount_d;
			INTEGER s_corraddrnamecount_d     ;
			INTEGER b_inq_per_phone_i         ;
			INTEGER b_inq_other_count24_i     ;
			REAL b_srchvelocityrisktype_i     ;
			INTEGER s_inq_retail_recency_d    ;
			INTEGER s_inq_count24_i           ;
			INTEGER s_estimated_income_d      ;
			REAL s_inq_per_addr_i             ;
			INTEGER s_idverrisktype_i         ;
			INTEGER b_idverrisktype_i         ;
			INTEGER s_bus_name_match_d        ;
			INTEGER s_credit_seeking_i        ;
			INTEGER b_inq_ssns_per_addr_i     ;
			INTEGER s_varrisktype_i           ;
			INTEGER _in_dob                   ;
			REAL yr_in_dob                    ;
			INTEGER yr_in_dob_int             ;
			INTEGER b_comb_age_d              ;
			INTEGER b_srchcomponentrisktype_i ;
			String bb_ship_mode_                 ;
			Integer bb_item_lines_               ;
			String bb_original_total_amount_     ;
			String bb_cc_type_                   ;
			String bb_avs_code_                  ;
			String bb_cvv_description_           ;
			String bb_entry_type_                ;
			String bb_line_type_header_          ;
			String tm_device_result_             ;
			Real tm_time_zone_hours_             ;
			String tm_reason_code_               ;
			String tm_true_ip_region_            ;
			Integer firstscore                   ;
			Integer lastscore                    ;
			Boolean btst_relatives_in_common     ;
			String distaddraddr2                 ;
			String distphone2addr2               ;
			Boolean btst_are_relatives           ;
			String addrscore                     ;
			Boolean truedid                      ;
			String in_state                      ;
			String in_dob                        ;
			Boolean addrpop                      ;
			Boolean hphnpop                      ;
			Integer hist_addr_match              ;
			Integer inq_count12                  ;
			Integer inq_count24                  ;
			Integer inq_retail_count             ;
			Integer inq_retail_count01           ;
			Integer inq_retail_count03           ;
			Integer inq_retail_count06           ;
			Integer inq_retail_count12           ;
			Integer inq_retail_count24           ;
			Integer inq_other_count24            ;
			Integer inq_peraddr                  ;
			Integer inq_ssnsperaddr              ;
			Integer inq_perphone                 ;
			String fp_idverrisktype              ;
			String fp_srchvelocityrisktype       ;
			String fp_corrrisktype               ;
			String fp_corraddrnamecount          ;
			String fp_corrphonelastnamecount     ;
			String fp_srchcomponentrisktype      ;
			Integer inferred_age                 ;
			Boolean truedid_s                    ;
			String rc_pwphonezipflag_s           ;
			String rc_addrvalflag_s              ;
			Integer bus_name_match_s             ;
			Boolean addrpop_s                    ;
			Boolean hphnpop_s                    ;
			Integer inq_count24_s                ;
			Integer inq_auto_count03_s           ;
			Integer inq_banking_count03_s        ;
			Integer inq_mortgage_count03_s       ;
			Integer inq_retail_count_s           ;
			Integer inq_retail_count01_s         ;
			Integer inq_retail_count03_s         ;
			Integer inq_retail_count06_s         ;
			Integer inq_retail_count12_s         ;
			Integer inq_retail_count24_s         ;
			Integer inq_communications_count03_s ;
			Integer inq_peraddr_s                ;
			Integer inq_perphone_s               ;
			String fp_idverrisktype_s           ;
			String fp_varrisktype_s             ;
			String fp_corrrisktype_s            ;
			String fp_corraddrnamecount_s       ;
			Integer estimated_income_s           ;
			String C_BORN_USA_s                 ;
			String C_HH7P_P_s                   ;
			String c_hval_125k_p                ;
			String c_hval_80k_p                 ;
			REAL final_score_0                 ;
			REAL final_score_1                 ;
			REAL final_score_2                 ;
			REAL final_score_3                 ;
			REAL final_score_4                 ;
			REAL final_score_5                 ;
			REAL final_score_6                 ;
			REAL final_score_7                 ;
			REAL final_score_8                 ;
			REAL final_score_9                 ;
			REAL final_score_10                ;
			REAL final_score_11                ;
			REAL final_score_12                ;
			REAL final_score_13                ;
			REAL final_score_14                ;
			REAL final_score_15                ;
			REAL final_score_16                ;
			REAL final_score_17                ;
			REAL final_score_18                ;
			REAL final_score_19                ;
			REAL final_score_20                ;
			REAL final_score_21                ;
			REAL final_score_22                ;
			REAL final_score_23                ;
			REAL final_score_24                ;
			REAL final_score_25                ;
			REAL final_score_26                ;
			REAL final_score_27                ;
			REAL final_score_28                ;
			REAL final_score_29                ;
			REAL final_score_30                ;
			REAL final_score_31                ;
			REAL final_score_32                ;
			REAL final_score_33                ;
			REAL final_score_34                ;
			REAL final_score_35                ;
			REAL final_score_36                ;
			REAL final_score_37                ;
			REAL final_score_38                ;
			REAL final_score_39                ;
			REAL final_score_40                ;
			REAL final_score_41                ;
			REAL final_score_42                ;
			REAL final_score_43                ;
			REAL final_score_44                ;
			REAL final_score_45                ;
			REAL final_score_46                ;
			REAL final_score_47                ;
			REAL final_score_48                ;
			REAL final_score_49                ;
			REAL final_score_50                ;
			REAL final_score_51                ;
			REAL final_score_52                ;
			REAL final_score_53                ;
			REAL final_score_54                ;
			REAL final_score_55                ;
			REAL final_score_56                ;
			REAL final_score_57                ;
			REAL final_score_58                ;
			REAL final_score_59                ;
			REAL final_score_60                ;
			REAL final_score_61                ;
			REAL final_score_62                ;
			REAL final_score_63                ;
			REAL final_score_64                ;
			REAL final_score_65                ;
			REAL final_score_66                ;
			REAL final_score_67                ;
			REAL final_score_68                ;
			REAL final_score_69                ;
			REAL final_score_70                ;
			REAL final_score_71                ;
			REAL final_score_72                ;
			REAL final_score_73                ;
			REAL final_score_74                ;
			REAL final_score_75                ;
			REAL final_score_76                ;
			REAL final_score_77                ;
			REAL final_score_78                ;
			REAL final_score                   ;
			REAL pbr                           ;
			REAL sbr                           ;
			REAL bb_offset                     ;
			INTEGER base                       ;
			INTEGER pts                        ;
			REAL lgt                           ;
			INTEGER cdn1404_1_0                ;
			models.layout_modelout;
			Risk_Indicators.Layout_BocaShell_BtSt_Out clam;
		END;
		Layout_Debug doModel(clam_with_easi le, customInputs ri) := TRANSFORM
	#else
		Layout_ModelOut doModel( clam_with_easi le, customInputs ri ) := TRANSFORM
	#end
	
	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	 
		bb_ship_mode_                    := ri.Ship_Mode_;
		bb_item_lines_                   := ri.Item_Lines_;
		bb_original_total_amount_        := ri.Original_Total_Amount_;
		bb_cc_type_                      := ri.Payment_Type_;
		bb_avs_code_                     := ri.AVS_Code_;
		bb_cvv_description_              := ri.CVV_Description_;
		bb_entry_type_                   := ri.Entry_Type_;
		bb_line_type_header_             := ri.Line_Type_Header_;
		tm_device_result_                := ri.Device_Result_;
		tm_time_zone_hours_              := ri.Time_Zone_Hours_;
		tm_reason_code_                  := ri.Reason_Code_;
		tm_true_ip_region_               := ri.True_IP_Region_;
		firstscore                       := (INTEGER)le.bs.eddo.firstscore;
		lastscore                        := (INTEGER)le.bs.eddo.lastscore;
		btst_relatives_in_common         := le.bs.eddo.btst_relatives_in_common;
		distaddraddr2                    := le.bs.eddo.distaddraddr2;
		distphone2addr2                  := le.bs.eddo.distphone2addr2;
		btst_are_relatives               := le.bs.eddo.btst_are_relatives;
		addrscore                        := le.bs.eddo.addrscore;

		//Bill To Fields
		truedid                          := le.bs.Bill_To_Out.truedid;
		in_state                         := le.bs.Bill_To_Out.shell_input.in_state;
		in_dob                           := le.bs.Bill_To_Out.shell_input.dob;
		addrpop                          := le.bs.Bill_To_Out.input_validation.address;
		hphnpop                          := le.bs.Bill_To_Out.input_validation.homephone;
		hist_addr_match                  := le.bs.Bill_To_Out.address_history_summary.hist_addr_match;
		inq_count12                      := le.bs.Bill_To_Out.acc_logs.inquiries.count12;
		inq_count24                      := le.bs.Bill_To_Out.acc_logs.inquiries.count24;
		inq_retail_count                 := le.bs.Bill_To_Out.acc_logs.retail.counttotal;
		inq_retail_count01               := le.bs.Bill_To_Out.acc_logs.retail.count01;
		inq_retail_count03               := le.bs.Bill_To_Out.acc_logs.retail.count03;
		inq_retail_count06               := le.bs.Bill_To_Out.acc_logs.retail.count06;
		inq_retail_count12               := le.bs.Bill_To_Out.acc_logs.retail.count12;
		inq_retail_count24               := le.bs.Bill_To_Out.acc_logs.retail.count24;
		inq_other_count24                := le.bs.Bill_To_Out.acc_logs.other.count24;
		inq_peraddr                      := le.bs.Bill_To_Out.acc_logs.inquiryperaddr;
		inq_ssnsperaddr                  := le.bs.Bill_To_Out.acc_logs.inquiryssnsperaddr;
		inq_perphone                     := le.bs.Bill_To_Out.acc_logs.inquiryperphone;
		fp_idverrisktype                 := le.bs.Bill_To_Out.fdattributesv2.idverrisklevel;
		fp_srchvelocityrisktype          := le.bs.Bill_To_Out.fdattributesv2.searchvelocityrisklevel;
		fp_corrrisktype                  := le.bs.Bill_To_Out.fdattributesv2.correlationrisklevel;
		fp_corraddrnamecount             := le.bs.Bill_To_Out.fdattributesv2.correlationaddrnamecount;
		fp_corrphonelastnamecount        := le.bs.Bill_To_Out.fdattributesv2.correlationphonelastnamecount;
		fp_srchcomponentrisktype         := le.bs.Bill_To_Out.fdattributesv2.searchcomponentrisklevel;
		inferred_age                     := le.bs.Bill_To_Out.inferred_age;
		c_hval_125k_p                    := le.census.easi.hval_125k_p;
		c_hval_80k_p                     := le.census.easi.hval_80k_p;
		
		//Ship To Fields
		truedid_s                        := le.bs.Ship_To_Out.truedid;
		rc_pwphonezipflag_s              := le.bs.Ship_To_Out.iid.pwphonezipflag;
		rc_addrvalflag_s                 := le.bs.Ship_To_Out.iid.addrvalflag;
		bus_name_match_s                 := le.bs.Ship_To_Out.business_header_address_summary.bus_name_match;
		addrpop_s                        := le.bs.Ship_To_Out.input_validation.address;
		hphnpop_s                        := le.bs.Ship_To_Out.input_validation.homephone;
		inq_count24_s                    := le.bs.Ship_To_Out.acc_logs.inquiries.count24;
		inq_auto_count03_s               := le.bs.Ship_To_Out.acc_logs.auto.count03;
		inq_banking_count03_s            := le.bs.Ship_To_Out.acc_logs.banking.count03;
		inq_mortgage_count03_s           := le.bs.Ship_To_Out.acc_logs.mortgage.count03;
		inq_retail_count_s               := le.bs.Ship_To_Out.acc_logs.retail.counttotal;
		inq_retail_count01_s             := le.bs.Ship_To_Out.acc_logs.retail.count01;
		inq_retail_count03_s             := le.bs.Ship_To_Out.acc_logs.retail.count03;
		inq_retail_count06_s             := le.bs.Ship_To_Out.acc_logs.retail.count06;
		inq_retail_count12_s             := le.bs.Ship_To_Out.acc_logs.retail.count12;
		inq_retail_count24_s             := le.bs.Ship_To_Out.acc_logs.retail.count24;
		inq_communications_count03_s     := le.bs.Ship_To_Out.acc_logs.communications.count03;
		inq_peraddr_s                    := le.bs.Ship_To_Out.acc_logs.inquiryperaddr;
		inq_perphone_s                   := le.bs.Ship_To_Out.acc_logs.inquiryperphone;
		fp_idverrisktype_s               := le.bs.Ship_To_Out.fdattributesv2.idverrisklevel;
		fp_varrisktype_s                 := le.bs.Ship_To_Out.fdattributesv2.variationrisklevel;
		fp_corrrisktype_s                := le.bs.Ship_To_Out.fdattributesv2.correlationrisklevel;
		fp_corraddrnamecount_s           := le.bs.Ship_To_Out.fdattributesv2.correlationaddrnamecount;
		estimated_income_s               := le.bs.Ship_To_Out.estimated_income;
		C_BORN_USA_s                     := le.census.easi2.born_usa;
		C_HH7P_P_s                       := le.census.easi2.hh7p_p;
		
NULL := -999999999;

sysdate := common.sas_date(if(le.bs.Bill_To_Out.historydate=999999, (string)ut.getdate, (string6)le.bs.Bill_To_Out.historydate+'01'));

pf_ship_mode := map(
    bb_Ship_Mode_ = '2' => 'NEXT DAY',
    bb_Ship_Mode_ = '7' => 'SECOND DAY',
    bb_Ship_Mode_ = 'G' => 'GROUND',
                           'STANDARD');

pf_num_items := if((String)bb_Item_Lines_ = '', NULL, bb_Item_Lines_);

pf_order_amount := if((String)bb_Original_Total_Amount_ = '', NULL, (real)bb_Original_Total_Amount_);

avg_pmt_amt := max(pf_order_amount, (real)0) / max((integer)pf_num_items, 1);

pf_pmt_type := map(
    // bb_CC_Type_ = (String)NULL                                   => 'GIFT CARD',
    bb_CC_Type_ = ''                                             => 'GIFT CARD',
    StringLib.StringToUpperCase(bb_CC_Type_) = 'AMERICANEXPRESS' => 'AMERICANEXPRESS',
    StringLib.StringToUpperCase(bb_CC_Type_) = 'CHASECONSUMER'   => 'CHASECONSUMER',
    StringLib.StringToUpperCase(bb_CC_Type_) = 'DINERS'          => 'DINERS',
    StringLib.StringToUpperCase(bb_CC_Type_) = 'DISCOVER'        => 'DISCOVER',
    StringLib.StringToUpperCase(bb_CC_Type_) = 'HRS'             => 'HRS',
    StringLib.StringToUpperCase(bb_CC_Type_) = 'MASTERCARD'      => 'MASTERCARD',
    StringLib.StringToUpperCase(bb_CC_Type_) = 'PAYPAL'          => 'PAYPAL',
    StringLib.StringToUpperCase(bb_CC_Type_) = 'VISA'            => 'VISA',
    StringLib.StringToUpperCase(bb_CC_Type_) = 'JCB'             => 'JCB',
                                                                    'OTHER');

avs_name_ver_1 := 0;

avs_addr_ver_1 := 0;

avs_zip5_ver_1 := 0;

avs_unvail_1 := 0;

avs_no_match_1 := 0;

avs_name_ver := map(
    pf_pmt_type = 'AMERICANEXPRESS' => (trim(bb_AVS_Code_) in ['L', 'M', 'O', 'K']),
    pf_pmt_type = 'CHASECONSUMER'   => avs_name_ver_1,
    pf_pmt_type = 'DISCOVER'        => avs_name_ver_1,
    pf_pmt_type = 'VISA'            => avs_name_ver_1,
    pf_pmt_type = 'MASTERCARD'      => avs_name_ver_1,
    pf_pmt_type = 'HRS'             => avs_name_ver_1,
                                       avs_name_ver_1);

avs_unvail := map(
    pf_pmt_type = 'AMERICANEXPRESS' => (trim(bb_AVS_Code_) in ['U']),
    pf_pmt_type = 'CHASECONSUMER'   => (trim(bb_AVS_Code_) in ['IU']),
    pf_pmt_type = 'DISCOVER'        => (trim(bb_AVS_Code_) in ['U']),
    pf_pmt_type = 'VISA'            => (trim(bb_AVS_Code_) in ['U']),
    pf_pmt_type = 'MASTERCARD'      => (trim(bb_AVS_Code_) in ['U']),
    pf_pmt_type = 'HRS'             => (trim(bb_AVS_Code_) in ['U']),
                                       (trim(bb_AVS_Code_) in ['X']));

avs_addr_ver := map(
    pf_pmt_type = 'AMERICANEXPRESS' => (trim(bb_AVS_Code_) in ['Y', 'A', 'M', 'O', 'E', 'F']),
    pf_pmt_type = 'CHASECONSUMER'   => (trim(bb_AVS_Code_) in ['I1', 'I3', 'I5', 'I7']),
    pf_pmt_type = 'DISCOVER'        => (trim(bb_AVS_Code_) in ['X', 'A', 'Y']),
    pf_pmt_type = 'VISA'            => (trim(bb_AVS_Code_) in ['A', 'B', 'D', 'F', 'M', 'Y']),
    pf_pmt_type = 'MASTERCARD'      => (trim(bb_AVS_Code_) in ['A', 'B', 'D', 'F', 'M', 'Y']),
    pf_pmt_type = 'HRS'             => (trim(bb_AVS_Code_) in ['Y', 'A']),
                                       (trim(bb_AVS_Code_) in ['A', 'F']));

avs_no_match := map(
    pf_pmt_type = 'AMERICANEXPRESS' => (trim(bb_AVS_Code_) in ['N', 'W']),
    pf_pmt_type = 'CHASECONSUMER'   => (trim(bb_AVS_Code_) in ['I6', 'I8']),
    pf_pmt_type = 'DISCOVER'        => (trim(bb_AVS_Code_) in ['N']),
    pf_pmt_type = 'VISA'            => (trim(bb_AVS_Code_) in ['N']),
    pf_pmt_type = 'MASTERCARD'      => (trim(bb_AVS_Code_) in ['N']),
    pf_pmt_type = 'HRS'             => (trim(bb_AVS_Code_) in ['N']),
                                       (trim(bb_AVS_Code_) in ['N']));

avs_zip5_ver := map(
    pf_pmt_type = 'AMERICANEXPRESS' => (trim(bb_AVS_Code_) in ['Y', 'Z', 'L', 'M', 'D', 'E']),
    pf_pmt_type = 'CHASECONSUMER'   => (trim(bb_AVS_Code_) in ['I1', 'I2', 'I3', 'I4']),
    pf_pmt_type = 'DISCOVER'        => (trim(bb_AVS_Code_) in ['X', 'A', 'T', 'Z']),
    pf_pmt_type = 'VISA'            => (trim(bb_AVS_Code_) in ['D', 'F', 'M', 'P', 'Y', 'Z']),
    pf_pmt_type = 'MASTERCARD'      => (trim(bb_AVS_Code_) in ['D', 'F', 'M', 'P', 'Y', 'Z']),
    pf_pmt_type = 'HRS'             => (trim(bb_AVS_Code_) in ['Y', 'Z']),
                                       (trim(bb_AVS_Code_) in ['Z', 'F']));

pf_avs_ver_lvl := map(
    pf_pmt_type = 'AMERICANEXPRESS' and (boolean)avs_name_ver => '0NM',
    pf_pmt_type = 'PAYPAL'                                    => '7NA',
    pf_pmt_type = 'GIFT CARD'                                 => '7NA',
    avs_no_match                                              => '5NO',
    avs_addr_ver and avs_zip5_ver                             => '1AZ',
    avs_addr_ver and not(avs_zip5_ver)                        => '2AX',
    not(avs_addr_ver) and avs_zip5_ver                        => '3XZ',
    avs_unvail                                                => '6UN',
                                                                 '4XX');
																 
pf_cid_match := map(
    trim(StringLib.StringToUpperCase(bb_CVV_Description_)) = 'MATCH'    => 1,
    trim(StringLib.StringToUpperCase(bb_CVV_Description_)) = 'NO MATCH' => 0,
                                                                           -1);
										
valid_tm_account := bb_Entry_Type_ = 'WEB' and not(TM_Device_Result_ = '');

tm_not_us_time_zone_f := valid_tm_account and not((TM_Time_Zone_Hours_ in [-8, -7, -6, -5])) and not((String)TM_Time_Zone_Hours_ = '');

tm_bad_reason_code_lvl := map(
    valid_tm_account and (trim(TM_Reason_Code_) in ['CC RISKY PERSONA - GLOBAL/DAY', 'GEO LANG MISMATCH', 'SMARTID INVOLVED IN REJECTED TRANSACTION- MONTH', 'SMARTID USED 5 CCS IN WEEK', 'TIME ZONE/TRUE GEO MISMATCH', 'TRUE IP ADDRESS IN GLOBAL BLACK LIST']) and not(TM_Reason_Code_ = '')                                                                                                                                                                                                                                                                                                             => 2,
	valid_tm_account and (trim(TM_Reason_Code_) in ['ACCOUNT EMAIL IN REJECTED TRANSACTION- MONTH', 'CC INVOLVED IN REJECTED TX- MONTH', 'CC USED BY 5 EXACTIDS IN A WEEK GLOBAL', 'DEVICE INVL REJECTED TRANSACTION- MONTH', 'EMAIL IN GLOBAL BLACK LIST', 'EMAIL REPUTATION', 'IP IN GLOBAL THREAT LIST', 'MULTIPLE PERSONAS - EXACTID - GLOBAL/DAY', 'MULTIPLE PERSONAS - EXACTID - GLOBAL/WEEK', 'MULTIPLE PERSONAS - EXACTID - LOCAL/DAY', 'PROXY GEO/TRUE GEO MISMATCH', 'PROXY IP IN GLOBAL BLACK LIST', 'SMARTID USED 5 CC IN WEEK', 'SMARTID USED 5 CCS IN A MONTH']) and not(TM_Reason_Code_ = '') => 1,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                0);

tm_bad_reason_code_f := valid_tm_account and (trim(TM_Reason_Code_) in ['CC RISKY PERSONA - GLOBAL/DAY', 'GEO LANG MISMATCH', 'SMARTID INVOLVED IN REJECTED TRANSACTION- MONTH', 'SMARTID USED 5 CCS IN WEEK', 'TIME ZONE/TRUE GEO MISMATCH', 'TRUE IP ADDRESS IN GLOBAL BLACK LIST']) and not(TM_Reason_Code_ = '');        

ip_state := map(
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'ALABAMA'        => 'AL',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'ALASKA'         => 'AK',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'ARIZONA'        => 'AZ',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'ARKANSAS'       => 'AR',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'CALIFORNIA'     => 'CA',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'COLORADO'       => 'CO',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'CONNECTICUT'    => 'CT',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'DELAWARE'       => 'DE',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'FLORIDA'        => 'FL',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'GEORGIA'        => 'GA',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'HAWAII'         => 'HI',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'IDAHO'          => 'ID',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'ILLINOIS'       => 'IL',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'INDIANA'        => 'IN',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'IOWA'           => 'IA',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'KANSAS'         => 'KS',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'KENTUCKY'       => 'KY',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'LOUISIANA'      => 'LA',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'MAINE'          => 'ME',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'MARYLAND'       => 'MD',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'MASSACHUSETTS'  => 'MA',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'MICHIGAN'       => 'MI',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'MINNESOTA'      => 'MN',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'MISSISSIPPI'    => 'MS',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'MISSOURI'       => 'MO',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'MONTANA'        => 'MT',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'NEBRASKA'       => 'NE',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'NEVADA'         => 'NV',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'NEW HAMPSHIRE'  => 'NH',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'NEW JERSEY'     => 'NJ',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'NEW MEXICO'     => 'NM',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'NEW YORK'       => 'NY',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'NORTH CAROLINA' => 'NC',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'NORTH DAKOTA'   => 'ND',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'OHIO'           => 'OH',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'OKLAHOMA'       => 'OK',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'OREGON'         => 'OR',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'PENNSYLVANIA'   => 'PA',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'RHODE ISLAND'   => 'RI',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'SOUTH CAROLINA' => 'SC',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'SOUTH DAKOTA'   => 'SD',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'TENNESSEE'      => 'TN',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'TEXAS'          => 'TX',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'UTAH'           => 'UT',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'VERMONT'        => 'VT',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'VIRGINIA'       => 'VA',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'WASHINGTON'     => 'WA',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'WEST VIRGINIA'  => 'WV',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'WISCONSIN'      => 'WI',
    StringLib.StringToUpperCase(TM_True_IP_Region_) = 'WYOMING'        => 'WY',
                                                                          '  ');

state_match_lvl := map(
    valid_tm_account and not(trim(ip_state) = '') and not(trim(in_state) = '') and StringLib.StringToUpperCase(in_state) = ip_state => 1,
    valid_tm_account and not(trim(ip_state) = '') and not(trim(in_state) = '')                                                      => 0,
    valid_tm_account and (trim(ip_state) = '' or trim(in_state) = '')                                                               => -1,
                                                                                                                                       -2);

b_hist_addr_match_i := map(
    not(truedid)            => NULL,
    hist_addr_match = -9999 => 99,
    hist_addr_match = 0     => 100,
                               min(if(hist_addr_match = NULL, -NULL, hist_addr_match), 98));

b_corraddrnamecount_d := if(not(truedid), NULL, min(if((Integer)fp_corraddrnamecount = NULL, -NULL, (Integer)fp_corraddrnamecount), 999));

b_inq_count24_i := if(not(truedid), NULL, min(if((Integer)inq_count24 = NULL, -NULL, (Integer)inq_count24), 999));

b_corrrisktype_i := map(
    not(truedid)                    => NULL,
    (Integer)fp_corrrisktype = NULL => NULL,
                                       (Integer)fp_corrrisktype);

s_inq_per_phone_i := if(not(hphnpop_s), NULL, min(if(inq_perphone_s = NULL, -NULL, inq_perphone_s), 999));

b_inq_count12_i := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

s_add_invalid_i := map(
    not(addrpop_s)                                        => NULL,
    trim(trim(rc_addrvalflag_s, LEFT), LEFT, RIGHT) = 'N' => 1,
                                                             0);

s_corrrisktype_i := map(
    not(truedid_s)                    => NULL,
    (Integer)fp_corrrisktype_s = NULL => NULL,
                                         (Integer)fp_corrrisktype_s);

b_inq_retail_recency_d := map(
    not(truedid)       => NULL,
    (Boolean)inq_retail_count01 => 1,
    (Boolean)inq_retail_count03 => 3,
    (Boolean)inq_retail_count06 => 6,
    (Boolean)inq_retail_count12 => 12,
    (Boolean)inq_retail_count24 => 24,
    (Boolean)inq_retail_count   => 99,
                                   999);

b_inq_per_addr_i := if(not(addrpop), NULL, min(if((String)inq_peraddr = '', -NULL, (Real)inq_peraddr), 999));

s_phn_not_issued_i := map(
    not(hphnpop_s)                 => NULL,
    (rc_pwphonezipflag_s in ['4']) => 1,
                                      0);

b_corrphonelastnamecount_d := if(not(truedid), NULL, min(if((Integer)fp_corrphonelastnamecount = NULL, -NULL, (Integer)fp_corrphonelastnamecount), 999));

s_corraddrnamecount_d := if(not(truedid_s), NULL, min(if((Integer)fp_corraddrnamecount_s = NULL, -NULL, (Integer)fp_corraddrnamecount_s), 999));

b_inq_per_phone_i := if(not(hphnpop), NULL, min(if((Integer)inq_perphone = NULL, -NULL, (Integer)inq_perphone), 999));

b_inq_other_count24_i := if(not(truedid), NULL, min(if((Integer)inq_Other_count24 = NULL, -NULL, (Integer)inq_Other_count24), 999));

b_srchvelocityrisktype_i := map(
    not(truedid)                 => NULL,
    fp_srchvelocityrisktype = '' => NULL,
                                    (REAL)fp_srchvelocityrisktype);

s_inq_retail_recency_d := map(
    not(truedid_s)       => NULL,
    (Boolean)inq_retail_count01_s => 1,
    (Boolean)inq_retail_count03_s => 3,
    (Boolean)inq_retail_count06_s => 6,
    (Boolean)inq_retail_count12_s => 12,
    (Boolean)inq_retail_count24_s => 24,
    (Boolean)inq_retail_count_s   => 99,
                                     999);

s_inq_count24_i := if(not(truedid_s), NULL, min(if(inq_count24_s = NULL, -NULL, inq_count24_s), 999));

s_estimated_income_d := if(not(truedid_s), NULL, estimated_income_s);

s_inq_per_addr_i := if(not(addrpop_s), NULL, min(if(inq_peraddr_s = NULL, -NULL, inq_peraddr_s), 999));

s_idverrisktype_i := if(not(truedid_s) or (Integer)fp_idverrisktype_s = NULL, NULL, (Integer)fp_idverrisktype_s);

b_idverrisktype_i := if(not(truedid) or (Integer)fp_idverrisktype = NULL, NULL, (Integer)fp_idverrisktype);

s_bus_name_match_d := if(not(addrpop_s), NULL, bus_name_match_s);

s_credit_seeking_i := if(not(truedid_s), NULL, if(max(min(2, if(inq_auto_count03_s = NULL, -NULL, inq_auto_count03_s)), min(2, if(inq_banking_count03_s = NULL, -NULL, inq_banking_count03_s)), min(2, if(inq_mortgage_count03_s = NULL, -NULL, inq_mortgage_count03_s)), min(2, if(inq_retail_count03_s = NULL, -NULL, inq_retail_count03_s)), min(2, if(inq_communications_count03_s = NULL, -NULL, inq_communications_count03_s))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03_s = NULL, -NULL, inq_auto_count03_s)) = NULL, 0, min(2, if(inq_auto_count03_s = NULL, -NULL, inq_auto_count03_s))), if(min(2, if(inq_banking_count03_s = NULL, -NULL, inq_banking_count03_s)) = NULL, 0, min(2, if(inq_banking_count03_s = NULL, -NULL, inq_banking_count03_s))), if(min(2, if(inq_mortgage_count03_s = NULL, -NULL, inq_mortgage_count03_s)) = NULL, 0, min(2, if(inq_mortgage_count03_s = NULL, -NULL, inq_mortgage_count03_s))), if(min(2, if(inq_retail_count03_s = NULL, -NULL, inq_retail_count03_s)) = NULL, 0, min(2, if(inq_retail_count03_s = NULL, -NULL, inq_retail_count03_s))), if(min(2, if(inq_communications_count03_s = NULL, -NULL, inq_communications_count03_s)) = NULL, 0, min(2, if(inq_communications_count03_s = NULL, -NULL, inq_communications_count03_s))))));

b_inq_ssns_per_addr_i := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

s_varrisktype_i := map(
    not(truedid_s)                   => NULL,
    (Integer)fp_varrisktype_s = NULL => NULL,
                                        (Integer)fp_varrisktype_s);

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

b_comb_age_d := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

b_srchcomponentrisktype_i := map(
    not(truedid)                             => NULL,
    (Integer)fp_srchcomponentrisktype = NULL => NULL,
                                                (Integer)fp_srchcomponentrisktype);


// Tree: 1 
final_score_1 := map(
(pf_pmt_type = '') => -0.0251187046,
(pf_pmt_type in ['GIFT CARD','HRS','OTHER','PAYPAL']) => -0.2466719726,
(pf_pmt_type in ['AMERICANEXPRESS','DISCOVER','MASTERCARD','VISA','DINERS','JCB']) => 
   map(
   (pf_CID_match = NULL) => 0.0430103015,
   (NULL < (Real)pf_CID_match and (Real)pf_CID_match <= 0.5) => 
      map(
	  (pf_avs_ver_lvl = '') => 0.2385227826,
      (pf_avs_ver_lvl in ['4XX','6UN']) => -0.1753700658,
      (pf_avs_ver_lvl in ['0NM','1AZ','2AX','3XZ','5NO','7NA']) => 0.8587903800, 0),
   ((Real)pf_CID_match > 0.5) => 0.0167824870, 0), 0);

// Tree: 2 
final_score_2 := map(
((String)avg_pmt_amt = '') => -0.0431707373,
(NULL < avg_pmt_amt and avg_pmt_amt <= 86.52) => -0.1814186052,
(avg_pmt_amt > 86.52) => 
   map(
   (b_corrphonelastnamecount_d = NULL) => 
      map(
	  (c_hval_125k_p = '') => 0.1085535921,
      (NULL < (Real)c_hval_125k_p and (Real)c_hval_125k_p <= 35.35) => 0.1913486145,
      ((Real)c_hval_125k_p > 35.35) => -1.1605176541, 0),
   (NULL < b_corrphonelastnamecount_d and b_corrphonelastnamecount_d <= 0.5) => 0.2554682935,
   (b_corrphonelastnamecount_d > 0.5) => -0.0759155866, 0), 0);

// Tree: 3 
final_score_3 := map(
(tm_bad_reason_code_lvl = NULL) => -0.0199176614,
(NULL < tm_bad_reason_code_lvl and tm_bad_reason_code_lvl <= 0.5) => 
   map(
   (s_inq_per_addr_i = NULL) => -0.0309671812,
   (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 7.5) => 
      map(
	  (b_srchvelocityrisktype_i = NULL) => -0.0300774765,
      (NULL < b_srchvelocityrisktype_i and b_srchvelocityrisktype_i <= 8.5) => -0.0636942271,
      (b_srchvelocityrisktype_i > 8.5) => 0.5746110885, 0),
   (s_inq_per_addr_i > 7.5) => 0.3002139609, 0),
((Real)tm_bad_reason_code_lvl > 0.5) => 0.4963770863, 0);

// Tree: 4 
final_score_4 := map(
(pf_order_amount = NULL) => -0.0526316899,
(NULL < pf_order_amount and pf_order_amount <= 1.175) => 
   map(
   ((Integer)tm_not_us_time_zone_f = NULL) => 0.5968872752,
   (NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 0.4676614229,
   ((Real)tm_not_us_time_zone_f > 0.5) => 1.0732870589, 0),
(pf_order_amount > 1.175) => 
   map(
   ((String)avg_pmt_amt = '') => -0.0629933703,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 29.27) => -0.4110606058,
   (avg_pmt_amt > 29.27) => 0.0179048564, 0), 0);

// Tree: 5 
final_score_5 := map(
(b_corraddrnamecount_d = NULL) => 0.3825143015,
(NULL < b_corraddrnamecount_d and b_corraddrnamecount_d <= 0.5) => 0.3128521848,
(b_corraddrnamecount_d > 0.5) => 
   map(
   ((String)lastscore = '') => -0.1482623099,
   (NULL < lastscore and lastscore <= 93.5) => 
      map(
	  ((Integer)btst_relatives_in_common = NULL) => 0.4020682553,
      (NULL < (Real)btst_relatives_in_common and (Real)btst_relatives_in_common <= 0.5) => 0.6863519469,
      ((Real)btst_relatives_in_common > 0.5) => -0.3170641940, 0),
   (lastscore > 93.5) => -0.1812932349, 0), 0);

// Tree: 6 
final_score_6 := map(
(s_Add_Invalid_i = NULL) => -0.0465822625,
(NULL < (Real)s_Add_Invalid_i and (Real)s_Add_Invalid_i <= 0.5) => 
   map(
   (pf_order_amount = NULL) => -0.0554653025,
   (NULL < pf_order_amount and pf_order_amount <= 219.535) => -0.1373795682,
   (pf_order_amount > 219.535) => 
      map(
	  ((String)state_match_lvl = '') => 0.0776823737,
      (NULL < (Real)state_match_lvl and (Real)state_match_lvl <= 0.5) => 0.2042456376,
      ((Real)state_match_lvl > 0.5) => -0.0250409736, 0), 0),
((Real)s_Add_Invalid_i > 0.5) => 0.4194210669, 0);

// Tree: 7 
final_score_7 := map(
(pf_ship_mode = '') => -0.0185591200,
(pf_ship_mode in ['GROUND','SECOND DAY','STANDARD']) => 
   map(
   (bb_Line_Type_Header_ = '') => -0.0296097611,
   (bb_Line_Type_Header_ in ['DELIVERY','INSTORE','SHIPTOHOME']) => -0.0727081323,
   (bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','MOBILEPLAN']) => 
      map(
	  (pf_num_items = NULL) => 0.2012006165,
      (NULL < (Real)pf_num_items and (Real)pf_num_items <= 1.5) => 1.7860165873,
      ((Real)pf_num_items > 1.5) => 0.1513062749, 0), 0),
(pf_ship_mode in ['NEXT DAY']) => 0.3200416170, 0);

// Tree: 8 
final_score_8 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0557161293,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   ((Integer)valid_tm_account = NULL) => -0.1029225114,
   (NULL < (Real)valid_tm_account and (Real)valid_tm_account <= 0.5) => 0.0925578102,
   ((Real)valid_tm_account > 0.5) => -0.2106416304, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (b_inq_count24_i = NULL) => 0.1452112252,
   (NULL < b_inq_count24_i and b_inq_count24_i <= 15.5) => 0.0859802651,
   (b_inq_count24_i > 15.5) => 0.4488126240, 0), 0);

// Tree: 9 
final_score_9 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0665389036,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   ((Integer)valid_tm_account = NULL) => -0.1170031025,
   (NULL < (Real)valid_tm_account and (Real)valid_tm_account <= 0.5) => 0.0924053981,
   ((Real)valid_tm_account > 0.5) => -0.2302335596, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (bb_Line_Type_Header_ = '') => 0.1311849410,
   (bb_Line_Type_Header_ in ['DELIVERY','INSTORE']) => -0.0443612592,
   (bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','MOBILEPLAN','SHIPTOHOME']) => 0.2305889912, 0), 0);

// Tree: 10 
final_score_10 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0630268242,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   ((Integer)valid_tm_account = NULL) => -0.1113854499,
   (NULL < (Real)valid_tm_account and (Real)valid_tm_account <= 0.5) => 0.0970181086,
   ((Real)valid_tm_account > 0.5) => -0.2234249226, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (b_inq_per_addr_i = NULL) => 0.1191336055,
   (NULL < b_inq_per_addr_i and b_inq_per_addr_i <= 4.5) => 0.0767702731,
   (b_inq_per_addr_i > 4.5) => 0.4178723447, 0), 0);

// Tree: 11 
final_score_11 := map(
(b_corrphonelastnamecount_d = NULL) => -0.0083635431,
(NULL < (Real)b_corrphonelastnamecount_d and (Real)b_corrphonelastnamecount_d <= 0.5) => 
   map(
   (pf_avs_ver_lvl = '') => 0.0449451659,
   (pf_avs_ver_lvl in ['0NM','1AZ','2AX','3XZ','4XX','7NA']) => 0.0349650386,
   (pf_avs_ver_lvl in ['5NO','6UN']) => 
      map(
	  (s_idverrisktype_i = NULL) => -0.0107421006,
      (NULL < s_idverrisktype_i and s_idverrisktype_i <= 4) => 0.3779135063,
      (s_idverrisktype_i > 4) => 0.0596165259, 0), 0),
((Real)b_corrphonelastnamecount_d > 0.5) => -0.0703876865, 0);

// Tree: 12 
final_score_12 := map(
(bb_Line_Type_Header_ = '') => 0.0021321459,
(bb_Line_Type_Header_ in ['DELIVERY']) => -0.3123706569,
(bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','INSTORE','MOBILEPLAN','SHIPTOHOME']) => 
   map(
   (b_comb_age_d = NULL) => 
      map(
	  ((Integer)valid_tm_account = NULL) => -0.0209979331,
      (NULL < (Real)valid_tm_account and (Real)valid_tm_account <= 0.5) => 0.1102859152,
      ((Real)valid_tm_account > 0.5) => -0.0820024676, 0),
   (NULL < b_comb_age_d and b_comb_age_d <= 76.5) => 0.0059413669,
   (b_comb_age_d > 76.5) => 0.3548963474, 0), 0);

// Tree: 13 
final_score_13 := map(
(pf_order_amount = NULL) => -0.0421408410,
(NULL < pf_order_amount and pf_order_amount <= 653.11) => 
   map(
   (s_inq_per_phone_i = NULL) => -0.1309839719,
   (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 3.5) => 
      map(
	  (s_corrrisktype_i = NULL) => 0.2033272176,
      (NULL < s_corrrisktype_i and s_corrrisktype_i <= 8.5) => -0.1136437472,
      (s_corrrisktype_i > 8.5) => 0.0851613683, 0),
   (s_inq_per_phone_i > 3.5) => 0.3360395513, 0),
(pf_order_amount > 653.11) => 0.1777813256, 0);

// Tree: 14 
final_score_14 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0594643288,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   ((Integer)valid_tm_account = NULL) => -0.1210588176,
   (NULL < (Real)valid_tm_account and (Real)valid_tm_account <= 0.5) => 
      map(
	  ((String)avg_pmt_amt = '') => 0.0390920278,
      (NULL < avg_pmt_amt and avg_pmt_amt <= 218.491666665) => -0.0891409333,
      (avg_pmt_amt > 218.491666665) => 0.3374453678, 0),
   ((Real)valid_tm_account > 0.5) => -0.2096094908, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 0.1756660661, 0);

// Tree: 15 
final_score_15 := map(
(pf_order_amount = NULL) => -0.0295159896,
(NULL < pf_order_amount and pf_order_amount <= 531.33) => 
   map(
   (s_Phn_Not_Issued_i = NULL) => -0.1311256437,
   (NULL < (Real)s_Phn_Not_Issued_i and (Real)s_Phn_Not_Issued_i <= 0.5) => -0.0208343657,
   ((Real)s_Phn_Not_Issued_i > 0.5) => 0.4230420530, 0),
(pf_order_amount > 531.33) => 
   map(
   (b_corrphonelastnamecount_d = NULL) => 0.2110319637,
   (NULL < (Real)b_corrphonelastnamecount_d and (Real)b_corrphonelastnamecount_d <= 0.5) => 0.1957392248,
   ((Real)b_corrphonelastnamecount_d > 0.5) => -0.0005742091, 0), 0);

// Tree: 16 
final_score_16 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0471192899,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   (pf_ship_mode = '') => -0.0949719781,
   (pf_ship_mode in ['GROUND','SECOND DAY','STANDARD']) => -0.1081396406,
   (pf_ship_mode in ['NEXT DAY']) => 0.4296019683, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (b_inq_count24_i = NULL) => 0.2017004816,
   (NULL < b_inq_count24_i and b_inq_count24_i <= 15.5) => 0.0918673542,
   (b_inq_count24_i > 15.5) => 0.4322251147, 0), 0);

// Tree: 17 
final_score_17 := map(
(distaddraddr2 = '') => -0.0459852510,
(NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 21.5) => 
   map(
   (pf_avs_ver_lvl = '') => -0.0931260443,
   (pf_avs_ver_lvl in ['0NM','1AZ','2AX','3XZ','4XX','7NA']) => -0.1174215937,
   (pf_avs_ver_lvl in ['5NO','6UN']) => 0.3017455840, 0),
((Real)distaddraddr2 > 21.5) => 
   map(
   (pf_order_amount = NULL) => 0.1956890154,
   (NULL < pf_order_amount and pf_order_amount <= 326.575) => 0.0461988897,
   (pf_order_amount > 326.575) => 0.3436286029, 0), 0);

// Tree: 18 
final_score_18 := map(
(distphone2addr2 = '') => 
   map(
   (b_inq_per_addr_i = NULL) => -0.0046910594,
   (NULL < b_inq_per_addr_i and b_inq_per_addr_i <= 4.5) => -0.0146099056,
   (b_inq_per_addr_i > 4.5) => 0.0939006808, 0),
(NULL < (Real)distphone2addr2 and (Real)distphone2addr2 <= 0.5) => -0.0750514685,
((Real)distphone2addr2 > 0.5) => 
   map(
   (s_corrrisktype_i = NULL) => 0.1731006141,
   (NULL < s_corrrisktype_i and s_corrrisktype_i <= 6.5) => -0.0935298278,
   (s_corrrisktype_i > 6.5) => 0.1718132574, 0), 0);

// Tree: 19 
final_score_19 := map(
(distaddraddr2 = '') => -0.0318430385,
(NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 18.5) => 
   map(
   (pf_avs_ver_lvl in ['0NM','1AZ','2AX','3XZ','4XX','7NA']) => 
      map(
	  (b_inq_per_addr_i = NULL) => -0.0706606586,
      (NULL < b_inq_per_addr_i and b_inq_per_addr_i <= 10.5) => -0.0784642647,
      (b_inq_per_addr_i > 10.5) => 0.3033197562, 0),
   (pf_avs_ver_lvl in ['5NO','6UN']) => 0.1326740687,
   (pf_avs_ver_lvl = '') => -0.0581682628, 0),
((Real)distaddraddr2 > 18.5) => 0.0913820519, 0);

// Tree: 20 
final_score_20 := map(
(pf_order_amount = NULL) => -0.0101696181,
(NULL < pf_order_amount and pf_order_amount <= 1899.79) => 
   map(
   (pf_order_amount = NULL) => -0.0125722175,
   (NULL < pf_order_amount and pf_order_amount <= 1.175) => 0.2051551144,
   (pf_order_amount > 1.175) => 
      map(
	  ((String)avg_pmt_amt = '') => -0.0161167992,
      (NULL < avg_pmt_amt and avg_pmt_amt <= 29.3175) => -0.1325166865,
      (avg_pmt_amt > 29.3175) => 0.0117085581, 0), 0),
(pf_order_amount > 1899.79) => 0.1317064051, 0);

// Tree: 21 
final_score_21 := map(
(distaddraddr2 = '') => -0.0080054267,
(NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 8.5) => -0.0196019236,
((Real)distaddraddr2 > 8.5) => 
   map(
   ((Integer)btst_are_relatives = NULL) => 0.0267423168,
   (NULL < (Real)btst_are_relatives and (Real)btst_are_relatives <= 0.5) => 
      map(
	  (c_hval_80k_p = '') => -0.0946762687,
      (NULL < (Real)c_hval_80k_p and (Real)c_hval_80k_p <= 3.15) => 0.0673066974,
      ((Real)c_hval_80k_p > 3.15) => -0.0213969909, 0),
   ((Real)btst_are_relatives > 0.5) => -0.1970220400, 0), 0);

// Tree: 22 
final_score_22 := map(
(s_Phn_Not_Issued_i = NULL) => 
   map(
   (pf_order_amount = NULL) => -0.0528830705,
   (NULL < pf_order_amount and pf_order_amount <= 518.36) => -0.0863821985,
   (pf_order_amount > 518.36) => 0.0740491387, 0),
(NULL < s_Phn_Not_Issued_i and s_Phn_Not_Issued_i <= 0.5) => 
   map(
   (s_estimated_income_d = NULL) => 0.0714030492,
   (NULL < s_estimated_income_d and s_estimated_income_d <= 22500) => 0.0853732771,
   (s_estimated_income_d > 22500) => -0.0374649889, 0),
(s_Phn_Not_Issued_i > 0.5) => 0.2466178669, 0);

// Tree: 23 
final_score_23 := map(
((String)state_match_lvl = '') => -0.0100511869,
(NULL < state_match_lvl and state_match_lvl <= 0.5) => 0.0303726743,
(state_match_lvl > 0.5) => 
   map(
   (pf_ship_mode = '') => -0.0374708802,
   (pf_ship_mode in ['GROUND','STANDARD']) => -0.0474180439,
   (pf_ship_mode in ['NEXT DAY','SECOND DAY']) => 
      map(
	  (s_varrisktype_i = NULL) => 0.1476459381,
      (NULL < s_varrisktype_i and s_varrisktype_i <= 3.5) => 0.0420832972,
      (s_varrisktype_i > 3.5) => 0.3145237699, 0), 0), 0);

// Tree: 24 
final_score_24 := map(
(distaddraddr2 = '') => -0.0214268884,
(NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 14.5) => 
   map(
   (b_Inq_Count12_i = NULL) => -0.0048033752,
   (NULL < b_Inq_Count12_i and b_Inq_Count12_i <= 16.5) => -0.0493424175,
   (b_Inq_Count12_i > 16.5) => 0.1815422092, 0),
((Real)distaddraddr2 > 14.5) => 
   map(
   (pf_pmt_type = '') => 0.0574313198,
   (pf_pmt_type in ['GIFT CARD','HRS','PAYPAL']) => -0.0907687667,
   (pf_pmt_type in ['AMERICANEXPRESS','DISCOVER','MASTERCARD','OTHER','VISA','DINERS','JCB']) => 0.0832071969, 0), 0);

// Tree: 25 
final_score_25 := map(
(distaddraddr2 = '') => -0.0337303461,
(NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 59.5) => 
   map(
   (pf_avs_ver_lvl = '') => -0.0657902206,
   (pf_avs_ver_lvl in ['0NM','1AZ','3XZ','4XX','7NA']) => 
      map(
	  (b_inq_count24_i = NULL) => 0.0952332102,
      (NULL < b_inq_count24_i and b_inq_count24_i <= 66) => -0.1020481502,
      (b_inq_count24_i > 66) => 0.3900129947, 0),
   (pf_avs_ver_lvl in ['2AX','5NO','6UN']) => 0.2632584591, 0),
((Real)distaddraddr2 > 59.5) => 0.1990914045, 0);

// Tree: 26 
final_score_26 := map(
((String)C_BORN_USA_s = '') => -0.0361515418,
(NULL < (Real)C_BORN_USA_s and (Real)C_BORN_USA_s <= 51.5) => 
   map(
   (distaddraddr2 = '') => 0.0375141171,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 8.5) => 0.0178694031,
   ((Real)distaddraddr2 > 8.5) => 
      map(
	  (c_hval_125k_p = '') => 0.0901105865,
      (NULL < (Real)c_hval_125k_p and (Real)c_hval_125k_p <= 42.35) => 0.1018858802,
      ((Real)c_hval_125k_p > 42.35) => -0.1683714703, 0), 0),
((Real)C_BORN_USA_s > 51.5) => -0.0240644022, 0);

// Tree: 27 
final_score_27 := map(
(pf_avs_ver_lvl = '') => -0.0197782899,
(pf_avs_ver_lvl in ['0NM','1AZ','3XZ','4XX','7NA']) => 
   map(
   (distaddraddr2 = '') => -0.0269357590,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 12.5) => -0.0467218762,
   ((Real)distaddraddr2 > 12.5) => 0.0505010414, 0),
(pf_avs_ver_lvl in ['2AX','5NO','6UN']) => 
   map(
   ((String)firstscore = '') => 0.0869289260,
   (NULL < firstscore and firstscore <= 91) => -0.0116902392,
   (firstscore > 91) => 0.1415412696, 0), 0);

// Tree: 28 
final_score_28 := map(
(bb_Line_Type_Header_ = '') => -0.0063414176,
(bb_Line_Type_Header_ in ['DELIVERY','INSTORE','SHIPTOHOME']) => 
   map(
   (s_Add_Invalid_i = NULL) => -0.0211217161,
   (NULL < s_Add_Invalid_i and s_Add_Invalid_i <= 0.5) => -0.0245066920,
   (s_Add_Invalid_i > 0.5) => 0.1498922481, 0),
(bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','MOBILEPLAN']) => 
   map(
   (pf_num_items = NULL) => 0.0712124386,
   (NULL < pf_num_items and pf_num_items <= 1.5) => 0.6068680636,
   (pf_num_items > 1.5) => 0.0562471080, 0), 0);

// Tree: 29 
final_score_29 := map(
(s_Add_Invalid_i = NULL) => -0.0169362822,
(NULL < s_Add_Invalid_i and s_Add_Invalid_i <= 0.5) => 
   map(
   ((String)avg_pmt_amt = '') => -0.0201828562,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 390.845) => 
      map(
	  (bb_Line_Type_Header_ = '') => -0.0325559389,
      (bb_Line_Type_Header_ in ['DELIVERY','INSTORE','SHIPTOHOME']) => -0.0524500649,
      (bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','MOBILEPLAN']) => 0.0671390872, 0),
   (avg_pmt_amt > 390.845) => 0.0613513603, 0),
(s_Add_Invalid_i > 0.5) => 0.1647423709, 0);

// Tree: 30 
final_score_30 := map(
(distaddraddr2 = '') => -0.0252286462,
(NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 17.5) => 
   map(
   (pf_avs_ver_lvl = '') => -0.0459503340,
   (pf_avs_ver_lvl in ['0NM','1AZ','2AX','3XZ','4XX','7NA']) => 
      map(
	  (s_inq_retail_recency_d = NULL) => -0.0580559075,
      (NULL < s_inq_retail_recency_d and s_inq_retail_recency_d <= 4.5) => 0.2296945338,
      (s_inq_retail_recency_d > 4.5) => -0.0629014071, 0),
   (pf_avs_ver_lvl in ['5NO','6UN']) => 0.0955683337, 0),
((Real)distaddraddr2 > 17.5) => 0.0704977454, 0);

// Tree: 31 
final_score_31 := map(
(pf_order_amount = NULL) => -0.0067998100,
(NULL < pf_order_amount and pf_order_amount <= 1335.705) => 
   map(
   (bb_Line_Type_Header_ = '') => -0.0108895110,
   (bb_Line_Type_Header_ in ['DELIVERY','INSTORE','MOBILEPLAN','SHIPTOHOME']) => -0.0238091387,
   (bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY']) => 
      map(
	  (pf_num_items = NULL) => 0.0619564254,
      (NULL < pf_num_items and pf_num_items <= 1.5) => 0.5934703490,
      (pf_num_items > 1.5) => 0.0442267203, 0), 0),
(pf_order_amount > 1335.705) => 0.1119059116, 0);

// Tree: 32 
final_score_32 := map(
((String)avg_pmt_amt = '') => -0.0292339021,
(NULL < avg_pmt_amt and avg_pmt_amt <= 381.585) => 
   map(
   (pf_avs_ver_lvl = '') => -0.0552739024,
   (pf_avs_ver_lvl in ['0NM','1AZ','3XZ','4XX','6UN','7NA']) => 
      map(
	  (distaddraddr2 = '') => -0.0651635820,
      (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 82.5) => -0.0780855772,
      ((Real)distaddraddr2 > 82.5) => 0.0777818061, 0),
   (pf_avs_ver_lvl in ['2AX','5NO']) => 0.1378531806, 0),
(avg_pmt_amt > 381.585) => 0.1270516883, 0);

// Tree: 33 
final_score_33 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0033804978,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   (distaddraddr2 = '') => -0.0683931082,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 52.5) => -0.0945035537,
   ((Real)distaddraddr2 > 52.5) => 0.1769559302, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   ((String)avg_pmt_amt = '') => 0.2440455294,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 199.6825) => 0.0979803245,
   (avg_pmt_amt > 199.6825) => 0.4375207253, 0), 0);

// Tree: 34 
final_score_34 := map(
(b_hist_addr_match_i = NULL) => 0.2368999766,
(NULL < b_hist_addr_match_i and b_hist_addr_match_i <= 99.5) => 
   map(
   (distaddraddr2 = '') => -0.0518278766,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 59.5) => -0.0726257406,
   ((Real)distaddraddr2 > 59.5) => 0.1460780214, 0),
(b_hist_addr_match_i > 99.5) => 
   map(
   ((String)avg_pmt_amt = '') => 0.1153925114,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 254.7925) => 0.0019234010,
   (avg_pmt_amt > 254.7925) => 0.2894218930, 0), 0);

// Tree: 35 
final_score_35 := map(
(b_hist_addr_match_i = NULL) => 0.2254929900,
(NULL < b_hist_addr_match_i and b_hist_addr_match_i <= 16.5) => 
   map(
   (distaddraddr2 = '') => -0.0504245658,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 55.5) => -0.0710880969,
   ((Real)distaddraddr2 > 55.5) => 0.1465218746, 0),
(b_hist_addr_match_i > 16.5) => 
   map(
   ((String)avg_pmt_amt = '') => 0.1167058796,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 297.58375) => 0.0182696831,
   (avg_pmt_amt > 297.58375) => 0.2973542400, 0), 0);

// Tree: 36 
final_score_36 := map(
(pf_order_amount = NULL) => -0.0110798853,
(NULL < pf_order_amount and pf_order_amount <= 729.435) => 
   map(
   (s_Add_Invalid_i = NULL) => -0.0197673095,
   (NULL < s_Add_Invalid_i and s_Add_Invalid_i <= 0.5) => 
      map(
	  (b_inq_per_phone_i = NULL) => -0.0652566074,
      (NULL < b_inq_per_phone_i and b_inq_per_phone_i <= 4.5) => -0.0245900945,
      (b_inq_per_phone_i > 4.5) => 0.1201335904, 0),
   (s_Add_Invalid_i > 0.5) => 0.1369600258, 0),
(pf_order_amount > 729.435) => 0.0651410101, 0);

// Tree: 37 
final_score_37 := map(
((String)avg_pmt_amt = '') => -0.0219200404,
(NULL < avg_pmt_amt and avg_pmt_amt <= 374.4925) => 
   map(
   ((Integer)tm_not_us_time_zone_f = NULL) => -0.0466154169,
   (NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0712070736,
   ((Real)tm_not_us_time_zone_f > 0.5) => 0.0625450795, 0),
(avg_pmt_amt > 374.4925) => 
   map(
   (b_hist_addr_match_i = NULL) => 0.2262908505,
   (NULL < b_hist_addr_match_i and b_hist_addr_match_i <= 9.5) => 0.0749383285,
   (b_hist_addr_match_i > 9.5) => 0.2089258974, 0), 0);

// Tree: 38 
final_score_38 := map(
(b_idverrisktype_i = NULL) => -0.0000395287,
(NULL < b_idverrisktype_i and b_idverrisktype_i <= 5.5) => 
   map(
   (s_Phn_Not_Issued_i = NULL) => -0.0282844534,
   (NULL < s_Phn_Not_Issued_i and s_Phn_Not_Issued_i <= 0.5) => 
      map(
	  (s_corraddrnamecount_d = NULL) => 0.0911576158,
      (NULL < s_corraddrnamecount_d and s_corraddrnamecount_d <= 0.5) => 0.0439460623,
      (s_corraddrnamecount_d > 0.5) => -0.0170877124, 0),
   (s_Phn_Not_Issued_i > 0.5) => 0.1309074235, 0),
(b_idverrisktype_i > 5.5) => 0.0447623015, 0);

// Tree: 39 
final_score_39 := map(
((String)avg_pmt_amt = '') => -0.0053460366,
(NULL < avg_pmt_amt and avg_pmt_amt <= 29.3175) => 
   map(
   ((String)avg_pmt_amt = '') => -0.0590731862,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 2.969) => 
      map(
	  (b_inq_ssns_per_addr_i = NULL) => 0.0698685282,
      (NULL < b_inq_ssns_per_addr_i and b_inq_ssns_per_addr_i <= 1.5) => 0.0155861837,
      (b_inq_ssns_per_addr_i > 1.5) => 0.2307535492, 0),
   (avg_pmt_amt > 2.969) => -0.0704038016, 0),
(avg_pmt_amt > 29.3175) => 0.0083961564, 0);

// Tree: 40 
final_score_40 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0130709900,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0250492103,
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (bb_Line_Type_Header_ = '') => 0.0321584494,
   (bb_Line_Type_Header_ in ['DELIVERY','INSTORE']) => -0.0129328743,
   (bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','MOBILEPLAN','SHIPTOHOME']) => 
      map(
	  (s_corrrisktype_i = NULL) => 0.0737752829,
      (NULL < s_corrrisktype_i and s_corrrisktype_i <= 5.5) => -0.0333571524,
      (s_corrrisktype_i > 5.5) => 0.0747298446, 0), 0), 0);

// Tree: 41 
final_score_41 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0056045012,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   (b_corraddrnamecount_d = NULL) => 0.1718533306,
   (NULL < b_corraddrnamecount_d and b_corraddrnamecount_d <= 0.5) => 0.0376863545,
   (b_corraddrnamecount_d > 0.5) => -0.0723614162, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (distaddraddr2 = '') => 0.1629121755,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 18.5) => 0.0890086644,
   ((Real)distaddraddr2 > 18.5) => 0.3459982401, 0), 0);

// Tree: 42 
final_score_42 := map(
(pf_pmt_type = '') => -0.0031361235,
(pf_pmt_type in ['GIFT CARD','HRS','OTHER','PAYPAL']) => -0.0363578101,
(pf_pmt_type in ['AMERICANEXPRESS','DISCOVER','MASTERCARD','VISA','DINERS','JCB']) => 
   map(
   (pf_CID_match = NULL) => 0.0070939570,
   (NULL < pf_CID_match and pf_CID_match <= 0.5) => 
      map(
	  (pf_CID_match = NULL) => 0.0444593390,
      (NULL < pf_CID_match and pf_CID_match <= -0.5) => 0.0256953318,
      (pf_CID_match > -0.5) => 0.1727339749, 0),
   (pf_CID_match > 0.5) => 0.0020512531, 0), 0);

// Tree: 43 
final_score_43 := map(
(pf_order_amount = NULL) => -0.0195948428,
(NULL < pf_order_amount and pf_order_amount <= 635.985) => 
   map(
   ((Integer)tm_not_us_time_zone_f = NULL) => -0.0359937181,
   (NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0523436256,
   ((Real)tm_not_us_time_zone_f > 0.5) => 
      map(
	  (b_inq_count24_i = NULL) => 0.0882758952,
      (NULL < b_inq_count24_i and b_inq_count24_i <= 15.5) => 0.0136077230,
      (b_inq_count24_i > 15.5) => 0.1715687594, 0), 0),
(pf_order_amount > 635.985) => 0.0878462782, 0);

// Tree: 44 
final_score_44 := map(
(C_HH7P_P_s = '') => -0.0125804415,
(NULL < (Real)C_HH7P_P_s and (Real)C_HH7P_P_s <= 5.55) => 
   map(
   (distphone2addr2 = '') => 
      map(
	  (s_inq_per_phone_i = NULL) => -0.0151011092,
      (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 6.5) => 0.0021098153,
      (s_inq_per_phone_i > 6.5) => 0.1243420249, 0),
   (NULL < (Real)distphone2addr2 and (Real)distphone2addr2 <= 2.5) => -0.0237929567,
   ((Real)distphone2addr2 > 2.5) => 0.0640863629, 0),
((Real)C_HH7P_P_s > 5.55) => 0.0649143320, 0);

// Tree: 45 
final_score_45 := map(
(bb_Line_Type_Header_ = '') => -0.0059267925,
(bb_Line_Type_Header_ in ['DELIVERY','INSTORE','MOBILEPLAN','SHIPTOHOME']) => 
   map(
   ((String)avg_pmt_amt = '') => -0.0166481761,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 531.15) => -0.0225977765,
   (avg_pmt_amt > 531.15) => 0.0414011389, 0),
(bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY']) => 
   map(
   (pf_num_items = NULL) => 0.0525563133,
   (NULL < pf_num_items and pf_num_items <= 1.5) => 0.4356336460,
   (pf_num_items > 1.5) => 0.0392496859, 0), 0);

// Tree: 46 
final_score_46 := map(
(s_inq_per_addr_i = NULL) => -0.0034489220,
(NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 10.5) => 
   map(
   (s_credit_seeking_i = NULL) => 
      map(
	  (s_bus_name_match_d = NULL) => -0.0035657933,
      (NULL < s_bus_name_match_d and s_bus_name_match_d <= 0.5) => 0.0536257295,
      (s_bus_name_match_d > 0.5) => -0.0068804882, 0),
   (NULL < s_credit_seeking_i and s_credit_seeking_i <= 2.5) => -0.0081509269,
   (s_credit_seeking_i > 2.5) => 0.1854678332, 0),
(s_inq_per_addr_i > 10.5) => 0.0492569109, 0);

// Tree: 47 
final_score_47 := map(
(pf_order_amount = NULL) => -0.0063343929,
(NULL < pf_order_amount and pf_order_amount <= 727.175) => 
   map(
   (pf_avs_ver_lvl = '') => -0.0112827214,
   (pf_avs_ver_lvl in ['1AZ','2AX','4XX','6UN','7NA']) => -0.0196400061,
   (pf_avs_ver_lvl in ['0NM','3XZ','5NO']) => 0.0316212626, 0),
(pf_order_amount > 727.175) => 
   map(
   (bb_Line_Type_Header_ = '') => 0.0346558696,
   (bb_Line_Type_Header_ in ['DELIVERY']) => -0.0828616740,
   (bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','INSTORE','MOBILEPLAN','SHIPTOHOME']) => 0.0449186334, 0), 0);

// Tree: 48 
final_score_48 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0138523380,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   (pf_ship_mode = '') => -0.0307964234,
   (pf_ship_mode in ['GROUND','SECOND DAY','STANDARD']) => -0.0353827442,
   (pf_ship_mode in ['NEXT DAY']) => 0.1404854457, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (b_Inq_Count12_i = NULL) => 0.0799145546,
   (NULL < b_Inq_Count12_i and b_Inq_Count12_i <= 9.5) => 0.0350348285,
   (b_Inq_Count12_i > 9.5) => 0.1507056386, 0), 0);

// Tree: 49 
final_score_49 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0115404451,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0251418885,
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (b_inq_retail_recency_d = NULL) => 0.0617507762,
   (NULL < b_inq_retail_recency_d and b_inq_retail_recency_d <= 4.5) => 0.1581361805,
   (b_inq_retail_recency_d > 4.5) => 
      map(
	  ((String)state_match_lvl = '') => 0.0277395042,
      (NULL < state_match_lvl and state_match_lvl <= 0.5) => 0.0857913470,
      (state_match_lvl > 0.5) => 0.0094108769, 0), 0), 0);

// Tree: 50 
final_score_50 := map(
(pf_order_amount = NULL) => -0.0109460375,
(NULL < pf_order_amount and pf_order_amount <= 726.555) => 
   map(
   (b_inq_count24_i = NULL) => 0.0256355480,
   (NULL < b_inq_count24_i and b_inq_count24_i <= 43.5) => -0.0240546329,
   (b_inq_count24_i > 43.5) => 
      map(
	  ((Integer)tm_not_us_time_zone_f = NULL) => 0.0683538952,
      (NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 0.0108796028,
      ((Real)tm_not_us_time_zone_f > 0.5) => 0.1432757408, 0), 0),
(pf_order_amount > 726.555) => 0.0607009376, 0);

// Tree: 51 
final_score_51 := map(
(b_corrrisktype_i = NULL) => 0.0180737047,
(NULL < b_corrrisktype_i and b_corrrisktype_i <= 8.5) => 
   map(
   ((String)lastscore = '') => -0.0173915406,
   (NULL < lastscore and lastscore <= 75.5) => 
      map(
	  ((Integer)btst_relatives_in_common = NULL) => 0.0398324730,
      (NULL < (Real)btst_relatives_in_common and (Real)btst_relatives_in_common <= 0.5) => 0.0690209981,
      ((Real)btst_relatives_in_common > 0.5) => -0.0491764910, 0),
   (lastscore > 75.5) => -0.0202658061, 0),
(b_corrrisktype_i > 8.5) => 0.0268101110, 0);

// Tree: 52 
final_score_52 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0048783920,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0099874291,
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (s_inq_count24_i = NULL) => 0.0072753829,
   (NULL < s_inq_count24_i and s_inq_count24_i <= 6.5) => 
      map(
	  (bb_Line_Type_Header_ = '') => 0.0117471617,
      (bb_Line_Type_Header_ in ['DELIVERY','DOWNLOAD DELIVERY','INSTORE','MOBILEPLAN','SHIPTOHOME']) => 0.0050102842,
      (bb_Line_Type_Header_ in ['EMAIL DELIVERY']) => 0.1530395112, 0),
   (s_inq_count24_i > 6.5) => 0.0620748287, 0), 0);

// Tree: 53 
final_score_53 := map(
(b_inq_count24_i = NULL) => 0.0449625110,
(NULL < b_inq_count24_i and b_inq_count24_i <= 46.5) => 
   map(
   (pf_ship_mode = '') => -0.0190248188,
   (pf_ship_mode in ['GROUND','SECOND DAY','STANDARD']) => 
      map(
	  ((Integer)tm_not_us_time_zone_f = NULL) => -0.0224945146,
      (NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0319143038,
      ((Real)tm_not_us_time_zone_f > 0.5) => 0.0193037944, 0),
   (pf_ship_mode in ['NEXT DAY']) => 0.0946271402, 0),
(b_inq_count24_i > 46.5) => 0.0914401713, 0);

// Tree: 54 
final_score_54 := map(
((String)avg_pmt_amt = '') => -0.0079087075,
(NULL < avg_pmt_amt and avg_pmt_amt <= 374.785) => 
   map(
   (pf_avs_ver_lvl = '') => -0.0148145368,
   (pf_avs_ver_lvl in ['0NM','1AZ','2AX','3XZ','4XX','7NA']) => 
      map(
	  ((String)lastscore = '') => -0.0176922522,
      (NULL < lastscore and lastscore <= 75.5) => 0.0362196987,
      (lastscore > 75.5) => -0.0207360679, 0),
   (pf_avs_ver_lvl in ['5NO','6UN']) => 0.0347184473, 0),
(avg_pmt_amt > 374.785) => 0.0319976219, 0);

// Tree: 55 
final_score_55 := map(
((String)C_BORN_USA_s = '') => -0.0015881373,
(NULL < (Real)C_BORN_USA_s and (Real)C_BORN_USA_s <= 95.5) => 
   map(
   (b_corrphonelastnamecount_d = NULL) => 0.0002242555,
   (NULL < b_corrphonelastnamecount_d and b_corrphonelastnamecount_d <= 0.5) => 
      map(
	  (distaddraddr2 = '') => 0.0146745009,
      (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 14.5) => 0.0108751005,
      ((Real)distaddraddr2 > 14.5) => 0.0284289970, 0),
   (b_corrphonelastnamecount_d > 0.5) => -0.0056636282, 0),
((Real)C_BORN_USA_s > 95.5) => -0.0133024618, 0);

// Tree: 56 
final_score_56 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0065570427,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   (distaddraddr2 = '') => -0.0246254386,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 77.5) => -0.0327803425,
   ((Real)distaddraddr2 > 77.5) => 0.0565339279, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   ((String)avg_pmt_amt = '') => 0.0618339327,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 199.6825) => 0.0260732861,
   (avg_pmt_amt > 199.6825) => 0.1117143990, 0), 0);

// Tree: 57 
final_score_57 := map(
(pf_avs_ver_lvl = '') => -0.0021924311,
(pf_avs_ver_lvl in ['1AZ','3XZ','4XX','6UN','7NA']) => 
   map(
   (bb_Line_Type_Header_ = '') => -0.0050980044,
   (bb_Line_Type_Header_ in ['DELIVERY','INSTORE','SHIPTOHOME']) => -0.0090154485,
   (bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','MOBILEPLAN']) => 
      map(
	  (pf_num_items = NULL) => 0.0148285008,
      (NULL < pf_num_items and pf_num_items <= 1.5) => 0.1280661924,
      (pf_num_items > 1.5) => 0.0114204155, 0), 0),
(pf_avs_ver_lvl in ['0NM','2AX','5NO']) => 0.0181617033, 0);

// Tree: 58 
final_score_58 := map(
(distphone2addr2 = '') => 
   map(
   (s_inq_per_phone_i = NULL) => 
      map(
	  (pf_order_amount = NULL) => -0.0088944830,
      (NULL < pf_order_amount and pf_order_amount <= 1142.52) => -0.0119278582,
      (pf_order_amount > 1142.52) => 0.0330585411, 0),
   (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 3.5) => 0.0010322625,
   (s_inq_per_phone_i > 3.5) => 0.0497988142, 0),
(NULL < (Real)distphone2addr2 and (Real)distphone2addr2 <= 16.5) => -0.0106371568,
((Real)distphone2addr2 > 16.5) => 0.0480128995, 0);

// Tree: 59 
final_score_59 := map(
((String)avg_pmt_amt = '') => -0.0086399980,
(NULL < avg_pmt_amt and avg_pmt_amt <= 374.4925) => 
   map(
   ((Integer)tm_not_us_time_zone_f = NULL) => -0.0163074433,
   (NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0231691327,
   ((Real)tm_not_us_time_zone_f > 0.5) => 
      map(
	  (b_inq_count24_i = NULL) => 0.0290571537,
      (NULL < b_inq_count24_i and b_inq_count24_i <= 31.5) => 0.0075415357,
      (b_inq_count24_i > 31.5) => 0.0897820831, 0), 0),
(avg_pmt_amt > 374.4925) => 0.0364907324, 0);

// Tree: 60 
final_score_60 := map(
(b_inq_per_phone_i = NULL) => -0.0123251484,
(NULL < b_inq_per_phone_i and b_inq_per_phone_i <= 4.5) => 
   map(
   ((String)state_match_lvl = '') => -0.0034894412,
   (NULL < state_match_lvl and state_match_lvl <= 0.5) => 
      map(
	  (b_corrphonelastnamecount_d = NULL) => 0.0092982059,
      (NULL < b_corrphonelastnamecount_d and b_corrphonelastnamecount_d <= 0.5) => 0.0159582806,
      (b_corrphonelastnamecount_d > 0.5) => -0.0049756554, 0),
   (state_match_lvl > 0.5) => -0.0096118578, 0),
(b_inq_per_phone_i > 4.5) => 0.0341662067, 0);

// Tree: 61 
final_score_61 := map(
(bb_Line_Type_Header_ = '') => -0.0011690821,
(bb_Line_Type_Header_ in ['DELIVERY','INSTORE','SHIPTOHOME']) => -0.0032342045,
(bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','MOBILEPLAN']) => 
   map(
   (pf_num_items = NULL) => 0.0095233649,
   (NULL < pf_num_items and pf_num_items <= 1.5) => 0.0576811516,
   (pf_num_items > 1.5) => 
      map(
	  ((String)avg_pmt_amt = '') => 0.0082089982,
      (NULL < avg_pmt_amt and avg_pmt_amt <= 41.2775) => 0.0507970527,
      (avg_pmt_amt > 41.2775) => 0.0014606704, 0), 0), 0);

// Tree: 62 
final_score_62 := map(
(distaddraddr2 = '') => -0.0012324552,
(NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 43.5) => 
   map(
   ((Integer)tm_not_us_time_zone_f = NULL) => -0.0126128105,
   (NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0229606679,
   ((Real)tm_not_us_time_zone_f > 0.5) => 0.0336697392, 0),
((Real)distaddraddr2 > 43.5) => 
   map(
   (pf_order_amount = NULL) => 0.0727057047,
   (NULL < pf_order_amount and pf_order_amount <= 325.975) => 0.0290782371,
   (pf_order_amount > 325.975) => 0.1151069565, 0), 0);

// Tree: 63 
final_score_63 := map(
(b_corraddrnamecount_d = NULL) => 0.0293760383,
(NULL < b_corraddrnamecount_d and b_corraddrnamecount_d <= 0.5) => 0.0220947590,
(b_corraddrnamecount_d > 0.5) => 
   map(
   ((Integer)tm_not_us_time_zone_f = NULL) => -0.0128915822,
   (NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0186417659,
   ((Real)tm_not_us_time_zone_f > 0.5) => 
      map(
	  (s_inq_per_phone_i = NULL) => -0.0047567452,
      (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 3.5) => 0.0228057660,
      (s_inq_per_phone_i > 3.5) => 0.0727364156, 0), 0), 0);

// Tree: 64 
final_score_64 := map(
(distphone2addr2 = '') => 
   map(
   (b_srchvelocityrisktype_i = NULL) => 0.0049979305,
   (NULL < b_srchvelocityrisktype_i and b_srchvelocityrisktype_i <= 8.5) => 
      map(
	  ((Integer)tm_bad_reason_code_f = NULL) => -0.0025912119,
      (NULL < (Real)tm_bad_reason_code_f and (Real)tm_bad_reason_code_f <= 0.5) => -0.0029456078,
      ((Real)tm_bad_reason_code_f > 0.5) => 0.0458429032, 0),
   (b_srchvelocityrisktype_i > 8.5) => 0.0350032445, 0),
(NULL < (Real)distphone2addr2 and (Real)distphone2addr2 <= 8.5) => -0.0079745047,
((Real)distphone2addr2 > 8.5) => 0.0324755395, 0);

// Tree: 65 
final_score_65 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0000970271,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   (distaddraddr2 = '') => -0.0155462078,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 67.5) => -0.0216291158,
   ((Real)distaddraddr2 > 67.5) => 0.0450211509, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   ((String)avg_pmt_amt = '') => 0.0579402970,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 172.211666665) => 0.0209872270,
   (avg_pmt_amt > 172.211666665) => 0.1010649107, 0), 0);

// Tree: 66 
final_score_66 := map(
(b_inq_Other_count24_i = NULL) => 0.0080437875,
(NULL < b_inq_Other_count24_i and b_inq_Other_count24_i <= 12.5) => 
   map(
   (tm_bad_reason_code_lvl = NULL) => -0.0036621964,
   (NULL < tm_bad_reason_code_lvl and tm_bad_reason_code_lvl <= 1.5) => 
      map(
	  (pf_ship_mode = '') => -0.0040291205,
      (pf_ship_mode in ['GROUND','SECOND DAY','STANDARD']) => -0.0047164192,
      (pf_ship_mode in ['NEXT DAY']) => 0.0192470459, 0),
   (tm_bad_reason_code_lvl > 1.5) => 0.0448223069, 0),
(b_inq_Other_count24_i > 12.5) => 0.0365457720, 0);

// Tree: 67 
final_score_67 := map(
(b_srchvelocityrisktype_i = NULL) => 0.0006751639,
(NULL < b_srchvelocityrisktype_i and b_srchvelocityrisktype_i <= 8.5) => 
   map(
   ((String)lastscore = '') => -0.0022316742,
   (NULL < lastscore and lastscore <= 77.5) => 
      map(
	  ((Integer)btst_relatives_in_common = NULL) => 0.0091512113,
      (NULL < (Real)btst_relatives_in_common and (Real)btst_relatives_in_common <= 0.5) => 0.0170577494,
      ((Real)btst_relatives_in_common > 0.5) => -0.0191929819, 0),
   (lastscore > 77.5) => -0.0028729263, 0),
(b_srchvelocityrisktype_i > 8.5) => 0.0224850586, 0);

// Tree: 68 
final_score_68 := map(
((Integer)tm_not_us_time_zone_f = NULL) => 0.0000341327,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   (b_corraddrnamecount_d = NULL) => 0.0413969583,
   (NULL < b_corraddrnamecount_d and b_corraddrnamecount_d <= 0.5) => 0.0065443390,
   (b_corraddrnamecount_d > 0.5) => -0.0164476835, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (distaddraddr2 = '') => 0.0447548223,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 24.5) => 0.0252382256,
   ((Real)distaddraddr2 > 24.5) => 0.0960845008, 0), 0);

// Tree: 69 
final_score_69 := map(
(distaddraddr2 = '') => -0.0036662154,
(NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 14.5) => 
   map(
   (pf_avs_ver_lvl = '') => -0.0060560273,
   (pf_avs_ver_lvl in ['0NM','1AZ','3XZ','4XX','7NA']) => 
      map(
	  (b_inq_retail_recency_d = NULL) => -0.0045913315,
      (NULL < b_inq_retail_recency_d and b_inq_retail_recency_d <= 4.5) => 0.0237593129,
      (b_inq_retail_recency_d > 4.5) => -0.0081731820, 0),
   (pf_avs_ver_lvl in ['2AX','5NO','6UN']) => 0.0096422098, 0),
((Real)distaddraddr2 > 14.5) => 0.0065614978, 0);

// Tree: 70 
final_score_70 := map(
(b_srchcomponentrisktype_i = NULL) => 
   map(
   ((String)avg_pmt_amt = '') => -0.0005375286,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 28.995) => -0.0155590009,
   (avg_pmt_amt > 28.995) => 
      map(
	  (pf_order_amount = NULL) => 0.0015879262,
      (NULL < pf_order_amount and pf_order_amount <= 38.32) => 0.0191043297,
      (pf_order_amount > 38.32) => -0.0004481420, 0), 0),
(NULL < b_srchcomponentrisktype_i and b_srchcomponentrisktype_i <= 1.5) => -0.0006216584,
(b_srchcomponentrisktype_i > 1.5) => 0.0128959276, 0);

// Tree: 71 
final_score_71 := map(
(b_hist_addr_match_i = NULL) => 0.0244958683,
(NULL < b_hist_addr_match_i and b_hist_addr_match_i <= 20.5) => 
   map(
   (distaddraddr2 = '') => -0.0062003196,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 67.5) => -0.0084743545,
   ((Real)distaddraddr2 > 67.5) => 0.0159158705, 0),
(b_hist_addr_match_i > 20.5) => 
   map(
   ((String)avg_pmt_amt = '') => 0.0126163536,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 325.5025) => 0.0028252681,
   (avg_pmt_amt > 325.5025) => 0.0330187204, 0), 0);

// Tree: 72 
final_score_72 := map(
(tm_bad_reason_code_lvl = NULL) => -0.0008122679,
(NULL < (Real)tm_bad_reason_code_lvl and (Real)tm_bad_reason_code_lvl <= 0.5) => 
   map(
   (b_inq_per_phone_i = NULL) => -0.0042466324,
   (NULL < b_inq_per_phone_i and b_inq_per_phone_i <= 6.5) => 
      map(
	  (b_corrphonelastnamecount_d = NULL) => 0.0012363786,
      (NULL < b_corrphonelastnamecount_d and b_corrphonelastnamecount_d <= 0.5) => 0.0020368548,
      (b_corrphonelastnamecount_d > 0.5) => -0.0038796204, 0),
   (b_inq_per_phone_i > 6.5) => 0.0124259307, 0),
(tm_bad_reason_code_lvl > 0.5) => 0.0117201923, 0);

// Tree: 73 
final_score_73 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0012168246,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => 
   map(
   ((Integer)valid_tm_account = NULL) => -0.0023624469,
   (NULL < (Real)valid_tm_account and (Real)valid_tm_account <= 0.5) => 
      map(
	  (distaddraddr2 = '') => 0.0008784381,
      (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 35.5) => -0.0000930153,
      ((Real)distaddraddr2 > 35.5) => 0.0062655889, 0),
   ((Real)valid_tm_account > 0.5) => -0.0041763988, 0),
((Real)tm_not_us_time_zone_f > 0.5) => 0.0031697937, 0);

// Tree: 74 
final_score_74 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0006434166,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0020221855,
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (distaddraddr2 = '') => 0.0045143822,
   (NULL < (Real)distaddraddr2 and (Real)distaddraddr2 <= 26.5) => 
      map(
	  (b_inq_count24_i = NULL) => 0.0087253928,
      (NULL < b_inq_count24_i and b_inq_count24_i <= 12.5) => 0.0006695724,
      (b_inq_count24_i > 12.5) => 0.0107488915, 0),
   ((Real)distaddraddr2 > 26.5) => 0.0097015444, 0), 0);

// Tree: 75 
final_score_75 := map(
(s_Phn_Not_Issued_i = NULL) => -0.0004034729,
(NULL < s_Phn_Not_Issued_i and s_Phn_Not_Issued_i <= 0.5) => 
   map(
   (s_corraddrnamecount_d = NULL) => 
      map(
	  ((String)addrscore = '') => 0.0013148027,
      (NULL < (Real)addrscore and (Real)addrscore <= 85) => 0.0021264963,
      ((Real)addrscore > 85) => -0.0003415958, 0),
   (NULL < s_corraddrnamecount_d and s_corraddrnamecount_d <= 0.5) => 0.0009813761,
   (s_corraddrnamecount_d > 0.5) => -0.0005190973, 0),
(s_Phn_Not_Issued_i > 0.5) => 0.0034866467, 0);

// Tree: 76 
final_score_76 := map(
(bb_Line_Type_Header_ = '') => -0.0000777208,
(bb_Line_Type_Header_ in ['DELIVERY']) => -0.0025394451,
(bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','INSTORE','MOBILEPLAN','SHIPTOHOME']) => 
   map(
   (pf_order_amount = NULL) => -0.0000316967,
   (NULL < pf_order_amount and pf_order_amount <= 1893.495) => 
      map(
	  (pf_avs_ver_lvl = '') => -0.0000637901,
      (pf_avs_ver_lvl in ['1AZ','2AX','4XX','6UN','7NA']) => -0.0002093526,
      (pf_avs_ver_lvl in ['0NM','3XZ','5NO']) => 0.0006465848, 0),
   (pf_order_amount > 1893.495) => 0.0021086034, 0), 0);

// Tree: 77 
final_score_77 := map(
(b_corrrisktype_i = NULL) => 0.0008426769,
(NULL < b_corrrisktype_i and b_corrrisktype_i <= 8.5) => 
   map(
   ((String)lastscore = '') => -0.0004118097,
   (NULL < lastscore and lastscore <= 73) => 0.0011127275,
   (lastscore > 73) => -0.0004933408, 0),
(b_corrrisktype_i > 8.5) => 
   map(
   ((String)avg_pmt_amt = '') => 0.0004349009,
   (NULL < avg_pmt_amt and avg_pmt_amt <= 218.9925) => 0.0000277322,
   (avg_pmt_amt > 218.9925) => 0.0012708960, 0), 0);

// Tree: 78 
final_score_78 := map(
((Integer)tm_not_us_time_zone_f = NULL) => -0.0001183761,
(NULL < (Real)tm_not_us_time_zone_f and (Real)tm_not_us_time_zone_f <= 0.5) => -0.0002397256,
((Real)tm_not_us_time_zone_f > 0.5) => 
   map(
   (b_Inq_Count12_i = NULL) => 0.0004814682,
   (NULL < b_Inq_Count12_i and b_Inq_Count12_i <= 16.5) => 
      map(
	  (bb_Line_Type_Header_ = '') => 0.0002279968,
      (bb_Line_Type_Header_ in ['DELIVERY','INSTORE']) => -0.0002699199,
      (bb_Line_Type_Header_ in ['DOWNLOAD DELIVERY','EMAIL DELIVERY','MOBILEPLAN','SHIPTOHOME']) => 0.0005177527, 0),
   (b_Inq_Count12_i > 16.5) => 0.0014897984, 0), 0);

// Tree: 0
final_score_0 := -2.0029195785;

// Final Score Sum 

   final_score := sum(
      final_score_0, final_score_1, final_score_2, final_score_3, final_score_4, final_score_5, 
      final_score_6, final_score_7, final_score_8, final_score_9, final_score_10, 
      final_score_11, final_score_12, final_score_13, final_score_14, final_score_15, 
      final_score_16, final_score_17, final_score_18, final_score_19, final_score_20, 
      final_score_21, final_score_22, final_score_23, final_score_24, final_score_25, 
      final_score_26, final_score_27, final_score_28, final_score_29, final_score_30, 
      final_score_31, final_score_32, final_score_33, final_score_34, final_score_35, 
      final_score_36, final_score_37, final_score_38, final_score_39, final_score_40, 
      final_score_41, final_score_42, final_score_43, final_score_44, final_score_45, 
      final_score_46, final_score_47, final_score_48, final_score_49, final_score_50, 
      final_score_51, final_score_52, final_score_53, final_score_54, final_score_55, 
      final_score_56, final_score_57, final_score_58, final_score_59, final_score_60, 
      final_score_61, final_score_62, final_score_63, final_score_64, final_score_65, 
      final_score_66, final_score_67, final_score_68, final_score_69, final_score_70, 
      final_score_71, final_score_72, final_score_73, final_score_74, final_score_75, 
      final_score_76, final_score_77, final_score_78); 

pbr := 0.01180484;

sbr := 0.153875985;

bb_offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

base := 650;

pts := -30;

lgt := ln(0.0118 / 0.9882);

cdn1404_1_0 := round(max((real)250, min(999, if(base + pts * (final_score - bb_offset - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score - bb_offset - lgt) / ln(2)))));


#if(MODEL_DEBUG)
		/* Model Input Variables */							
		self.sysdate                          := sysdate;
		self.pf_ship_mode                     := pf_ship_mode;
		self.pf_num_items                     := pf_num_items;
		self.pf_order_amount                  := pf_order_amount;
		self.avg_pmt_amt                      := avg_pmt_amt;
		self.pf_pmt_type                      := pf_pmt_type;
		self.avs_name_ver                     := avs_name_ver;
		self.avs_unvail                       := avs_unvail;
		self.avs_addr_ver                     := avs_addr_ver;
		self.avs_no_match                     := avs_no_match;
		self.avs_zip5_ver                     := avs_zip5_ver;
		self.pf_avs_ver_lvl                   := pf_avs_ver_lvl;
		self.pf_cid_match                     := pf_cid_match;
		self.valid_tm_account                 := valid_tm_account;
		self.tm_not_us_time_zone_f            := tm_not_us_time_zone_f;
		self.tm_bad_reason_code_lvl           := tm_bad_reason_code_lvl;
		self.tm_bad_reason_code_f             := tm_bad_reason_code_f;
		self.ip_state                         := ip_state;
		self.state_match_lvl                  := state_match_lvl;
		self.b_hist_addr_match_i              := b_hist_addr_match_i;
		self.b_corraddrnamecount_d            := b_corraddrnamecount_d;
		self.b_inq_count24_i                  := b_inq_count24_i;
		self.b_corrrisktype_i                 := b_corrrisktype_i;
		self.s_inq_per_phone_i                := s_inq_per_phone_i;
		self.b_inq_count12_i                  := b_inq_count12_i;
		self.s_add_invalid_i                  := s_add_invalid_i;
		self.s_corrrisktype_i                 := s_corrrisktype_i;
		self.b_inq_retail_recency_d           := b_inq_retail_recency_d;
		self.b_inq_per_addr_i                 := b_inq_per_addr_i;
		self.s_phn_not_issued_i               := s_phn_not_issued_i;
		self.b_corrphonelastnamecount_d       := b_corrphonelastnamecount_d;
		self.s_corraddrnamecount_d            := s_corraddrnamecount_d;
		self.b_inq_per_phone_i                := b_inq_per_phone_i;
		self.b_inq_other_count24_i            := b_inq_other_count24_i;
		self.b_srchvelocityrisktype_i         := b_srchvelocityrisktype_i;
		self.s_inq_retail_recency_d           := s_inq_retail_recency_d;
		self.s_inq_count24_i                  := s_inq_count24_i;
		self.s_estimated_income_d             := s_estimated_income_d;
		self.s_inq_per_addr_i                 := s_inq_per_addr_i;
		self.s_idverrisktype_i                := s_idverrisktype_i;
		self.b_idverrisktype_i                := b_idverrisktype_i;
		self.s_bus_name_match_d               := s_bus_name_match_d;
		self.s_credit_seeking_i               := s_credit_seeking_i;
		self.b_inq_ssns_per_addr_i            := b_inq_ssns_per_addr_i;
		self.s_varrisktype_i                  := s_varrisktype_i;
		self._in_dob                          := _in_dob;
		self.yr_in_dob                        := yr_in_dob;
		self.yr_in_dob_int                    := yr_in_dob_int;
		self.b_comb_age_d                     := b_comb_age_d;
		self.b_srchcomponentrisktype_i        := b_srchcomponentrisktype_i;
		self.bb_ship_mode_                    := bb_ship_mode_               ;
		self.bb_item_lines_                   := bb_item_lines_              ;
		self.bb_original_total_amount_        := (String)bb_original_total_amount_;
		self.bb_cc_type_                      := bb_cc_type_                 ;
		self.bb_avs_code_                     := bb_avs_code_                ;
		self.bb_cvv_description_              := bb_cvv_description_         ;
		self.bb_entry_type_                   := bb_entry_type_              ;
		self.bb_line_type_header_             := bb_line_type_header_        ;
		self.tm_device_result_                := tm_device_result_           ;
		self.tm_time_zone_hours_              := tm_time_zone_hours_         ;
		self.tm_reason_code_                  := tm_reason_code_             ;
		self.tm_true_ip_region_               := tm_true_ip_region_          ;
		self.firstscore                       := firstscore                  ;
		self.lastscore                        := lastscore                   ;
		self.btst_relatives_in_common         := btst_relatives_in_common    ;
		self.distaddraddr2                    := distaddraddr2               ;
		self.distphone2addr2                  := distphone2addr2             ;
		self.btst_are_relatives               := btst_are_relatives          ;
		self.addrscore                        := addrscore                   ;
		self.truedid                          := truedid                     ;
		self.in_state                         := in_state                    ;
		self.in_dob                           := in_dob                      ;
		self.addrpop                          := addrpop                     ;
		self.hphnpop                          := hphnpop                     ;
		self.hist_addr_match                  := hist_addr_match             ;
		self.inq_count12                      := inq_count12                 ;
		self.inq_count24                      := inq_count24                 ;
		self.inq_retail_count                 := inq_retail_count            ;
		self.inq_retail_count01               := inq_retail_count01          ;
		self.inq_retail_count03               := inq_retail_count03          ;
		self.inq_retail_count06               := inq_retail_count06          ;
		self.inq_retail_count12               := inq_retail_count12          ;
		self.inq_retail_count24               := inq_retail_count24          ;
		self.inq_other_count24                := inq_other_count24           ;
		self.inq_peraddr                      := inq_peraddr                 ;
		self.inq_ssnsperaddr                  := inq_ssnsperaddr             ;
		self.inq_perphone                     := inq_perphone                ;
		self.fp_idverrisktype                 := fp_idverrisktype            ;
		self.fp_srchvelocityrisktype          := fp_srchvelocityrisktype     ;
		self.fp_corrrisktype                  := fp_corrrisktype             ;
		self.fp_corraddrnamecount             := fp_corraddrnamecount        ;
		self.fp_corrphonelastnamecount        := fp_corrphonelastnamecount   ;
		self.fp_srchcomponentrisktype         := fp_srchcomponentrisktype    ;
		self.inferred_age                     := inferred_age                ;
		self.truedid_s                        := truedid_s                   ;
		self.rc_pwphonezipflag_s              := rc_pwphonezipflag_s         ;
		self.rc_addrvalflag_s                 := rc_addrvalflag_s            ;
		self.bus_name_match_s                 := bus_name_match_s            ;
		self.addrpop_s                        := addrpop_s                   ;
		self.hphnpop_s                        := hphnpop_s                   ;
		self.inq_count24_s                    := inq_count24_s               ;
		self.inq_auto_count03_s               := inq_auto_count03_s          ;
		self.inq_banking_count03_s            := inq_banking_count03_s       ;
		self.inq_mortgage_count03_s           := inq_mortgage_count03_s      ;
		self.inq_retail_count_s               := inq_retail_count_s          ;
		self.inq_retail_count01_s             := inq_retail_count01_s        ;
		self.inq_retail_count03_s             := inq_retail_count03_s        ;
		self.inq_retail_count06_s             := inq_retail_count06_s        ;
		self.inq_retail_count12_s             := inq_retail_count12_s        ;
		self.inq_retail_count24_s             := inq_retail_count24_s        ;
		self.inq_communications_count03_s     := inq_communications_count03_s;
		self.inq_peraddr_s                    := inq_peraddr_s               ;
		self.inq_perphone_s                   := inq_perphone_s              ;
		self.fp_idverrisktype_s               := fp_idverrisktype_s          ;
		self.fp_varrisktype_s                 := fp_varrisktype_s            ;
		self.fp_corrrisktype_s                := fp_corrrisktype_s           ;
		self.fp_corraddrnamecount_s           := fp_corraddrnamecount_s      ;
		self.estimated_income_s               := estimated_income_s          ;
		self.C_BORN_USA_s                     := C_BORN_USA_s                ;
		self.C_HH7P_P_s                       := C_HH7P_P_s                  ;
		self.c_hval_125k_p                    := c_hval_125k_p               ;
		self.c_hval_80k_p                     := c_hval_80k_p                ;
		self.final_score_0                    := final_score_0;
		self.final_score_1                    := final_score_1;
		self.final_score_2                    := final_score_2;
		self.final_score_3                    := final_score_3;
		self.final_score_4                    := final_score_4;
		self.final_score_5                    := final_score_5;
		self.final_score_6                    := final_score_6;
		self.final_score_7                    := final_score_7;
		self.final_score_8                    := final_score_8;
		self.final_score_9                    := final_score_9;
		self.final_score_10                   := final_score_10;
		self.final_score_11                   := final_score_11;
		self.final_score_12                   := final_score_12;
		self.final_score_13                   := final_score_13;
		self.final_score_14                   := final_score_14;
		self.final_score_15                   := final_score_15;
		self.final_score_16                   := final_score_16;
		self.final_score_17                   := final_score_17;
		self.final_score_18                   := final_score_18;
		self.final_score_19                   := final_score_19;
		self.final_score_20                   := final_score_20;
		self.final_score_21                   := final_score_21;
		self.final_score_22                   := final_score_22;
		self.final_score_23                   := final_score_23;
		self.final_score_24                   := final_score_24;
		self.final_score_25                   := final_score_25;
		self.final_score_26                   := final_score_26;
		self.final_score_27                   := final_score_27;
		self.final_score_28                   := final_score_28;
		self.final_score_29                   := final_score_29;
		self.final_score_30                   := final_score_30;
		self.final_score_31                   := final_score_31;
		self.final_score_32                   := final_score_32;
		self.final_score_33                   := final_score_33;
		self.final_score_34                   := final_score_34;
		self.final_score_35                   := final_score_35;
		self.final_score_36                   := final_score_36;
		self.final_score_37                   := final_score_37;
		self.final_score_38                   := final_score_38;
		self.final_score_39                   := final_score_39;
		self.final_score_40                   := final_score_40;
		self.final_score_41                   := final_score_41;
		self.final_score_42                   := final_score_42;
		self.final_score_43                   := final_score_43;
		self.final_score_44                   := final_score_44;
		self.final_score_45                   := final_score_45;
		self.final_score_46                   := final_score_46;
		self.final_score_47                   := final_score_47;
		self.final_score_48                   := final_score_48;
		self.final_score_49                   := final_score_49;
		self.final_score_50                   := final_score_50;
		self.final_score_51                   := final_score_51;
		self.final_score_52                   := final_score_52;
		self.final_score_53                   := final_score_53;
		self.final_score_54                   := final_score_54;
		self.final_score_55                   := final_score_55;
		self.final_score_56                   := final_score_56;
		self.final_score_57                   := final_score_57;
		self.final_score_58                   := final_score_58;
		self.final_score_59                   := final_score_59;
		self.final_score_60                   := final_score_60;
		self.final_score_61                   := final_score_61;
		self.final_score_62                   := final_score_62;
		self.final_score_63                   := final_score_63;
		self.final_score_64                   := final_score_64;
		self.final_score_65                   := final_score_65;
		self.final_score_66                   := final_score_66;
		self.final_score_67                   := final_score_67;
		self.final_score_68                   := final_score_68;
		self.final_score_69                   := final_score_69;
		self.final_score_70                   := final_score_70;
		self.final_score_71                   := final_score_71;
		self.final_score_72                   := final_score_72;
		self.final_score_73                   := final_score_73;
		self.final_score_74                   := final_score_74;
		self.final_score_75                   := final_score_75;
		self.final_score_76                   := final_score_76;
		self.final_score_77                   := final_score_77;
		self.final_score_78                   := final_score_78;
		self.final_score                      := final_score;
		self.pbr                              := pbr;
		self.sbr                              := sbr;
		self.bb_offset                        := bb_offset;
		self.base                             := base;
		self.pts                              := pts;
		self.lgt                              := lgt;
		self.cdn1404_1_0                      := cdn1404_1_0;
		SELF.seq                              := ri.seq;
		SELF.score                            := (STRING3)cdn1404_1_0;
		SELF.clam                             := le.bs;
		self := [];
	#else
		SELF.ri := [];
		SELF.seq := le.bs.Bill_To_Out.seq;
		SELF.score := (STRING3)cdn1404_1_0;
	#end
	END;
	
	model := JOIN(clam_with_easi, customInputs, 
		LEFT.bs.bill_to_out.seq = (RIGHT.seq * 2), doModel(LEFT, RIGHT), LEFT OUTER);

	// need to project billto boca shell results into layout.output
	Risk_Indicators.Layout_Output into_layout_output(clam_with_easi le) := TRANSFORM
		SELF.seq := le.bs.Bill_To_Out.seq;
		SELF.socllowissue := (STRING)le.bs.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
		SELF.soclhighissue := (STRING)le.bs.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
		SELF.socsverlevel := le.bs.Bill_To_Out.iid.NAS_summary;
		SELF.nxx_type := le.bs.Bill_To_Out.phone_verification.telcordia_type;
		SELF := le.bs.Bill_To_Out.iid;
		SELF := le.bs.Bill_To_Out.shell_input;
		SELF := le.bs.bill_to_out;
	END;
	iidBT := PROJECT(clam_with_easi, into_layout_output(LEFT));

	RiskWise.Layout_IP2O fill_ip(clam_with_easi le) := TRANSFORM
		SELF.countrycode := le.bs.ip2o.countrycode[1..2];
		SELF := le.bs.ip2o;
	END;
	ipInfo := PROJECT(clam_with_easi, fill_ip(LEFT));


	Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
		SELF.seq := le.seq;
		SELF.ri := RiskWise.cdReasonCodes(le, 6, rt, TRUE, IBICID, WantstoSeeBillToShipToDifferenceFlag);
		SELF := [];
	END;
	BTReasons := JOIN(iidBT, ipInfo, LEFT.seq = RIGHT.seq, addBTReasons(LEFT, RIGHT), LEFT OUTER);


	#if(MODEL_DEBUG)
	Layout_debug fillReasons(layout_debug le, BTreasons rt) := TRANSFORM
	#else
	Layout_ModelOut fillReasons(Layout_ModelOut le, BTreasons rt) := TRANSFORM
	SELF.ri := rt.ri;
	#end
		SELF := le;
	END;
	
	#if(MODEL_DEBUG)
	BTrecord := JOIN(model, BTReasons, LEFT.clam.Bill_To_out.seq = RIGHT.seq, fillReasons(LEFT, RIGHT), LEFT OUTER);
	#else
	BTrecord := JOIN(model, BTReasons, LEFT.seq = RIGHT.seq, fillReasons(LEFT, RIGHT), LEFT OUTER);
	#end


	// need to project the shipto boca shell results into layout.output
	Risk_Indicators.Layout_Output into_layout_output2(clam_with_easi le) := TRANSFORM
		SELF.seq := le.bs.Ship_To_Out.seq;
		SELF.socllowissue := (string)le.bs.Ship_To_Out.SSN_Verification.Validation.low_issue_date;
		SELF.soclhighissue := (string)le.bs.Ship_To_Out.SSN_Verification.Validation.high_issue_date;
		SELF.socsverlevel := le.bs.Ship_To_Out.iid.NAS_summary;
		SELF := le.bs.Ship_To_Out.iid;
		SELF := le.bs.Ship_To_Out.shell_input;
		SELF := le.bs.ship_to_out;
	END;
	iidST := PROJECT(clam_with_easi, into_layout_output2(LEFT));


	Layout_ModelOut addSTReasons(iidST le, ipInfo rt) := TRANSFORM
		SELF.seq := le.seq;
		SELF.ri := RiskWise.cdReasonCodes(le, 6, rt, FALSE, IBICID, false);
		SELF := [];
	END;
	STReasons := JOIN(iidST, ipInfo, LEFT.seq=((RIGHT.seq*2)-1), addSTReasons(LEFT, RIGHT), LEFT OUTER);

	#if(MODEL_DEBUG)
		layout_debug fillReasons2(layout_debug le, STreasons rt) := TRANSFORM
		SELF.ri := le.ri + rt.ri;
	#else
		Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := TRANSFORM
		SELF.ri := le.ri + rt.ri;
	#end
		SELF := le;
	END;
	
	#if(MODEL_DEBUG)
	STRecord := JOIN(BTRecord, STReasons, ((LEFT.clam.Bill_To_Out.seq*2)-1) = RIGHT.seq, fillReasons2(LEFT, RIGHT), LEFT OUTER);
	#else
	STRecord := JOIN(BTRecord, STReasons, ((LEFT.seq*2)-1) = RIGHT.seq, fillReasons2(LEFT, RIGHT), LEFT OUTER);
	#end

	RETURN(STRecord);
END;