//used by FCRA only
import risk_indicators, ut, easi, std, riskview;

export IED1002_0_6( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, unsigned1 BSversion=2) := FUNCTION
	IE_DEBUG := FALSE;

	#IF(IE_DEBUG)
		Layout_debug := record
			risk_indicators.Layout_Boca_Shell clam;
			integer pk_wealth_index;                                                      
			Real pk_wealth_index_m;                                                    
			integer wealth_index_cm;                                                      
			Boolean source_tot_da;                                                        
			Boolean source_tot_cg;                                                        
			Boolean source_tot_p;                                                         
			Boolean source_tot_ba;                                                        
			Boolean source_tot_am;                                                        
			Boolean source_tot_w;                                                         
			Boolean add_apt;                                                              
			Integer adl_category_ord;                                                     
			Boolean bk_flag;                                                              
			Integer pk_bk_level;                                                          
			Integer add1_avm_med;                                                         
			Integer rc_valid_bus_phone;                                                   
			Integer rc_valid_res_phone;                                                   
			Integer age_rcd;                                                              
			Integer add1_mortgage_type_ord;                                               
			Real prof_license_category_ord;                                            
			Integer pk_attr_total_number_derogs;                                          
			Integer pk_attr_num_nonderogs90;                                              
			Integer pk_derog_total;                                                       
			Integer pk_derog_total_m;                                                     
			Integer add1_avm_automated_valuation_rcd;                                     
			Integer add1_avm_automated_val_2_rcd;                                         
			Integer pk_liens_unrel_ot_total_amount;                                       
			Integer attr_num_watercraft60_cap;                                            
			Integer combo_addrcount_cap;                                                  
			Integer gong_did_phone_ct_cap;                                                
			Integer ams_college_code_mis;                                                 
			Integer ams_college_code_cm;                                                  
			Integer unit5;                                                                
			real pk_dist_a1toa2;                                                       
			real pk_dist_a1toa3;                                                       
			real pk_dist_a2toa3;                                                       
			real pk_rc_disthphoneaddr;                                                 
			Real Dist_mod;                                                             
			Integer sysdate;                                                              
			Integer date_last_seen2;                                                      
			Real years_date_last_seen;                                                 
			Integer liens_unrel_cj_last_seen2;                                            
			Real years_liens_unrel_cj_last_seen;                                       
			Integer pk_yr_date_last_seen;                                                 
			Integer pk_bk_yr_date_last_seen;                                              
			Real pk_bk_yr_date_last_seen_m1;                                           
			Integer pk_yr_liens_unrel_cj_last_seen;                                       
			Integer pk2_yr_liens_unrel_cj_last_seen;                                      
			Real predicted_inc_high;                                                   
			Real predicted_inc_low;                                                    
			Real pred_inc;                                                             
			Integer estimated_income;
			Integer estinc_bounded;
			Integer estimated_income_2;
	end;

	 Layout_debug doModel( clam le ) := TRANSFORM
	#ELSE
	 Risk_Indicators.Layout_Boca_Shell doModel( clam le ) := TRANSFORM
	#END
	adl_category                     := le.adlcategory;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_sources                       := if( BSversion > 3, le.header_summary.ver_sources, le.iid.sources ); //header_summary only on 40 and higher
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	rc_fnamessnmatch                 := le.iid.firstssnmatch;
	combo_addrcount                  := le.iid.combo_addrcount;
	lname_eda_sourced                := le.name_verification.lname_eda_sourced;
	age                              := le.name_verification.age;
	add1_unit_count                  := le.address_verification.input_address_information.unit_count;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
	add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	attr_num_watercraft60            := le.watercraft.watercraft_count60;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
	bankrupt                         := le.bjl.bankrupt;
	date_last_seen                   := le.bjl.date_last_seen;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	ams_college_code                 := le.student.college_code;
	prof_license_category            := le.professional_license.plcategory;
	wealth_index                     := le.wealth_indicator;
	archive_date                     := le.historydate;

	NULL := -999999999;

	pk_wealth_index := map(
			(integer)wealth_index <= 2 => 0,
			(integer)wealth_index <= 3 => 1,
			(integer)wealth_index <= 4 => 2,
			(integer)wealth_index <= 5 => 3,
																 4);

	pk_wealth_index_m := map(
			pk_wealth_index = 0 => 39116.676936,
			pk_wealth_index = 1 => 43449.700792,
			pk_wealth_index = 2 => 57061.910522,
			pk_wealth_index = 3 => 82122.972447,
														 134020.49977);

	wealth_index_cm := map(
			(integer)wealth_index = 0 => 35766,
			(integer)wealth_index = 1 => 32220,
			(integer)wealth_index = 2 => 35991,
			(integer)wealth_index = 3 => 39789,
			(integer)wealth_index = 4 => 46630,
			(integer)wealth_index = 5 => 52993,
			(integer)wealth_index = 6 => 55911,
																43256);

	source_tot_da := Models.Common.findw_cpp(rc_sources, 'DA' , ' ,', 'I') > 0;

	source_tot_cg := Models.Common.findw_cpp(rc_sources, 'CG' , ' ,', 'I') > 0;

	source_tot_p := Models.Common.findw_cpp(rc_sources, 'P' , ' ,', 'I') > 0;

	source_tot_ba := Models.Common.findw_cpp(rc_sources, 'BA' , ' ,', 'I') > 0;

	source_tot_am := Models.Common.findw_cpp(rc_sources, 'AM' , ' ,', 'I') > 0;

	source_tot_w := Models.Common.findw_cpp(rc_sources, 'W' , ' ,', 'I') > 0;

	add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

	adl_category_ord := (integer)((string) adl_category = '1 DEAD');

	bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

	pk_bk_level := map(
			bankrupt             => 2,
			(integer)bk_flag = 1 => 1,
															0);

	add1_avm_med := map(
			ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
			ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
																ADD1_AVM_MED_FIPS);

	rc_valid_bus_phone := if((integer)rc_phonevalflag = 1, 1, 0);

	rc_valid_res_phone := if((integer)rc_phonevalflag = 2, 1, 0);

	age_rcd := map(
			age < 18 => 35,
			age > 60 => 35,
									age);

	add1_mortgage_type_ord := map(
			(add1_mortgage_type in ['FHA'])              => 1,
			(add1_mortgage_type in ['', ' '])            => 2,
			(add1_mortgage_type in ['2', 'E', 'N', 'U']) => 4,
																											3);

	prof_license_category_ord := map(
			prof_license_category = '0'          => 1,
			(prof_license_category in ['', ' ']) => 1.5,
			(integer1)prof_license_category);

	pk_attr_total_number_derogs_1 := attr_total_number_derogs;

	pk_attr_total_number_derogs := if((integer) pk_attr_total_number_derogs_1 > 3, 3, pk_attr_total_number_derogs_1);

	pk_attr_num_nonderogs90_1 := attr_num_nonderogs90;

	pk_attr_num_nonderogs90 := if((integer)pk_attr_num_nonderogs90_1 > 4, 4, pk_attr_num_nonderogs90_1);

	pk_derog_total := if(pk_attr_total_number_derogs > 0, pk_attr_total_number_derogs, (-1 * pk_attr_num_nonderogs90));

	pk_derog_total_m := map(
			pk_derog_total <= -4 => 51961,
			pk_derog_total <= -3 => 49033,
			pk_derog_total <= -2 => 45551,
			pk_derog_total <= -1 => 40287,
			pk_derog_total <= 0  => 42406,
			pk_derog_total <= 1  => 40550,
			pk_derog_total <= 2  => 38539,
			pk_derog_total <= 3  => 37345,
															43256);

	add1_avm_automated_valuation_rcd := if(add1_avm_automated_valuation = 0, 150000, add1_avm_automated_valuation);

	add1_avm_automated_val_2_rcd := if((integer)add1_avm_automated_valuation_2 = 0, 150000, add1_avm_automated_valuation_2);

	pk_liens_unrel_ot_total_amount := map(
			(integer) liens_unrel_ot_total_amount <= 0     => -1,
			(integer) liens_unrel_ot_total_amount <= 10000 => 0,
																							1);

	attr_num_watercraft60_cap := if((integer)attr_num_watercraft60 > 2, 2, attr_num_watercraft60);

	combo_addrcount_cap := if(combo_addrcount > 6, 6, combo_addrcount);

	gong_did_phone_ct_cap := if((integer)gong_did_phone_ct > 5, 5, gong_did_phone_ct);

	//# warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
	ams_college_code_mis := if(trim(ams_college_code)='',1,0);

	ams_college_code_cm := map(
			(integer)ams_college_code = 2 => 38463,
			(integer)ams_college_code = 4 => 49756,
																		43256);

	unit5 := if((integer) add1_unit_count = 0, 4, min(if(add1_unit_count = NULL, -NULL, add1_unit_count), 5));

	pk_dist_a1toa2 := map(
			dist_a1toa2 = 9999 => -1,
			dist_a1toa2 <= 0   => 0,
			dist_a1toa2 <= 9   => 1,
														2);

	pk_dist_a1toa3 := map(
			dist_a1toa3 = 9999 => -1,
			dist_a1toa3 <= 0   => 0,
			dist_a1toa3 <= 30  => 1,
														2);

	pk_dist_a2toa3 := map(
			dist_a2toa3 = 9999 => -1,
			dist_a2toa3 <= 0   => 0,
			dist_a2toa3 <= 9   => 1,
			dist_a2toa3 <= 35  => 2,
														3);

	pk_rc_disthphoneaddr := map(
			rc_disthphoneaddr = 9999 => 0,
			rc_disthphoneaddr <= 3   => 0,
			rc_disthphoneaddr <= 6   => 1,
			rc_disthphoneaddr <= 12  => 2,
																	3);

	dist_mod := 53000 +
			(pk_dist_a1toa2 * 2742.75338) +
			(pk_dist_a1toa3 * 2773.73056) +
			(pk_dist_a2toa3 * 2915.40756) +
			(pk_rc_disthphoneaddr * 4620.15356);

	sysdate := map(
			trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (string)Std.Date.Today(), (string6)le.historydate+'01')),
			length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																														 NULL);

	_y_c33_b1 := (real)(trim((string)date_last_seen, LEFT))[1..4];

	_m_c33_b1 := min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6])));

	_daycap_c34 := map(
			(_m_c33_b1 in [1, 3, 5, 7, 8, 10, 12]) => 31,
			(_m_c33_b1 in [4, 6, 9, 11])           => 30,
																								28 + (integer)((_y_c33_b1 % 4) = 0 and (_y_c33_b1 % 100) > 0 or (_y_c33_b1 % 400) = 0));

	_d_c33_b1 := if(max(_daycap_c34, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_c34 = NULL, -NULL, _daycap_c34), if(max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]))));

	_y_1 := map(
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 8 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (real)(trim((string)date_last_seen, LEFT))[1..4],
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 6 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => NULL,
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 4 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => NULL,
																																																																NULL);

	_m_1 := map(
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 8 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))),
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 6 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => NULL,
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 4 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => NULL,
																																																																NULL);

	_d_1 := map(
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 8 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_c34, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_c34 = NULL, -NULL, _daycap_c34), if(max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8])))),
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 6 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => NULL,
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 4 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => NULL,
																																																																NULL);

	date_last_seen2 := map(
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 8 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)_y_c33_b1, (string)_m_c33_b1, (string)_d_c33_b1) - ut.DaysSince1900('1960', '1', '1')),
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 6 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 4 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																																																NULL);

	_daycap_1 := map(
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 8 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _daycap_c34,
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 6 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => NULL,
			length(trim((string)date_last_seen, LEFT, RIGHT)) = 4 and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => NULL,
																																																																NULL);

	years_date_last_seen := if(sysdate != NULL and date_last_seen2 != NULL, (sysdate - date_last_seen2) / 365.25, NULL);

	_y_c36_b1 := (real)(trim((string)liens_unrel_cj_last_seen, LEFT))[1..4];

	_m_c36_b1 := min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6])));

	_daycap_c37 := map(
			(_m_c36_b1 in [1, 3, 5, 7, 8, 10, 12]) => 31,
			(_m_c36_b1 in [4, 6, 9, 11])           => 30,
																								28 + (integer)((_y_c36_b1 % 4) = 0 and (_y_c36_b1 % 100) > 0 or (_y_c36_b1 % 400) = 0));

	_d_c36_b1 := if(max(_daycap_c37, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_c37 = NULL, -NULL, _daycap_c37), if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]))));

	liens_unrel_cj_last_seen2 := map(
			length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8 and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)_y_c36_b1, (string)_m_c36_b1, (string)_d_c36_b1) - ut.DaysSince1900('1960', '1', '1')),
			length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6 and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
			length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4 and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																																																										NULL);

	years_liens_unrel_cj_last_seen := if(sysdate != NULL and liens_unrel_cj_last_seen2 != NULL, ((sysdate - liens_unrel_cj_last_seen2) / 365.25), NULL);

	pk_yr_date_last_seen := if (years_date_last_seen >= 0, roundup(years_date_last_seen), truncate(years_date_last_seen));

	pk_bk_yr_date_last_seen := map(
			(real)pk_yr_date_last_seen = NULL => -1,
			(real)pk_yr_date_last_seen >= 9   => 9,
																		 pk_yr_date_last_seen);

	pk_bk_yr_date_last_seen_m1 := map(
			pk_bk_yr_date_last_seen = -1 => 65447.971203,
			pk_bk_yr_date_last_seen = 1  => 37195.924959,
			pk_bk_yr_date_last_seen = 2  => 40666.992447,
			pk_bk_yr_date_last_seen = 3  => 42965.336207,
			pk_bk_yr_date_last_seen = 4  => 44669.167255,
			pk_bk_yr_date_last_seen = 5  => 47563.390744,
			pk_bk_yr_date_last_seen = 6  => 47917.954038,
			pk_bk_yr_date_last_seen = 7  => 49396.154083,
			pk_bk_yr_date_last_seen = 8  => 50099.973169,
			pk_bk_yr_date_last_seen = 9  => 52557.404007,
																			65447.971203);

	pk_yr_liens_unrel_cj_last_seen := if (years_liens_unrel_cj_last_seen >= 0, roundup(years_liens_unrel_cj_last_seen), truncate(years_liens_unrel_cj_last_seen));

	pk2_yr_liens_unrel_cj_last_seen := map(
			pk_yr_liens_unrel_cj_last_seen <= NULL => -1,
			pk_yr_liens_unrel_cj_last_seen <= 3    => 2,
			pk_yr_liens_unrel_cj_last_seen <= 5    => 1,
																								0);

	predicted_inc_high := -28552 +
			(pk_wealth_index_m * 0.51667) +
			((integer)source_tot_da * 88499) +
			(add1_avm_med * 0.05448) +
			(prof_license_category_ord * 8167.93208) +
			(addrs_per_adl * 855.48025) +
			(pk_derog_total_m * 0.27963) +
			(add1_avm_automated_valuation_rcd * 0.01557) +
			(property_sold_assessed_total * 0.02413) +
			(attr_num_watercraft60_cap * 10490) +
			(age_rcd * 324.98302) +
			(combo_addrcount_cap * -2218.70449) +
			((integer)add_apt * -6810.8463) +
			((integer)source_tot_cg * 28047) +
			((integer)source_tot_w * 6718.13655) +
			(gong_did_phone_ct * 1414.7842) +
			(add1_mortgage_type_ord * 1825.91813) +
			((integer)source_tot_am * 17169) +
			(rc_valid_bus_phone * 11042) +
			(pk_liens_unrel_ot_total_amount * 7931.02954) +
			(add1_avm_automated_val_2_rcd * 0.00826) +
			(ams_college_code_mis * -5323.07783) +
			(pk_bk_level * -1970.64639);

	predicted_inc_low := -41102 +
			(unit5 * -831.61455) +
			(wealth_index_cm * 0.58647) +
			(pk_derog_total_m * 0.10024) +
			(add1_avm_automated_valuation_rcd * 0.04533) +
			(addrs_per_adl * 550.25883) +
			((integer)source_tot_w * 5344.21522) +
			(prof_license_category_ord * 5945.60684) +
			((integer)source_tot_p * 2458.14454) +
			(dist_mod * 0.14406) +
			(pk_bk_yr_date_last_seen_m1 * 0.09737) +
			(adl_category_ord * -6248.93016) +
			((integer)rc_fnamessnmatch * 1791.67303) +
			(add1_mortgage_type_ord * 866.89420) +
			(pk2_yr_liens_unrel_cj_last_seen * -802.79314) +
			(ams_college_code_cm * 0.23991) +
			(attr_num_watercraft60_cap * 6305.45509) +
			(rc_valid_res_phone * -2003.57100) +
			(addrs_10yr * -380.27808) +
			(gong_did_phone_ct_cap * 622.39725) +
			((integer)source_tot_am * 12813) +
			((integer)lname_eda_sourced * 1471.54247);

	pred_inc := if(predicted_inc_high < 60000, predicted_inc_low - 3560, predicted_inc_high - 2000);
//since we have pred_inc, can't use the rounded estimated income, we determine the income level code here
	newIncomeLevelCode := MAP(
          pred_inc <= 13000 => 'A',
          pred_inc <= 19900 => 'B',
          pred_inc <= 23700 => 'C',
          pred_inc <= 26600 => 'D',
          pred_inc <= 29300 => 'E',
          pred_inc <= 31900 => 'F',
          pred_inc <= 35900 => 'G',
          pred_inc <= 39000 => 'H',
          pred_inc <= 43800 => 'I',
          pred_inc <= 60000 => 'J',
				  'K');

	estimated_income := pred_inc;

	estinc_bounded := map(
			estimated_income < 20000  => 19999,
			estimated_income > 250000 => 250999,
													 round(estimated_income/1000)*1000);

	estimated_income_2 := if(riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 0, estinc_bounded);

		#if(IE_DEBUG)
			self.pk_wealth_index                  := pk_wealth_index;                                   
			self.pk_wealth_index_m                := pk_wealth_index_m;                                 
			self.wealth_index_cm                  := wealth_index_cm;                                   
			self.source_tot_da                    := source_tot_da;                                     
			self.source_tot_cg                    := source_tot_cg;                                     
			self.source_tot_p                     := source_tot_p;                                      
			self.source_tot_ba                    := source_tot_ba;                                     
			self.source_tot_am                    := source_tot_am;                                     
			self.source_tot_w                     := source_tot_w;                                      
			self.add_apt                          := add_apt;                                           
			self.adl_category_ord                 := adl_category_ord;                                  
			self.bk_flag                          := bk_flag;                                           
			self.pk_bk_level                      := pk_bk_level;                                       
			self.add1_avm_med                     := add1_avm_med;                                      
			self.rc_valid_bus_phone               := rc_valid_bus_phone;                                
			self.rc_valid_res_phone               := rc_valid_res_phone;                                
			self.age_rcd                          := age_rcd;                                           
			self.add1_mortgage_type_ord           := add1_mortgage_type_ord;                            
			self.prof_license_category_ord        := prof_license_category_ord;                         
			self.pk_attr_total_number_derogs      := pk_attr_total_number_derogs;                       
			self.pk_attr_num_nonderogs90          := pk_attr_num_nonderogs90;                           
			self.pk_derog_total                   := pk_derog_total;                                    
			self.pk_derog_total_m                 := pk_derog_total_m;                                  
			self.add1_avm_automated_valuation_rcd := add1_avm_automated_valuation_rcd;                  
			self.add1_avm_automated_val_2_rcd     := add1_avm_automated_val_2_rcd;                      
			self.pk_liens_unrel_ot_total_amount   := pk_liens_unrel_ot_total_amount;                    
			self.attr_num_watercraft60_cap        := attr_num_watercraft60_cap;                         
			self.combo_addrcount_cap              := combo_addrcount_cap;                               
			self.gong_did_phone_ct_cap            := gong_did_phone_ct_cap;                             
			self.ams_college_code_mis             := ams_college_code_mis;                              
			self.ams_college_code_cm              := ams_college_code_cm;                               
			self.unit5                            := unit5;                                             
			self.pk_dist_a1toa2                   := pk_dist_a1toa2;                                    
			self.pk_dist_a1toa3                   := pk_dist_a1toa3;                                    
			self.pk_dist_a2toa3                   := pk_dist_a2toa3;                                    
			self.pk_rc_disthphoneaddr             := pk_rc_disthphoneaddr;                              
			self.dist_mod                         := dist_mod;                                          
			self.sysdate                          := sysdate;                                           
			self.date_last_seen2                  := date_last_seen2;                                   
			self.years_date_last_seen             := years_date_last_seen;                              
			self.liens_unrel_cj_last_seen2        := liens_unrel_cj_last_seen2;                         
			self.years_liens_unrel_cj_last_seen   := years_liens_unrel_cj_last_seen;                    
			self.pk_yr_date_last_seen             := pk_yr_date_last_seen;                              
			self.pk_bk_yr_date_last_seen          := pk_bk_yr_date_last_seen;                           
			self.pk_bk_yr_date_last_seen_m1       := pk_bk_yr_date_last_seen_m1;                        
			self.pk_yr_liens_unrel_cj_last_seen   := pk_yr_liens_unrel_cj_last_seen;                    
			self.pk2_yr_liens_unrel_cj_last_seen  := pk2_yr_liens_unrel_cj_last_seen;                   
			self.predicted_inc_high               := predicted_inc_high;                                
			self.predicted_inc_low                := predicted_inc_low;                                 
			self.pred_inc                         := pred_inc;                                          
			self.estimated_income := estimated_income;
			self.estinc_bounded := estinc_bounded;
			self.estimated_income_2 := estimated_income_2;
			self.clam.student.income_level_code := newIncomeLevelCode;
			self.clam := le;
		#else
			self.estimated_income := estimated_income_2;
			self.student.income_level_code := newIncomeLevelCode;
			self := le;
		#end

	END;
	
	results := project(clam, doModel(left));

	return results;
END;