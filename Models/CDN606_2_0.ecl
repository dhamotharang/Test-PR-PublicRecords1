import ut, risk_indicators, address, RiskWise, Business_Risk, std;

export CDN606_2_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, dataset(RiskWise.Layout_CD2I) indata, boolean IBICID, boolean isBusiness, dataset(business_risk.layout_biid_btst_output) biid ) := 

FUNCTION		

models.Layout_ModelOut doModel(clam le, indata ri) := TRANSFORM

	consumer := ri.ordertype = '1';
	shipto_order := (integer)le.eddo.addrscore < 80;
	
	today := if(le.bill_to_out.historydate <> 999999, ((string)le.bill_to_out.historydate)[1..6] + '01', (STRING)Std.Date.Today());
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);
	

	avs := StringLib.StringToUpperCase(ri.avscode);
	pmttype := StringLib.StringToUpperCase(ri.pymtmethod);

	AVS_Unavailable := avs in ['0','5','9','E','R','S','U'];		 
	AVS_Match := avs in ['M','X','D'] or (avs = 'Y' and pmttype <> 'D') or (avs = 'A' and pmttype = 'D') or (avs in ['C','G'] and pmttype = 'A');
	AVS_No_Match := avs in ['N','I'] or (avs = 'W' and pmttype = 'D') or (avs in ['C','G'] and pmttype <> 'A');
	AVS_Zip_Match := avs in ['Z','P'] or (avs = 'W' and pmttype <> 'D');
	AVS_Addr_Match := avs in ['B'] or (avs = 'Y' and pmttype = 'D') or (avs = 'A' and pmttype <> 'D');
	AVS_Partial_Match := avs in ['F','L','O'];
	AVS_Name_Only_Match := avs = 'K';
	
	
	acquisition_phone := if((integer)ri.channel = 2, 1, 0);

	dpo := if((integer)ri.numitems = 0, -99, (real)ri.orderamt/(real)ri.numitems);
	
	ccresp := trim(StringLib.StringToUpperCase(ri.cidcode));
	cvv2match := map(ccresp = 'M' => 1,
				  ccresp in ['P','S','','NULL'] => 0,
				  ccresp in ['N','U'] => -1,
				  0);

	next_day_shipping := if(trim(ri.shipmode) in ['','2'], 1, 0);
	second_day_shipping := if(trim(ri.shipmode) = '7', 1, 0);

	laptop :=  if(ri.prodcode <> '' and (integer)ri.prodcode = 2, 1, 0);

	first_order_date := ut.DaysSince1900(ri.orderdate[1..4], ri.orderdate[5..6], ri.orderdate[7..8]);    

	days_since_first := today1900 - first_order_date;

	state_match := StringLib.StringToUpperCase(le.ip2o.state) = StringLib.StringToUpperCase(le.bill_to_out.shell_input.in_state);

	ip_pop := ri.ipaddr <> '';
	na_flag := le.ip2o.continent = '5';
	us_flag := StringLib.StringToUpperCase(le.ip2o.countrycode) = 'USA'; 

	state_eligible := ip_pop and na_flag and us_flag;
	state_match2 := state_eligible and not(~state_match and le.ip2o.statecf in ['4','5']);

	dot_mil := StringLib.StringToUpperCase(le.ip2o.topleveldomain) = 'MIL';
	dot_gov := StringLib.StringToUpperCase(le.ip2o.topleveldomain) = 'GOV';
	aol_domain := StringLib.StringToUpperCase(le.ip2o.secondleveldomain) = 'AOL';

	atPos := StringLib.StringFind(le.bill_to_out.shell_input.email_address, '@', 1);
	lenEmail := length(trim(le.bill_to_out.shell_input.email_address));
	email_provider := if(StringLib.StringFind(le.bill_to_out.shell_input.email_address, '.', 1) > 0, StringLib.StringToUpperCase(le.bill_to_out.shell_input.email_address[atPos+1..lenEmail]), '');


	zip_mismatch := le.bill_to_out.shell_input.in_zipcode <> le.ship_to_out.shell_input.in_zipcode;

	address_verified := le.bill_to_out.iid.nas_summary in [3,5,8] or le.bill_to_out.iid.nap_summary in [3,5,8,10,11,12];
	phone_verified := le.bill_to_out.iid.nap_summary in [4,6,7,9,10,11,12];

	address_verified_s := le.ship_to_out.iid.nas_summary in [3,5,8] or le.ship_to_out.iid.nap_summary in [3,5,8,10,11,12];
	phone_verified_s := le.ship_to_out.iid.nap_summary in [4,6,7,9,10,11,12];


	phnzip := (integer)le.bill_to_out.phone_verification.phone_zip_mismatch;
	pnotpots := if(le.bill_to_out.phone_verification.telcordia_type in ['00','50','51','52','54'], 0, 1);
	

	disconnect_flag_s := (integer)le.ship_to_out.phone_verification.disconnected;
	phnzip_s := (integer)le.ship_to_out.phone_verification.phone_zip_mismatch;
	pnotpots_s := if(le.ship_to_out.phone_verification.telcordia_type in ['00','50','51','52','54'], 0, 1);

	apt_flag := StringLib.StringToUpperCase(le.bill_to_out.address_validation.dwelling_type) = 'A';
	apt_flag_s := StringLib.StringToUpperCase(le.ship_to_out.address_validation.dwelling_type) = 'A';


	/********************************************************************************************************
	** CBD Model, Bill To Consumers Segment
	********************************************************************************************************/

	/********** customer variables ***************/
	AVS_Match_Level_bm := map(AVS_Match => 2,
						 AVS_No_Match => 0,
						 1);

	avs_match_level_bm_l := map(avs_match_level_bm = 0 => -1.96089602,
						   avs_match_level_bm = 1 => -3.068707814,
						   -4.327873964);

	dpo_c_bm := if(dpo = -99, 750, Min(dpo, 5000));

	days_since_first_bm := if(ri.orderdate <> '', Max(Min(days_since_first, 34), 0), -99);

	existing_cust_bm := days_since_first_bm > 30;

	/********** ip variables***************/
	ip_geo_location2_bm := map(ip_pop and ~na_flag and ~(dot_mil or dot_gov) => 1,
						  ip_pop and ~us_flag and ~(dot_mil or dot_gov) => 2,
						  ip_pop and ~state_match2 and ~aol_domain => 3,
						  ip_pop => 4,
						  2.5);

	ip_geo_location2_bm_m := map(ip_geo_location2_bm = 1 => 0.4,
						    ip_geo_location2_bm = 2 => 0.2636363636,
						    ip_geo_location2_bm = 2.5 => 0.039368932,
						    ip_geo_location2_bm = 3 => 0.0376032332,
						    0.012231338);

	domain2_bm := if(trim(StringLib.StringToLowerCase(le.ip2o.domain)) not in ['optonline.net', 'pacbell.net', '', 'ameritech.net', 'aol.com', 'swbell.net', 
																'bellsouth.net', 'sprint-hsd.net', 'insightbb.com', 'comcast.net', 'rr.com', 
																'adelphia.net', 'cox.net', 'mindspring.com', 'verizon.net', 'charter.com', 'direcpc.com', 
																'snet.net', 'mchsi.com', 'avivacenter.org', 'qwest.net', 'alltel.net', 'covad.net'], 'uncommon', 
				  trim(StringLib.StringToLowerCase(le.ip2o.domain[1..100])));


	domain_risk_bm := map(domain2_bm = 'optonline.net' => 0,
					  domain2_bm in ['pacbell.net', ''] => 1,
					  domain2_bm in ['ameritech.net','aol.com','swbell.net'] => 2,
					  domain2_bm in ['uncommon','bellsouth.net'] => 3,
					  domain2_bm in ['sprint-hsd.net','insightbb.com','comcast.net','rr.com','adelphia.net','cox.net',
								  'mindspring.com','verizon.net','charter.com'] => 5,
					  domain2_bm in ['direcpc.com','snet.net','mchsi.com','avivacenter.org'] => 7,
					  9);

	email_provider2_bm := if(email_provider not in ['YAHOO.COM','GMAIL.COM','JUNO.COM','','HOTMAIL.COM','AOL.COM','MSN.COM','DELL.COM',
										   'SBCGLOBAL.NET','BELLSOUTH.NET','EARTHLINK.NET','OPTONLINE.NET','CHARTER.NET',
										   'DELLINC.NET','VERIZON.NET','COX.NET','COMCAST.NET','ADELPHIA.NET'], 'UNCOMMON', trim(email_provider[1..25]));
	

	email_provider_risk_bm := map(email_provider2_bm = 'YAHOO.COM' => 0,
							email_provider2_bm = 'GMAIL.COM' => 1,
							email_provider2_bm in ['JUNO.COM','','HOTMAIL.COM'] => 2,
							email_provider2_bm in ['AOL.COM','MSN.COM','DELL.COM','UNCOMMON'] => 3,
							email_provider2_bm in ['SBCGLOBAL.NET','BELLSOUTH.NET','EARTHLINK.NET','OPTONLINE.NET',
											   'CHARTER.NET','DELLINC.NET','VERIZON.NET','COX.NET'] => 4,
							5);
							
							
	email_score_bm := map(le.eddo.efirstscore = '-1' or le.eddo.elastscore = '-1' => -1,
					  (integer)le.eddo.elastscore  > 0 => 1,
					  (integer)le.eddo.efirstscore > 0 => 2,
					  3);

	email_score_bm_l := map(email_score_bm = -1 => -3.195219666,
					    email_score_bm =  1 => -4.532534716,
					    email_score_bm =  2 => -3.932659661,
					    -2.836776058);

 
	hr_connection_bm := StringLib.StringToLowerCase(le.ip2o.ipconnection) in ['satellite','wireless'] or (integer)le.ip2o.iproutingmethod = 2;
	
	
	/****************************** verification **********************************************************/
	add1_source_level_bm := map(le.bill_to_out.address_verification.input_address_information.source_count = 0 => 0,
						   le.bill_to_out.address_verification.input_address_information.source_count <= 5 => 1,
						   2);

	nas_summary_bm := if(le.bill_to_out.iid.nas_summary > 2, 8, le.bill_to_out.iid.nas_summary);

	verx_bm := map(le.bill_to_out.iid.nap_summary >= 10 and nas_summary_bm >= 2 => 1,
				le.bill_to_out.iid.nap_summary >=  3 and nas_summary_bm  = 8 => 2,
				le.bill_to_out.iid.nap_summary  =  0 and nas_summary_bm  = 8 => 3,
				le.bill_to_out.iid.nap_summary >=  3 and nas_summary_bm  = 2 => 4,
				le.bill_to_out.iid.nap_summary >= 10 and nas_summary_bm <= 1 => 5,
				le.bill_to_out.iid.nap_summary  =  1 and nas_summary_bm  = 8 => 6,
				le.bill_to_out.iid.nap_summary  =  0 and nas_summary_bm  = 2 => 7,
				le.bill_to_out.iid.nap_summary  =  1 and nas_summary_bm  = 2 => 8,
				le.bill_to_out.iid.nap_summary >=  3 and nas_summary_bm <= 1 => 9,
				10);

	verx2_bm := if(phone_verified and verx_bm <> 5, verx_bm - 1, verx_bm);
	verx3_bm := if(add1_source_level_bm = 2 and verx2_bm <= 4, 0, verx2_bm);

	verx3_bm_l := map(verx3_bm = 0 => -5.028850267,
				   verx3_bm = 1 => -4.886331041,
				   verx3_bm = 2 => -3.947102226,
				   verx3_bm = 3 => -3.8705429,
				   verx3_bm = 4 => -3.382333707,
				   verx3_bm = 5 => -3.572345638,
				   verx3_bm = 6 => -3.447182495,
				   verx3_bm = 7 => -3.045572307,
				   verx3_bm = 8 => -3.042778758,
				   verx3_bm = 9 => -2.127821113,
				   -1.402657218);


	/******************************  phone ***************************************************/
	phnprob_bm := map((pnotpots = 0 and phnzip = 0) or ~le.bill_to_out.input_validation.homephone => 0,
				   pnotpots  = 0 and phnzip = 1 => 1,
				   pnotpots  = 1 and phnzip = 0 => 1,
				   2);

	/******************************  census ***************************************************/
	add1_census_income2_bm := if((integer)le.bill_to_out.address_verification.input_address_information.census_income<>0, 
															Min(Max((integer)le.bill_to_out.address_verification.input_address_information.census_income, 20000), 150000), 37500);

	add1_census_income2_bm_log := log(add1_census_income2_bm + 1) / .434294481903;

	/******************************  naprop ***************************************************/
	property_owned_total_bm_c := Min(le.bill_to_out.address_verification.owned.property_total, 10);

	naproptree_bm := map(le.bill_to_out.address_verification.input_address_information.naprop  = 4 and le.bill_to_out.address_verification.address_history_1.naprop >= 2 => 1,
					 le.bill_to_out.address_verification.input_address_information.naprop >= 2 and le.bill_to_out.address_verification.address_history_1.naprop  = 4 => 1,
					 le.bill_to_out.address_verification.input_address_information.naprop >= 2 and le.bill_to_out.address_verification.address_history_1.naprop >= 2 => 2,
					 le.bill_to_out.address_verification.input_address_information.naprop >= 2 and le.bill_to_out.address_verification.address_history_1.naprop  = 1 => 2,
					 le.bill_to_out.address_verification.input_address_information.naprop  = 4 and le.bill_to_out.address_verification.address_history_1.naprop  = 0 => 2,
					 le.bill_to_out.address_verification.input_address_information.naprop  = 3 and le.bill_to_out.address_verification.address_history_1.naprop  = 0 => 4,
					 le.bill_to_out.address_verification.input_address_information.naprop <= 1 and le.bill_to_out.address_verification.address_history_1.naprop  = 4 => 4,
					 le.bill_to_out.address_verification.input_address_information.naprop <= 1 and le.bill_to_out.address_verification.address_history_1.naprop >= 2 => 5,
					 le.bill_to_out.address_verification.input_address_information.naprop <= 1 and le.bill_to_out.address_verification.address_history_1.naprop  = 1 => 6,
					 le.bill_to_out.address_verification.input_address_information.naprop  = 3 and le.bill_to_out.address_verification.address_history_1.naprop  = 0 => 6,
					 le.bill_to_out.address_verification.input_address_information.naprop  = 2 and le.bill_to_out.address_verification.address_history_1.naprop  = 0 => 6,
					 le.bill_to_out.address_verification.input_address_information.naprop  = 0 and le.bill_to_out.address_verification.address_history_1.naprop  = 0 => 7,
					 8);
	/********************************************************************************************************/

	/******************************  rel  ***************************************************/
	rel_count_bm := Min(le.bill_to_out.relatives.owned.relatives_property_count, 30);                     

	rel_dist_bm := map(rel_count_bm = 0 => 1000,
				    le.bill_to_out.relatives.relative_within25miles_count > 0 => 25,
				    le.bill_to_out.relatives.relative_within100miles_count > 0 => 100,
				    le.bill_to_out.relatives.relative_within500miles_count > 0 => 100,
				    le.bill_to_out.relatives.relative_withinother_count > 0 => 501,
				    25);

	rel_dist_bm_flag := if(rel_dist_bm = 25, 1, 0);

	/********************************************************************************************************/

	/******************************  score code ***************************************************/
	cbd_billto_score1 := 10.628110145
					   + acquisition_phone  * 0.7386282067
					   + dpo_c_bm  * 0.0006312427
					   + cvv2match  * -0.645673663
					   + laptop  * 0.6188025616
					   + next_day_shipping  * 1.8542712978
					   + (integer)existing_cust_bm  * -4.277337544
					   + avs_match_level_bm_l  * 0.8993777894
					   + ip_geo_location2_bm_m  * 7.1254070586
					   + domain_risk_bm  * -0.086210238
					   + email_provider_risk_bm  * -0.444950866
					   + (integer)hr_connection_bm  * 1.769679072
					   + email_score_bm_l  * 0.5128834613
					   + verx3_bm_l  * 0.5363071925
					   + phnprob_bm  * 0.3655133811
					   + add1_census_income2_bm_log  * -0.80358143
					   + naproptree_bm  * 0.0984928254
					   + rel_dist_bm_flag  * -0.65579559;
     
     cbd_billto_score2 := (exp(cbd_billto_score1)) / (1+exp(cbd_billto_score1));

     base := 720;
     odds := .0476;
     point := -20;
     cbd_billto_score3 := Min((integer)(point*(log(cbd_billto_score2/(1-cbd_billto_score2)) - log(odds))/log(2) + base), 999);
	cbd_billto_score := if(cbd_billto_score3 < 250, 250, cbd_billto_score3);
	
	/********************************************************************************************************
	** CBD Model, Ship To Consumers Segment
	********************************************************************************************************/

	/******************************  customer data  ***************************************************/
	avs_match_level2_sm := if(AVS_match or AVS_zip_match or AVS_partial_match, 1, 2); 

	noitemsord_c_sm := Min((integer)ri.numitems, 3);

	dpo_c_sm := if(dpo = -99, 400, Min(dpo, 3000));

	cvv2match_sm := map(ccresp = 'M' => 1,
					ccresp in ['P','S','','NULL'] => 0,
					ccresp in ['N','U'] => -1,
					0);

	cvv2match_sm_m := map(cvv2match_sm = -1 => 0.1524064171,
					  cvv2match_sm = 0 => 0.0751944685,
					  0.0445895732);

	shiprisk_sm := map(next_day_shipping = 1 => 2,
				    second_day_shipping = 1 => 1,
				    0);

	shiprisk_sm_m := map(shiprisk_sm = 0 => 0.0360218314,
					 shiprisk_sm = 1 => 0.0461936438,
					 0.3317152104);

	desktop_sm :=  if(ri.prodcode='' or (integer)ri.prodcode = 0, 1, 0);

	days_since_first_sm := if(ri.orderdate <> '', Max(Min(days_since_first, 40), 30), -99);

	existing_cust_sm := days_since_first_sm > 30;

	/********** ip data ***************/
	state_match_s := StringLib.StringToUpperCase(le.ip2o.state) = StringLib.StringToUpperCase(le.ship_to_out.shell_input.in_state);
	state_match_st := StringLib.StringToUpperCase(le.bill_to_out.shell_input.in_state) = StringLib.StringToUpperCase(le.ship_to_out.shell_input.in_state);

	ip_geo_location_sm := map(~ip_pop => 0,
						 ~na_flag and ~(dot_mil or dot_gov) => 6,
						 ~us_flag and ~(dot_mil or dot_gov) => 5,
						 aol_domain => 2.5,
						 state_match => 1,
						 state_match_st => 2,
						 state_match_s => 3,
						 4);

	ip_geo_location_sm_l := map(ip_geo_location_sm = 0 => -2.717024487,
						   ip_geo_location_sm = 1 => -4.183898999,
						   ip_geo_location_sm = 2 => -3.928359425,
						   ip_geo_location_sm = 2.5 => -2.498699972,
						   ip_geo_location_sm = 3 => -1.869827843,
						   ip_geo_location_sm = 4 => -1.517870719,
						   ip_geo_location_sm = 5 => -0.336472237,
						   -0.026668247);


	email_provider2_sm := if(email_provider not in ['YAHOO.COM','HOTMAIL.COM','MSN.COM','AOL.COM','GMAIL.COM','SBCGLOBAL.NET','COMCAST.NET'], 'UNCOMMON',	trim(email_provider[1..25]));    

	email_provider_risk_sm := map(~ip_pop => 0,
							email_provider2_sm = 'YAHOO.COM' => 4,
							email_provider2_sm in ['HOTMAIL.COM','MSN.COM','AOL.COM'] => 3,
							email_provider2_sm in ['GMAIL.COM','UNCOMMON'] => 2,
							1);

	email_provider_risk_sm_l := map(email_provider_risk_sm = 0 => -2.717024487,
							  email_provider_risk_sm = 1 => -5.991464547,
							  email_provider_risk_sm = 2 => -3.891245255,
							  email_provider_risk_sm = 3 => -2.706645706,
							  -1.764393098);
							  
	email_score_sm := map(le.eddo.efirstscore = '-1' or le.eddo.elastscore = '-1' => -1,
					  (integer)le.eddo.elastscore > 0 => 1,
					  (integer)le.eddo.efirstscore > 0 => 2,
					  3);

	email_score_sm_m := map(email_score_sm = -1 => 0.0619279455,
					    email_score_sm = 1 => 0.0174577196,
					    email_score_sm = 2 => 0.0282131661,
					    0.10657277);

	/******************************  verification  **********************************************************/
	nas_summary_sm := if(le.bill_to_out.iid.nas_summary > 2, 8, le.bill_to_out.iid.nas_summary);
	nas_summary_s_sm := if(le.ship_to_out.iid.nas_summary > 2, 8, le.ship_to_out.iid.nas_summary);

	nap_summary2_sm := map(le.bill_to_out.iid.nap_summary >= 9 => 5,
					   le.bill_to_out.iid.nap_summary =  0 => 0,
					   le.bill_to_out.iid.nap_summary =  3 => 0,
					   le.bill_to_out.iid.nap_summary =  1 => 2,
					   le.bill_to_out.iid.nap_summary =  8 => 3,
					   le.bill_to_out.iid.nap_summary =  3 => 1,
					   le.bill_to_out.iid.nap_summary =  5 => 1,
					   4); 

	verx_sm := map(nap_summary2_sm < 4 and nas_summary_sm = 2 => 4.5,
				nap_summary2_sm < 4 and nas_summary_sm = 8 => 6,
				nap_summary2_sm > 3 and nas_summary_sm > 0 => 7,
				nap_summary2_sm);

	add1_source_level_sm := map(le.bill_to_out.address_verification.input_address_information.source_count = 0 => 0,
						   le.bill_to_out.address_verification.input_address_information.source_count <= 5 => 1,
						   2);

	nap_summary_s2_sm := map(le.ship_to_out.iid.nap_summary  = 12 => 5,
						le.ship_to_out.iid.nap_summary >=  9 => 4,
						le.ship_to_out.iid.nap_summary >=  3 => 3,
						le.ship_to_out.iid.nap_summary  =  1 => 2,
						1);

	verx_s_sm := map(nap_summary_s2_sm <= 2 and nas_summary_s_sm <= 1 => 1,
				  nap_summary_s2_sm  = 3 and nas_summary_s_sm <= 1 => 2,
				  nap_summary_s2_sm >= 4 and nas_summary_s_sm <= 1 => 3,
				  nap_summary_s2_sm <= 2 and nas_summary_s_sm  = 2 => 3,
				  nap_summary_s2_sm <= 3 and nas_summary_s_sm  = 8 => 3,
				  nap_summary_s2_sm  = 3 and nas_summary_s_sm  = 2 => 4,
				  nap_summary_s2_sm  = 4 and nas_summary_s_sm >= 2 => 5,
				  6);

	verx_s2_sm := map(verx_s_sm = 3 and ~phone_verified_s => 4,
				   verx_s_sm = 4 and ~phone_verified_s => 3,
				   verx_s_sm = 2 and phone_verified_s => 5,
				   verx_s_sm = 3 and phone_verified_s => 5,
				   verx_s_sm = 4 and phone_verified_s => 6,
				   verx_s_sm = 5 and phone_verified_s => 6,
				   verx_s_sm = 6 and phone_verified_s => 7,
				   verx_s_sm);


	verx_sm_m := map(verx_sm = 0 => 0.2030981067,
				  verx_sm = 1 => 0.1366906475,
				  verx_sm = 2 => 0.1,
				  verx_sm = 3 => 0.1067961165,
				  verx_sm = 4 => 0.0808080808,
				  verx_sm = 4.5 => 0.0626477541,
				  verx_sm = 5 => 0.0526315789,
				  verx_sm = 6 => 0.0503933659,
				  0.025766555);

	verx_s2_sm_l := map(verx_s2_sm = 1 => -1.844428415,
					verx_s2_sm = 2 => -2.233592222,
					verx_s2_sm = 3 => -2.905875944,
					verx_s2_sm = 4 => -3.157000421,
					verx_s2_sm = 5 => -3.488501114,
					verx_s2_sm = 6 => -4.786380014,
					-5.645446898);
	/********************************************************************************************************/

	/******************************  phone ***************************************************/
	phnprob_sm := map((pnotpots = 0 and phnzip = 0) or ~le.bill_to_out.input_validation.homephone => 0,
				   pnotpots = 0 and phnzip = 1 => 1,
				   pnotpots = 1 and phnzip = 0 => 1,
				   2);

	/********** Ship To *************/
	phnprob_s_sm := map((pnotpots_s = 0 and phnzip_s = 0 and disconnect_flag_s = 0) or ~le.ship_to_out.input_validation.homephone => 0,
					pnotpots_s = 1 and phnzip_s = 0 and disconnect_flag_s = 0 => 1,
					pnotpots_s = 0 and phnzip_s > 0  or disconnect_flag_s > 0 => 2,		
					3);


	phonex_sm := map(phnprob_sm  = 0 and phnprob_s_sm  = 0 => 0,
				  phnprob_sm <= 2 and phnprob_s_sm  = 0 => 1,
				  phnprob_sm  = 0 and phnprob_s_sm <= 2 => 2,
				  phnprob_sm  = 1 and phnprob_s_sm  = 1 => 3,
				  phnprob_sm <= 1 and phnprob_s_sm >= 2 => 4,
				  5);

	phonex_sm_m := map(phonex_sm = 0 => 0.0183760684,
				    phonex_sm = 1 => 0.049771167,
				    phonex_sm = 2 => 0.0663117135,
				    phonex_sm = 3 => 0.0694380996,
				    phonex_sm = 4 => 0.1767955801,
				    0.2283950617);


	/******************************  census Ship To ***************************************************/
	add1_census_age2_s_sm := if((integer)le.ship_to_out.address_verification.input_address_information.census_age<>0, 
														Min(Max((integer)le.ship_to_out.address_verification.input_address_information.census_age, 18), 65), 37);
	/********************************************************************************/

	/********************************************************************************/
	add1_census_income2_s_sm := if((integer)le.ship_to_out.address_verification.input_address_information.census_income<>0, 
														Min(Max((integer)le.ship_to_out.address_verification.input_address_information.census_income, 20000), 200000), 70000);

	/********************************************************************************/

	/********************************************************************************/
	add1_census_education2_s_sm := if((integer)le.ship_to_out.address_verification.input_address_information.census_education<>0, 
														Min(Max((integer)le.ship_to_out.address_verification.input_address_information.census_education, 9), 16), 14);
	/********************************************************************************************************/

	/********************************************************************************/
	cenmod_sm := 3.0108850324
				   + add1_census_age2_s_sm  * -0.072452239
				   + add1_census_income2_s_sm  * -0.000014427
				   + add1_census_education2_s_sm  * -0.201574118;
	/********************************************************************************************************/

	/******************************  naprop ***************************************************/
	best_match_level_sm := map(le.bill_to_out.address_verification.input_address_information.isbestmatch => 2,
						  le.bill_to_out.address_verification.address_history_1.isbestmatch => 1,
						  0);

	add1_naprop_sm := if(le.bill_to_out.address_verification.input_address_information.naprop = 3, 2, le.bill_to_out.address_verification.input_address_information.naprop);  
	add1_naprop_s_sm := if(le.ship_to_out.address_verification.input_address_information.naprop = 3, 2, le.ship_to_out.address_verification.input_address_information.naprop);  

	add1_proptree_sm := map(add1_naprop_sm >= 2 and add1_naprop_s_sm = 4 => 1,
					    add1_naprop_sm  = 0 and add1_naprop_s_sm = 4 => 1,
					    add1_naprop_sm  = 1 and add1_naprop_s_sm = 4 => 2,
					    add1_naprop_sm >= 2 and add1_naprop_s_sm = 2 => 3,
					    add1_naprop_sm  = 0 and add1_naprop_s_sm = 2 => 3,
					    add1_naprop_sm  = 1 and add1_naprop_s_sm = 2 => 4,
					    add1_naprop_sm >= 2 and add1_naprop_s_sm = 1 => 4,
					    add1_naprop_sm >= 2 and add1_naprop_s_sm = 0 => 5,
					    add1_naprop_sm  = 0 and add1_naprop_s_sm = 0 => 5,
					    add1_naprop_sm  = 0 and add1_naprop_s_sm = 1 => 6,
					    add1_naprop_sm  = 1 and add1_naprop_s_sm = 1 => 7,
					    8);

	proptree_sm := map(add1_proptree_sm  = 1 and best_match_level_sm >= 0 => 1,
				    add1_proptree_sm  = 2 and best_match_level_sm >= 1 => 1,
				    add1_proptree_sm  = 3 and best_match_level_sm >= 1 => 2,
				    add1_proptree_sm  = 4 and best_match_level_sm >= 1 => 3,
				    add1_proptree_sm  = 5 and best_match_level_sm >= 1 => 4,
				    add1_proptree_sm  = 6 and best_match_level_sm  = 2 => 5,
				    add1_proptree_sm >= 7 and best_match_level_sm  = 2 => 6,
				    add1_proptree_sm <= 4 and best_match_level_sm  = 0 => 6,
				    add1_proptree_sm >= 6 and best_match_level_sm  = 1 => 7,
				    add1_proptree_sm <= 6 and best_match_level_sm  = 0 => 8,
				    add1_proptree_sm  = 7 and best_match_level_sm  = 0 => 9,
				    10);

	proptree_sm_l := map(proptree_sm = 1 => -4.692313133,
					 proptree_sm = 2 => -3.921973336,
					 proptree_sm = 3 => -3.084894893,
					 proptree_sm = 4 => -2.859490444,
					 proptree_sm = 5 => -2.885529133,
					 proptree_sm = 6 => -2.459716401,
					 proptree_sm = 7 => -2.386862852,
					 proptree_sm = 8 => -1.873370805,
					 proptree_sm = 9 => -1.348554033,
					 -1.222226245);

	/******************************  relatives  ***************************************************/
	rel_prop_owned_count_s_i_sm := (integer)(le.ship_to_out.relatives.owned.relatives_property_count > 0);

	/******************************  score code  ***************************************************/
	cbd_shipto_score1 := 2.9852014345
					   + avs_match_level2_sm  * 0.4273486542
					   + noitemsord_c_sm  * 0.2710760051
					   + dpo_c_sm  * 0.000802525
					   + desktop_sm  * -0.899575371
					   + (integer)existing_cust_sm  * -3.501947696
					   + cvv2match_sm_m  * 9.6401542928
					   + shiprisk_sm_m  * 6.7956826485
					   + ip_geo_location_sm_l  * 0.8975524585
					   + email_provider_risk_sm_l  * 0.6840557402
					   + email_score_sm_m  * 13.710311002
					   + verx_sm_m  * 2.9795898148
					   + verx_s2_sm_l  * 0.5699362205
					   + phonex_sm_m  * 6.5961336706
					   + cenmod_sm  * 0.7283801264
					   + proptree_sm_l  * 0.4056238214
					   + rel_prop_owned_count_s_i_sm  * -0.339953852;
     
     cbd_shipto_score2 := (exp(cbd_shipto_score1)) / (1+exp(cbd_shipto_score1));

	cbd_shipto_score3 := Min((integer)(point*(log(cbd_shipto_score2/(1-cbd_shipto_score2)) - log(odds))/log(2) + base), 999);
	cbd_shipto_score := if(cbd_shipto_score3 < 250, 250, cbd_shipto_score3);
	
	
	/********************************************************************************************************
	** CBD Model, Business Segment
	********************************************************************************************************/

	/********** customer data ***************/
	avs_match_level_bus := map(AVS_match => 0,
						  AVS_zip_match => 0,
						  AVS_partial_match => 0,
						  AVS_addr_match => 1,
						  AVS_no_match => 2,
						  AVS_name_only_match => 2,
						  AVS_unavailable => 4,
						  3);

	acquisition_phone_bus := if((integer)ri.channel = 2, 1, 0);

	noitemsord_bus_c := Min((integer)ri.numitems, 4);

	cvv2match_bus := map(ccresp = 'M' => 1,
					 ccresp in ['P','S','','NULL'] => 0,
					 -1);

	days_since_first_bus := if(ri.orderdate <> '', Max(Min(days_since_first, 34), 0), -99);

	existing_cust_bus := days_since_first >= 30;

	/********** ip  data ***************/
	ip_geo_location_bus := map(~ip_pop => 1.5,
						  ~us_flag and ~(dot_mil or dot_gov) => 4,
						  aol_domain => 2.5,
						  state_match => 1,
						  state_match_st => 2,
						  state_match_s => 2,
						  3);


	ip_geo_location_bus_l := map(ip_geo_location_bus = 1 => -5.036581476,
						    ip_geo_location_bus = 1.5 => -4.272775646,
						    ip_geo_location_bus = 2 => -3.786081782,
						    ip_geo_location_bus = 2.5 => -3.423176288,
						    ip_geo_location_bus = 3 => -2.708050201,
						    -0.647684806);

	domain2_bus := if(trim(StringLib.StringToUpperCase(le.ip2o.domain)) not in ['OPTONLINE.NET','AOL.COM','SWBELL.NET','','COMCAST.NET','AMERITECH.NET',
																 'CHARTER.COM', 'COX.NET', 'RR.COM', 'VERIZON.NET', 'PACBELL.NET', 'SPRINT-HSD.NET',
																 'QWEST.NET', 'BELLSOUTH.NET', 'MINDSPRING.COM', 'ADELPHIA.NET', 'XO.NET', 'COVAD.NET'], 'UNCOMMON',
					   trim(StringLib.StringToUpperCase(le.ip2o.domain[1..100])));
	
	domain_risk_bus := map(domain2_bus = 'OPTONLINE.NET' => 5, 
					   domain2_bus in ['AOL.COM','SWBELL.NET'] => 4,
					   domain2_bus in ['','COMCAST.NET','AMERITECH.NET','CHARTER.COM','COX.NET','UNCOMMON'] => 3,
					   domain2_bus in ['RR.COM','VERIZON.NET','PACBELL.NET','SPRINT-HSD.NET'] => 2,
					   1);

	domain_risk_bus_m := map(domain_risk_bus = 1 => 0,
						domain_risk_bus = 2 => 0.0041666667,
						domain_risk_bus = 3 => 0.0149961217,
						domain_risk_bus = 4 => 0.0321285141,
						0.1073446328);
						
	atPosBus := StringLib.StringFind(le.bill_to_out.shell_input.email_address, '@', 1);
	lenEmailBus := length(trim(le.bill_to_out.shell_input.email_address));
	email_provider_bus1 := if(StringLib.StringFind(le.bill_to_out.shell_input.email_address, '.', 1) > 0, StringLib.StringToUpperCase(le.bill_to_out.shell_input.email_address[atPosBus+1..lenEmailBus]), '');					

	email_provider_bus := if(email_provider_bus1 not in ['YAHOO.COM','MSN.COM','HOTMAIL.COM','','AOL.COM','UNCOMMON','GMAIL.COM','EARTHLINK.NET',
											   'VERIZON.NET','BELLSOUTH.NET','COX.NET','SBCGLOBAL.NET','COMCAST.NET'], 'UNCOMMON', email_provider_bus1);

	email_provider_risk_bus := map(email_provider_bus = 'YAHOO.COM' => 5, 
							 email_provider_bus in ['MSN.COM','HOTMAIL.COM'] => 4,
							 email_provider_bus in ['','AOL.COM'] => 3,
							 email_provider_bus = 'UNCOMMON' => 2,
							 1);
	/********************************************************************************************************/

	/******************************  verification  **********************************************************/
	nas_summary_bus := if(le.bill_to_out.iid.nas_summary > 2, 8, le.bill_to_out.iid.nas_summary);

	verx_bus := map(le.bill_to_out.iid.nap_summary >= 10 and nas_summary_bus >= 0 => 1,
				 phone_verified and nas_summary_bus >= 0 => 1,
				 le.bill_to_out.iid.nap_summary > 1 and nas_summary_bus >= 2 => 2,
				 le.bill_to_out.iid.nap_summary = 1 and nas_summary_bus >= 2 => 2,
				 le.bill_to_out.iid.nap_summary = 0 and nas_summary_bus  = 8 => 2,
				 le.bill_to_out.iid.nap_summary = 0 and nas_summary_bus  = 2 => 3,
				 le.bill_to_out.iid.nap_summary = 1 and nas_summary_bus <= 1 => 4,
				 5);

	verx_s_bus := map(~shipto_order => 0,
				   le.ship_to_out.iid.nap_summary >= 10 => 1,
				   phone_verified_s => 2,
				   le.ship_to_out.iid.nap_summary >= 1 => 3,
				   4);

	verx_comb_bus := map(verx_bus  = 1 and verx_s_bus = 0 => 2,
					 verx_bus <= 3 and verx_s_bus = 0 => 4,
					 verx_bus  = 4 and verx_s_bus = 0 => 6,
					 verx_bus  = 5 and verx_s_bus = 0 => 7,
					 verx_bus >= 1 and verx_s_bus = 1 => 1,
					 verx_bus <= 2 and verx_s_bus = 2 => 1,
					 verx_bus >= 3 and verx_s_bus = 2 => 3,
					 verx_bus <= 3 and verx_s_bus = 3 => 3,
					 verx_bus >= 4 and verx_s_bus = 3 => 4,
					 5);
	/********************************************************************************************************/

	/******************************  phone ***************************************************/
	phnprob_bus := map(~le.bill_to_out.input_validation.homephone => 0,
				    pnotpots = 0 and phnzip = 0 => 0,
				    pnotpots = 1 and phnzip = 0 => 1,
				    pnotpots = 0 and phnzip = 1 => 2,
				    3);

	phnprob_bus_m := map(phnprob_bus = 0 => 0.0064961023,
					 phnprob_bus = 1 => 0.0383903793,
					 phnprob_bus = 2 => 0.0396643783,
					 0.0526315789);
	/********************************************************************************************************/

	/****************************** census ***************************************************/

	/********************************************************************************/
	add1_census_home_value2_bus := if((integer)le.bill_to_out.address_verification.input_address_information.census_home_value<>0, 
													Min(Max((integer)le.bill_to_out.address_verification.input_address_information.census_home_value, 100000), 350000), 250000);

	/********************************************************************************************************/

	/******************************  census Ship To ***************************************************/
	add1_census_age2_s_bus := if((integer)le.ship_to_out.address_verification.input_address_information.census_age<>0, 
													Min(Max((integer)le.ship_to_out.address_verification.input_address_information.census_age, 28), 55), 35);
	/********************************************************************************/

	/********************************************************************************/
	add1_census_education2_s_bus := if((integer)le.ship_to_out.address_verification.input_address_information.census_education<>0, 
													Min(Max((integer)le.ship_to_out.address_verification.input_address_information.census_education, 11), 17), 12.5);
	/********************************************************************************************************/

	/******************************  score code ***************************************************/
	cbd_business_score1 := -2.763491406
						   + avs_match_level_bus  * 0.8246793572
						   + acquisition_phone_bus  * -0.550264962
						   + noitemsord_bus_c  * 0.3665722978
						   + cvv2match_bus  * -0.551370476
						   + laptop  * 1.6345081007
						   + next_day_shipping  * 2.0306726196
						   + second_day_shipping  * 0.9517702307
						   + (integer)existing_cust_bus  * -3.649182354
						   + email_provider_risk_bus  * 0.8625406798
						   + ip_geo_location_bus_l  * 0.6744595442
						   + domain_risk_bus_m  * 29.545667045
						   + verx_comb_bus  * 0.3879825302
						   + phnprob_bus_m  * 18.142604192
						   + add1_census_home_value2_bus  * -4.083434E-6
						   + add1_census_age2_s_bus  * -0.045460594
						   + add1_census_education2_s_bus  * -0.259351121;
	
	cbd_business_score2 := (exp(cbd_business_score1)) / (1+exp(cbd_business_score1));
	
	cbd_business_score3 := Min((integer)(point*(log(cbd_business_score2/(1-cbd_business_score2)) - log(odds))/log(2) + base), 999);
	cbd_business_score := if(cbd_business_score3 < 250, 250, cbd_business_score3);

	cbd_score := map(consumer and shipto_order => cbd_shipto_score,
				  consumer and ~shipto_order => cbd_billto_score,
				  cbd_business_score);



	/***********************************************************************************************************
	** Global Code - Used by all models
	***********************************************************************************************************/

	/***********************************************************************************************************
	** Bill To Model, Consumers
	***********************************************************************************************************/

	/******************************  verification  **********************************************************/
	best_match_level_bt_con := map(le.bill_to_out.address_verification.input_address_information.isbestmatch => 2,
							 le.bill_to_out.address_verification.address_history_1.isbestmatch => 1,
							 0);

	nas_summary_bt_con := if(le.bill_to_out.iid.nas_summary > 2, 8, le.bill_to_out.iid.nas_summary);

	verx_bt_con := map(le.bill_to_out.iid.nap_summary >= 10 and nas_summary_bt_con >= 2 => 1,
				    le.bill_to_out.iid.nap_summary >=  3 and nas_summary_bt_con  = 8 => 2,
				    le.bill_to_out.iid.nap_summary  =  0 and nas_summary_bt_con  = 8 => 2,
				    le.bill_to_out.iid.nap_summary >=  3 and nas_summary_bt_con  = 2 => 3,
				    le.bill_to_out.iid.nap_summary >= 10 and nas_summary_bt_con <= 1 => 4,
				    le.bill_to_out.iid.nap_summary  =  1 and nas_summary_bt_con  = 8 => 5,
				    le.bill_to_out.iid.nap_summary  =  0 and nas_summary_bt_con  = 2 => 6,
				    le.bill_to_out.iid.nap_summary  =  1 and nas_summary_bt_con  = 2 => 6,
				    le.bill_to_out.iid.nap_summary >=  3 and nas_summary_bt_con <= 1 => 7,
				    le.bill_to_out.iid.nap_summary  =  1 and nas_summary_bt_con <= 1 => 8,
				    9);

	verx2_bt_con := if(phone_verified, verx_bt_con - 1, verx_bt_con);

	verx2_bt_con_l := map(verx2_bt_con = 0 => -5.055769473,
					  verx2_bt_con = 1 => -4.835399684,
					  verx2_bt_con = 2 => -3.927540285,
					  verx2_bt_con = 3 => -3.63363098,
					  verx2_bt_con = 5 => -3.345718229,
					  verx2_bt_con = 6 => -2.986032876,
					  verx2_bt_con = 7 => -2.178242126,
					  verx2_bt_con = 8 => -1.632361552,
					  -1.409804741);
	/********************************************************************************************************/

	/****************************** phone ***************************************************/
	phnprob_bt_con := map((pnotpots  = 0 and phnzip = 0) or ~le.bill_to_out.input_validation.homephone => 0,
					  pnotpots  = 1 and phnzip = 0 => 1,
					  pnotpots  = 0 and phnzip = 1 => 2,
					  3);

	/****************************** address ***************************************************/
	addprob_bt_con := map(best_match_level_bt_con = 2 and le.bill_to_out.address_validation.usps_deliverable and ~apt_flag => 0, 
					  best_match_level_bt_con = 2 => 2, 
					  best_match_level_bt_con = 1 and le.bill_to_out.address_validation.usps_deliverable and ~apt_flag => 1, 
					  best_match_level_bt_con = 1 => 3,
					  best_match_level_bt_con = 0 and le.bill_to_out.address_validation.usps_deliverable and ~apt_flag => 4,
					  5); 

	addprob_bt_con_l := map(addprob_bt_con = 0 => -4.481971778,
					    addprob_bt_con = 1 => -3.664371035,
					    addprob_bt_con = 2 => -3.373891931,
					    addprob_bt_con = 3 => -3.204620858,
					    addprob_bt_con = 4 => -2.276656598,
					    -1.810690257);
	/********************************************************************************************************/

	/****************************** census ***************************************************/
	add1_census_age_bt_con := if((integer)le.bill_to_out.address_verification.input_address_information.census_age<>0, 
													Min(Max((integer)le.bill_to_out.address_verification.input_address_information.census_age, 18), 35), 35);

	census_age_bt_con_flag2 := add1_census_age_bt_con > 31;
	/********************************************************************************/

	/********************************************************************************/
	add1_census_income_bt_con := if((integer)le.bill_to_out.address_verification.input_address_information.census_income<>0, 
													Min(Max((integer)le.bill_to_out.address_verification.input_address_information.census_income, 10000), 70000), 35000);

	add1_census_income_bt_con_ln := log(add1_census_income_bt_con + 1) / .434294481903;
	/********************************************************************************/

	/********************************************************************************/
	add1_census_education_bt_con := if((integer)le.bill_to_out.address_verification.input_address_information.census_education<>0, 
													Min(Max((integer)le.bill_to_out.address_verification.input_address_information.census_education, 10), 14), 13.5);
	/********************************************************************************************************/

	/******************************  misc ***************************************************/
	phad_dist_level_bt_con := map(trim(le.eddo.distphoneaddr) = '' => 1,
							(integer)le.eddo.distphoneaddr =  0 => 0,
							(integer)le.eddo.distphoneaddr >= 55 => 2,
							1);

	phad_dist_level_bt_con_m := map(phad_dist_level_bt_con = 0 => 0.0094320173,
							  phad_dist_level_bt_con = 1 => 0.0428567055,
							  0.1608187135);

	billto_score_con1 := 5.5962487865
					   + verx2_bt_con_l  * 0.6230594698
					   + phnprob_bt_con  * 0.3773897456
					   + addprob_bt_con_l  * 0.3372872005
					   + add1_census_income_bt_con_ln  * -0.419380829
					   + add1_census_education_bt_con  * -0.132312311
					   + (integer)census_age_bt_con_flag2  * -0.194236049
					   + phad_dist_level_bt_con_m  * 9.5828765972;
	
	billto_score_con2 := (exp(billto_score_con1)) / (1+exp(billto_score_con1));
	billto_score_con := (integer)(point*(log(billto_score_con2/(1-billto_score_con2)) - log(odds))/log(2) + base);
	/********************************************************************************************************/

	/***********************************************************************************************************
	** Bill To Model, Business
	***********************************************************************************************************/

	/******************************  verification  **********************************************************/
	best_match_level2_bt_bus := if(le.bill_to_out.address_verification.input_address_information.isbestmatch or le.bill_to_out.address_verification.address_history_1.isbestmatch, 1, 0);

	nas_summary_bt_bus := if(le.bill_to_out.iid.nas_summary > 2, 8, le.bill_to_out.iid.nas_summary);

	verx_bt_bus := map(le.bill_to_out.iid.nap_summary >= 10 and nas_summary_bt_bus >=  0 => 1,
				    le.bill_to_out.iid.nap_summary >=  3 and nas_summary_bt_bus >=  0 => 2,
				    le.bill_to_out.iid.nap_summary >=  0 and nas_summary_bt_bus  =  8 => 2,
				    le.bill_to_out.iid.nap_summary  =  1 and nas_summary_bt_bus  =  2 => 2,
				    le.bill_to_out.iid.nap_summary  =  0 and nas_summary_bt_bus  =  2 => 3,
				    le.bill_to_out.iid.nap_summary  =  1 and nas_summary_bt_bus <=  1 => 4,
				    5);

	verx2_bt_bus := if(verx_bt_bus = 2 and phone_verified, 1, verx_bt_bus);


	verx_bt_bus_m := map(verx_bt_bus = 1 => 0.0058027079,
					 verx_bt_bus = 2 => 0.0091085742,
					 verx_bt_bus = 3 => 0.0164083865,
					 verx_bt_bus = 4 => 0.0292134831,
					 0.0502890173);
	/********************************************************************************************************/

	/****************************** phone ***************************************************/
	phnprob_bt_bus := map(~le.bill_to_out.input_validation.homephone => 2,
					  pnotpots  = 0 and phnzip = 0 => 1,
					  pnotpots  = 1 and phnzip = 0 => 2,
					  pnotpots  = 0 and phnzip = 1 => 2,
					  3);

	phnprob_bt_bus_m := map(phnprob_bt_bus = 1 => 0.0063291139,
					    phnprob_bt_bus = 2 => 0.0388652482,
					    0.0526315789);
	/********************************************************************************************************/

	/****************************** census ***************************************************/
	add1_census_age_bt_bus := if((integer)le.bill_to_out.address_verification.input_address_information.census_age<>0, 
														Min(Max((integer)le.bill_to_out.address_verification.input_address_information.census_age, 30), 55), 35);
	/********************************************************************************/

	/********************************************************************************/
	add1_census_education_bt_bus := if((integer)le.bill_to_out.address_verification.input_address_information.census_education<>0, 
														Min(Max((integer)le.bill_to_out.address_verification.input_address_information.census_education, 10), 17), 14);
	/********************************************************************************************************/

	billto_score_bus1 := -0.072535073
					   + best_match_level2_bt_bus  * -0.677690784
					   + verx_bt_bus_m  * 19.469144654
					   + phnprob_bt_bus_m  * 50.282816127
					   + add1_census_age_bt_bus  * -0.032353455
					   + add1_census_education_bt_bus  * -0.307351598;
	
	billto_score_bus2 := (exp(billto_score_bus1)) / (1+exp(billto_score_bus1));
	billto_score_bus := (integer)(point*(log(billto_score_bus2/(1-billto_score_bus2)) - log(odds))/log(2) + base);
	
	billto_score := if(consumer, billto_score_con, billto_score_bus);

	/***********************************************************************************************************
	** Ship To Model, Consumers
	***********************************************************************************************************/

	/******************************  verification  **********************************************************/
	best_match_level_st_con := map(le.bill_to_out.address_verification.input_address_information.isbestmatch => 2,
							 le.bill_to_out.address_verification.address_history_1.isbestmatch => 1,
							 0);

	nas_summary_st_con := if(le.bill_to_out.iid.nas_summary > 2, 8, le.bill_to_out.iid.nas_summary);
	nas_summary_s_st_con := if(le.ship_to_out.iid.nas_summary > 2, 8, le.ship_to_out.iid.nas_summary);

	nap_summary2_st_con := map(le.bill_to_out.iid.nap_summary >= 9 => 5,
						  le.bill_to_out.iid.nap_summary =  0 => 0,
						  le.bill_to_out.iid.nap_summary =  2 => 0,
						  le.bill_to_out.iid.nap_summary =  1 => 2,
						  le.bill_to_out.iid.nap_summary =  8 => 3,
						  le.bill_to_out.iid.nap_summary =  3 => 1,
						  le.bill_to_out.iid.nap_summary =  5 => 1,
						  4);

	verx_st_con := map(nap_summary2_st_con < 4 and nas_summary_st_con = 2 => 4.5,
				    nap_summary2_st_con < 4 and nas_summary_st_con = 8 => 6,
				    nap_summary2_st_con > 3 and nas_summary_st_con > 0 => 7,
				    nap_summary2_st_con);

	ver_tree_st_con := map(best_match_level_st_con = 2 and le.bill_to_out.iid.nap_summary >= 10 and nas_summary_st_con >= 0 => 0,
					   best_match_level_st_con = 2 and le.bill_to_out.iid.nap_summary >=  3 and nas_summary_st_con >= 0 => 2,
					   3);

	verx_s_st_con := map(le.ship_to_out.iid.nap_summary  = 12 and nas_summary_s_st_con >= 2 => 0,
					 le.ship_to_out.iid.nap_summary >=  0 and nas_summary_s_st_con >= 2 => 1,
					 le.ship_to_out.iid.nap_summary >=  3 and nas_summary_s_st_con <= 1 => 2,
					 3);

	verx_s_2_st_con := if(phone_verified_s, verx_s_st_con - 2, verx_s_st_con);

	verx_st_con_m := map(verx_st_con = 0 => 0.1985559567,
					 verx_st_con = 1 => 0.1626506024,
					 verx_st_con = 2 => 0.1,
					 verx_st_con = 3 => 0.1067961165,
					 verx_st_con = 4 => 0.0808080808,
					 verx_st_con = 4.5 => 0.0626477541,
					 verx_st_con = 5 => 0.0526315789,
					 verx_st_con = 6 => 0.0503933659,
					 0.025766555);

	verx_s_2_st_con_l := map(verx_s_2_st_con = -2 => -5.645446898,
						verx_s_2_st_con = -1 => -4.499304492,
						verx_s_2_st_con = 0 => -3.534863174,
						verx_s_2_st_con = 1 => -3.118045058,
						verx_s_2_st_con = 2 => -2.233592222,
						-1.844428415);
	/********************************************************************************************************/

	/****************************** phone ***************************************************/
	phnprob_st_con := map((pnotpots = 0 and phnzip = 0) or ~le.bill_to_out.input_validation.homephone => 0,
					  pnotpots = 0 and phnzip = 1 => 1,
					  pnotpots = 1 and phnzip = 0 => 1,
					  2);

	/********** Ship To phone *************/
	phnprob_s_st_con := map((pnotpots_s = 0 and phnzip_s = 0 and disconnect_flag_s = 0) or ~le.ship_to_out.input_validation.homephone => 0,
					    pnotpots_s = 1 and phnzip_s = 0 and disconnect_flag_s = 0 => 1,
					    pnotpots_s = 0 and phnzip_s > 0 or disconnect_flag_s > 0 => 2,	
					    3);


	phonex_st_con := map(phnprob_st_con  = 0 and phnprob_s_st_con  = 0 => 0,
					 phnprob_st_con <= 2 and phnprob_s_st_con  = 0 => 1,
					 phnprob_st_con  = 0 and phnprob_s_st_con <= 2 => 2,
					 phnprob_st_con  = 1 and phnprob_s_st_con  = 1 => 3,
					 phnprob_st_con <= 1 and phnprob_s_st_con >= 2 => 4,
					 5);

	phonex_st_con_l := map(phonex_st_con = 0 => -3.978159087,
					   phonex_st_con = 1 => -2.949266991,
					   phonex_st_con = 2 => -2.644776087,
					   phonex_st_con = 3 => -2.595352895,
					   phonex_st_con = 4 => -1.538210403,
					   -1.217395825);
	/********************************************************************************************************/

	/****************************** address ***************************************************/
	addx_st_con := map(le.bill_to_out.address_validation.usps_deliverable and ~le.bill_to_out.address_verification.input_address_information.hr_address => 0,
				    le.bill_to_out.address_validation.usps_deliverable and le.bill_to_out.address_verification.input_address_information.hr_address => 1,
				    ~le.bill_to_out.address_validation.usps_deliverable and le.bill_to_out.address_verification.input_address_information.hr_address => 1,
				    2);

	addprob_st_con := map(best_match_level_st_con  = 2 and addx_st_con  = 0 => 0,
					  best_match_level_st_con  = 1 and addx_st_con  = 0 => 1,
					  best_match_level_st_con >= 1 and addx_st_con >= 1 => 2,
					  best_match_level_st_con  = 0 and addx_st_con  = 0 => 3,
					  best_match_level_st_con  = 0 and addx_st_con  = 1 => 4,
					  5);

	addprob_s_st_con := if(apt_flag_s and addprob_st_con < 4, addprob_st_con + 2, addprob_st_con);

	addprob_s_st_con_l := map(addprob_s_st_con = 0 => -3.354677366,
						 addprob_s_st_con = 1 => -3.294678788,
						 addprob_s_st_con = 2 => -2.649209701,
						 addprob_s_st_con = 3 => -2.449264958,
						 addprob_s_st_con = 4 => -1.857142228,
						 -1.433989235);

	/****************************** census Ship To ***************************************************/
	add1_census_age_s_st_con := if((integer)le.ship_to_out.address_verification.input_address_information.census_age<>0,
														Min(Max((integer)le.ship_to_out.address_verification.input_address_information.census_age, 18), 65), 37);
	/********************************************************************************/

	/********************************************************************************/
	add1_census_income_s_st_con := if((integer)le.ship_to_out.address_verification.input_address_information.census_income<>0, 
														Min(Max((integer)le.ship_to_out.address_verification.input_address_information.census_income, 20000), 200000), 70000);
	add1_census_income_s_st_con_ln := log(add1_census_income_s_st_con + 1) / .434294481903;
	/********************************************************************************/

	/********************************************************************************/
	add1_census_education_s_st_con := if((integer)le.ship_to_out.address_verification.input_address_information.census_education<>0, 
														Min(Max((integer)le.ship_to_out.address_verification.input_address_information.census_education, 9), 16), 14);
	/********************************************************************************************************/

	shipto_score_con1 := 12.86998428
					   + verx_st_con_m  * 3.5885293881
					   + verx_s_2_st_con_l  * 0.7208258723
					   + phonex_st_con_l  * 0.6605519938
					   + addprob_s_st_con_l  * 0.5579986103
					   + add1_census_age_s_st_con  * -0.048156682
					   + add1_census_income_s_st_con_ln  * -0.538719737
					   + add1_census_education_s_st_con  * -0.227878279;
	
	shipto_score_con2 := (exp(shipto_score_con1)) / (1+exp(shipto_score_con1));
	shipto_score_con3 := Min((integer)(point*(log(shipto_score_con2/(1-shipto_score_con2)) - log(odds))/log(2) + base), 999);
	shipto_score_con := if(shipto_score_con3 < 250, 250, shipto_score_con3);

	/***********************************************************************************************************
	** Ship To Model, Business
	***********************************************************************************************************/

	/******************************  verification  **********************************************************/
	verx_s2_st_bus := map(phone_verified_s => 1,
					  le.ship_to_out.iid.nap_summary = 0 => 3,
					  2);

	verx_s2_st_bus_m := map(verx_s2_st_bus = 1 => 0.0019120459,
					    verx_s2_st_bus = 2 => 0.0085763293,
					    0.0214088398);
	/********************************************************************************************************/

	/****************************** phone ***************************************************/
	/********** Ship To phone *************/
	phnprob_s_st_bus := map(~shipto_order => 0,
					    ~le.ship_to_out.input_validation.homephone => 4,
					    pnotpots_s = 0 and phnzip_s = 0 => 1,
					    pnotpots_s = 0 and phnzip_s = 1 => 2,
					    pnotpots_s = 1 and phnzip_s = 0 => 3,
					    4);
	
	/********************************************************************************************************/

	/********************************************************************************/
	add1_census_income_s_st_bus := if((integer)le.ship_to_out.address_verification.input_address_information.census_income<>0, 
													Min(Max((integer)le.ship_to_out.address_verification.input_address_information.census_income, 25000), 90000), 50000);
	/********************************************************************************/
	shipto_score_bus1 := -5.590477754
					   + verx_s2_st_bus_m  * 81.509242351
					   + phnprob_s_st_bus  * 0.452385903
					   + add1_census_income_s_st_bus  * -0.000020135;
	
	shipto_score_bus2 := (exp(shipto_score_bus1)) / (1+exp(shipto_score_bus1));
	shipto_score_bus3 := Min((integer)(point*(log(shipto_score_bus2/(1-shipto_score_bus2)) - log(odds))/log(2) + base), 999);
	shipto_score_bus := if(shipto_score_bus3 < 250, 250, shipto_score_bus3);
	
	shipto_score := if(consumer, shipto_score_con, shipto_score_bus);

	self.score := (string)cbd_score+(string)billto_score+(string)shipto_score;
	self.seq := le.bill_to_out.seq;
	self := [];
END;
model := JOIN(clam, indata, left.bill_to_out.seq = right.seq*2, doModel(left,right), left outer);


// need to project billto boca shell results into layout.output
Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
	self.seq := le.Bill_To_Out.seq;
	self.socllowissue := (string)le.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.Bill_To_Out.iid.NAS_summary;
	self.nxx_type := le.Bill_To_Out.phone_verification.telcordia_type;
	self := le.Bill_To_Out.iid;
	self := le.Bill_To_Out.shell_input;
	self := le.bill_to_out;
END;
iidBT := project(clam, into_layout_output(left));


temp_layout := RECORD
	RiskWise.Layout_IP2O ip;
	Risk_Indicators.Layout_EDDO eddo;
	business_risk.layout_biid_btst_output biid;
END;


temp_layout fill_ip(clam le, biid rt ) := TRANSFORM
	self.eddo := le.eddo;
	self.ip.countrycode := le.ip2o.countrycode[1..2];
	self.ip := le.ip2o;
	self.biid := rt;
END;
ipInfo := JOIN(clam, biid, left.bill_to_out.seq = right.bill_to_output.seq, fill_ip(left, right), left outer);


Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
	self.seq := le.seq;
	self.ri := if( isBusiness,
			RiskWise.cdReasonCodesBus(le, 6, rt, true, IBICID, rt.biid.Bill_to_output ),
			RiskWise.cdReasonCodesCon(le, 6, rt, true, IBICID )
	);
	self := [];
END;
BTReasons := join(iidBT, ipInfo, left.seq = right.ip.seq, addBTReasons(left, right), left outer);

Layout_ModelOut fillReasons(Layout_ModelOut le, BTreasons rt) := TRANSFORM
	self.ri := rt.ri;
	self := le;
END;
BTrecord := JOIN(model, BTReasons, left.seq = right.seq, fillReasons(left,right), left outer);


// need to project the shipto boca shell results into layout.output
Risk_Indicators.Layout_Output into_layout_output2(clam le) := TRANSFORM
	self.seq := le.Ship_To_Out.seq;
	self.socllowissue := (string)le.Ship_To_Out.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.Ship_To_Out.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.Ship_To_Out.iid.NAS_summary;
	self.nxx_type := le.Ship_To_Out.phone_verification.telcordia_type;
	self := le.Ship_To_Out.iid;
	self := le.Ship_To_Out.shell_input;
	self := le.ship_to_out;
END;
iidST := project(clam, into_layout_output2(left));


Layout_ModelOut addSTReasons(iidST le, ipInfo rt ) := TRANSFORM
	self.seq := le.seq;
	self.ri := if( isBusiness,
			RiskWise.cdReasonCodesBus(le, 6, rt, false, IBICID, rt.biid.Ship_to_output),
			RiskWise.cdReasonCodesCon(le, 6, rt, false, IBICID )
	);
	self := [];
END;

STReasons := join(iidST, ipInfo, left.seq=((right.ip.seq*2)-1), addSTReasons(left, right), left outer);


Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := TRANSFORM
	self.ri := le.ri + rt.ri;
	self := le;
END;
STRecord := JOIN(BTRecord, STReasons, ((left.seq*2)-1) = right.seq, fillReasons2(left,right), left outer);

RETURN (STRecord);

END;