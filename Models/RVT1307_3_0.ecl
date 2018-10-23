// RVT1307_3_0: AT & T - //FCRA 4.1 Modeling Shell ****************************************************************

import risk_indicators, riskwise, riskwisefcra, ut, models, std, riskview; 

export RVT1307_3_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clamPre, BOOLEAN isCalifornia = FALSE, BOOLEAN isFCRA = TRUE) := FUNCTION

	msa_bocashell := RECORD
		risk_indicators.Layout_Boca_Shell;
		string50 msa;
	end;

	clam := join(clamPre, Models.Key_MSA_Zip_Lookup(isFCRA), KEYED(left.shell_input.z5 = right.zip), 
							  TRANSFORM(msa_bocashell, self.msa:= right.msa, self:=left),
								left outer, keep(1));

  RVT_DEBUG := FALSE;

  #if(RVT_DEBUG)
    layout_debug := record				
			string _msa;                                             
			integer sysdate;                                         
			boolean iv_pots_phone;                                           
			boolean iv_add_apt;                                              
			boolean iv_riskview_222s;                                        
			string iv_va002_add_invalid;                                    
			boolean email_src_im;                                            
			integer iv_ds001_impulse_count;                                  
			integer bureau_adl_vo_fseen_pos;                                 
			string bureau_adl_fseen_vo;                                     
			integer _bureau_adl_fseen_vo;                                    
			integer _src_bureau_adl_fseen;                                   
			integer mth_ver_src_fdate_vo;                                    
			integer bureau_adl_vo_lseen_pos;                                 
			string bureau_adl_lseen_vo;                                     
			integer _bureau_adl_lseen_vo;                                    
			integer mth_ver_src_ldate_vo;                                    
			boolean mth_ver_src_fdate_vo60;                                  
			boolean mth_ver_src_ldate_vo0;                                   
			integer bureau_adl_w_lseen_pos;                                  
			string bureau_adl_lseen_w;                                      
			integer _bureau_adl_lseen_w;                                     
			integer mth_ver_src_ldate_w;                                     
			boolean mth_ver_src_ldate_w0;                                    
			integer bureau_adl_wp_lseen_pos;                                 
			string bureau_adl_lseen_wp;                                     
			integer _bureau_adl_lseen_wp;                                    
			integer _src_bureau_adl_lseen;                                   
			integer mth_ver_src_ldate_wp;                                    
			boolean mth_ver_src_ldate_wp0;                                   
			integer _paw_first_seen;                                         
			integer mth_paw_first_seen;                                      
			integer mth_paw_first_seen2;                                     
			boolean ver_src_am;                                              
			boolean ver_src_e1;                                              
			boolean ver_src_e2;                                              
			boolean ver_src_e3;                                              
			boolean ver_src_pl;                                              
			boolean ver_src_w;                                               
			boolean paw_dead_business_count_gt3;                             
			boolean paw_active_phone_count_0;                                
			integer _infutor_first_seen;                                     
			integer mth_infutor_first_seen;                                  
			integer _infutor_last_seen;                                      
			integer mth_infutor_last_seen;                                   
			integer infutor_i;                                               
			real infutor_im;                                              
			integer white_pages_adl_wp_fseen_pos;                            
			string white_pages_adl_fseen_wp;                                
			integer _white_pages_adl_fseen_wp;                               
			integer _src_white_pages_adl_fseen;                              
			integer iv_sr001_m_wp_adl_fs;                                    
			integer src_m_wp_adl_fs;                                         
			integer _header_first_seen;                                      
			integer iv_sr001_m_hdr_fs;                                       
			integer src_m_hdr_fs;                                            
			real source_mod6;                                             
			real iv_sr001_source_profile;  //use to be int                               
			integer iv_sr001_source_profile_index;                           
			integer iv_pv001_bst_avm_autoval;                                
			integer iv_pl002_addrs_per_ssn_c6;                               
			string iv_po001_inp_addr_naprop;                                
			integer iv_in001_estimated_income;                               
			integer _reported_dob;                                           
			real reported_age;                                            
			integer iv_combined_age;                                         
			integer iv_ssn_miskey;                                           
			integer iv_inp_addr_assessed_total_val;                          
			integer iv_prv_addr_avm_auto_val;                                
			integer iv_addrs_5yr;                                            
			integer iv_hist_addr_match;                                      
			integer iv_avg_num_sources_per_addr;                             
			integer iv_max_ids_per_sfd_addr;                                 
			integer iv_phones_per_adl_c6;                                    
			integer iv_ssns_per_addr_c6;                                     
			integer iv_phones_per_sfd_addr_c6;                               
			integer iv_paw_source_count;                                     
			string iv_rec_vehx_level;                                       
			integer iv_eviction_count;                                       
			string iv_liens_unrel_x_rel;                                    
			string iv_criminal_x_felony;                                    
			string iv_ams_college_tier;                                     
			integer iv_pb_average_dollars;                                   
			real _msa_subscore0;                                          
			real _msa_subscore1;                                          
			real _msa_subscore2;                                          
			real _msa_subscore3;                                          
			real _msa_subscore4;                                          
			real _msa_subscore5;                                          
			real _msa_subscore6;                                          
			real _msa_subscore7;                                          
			real _msa_subscore8;                                          
			real _msa_subscore9;                                          
			real _msa_subscore10;                                         
			real _msa_subscore11;                                         
			real _msa_subscore12;                                         
			real _msa_subscore13;                                         
			real _msa_subscore14;                                         
			real _msa_subscore15;                                         
			real _msa_subscore16;                                         
			real _msa_subscore17;                                         
			real _msa_subscore18;                                         
			real _msa_subscore19;                                         
			real _msa_subscore20;                                         
			real _msa_subscore21;                                         
			real _msa_subscore22;                                         
			real _msa_subscore23;                                         
			real _msa_subscore24;                                         
			real _msa_subscore25;                                         
			real _msa_rawscore;                                           
			real _msa_lnoddsscore;                                        
			real _msa_probscore;                                          
			real base;                                                    
			real pts;                                                     
			real logit;                                                   
			integer _msa_model;                                              
			boolean ov_rc19;                                                 
			boolean _200;                                                    
			boolean _201;                                                    
			boolean _203;                                                    
			boolean _210;                                                    
			boolean _222;                                                    
			boolean _650;                                                    
			boolean _670;                                                    
			boolean _700;                                                    
			integer rvt1307_3_0;                                             
			boolean glrc11;                                                  
			boolean glrc9h;                                                  
			boolean glrc9r;                                                  
			boolean glrcpv;                                                  
			boolean glrc9d;                                                  
			boolean glrc9a;                                                  
			boolean glrc9j;                                                  
			boolean glrc29;                                                  
			boolean glrc25;                                                  
			boolean glrc9e;                                                  
			boolean glrc9m;                                                  
			boolean glrcev;                                                  
			boolean glrc98;                                                  
			boolean glrc97;                                                  
			boolean glrc9i;                                                  
			// boolean glrc9y;                                                  
			boolean glrcbl;                                                  
			real rcvalue11_1;                                             
			real rcvalue11;                                               
			real rcvalue9h_1;                                             
			real rcvalue9h;                                               
			real rcvalue9r_1;                                             
			real rcvalue9r;                                               
			real rcvaluepv_1;                                             
			real rcvaluepv_2;                                             
			real rcvaluepv;                                               
			real rcvalue9d_1;                                             
			real rcvalue9d_2;                                             
			real rcvalue9d;                                               
			real rcvalue9a_1;                                             
			real rcvalue9a;                                               
			real rcvalue9j_1;                                             
			real rcvalue9j;                                               
			real rcvalue29_1;                                             
			real rcvalue29;                                               
			real rcvalue25_1;                                             
			real rcvalue25;                                               
			real rcvalue9e_1;                                             
			real rcvalue9e;                                               
			real rcvalue9m_1;                                             
			real rcvalue9m;                                               
			real rcvalueev_1;                                             
			real rcvalueev;                                               
			real rcvalue98_1;                                             
			real rcvalue98;                                               
			real rcvalue97_1;                                             
			real rcvalue97;                                               
			real rcvalue9i_1;                                             
			real rcvalue9i;                                               
			// real rcvalue9y_1;                                             
			// real rcvalue9y;                                               
			real rcvaluebl_1;                                             
			real rcvaluebl_2;                                             
			real rcvaluebl_3;                                             
			real rcvaluebl_4;                                             
			real rcvaluebl_5;                                             
			real rcvaluebl_6;                                             
			real rcvaluebl_7;                                             
			real rcvaluebl_8;                                             
			real rcvaluebl;                                               
			string rc1;                                                     
			string rc4;                                                     
			string rc2;                                                     
			string rc3;                                                     
			string rc5;                                                     
			
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	msa_name                         := le.msa;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_st                           := le.shell_input.st;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_hrisksic                      := le.iid.hrisksic;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_lnamecount                 := le.iid.combo_lastcount;
	combo_addrcount                  := le.iid.combo_addrcount;
	combo_hphonecount                := le.iid.combo_hphonecount;
	combo_ssncount                   := le.iid.combo_ssncount;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	addr_count2                      := le.address_history_summary.addr_count2;
	addr_count_ge3                   := le.address_history_summary.addr_count3;
	addr_count_ge6                   := le.address_history_summary.addr_count6;
	addr_count_ge10                  := le.address_history_summary.addr_count10;
	hist_addr_match                  := le.address_history_summary.hist_addr_match;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen                := le.ssn_verification.header_first_seen;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
	addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	paw_source_count                 := le.employment.source_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_age                          := le.student.age;
	ams_college_code                 := le.student.college_code;
	ams_college_tier                 := le.student.college_tier;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := le.shell_input.age;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	estimated_income                 := le.estimated_income;
	archive_date                     := le.historydate;

NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

_msa := map(
    MSA_NAME = 'LOS ANGELES-LONG BEACH-SANTAANA, CA'          => MSA_NAME,
    MSA_NAME = 'HOUSTON-SUGAR LAND-BAYTOWN,TX'                => MSA_NAME,
    MSA_NAME = 'CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI'          => MSA_NAME,
    MSA_NAME = 'DALLAS-FORT WORTH-ARLINGTON,TX'               => MSA_NAME,
    MSA_NAME = 'MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL'      => MSA_NAME,
    MSA_NAME = 'SAN FRANCISCO-OAKLAND-FREMONT, CA'            => MSA_NAME,
    MSA_NAME = 'NEW YORK-NORTHERN NEW JERSEY'                 => MSA_NAME,
    MSA_NAME = 'ATLANTA-SANDY SPRINGS-MARIETTA, GA'           => MSA_NAME,
    MSA_NAME = 'DETROIT-WARREN-LIVONIA, MI'                   => MSA_NAME,
    MSA_NAME = 'SAN DIEGO-CARLSBAD-SAN MARCOS, CA'            => MSA_NAME,
    MSA_NAME = 'INDIANAPOLIS-CARMEL, IN'                      => MSA_NAME,
    MSA_NAME = 'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA'        => MSA_NAME,
    MSA_NAME = 'ST. LOUIS, MO-IL'                             => MSA_NAME,
    MSA_NAME = 'SD NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'SAN JOSE-SUNNYVALE-SANTACLARA, CA'            => MSA_NAME,
    MSA_NAME = 'TX NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'MILWAUKEE-WAUKESHA-WEST ALLIS, WI'            => MSA_NAME,
    MSA_NAME = 'SAN ANTONIO, TX'                              => MSA_NAME,
    MSA_NAME = 'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA'         => MSA_NAME,
    MSA_NAME = 'CLEVELAND-ELYRIA-MENTOR,OH'                   => MSA_NAME,
    MSA_NAME = 'AUSTIN-ROUND ROCK, TX'                        => MSA_NAME,
    MSA_NAME = 'COLUMBUS, OH'                                 => MSA_NAME,
    MSA_NAME = 'KANSAS CITY, MO-KS'                           => MSA_NAME,
    MSA_NAME = 'FRESNO, CA'                                   => MSA_NAME,
    MSA_NAME = 'BAKERSFIELD, CA'                              => MSA_NAME,
    MSA_NAME = 'MS NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'MEMPHIS, TN-AR-MS'                            => MSA_NAME,
    MSA_NAME = 'BOSTON-CAMBRIDGE-QUINCY,MA-NH'                => MSA_NAME,
    MSA_NAME = 'HARTFORD-WEST HARTFORD-EASTHARTFORD, CT'      => MSA_NAME,
    MSA_NAME = 'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV' => MSA_NAME,
    MSA_NAME = 'ORLANDO-KISSIMMEE, FL'                        => MSA_NAME,
    MSA_NAME = 'NEW HAVEN-MILFORD, CT'                        => MSA_NAME,
    MSA_NAME = 'OK NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'JACKSONVILLE, FL'                             => MSA_NAME,
    MSA_NAME = 'BIRMINGHAM-HOOVER, AL'                        => MSA_NAME,
    MSA_NAME = 'OKLAHOMA CITY, OK'                            => MSA_NAME,
    MSA_NAME = 'NEW ORLEANS-METAIRIE-KENNER,LA'               => MSA_NAME,
    MSA_NAME = 'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD'  => MSA_NAME,
    MSA_NAME = 'LA NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'CHARLOTTE-GASTONIA-CONCORD,NC-SC'             => MSA_NAME,
    MSA_NAME = 'EL PASO, TX'                                  => MSA_NAME,
    MSA_NAME = 'CA NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'AR NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'STOCKTON, CA'                                 => MSA_NAME,
    MSA_NAME = 'MCALLEN-EDINBURG-MISSION,TX'                  => MSA_NAME,
    MSA_NAME = 'SAN JUAN-CAGUAS-GUAYNABO,PR'                  => MSA_NAME,
    MSA_NAME = 'NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN' => MSA_NAME,
    MSA_NAME = 'VISALIA-PORTERVILLE, CA'                      => MSA_NAME,
    MSA_NAME = 'MO NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'LOUISVILLE/JEFFERSON COUNTY,KY-IN'            => MSA_NAME,
    MSA_NAME = 'MT NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR'      => MSA_NAME,
    MSA_NAME = 'BATON ROUGE, LA'                              => MSA_NAME,
    MSA_NAME = 'BRIDGEPORT-STAMFORD-NORWALK,CT'               => MSA_NAME,
    MSA_NAME = 'KY NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'SEATTLE-TACOMA-BELLEVUE,WA'                   => MSA_NAME,
    MSA_NAME = 'GRAND RAPIDS-WYOMING, MI'                     => MSA_NAME,
    MSA_NAME = 'MODESTO, CA'                                  => MSA_NAME,
    MSA_NAME = 'NC NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'MI NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'GA NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'SALINAS, CA'                                  => MSA_NAME,
    MSA_NAME = 'RENO-SPARKS, NV'                              => MSA_NAME,
    MSA_NAME = 'TULSA, OK'                                    => MSA_NAME,
    MSA_NAME = 'RALEIGH-CARY, NC'                             => MSA_NAME,
    MSA_NAME = 'CO NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'TN NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'KS NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'AL NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'WICHITA, KS'                                  => MSA_NAME,
    MSA_NAME = 'SANTA ROSA-PETALUMA, CA'                      => MSA_NAME,
    MSA_NAME = 'JACKSON, MS'                                  => MSA_NAME,
    MSA_NAME = 'DAYTON, OH'                                   => MSA_NAME,
    MSA_NAME = 'OH NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA'      => MSA_NAME,
    MSA_NAME = 'ND NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'IN NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'AKRON, OH'                                    => MSA_NAME,
    MSA_NAME = 'VALLEJO-FAIRFIELD, CA'                        => MSA_NAME,
    MSA_NAME = 'COLUMBIA, SC'                                 => MSA_NAME,
    MSA_NAME = 'PHOENIX-MESA-SCOTTSDALE,AZ'                   => MSA_NAME,
    MSA_NAME = 'BROWNSVILLE-HARLINGEN, TX'                    => MSA_NAME,
    MSA_NAME = 'GREENVILLE-MAULDIN-EASLEY, SC'                => MSA_NAME,
    MSA_NAME = 'BEAUMONT-PORT ARTHUR, TX'                     => MSA_NAME,
    MSA_NAME = 'FARMINGTON, NM'                               => MSA_NAME,
    MSA_NAME = 'PORTLAND-VANCOUVER-BEAVERTON, OR-WA'          => MSA_NAME,
    MSA_NAME = 'PORT ST. LUCIE, FL'                           => MSA_NAME,
    MSA_NAME = 'VALLEJO-FAIRFIELD, CA'                        => MSA_NAME,
    MSA_NAME = 'MERCED, CA'                                   => MSA_NAME,
    MSA_NAME = 'SPRINGFIELD, MO'                              => MSA_NAME,
    MSA_NAME = 'FL NONMETROPOLITAN AREA'                      => MSA_NAME,
    MSA_NAME = 'SANTA CRUZ-WATSONVILLE, CA'                   => MSA_NAME,
                                                                 'STATE: ' + trim(out_st, LEFT, RIGHT)
    );

	sysdate := common.sas_date(if(archive_date=999999, (STRING)Std.Date.Today(), (string6)archive_date+'01'));
	
	iv_pots_phone := (telcordia_type in ['00', '50', '51', '52', '54']);

	iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

	iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

	iv_va002_add_invalid := map(
			not(add1_pop)                                       => ' ',
			trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N' => '1',
																														 '0');

	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

	iv_ds001_impulse_count := map(
			not(truedid) => NULL,
			impulse_count = 0 and email_src_im => 1,
																								impulse_count);

	bureau_adl_vo_fseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

	bureau_adl_fseen_vo := if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ','));

	_bureau_adl_fseen_vo := common.sas_date((string)(bureau_adl_fseen_vo));

	_src_bureau_adl_fseen := _bureau_adl_fseen_vo;

	mth_ver_src_fdate_vo := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_fseen = NULL => -1,	
			if (((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)) >= 0,
																			truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), 
																			roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));

	bureau_adl_vo_lseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

	bureau_adl_lseen_vo := if(bureau_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_vo_lseen_pos, ','));

	_bureau_adl_lseen_vo := common.sas_date((string)(bureau_adl_lseen_vo));

	_src_bureau_adl_lseen_2 := _bureau_adl_lseen_vo;

	mth_ver_src_ldate_vo := map(
			not(truedid)                   => NULL,
			_src_bureau_adl_lseen_2 = NULL => -1,
																				if ((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12))));

	mth_ver_src_fdate_vo60 := mth_ver_src_fdate_vo > 60;

	mth_ver_src_ldate_vo0 := mth_ver_src_ldate_vo = 0;

	bureau_adl_w_lseen_pos := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E');

	bureau_adl_lseen_w := if(bureau_adl_w_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_w_lseen_pos, ','));

	_bureau_adl_lseen_w := common.sas_date((string)(bureau_adl_lseen_w));

	_src_bureau_adl_lseen_1 := _bureau_adl_lseen_w;

	mth_ver_src_ldate_w := map(
			not(truedid)                   => NULL,
			_src_bureau_adl_lseen_1 = NULL => -1,
																				if ((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12))));

	mth_ver_src_ldate_w0 := mth_ver_src_ldate_w = 0;

	bureau_adl_wp_lseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

	bureau_adl_lseen_wp := if(bureau_adl_wp_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_wp_lseen_pos, ','));

	_bureau_adl_lseen_wp := common.sas_date((string)(bureau_adl_lseen_wp));

	_src_bureau_adl_lseen := _bureau_adl_lseen_wp;

	mth_ver_src_ldate_wp := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_lseen = NULL => -1,
																			if ((sysdate - _src_bureau_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen) / (365.25 / 12))));

	mth_ver_src_ldate_wp0 := mth_ver_src_ldate_wp = 0;

	_paw_first_seen := common.sas_date((string)paw_first_seen);
//use to use roundup not round
	mth_paw_first_seen := map(
    not(truedid)           => NULL,
    _paw_first_seen = NULL => -1,
                              if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0,
															truncate((sysdate - _paw_first_seen) / (365.25 / 12)),
															roundup((sysdate - _paw_first_seen) / (365.25 / 12))));

	mth_paw_first_seen2 := if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen)));

	ver_src_am := Models.Common.findw_cpp(ver_sources, 'AM' , ', ', 'E') > 0;

	ver_src_e1 := Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E') > 0;

	ver_src_e2 := Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E') > 0;

	ver_src_e3 := Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E') > 0;

	ver_src_pl := Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0;

	ver_src_w := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') > 0;

	paw_dead_business_count_gt3 := paw_dead_business_count > 3;

	paw_active_phone_count_0 := paw_active_phone_count <= 0;

	_infutor_first_seen := common.sas_date((string)infutor_first_seen);

	mth_infutor_first_seen := map(
			not(truedid)               => NULL,
			_infutor_first_seen = NULL => NULL,
																		if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))));

	_infutor_last_seen := common.sas_date((string)infutor_last_seen);

	mth_infutor_last_seen := map(
			not(truedid)              => NULL,
			_infutor_last_seen = NULL => NULL,
																	 if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12))));

	infutor_i := map(
			infutor_nap = 12 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 1,
			infutor_nap = 12                                                                 => 4,
			infutor_nap = 11 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 3,
			infutor_nap = 11                                                                 => 5,
			infutor_nap >= 7 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 6,
			infutor_nap >= 7                                                                 => 7,
			(infutor_nap in [1, 6])                                                          => 8,
			(infutor_nap in [0])                                                             => 2,
																																													7);

	infutor_im := map(
			infutor_i = 1 => 7.77,
			infutor_i = 2 => 8.06,
			infutor_i = 3 => 8.38,
			infutor_i = 4 => 8.96,
			infutor_i = 5 => 9.35,
			infutor_i = 6 => 10.19,
			infutor_i = 7 => 13.13,
			infutor_i = 8 => 14.77,
											 9.03);

	white_pages_adl_wp_fseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

	white_pages_adl_fseen_wp := if(white_pages_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, white_pages_adl_wp_fseen_pos, ','));

	_white_pages_adl_fseen_wp := common.sas_date((string)(white_pages_adl_fseen_wp));

	_src_white_pages_adl_fseen := _white_pages_adl_fseen_wp;

	iv_sr001_m_wp_adl_fs := map(
			not(truedid)                      => NULL,
			_src_white_pages_adl_fseen = NULL => -1,
																					 if ((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12))));

	src_m_wp_adl_fs := map(
			iv_sr001_m_wp_adl_fs = NULL => -1,
			iv_sr001_m_wp_adl_fs = -1   => 10,
			iv_sr001_m_wp_adl_fs >= 24  => 24,
																		 iv_sr001_m_wp_adl_fs);

	_header_first_seen := common.sas_date((string)(header_first_seen));

	iv_sr001_m_hdr_fs := map(
			not(truedid)                   => NULL,
			not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
																				-1);

	src_m_hdr_fs := map(
			iv_sr001_m_hdr_fs = NULL => 15,
			iv_sr001_m_hdr_fs = -1   => 40,
			iv_sr001_m_hdr_fs >= 260 => 260,
																	iv_sr001_m_hdr_fs);

	source_mod6_1 := -2.350792319 +
			(integer)ver_src_am * -0.611853123 +
			(integer)ver_src_e1 * -0.208450798 +
			(integer)ver_src_e2 * -0.23159296 +
			(integer)ver_src_e3 * -0.415443106 +
			(integer)ver_src_pl * -0.275168358 +
			(integer)mth_ver_src_fdate_vo60 * -0.119660071 +
			(integer)mth_ver_src_ldate_vo0 * -0.322346162 +
			(integer)ver_src_w * -0.232332713 +
			(integer)mth_ver_src_ldate_w0 * -0.371580672 +
			(integer)mth_ver_src_ldate_wp0 * -0.149556634 +
			mth_paw_first_seen2 * -0.002615342 +
			(integer)paw_dead_business_count_gt3 * 1.3423068152 +
			(integer)paw_active_phone_count_0 * 0.3754685927 +
			infutor_im * 0.061827139 +
			src_m_wp_adl_fs * -0.006650973 +
			src_m_hdr_fs * -0.004903484;

	source_mod6 := exp(source_mod6_1) / (1 + exp(source_mod6_1));
	source_temp := round(500 * source_mod6/0.1) * 0.1;
	iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, (100 - source_temp) * 10) /10);
//if(not(truedid), NULL, max((real)0, round((100 - source_temp) * 10) /10));
	iv_sr001_source_profile_index := map(
			not(truedid)                  => -1,
			iv_sr001_source_profile <= 9  => 0,
			iv_sr001_source_profile <= 18 => 1,
			iv_sr001_source_profile <= 23 => 2,
			iv_sr001_source_profile <= 35 => 3,
			iv_sr001_source_profile <= 60 => 4,
			iv_sr001_source_profile <= 72 => 5,
			iv_sr001_source_profile <= 79 => 6,
			iv_sr001_source_profile <= 82 => 7,
			iv_sr001_source_profile <= 86 => 8,
																			 9);

	iv_pv001_bst_avm_autoval := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_avm_automated_valuation,
													add2_avm_automated_valuation);

	iv_pl002_addrs_per_ssn_c6 := if(not((integer) ssnlength > 0), NULL, addrs_per_ssn_c6);

	iv_po001_inp_addr_naprop := if(not(add1_pop), ' ', (string)add1_naprop);

	iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

	_reported_dob := common.sas_date((string)(reported_dob));

	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

	iv_combined_age := map(
			not(truedid or dobpop) 			=> NULL,
			age > 0                			=> age,
			(integer) input_dob_age > 0 => (integer) input_dob_age,
			inferred_age > 0       			=> inferred_age,
			reported_age > 0       			=> reported_age,
			(integer) ams_age > 0   		=> (integer) ams_age,
																-1);

	iv_ssn_miskey := if(not(truedid and (integer) ssnlength > 0), NULL, (integer) rc_ssnmiskeyflag);

	iv_inp_addr_assessed_total_val := if(not(add1_pop), NULL, add1_assessed_total_value);

	iv_prv_addr_avm_auto_val := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add2_avm_automated_valuation,
													add3_avm_automated_valuation);

	iv_addrs_5yr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 addrs_5yr);

	iv_hist_addr_match := map(
			not(truedid)            => NULL,
			hist_addr_match = -9999 => -1,
																 hist_addr_match);

	iv_avg_num_sources_per_addr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 if (if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10))) >= 0, truncate(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10)))), roundup(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10))))));

	iv_max_ids_per_sfd_addr := map(
			not(add1_pop)    => NULL,
			iv_add_apt  => -1,
			max(adls_per_addr, ssns_per_addr));

	iv_phones_per_adl_c6 := if(not(truedid), NULL, phones_per_adl_c6);

	iv_ssns_per_addr_c6 := if(not(add1_pop), NULL, ssns_per_addr_c6);

	iv_phones_per_sfd_addr_c6 := map(
			not(add1_pop)    => NULL,
			iv_add_apt => -1,
			phones_per_addr_c6);

	iv_paw_source_count := if(not(truedid), NULL, paw_source_count);

	iv_rec_vehx_level := map(
			not(truedid)                                   => '  ',
			attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
			attr_num_aircraft > 0                          => 'AO',
			watercraft_count > 0                           => trim('W', LEFT, RIGHT) + trim((string) min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
																												'XX');

	iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

	iv_liens_unrel_x_rel := if(not(truedid), '   ', trim((string) min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT));

	iv_criminal_x_felony := if(not(truedid), '   ', trim((string) min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

	iv_ams_college_tier := map(
			not(truedid)            => '  ',
			(string) trim(ams_college_tier) = '' => '-1',
			ams_college_tier);

	iv_pb_average_dollars := map(
			not(truedid)              => NULL,
			(string) trim(pb_average_dollars) = '' => -1,
			(integer) pb_average_dollars);

	_msa_subscore0 := map(
			(iv_va002_add_invalid in [' ']) => 0.000000,
			(iv_va002_add_invalid in ['0']) => 0.011130,
			(iv_va002_add_invalid in ['1']) => -0.212605,
																				 0.000000);

	_msa_subscore1 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.022814,
			1 <= iv_ds001_impulse_count                                  => -0.868674,
																																			-0.000000);

	_msa_subscore2 := map(
			NULL < iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 7 => -0.016723,
			7 <= iv_sr001_source_profile_index                                         => 0.251948,
																																										-0.000000);

	_msa_subscore3 := map(
			NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1        => -0.007174,
			1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 17481      => -0.559313,
			17481 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 38651  => -0.365437,
			38651 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 59349  => -0.143017,
			59349 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 85161  => -0.048501,
			85161 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 157254 => 0.075827,
			157254 <= iv_pv001_bst_avm_autoval                                      => 0.219769,
																																								 -0.000000);

	_msa_subscore4 := map(
			NULL < iv_pl002_addrs_per_ssn_c6 AND iv_pl002_addrs_per_ssn_c6 < 1 => 0.071268,
			1 <= iv_pl002_addrs_per_ssn_c6 AND iv_pl002_addrs_per_ssn_c6 < 2   => -0.491307,
			2 <= iv_pl002_addrs_per_ssn_c6                                     => -0.860672,
																																						-0.000000);

	_msa_subscore5 := map(
			(iv_po001_inp_addr_naprop in [' '])      => -0.000000,
			(iv_po001_inp_addr_naprop in ['0'])      => -0.035296,
			(iv_po001_inp_addr_naprop in ['1'])      => -0.100130,
			(iv_po001_inp_addr_naprop in ['2', '3']) => 0.171826,
			(iv_po001_inp_addr_naprop in ['4'])      => 0.455072,
																									-0.000000);

	_msa_subscore6 := map(
			NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 19999   => 0.290046,
			19999 <= iv_in001_estimated_income AND iv_in001_estimated_income < 28000 => -0.108344,
			28000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 31000 => -0.075841,
			31000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 35000 => 0.044458,
			35000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 65000 => 0.113881,
			65000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 91000 => 0.202171,
			91000 <= iv_in001_estimated_income                                       => 0.360295,
																																									0.000000);

	_msa_subscore7 := map(
			NULL < iv_combined_age AND iv_combined_age < 18 => -0.000000,
			18 <= iv_combined_age AND iv_combined_age < 62  => -0.029623,
			62 <= iv_combined_age                           => 0.289220,
																												 -0.000000);

	_msa_subscore8 := map(
			(iv_ssn_miskey = 0 OR iv_ssn_miskey = NULL) => 0.007327,
			(iv_ssn_miskey in [1])      => -0.214381,
																			 0.000000);

	_msa_subscore9 := map(
			NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 1       => -0.027185,
			1 <= iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 11080     => -0.179875,
			11080 <= iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 20582 => -0.092247,
			20582 <= iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 91733 => 0.044588,
			91733 <= iv_inp_addr_assessed_total_val                                            => 0.134247,
																																														0.000000);

	_msa_subscore10 := map(
			NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1         => 0.011373,
			1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 32797       => -0.423039,
			32797 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 53300   => -0.241125,
			53300 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 81754   => -0.144053,
			81754 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 105786  => -0.050371,
			105786 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 134388 => 0.064302,
			134388 <= iv_prv_addr_avm_auto_val                                       => 0.147749,
																																									-0.000000);

	_msa_subscore11 := map(
			NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => 0.094457,
			0 <= iv_addrs_5yr AND iv_addrs_5yr < 2   => 0.065517,
			2 <= iv_addrs_5yr AND iv_addrs_5yr < 5   => -0.056652,
			5 <= iv_addrs_5yr                        => -0.207398,
																									0.000000);

	_msa_subscore12 := map(
			NULL < iv_hist_addr_match AND iv_hist_addr_match < 0 => -0.437020,
			0 <= iv_hist_addr_match AND iv_hist_addr_match < 1   => -0.089916,
			1 <= iv_hist_addr_match                              => 0.162871,
																															-0.000000);

	_msa_subscore13 := map(
			NULL < iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 1 => 0.231501,
			1 <= iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 3   => -0.051083,
			3 <= iv_avg_num_sources_per_addr                                       => 0.124423,
																																								-0.000000);

	_msa_subscore14 := map(
			NULL < iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 0 => 0.020004,
			0 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 1   => 0.044628,
			1 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 5   => 0.459059,
			5 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 7   => 0.256225,
			7 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 11  => 0.191049,
			11 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 19 => -0.032343,
			19 <= iv_max_ids_per_sfd_addr                                  => -0.230635,
																																				-0.000000);

	_msa_subscore15 := map(
			NULL < iv_phones_per_adl_c6 AND iv_phones_per_adl_c6 < 1 => 0.030107,
			1 <= iv_phones_per_adl_c6                                => -0.344067,
																																	-0.000000);

	_msa_subscore16 := map(
			NULL < iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 1 => 0.062469,
			1 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 3   => -0.200267,
			3 <= iv_ssns_per_addr_c6                               => -0.466869,
																																0.000000);

	_msa_subscore17 := map(
			NULL < iv_phones_per_sfd_addr_c6 AND iv_phones_per_sfd_addr_c6 < 0 => 0.015956,
			0 <= iv_phones_per_sfd_addr_c6 AND iv_phones_per_sfd_addr_c6 < 1   => 0.048284,
			1 <= iv_phones_per_sfd_addr_c6 AND iv_phones_per_sfd_addr_c6 < 2   => -0.339159,
			2 <= iv_phones_per_sfd_addr_c6                                     => -0.755619,
																																						-0.000000);

	_msa_subscore18 := map(
			NULL < iv_paw_source_count AND iv_paw_source_count < 1 => -0.015444,
			1 <= iv_paw_source_count                               => 0.199692,
																																-0.000000);

	_msa_subscore19 := map(
			(iv_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 0.402175,
			(iv_rec_vehx_level in ['XX'])                         => -0.003495,
																															 -0.000000);

	_msa_subscore20 := map(
			NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.017100,
			1 <= iv_eviction_count                             => -0.318211,
																														0.000000);

	_msa_subscore21 := map(
			(iv_liens_unrel_x_rel in ['0-0'])                             => 0.036833,
			(iv_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '1-2', '2-2']) => -0.046713,
			(iv_liens_unrel_x_rel in ['1-0', '2-1', '3-1', '3-2'])        => -0.243852,
			(iv_liens_unrel_x_rel in ['2-0', '3-0'])                      => -0.354878,
																																			 0.000000);

	_msa_subscore22 := map(
			(iv_criminal_x_felony in ['0-0'])                                           => 0.040571,
			(iv_criminal_x_felony in ['1-0', '2-0'])                                    => -0.498939,
			(iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.928587,
																																										 0.000000);

	_msa_subscore23 := map(
			(iv_ams_college_tier in ['-1'])          => -0.025136,
			(iv_ams_college_tier in ['1', '2', '3']) => 0.907458,
			(iv_ams_college_tier in ['4'])           => 0.647562,
			(iv_ams_college_tier in ['0', '5', '6']) => 0.380492,
																									0.000000);

	_msa_subscore24 := map(
			NULL < iv_pb_average_dollars AND iv_pb_average_dollars < 6 => -0.063866,
			6 <= iv_pb_average_dollars AND iv_pb_average_dollars < 8   => -0.446884,
			8 <= iv_pb_average_dollars AND iv_pb_average_dollars < 13  => 0.012956,
			13 <= iv_pb_average_dollars AND iv_pb_average_dollars < 38 => 0.208613,
			38 <= iv_pb_average_dollars                                => 0.320319,
																																		-0.000000);

	_msa_subscore25 := map(
			(_msa in ['AL NONMETROPOLITAN AREA', 'AR NONMETROPOLITAN AREA', 'GA NONMETROPOLITAN AREA', 'KY NONMETROPOLITAN AREA', 'LA NONMETROPOLITAN AREA', 'MS NONMETROPOLITAN AREA', 'NC NONMETROPOLITAN AREA', 'STATE: LA', 'TN NONMETROPOLITAN AREA'])                                      => -0.579975,
			(_msa in ['BATON ROUGE, LA', 'JACKSON, MS', 'NEW ORLEANS-METAIRIE-KENNER,LA', 'STATE: AL', 'STATE: MS'])                                                                                                                                                                             => -0.391421,
			(_msa in ['BEAUMONT-PORT ARTHUR, TX', 'BROWNSVILLE-HARLINGEN, TX', 'DALLAS-FORT WORTH-ARLINGTON,TX', 'EL PASO, TX', 'HOUSTON-SUGAR LAND-BAYTOWN,TX', 'MCALLEN-EDINBURG-MISSION,TX', 'SAN ANTONIO, TX', 'TX NONMETROPOLITAN AREA'])                                                   => 0.220783,
			(_msa in ['AKRON, OH', 'CLEVELAND-ELYRIA-MENTOR,OH', 'OH NONMETROPOLITAN AREA', 'STATE: OH'])                                                                                                                                                                                        => -0.090366,
			(_msa in ['AUSTIN-ROUND ROCK, TX'])                                                                                                                                                                                                                                                  => 0.305737,
			(_msa in ['ATLANTA-SANDY SPRINGS-MARIETTA, GA', 'BIRMINGHAM-HOOVER, AL', 'STATE: GA'])                                                                                                                                                                                               => -0.077981,
			(_msa in ['COLUMBUS, OH', 'DAYTON, OH'])                                                                                                                                                                                                                                             => 0.234112,
			(_msa in ['BAKERSFIELD, CA', 'CA NONMETROPOLITAN AREA', 'FRESNO, CA', 'MERCED, CA', 'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA', 'SD NONMETROPOLITAN AREA', 'STOCKTON, CA', 'VALLEJO-FAIRFIELD, CA', 'VISALIA-PORTERVILLE, CA'])                                                         => 0.062969,
			(_msa in ['BOSTON-CAMBRIDGE-QUINCY,MA-NH', 'NEW YORK-NORTHERN NEW JERSEY', 'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD', 'STATE: NJ', 'STATE: NY', 'STATE: PA', 'STATE: VI', 'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV'])                                                       => -0.117342,
			(_msa in ['BRIDGEPORT-STAMFORD-NORWALK,CT', 'HARTFORD-WEST HARTFORD-EASTHARTFORD, CT', 'NEW HAVEN-MILFORD, CT', 'PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA', 'STATE: CT'])                                                                                                             => -0.390277,
			(_msa in ['CHARLOTTE-GASTONIA-CONCORD,NC-SC', 'COLUMBIA, SC', 'GREENVILLE-MAULDIN-EASLEY, SC', 'LOUISVILLE/JEFFERSON COUNTY,KY-IN', 'MEMPHIS, TN-AR-MS', 'RALEIGH-CARY, NC', 'STATE: KY', 'STATE: NC', 'STATE: SC', 'STATE: TN', 'STATE: WV'])                                       => -0.182729,
			(_msa in ['CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI'])                                                                                                                                                                                                                                    => 0.063924,
			(_msa in ['CO NONMETROPOLITAN AREA', 'FARMINGTON, NM', 'MT NONMETROPOLITAN AREA', 'ND NONMETROPOLITAN AREA', 'STATE: CO', 'STATE: ID', 'STATE: MT', 'STATE: ND', 'STATE: SD', 'STATE: UT', 'STATE: WY'])                                                                             => 0.099330,
			(_msa in ['DETROIT-WARREN-LIVONIA, MI', 'MILWAUKEE-WAUKESHA-WEST ALLIS, WI'])                                                                                                                                                                                                        => -0.178295,
			(_msa in ['FL NONMETROPOLITAN AREA', 'JACKSONVILLE, FL', 'ORLANDO-KISSIMMEE, FL', 'PORT ST. LUCIE, FL', 'STATE: FL'])                                                                                                                                                                => -0.215434,
			(_msa in ['GRAND RAPIDS-WYOMING, MI', 'MI NONMETROPOLITAN AREA', 'STATE: IA', 'STATE: MI', 'STATE: MN', 'STATE: WI'])                                                                                                                                                                => 0.083034,
			(_msa in ['IN NONMETROPOLITAN AREA', 'INDIANAPOLIS-CARMEL, IN', 'STATE: IN'])                                                                                                                                                                                                        => 0.011680,
			(_msa in ['KANSAS CITY, MO-KS', 'KS NONMETROPOLITAN AREA', 'LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR', 'MO NONMETROPOLITAN AREA', 'OK NONMETROPOLITAN AREA', 'OKLAHOMA CITY, OK', 'SPRINGFIELD, MO', 'STATE: KS', 'STATE: NE', 'STATE: OK', 'STATE: TX', 'TULSA, OK', 'WICHITA, KS']) => 0.175044,
			(_msa in ['LOS ANGELES-LONG BEACH-SANTAANA, CA', 'MODESTO, CA', 'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA', 'SAN DIEGO-CARLSBAD-SAN MARCOS, CA', 'STATE:', 'STATE: HI'])                                                                                                                 => 0.139965,
			(_msa in ['MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL'])                                                                                                                                                                                                                                => 0.239635,
			(_msa in ['NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN'])                                                                                                                                                                                                                           => 0.125969,
			(_msa in ['PHOENIX-MESA-SCOTTSDALE,AZ', 'STATE: AZ', 'STATE: NM', 'STATE: NV'])                                                                                                                                                                                                      => -0.260459,
			(_msa in ['PORTLAND-VANCOUVER-BEAVERTON, OR-WA', 'SEATTLE-TACOMA-BELLEVUE,WA', 'STATE: OR', 'STATE: WA'])                                                                                                                                                                            => 0.129238,
			(_msa in ['RENO-SPARKS, NV', 'SALINAS, CA', 'SAN FRANCISCO-OAKLAND-FREMONT, CA', 'SAN JOSE-SUNNYVALE-SANTACLARA, CA', 'SANTA CRUZ-WATSONVILLE, CA', 'SANTA ROSA-PETALUMA, CA', 'STATE: CA'])                                                                                         => 0.369434,
			(_msa in ['SAN JUAN-CAGUAS-GUAYNABO,PR', 'STATE: GU', 'STATE: PR'])                                                                                                                                                                                                                  => -0.273437,
			(_msa in ['ST. LOUIS, MO-IL', 'STATE: IL', 'STATE: MO'])                                                                                                                                                                                                                             => -0.112982,
			(_msa in ['STATE: AK', 'STATE: AP', 'STATE: AR'])                                                                                                                                                                                                                                    => -0.081064,
			(_msa in ['STATE: DE', 'STATE: MA', 'STATE: MD', 'STATE: ME', 'STATE: NH', 'STATE: VA', 'STATE: VT'])                                                                                                                                                                                => -0.649572,
																																																																																																																																															0.000000);

	_msa_rawscore := _msa_subscore0 +
			_msa_subscore1 +
			_msa_subscore2 +
			_msa_subscore3 +
			_msa_subscore4 +
			_msa_subscore5 +
			_msa_subscore6 +
			_msa_subscore7 +
			_msa_subscore8 +
			_msa_subscore9 +
			_msa_subscore10 +
			_msa_subscore11 +
			_msa_subscore12 +
			_msa_subscore13 +
			_msa_subscore14 +
			_msa_subscore15 +
			_msa_subscore16 +
			_msa_subscore17 +
			_msa_subscore18 +
			_msa_subscore19 +
			_msa_subscore20 +
			_msa_subscore21 +
			_msa_subscore22 +
			_msa_subscore23 +
			_msa_subscore24 +
			_msa_subscore25;

	_msa_lnoddsscore := _msa_rawscore + 0.822418;

	_msa_probscore := exp(_msa_lnoddsscore) / (1 + exp(_msa_lnoddsscore));

	base := 700;

	pts := 40;

	logit := ln(.695 / (1 - .695));

	_msa_model := min(if(max(round(base + pts * (_msa_lnoddsscore - logit) / ln(2)), 501) = NULL, -NULL, max(round(base + pts * (_msa_lnoddsscore - logit) / ln(2)), 501)), 900);

	ov_rc19 := combo_lnamecount = 0 and combo_addrcount = 0 and combo_hphonecount = 0 and combo_ssncount = 0;

	_200 := (integer) ssnlength > 0 and rc_decsflag = '1';

	_201 := rc_hrisksic = '2225';

	_203 := nas_summary <= 4 and nap_summary <= 4 or ov_rc19;

	_210 := fnamepop = false and lnamepop = false and addrpop = false and (integer) ssnlength = 0 and hphnpop = false;

	_222 := iv_riskview_222s;

	_650 := _msa_model > 650 and impulse_count > 0;

	_670 := _msa_model > 670 and criminal_count > 0;

	_700 := _msa_model > 700 and (rc_pwssnvalflag in ['1', '2', '3']);

	rvt1307_3_0 := map(
			_200 => 200,
			_201 => 201,
			_210 => 210,
			_203 => 203,
			_222 => 222,
			_650 => 650,
			_670 => 670,
			_700 => 700,
							_msa_model);

	rc5_2 := '';

	glrc11 := addrpop;

	glrc9h := truedid and impulse_count > 0;

	glrc9r := truedid and 0 < iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 7 and -1 < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 120;

	glrcpv := truedid and addrpop and 0 < add1_avm_automated_valuation AND add1_avm_automated_valuation < 100000;

	glrc9d := (integer) ssnlength = 9 and iv_pl002_addrs_per_ssn_c6 > 0 or iv_addrs_5yr > 2;

	glrc9a := add1_naprop < 2 and property_owned_total < 1;

	glrc9j := -1 < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs <= 140;

	glrc29 := truedid and (integer) ssnlength = 9;

	glrc25 := addrpop and iv_hist_addr_match < 1;

	glrc9e := addrpop and 0 < iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 3;

	glrc9m := truedid and attr_num_aircraft = 0 and watercraft_count = 0 and (integer) wealth_index <= 2;

	glrcev := attr_eviction_count > 0;

	glrc98 := truedid and (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0);

	glrc97 := truedid  and criminal_count > 0;

	glrc9i := truedid and not((ams_college_code in ['1', '2', '4'])) and 18 <= age AND age < 30;

	// glrc9y := truedid and pb_total_orders = '';

	glrcbl := 0;

	rcvalue11_1 := 0.011130 - _msa_subscore0;

	rcvalue11 := (integer)glrc11 * if(max(rcvalue11_1) = NULL, NULL, sum(if(rcvalue11_1 = NULL, 0, rcvalue11_1)));

	rcvalue9h_1 := 0.022814 - _msa_subscore1;

	rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

	rcvalue9r_1 := 0.251948 - _msa_subscore2;

	rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));

	rcvaluepv_1 := 0.219769 - _msa_subscore3;

	rcvaluepv_2 := 0.134247 - _msa_subscore9;

	rcvaluepv := (integer)glrcpv * if(max(rcvaluepv_1, rcvaluepv_2) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2)));

	rcvalue9d_1 := 0.071268 - _msa_subscore4;

	rcvalue9d_2 := 0.065517 - _msa_subscore11;

	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1, rcvalue9d_2) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2)));

	rcvalue9a_1 := 0.455072 - _msa_subscore5;

	rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

	rcvalue9j_1 := 0.289220 - _msa_subscore7;

	rcvalue9j := (integer)glrc9j * if(max(rcvalue9j_1) = NULL, NULL, sum(if(rcvalue9j_1 = NULL, 0, rcvalue9j_1)));

	rcvalue29_1 := 0.007327 - _msa_subscore8;

	rcvalue29 := (integer)glrc29 * if(max(rcvalue29_1) = NULL, NULL, sum(if(rcvalue29_1 = NULL, 0, rcvalue29_1)));

	rcvalue25_1 := 0.162871 - _msa_subscore12;

	rcvalue25 := (integer)glrc25 * if(max(rcvalue25_1) = NULL, NULL, sum(if(rcvalue25_1 = NULL, 0, rcvalue25_1)));

	rcvalue9e_1 := 0.124423 - _msa_subscore13;

	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

	rcvalue9m_1 := 0.402175 - _msa_subscore19;

	rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1)));

	rcvalueev_1 := 0.017100 - _msa_subscore20 + 0.25;

	rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

	rcvalue98_1 := 0.036833 - _msa_subscore21;

	rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

	rcvalue97_1 := 0.040571 - _msa_subscore22;

	rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

	rcvalue9i_1 := 0.380492 - _msa_subscore23;

	rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

	// rcvalue9y_1 := 0.320319 - _msa_subscore24;

	// rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));

	rcvaluebl_1 := 0.360295 - _msa_subscore6;

	rcvaluebl_2 := 0.147749 - _msa_subscore10;

	rcvaluebl_3 := 0.459059 - _msa_subscore14;

	rcvaluebl_4 := 0.030107 - _msa_subscore15;

	rcvaluebl_5 := 0.062469 - _msa_subscore16;

	rcvaluebl_6 := 0.015956 - _msa_subscore17;

	rcvaluebl_7 := 0.199692 - _msa_subscore18;

	rcvaluebl_8 := 0.369434 - _msa_subscore25;

	rcvaluebl := glrcbl * (rcvaluebl_1 +
			rcvaluebl_2 +
			rcvaluebl_3 +
			rcvaluebl_4 +
			rcvaluebl_5 +
			rcvaluebl_6 +
			rcvaluebl_7 +
			rcvaluebl_8);

	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//


	
	ds_layout := {STRING rc, REAL value};

	rc_dataset := DATASET([
    {'11', RCValue11},
    {'9H', RCValue9H},
    {'9R', RCValue9R},
    {'PV', RCValuePV},
    {'9D', RCValue9D},
    {'9A', RCValue9A},
    {'9J', RCValue9J},
    {'29', RCValue29},
    {'25', RCValue25},
    {'9E', RCValue9E},
    {'9M', RCValue9M},
    {'EV', RCValueEV},
    {'98', RCValue98},
    {'97', RCValue97},
    {'9I', RCValue9I},
    // {'9Y', RCValue9Y},
    {'BL', RCValueBL}
    ], ds_layout) (value > 0);

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);

	rcs_override := MAP(
											rvt1307_3_0 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvt1307_3_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rvt1307_3_0 = 900 => DATASET([{' ', NULL}], ds_layout),
											(500 < rvt1307_3_0) and (rvt1307_3_0 <= 720) and 
													(rcs_top[1].rc !='' and rcs_top[1].rc !='36') and 
													(rcs_top[2].rc='') => DATASET([{rcs_top[1].rc, NULL}, {'36', NULL}], ds_layout),		
											(500 < rvt1307_3_0) and (rvt1307_3_0 <= 720) and 
													(rcs_top[1].rc !='9E') and 
													(rcs_top[2].rc='') => DATASET([{rcs_top[1].rc, NULL}, {'9E', NULL}], ds_layout),
											rcs_top
										);
	
	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	
	rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
				SELF.hri := LEFT.rc,
				SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
			));

	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
			
	ri := MAP(
						riTemp[1].hri <> '00' => riTemp,
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//Intermediate variables
	#if(RVT_DEBUG)
		self.clam															:= le;
		self._msa                             := _msa;                                   
		self.sysdate                          := sysdate;                                
		self.iv_pots_phone                    := iv_pots_phone;                          
		self.iv_add_apt                       := iv_add_apt;                             
		self.iv_riskview_222s                 := iv_riskview_222s;                       
		self.iv_va002_add_invalid             := iv_va002_add_invalid;                   
		self.email_src_im                     := email_src_im;                           
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;                 
		self.bureau_adl_vo_fseen_pos          := bureau_adl_vo_fseen_pos;                
		self.bureau_adl_fseen_vo              := bureau_adl_fseen_vo;                    
		self._bureau_adl_fseen_vo             := _bureau_adl_fseen_vo;                   
		self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;                  
		self.mth_ver_src_fdate_vo             := mth_ver_src_fdate_vo;                   
		self.bureau_adl_vo_lseen_pos          := bureau_adl_vo_lseen_pos;                
		self.bureau_adl_lseen_vo              := bureau_adl_lseen_vo;                    
		self._bureau_adl_lseen_vo             := _bureau_adl_lseen_vo;                   
		self.mth_ver_src_ldate_vo             := mth_ver_src_ldate_vo;                   
		self.mth_ver_src_fdate_vo60           := mth_ver_src_fdate_vo60;                 
		self.mth_ver_src_ldate_vo0            := mth_ver_src_ldate_vo0;                  
		self.bureau_adl_w_lseen_pos           := bureau_adl_w_lseen_pos;                 
		self.bureau_adl_lseen_w               := bureau_adl_lseen_w;                     
		self._bureau_adl_lseen_w              := _bureau_adl_lseen_w;                    
		self.mth_ver_src_ldate_w              := mth_ver_src_ldate_w;                    
		self.mth_ver_src_ldate_w0             := mth_ver_src_ldate_w0;                   
		self.bureau_adl_wp_lseen_pos          := bureau_adl_wp_lseen_pos;                
		self.bureau_adl_lseen_wp              := bureau_adl_lseen_wp;                    
		self._bureau_adl_lseen_wp             := _bureau_adl_lseen_wp;                   
		self._src_bureau_adl_lseen            := _src_bureau_adl_lseen;                  
		self.mth_ver_src_ldate_wp             := mth_ver_src_ldate_wp;                   
		self.mth_ver_src_ldate_wp0            := mth_ver_src_ldate_wp0;                  
		self._paw_first_seen                  := _paw_first_seen;                        
		self.mth_paw_first_seen               := mth_paw_first_seen;                     
		self.mth_paw_first_seen2              := mth_paw_first_seen2;                    
		self.ver_src_am                       := ver_src_am;                             
		self.ver_src_e1                       := ver_src_e1;                             
		self.ver_src_e2                       := ver_src_e2;                             
		self.ver_src_e3                       := ver_src_e3;                             
		self.ver_src_pl                       := ver_src_pl;                             
		self.ver_src_w                        := ver_src_w;                              
		self.paw_dead_business_count_gt3      := paw_dead_business_count_gt3;            
		self.paw_active_phone_count_0         := paw_active_phone_count_0;               
		self._infutor_first_seen              := _infutor_first_seen;                    
		self.mth_infutor_first_seen           := mth_infutor_first_seen;                 
		self._infutor_last_seen               := _infutor_last_seen;                     
		self.mth_infutor_last_seen            := mth_infutor_last_seen;                  
		self.infutor_i                        := infutor_i;                              
		self.infutor_im                       := infutor_im;                             
		self.white_pages_adl_wp_fseen_pos     := white_pages_adl_wp_fseen_pos;           
		self.white_pages_adl_fseen_wp         := white_pages_adl_fseen_wp;               
		self._white_pages_adl_fseen_wp        := _white_pages_adl_fseen_wp;              
		self._src_white_pages_adl_fseen       := _src_white_pages_adl_fseen;             
		self.iv_sr001_m_wp_adl_fs             := iv_sr001_m_wp_adl_fs;                   
		self.src_m_wp_adl_fs                  := src_m_wp_adl_fs;                        
		self._header_first_seen               := _header_first_seen;                     
		self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;                      
		self.src_m_hdr_fs                     := src_m_hdr_fs;                           
		self.source_mod6                      := source_mod6;                            
		self.iv_sr001_source_profile          := iv_sr001_source_profile;                
		self.iv_sr001_source_profile_index    := iv_sr001_source_profile_index;          
		self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;               
		self.iv_pl002_addrs_per_ssn_c6        := iv_pl002_addrs_per_ssn_c6;              
		self.iv_po001_inp_addr_naprop         := iv_po001_inp_addr_naprop;               
		self.iv_in001_estimated_income        := iv_in001_estimated_income;              
		self._reported_dob                    := _reported_dob;                          
		self.reported_age                     := reported_age;                           
		self.iv_combined_age                  := iv_combined_age;                        
		self.iv_ssn_miskey                    := iv_ssn_miskey;                          
		self.iv_inp_addr_assessed_total_val   := iv_inp_addr_assessed_total_val;         
		self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;               
		self.iv_addrs_5yr                     := iv_addrs_5yr;                           
		self.iv_hist_addr_match               := iv_hist_addr_match;                     
		self.iv_avg_num_sources_per_addr      := iv_avg_num_sources_per_addr;            
		self.iv_max_ids_per_sfd_addr          := iv_max_ids_per_sfd_addr;                
		self.iv_phones_per_adl_c6             := iv_phones_per_adl_c6;                   
		self.iv_ssns_per_addr_c6              := iv_ssns_per_addr_c6;                    
		self.iv_phones_per_sfd_addr_c6        := iv_phones_per_sfd_addr_c6;              
		self.iv_paw_source_count              := iv_paw_source_count;                    
		self.iv_rec_vehx_level                := iv_rec_vehx_level;                      
		self.iv_eviction_count                := iv_eviction_count;                      
		self.iv_liens_unrel_x_rel             := iv_liens_unrel_x_rel;                   
		self.iv_criminal_x_felony             := iv_criminal_x_felony;                   
		self.iv_ams_college_tier              := iv_ams_college_tier;                    
		self.iv_pb_average_dollars            := iv_pb_average_dollars;                  
		self._msa_subscore0                   := _msa_subscore0;                         
		self._msa_subscore1                   := _msa_subscore1;                         
		self._msa_subscore2                   := _msa_subscore2;                         
		self._msa_subscore3                   := _msa_subscore3;                         
		self._msa_subscore4                   := _msa_subscore4;                         
		self._msa_subscore5                   := _msa_subscore5;                         
		self._msa_subscore6                   := _msa_subscore6;                         
		self._msa_subscore7                   := _msa_subscore7;                         
		self._msa_subscore8                   := _msa_subscore8;                         
		self._msa_subscore9                   := _msa_subscore9;                         
		self._msa_subscore10                  := _msa_subscore10;                        
		self._msa_subscore11                  := _msa_subscore11;                        
		self._msa_subscore12                  := _msa_subscore12;                        
		self._msa_subscore13                  := _msa_subscore13;                        
		self._msa_subscore14                  := _msa_subscore14;                        
		self._msa_subscore15                  := _msa_subscore15;                        
		self._msa_subscore16                  := _msa_subscore16;                        
		self._msa_subscore17                  := _msa_subscore17;                        
		self._msa_subscore18                  := _msa_subscore18;                        
		self._msa_subscore19                  := _msa_subscore19;                        
		self._msa_subscore20                  := _msa_subscore20;                        
		self._msa_subscore21                  := _msa_subscore21;                        
		self._msa_subscore22                  := _msa_subscore22;                        
		self._msa_subscore23                  := _msa_subscore23;                        
		self._msa_subscore24                  := _msa_subscore24;                        
		self._msa_subscore25                  := _msa_subscore25;                        
		self._msa_rawscore                    := _msa_rawscore;                          
		self._msa_lnoddsscore                 := _msa_lnoddsscore;                       
		self._msa_probscore                   := _msa_probscore;                         
		self.base                             := base;                                   
		self.pts                              := pts;                                    
		self.logit                            := logit;                                  
		self._msa_model                       := _msa_model;                             
		self.ov_rc19                          := ov_rc19;                                
		self._200                             := _200;                                   
		self._201                             := _201;                                   
		self._203                             := _203;                                   
		self._210                             := _210;                                   
		self._222                             := _222;                                   
		self._650                             := _650;                                   
		self._670                             := _670;                                   
		self._700                             := _700;                                   
		self.rvt1307_3_0                      := rvt1307_3_0;                            
		self.glrc11                           := glrc11;                                 
		self.glrc9h                           := glrc9h;                                 
		self.glrc9r                           := glrc9r;                                 
		self.glrcpv                           := glrcpv;                                 
		self.glrc9d                           := glrc9d;                                 
		self.glrc9a                           := glrc9a;                                 
		self.glrc9j                           := glrc9j;                                 
		self.glrc29                           := glrc29;                                 
		self.glrc25                           := glrc25;                                 
		self.glrc9e                           := glrc9e;                                 
		self.glrc9m                           := glrc9m;                                 
		self.glrcev                           := glrcev;                                 
		self.glrc98                           := glrc98;                                 
		self.glrc97                           := glrc97;                                 
		self.glrc9i                           := glrc9i;                                 
		// self.glrc9y                           := glrc9y;                                 
		self.glrcbl                           := glrcbl;                                 
		self.rcvalue11_1                      := rcvalue11_1;                            
		self.rcvalue11                        := rcvalue11;                              
		self.rcvalue9h_1                      := rcvalue9h_1;                            
		self.rcvalue9h                        := rcvalue9h;                              
		self.rcvalue9r_1                      := rcvalue9r_1;                            
		self.rcvalue9r                        := rcvalue9r;                              
		self.rcvaluepv_1                      := rcvaluepv_1;                            
		self.rcvaluepv_2                      := rcvaluepv_2;                            
		self.rcvaluepv                        := rcvaluepv;                              
		self.rcvalue9d_1                      := rcvalue9d_1;                            
		self.rcvalue9d_2                      := rcvalue9d_2;                            
		self.rcvalue9d                        := rcvalue9d;                              
		self.rcvalue9a_1                      := rcvalue9a_1;                            
		self.rcvalue9a                        := rcvalue9a;                              
		self.rcvalue9j_1                      := rcvalue9j_1;                            
		self.rcvalue9j                        := rcvalue9j;                              
		self.rcvalue29_1                      := rcvalue29_1;                            
		self.rcvalue29                        := rcvalue29;                              
		self.rcvalue25_1                      := rcvalue25_1;                            
		self.rcvalue25                        := rcvalue25;                              
		self.rcvalue9e_1                      := rcvalue9e_1;                            
		self.rcvalue9e                        := rcvalue9e;                              
		self.rcvalue9m_1                      := rcvalue9m_1;                            
		self.rcvalue9m                        := rcvalue9m;                              
		self.rcvalueev_1                      := rcvalueev_1;                            
		self.rcvalueev                        := rcvalueev;                              
		self.rcvalue98_1                      := rcvalue98_1;                            
		self.rcvalue98                        := rcvalue98;                              
		self.rcvalue97_1                      := rcvalue97_1;                            
		self.rcvalue97                        := rcvalue97;                              
		self.rcvalue9i_1                      := rcvalue9i_1;                            
		self.rcvalue9i                        := rcvalue9i;                              
		// self.rcvalue9y_1                      := rcvalue9y_1;                            
		// self.rcvalue9y                        := rcvalue9y;                              
		self.rcvaluebl_1                      := rcvaluebl_1;                            
		self.rcvaluebl_2                      := rcvaluebl_2;                            
		self.rcvaluebl_3                      := rcvaluebl_3;                            
		self.rcvaluebl_4                      := rcvaluebl_4;                            
		self.rcvaluebl_5                      := rcvaluebl_5;                            
		self.rcvaluebl_6                      := rcvaluebl_6;                            
		self.rcvaluebl_7                      := rcvaluebl_7;                            
		self.rcvaluebl_8                      := rcvaluebl_8;                            
		self.rcvaluebl                        := rcvaluebl;                              
		self.rc1                              := if(reasons[1].hri = '00', '', reasons[1].hri);
		self.rc2                              := if(reasons[2].hri = '00', '', reasons[2].hri);
		self.rc3                              := if(reasons[3].hri = '00', '', reasons[3].hri);
		self.rc4                              := if(reasons[4].hri = '00', '', reasons[4].hri);
		self.rc5                              := if(reasons[5].hri = '00', '', reasons[5].hri);                                 	
  #end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)rvt1307_3_0
										);
										self := [];
	END;

	model := project( clam, doModel(left) );

	return model;
END;