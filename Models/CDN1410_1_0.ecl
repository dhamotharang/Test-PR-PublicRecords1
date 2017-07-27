
IMPORT EASI, Business_Risk, ut, RiskWise, RiskWiseFCRA, Risk_Indicators;

EXPORT cdn1410_1_0 (GROUPED DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
										DATASET(Models.Layout_CD_CustomModelInputs) customInputs,
										BOOLEAN IBICID,
										BOOLEAN WantstoSeeBillToShipToDifferenceFlag,
										BOOLEAN WantsToSeeEA) := FUNCTION

	MODEL_DEBUG := false;
	
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
		 BOOLEAN           avs_zip                              ;
     BOOLEAN           avs_missing                          ;
     STRING           pf_pmt_type                          ;
     REAL           pf_product_dollars                   ;
     STRING           pf_ship_method                       ;
     REAL           btst_distaddraddr2_i                 ;
     REAL           s_add_input_nhood_bus_pct_i          ;
     REAL           num_inp_lat                          ;
     REAL8           num_inp_long                         ;
     REAL           num_ip_lat                           ;
     REAL           num_ip_long                          ;
     REAL           d_lat                                ;
     REAL           d_long                               ;
     REAL           a                                    ;
     REAL           c                                    ;
     REAL           dist                                 ;
     REAL           btst_dist_inp_addr_to_ip_addr_i      ;
     REAL           b_c20_email_verification_d           ;
     REAL           s_c12_source_profile_index_d         ;
     REAL           b_divaddrsuspidcountnew_i            ;
     REAL           s_add_input_mobility_index_i         ;
     REAL           s_corrrisktype_i                     ;
     BOOLEAN           b_nae_email_verd_d                   ;
     REAL           s_p88_phn_dst_to_inp_add_i           ;
     BOOLEAN           s_nap_phn_verd_d                     ;
     REAL           b_adl_per_email_i                    ;
     REAL           b_add_input_nhood_bus_pct_i          ;
     STRING           btst_lastscore_d                     ;
     REAL           s_corraddrphonecount_d               ;
     REAL           btst_distphone2addr2_i               ;
     REAL           s_bus_phone_match_d                  ;
     REAL           s_l79_adls_per_addr_c6_i             ;
     STRING           s_idverrisktype_i                    ;
     REAL           b_bus_phone_match_d                  ;
     REAL           s_inq_per_addr_i                     ;
     REAL           s_phone_ver_experian_d               ;
     REAL           b_corraddrnamecount_d                ;
     REAL           b_phone_ver_experian_d               ;
     REAL           s_corraddrnamecount_d                ;
     REAL           s_add_input_nhood_prop_sum           ;
     REAL           s_add_input_nhood_vac_pct_i          ;
     REAL           s_inq_per_phone_i                    ;
     REAL           s_corrphonelastnamecount_d           ;
     REAL           s_inq_retail_count_week_i            ;
     REAL           b_corrphonelastnamecount_d           ;
     REAL           s_srchcountday_i                     ;
     REAL           s_inq_count_i                        ;
     REAL           b_add_input_mobility_index_i         ;
     BOOLEAN           b_nae_fname_verd_d                   ;
     REAL8           add_input_nhood_prop_sum             ;
     REAL           b_add_input_nhood_vac_pct_i          ;
     REAL           s_inq_lnames_per_addr_i              ;
     REAL           b_p85_phn_invalid_i                  ;
     REAL           s_bus_name_nover_i                   ;
     REAL           b_inq_per_phone_i                    ;
     REAL           s_inq_retail_count_day_i             ;
     STRING           email_topleveldomain                 ;
     STRING           btst_email_topleveldomain_n          ;
     REAL           b_p86_phn_pager_i                    ;
     STRING          btst_email_last_score_d              ;
     REAL           final_score_0                        ;
     REAL           final_score_1                        ;
     REAL           final_score_2                        ;
     REAL           final_score_3                        ;
     REAL           final_score_4                        ;
     REAL           final_score_5                        ;
     REAL           final_score_6                        ;
     REAL           final_score_7                        ;
     REAL           final_score_8                        ;
     REAL           final_score_9                        ;
     REAL           final_score_10                       ;
     REAL           final_score_11                       ;
     REAL           final_score_12                       ;
     REAL           final_score_13                       ;
     REAL           final_score_14                       ;
     REAL           final_score_15                       ;
     REAL           final_score_16                       ;
     REAL           final_score_17                       ;
     REAL           final_score_18                       ;
     REAL           final_score_19                       ;
     REAL           final_score_20                       ;
     REAL           final_score_21                       ;
     REAL           final_score_22                       ;
     REAL           final_score_23                       ;
     REAL           final_score_24                       ;
     REAL           final_score_25                       ;
     REAL           final_score_26                       ;
     REAL           final_score_27                       ;
     REAL           final_score_28                       ;
     REAL           final_score_29                       ;
     REAL           final_score_30                       ;
     REAL           final_score_31                       ;
     REAL           final_score_32                       ;
     REAL           final_score_33                       ;
     REAL           final_score_34                       ;
     REAL           final_score_35                       ;
     REAL           final_score_36                       ;
     REAL           final_score_37                       ;
     REAL           final_score_38                       ;
     REAL           final_score_39                       ;
     REAL           final_score_40                       ;
     REAL           final_score_41                       ;
     REAL           final_score_42                       ;
     REAL           final_score_43                       ;
     REAL           final_score_44                       ;
     REAL           final_score_45                       ;
     REAL           final_score_46                       ;
     REAL           final_score_47                       ;
     REAL           final_score_48                       ;
     REAL           final_score_49                       ;
     REAL           final_score_50                       ;
     REAL           final_score_51                       ;
     REAL           final_score_52                       ;
     REAL           final_score_53                       ;
     REAL           final_score_54                       ;
     REAL           final_score_55                       ;
     REAL           final_score_56                       ;
     REAL           final_score_57                       ;
     REAL           final_score_58                       ;
     REAL           final_score_59                       ;
     REAL           final_score_60                       ;
     REAL           final_score_61                       ;
     REAL           final_score_62                       ;
     REAL           final_score_63                       ;
     REAL           final_score                          ;
     REAL           pbr                                  ;
     REAL           sbr                                  ;
     REAL           offset                               ;
     REAL           base                                 ;
     REAL           pts                                  ;
     REAL           lgt                                  ;
     REAL           cdn1410_1_0_raw                      ;
     STRING           ip_routingmethod_n                   ;
     STRING          ip_connection_n                      ;
     STRING           ip_dma_lvl_n                         ;
     STRING          ip_continent_n                       ;
     BOOLEAN           ip_routingmethod_anonymous           ;
     REAL           ip_connection_dialup                 ;
     BOOLEAN           ip_dma_lvl_0                         ;
     BOOLEAN           ip_continent_not_n_america           ;
     REAL           cdn1410_1_0_adj                      ;
     REAL           b_inq_count_day_i                    ;
     REAL           b_inq_count_week_i                   ;
     REAL           s_inq_count_day_i                    ;
     REAL           s_inq_count_week_i                   ;
     BOOLEAN           foreign_order                        ;
     Boolean           bt_min_pii                           ;
		 INTEGER           cdn1410_1_0                          ;
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
	 
	avs                              := ri.TD_avs;
	pay_method                       := ri.TD_pay_method;
	product_dollars                  := ri.TD_product_dollars;
	ship_method                      := ri.TD_ship_method;
	distaddraddr2                    := le.bs.eddo.distaddraddr2;
	latitude                         := le.bs.ip2o.latitude;
	longitude                        := le.bs.ip2o.longitude;
	lastscore                        := le.bs.eddo.lastscore;
	distphone2addr2                  := le.bs.eddo.distphone2addr2;
	elastscore                       := le.bs.eddo.elastscore;
	btst_relatives_in_common         := le.bs.eddo.btst_relatives_in_common;
	//st_cen_urban_p                   := ;
	ipaddr                           := le.bs.ip2o.ipaddr;
	iproutingmethod                  := le.bs.ip2o.iproutingmethod;
	ipconnection                     := StringLib.StringtoUppercase(trim(le.bs.ip2o.ipconnection));
	ipdma                            := trim(le.bs.ip2o.ipdma);
	continent                        := le.bs.ip2o.continent;
	td_day_velocity_threshold        := ri.td_day_velocity_threshold;
	td_week_velocity_threshold       := ri.td_week_velocity_threshold;
	BT_cen_span_lang                 := le.census.easi.span_lang;
	ST_cen_blue_col                  := le.census.easi2.blue_col;
	ST_cen_span_lang                 := le.census.easi2.span_lang;
	ST_cen_urban_p                   := le.census.easi2.urban_p;
	truedid                          := le.bs.Bill_To_Out.truedid;
	in_state                         := le.bs.Bill_To_Out.shell_input.in_state;
	out_lat                          := le.bs.Bill_To_Out.shell_input.lat;
	out_long                         := le.bs.Bill_To_Out.shell_input.long;
	in_email_address                 := le.bs.Bill_To_Out.shell_input.email_address;
	rc_hriskphoneflag                := le.bs.Bill_To_Out.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.bs.Bill_To_Out.iid.hphonetypeflag;
	rc_phonevalflag                  := le.bs.Bill_To_Out.iid.phonevalflag;
	rc_hphonevalflag                 := le.bs.Bill_To_Out.iid.hphonevalflag;
	rc_phonetype                     := le.bs.Bill_To_Out.iid.phonetype;
	bus_phone_match                  := le.bs.Bill_To_Out.business_header_address_summary.bus_phone_match;
	lnamepop                         := le.bs.Bill_To_Out.input_validation.lastname;
	addrpop                          := le.bs.Bill_To_Out.input_validation.address;
	emailpop                         := le.bs.Bill_To_Out.input_validation.email;
	hphnpop                          := le.bs.Bill_To_Out.input_validation.homephone;
	add_input_occupants_1yr          := le.bs.Bill_To_Out.addr_risk_summary.occupants_1yr ;
	add_input_turnover_1yr_in        := le.bs.Bill_To_Out.addr_risk_summary.turnover_1yr_in ;
	add_input_turnover_1yr_out       := le.bs.Bill_To_Out.addr_risk_summary.turnover_1yr_out ;
	add_input_nhood_vac_prop         := le.bs.Bill_To_Out.addr_risk_summary.N_Vacant_Properties;
	add_input_nhood_bus_ct           := le.bs.Bill_To_Out.addr_risk_summary.N_Business_Count ;
	add_input_nhood_sfd_ct           := le.bs.Bill_To_Out.addr_risk_summary.N_SFD_Count ;
	add_input_nhood_mfd_ct           := le.bs.Bill_To_Out.addr_risk_summary.N_MFD_Count;
	telcordia_type                   := le.bs.Bill_To_Out.phone_verification.telcordia_type;
	phone_ver_experian               := le.bs.Bill_To_Out.Experian_Phone_Verification;
	inq_count_day                    := le.bs.Bill_To_Out.acc_logs.inquiries.countday;
	inq_count_week                   := le.bs.Bill_To_Out.acc_logs.inquiries.countweek;
	inq_perphone                     := le.bs.Bill_To_Out.acc_logs.inquiryPerPhone;
	// email_name_addr_verification     := le.bs.Bill_To_Out.email_summary.identity_email_verification_level;
	email_name_addr_verification     := le.bs.Bill_To_Out.email_summary.reverse_email.verification_level;
	// email_verification               := le.bs.Bill_To_Out.email_summary.reverse_email.verification_level;
	email_verification               := le.bs.Bill_To_Out.email_summary.identity_email_verification_level;
	adl_per_email                    := le.bs.Bill_To_Out.email_summary.reverse_email.adls_per_email;
	fp_corraddrnamecount             := le.bs.Bill_To_Out.fdattributesv2.correlationaddrnamecount;
	fp_corrphonelastnamecount        := le.bs.Bill_To_Out.fdattributesv2.correlationphonelastnamecount;
	fp_divaddrsuspidcountnew         := le.bs.Bill_To_Out.fdattributesv2.divaddrsuspidentitycountnew;
	truedid_s                        := le.bs.Ship_To_Out.truedid;
	in_state_s                       := le.bs.Ship_To_Out.shell_input.in_state;
	nap_summary_s                    := le.bs.Ship_To_Out.iid.nap_summary;
	rc_disthphoneaddr_s              := le.bs.Ship_To_Out.iid.disthphoneaddr;
	hdr_source_profile_index_s       := le.bs.Ship_To_Out.source_profile_index;
	bus_name_match_s                 := le.bs.Ship_To_Out.business_header_address_summary.bus_name_match;
	bus_phone_match_s                := le.bs.Ship_To_Out.business_header_address_summary.bus_phone_match;
	addrpop_s                        := le.bs.Ship_To_Out.input_validation.address;
	hphnpop_s                        := le.bs.Ship_To_Out.input_validation.homephone;
	add_input_occupants_1yr_s        := le.bs.Ship_To_Out.addr_risk_summary.occupants_1yr ;
	add_input_turnover_1yr_in_s      := le.bs.Ship_To_Out.addr_risk_summary.turnover_1yr_in ;
	add_input_turnover_1yr_out_s     := le.bs.Ship_To_Out.addr_risk_summary.turnover_1yr_out ;
	add_input_nhood_vac_prop_s       := le.bs.Ship_To_Out.addr_risk_summary.N_Vacant_Properties;
	add_input_nhood_bus_ct_s         := le.bs.Ship_To_Out.addr_risk_summary.N_Business_Count ;
	add_input_nhood_sfd_ct_s         := le.bs.Ship_To_Out.addr_risk_summary.N_SFD_Count ;
	add_input_nhood_mfd_ct_s         := le.bs.Ship_To_Out.addr_risk_summary.N_MFD_Count;
	phone_ver_experian_s             := le.bs.Ship_To_Out.Experian_Phone_Verification;
	adls_per_addr_c6_s               := le.bs.Ship_To_Out.velocity_counters.adls_per_addr_created_6months;
	inq_count_s                      := le.bs.Ship_To_Out.acc_logs.inquiries.counttotal;
	inq_count_day_s                  := le.bs.Ship_To_Out.acc_logs.inquiries.countday;
	inq_count_week_s                 := le.bs.Ship_To_Out.acc_logs.inquiries.countweek;
	inq_retail_count_day_s           := le.bs.Ship_To_Out.acc_logs.retail.countday;
	inq_retail_count_week_s          := le.bs.Ship_To_Out.acc_logs.retail.countweek;
	inq_peraddr_s                    := le.bs.Ship_To_Out.acc_logs.inquiryPerAddr ;
	inq_lnamesperaddr_s              := le.bs.Ship_To_Out.acc_logs.inquiryLNamesPerAddr ;
	inq_perphone_s                   := le.bs.Ship_To_Out.acc_logs.inquiryPerPhone ;
	fp_idverrisktype_s               := le.bs.Ship_To_Out.fdattributesv2.idverrisklevel;
	fp_srchcountday_s                := le.bs.Ship_To_Out.fdattributesv2.searchcountday;
	fp_corrrisktype_s                := le.bs.Ship_To_Out.fdattributesv2.correlationrisklevel;
	fp_corraddrnamecount_s           := le.bs.Ship_To_Out.fdattributesv2.correlationaddrnamecount;
	fp_corraddrphonecount_s          := le.bs.Ship_To_Out.fdattributesv2.correlationaddrphonecount;
	fp_corrphonelastnamecount_s      := le.bs.Ship_To_Out.fdattributesv2.correlationphonelastnamecount;

		
NULL := -999999999;

avs_zip := (AVS in ['A3', 'A4', 'B3', 'B4', 'I1', 'I2', 'I3', 'I4', 'IP']);

avs_missing := AVS = '';

pf_pmt_type := map(
    PAY_METHOD = 'AD' => 'Tiger Pay Card  ',
    PAY_METHOD = 'AX' => 'American Express',
    PAY_METHOD = 'BC' => 'Bit Coin        ',
    PAY_METHOD = 'BL' => 'Bill Me Later   ',
    PAY_METHOD = 'DC' => 'Diners Club     ',
    PAY_METHOD = 'DI' => 'Discover        ',
    PAY_METHOD = 'GG' => 'Google Checkout ',
    PAY_METHOD = 'MC' => 'MasterCard      ',
    PAY_METHOD = 'MX' => 'Multiple Cards  ',
    PAY_METHOD = 'PP' => 'PayPal Card     ',
    PAY_METHOD = 'VI' => 'Visa            ',
    PAY_METHOD = 'VM' => 'V.me by Visa    ',
                         'Other           ');

pf_product_dollars := PRODUCT_DOLLARS;

pf_ship_method := map(
    (SHIP_METHOD in ['01', '36'])       => 'Second Day        ',
    (SHIP_METHOD in ['02', '33', '55']) => 'Ground            ',
    (SHIP_METHOD in ['03', '38', '40']) => 'Next Day/Overnight',
    (SHIP_METHOD in ['05'])             => 'Insured USPS Mail ',
    (SHIP_METHOD in ['07'])             => 'UPS Basic         ',
    (SHIP_METHOD in ['20'])             => 'UPS WrldWd Expd   ',
    (SHIP_METHOD in ['35'])             => 'Retail Naperville ',
    (SHIP_METHOD in ['52'])             => 'Next Day Air Saver',
    (SHIP_METHOD in ['53'])             => 'UPS Saturday      ',
    (SHIP_METHOD in ['62'])             => 'AIT Logistics     ',
    (SHIP_METHOD in ['88'])             => 'YRC Freight       ',
    (SHIP_METHOD in ['91'])             => 'Downloadable      ',
                                           'Other             ');

btst_distaddraddr2_i := if((not(addrpop) and not(addrpop_s)) or distaddraddr2 = '', NULL, (integer)distaddraddr2);

s_add_input_nhood_prop_sum_1 := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));

s_add_input_nhood_bus_pct_i := map(
    not(addrpop_s)               => NULL,
    add_input_nhood_BUS_ct_s = 0 => NULL,
                                    add_input_nhood_BUS_ct_s / s_add_input_nhood_prop_sum_1);

num_inp_lat := if((string)out_lat = '', NULL, (real)StringLib.StringFilterOut(out_lat, '<>'));

num_inp_long := if((string)out_long = '', NULL,(real)StringLib.StringFilterOut(out_long, '<>'));

num_ip_lat := if((string)latitude= '', NULL,(real)StringLib.StringFilterOut((string)latitude, '<>'));

num_ip_long := if((string)longitude = '', NULL,(real)StringLib.StringFilterOut((string)longitude, '<>'));

// added code here to check if either one is 0, then set to null like SAS does
d_lat := if(num_inp_lat=NULL or num_ip_lat=NULL, NULL, if(num_inp_lat=0 or num_ip_lat=0, null, num_inp_lat - num_ip_lat));
d_long := if(num_inp_long=NULL or num_ip_long=NULL, NULL,  if(num_inp_long=0 or num_ip_long=0, null, num_inp_long - num_ip_long));

a :=if(num_inp_lat=NULL or num_ip_lat=NULL, NULL,	if(num_inp_lat=0 or num_ip_lat=0 or d_lat=null or d_long=null, null, power(sin(d_lat / 2), 2) + power(sin(d_long / 2) , 2) * cos(num_inp_lat) * cos(num_ip_lat)));

c := if(a=null, null,2 * atan2(sqrt(a), sqrt(1 - a)));

dist := if(c=null, null,3959 * c);

btst_dist_inp_addr_to_ip_addr_i := round(dist);

b_c20_email_verification_d := if(not(emailpop), NULL, (integer)email_verification);

s_c12_source_profile_index_d := if(not(truedid_s), NULL, hdr_source_profile_index_s);

b_divaddrsuspidcountnew_i := if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (integer)fp_divaddrsuspidcountnew), 999));

s_add_input_mobility_index_i := map(
    not(addrpop_s)                 => NULL,
    add_input_occupants_1yr_s <= 0 => NULL,
                                      if(max(add_input_turnover_1yr_in_s, add_input_turnover_1yr_out_s) = NULL, NULL, sum(if(add_input_turnover_1yr_in_s = NULL, 0, add_input_turnover_1yr_in_s), if(add_input_turnover_1yr_out_s = NULL, 0, add_input_turnover_1yr_out_s))) / add_input_occupants_1yr_s);

s_corrrisktype_i := map(
    not(truedid_s)         => NULL,
    fp_corrrisktype_s = '' => NULL,
                                (integer)fp_corrrisktype_s);

b_nae_email_verd_d := ((integer)email_name_addr_verification in [2, 3, 4, 5, 6, 7, 8]);

s_p88_phn_dst_to_inp_add_i := if(rc_disthphoneaddr_s = 9999, NULL, rc_disthphoneaddr_s);

s_nap_phn_verd_d := (nap_summary_s in [4, 6, 7, 9, 10, 11, 12]);

b_adl_per_email_i := if(not(emailpop), NULL, min(if(adl_per_email = NULL, -NULL, adl_per_email), 999));

add_input_nhood_prop_sum_1 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

b_add_input_nhood_bus_pct_i := map(
    not(addrpop)               => NULL,
    add_input_nhood_BUS_ct = 0 => NULL,
                                  add_input_nhood_BUS_ct / add_input_nhood_prop_sum_1);

btst_lastscore_d := lastscore;

s_corraddrphonecount_d := if(not(truedid_s), NULL, min(if(fp_corraddrphonecount_s = '', -NULL, (integer)fp_corraddrphonecount_s), 999));

btst_distphone2addr2_i := if((not(hphnpop_s) and not(addrpop_s)) or (string)distphone2addr2 = '', NULL, (integer)distphone2addr2);

s_bus_phone_match_d := if(not(addrpop_s), NULL, (integer)(bus_phone_match_s = 3));

s_l79_adls_per_addr_c6_i := if(not(addrpop_s), NULL, min(if(adls_per_addr_c6_s = NULL, -NULL, adls_per_addr_c6_s), 999));

s_idverrisktype_i := if(not(truedid_s) or fp_idverrisktype_s = '', (string)NULL, fp_idverrisktype_s);

b_bus_phone_match_d := if(not(addrpop), NULL, (integer)(bus_phone_match = 3));

s_inq_per_addr_i := if(not(addrpop_s), NULL, min(if(inq_peraddr_s = NULL, -NULL, inq_peraddr_s), 999));

s_phone_ver_experian_d := if(not(truedid_s) or phone_ver_experian_s = '-1', NULL, (integer)phone_ver_experian_s);

b_corraddrnamecount_d := if(not(truedid), NULL, min(if(fp_corraddrnamecount = '', -NULL, (integer)fp_corraddrnamecount), 999));

b_phone_ver_experian_d := if(not(truedid) or phone_ver_experian = '-1', NULL, (integer)phone_ver_experian);

s_corraddrnamecount_d := if(not(truedid_s), NULL, (integer)min(if(fp_corraddrnamecount_s = '', -NULL, (integer)fp_corraddrnamecount_s), 999));

s_add_input_nhood_prop_sum := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));

s_add_input_nhood_vac_pct_i := map(
    not(addrpop_s)                 => NULL,
    s_add_input_nhood_prop_sum = 0 => -1,
                                      add_input_nhood_VAC_prop_s / s_add_input_nhood_prop_sum);

s_inq_per_phone_i := if(not(hphnpop_s), NULL, min(if(inq_perphone_s = NULL, -NULL, inq_perphone_s), 999));

s_corrphonelastnamecount_d := if(not(truedid_s), NULL, min(if(fp_corrphonelastnamecount_s = '', -NULL, (integer)fp_corrphonelastnamecount_s), 999));

s_inq_retail_count_week_i := if(not(truedid_s), NULL, min(if(inq_Retail_count_week_s = NULL, -NULL, inq_Retail_count_week_s), 999));

b_corrphonelastnamecount_d := if(not(truedid), NULL, min(if(fp_corrphonelastnamecount = '', -NULL, (integer)fp_corrphonelastnamecount), 999));

s_srchcountday_i := if(not(truedid_s), NULL, min(if(fp_srchcountday_s = '', -NULL, (integer)fp_srchcountday_s), 999));

s_inq_count_i := if(not(truedid_s), NULL, min(if(inq_count_s = NULL, -NULL, inq_count_s), 999));

b_add_input_mobility_index_i := map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr);

b_nae_fname_verd_d := ((integer)email_name_addr_verification in [2, 5, 6, 8]);

add_input_nhood_prop_sum := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

b_add_input_nhood_vac_pct_i := map(
    not(addrpop)                 => NULL,
    add_input_nhood_prop_sum = 0 => -1,
                                    add_input_nhood_VAC_prop / add_input_nhood_prop_sum);

s_inq_lnames_per_addr_i := if(not(addrpop_s), NULL, min(if(inq_lnamesperaddr_s = NULL, -NULL, inq_lnamesperaddr_s), 999));

b_p85_phn_invalid_i := map(
    not(hphnpop)                                                    													 => NULL,
    (integer)rc_phonevalflag = 0 or (integer)rc_hphonevalflag = 0 or (integer)rc_phonetype = 5 => 1,
																																																	   0);

s_bus_name_nover_i := if(not(addrpop_s), NULL, (integer)(bus_name_match_s = 1));

b_inq_per_phone_i := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

s_inq_retail_count_day_i := if(not(truedid_s), NULL, min(if(inq_Retail_count_day_s = NULL, -NULL, inq_Retail_count_day_s), 999));

// email_topleveldomain := Models.Common.getw(Models.Common.getw(in_email_address, -1, '@'), -1, '.');
email_domain := TRIM(StringLib.StringToUpperCase(in_email_address [(StringLib.StringFind(in_email_address, '@', StringLib.StringFindCount(in_email_address, '@')) + 1)..]));
email_topleveldomain :=TRIM(email_domain [(StringLib.StringFind(email_domain, '.', StringLib.StringFindCount(email_domain, '.')) + 1)..]);

btst_email_topleveldomain_n := map(
    in_email_address = ''                                                             => ' ',
    (email_topleveldomain in ['COM', 'NET', 'EDU', 'ORG', 'US', 'GOV', 'BIZ', 'MIL']) => email_topleveldomain,
                                                                                         'OTH');

b_p86_phn_pager_i := map(
    not(hphnpop)                                                                                                                                                                                                                                            => NULL,
    (integer)rc_hriskphoneflag = 2 or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '2' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '02' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '56' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '61' => 1,
                                                                                                                                                                                                                                                               0);

btst_email_last_score_d := elastscore;

final_score_0 := -1.4892037849;

final_score_1_c42 := map(
    NULL < (integer)avs_zip AND (integer)avs_zip <= 0.5 => 0.5798639475,
    (integer)avs_zip > 0.5                              => 0.0658358576,
                                                           0.1955457282);

final_score_1_c41 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => final_score_1_c42,
    (integer)avs_missing > 0.5                                  => -0.3004652219,
                                                                   0.0601565176);

final_score_1 := map(
    NULL < (integer)b_nae_email_verd_d AND (integer)b_nae_email_verd_d <= 0.5 => final_score_1_c41,
    (integer)b_nae_email_verd_d > 0.5                                         => -0.3696047894,
                                                                                 -0.0917905469);

final_score_2_c45 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 7.5 => -0.1869432793,
    btst_distaddraddr2_i > 7.5                                  => 0.1496288036,
                                                                   -0.1216620386);

final_score_2_c44 := map(
    NULL < (integer)avs_zip AND (integer)avs_zip <= 0.5 => 0.4522124854,
    (integer)avs_zip > 0.5                              => final_score_2_c45,
                                                           -0.0153398918);

final_score_2 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => final_score_2_c44,
    (integer)avs_missing > 0.5                         					=> -0.2766175670,
																																	 -0.0925391470);

final_score_3_c47 := map(
    (pf_ship_method in ['Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'Second Day', 'UPS Basic', 'UPS WrldWd Expd', 'YRC Freight']) => -0.1637492446,
    (pf_ship_method in ['AIT Logistics', 'Insured USPS Mail', 'Next Day Air Saver', 'UPS Saturday'])                                                                => 0.4480458000,
                                                                                                                                                                       -0.1196416143);

final_score_3_c48 := if(ST_cen_span_lang <>' ',
    map(
    NULL < (real)ST_cen_blue_col AND (real)ST_cen_blue_col <= 11.15 => 0.4427924593,
    (real)ST_cen_blue_col > 11.15                                      => -0.0031403678,
                                                                             0.3068635373),
																																						 0.3068635373);

final_score_3 :=if(ST_cen_span_lang <>' ', 
    map(
    NULL < (real)ST_cen_span_lang AND (real)ST_cen_span_lang <= 182.5 => final_score_3_c47,
    (real)ST_cen_span_lang > 182.5                                       => final_score_3_c48,
                                                                               -0.1022307367),
																																							-0.1022307367) ;

final_score_4_c51 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 25.49 => 1.0235485805,
    pf_product_dollars > 25.49                                => -0.0042377656,
                                                                 0.1914801338);

final_score_4_c50 := map(
    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'MIL', 'ORG', 'OTH', 'US']) => 0.0184978882,
    (btst_email_topleveldomain_n in ['EDU', 'GOV', 'NET'])                     => final_score_4_c51,
                                                                                  -0.0777021222);

final_score_4 := map(
    NULL < (integer)btst_email_last_score_d AND (integer)btst_email_last_score_d <= 0.5 => final_score_4_c50,
    (integer)btst_email_last_score_d > 0.5                                              => -0.0445600548,
                                                                                           -0.0046855162);

final_score_5_c54 := map(
    (pf_pmt_type in ['American Express', 'Bill Me Later', 'Discover', 'MasterCard', 'Multiple Cards', 'Tiger Pay Card', 'Visa']) => 0.1274125349,
    (pf_pmt_type in ['Bit Coin', 'Diners Club', 'PayPal Card', 'V.me by Visa'])                                                  => 0.7846035256,
                                                                                                                                    0.1516513119);

final_score_5_c53 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 762.5 => -0.0967482005,
    btst_dist_inp_addr_to_ip_addr_i > 762.5                                             => 0.0802023565,
                                                                                           final_score_5_c54);

final_score_5 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 96.855 => -0.0935039264,
    pf_product_dollars > 96.855                                => final_score_5_c53,
                                                                  -0.0262509480);

final_score_6_c57 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => 0.4002600314,
    (integer)avs_missing > 0.5                                  => -0.0822061055,
                                                                   0.1406848913);

final_score_6_c56 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 49.995 => -0.1339731778,
    pf_product_dollars > 49.995                                => final_score_6_c57,
                                                                  -0.0450729492);

final_score_6 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 2962.5 => -0.0984368749,
    btst_dist_inp_addr_to_ip_addr_i > 2962.5                                             => 0.1064125133,
                                                                                            final_score_6_c56);

final_score_7_c60 := map(
    (pf_ship_method in ['AIT Logistics', 'Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'YRC Freight']) => -0.0189809345,
    (pf_ship_method in ['Insured USPS Mail', 'Next Day Air Saver', 'Second Day', 'UPS Basic', 'UPS Saturday', 'UPS WrldWd Expd'])      => 0.2981161642,
                                                                                                                                          0.0771802920);

final_score_7_c59 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 239.985 => -0.1337865415,
    pf_product_dollars > 239.985                                => final_score_7_c60,
                                                                   -0.0780936554);

final_score_7 := map(
    NULL < b_divaddrsuspidcountnew_i AND b_divaddrsuspidcountnew_i <= 5.5 => final_score_7_c59,
    b_divaddrsuspidcountnew_i > 5.5                                       => 0.2861547390,
                                                                             0.1382012417);

final_score_8_c63 := map(
    (pf_pmt_type in ['American Express', 'Bill Me Later', 'Bit Coin', 'MasterCard', 'Multiple Cards', 'PayPal Card', 'Visa']) => -0.0443782437,
    (pf_pmt_type in ['Diners Club', 'Discover', 'Tiger Pay Card', 'V.me by Visa'])                                            => 0.1593930624,
                                                                                                                                 -0.0252226486);

final_score_8_c62 := map(
    (pf_ship_method in ['AIT Logistics', 'Downloadable', 'Ground', 'Next Day Air Saver', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'Second Day', 'UPS Basic', 'YRC Freight']) => final_score_8_c63,
    (pf_ship_method in ['Insured USPS Mail', 'UPS Saturday', 'UPS WrldWd Expd'])                                                                                                        => 0.2460362784,
                                                                                                                                                                                           -0.0224495065);

final_score_8 := if(BT_cen_span_lang <>' ',
    map(
    NULL < (real)BT_cen_span_lang AND (real)BT_cen_span_lang <= 196.5 => final_score_8_c62,
    (real)BT_cen_span_lang > 196.5                                       => 0.1637335138,
                                                                               -0.1629250991),
																																							 -0.1629250991);

final_score_9_c65 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 37.5 => -0.2044429627,
    btst_distaddraddr2_i > 37.5                                  => 0.4569190488,
                                                                    -0.1339755460);

final_score_9_c66 := map(
    NULL < s_add_input_mobility_index_i AND s_add_input_mobility_index_i <= 0.4645091931 => 0.0984689205,
    s_add_input_mobility_index_i > 0.4645091931                                          => 0.8247658043,
                                                                                            0.5762394370);

final_score_9 :=if(ST_cen_span_lang<>'', 
    map(
    NULL < (real)ST_cen_span_lang AND (real)ST_cen_span_lang <= 184.5 => final_score_9_c65,
    (real)ST_cen_span_lang > 184.5                                       => final_score_9_c66,
                                                                               -0.1703671979),
																																							  -0.1703671979);

final_score_10_c69 := map(
    NULL < b_add_input_mobility_index_i AND b_add_input_mobility_index_i <= 0.3612045971 => -0.0790145128,
    b_add_input_mobility_index_i > 0.3612045971                                          => 0.1234198345,
                                                                                            0.0398056476);

final_score_10_c68 := map(
    NULL < s_inq_count_i AND s_inq_count_i <= 92 => -0.0227708550,
    s_inq_count_i > 92                           => 0.9074778844,
                                                    final_score_10_c69);

final_score_10 := map(
    NULL < s_inq_per_addr_i AND s_inq_per_addr_i <= 11.5 => final_score_10_c68,
    s_inq_per_addr_i > 11.5                              => 0.1802306601,
                                                            -0.0929138651);

final_score_11_c72 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 1066.5 => -0.0418341473,
    btst_dist_inp_addr_to_ip_addr_i > 1066.5                                             => 0.4728983201,
                                                                                            0.5164813689);

final_score_11_c71 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => final_score_11_c72,
    (integer)avs_missing > 0.5                                  => -0.1712498823,
                                                                   0.2567736351);

final_score_11 := map(
    NULL < (integer)btst_relatives_in_common AND (integer)btst_relatives_in_common <= 0.5 => final_score_11_c71,
    (integer)btst_relatives_in_common > 0.5                                               => -0.1705302870,
                                                                                             -0.0452540678);

final_score_12_c75 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 1.5 => 0.0620050598,
    b_c20_email_verification_d > 1.5                                        => -0.0695319525,
                                                                               0.1634361892);

final_score_12_c74 := map(
    NULL < s_bus_phone_match_d AND s_bus_phone_match_d <= 0.5 => final_score_12_c75,
    s_bus_phone_match_d > 0.5                                 => -0.2030885303,
                                                                 -0.0499249581);

final_score_12 := map(
    NULL < s_l79_adls_per_addr_c6_i AND s_l79_adls_per_addr_c6_i <= 3.5 => final_score_12_c74,
    s_l79_adls_per_addr_c6_i > 3.5                                      => 0.1277965730,
                                                                           -0.0697846134);

final_score_13_c77 := map(
    NULL < (integer)s_nap_phn_verd_d AND (integer)s_nap_phn_verd_d <= 0.5 => 0.1688263147,
    (integer)s_nap_phn_verd_d > 0.5                                       => -0.0446084055,
                                                                             0.0688357026);

final_score_13_c78 := map(
    NULL < b_corraddrnamecount_d AND b_corraddrnamecount_d <= 0.5 => 0.1444855532,
    b_corraddrnamecount_d > 0.5                                   => -0.1207128946,
                                                                     0.1495409439);

final_score_13 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 2614.5 => -0.0783753343,
    btst_dist_inp_addr_to_ip_addr_i > 2614.5                                             => final_score_13_c77,
                                                                                            final_score_13_c78);

final_score_14_c80 := map(
    NULL < (real)btst_lastscore_d AND (real)btst_lastscore_d <= 55 => 0.1537336692,
    (real)btst_lastscore_d > 55                                       => -0.1346414325,
                                                                            -0.1116771990);

final_score_14_c81 := if(ST_cen_span_lang<>'',
    map(
    NULL < (real)ST_cen_span_lang AND (real)ST_cen_span_lang <= 129.5 => 0.0285199965,
    (real)ST_cen_span_lang > 129.5                                       => 0.2582288899,
                                                                               -0.0816134875),
																																							 -0.0816134875);

final_score_14 := map(
    NULL < s_c12_source_profile_index_d AND s_c12_source_profile_index_d <= 0.5 => 0.1779566387,
    s_c12_source_profile_index_d > 0.5                                          => final_score_14_c80,
                                                                                   final_score_14_c81);

final_score_15_c84 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 179.945 => -0.0598384589,
    pf_product_dollars > 179.945                                => 0.0697866958,
                                                                   -0.0157636784);

final_score_15_c83 := map(
    NULL < btst_distphone2addr2_i AND btst_distphone2addr2_i <= 3.5 => -0.0938209925,
    btst_distphone2addr2_i > 3.5                                    => 0.1374916972,
                                                                       final_score_15_c84);

final_score_15 := map(
    (pf_ship_method in ['AIT Logistics', 'Downloadable', 'Ground', 'Next Day Air Saver', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'Second Day', 'UPS Basic', 'YRC Freight']) => final_score_15_c83,
    (pf_ship_method in ['Insured USPS Mail', 'UPS Saturday', 'UPS WrldWd Expd'])                                                                                                        => 0.3291752366,
                                                                                                                                                                                           -0.0211848475);

final_score_16_c87 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => 0.1585986402,
    (integer)avs_missing > 0.5                                  => -0.1200874974,
                                                                   0.0862398688);

final_score_16_c86 := map(
    NULL < s_corraddrphonecount_d AND s_corraddrphonecount_d <= 0.5 => final_score_16_c87,
    s_corraddrphonecount_d > 0.5                                    => -0.1076842256,
                                                                       0.1424978257);

final_score_16 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 1.5 => final_score_16_c86,
    b_c20_email_verification_d > 1.5                                        => -0.0743233862,
                                                                               0.1932584669);

final_score_17_c90 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 3.5 => 0.1679233087,
    b_c20_email_verification_d > 3.5                                        => -0.1421494167,
                                                                               0.4275833398);

final_score_17_c89 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => final_score_17_c90,
    (integer)avs_missing > 0.5                                  => -0.1449027758,
                                                                   0.0551708657);

final_score_17 := map(
    NULL < s_corrrisktype_i AND s_corrrisktype_i <= 8.5 => -0.1044267101,
    s_corrrisktype_i > 8.5                              => final_score_17_c89,
                                                           0.1156896780);

final_score_18_c93 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 0.5 => 0.1259451481,
    b_c20_email_verification_d > 0.5                                        => 0.0261691690,
                                                                               0.1667683792);

final_score_18_c92 := map(
    NULL < s_bus_phone_match_d AND s_bus_phone_match_d <= 0.5 => final_score_18_c93,
    s_bus_phone_match_d > 0.5                                 => -0.0946543811,
                                                                 -0.0340739831);

final_score_18 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 159.965 => -0.0429112345,
    pf_product_dollars > 159.965                                => final_score_18_c92,
                                                                   -0.0166794105);

final_score_19_c96 := map(
    (pf_ship_method in ['AIT Logistics', 'Downloadable', 'Ground', 'Next Day Air Saver', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'Second Day', 'UPS Basic', 'UPS Saturday', 'YRC Freight']) => -0.0830468053,
    (pf_ship_method in ['Insured USPS Mail', 'UPS WrldWd Expd'])                                                                                                                                        => 0.6724503436,
                                                                                                                                                                                                           -0.0774130667);

final_score_19_c95 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 15.5 => final_score_19_c96,
    btst_distaddraddr2_i > 15.5                                  => 0.0804761449,
                                                                    -0.0573484417);

final_score_19 := if(ST_cen_span_lang <>'',
    map(
    NULL < (real)ST_cen_span_lang AND (real)ST_cen_span_lang <= 183.5 => final_score_19_c95,
    (real)ST_cen_span_lang > 183.5                                       => 0.1160022451,
                                                                               -0.0413042439),
																																							 -0.0413042439);

final_score_20_c99 := map(
    NULL < b_add_input_nhood_vac_pct_i AND b_add_input_nhood_vac_pct_i <= 1.3292978208 => 0.0050233962,
    b_add_input_nhood_vac_pct_i > 1.3292978208                                         => 0.2184876194,
                                                                                          0.0110100699);

final_score_20_c98 := map(
    NULL < b_phone_ver_experian_d AND b_phone_ver_experian_d <= 0.5 => 0.0598312875,
    b_phone_ver_experian_d > 0.5                                    => -0.0371558321,
                                                                       final_score_20_c99);

final_score_20 := map(
    NULL < b_bus_phone_match_d AND b_bus_phone_match_d <= 0.5 => final_score_20_c98,
    b_bus_phone_match_d > 0.5                                 => -0.0787739267,
                                                                 -0.0112520731);

final_score_21_c102 := map(
    NULL < (integer)s_nap_phn_verd_d AND (integer)s_nap_phn_verd_d <= 0.5 => 0.3299380846,
    (integer)s_nap_phn_verd_d > 0.5                                       => -0.0014408592,
                                                                             0.2442717245);

final_score_21_c101 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 22.5 => -0.1064433192,
    btst_distaddraddr2_i > 22.5                                  => final_score_21_c102,
                                                                    -0.0617841906);

final_score_21 := map(
    NULL < s_add_input_nhood_bus_pct_i AND s_add_input_nhood_bus_pct_i <= 0.6195188066 => final_score_21_c101,
    s_add_input_nhood_bus_pct_i > 0.6195188066                                         => 0.4012657554,
                                                                                          -0.0869657522);

final_score_22_c105 := map(
    (pf_ship_method in ['AIT Logistics', 'Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'Second Day', 'UPS Basic']) => -0.0759368069,
    (pf_ship_method in ['Insured USPS Mail', 'Next Day Air Saver', 'UPS Saturday', 'UPS WrldWd Expd', 'YRC Freight'])                              => 0.1326890600,
                                                                                                                                                      -0.0641071636);

final_score_22_c104 := map(
    NULL < b_add_input_nhood_bus_pct_i AND b_add_input_nhood_bus_pct_i <= 0.5818370356 => final_score_22_c105,
    b_add_input_nhood_bus_pct_i > 0.5818370356                                         => 0.1579114388,
                                                                                          -0.0494306693);

final_score_22 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 54.5 => final_score_22_c104,
    btst_distaddraddr2_i > 54.5                                  => 0.1102991660,
                                                                    -0.0463111354);

final_score_23_c108 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 109.995 => -0.0592055590,
    pf_product_dollars > 109.995                                => 0.0911052173,
                                                                   0.0448503320);

final_score_23_c107 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 9.5 => -0.0529021686,
    btst_distaddraddr2_i > 9.5                                  => final_score_23_c108,
                                                                   -0.0381445962);

final_score_23 := map(
    NULL < s_l79_adls_per_addr_c6_i AND s_l79_adls_per_addr_c6_i <= 3.5 => final_score_23_c107,
    s_l79_adls_per_addr_c6_i > 3.5                                      => 0.1124477479,
                                                                           -0.0902485569);

final_score_24_c111 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => 0.1404139278,
    (integer)avs_missing > 0.5                                  => -0.0803122898,
                                                                   0.0461634863);

final_score_24_c110 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 1377 => -0.0542234698,
    btst_dist_inp_addr_to_ip_addr_i > 1377                                             => 0.1143704799,
                                                                                          final_score_24_c111);

final_score_24 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 1.5 => final_score_24_c110,
    b_c20_email_verification_d > 1.5                                        => -0.0611050552,
                                                                               0.1073545537);

final_score_25_c114 := map(
    NULL < s_bus_phone_match_d AND s_bus_phone_match_d <= 0.5 => 0.0624214002,
    s_bus_phone_match_d > 0.5                                 => -0.0867054230,
                                                                 0.0078382944);

final_score_25_c113 := map(
    (pf_ship_method in ['AIT Logistics', 'Downloadable', 'Ground', 'Next Day Air Saver', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'Second Day', 'UPS Saturday', 'YRC Freight']) => final_score_25_c114,
    (pf_ship_method in ['Insured USPS Mail', 'UPS Basic', 'UPS WrldWd Expd'])                                                                                                              => 0.2907509346,
                                                                                                                                                                                              0.0341529724);

final_score_25 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 249.925 => -0.0230803679,
    pf_product_dollars > 249.925                                => final_score_25_c113,
                                                                   -0.0078804565);

final_score_26_c117 := map(
    NULL < b_corrphonelastnamecount_d AND b_corrphonelastnamecount_d <= 0.5 => 0.0332318602,
    b_corrphonelastnamecount_d > 0.5                                        => -0.0417592340,
                                                                               0.0448113207);

final_score_26_c116 := map(
    NULL < b_bus_phone_match_d AND b_bus_phone_match_d <= 0.5 => final_score_26_c117,
    b_bus_phone_match_d > 0.5                                 => -0.0693046011,
                                                                 -0.0136116506);

final_score_26 := map(
    NULL < b_inq_per_phone_i AND b_inq_per_phone_i <= 17.5 => final_score_26_c116,
    b_inq_per_phone_i > 17.5                               => 0.2374760063,
                                                              -0.0933584696);

final_score_27_c120 := map(
    NULL < (integer)b_nae_email_verd_d AND (integer)b_nae_email_verd_d <= 0.5 => 0.0714581796,
    (integer)b_nae_email_verd_d > 0.5                                         => -0.0353106197,
                                                                                 0.0396867279);

final_score_27_c119 := map(
    NULL < s_corrrisktype_i AND s_corrrisktype_i <= 6.5 => -0.0806387342,
    s_corrrisktype_i > 6.5                              => final_score_27_c120,
                                                           0.0429303819);

final_score_27 := map(
    (pf_ship_method in ['Downloadable', 'Ground', 'Other', 'Retail Naperville'])                                                                                                        => -0.0403253993,
    (pf_ship_method in ['AIT Logistics', 'Insured USPS Mail', 'Next Day Air Saver', 'Next Day/Overnight', 'Second Day', 'UPS Basic', 'UPS Saturday', 'UPS WrldWd Expd', 'YRC Freight']) => final_score_27_c119,
                                                                                                                                                                                           -0.0219642876);

final_score_28_c123 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 153.485 => -0.0095856810,
    pf_product_dollars > 153.485                                => 0.1356223629,
                                                                   0.0667268324);

final_score_28_c122 := map(
    NULL < s_p88_phn_dst_to_inp_add_i AND s_p88_phn_dst_to_inp_add_i <= 3.5 => -0.0332564703,
    s_p88_phn_dst_to_inp_add_i > 3.5                                        => final_score_28_c123,
                                                                               0.0634273512);

final_score_28 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 0.5 => final_score_28_c122,
    b_c20_email_verification_d > 0.5                                        => -0.0258491401,
                                                                               0.0366299010);

final_score_29_c126 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 11.3 => 0.0098576282,
    pf_product_dollars > 11.3                                => 0.9315046702,
                                                                0.0894471827);

final_score_29_c125 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 11.985 => final_score_29_c126,
    pf_product_dollars > 11.985                                => -0.0031853636,
                                                                  0.0002633404);

final_score_29 := map(
    NULL < b_p86_phn_pager_i AND b_p86_phn_pager_i <= 0.5 => final_score_29_c125,
    b_p86_phn_pager_i > 0.5                               => 0.2075248391,
                                                             -0.0213271459);

final_score_30_c129 := map(
    NULL < s_add_input_mobility_index_i AND s_add_input_mobility_index_i <= 0.36330298635 => -0.0403382131,
    s_add_input_mobility_index_i > 0.36330298635                                          => 0.0524447081,
                                                                                             0.0198860882);

final_score_30_c128 := map(
    NULL < s_inq_retail_count_week_i AND s_inq_retail_count_week_i <= 5.5 => -0.0186557182,
    s_inq_retail_count_week_i > 5.5                                       => 0.3258570186,
                                                                             final_score_30_c129);

final_score_30 := map(
    NULL < s_inq_per_addr_i AND s_inq_per_addr_i <= 11.5 => final_score_30_c128,
    s_inq_per_addr_i > 11.5                              => 0.0877124875,
                                                            -0.0378959304);

final_score_31_c132 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => 0.1581473534,
    (integer)avs_missing > 0.5                                  => -0.0424681731,
                                                                   0.0522853979);

final_score_31_c131 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 49.995 => -0.0539201262,
    pf_product_dollars > 49.995                                => final_score_31_c132,
                                                                  -0.0189921460);

final_score_31 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 1767.5 => -0.0445853690,
    btst_dist_inp_addr_to_ip_addr_i > 1767.5                                             => 0.0400350309,
                                                                                            final_score_31_c131);

final_score_32_c135 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => 0.1001127425,
    (integer)avs_missing > 0.5                                  => -0.0614811689,
                                                                   0.0331214291);

final_score_32_c134 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 2534 => -0.0221852509,
    btst_dist_inp_addr_to_ip_addr_i > 2534                                             => 0.0882171190,
                                                                                          final_score_32_c135);

final_score_32 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 1.5 => final_score_32_c134,
    b_c20_email_verification_d > 1.5                                        => -0.0437721507,
                                                                               0.0693385986);

final_score_33_c138 := map(
    NULL < s_corraddrphonecount_d AND s_corraddrphonecount_d <= 0.5 => 0.0649047391,
    s_corraddrphonecount_d > 0.5                                    => -0.0638059097,
                                                                       0.0342234690);

final_score_33_c137 := map(
    NULL < s_phone_ver_experian_d AND s_phone_ver_experian_d <= 0.5 => final_score_33_c138,
    s_phone_ver_experian_d > 0.5                                    => -0.0453916169,
                                                                       0.0274412598);

final_score_33 := map(
    NULL < b_adl_per_email_i AND b_adl_per_email_i <= 0.5 => final_score_33_c137,
    b_adl_per_email_i > 0.5                               => -0.0578000627,
                                                             0.0584968393);

final_score_34_c141 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 0.5 => 0.1538327605,
    b_c20_email_verification_d > 0.5                                        => 0.0038688913,
                                                                               0.2444321300);

final_score_34_c140 := map(
    (pf_ship_method in ['Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'UPS Basic', 'UPS WrldWd Expd', 'YRC Freight']) => -0.0601513946,
    (pf_ship_method in ['AIT Logistics', 'Insured USPS Mail', 'Next Day Air Saver', 'Second Day', 'UPS Saturday'])                                    => final_score_34_c141,
                                                                                                                                                         -0.0370739189);

final_score_34 :=  if(ST_cen_span_lang<>'',
    map(
    NULL < (real)ST_cen_span_lang AND (real)ST_cen_span_lang <= 184.5 => final_score_34_c140,
    (real)ST_cen_span_lang > 184.5                                       => 0.0984239981,
                                                                               -0.0408040448),
																																							 -0.0408040448);

final_score_35_c144 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 159.5 => -0.0466359007,
    btst_distaddraddr2_i > 159.5                                  => 0.0442884526,
                                                                     -0.0795449091);

final_score_35_c143 := map(
    (pf_ship_method in ['AIT Logistics', 'Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'Second Day', 'UPS Basic']) => final_score_35_c144,
    (pf_ship_method in ['Insured USPS Mail', 'Next Day Air Saver', 'UPS Saturday', 'UPS WrldWd Expd', 'YRC Freight'])                              => 0.0915153019,
                                                                                                                                                      -0.0319827787);

final_score_35 := map(
    NULL < b_divaddrsuspidcountnew_i AND b_divaddrsuspidcountnew_i <= 4.5 => final_score_35_c143,
    b_divaddrsuspidcountnew_i > 4.5                                       => 0.1134604870,
                                                                             0.0525040216);

final_score_36_c147 := map(
    NULL < s_l79_adls_per_addr_c6_i AND s_l79_adls_per_addr_c6_i <= 3.5 => -0.0573550000,
    s_l79_adls_per_addr_c6_i > 3.5                                      => 0.0456545782,
                                                                           -0.0054629568);

final_score_36_c146 := map(
    NULL < s_bus_name_nover_i AND s_bus_name_nover_i <= 0.5 => 0.0485758769,
    s_bus_name_nover_i > 0.5                                => final_score_36_c147,
                                                               -0.0069355970);

final_score_36 := map(
    NULL < s_inq_retail_count_day_i AND s_inq_retail_count_day_i <= 1.5 => -0.0051871177,
    s_inq_retail_count_day_i > 1.5                                      => 0.2552994673,
                                                                           final_score_36_c146);

final_score_37_c150 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 46.695 => -0.0361350357,
    pf_product_dollars > 46.695                                => 0.0744883059,
                                                                  0.0012983644);

final_score_37_c149 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 3354.5 => -0.0089103087,
    btst_dist_inp_addr_to_ip_addr_i > 3354.5                                             => 0.0254160505,
                                                                                            final_score_37_c150);

final_score_37 := if(ST_cen_urban_p <>'',
    map(
    NULL < (real)ST_cen_urban_p AND (real)ST_cen_urban_p <= 90.75 => -0.0274309334,
    (real)ST_cen_urban_p > 90.75                                     => final_score_37_c149,
                                                                           -0.0234496792),
																																					  -0.0234496792);

final_score_38_c153 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 17.5 => 0.0189307681,
    btst_distaddraddr2_i > 17.5                                  => 0.0846027737,
                                                                    0.0324621247);

final_score_38_c152 := map(
    NULL < (integer)s_idverrisktype_i AND (integer)s_idverrisktype_i <= 1.5 => -0.0648386203,
    (integer)s_idverrisktype_i > 1.5                                        => final_score_38_c153,
                                                                               0.0578466567);

final_score_38 := map(
    NULL < b_adl_per_email_i AND b_adl_per_email_i <= 0.5 => final_score_38_c152,
    b_adl_per_email_i > 0.5                               => -0.0704115636,
                                                             0.0831057802);

final_score_39_c155 := map(
    NULL < btst_distphone2addr2_i AND btst_distphone2addr2_i <= 9.5 => -0.0667720618,
    btst_distphone2addr2_i > 9.5                                    => 0.0793642519,
                                                                       -0.0163483858);

final_score_39_c156 := map(
    NULL < s_corraddrnamecount_d AND s_corraddrnamecount_d <= 0.5 => 0.0760412918,
    s_corraddrnamecount_d > 0.5                                   => -0.0157483177,
                                                                     0.0663083807);

final_score_39 := if (ST_cen_span_lang<>'',
    map(
    NULL < (real)ST_cen_span_lang AND (real)ST_cen_span_lang <= 158.5 => final_score_39_c155,
    (real)ST_cen_span_lang > 158.5                                       => final_score_39_c156,
                                                                               0.0015460315),
																																							 0.0015460315);

final_score_40_c159 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 3.5 => 0.0556426447,
    b_c20_email_verification_d > 3.5                                        => -0.0423391640,
                                                                               0.0857856199);

final_score_40_c158 := map(
    NULL < s_bus_phone_match_d AND s_bus_phone_match_d <= 0.5 => final_score_40_c159,
    s_bus_phone_match_d > 0.5                                 => -0.0537469764,
                                                                 0.0079840447);

final_score_40 := map(
    NULL < s_phone_ver_experian_d AND s_phone_ver_experian_d <= 0.5 => final_score_40_c158,
    s_phone_ver_experian_d > 0.5                                    => -0.0426466548,
                                                                       0.0057767399);

final_score_41_c161 := map(
    NULL < s_inq_per_addr_i AND s_inq_per_addr_i <= 8.5 => -0.0116709106,
    s_inq_per_addr_i > 8.5                              => 0.0625578970,
                                                           -0.0072358899);

final_score_41_c162 := map(
    NULL < s_add_input_nhood_vac_pct_i AND s_add_input_nhood_vac_pct_i <= 1.33775362725 => 0.0059187309,
    s_add_input_nhood_vac_pct_i > 1.33775362725                                         => 0.0932546288,
                                                                                           -0.0121116504);

final_score_41 := map(
    NULL < s_srchcountday_i AND s_srchcountday_i <= 1.5 => final_score_41_c161,
    s_srchcountday_i > 1.5                              => 0.2360918948,
                                                           final_score_41_c162);

final_score_42_c165 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 4.5 => 0.0320812844,
    btst_distaddraddr2_i > 4.5                                  => 0.0807034165,
                                                                   0.0429858932);

final_score_42_c164 := map(
    (pf_pmt_type in ['American Express', 'Bill Me Later', 'Bit Coin', 'MasterCard', 'Multiple Cards', 'PayPal Card', 'Visa']) => -0.0072669217,
    (pf_pmt_type in ['Diners Club', 'Discover', 'Tiger Pay Card', 'V.me by Visa'])                                            => final_score_42_c165,
                                                                                                                                 -0.0024645708);

final_score_42 := map(
    NULL < b_p85_phn_invalid_i AND b_p85_phn_invalid_i <= 0.5 => final_score_42_c164,
    b_p85_phn_invalid_i > 0.5                                 => 0.0666471445,
                                                                 -0.0616934210);

final_score_43_c168 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 179.96 => -0.0306394879,
    pf_product_dollars > 179.96                                => 0.0477407317,
                                                                  0.0019867611);

final_score_43_c167 := map(
    NULL < s_p88_phn_dst_to_inp_add_i AND s_p88_phn_dst_to_inp_add_i <= 3.5 => -0.0390001369,
    s_p88_phn_dst_to_inp_add_i > 3.5                                        => final_score_43_c168,
                                                                               0.0202975437);

final_score_43 := map(
    NULL < s_inq_per_phone_i AND s_inq_per_phone_i <= 6.5 => final_score_43_c167,
    s_inq_per_phone_i > 6.5                               => 0.0848017055,
                                                             -0.0510499274);

final_score_44_c171 := map(
    NULL < (integer)b_nae_email_verd_d AND (integer)b_nae_email_verd_d <= 0.5 => 0.0824607934,
    (integer)b_nae_email_verd_d > 0.5                                         => -0.0545838137,
                                                                                 0.0581627570);

final_score_44_c170 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 37.5 => -0.0417232651,
    btst_distaddraddr2_i > 37.5                                  => final_score_44_c171,
                                                                    -0.0300766750);

final_score_44 := map(
    NULL < b_divaddrsuspidcountnew_i AND b_divaddrsuspidcountnew_i <= 4.5 => final_score_44_c170,
    b_divaddrsuspidcountnew_i > 4.5                                       => 0.1065553076,
                                                                             0.0744387111);

final_score_45_c174 := map(
    NULL < b_corraddrnamecount_d AND b_corraddrnamecount_d <= 0.5 => 0.0457412530,
    b_corraddrnamecount_d > 0.5                                   => -0.0290646341,
                                                                     0.0123358484);

final_score_45_c173 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 119.975 => final_score_45_c174,
    pf_product_dollars > 119.975                                => 0.0270182840,
                                                                   0.0001148087);

final_score_45 := map(
    (pf_ship_method in ['Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'YRC Freight'])                              => -0.0169696131,
    (pf_ship_method in ['AIT Logistics', 'Insured USPS Mail', 'Next Day Air Saver', 'Second Day', 'UPS Basic', 'UPS Saturday', 'UPS WrldWd Expd']) => final_score_45_c173,
                                                                                                                                                      -0.0085941900);

final_score_46_c177 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => 0.0585018276,
    (integer)avs_missing > 0.5                                  => -0.0270772641,
                                                                   0.0351594028);

final_score_46_c176 := map(
    NULL < s_p88_phn_dst_to_inp_add_i AND s_p88_phn_dst_to_inp_add_i <= 8.5 => -0.0126936918,
    s_p88_phn_dst_to_inp_add_i > 8.5                                        => 0.0510841455,
                                                                               final_score_46_c177);

final_score_46 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 1.5 => final_score_46_c176,
    b_c20_email_verification_d > 1.5                                        => -0.0239029879,
                                                                               0.0304678297);

final_score_47_c180 := map(
    NULL < btst_distphone2addr2_i AND btst_distphone2addr2_i <= 2.5 => -0.0262326539,
    btst_distphone2addr2_i > 2.5                                    => 0.0503045155,
                                                                       -0.0024808115);

final_score_47_c179 := map(
    (pf_ship_method in ['Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'UPS Basic', 'YRC Freight'])    => final_score_47_c180,
    (pf_ship_method in ['AIT Logistics', 'Insured USPS Mail', 'Next Day Air Saver', 'Second Day', 'UPS Saturday', 'UPS WrldWd Expd']) => 0.0360540881,
                                                                                                                                         0.0057666252);

final_score_47 := map(
    NULL < (integer)b_nae_email_verd_d AND (integer)b_nae_email_verd_d <= 0.5 => final_score_47_c179,
    (integer)b_nae_email_verd_d > 0.5                             				    => -0.0390779170,
                                                                                 -0.0103400080);

final_score_48_c183 := map(
    NULL < s_bus_phone_match_d AND s_bus_phone_match_d <= 0.5 => 0.0025833261,
    s_bus_phone_match_d > 0.5                                 => -0.0446521554,
                                                                 -0.0064921370);

final_score_48_c182 := map(
    NULL < (integer)avs_zip AND (integer)avs_zip <= 0.5 => 0.0463252126,
    (integer)avs_zip > 0.5                              => final_score_48_c183,
                                                           0.0034525713);
       
final_score_48 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => final_score_48_c182,
    (integer)avs_missing > 0.5                                  => -0.0241713915,
                                                                   -0.0048176377);

final_score_49_c185 := map(
    NULL < b_add_input_nhood_bus_pct_i AND b_add_input_nhood_bus_pct_i <= 0.5818370356 => -0.0190759819,
    b_add_input_nhood_bus_pct_i > 0.5818370356                                         => 0.0397995947,
                                                                                          -0.0113945361);

final_score_49_c186 := map(
    NULL < s_p88_phn_dst_to_inp_add_i AND s_p88_phn_dst_to_inp_add_i <= 3.5 => -0.0141160301,
    s_p88_phn_dst_to_inp_add_i > 3.5                                        => 0.0326202927,
                                                                               0.0236419082);

final_score_49 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 175.985 => final_score_49_c185,
    pf_product_dollars > 175.985                                => final_score_49_c186,
                                                                   -0.0059286861);

final_score_50_c189 := map(
    NULL < b_adl_per_email_i AND b_adl_per_email_i <= 0.5 => 0.0369335242,
    b_adl_per_email_i > 0.5                               => -0.0214258590,
                                                             0.0707390647);

final_score_50_c188 := map(
    (pf_ship_method in ['Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'UPS Basic', 'YRC Freight'])    => -0.0189143665,
    (pf_ship_method in ['AIT Logistics', 'Insured USPS Mail', 'Next Day Air Saver', 'Second Day', 'UPS Saturday', 'UPS WrldWd Expd']) => final_score_50_c189,
                                                                                                                                         -0.0120382414);

final_score_50 :=if (ST_cen_span_lang <> '', 
    map(
    NULL < (real)ST_cen_span_lang AND (real)ST_cen_span_lang <= 182.5 => final_score_50_c188,
    (real)ST_cen_span_lang > 182.5                                       => 0.0298005937,
                                                                               -0.0131933473),
																																							 -0.0131933473);

final_score_51_c192 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 174.97 => -0.0068022496,
    pf_product_dollars > 174.97                                => 0.0065591602,
                                                                  -0.0026344048);

final_score_51_c191 := map(
    NULL < b_bus_phone_match_d AND b_bus_phone_match_d <= 0.5 => final_score_51_c192,
    b_bus_phone_match_d > 0.5                                 => -0.0186882139,
                                                                 -0.0052933169);

final_score_51 := map(
    NULL < s_inq_lnames_per_addr_i AND s_inq_lnames_per_addr_i <= 1.5 => final_score_51_c191,
    s_inq_lnames_per_addr_i > 1.5                                     => 0.0124886615,
                                                                         -0.0064361184);

final_score_52_c195 := map(
    NULL < s_c12_source_profile_index_d AND s_c12_source_profile_index_d <= 0.5 => 0.0037208942,
    s_c12_source_profile_index_d > 0.5                                          => -0.0249588361,
                                                                                   0.0247047361);

final_score_52_c194 := map(
    NULL < btst_distaddraddr2_i AND btst_distaddraddr2_i <= 39.5 => final_score_52_c195,
    btst_distaddraddr2_i > 39.5                                  => 0.0690824696,
                                                                    -0.0096813191);

final_score_52 := map(
    NULL < s_add_input_nhood_bus_pct_i AND s_add_input_nhood_bus_pct_i <= 0.6195188066 => final_score_52_c194,
    s_add_input_nhood_bus_pct_i > 0.6195188066                                         => 0.1024958986,
                                                                                          -0.0181256813);

final_score_53_c198 := map(
    NULL < s_add_input_nhood_vac_pct_i AND s_add_input_nhood_vac_pct_i <= 0.69939135385 => 0.0134312944,
    s_add_input_nhood_vac_pct_i > 0.69939135385                                         => 0.0484101065,
                                                                                           -0.0142178016);

final_score_53_c197 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 1601.5 => -0.0157295553,
    btst_dist_inp_addr_to_ip_addr_i > 1601.5                                             => 0.0122478626,
                                                                                            final_score_53_c198);

final_score_53 := map(
    NULL < s_corrrisktype_i AND s_corrrisktype_i <= 8.5 => -0.0092463681,
    s_corrrisktype_i > 8.5                              => 0.0078991181,
                                                           final_score_53_c197);

final_score_54_c201 := map(
    NULL < (integer)b_nae_fname_verd_d AND (integer)b_nae_fname_verd_d <= 0.5 => 0.0103939934,
    (integer)b_nae_fname_verd_d > 0.5                                         => -0.0087940361,
                                                                                 0.0053185825);

final_score_54_c200 := map(
    NULL < s_phone_ver_experian_d AND s_phone_ver_experian_d <= 0.5 => final_score_54_c201,
    s_phone_ver_experian_d > 0.5                                    => -0.0063462716,
                                                                       0.0031983858);

final_score_54 := map(
    NULL < b_bus_phone_match_d AND b_bus_phone_match_d <= 0.5 => final_score_54_c200,
    b_bus_phone_match_d > 0.5                                 => -0.0098377741,
                                                                 -0.0017958471);

final_score_55_c204 := map(
    NULL < b_add_input_nhood_bus_pct_i AND b_add_input_nhood_bus_pct_i <= 0.57096204205 => -0.0025775167,
    b_add_input_nhood_bus_pct_i > 0.57096204205                                         => 0.0117968426,
                                                                                           -0.0062816478);

final_score_55_c203 := map(
    (pf_pmt_type in ['American Express', 'Bill Me Later', 'Bit Coin', 'MasterCard', 'Multiple Cards', 'PayPal Card', 'Visa']) => final_score_55_c204,
    (pf_pmt_type in ['Diners Club', 'Discover', 'Tiger Pay Card', 'V.me by Visa'])                                            => 0.0105225476,
                                                                                                                                 -0.0004936654);

final_score_55 := map(
    NULL < s_inq_per_addr_i AND s_inq_per_addr_i <= 24.5 => final_score_55_c203,
    s_inq_per_addr_i > 24.5                              => 0.0187807681,
                                                            -0.0012777548);

final_score_56_c207 := map(
    NULL < s_p88_phn_dst_to_inp_add_i AND s_p88_phn_dst_to_inp_add_i <= 7.5 => -0.0048754718,
    s_p88_phn_dst_to_inp_add_i > 7.5                                        => 0.0150123394,
                                                                               0.0157257459);

final_score_56_c206 := map(
    (pf_ship_method in ['Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville', 'UPS Basic', 'YRC Freight'])    => -0.0069616614,
    (pf_ship_method in ['AIT Logistics', 'Insured USPS Mail', 'Next Day Air Saver', 'Second Day', 'UPS Saturday', 'UPS WrldWd Expd']) => final_score_56_c207,
                                                                                                                                         -0.0046671269);

final_score_56 := if (ST_cen_span_lang <> '',
    map(
    NULL < (real)ST_cen_span_lang AND (real)ST_cen_span_lang <= 183.5 => final_score_56_c206,
    (real)ST_cen_span_lang > 183.5                                       => 0.0103599096,
                                                                               -0.0027031477),
																																							 -0.0027031477);

final_score_57_c210 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 1.5 => 0.0186146147,
    b_c20_email_verification_d > 1.5                                        => -0.0022830088,
                                                                               0.0047254965);

final_score_57_c209 := map(
    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'EDU', 'GOV', 'MIL', 'ORG', 'US']) => 0.0008544641,
    (btst_email_topleveldomain_n in ['NET', 'OTH'])                                   => final_score_57_c210,
                                                                                         0.0014651290);

final_score_57 := map(
    (pf_ship_method in ['AIT Logistics', 'Downloadable', 'Ground', 'Next Day Air Saver', 'Other', 'Retail Naperville', 'Second Day', 'UPS WrldWd Expd', 'YRC Freight']) => -0.0009127527,
    (pf_ship_method in ['Insured USPS Mail', 'Next Day/Overnight', 'UPS Basic', 'UPS Saturday'])                                                                        => final_score_57_c209,
                                                                                                                                                                           -0.0001690378);

final_score_58_c213 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 3.5 => 0.0065049435,
    b_c20_email_verification_d > 3.5                                        => -0.0040763907,
                                                                               0.0036367754);

final_score_58_c212 := map(
    NULL < b_phone_ver_experian_d AND b_phone_ver_experian_d <= 0.5 => final_score_58_c213,
    b_phone_ver_experian_d > 0.5                                    => -0.0018306503,
                                                                       0.0039434080);

final_score_58 := map(
    (pf_ship_method in ['Downloadable', 'Ground', 'Next Day/Overnight', 'Other', 'Retail Naperville'])                                                            => -0.0023922679,
    (pf_ship_method in ['AIT Logistics', 'Insured USPS Mail', 'Next Day Air Saver', 'Second Day', 'UPS Basic', 'UPS Saturday', 'UPS WrldWd Expd', 'YRC Freight']) => final_score_58_c212,
                                                                                                                                                                     -0.0007056674);

final_score_59_c216 := map(
    NULL < s_corrphonelastnamecount_d AND s_corrphonelastnamecount_d <= 0.5 => 0.0056085763,
    s_corrphonelastnamecount_d > 0.5                                        => -0.0029366475,
                                                                               0.0030155432);

final_score_59_c215 := map(
    NULL < b_bus_phone_match_d AND b_bus_phone_match_d <= 0.5 => final_score_59_c216,
    b_bus_phone_match_d > 0.5                                 => -0.0053372172,
                                                                 0.0012440228);

final_score_59 := map(
    NULL < b_phone_ver_experian_d AND b_phone_ver_experian_d <= 0.5 => final_score_59_c215,
    b_phone_ver_experian_d > 0.5                                    => -0.0031102888,
                                                                       0.0007167990);

final_score_60_c219 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 865.5 => -0.0005515605,
    btst_dist_inp_addr_to_ip_addr_i > 865.5                                             => 0.0033377267,
                                                                                           0.0037743635);

final_score_60_c218 := map(
    NULL < (integer)avs_missing AND (integer)avs_missing <= 0.5 => final_score_60_c219,
    (integer)avs_missing > 0.5                                  => -0.0013731539,
                                                                   0.0018229828);

final_score_60 := map(
    NULL < (integer)btst_relatives_in_common AND (integer)btst_relatives_in_common <= 0.5 => final_score_60_c218,
    (integer)btst_relatives_in_common > 0.5                                               => -0.0013176773,
                                                                                             -0.0003942543);

final_score_61_c222 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 0.5 => 0.0012291518,
    b_c20_email_verification_d > 0.5                                        => 0.0000364453,
                                                                               0.0013760115);

final_score_61_c221 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 249.925 => -0.0003017317,
    pf_product_dollars > 249.925                                => final_score_61_c222,
                                                                   -0.0000828012);

final_score_61 := map(
    NULL < btst_distphone2addr2_i AND btst_distphone2addr2_i <= 3.5 => -0.0006411443,
    btst_distphone2addr2_i > 3.5                                    => 0.0011128468,
                                                                       final_score_61_c221);

final_score_62_c225 := map(
    NULL < s_p88_phn_dst_to_inp_add_i AND s_p88_phn_dst_to_inp_add_i <= 14.5 => -0.0000724668,
    s_p88_phn_dst_to_inp_add_i > 14.5                                        => 0.0004944193,
                                                                                0.0005406007);

final_score_62_c224 := map(
    NULL < btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i <= 766 => -0.0003615528,
    btst_dist_inp_addr_to_ip_addr_i > 766                                             => final_score_62_c225,
                                                                                         0.0003166826);

final_score_62 := map(
    NULL < b_c20_email_verification_d AND b_c20_email_verification_d <= 1.5 => final_score_62_c224,
    b_c20_email_verification_d > 1.5                                        => -0.0002286229,
                                                                               0.0001813579);

final_score_63_c228 := map(
    NULL < pf_product_dollars AND pf_product_dollars <= 173.925 => -0.0000274012,
    pf_product_dollars > 173.925                                => 0.0000674110,
                                                                   0.0000029415);

final_score_63_c227 := map(
    NULL < b_bus_phone_match_d AND b_bus_phone_match_d <= 0.5 => final_score_63_c228,
    b_bus_phone_match_d > 0.5                                 => -0.0001007111,
                                                                 -0.0000146208);

final_score_63 := map(
    NULL < s_inq_per_addr_i AND s_inq_per_addr_i <= 28.5 => final_score_63_c227,
    s_inq_per_addr_i > 28.5                              => 0.0002086263,
                                                            -0.0000761792);

final_score := final_score_0 +
    final_score_1 +
    final_score_2 +
    final_score_3 +
    final_score_4 +
    final_score_5 +
    final_score_6 +
    final_score_7 +
    final_score_8 +
    final_score_9 +
    final_score_10 +
    final_score_11 +
    final_score_12 +
    final_score_13 +
    final_score_14 +
    final_score_15 +
    final_score_16 +
    final_score_17 +
    final_score_18 +
    final_score_19 +
    final_score_20 +
    final_score_21 +
    final_score_22 +
    final_score_23 +
    final_score_24 +
    final_score_25 +
    final_score_26 +
    final_score_27 +
    final_score_28 +
    final_score_29 +
    final_score_30 +
    final_score_31 +
    final_score_32 +
    final_score_33 +
    final_score_34 +
    final_score_35 +
    final_score_36 +
    final_score_37 +
    final_score_38 +
    final_score_39 +
    final_score_40 +
    final_score_41 +
    final_score_42 +
    final_score_43 +
    final_score_44 +
    final_score_45 +
    final_score_46 +
    final_score_47 +
    final_score_48 +
    final_score_49 +
    final_score_50 +
    final_score_51 +
    final_score_52 +
    final_score_53 +
    final_score_54 +
    final_score_55 +
    final_score_56 +
    final_score_57 +
    final_score_58 +
    final_score_59 +
    final_score_60 +
    final_score_61 +
    final_score_62 +
    final_score_63;

pbr := 0.018150413;

sbr := 0.198940073;

offset := ln(((1 - pbr) * sbr) /( pbr * (1 - sbr)));

base := 700;

pts := -40;

lgt := ln(0.0181 / 0.9819);

cdn1410_1_0_raw := round(max((real)310, min(999, if(base + pts * ((final_score - offset - lgt) / ln(2)) = NULL, -NULL, base + pts * ((final_score - offset - lgt) / ln(2))))));
// cdn1410_1_0_raw := round(max((real)310, min(999, base + pts * (final_score - offset - lgt) / ln(2))));

ip_routingmethod_n := map(
    ipaddr = ''            => '  ',
    iproutingmethod = ''   => '-1',
                              iproutingmethod);

ip_connection_n := map(
    ipaddr = ''       => ' ',
    ipconnection = '' => '-1',
                           StringLib.StringtoUppercase(ipconnection));

ip_dma_lvl_n := map(
    ipaddr = ''        => '               ',
    ipdma = ''         => '1. Missing DMA ',
    ipdma = '-1'       => '2. DMA: -1     ',
    ipdma = '0'        => '3. DMA: 0      ',
    length(ipdma) = 3  => '4. DMA: US Code',
    length(ipdma) != 3 => '5. DMA: Unkown ',
                          '6. Other');

ip_continent_n := map(
    (integer)continent = 1 => 'AFRICA   ',
    (integer)continent = 2 => 'ASIA     ',
    (integer)continent = 3 => 'AUSTRALIA',
    (integer)continent = 4 => 'EUROPE   ',
    (integer)continent = 7 => 'S AMERICA',
    (integer)continent = 5 => 'N AMERICA',
                     'Other');

ip_routingmethod_anonymous := ip_routingmethod_n = '02';

ip_connection_dialup := (Integer)(ip_connection_n = 'DIALUP');

ip_dma_lvl_0 := ip_dma_lvl_n = '3. DMA: 0';

ip_continent_not_n_america := (ip_continent_n in ['AFRICA', 'ASIA', 'AUSTRALIA', 'EUROPE', 'S AMERICA']);

cdn1410_1_0_adj := map(
    ip_routingmethod_anonymous => max(310, cdn1410_1_0_raw - 100),
    ip_dma_lvl_0               => max(310, cdn1410_1_0_raw - 60),
    (boolean)ip_connection_dialup       => max(310, cdn1410_1_0_raw - 60),
    ip_continent_not_n_america => min(if(max(310, cdn1410_1_0_raw - 80) = NULL, -NULL, max(310, cdn1410_1_0_raw - 80)), 699),
                                  cdn1410_1_0_raw);

b_inq_count_day_i := if(not(truedid), NULL, min(if(inq_count_day = NULL, -NULL, inq_count_day), 999));

b_inq_count_week_i := if(not(truedid), NULL, min(if(inq_count_week = NULL, -NULL, inq_count_week), 999));

s_inq_count_day_i := if(not(truedid_s), NULL, min(if(inq_count_day_s = NULL, -NULL, inq_count_day_s), 999));

s_inq_count_week_i := if(not(truedid_s), NULL, min(if(inq_count_week_s = NULL, -NULL, inq_count_week_s), 999));

foreign_order := not((in_state in ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY', 'AA', 'AE', 'AP', 'PR', 'VI', 'AS', 'GU', 'MP'])) or not((in_state_s in ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY', 'AA', 'AE', 'AP', 'PR', 'VI', 'AS', 'GU', 'MP', ' ']));

bt_min_pii := (integer)lnamepop = 1 and (integer)addrpop = 1;

cdn1410_1_0 := map(
     AVS in [ 'I8' , 'B8' , 'IG']                                                                          =>300,  
    (b_inq_count_day_i >= (integer) TD_DAY_VELOCITY_THRESHOLD) or (s_inq_count_day_i >= (integer)TD_DAY_VELOCITY_THRESHOLD)       => 301,
    (b_inq_count_week_i >= (integer)TD_WEEK_VELOCITY_THRESHOLD) or (s_inq_count_week_i >= (integer)TD_WEEK_VELOCITY_THRESHOLD)   => 301,
    (integer)bt_min_pii = 0                                                                                       => 302,
    (integer)foreign_order = 1                                                                                    => 302,
   
                                                                                                         cdn1410_1_0_adj);
#if(MODEL_DEBUG)
                    
                    self.avs_zip                          := avs_zip;
                    self.avs_missing                      := avs_missing;
                    self.pf_pmt_type                      := pf_pmt_type;
                    self.pf_product_dollars               := pf_product_dollars;
                    self.pf_ship_method                   := pf_ship_method;
                    self.btst_distaddraddr2_i             := btst_distaddraddr2_i;
                    self.s_add_input_nhood_bus_pct_i      := s_add_input_nhood_bus_pct_i;
                    self.num_inp_lat                      := num_inp_lat;
                    self.num_inp_long                     := num_inp_long;
                    self.num_ip_lat                       := num_ip_lat;
                    self.num_ip_long                      := num_ip_long;
                    self.d_lat                            := d_lat;
                    self.d_long                           := d_long;
                    self.a                                := a;
                    self.c                                := c;
                    self.dist                             := dist;
                    self.btst_dist_inp_addr_to_ip_addr_i  := btst_dist_inp_addr_to_ip_addr_i;
                    self.b_c20_email_verification_d       := b_c20_email_verification_d;
                    self.s_c12_source_profile_index_d     := s_c12_source_profile_index_d;
                    self.b_divaddrsuspidcountnew_i        := b_divaddrsuspidcountnew_i;
                    self.s_add_input_mobility_index_i     := s_add_input_mobility_index_i;
                    self.s_corrrisktype_i                 := s_corrrisktype_i;
                    self.b_nae_email_verd_d               := b_nae_email_verd_d;
                    self.s_p88_phn_dst_to_inp_add_i       := s_p88_phn_dst_to_inp_add_i;
                    self.s_nap_phn_verd_d                 := s_nap_phn_verd_d;
                    self.b_adl_per_email_i                := b_adl_per_email_i;
                    self.b_add_input_nhood_bus_pct_i      := b_add_input_nhood_bus_pct_i;
                    self.btst_lastscore_d                 := btst_lastscore_d;
                    self.s_corraddrphonecount_d           := s_corraddrphonecount_d;
                    self.btst_distphone2addr2_i           := btst_distphone2addr2_i;
                    self.s_bus_phone_match_d              := s_bus_phone_match_d;
                    self.s_l79_adls_per_addr_c6_i         := s_l79_adls_per_addr_c6_i;
                    self.s_idverrisktype_i                := s_idverrisktype_i;
                    self.b_bus_phone_match_d              := b_bus_phone_match_d;
                    self.s_inq_per_addr_i                 := s_inq_per_addr_i;
                    self.s_phone_ver_experian_d           := s_phone_ver_experian_d;
                    self.b_corraddrnamecount_d            := b_corraddrnamecount_d;
                    self.b_phone_ver_experian_d           := b_phone_ver_experian_d;
                    self.s_corraddrnamecount_d            := s_corraddrnamecount_d;
                    self.s_add_input_nhood_prop_sum       := s_add_input_nhood_prop_sum;
                    self.s_add_input_nhood_vac_pct_i      := s_add_input_nhood_vac_pct_i;
                    self.s_inq_per_phone_i                := s_inq_per_phone_i;
                    self.s_corrphonelastnamecount_d       := s_corrphonelastnamecount_d;
                    self.s_inq_retail_count_week_i        := s_inq_retail_count_week_i;
                    self.b_corrphonelastnamecount_d       := b_corrphonelastnamecount_d;
                    self.s_srchcountday_i                 := s_srchcountday_i;
                    self.s_inq_count_i                    := s_inq_count_i;
                    self.b_add_input_mobility_index_i     := b_add_input_mobility_index_i;
                    self.b_nae_fname_verd_d               := b_nae_fname_verd_d;
                    self.add_input_nhood_prop_sum         := add_input_nhood_prop_sum;
                    self.b_add_input_nhood_vac_pct_i      := b_add_input_nhood_vac_pct_i;
                    self.s_inq_lnames_per_addr_i          := s_inq_lnames_per_addr_i;
                    self.b_p85_phn_invalid_i              := b_p85_phn_invalid_i;
                    self.s_bus_name_nover_i               := s_bus_name_nover_i;
                    self.b_inq_per_phone_i                := b_inq_per_phone_i;
                    self.s_inq_retail_count_day_i         := s_inq_retail_count_day_i;
                    self.email_topleveldomain             := email_topleveldomain;
                    self.btst_email_topleveldomain_n      := btst_email_topleveldomain_n;
                    self.b_p86_phn_pager_i                := b_p86_phn_pager_i;
                    self.btst_email_last_score_d          := btst_email_last_score_d;
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
                    self.final_score                      := final_score;
                    self.pbr                              := pbr;
                    self.sbr                              := sbr;
                    self.offset                           := offset;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.cdn1410_1_0_raw                  := cdn1410_1_0_raw;
                    self.ip_routingmethod_n               := ip_routingmethod_n;
                    self.ip_connection_n                  := ip_connection_n;
                    self.ip_dma_lvl_n                     := ip_dma_lvl_n;
                    self.ip_continent_n                   := ip_continent_n;
                    self.ip_routingmethod_anonymous       := ip_routingmethod_anonymous;
                    self.ip_connection_dialup             := ip_connection_dialup;
                    self.ip_dma_lvl_0                     := ip_dma_lvl_0;
                    self.ip_continent_not_n_america       := ip_continent_not_n_america;
                    self.cdn1410_1_0_adj                  := cdn1410_1_0_adj;
                    self.b_inq_count_day_i                := b_inq_count_day_i;
                    self.b_inq_count_week_i               := b_inq_count_week_i;
                    self.s_inq_count_day_i                := s_inq_count_day_i;
                    self.s_inq_count_week_i               := s_inq_count_week_i;
                    self.foreign_order                    := foreign_order;
                    self.bt_min_pii                       := bt_min_pii;
	  self.cdn1410_1_0                      := cdn1410_1_0;
	  SELF.seq                              := ri.seq;
		SELF.score                            := (STRING3)cdn1410_1_0;
		SELF.clam                             := le.bs;
		self := [];
	#else
	
		SELF.ri := [];
		SELF.seq := le.bs.Bill_To_Out.seq;
		SELF.score := (STRING3)cdn1410_1_0;
	#end
	END;
	
	model := JOIN(clam_with_easi, customInputs, LEFT.bs.bill_to_out.seq = (RIGHT.seq * 2), doModel(LEFT, RIGHT), LEFT OUTER);

	
	// need to project billto boca shell results into layout.output
	Risk_Indicators.Layout_Output into_layout_output(clam_with_easi le) := TRANSFORM
		SELF.seq := le.bs.Bill_To_Out.seq;
		SELF.socllowissue := (STRING)le.bs.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
		SELF.soclhighissue := (STRING)le.bs.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
		SELF.socsverlevel := le.bs.Bill_To_Out.iid.NAS_summary;
		SELF.nxx_type := le.bs.Bill_To_Out.phone_verification.telcordia_type;
		SELF.isShipToBillToDifferent := le.bs.isShipToBillToDifferent;
		SELF.email_verification := (integer)le.bs.Bill_To_Out.email_summary.identity_email_verification_level;;
		SELF := le.bs.Bill_To_Out.iid;
		SELF := le.bs.Bill_To_Out.shell_input;
		SELF := le.bs.bill_to_out;

	END;
	iidBT := PROJECT(clam_with_easi, into_layout_output(LEFT));

	RiskWise.Layout_IP2O fill_ip(clam_with_easi le) := TRANSFORM
		SELF.seq := le.bs.Bill_To_Out.seq;
		SELF.countrycode := le.bs.ip2o.countrycode[1..2];
		SELF := le.bs.ip2o;
	END;
	ipInfo := PROJECT(clam_with_easi, fill_ip(LEFT));


	Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
		SELF.seq := le.seq;
		SELF.ri := RiskWise.cdReasonCodes(le, 6, rt, TRUE, IBICID, WantstoSeeBillToShipToDifferenceFlag, WantsToSeeEA);
		SELF := [];
	END;
	BTReasons := JOIN(iidBT, ipInfo, LEFT.seq = RIGHT.seq, addBTReasons(LEFT, RIGHT), LEFT OUTER);


	#if(MODEL_DEBUG)
	Layout_debug fillReasons(layout_debug le, BTreasons rt) := TRANSFORM
	SELF.ri := rt.ri;
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
		SELF.ri := RiskWise.cdReasonCodes(le, 6, rt, FALSE, IBICID, false, false);
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
	STRecord := JOIN(BTRecord, STReasons, (LEFT.clam.Bill_To_Out.seq+1) = RIGHT.seq, fillReasons2(LEFT, RIGHT), LEFT OUTER);
	#else
	STRecord := JOIN(BTRecord, STReasons, ((LEFT.seq*2)-1) = RIGHT.seq, fillReasons2(LEFT, RIGHT), LEFT OUTER);

	#end
	
	RETURN(STRecord);
END;
