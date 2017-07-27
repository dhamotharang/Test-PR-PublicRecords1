import riskwise, ut, address, risk_indicators;

export CDN706_1_0(dataset(riskwise.layouts.cdn706_variables) model_variables) := FUNCTION		


dell_reason_codes( layout, cnt, billTo) := MACRO
CHOOSEN(

	IF(billTo and Risk_Indicators.rcSet.isCodeIA(layout.indata.ipaddr, layout.ip_results.ipaddr<>''),
		DATASET([{'IA',risk_indicators.getHRIDesc('IA')}],risk_indicators.Layout_Desc)) &
		
	IF(billTo and Risk_Indicators.rcSet.isCodeIH(layout.ip_results.countrycode),
		DATASET([{'IH',risk_indicators.getHRIDesc('IH')}],risk_indicators.Layout_Desc)) &

	IF(Risk_Indicators.rcSet.isCode20(if(billto,layout.btnap_calc.combo_lastcount,layout.stnap_calc.combo_lastcount),
									  if(billto,layout.btnap_calc.combo_addrcount,layout.stnap_calc.combo_addrcount),
									  if(billto,layout.btnap_calc.combo_hphonecount,layout.stnap_calc.combo_hphonecount),
									   /*set ssn_count=0*/ 0 ),
		DATASET([{'20',risk_indicators.getHRIDesc('20')}],risk_indicators.Layout_Desc)) &
							
	IF(Risk_Indicators.rcSet.isCode22(if(billto,layout.indata.last,layout.indata.last2),
									  if(billto,layout.indata.in_addr,layout.indata.in_addr2),
									  if(billto,layout.btnap_calc.combo_lastcount,layout.stnap_calc.combo_lastcount),
									  if(billto,layout.btnap_calc.combo_addrcount,layout.stnap_calc.combo_addrcount),
									  if(billto,layout.btnap_calc.combo_hphonecount,layout.stnap_calc.combo_hphonecount)),
		DATASET([{'22',risk_indicators.getHRIDesc('22')}],risk_indicators.Layout_Desc)) &
			
			
	IF(Risk_Indicators.rcSet.isCode25(if(billto,layout.indata.in_addr,layout.indata.in_addr2), 
									  if(billto,layout.btnap_calc.combo_lastcount,layout.stnap_calc.combo_lastcount), 
									  if(billto,layout.btnap_calc.combo_addrcount,layout.stnap_calc.combo_addrcount),
									  if(billto,layout.btnap_calc.combo_hphonecount,layout.stnap_calc.combo_hphonecount), 
									  /*set ssn_count=0*/ 0 ),
		DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &


	IF(Risk_Indicators.rcSet.isCode21(if(billto,layout.indata.last,layout.indata.last2), 
									  if(billto,layout.indata.hphone,layout.indata.hphone2), 
									  if(billto,layout.btnap_calc.combo_lastcount,layout.stnap_calc.combo_lastcount), 
									  if(billto,layout.btnap_calc.combo_addrcount,layout.stnap_calc.combo_addrcount), 
									  if(billto,layout.btnap_calc.combo_hphonecount,layout.stnap_calc.combo_hphonecount)),
		DATASET([{'21',risk_indicators.getHRIDesc('21')}],risk_indicators.Layout_Desc)) &


	IF(billTo and Risk_Indicators.rcSet.isCodeIB_can(layout.indata.in_province, layout.ip_results.state, layout.ip_results.countrycode, layout.ip_results.ipaddr<>'', 
													 layout.ip_results.secondleveldomain, layout.ip_results.iptype),
		DATASET([{'IB',risk_indicators.getHRIDesc('IB')}],risk_indicators.Layout_Desc)) &

	IF(Risk_Indicators.rcSet.isCode37(if(billto,layout.indata.last,layout.indata.last2), 
									  if(billto,layout.btnap_calc.combo_lastcount,layout.stnap_calc.combo_lastcount), 
									  if(billto,layout.btnap_calc.combo_addrcount,layout.stnap_calc.combo_addrcount), 
									  if(billto,layout.btnap_calc.combo_hphonecount,layout.stnap_calc.combo_hphonecount), 
									  /*set ssn_count=0*/ 0 ),
		DATASET([{'37',risk_indicators.getHRIDesc('37')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode27(if(billto,layout.indata.hphone,layout.indata.hphone2), 
									  if(billto,layout.btnap_calc.combo_lastcount,layout.stnap_calc.combo_lastcount), 
									  if(billto,layout.btnap_calc.combo_hphonecount,layout.stnap_calc.combo_hphonecount)),
		DATASET([{'27',risk_indicators.getHRIDesc('27')}],risk_indicators.Layout_Desc)) &	
		
	IF(Risk_Indicators.rcSet.isCode74(if(billto,layout.btnap_calc.phone_lastcount,layout.stnap_calc.phone_lastcount), 
									  if(billto,layout.btnap_calc.phone_addrcount,layout.stnap_calc.phone_addrcount), 
									  if(billto,layout.btnap_calc.phone_phonecount,layout.stnap_calc.phone_phonecount), 
									  if(billto,layout.btnap_calc.phonevalflag,layout.stnap_calc.phonevalflag) ),
		DATASET([{'74',risk_indicators.getHRIDesc('74')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode73(if(billto,layout.indata.hphone,layout.indata.hphone2),
									  if(billto,layout.btnap_calc.phone_phonecount,layout.stnap_calc.phone_phonecount), 
									  if(billto,layout.btnap_calc.combo_hphonecount,layout.stnap_calc.combo_hphonecount)),
		DATASET([{'73',risk_indicators.getHRIDesc('73')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode11(if(billto,layout.indata.addrvalflag,layout.indata.addrvalflag2), 
									  if(billto,layout.indata.in_addr,layout.indata.in_addr2), 
									  if(billto,layout.indata.in_locality,layout.indata.in_locality2), 
									  if(billto,layout.indata.in_province,layout.indata.in_province2), 
									  if(billto,layout.indata.in_postalcode,layout.indata.in_postalcode2)),								  
		DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode82(if(billto,layout.btnap_calc.addr_phonenumber,layout.stnap_calc.addr_phonenumber), 
									  if(billto,layout.indata.hphone,layout.indata.hphone2), 
									  if(billto,layout.btnap_calc.addr_lastscore,layout.stnap_calc.addr_lastscore)),
		DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode64(if(billto,layout.btnap_calc.addr_phonenumber,layout.stnap_calc.addr_phonenumber), 
									  if(billto,layout.indata.hphone,layout.indata.hphone2), 
									  if(billto,layout.btnap_calc.addr_lastscore,layout.stnap_calc.addr_lastscore)),								  
		DATASET([{'64',risk_indicators.getHRIDesc('64')}],risk_indicators.Layout_Desc)) &
		
	IF(billTo and Risk_Indicators.rcSet.isCodeIE(layout.ip_results.ipaddr<>'', layout.ip_results.secondleveldomain, layout.ip_results.iptype),
		DATASET([{'IE',risk_indicators.getHRIDesc('IE')}],risk_indicators.Layout_Desc)) &

	IF(billTo and Risk_Indicators.rcSet.isCodeIC_can(layout.indata.in_postalcode, layout.ip_results.zip, layout.ip_results.countrycode, layout.ip_results.ipaddr<>'', 
													 layout.indata.in_province, layout.ip_results.state, layout.ip_results.secondleveldomain,
												     layout.ip_results.iptype, layout.ip_results.areacode, layout.indata.hphone),
		DATASET([{'IC',risk_indicators.getHRIDesc('IC')}],risk_indicators.Layout_Desc)) &


	IF(billTo and Risk_Indicators.rcSet.isCodeIG(layout.ip_results.iptype),
		DATASET([{'IG',risk_indicators.getHRIDesc('IG')}],risk_indicators.Layout_Desc)) &

	IF(Risk_Indicators.rcSet.isCode77(if(billto,layout.indata.last,layout.indata.last2),if(billto,layout.indata.first,layout.indata.first2)),
		DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode78(if(billto,layout.indata.in_addr,layout.indata.in_addr2)),
		DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode80(if(billto,layout.indata.hphone,layout.indata.hphone2)),
		DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode30(if(billto,layout.btnap_calc.corrected_address<>'',layout.stnap_calc.corrected_address<>'')),
		DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode31(if(billto,layout.btnap_calc.corrected_hphone<>'',layout.stnap_calc.corrected_hphone<>'')),
		DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode76(if(billto,layout.btnap_calc.corrected_last,layout.stnap_calc.corrected_last)),
		DATASET([{'76',risk_indicators.getHRIDesc('76')}],risk_indicators.Layout_Desc)) &
		
	IF(Risk_Indicators.rcSet.isCode48(if(billto,layout.indata.first,layout.indata.first2), 
									  if(billto,layout.btnap_calc.combo_firstcount,layout.stnap_calc.combo_firstcount), 
									  if(billto,layout.btnap_calc.combo_lastcount,layout.stnap_calc.combo_lastcount)),
		DATASET([{'48',risk_indicators.getHRIDesc('48')}],risk_indicators.Layout_Desc)) &

	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,

cnt)

ENDMACRO;


riskwise.layouts.cdn706_variables do_model(model_variables le) := transform

	// indata contains the input data from the customer, as well as the the cleaned addresses from candian postalsoft
	// eddo contains the first, last and email scores
	// ip_results contains the netAcuity information about the input IP address
	// vdata contains the name/addr/phone verifcation levels for billto an shipto
	
	BT_BOBJ_address	:= Risk_Indicators.MOD_AddressClean.street_address('',le.indata.prim_range, le.indata.dir, le.indata.prim_name, le.indata.addr_suffix, '', le.indata.unit_desig, le.indata.sec_range);
	ST_BOBJ_address	:= Risk_Indicators.MOD_AddressClean.street_address('',le.indata.prim_range2, le.indata.dir2, le.indata.prim_name2, le.indata.addr_suffix2, '', le.indata.unit_desig2, le.indata.sec_range2);
	v_bt := if(bt_bobj_address=st_bobj_address and
			   le.indata.locality=le.indata.locality2 and
			   le.indata.province=le.indata.province2 and
			   le.indata.postalcode=le.indata.postalcode2, 1, 0);
	
	V_bobj_risk := if(le.indata.addr_status[2]<>'0' or le.indata.addr_status2[2]<>'0', 1, 0);
	
	v_orderamt := ut.imin2(4000, if(le.indata.orderamt='', 4000, (integer)le.indata.orderamt));
	
	_avs := stringlib.stringtouppercase(le.indata.avscode);
	
	v_avs_rank := map(_avs in ['9','H','X'] => '10-match',
					  _avs in ['B','D','F','N3','JA','N4','N6'] => '20-add match',
					  _avs in ['A','C','JB','N7','Z'] => '30-zip match',
					  _avs in ['JD'] => '40-intl zip match',
					  _avs in ['E'] => '50-zip4 match',
					  _avs in ['7'] => '60-add na',
					  _avs in ['2','3','G','4','R'] => '80-no match/no participate',
					  _avs in ['J','N5','JC'] => '90-intl no match,no participate',
					  '70-system down');
	
	v_avs_rank_m := map(v_avs_rank =   '10-match' 						   => 0.00489519,
						v_avs_rank =   '20-add match'                      => 0.00542149,
						v_avs_rank =   '30-zip match'                      => 0.00784159, 
						v_avs_rank =   '60-add na'                         => 0.01118763, 
						v_avs_rank =   '70-system down'                    => 0.03450926, 
						v_avs_rank =   '80-no match/no participate'        => 0.03685378, 
						v_avs_rank =   '90-intl no match,no participate'   => 0.10362071,
						0.01276312)  ;
						
						
	_cid := stringlib.stringtouppercase(le.indata.cidcode);
	
    v_cid := map(_cid = 'M' => '1-M',
				 _cid = 'P' => '2-P',
				 _cid = 'U' => '4-U',
				 _cid = 'S' => '5-S',
				 _cid = 'Y' => '6-Y',
				 _cid = 'N' => '6-N',
				 '3.5-missing');

	v_avscid_i_a := map(v_avs_rank = '10-match' and v_cid = '1-M' => 1,
					  v_avs_rank = '10-match' and v_cid in ['2-P','3.5-missing','4-U'] => 2,
					  v_avs_rank = '10-match' => 5,
					  v_avs_rank = '20-add match' and v_cid in ['1-M','2-P','3.5-missing','4-U'] => 2,
					  v_avs_rank = '20-add match' => 5,
					  v_avs_rank = '30-zip match' and v_cid in ['1-M','2-P','3.5-missing','4-U'] => 2,
					  v_avs_rank = '30-zip match' => 5,
					  v_avs_rank = '40-intl zip match' and v_cid in ['1-M','2-P','3.5-missing','4-U'] => 2,
					  v_avs_rank = '40-intl zip match' => 5,
					  v_avs_rank = '50-zip4 match' and v_cid in ['1-M','2-P','3.5-missing','4-U'] => 2,
					  v_avs_rank = '50-zip4 match' => 5,
					  v_avs_rank = '60-add na' and v_cid in ['1-M'] => 2,
					  v_avs_rank = '60-add na' and v_cid in ['2-P'] => 3,
					  v_avs_rank = '60-add na' and v_cid in ['3.5-missing','4-U'] => 4,
					  v_avs_rank = '60-add na' and v_cid in ['5-S'] => 5,
					  v_avs_rank = '60-add na' => 6,
					  v_avs_rank = '70-system down' and v_cid in ['1-M'] => 2,
					  v_avs_rank = '70-system down' and v_cid in ['2-P'] => 3,
					  v_avs_rank = '70-system down' and v_cid in ['3.5-missing'] => 4,
					  v_avs_rank = '70-system down' and v_cid in ['4-U'] => 5,
					  v_avs_rank = '70-system down' => 6,
					  v_avs_rank = '80-no match/no participate' and v_cid in ['1-M'] => 3,
					  v_avs_rank = '80-no match/no participate' and v_cid in ['2-P','3.5-missing'] => 5,
					  v_avs_rank = '80-no match/no participate' => 6,
					  6);

	pmttype := stringlib.stringtouppercase(le.indata.pymtmethod);
	v_avscid_i := map(v_avscid_i_a = 1 and pmttype = 'A' => 0,
					  v_avscid_i_a = 6 and pmttype = 'M' => 7,
					  v_avscid_i_a);
	
	prodcode := trim(le.indata.prodcode);
	v_avscid_i2 := map(v_avscid_i = 0 and prodcode = '1' => -1,
					   v_avscid_i = 5 and prodcode = '2' => 6,
					   v_avscid_i = 6 and prodcode = '2' => 7,
					   v_avscid_i = 7 and prodcode = '2' => 8,
					   v_avscid_i in [0,1,2] => 1,
					   v_avscid_i);

	v_avscid_i2_m := map(v_avscid_i2 = -1 =>    0.00000000, 
						 v_avscid_i2 =  1 =>    0.00566068, 
						 v_avscid_i2 =  3 =>    0.02715339, 
						 v_avscid_i2 =  4 =>    0.03492579, 
						 v_avscid_i2 =  5 =>    0.03562753, 
						 v_avscid_i2 =  6 =>    0.08818167, 
						 v_avscid_i2 =  7 =>    0.20778516, 
						 v_avscid_i2 =  8 =>    0.62575685,
						 0.01276312);
	
	v_laptop := if(prodcode='2',1,0);
	
	scoring_date := ut.GetDate;

	v_firstorderdate := trim(le.indata.orderdate);
	v_account_tenure_mon := ( ut.DaysApart(scoring_date,v_firstorderdate) ) / 30.5;

	v_NonMatureAccount := if(v_account_tenure_mon <= 3.00, 1, 0);	
		
	_email := trim(le.indata.email);
	a := Stringlib.StringFind(_email, '@', 1);
	elen := length(_email);

	v_email_domain := if(a=0, '', trim(stringlib.stringtouppercase(_email)[a+1..elen]));

	v_email_domain3 := map( stringlib.stringfind(v_email_domain,'.GOV',1) <> 0 => '0-LowRiskEmail', 
							v_email_domain = 'DELL.COM'     => '0-LowRiskEmail' , 
							v_email_domain = 'SYMPATICO.CA' => '1-ISP' , 
							v_email_domain = 'ROGERS.COM'   => '1-ISP' , 
							v_email_domain = 'TELUS.NET'    => '1-ISP' , 
							v_email_domain = 'SHAW.CA'      => '1-ISP' , 
							v_email_domain = 'VIDEOTRON.CA' => '1-ISP' , 
							v_email_domain = 'GMAIL.COM'    => '2-GMAIL.COM' , 
							v_email_domain = 'HOTMAIL.COM'  => '3-CommercialEmail' , 
							v_email_domain = 'YAHOO.COM'    => '3-CommercialEmail' , 
							v_email_domain = 'YAHOO.CA'     => '3-CommercialEmail', 
							'Other');

	v_email_domain3_m := map( v_email_domain3 =    '0-LowRiskEmail'       =>    0.00000000    ,
							  v_email_domain3 =    '1-ISP'                =>    0.00316024    ,  
							  v_email_domain3 =    '2-GMAIL.COM'          =>    0.01125609    ,  
							  v_email_domain3 =    '3-CommercialEmail'    =>    0.02164129    ,  
							  v_email_domain3 =    'Other'                =>    0.01338303    ,
							  0.01276312    );
							  

	v_IP_continent := trim(le.ip_results.continent);
	v_IP_region := trim(le.ip_results.ipregion);
	ACQCHANNEL := trim(le.indata.channel);
	ip_countrycode := trim(stringlib.stringtouppercase(le.ip_results.countrycode));
	v_IP_connection := trim(stringlib.stringtolowercase(le.ip_results.ipconnection));
	
	v_ip_region_i := map(ACQCHANNEL = '01' and ip_countrycode = 'CA' => 'canada',
						 ACQCHANNEL = '01' and ip_countrycode = 'US' => 'us',
						 ACQCHANNEL = '01' and v_ip_continent = '1'  => 'bad',
						 ACQCHANNEL = '01' and v_ip_continent <> ''  => 'other',
						 ACQCHANNEL = '01' and v_ip_continent = ''   => 'missing',
						 'telephone order');

	v_ip_city  := trim(stringlib.stringtouppercase(le.ip_results.ipcity));
	v_ip_state := trim(stringlib.stringtouppercase(le.ip_results.ipregion));

	v_bt_city  := trim(stringlib.stringtouppercase(le.indata.locality));
	v_bt_state := trim(stringlib.stringtouppercase(le.indata.province));

	v_st_city  := trim(stringlib.stringtouppercase(le.indata.locality2));
	v_st_state := trim(stringlib.stringtouppercase(le.indata.province2));

	// internet orders
	v_ip_i_channel01 := map(v_bt=1 and v_ip_city = v_bt_city => 'int-bt-city',
							v_bt=1 and v_ip_state = v_bt_state => 'int-bt-state',
							v_bt=1 and v_ip_region_i = 'canada' => 'int-bt-outstate',
							v_bt=1 and v_ip_region_i = 'bad' => 'int-bt-badzone',
							v_bt=1 => 'int-bt-foreign',
							v_bt_city=v_st_city and v_bt_state=v_st_state and v_ip_city = v_bt_city => 'int-st-city-city',
							v_bt_city=v_st_city and v_bt_state=v_st_state and v_ip_state = v_bt_state => 'int-st-city-state',
							v_bt_city=v_st_city and v_bt_state=v_st_state and v_ip_region_i = 'canada' => 'int-st-city-outstate',
							v_bt_city=v_st_city and v_bt_state=v_st_state and v_ip_region_i = 'bad' => 'int-st-city-badzone',
							v_bt_city=v_st_city and v_bt_state=v_st_state => 'int-st-city-foreign',
							v_bt_state=v_st_state and v_ip_city = v_bt_city => 'int-st-state-btcity',
							v_bt_state=v_st_state and v_ip_city = v_st_city => 'int-st-state-stcity',
							v_bt_state=v_st_state and v_ip_state = v_bt_state => 'int-st-state-state',
							v_bt_state=v_st_state and v_ip_region_i = 'canada' => 'int-st-state-outstate',
							v_bt_state=v_st_state and v_ip_region_i = 'bad' => 'int-st-state-badzone',
							v_bt_state=v_st_state => 'int-st-state-foreign',
							v_ip_city = v_bt_city and v_ip_state = v_bt_state => 'int-st-outstate-btcity',
							v_ip_state = v_bt_state => 'int-st-outstate-btstate',
							v_ip_city = v_st_city and v_ip_state = v_st_state => 'int-st-outstate-stcity',
							v_ip_state = v_st_state => 'int-st-outstate-ststate',
							v_ip_region_i = 'canada' => 'int-st-outstate-outstate',
							v_ip_region_i = 'bad' => 'int-st-outstate-badzone',
							'int-st-outstate-foreign'); 


	// telephone orders
	v_ip_i_channel02 := map(v_bt=1 => 'tel-bt',
							v_bt_city = v_st_city and v_bt_state=v_st_state => 'tel-st-city',
							v_bt_state = v_st_state => 'tel-st-state',
							'tel-st-out');

	v_ip_i := if(ACQCHANNEL='01', v_ip_i_channel01, v_ip_i_channel02);
	
	v_ip_i2 := map(v_ip_i='tel-bt'                     => 't1', 
				   v_ip_i='tel-st-city'                => 't2', 
				   v_ip_i='tel-st-state'               => 't3', 
				   v_ip_i='tel-st-out'                 => 't4', 
				   v_ip_i='int-bt-city'                => 'a1', 
				   v_ip_i='int-bt-state'               => 'a2', 
				   v_ip_i='int-bt-outstate'            => 'a2', 
				   v_ip_i='int-bt-foreign'             => 'a3', 
				   v_ip_i='int-bt-badzone'             => 'xx', 
				   v_ip_i='int-st-city-city'           => 'b1', 
				   v_ip_i='int-st-city-state'          => 'b1', 
				   v_ip_i='int-st-city-outstate'       => 'b1', 
				   v_ip_i='int-st-city-foreign'        => 'b1', 
				   v_ip_i='int-st-city-badzone'        => 'xx', 
				   v_ip_i='int-st-state-btcity'        => 'c1', 
				   v_ip_i='int-st-state-stcity'        => 'c1', 
				   v_ip_i='int-st-state-state'         => 'c2', 
				   v_ip_i='int-st-state-outstate'      => 'c2', 
				   v_ip_i='int-st-state-foreign'       => 'c2', 
				   v_ip_i='int-st-state-badzone'       => 'xx', 
				   v_ip_i='int-st-outstate-btcity'     => 'd1', 
				   v_ip_i='int-st-outstate-btstate'    => 'd1', 
				   v_ip_i='int-st-outstate-stcity'     => 'd2', 
				   v_ip_i='int-st-outstate-ststate'    => 'd2', 
				   v_ip_i='int-st-outstate-outstate'   => 'd2', 
				   v_ip_i='int-st-outstate-foreign'    => 'd2', 
				   v_ip_i='int-st-outstate-badzone'    => 'xx',
				   '00');

	v_ip_i2_m := map(v_ip_i2 =    'a1'     =>    0.00415757    ,
					  v_ip_i2 =    'a2'     =>    0.01050267    , 
					  v_ip_i2 =    'a3'     =>    0.01534541    , 
					  v_ip_i2 =    'b1'     =>    0.00973630    , 
					  v_ip_i2 =    'c1'     =>    0.01484006    , 
					  v_ip_i2 =    'c2'     =>    0.03792488    , 
					  v_ip_i2 =    'd1'     =>    0.01968934    , 
					  v_ip_i2 =    'd2'     =>    0.10820074    , 
					  v_ip_i2 =    't1'     =>    0.01420033    , 
					  v_ip_i2 =    't2'     =>    0.02149258    , 
					  v_ip_i2 =    't3'     =>    0.02845293    , 
					  v_ip_i2 =    't4'     =>    0.04438461    , 
					  v_ip_i2 =    'xx'     =>    0.91231090    ,
					  0.01276312    );

	v_ip_connection_i := map(ACQCHANNEL = '02' => -1, 
							 v_ip_connection = 't1'           => 0, 
							 v_ip_connection =    'broadband'    => 1,
							 v_ip_connection =    'cable'        => 1, 
							 v_ip_connection =    'xdsl'         => 2, 
							 v_ip_connection =    'dialup'       => 3, 
							 v_ip_connection =    'satellite'    => 4, 
							 v_ip_connection =    'wireless'     => 4,
							 2.5);

	v_ip_connection_i_m := map(v_ip_connection_i =      -1     =>    0.01601513    , 
							   v_ip_connection_i =       0     =>    0.00410022    , 
							   v_ip_connection_i =       1     =>    0.00992337    , 
							   v_ip_connection_i =       2     =>    0.01282454    ,
							   v_ip_connection_i =     2.5     =>    0.01421223    ,
							   v_ip_connection_i =       3     =>    0.02623474    , 
							   v_ip_connection_i =       4     =>    0.05040566    ,
							   0.01276312    );

	v_email_bt_score := map(le.eddo.efirstscore='-1' or le.eddo.elastscore='-1' => -1,
							(integer)le.eddo.elastscore>0 => 1,
							(integer)le.eddo.efirstscore>0 => 1,
							3);

	v_email_st_score := map(le.eddo.efirst2score='-1' or le.eddo.elast2score='-1' => -1,
							(integer)le.eddo.elast2score>0 => 1,
							(integer)le.eddo.efirst2score>0 => 1,
							3);
							
	v_email_score := map(v_email_bt_score=-1 or v_email_st_score=-1 => -1,
						 v_email_bt_score= 1 and v_email_st_score= 1 => 1,
						 v_email_bt_score= 3 and v_email_st_score= 3 => 3,
						 2);
						 
	v_email_score_m := map(v_email_score =     -1      =>    0.01575194    , 
						   v_email_score =      1      =>    0.00671046    , 
						   v_email_score =      2      =>    0.02079106    , 
						   v_email_score =      3      =>    0.02262792    ,
						   0.01276312    );


     /* **************** verification **********************/

	nap_bt_combo_nap_level := le.btnap_calc.combo_NAP_level;
	v_bt_combo_nap := map(nap_bt_combo_nap_level in [1       ] => 6, 
						  nap_bt_combo_nap_level in [0       ] => 5, 
						  nap_bt_combo_nap_level in [2,3,4   ] => 4, 
						  nap_bt_combo_nap_level in [  5,6   ] => 3, 
						  nap_bt_combo_nap_level in [7,8,9,10] => 2, 
						  nap_bt_combo_nap_level in [11      ] => 1,
						  0);


	nap_st_combo_nap_level := le.stnap_calc.combo_NAP_level;
	v_st_combo_nap := map(nap_st_combo_nap_level in [1       ] => 6, 
						  nap_st_combo_nap_level in [0       ] => 5, 
						  nap_st_combo_nap_level in [2,3,4   ] => 4, 
						  nap_st_combo_nap_level in [  5,6   ] => 3, 
						  nap_st_combo_nap_level in [7,8,9,10] => 2, 
						  nap_st_combo_nap_level in [11      ] => 1,
						  0);

	v_combo_nap := map(v_st_combo_nap=0                       => 1, 
					   v_st_combo_nap=1 and v_bt_combo_nap<=1 => 1, 
					   v_st_combo_nap=1 and v_bt_combo_nap<=4 => 2, 
					   v_st_combo_nap=1                       => 2, 
					   v_st_combo_nap=2 and v_bt_combo_nap<=4 => 2, 
					   v_st_combo_nap=2                       => 3, 
					   v_st_combo_nap=3                       => 3, 
					   v_st_combo_nap=4                       => 4, 
					   v_st_combo_nap=5 and v_bt_combo_nap<=5 => 4,
					   5);

	v_combo_nap_m := map(v_combo_nap =      1      =>    0.00347752    , 
						 v_combo_nap =      2      =>    0.00625194    , 
						 v_combo_nap =      3      =>    0.01440751    , 
						 v_combo_nap =      4      =>    0.02228589    , 
						 v_combo_nap =      5      =>    0.04034032    ,
						 0.01276312    );

	/* ********* final model  **********/

	logit20 := -10.42724792
			  + v_ORDERAMT  * 0.0002049185
			  + v_avscid_i2_m  * 5.2047441437
			  + v_avs_rank_m  * 29.997312819
			  + v_laptop  * 0.5218953861
			  + v_NonMatureAccount  * 1.2249911531
			  + v_ip_i2_m  * 8.3898050781
			  + v_ip_connection_i_m  * 48.51489684
			  + v_email_score_m  * 57.95529212
			  + v_email_domain3_m  * 78.398260012
			  + v_bobj_risk  * 0.8526296815
			  + v_combo_nap_m  * 60.408685091;

	phat20 := (exp(logit20 )) / (1+exp(logit20 ));
	mod20 := round(-20*(log(phat20/(1-phat20)) - log(0.5/99.5))/log(2) + 720);

	self.score := map(mod20 > 999 => 999,
					  mod20 < 250 => 250,
					  mod20);
	
	
	self.bt_reasons := dell_reason_codes(le,6,true);
	self.st_reasons := dell_reason_codes(le,6,false);

	self := le;
	

end;

ret := project(model_variables, do_model(left));

return ret;

/*  **************************************************************************************************************
 Hang onto the validation code just in case they need to make a few tweaks to model and need to validate again
 *****************************************************************************************************************

val_layout := record

	unsigned seq;
	
	string scoring_date ;
	
	string BT_first_name ;
	string BT_last_name ;
	string ST_first_name ;
	string ST_last_name ;
	string email ;
	string avs ;
	string cidcode ;
	string pmttype ;
	string prodcode ;
	string ORDERAMT ;
	string FRSTORDRDT ;
	string IP_address ;
	string ACQCHANNEL ;
		 
	string BT_BOBJ_address ;                         
	string BT_BOBJ_locality1 ;                       
	string BT_BOBJ_region1     ;                     
	string BT_BOBJ_postcodefull  ;                   
	string BT_BOBJ_addrstatuscode  ;
	string bt_bobj_rectype;
	
	string ST_BOBJ_address ;                         
	string ST_BOBJ_locality1 ;                       
	string ST_BOBJ_region1 ;                         
	string ST_BOBJ_postcodefull ;                    
	string ST_BOBJ_addrstatuscode ;
	string st_bobj_rectype;

	string IP_city ;                                 
	string IP_region ;                               
	string IP_countrycode ;                          
	string IP_continent ;  
	string ip_connection ;

	string IST_efirstscore ;
	string IST_elastscore ;
	string IST_efirst2score ;
	string IST_elast2score ;
		 
	integer nap_bt_combo_nap_level ;
	integer nap_st_combo_nap_level ;
	
	integer v_bt;
	string v_ip_i;
	string v_ip_i2;
	real v_ip_i2_m ;
	
	real v_ORDERAMT ;
	real v_avscid_i2_m ;
	real v_avs_rank_m ;
	real v_laptop ;
	real v_NonMatureAccount ;
	real v_ip_connection_i_m ;
	real v_email_score_m ;
	real v_email_domain3_m ;
	real v_bobj_risk ;
	real v_combo_nap_m ;
	
	integer cdn706_score ;
	integer score;
end;

val_layout do_model(model_variables le) := transform


	self.seq	:= le.indata.seq	;

	self.scoring_date	:= scoring_date	;
	self.BT_first_name	:= le.indata.first	;
	self.BT_last_name	:= le.indata.last	;
	self.ST_first_name	:= le.indata.first2	;
	self.ST_last_name	:= le.indata.last2	;
	self.email	:= le.indata.email	;
	self.avs	:= le.indata.avscode	;
	self.cidcode	:= le.indata.cidcode	;
	self.pmttype	:= le.indata.pymtmethod	;
	self.prodcode	:= le.indata.prodcode	;
	self.ORDERAMT	:= le.indata.orderamt	;
	self.FRSTORDRDT	:= le.indata.orderdate	;
	self.IP_address	:= le.indata.ipaddr	;
	self.ACQCHANNEL	:= le.indata.channel	;

	self.BT_BOBJ_address	:= BT_BOBJ_address;                         
	self.BT_BOBJ_locality1	:= le.indata.locality	;                       
	self.BT_BOBJ_region1    	:= le.indata.province	;                     
	self.BT_BOBJ_postcodefull 	:= le.indata.postalcode	;                   
	self.BT_BOBJ_addrstatuscode 	:= le.indata.addr_status	; 
	self.bt_bobj_rectype := le.indata.addr_type;                
	self.ST_BOBJ_address	:= ST_BOBJ_address;                         
	self.ST_BOBJ_locality1	:= le.indata.locality2	;                       
	self.ST_BOBJ_region1	:= le.indata.province2	;                         
	self.ST_BOBJ_postcodefull	:= le.indata.postalcode2	;                    
	self.ST_BOBJ_addrstatuscode	:= le.indata.addr_status2	; 
	self.st_bobj_rectype := le.indata.addr_type2;                 

	self.IP_city	:= le.ip_results.ipcity	;                                 
	self.IP_region	:= le.ip_results.ipregion	;                               
	self.IP_countrycode	:= le.ip_results.countrycode	;                          
	self.IP_continent	:= le.ip_results.continent	;  
	self.ip_connection	:= le.ip_results.ipconnection	;

	self.IST_efirstscore	:= le.eddo.efirstscore	;
	self.IST_elastscore	:= le.eddo.elastscore	;
	self.IST_efirst2score	:= le.eddo.efirst2score	;
	self.IST_elast2score	:= le.eddo.elast2score	;

	self.nap_bt_combo_nap_level	:= le.btnap_calc.combo_nap_level	;
	self.nap_st_combo_nap_level	:= le.stnap_calc.combo_nap_level	;

	self.v_bt := v_bt ;
	self.v_ip_i := v_ip_i;
	self.v_ip_i2 := v_ip_i2;

	self.v_ORDERAMT	:= v_orderamt	;
	self.v_avscid_i2_m	:= v_avscid_i2_m	;
	self.v_avs_rank_m	:= v_avs_rank_m	;
	self.v_laptop	:= v_laptop	;
	self.v_NonMatureAccount	:= v_nonmatureaccount	;
	self.v_ip_i2_m	:= v_ip_i2_m	;
	self.v_ip_connection_i_m	:= v_ip_connection_i_m	;
	self.v_email_score_m	:= v_email_score_m	;
	self.v_email_domain3_m	:= v_email_domain3_m	;
	self.v_bobj_risk	:= v_bobj_risk	;
	self.v_combo_nap_m	:= v_combo_nap_m	;

	self.cdn706_score	:= mod20 ;
*/

end;

	