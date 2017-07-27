import ut, risk_indicators, address, RiskWise, EASI;

export CDN606_1_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, dataset(RiskWise.Layout_CD2I) indata, boolean IBICID) := 

FUNCTION

layout_cd2iPlus := RECORD
	RiskWise.Layout_CD2I;
	string3 county := '';
	string7 geo_blk := '';
	string3 county2 := '';
	string7 geo_blk2 := '';
END;

layout_cd2iPlus getGeo(indata le) := TRANSFORM
	a1_val1 := le.addr;
	a2_val1 := Address.Addr2FromComponents(le.city, le.state, le.zip);
	clean_a := if(a1_val1<>'' or a2_val1<>'',Address.CleanAddress182(a1_val1,a2_val1),'');
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	
	a1_val2 := le.addr2;
	a2_val2 := Address.Addr2FromComponents(le.city2, le.state2, le.zip2);
	clean_a2 := if(a1_val2<>'' or a2_val2<>'',Address.CleanAddress182(a1_val2,a2_val2),'');
	self.county2 := clean_a2[143..145];
	self.geo_blk2 := clean_a2[171..177];
	self := le;
END;
withgeo := project(indata, getGeo(LEFT));




layout_ineasi := RECORD
	layout_cd2iPlus cd2i;
	Easi.layout_census easi;
	Easi.layout_census easi2;
END;


layout_ineasi join2recs(withgeo le, Easi.Key_Easi_Census ri) := TRANSFORM
	self.cd2i := le;
	self.easi := ri;
	self	:= [];
END;				 
results := join(withgeo, Easi.Key_Easi_Census,
			 keyed(right.geolink=left.state+left.county+left.geo_blk),
			 join2recs(left,right),
			 left outer,ATMOST(keyed(right.geolink=left.state+left.county+left.geo_blk),RiskWise.max_atmost),keep(1));
			
layout_ineasi joinEm(results le, Easi.Key_Easi_Census ri) := TRANSFORM
	self.easi2 := ri;
	self := le;
END;
ineasi := join(results, Easi.Key_Easi_Census,
			keyed(right.geolink=left.cd2i.state2+left.cd2i.county2+left.cd2i.geo_blk2),
			joinEm(left,right),
			left outer,ATMOST(keyed(right.geolink=left.cd2i.state2+left.cd2i.county2+left.cd2i.geo_blk2),RiskWise.max_atmost),keep(1));
			
			
// replicated sas function here, returns the smallest integer that is greater than or equal to the argument			
ceil(real val) := if((integer)val = val, (integer)val, (integer)(val + 1));			



Layout_ModelOut doModel(clam le, ineasi ri) := TRANSFORM

	/*** make system var ***/
	archive_y := if(le.bill_to_out.historydate <> 999999, (integer)(string)le.bill_to_out.historydate[1..4],  (integer)(ut.GetDate[1..4]));		// not sure if this is correct to use it in the boca shell
	archive_y_st := if(le.ship_to_out.historydate <> 999999, (integer)(string)le.ship_to_out.historydate[1..4], (integer)(ut.GetDate[1..4]));		// is this ever different than the bill to history date?


	/*** make order attribute var ***/

	/* shared var */
	_avs := StringLib.StringToUpperCase(ri.cd2i.avscode);
	_cid := ri.cd2i.cidcode;
	_payType := StringLib.StringToUpperCase(ri.cd2i.pymtmethod);
	_shippingMode := StringLib.StringToUpperCase(ri.cd2i.shipmode);
	v_AcqChannel := ri.cd2i.channel;

	/* st model var */
	vs_order_amt := ut.imin2((real)ri.cd2i.orderamt, 500);

	vs_order_amt_ge1400 := (integer)((real)ri.cd2i.orderamt >= 1400);

	vs_avscode := map(_avs in ['M','V','6','D','U','N', '4','0'] => 1,
				   _avs in ['R','X'] or (_avs = '' and _payType <> 'G') => 2,
				   _avs in ['A','Z','9','3','7','1'] and _payType in ['A','B','V'] => 4,
				   _avs in ['A','Z','W','9','3','7','1'] => 3,
				   _avs in ['Y','8','2'] => 4,
				   _avs in ['B','G'] => 2,
				   _avs = '' and _payType = 'G' => 5,
				   -1);

	vs_avscode_m := map(vs_avscode = 1 => 0.08962670,
					vs_avscode = 2 => 0.06896552,
					vs_avscode = 3 => 0.01677578,
					vs_avscode = 4 => 0.01378576,
					vs_avscode = 5 => 0.00035430,
					0.01726424);

	vs_CID := map(_cid = '1' => 0,
			    _cid in ['','0','3','5','7'] => 1,
			    _cid in ['2','4','6'] => 2,
			    -1);

	vs_cid_m := map(vs_cid = 0 => 0.01486056,
				 vs_cid = 1 => 0.02914573,
				 vs_cid = 2 => 0.06709522,
				 0.01726424);

	vs_shippingMode_m := map(_shippingMode = '2' => 0.10567410,
						_shippingMode = '7' => 0.02428256,
						_shippingMode = 'G' => 0.00755993,
						_shippingMode = 'R' => 0.02739212,
						0.01726424);

	/* bt model var */
	vb_CUS_ORDER_AMT := if(ri.cd2i.orderamt in ['0',''], 0, log((ut.imin2((real)ri.cd2i.orderamt, 2500)))/.434294481903);	// do I need to a natural log here?

	vb_avs_bad_f := if(_avs in ['N','M','V','6','D','U','0','4'], 1, 0);

	vb_avscode := map(_avs = '' and _payType = 'G' => 10,
				   _avs = '' and _payType = 'X' => 9.5,
				   _avs in ['Y','2','8'] => if(_payType = 'V', 9, 8),
				   _avs in ['A','Z','1','3','7','9'] => 7,
				   _avs in ['B','G'] => 6,
				   _avs in ['N','0','4'] => if(_payType in ['A','D','X'], 4, 5),
				   _avs in ['R','X',''] => 3,
				   _avs in ['M','V','6','D','U'] => 1,
				   -1);

	vb_avscode_m := map(vb_avscode = 1 => 0.21405469,
					vb_avscode = 3 => 0.07039021,
					vb_avscode = 4 => 0.16285625,
					vb_avscode = 5 => 0.04838535,
					vb_avscode = 6 => 0.01717033,
					vb_avscode = 7 => 0.00516600,
					vb_avscode = 8 => 0.00155429,
					vb_avscode = 9 => 0.00090950,
					vb_avscode = 9.5 => 0.00179670,
					vb_avscode = 10 => 0.00001429,
					0.00445174);

	vb_cid_nonMatch_f := (integer)((integer)_cid <> 1);

	vb_shippingMode_m := map(_shippingMode = '2' => 0.0334620,
						_shippingMode = '7' => 0.0149777,
						_shippingMode = 'G' => 0.0018793,
						_shippingMode = 'R' => 0.0087849,
						0.0043496);

	/* is model var */	

	vi_CUS_ORDER_AMT100 := ceil((real)ri.cd2i.orderamt/100)*100;

	vi_order_amt := map(vi_CUS_ORDER_AMT100 <= 500 => vi_CUS_ORDER_AMT100,
					vi_CUS_ORDER_AMT100 <= 1500 => 1000,
					vi_CUS_ORDER_AMT100 <= 2500 => 2000,
					2501);

	vi_order_amt_m := map(vi_order_amt = 0 => 0,
					  vi_order_amt = 100 => 0.00033315,
					  vi_order_amt = 200 => 0.00093694,
					  vi_order_amt = 300 => 0.00105150,
					  vi_order_amt = 400 => 0.00140335,
					  vi_order_amt = 500 => 0.00175223,
					  vi_order_amt = 1000 => 0.00360871,
					  vi_order_amt = 2000 => 0.01655629,
					  vi_order_amt = 2501 => 0.02840909,
					  0.00102799);

	vi_avscode := map(_avs = '' and _payType = 'G' => 10,
				   _avs in ['Y','2','8'] => if(_payType = 'V', 9, 8),
				   _avs in ['A','Z','1','3','7','9'] => 7,
				   _avs in ['B','G'] => 6,
				   _avs in ['N','0','4'] => if(_payType in ['A','D','X'], 1, 5),
				   _avs in ['M','V','6','D','U'] => 1,
				   _avs in ['R','X',''] => 6,
				   -1);

	vi_avscode_m := map(vi_avscode = 1 => 0.08295232,
					vi_avscode = 5 => 0.01457399,
					vi_avscode = 6 => 0.00453309,
					vi_avscode = 7 => 0.00144561,
					vi_avscode = 8 => 0.00035486,
					vi_avscode = 9 => 0.00014025,
					vi_avscode = 10 => 0.00000001,
					0.00102799);

	vi_cid_nonMatch_f := (integer)((integer)_cid <> 1);
	
	
	/*** make IP var ***/

	/* shared var */

	v_IP_nonUS_f := StringLib.StringToUpperCase(le.ip2o.countrycode) <> 'USA';
	v_topDomain := StringLib.StringToUpperCase(le.ip2o.topleveldomain);
	v_IP_connection := StringLib.StringToUpperCase(le.ip2o.ipconnection);
	v_ip_state := StringLib.StringToUpperCase(le.ip2o.state);
	proxy := le.ip2o.iproutingmethod;


	v_IP_connection_I := map(proxy = '02' => 1,	// replaced this sas code, in ['ANONYMOUS','TRANSPARENT']
						v_IP_connection in ['SATELLITE','WIRELESS'] => 1,
						v_IP_connection = 'DIALUP' => 2,
						v_IP_connection in ['BROADBAND','CABLE','XDSL'] => 3,
						v_IP_connection in ['T1','T3'] => 4,
						1);

	
	/* st model var */

	vs_IPStateMatchCode := map(v_AcqChannel = '02' => if(ri.cd2i.state = ri.cd2i.state2, 's01-tbb', 's02-tbs'),
						  v_AcqChannel = '03'=> if(ri.cd2i.state = ri.cd2i.state2, 's03-kbb', 's04-kbs'),
						  v_ip_state = 'AOL' => 's05-aol',
						  v_ip_state = ri.cd2i.state and v_ip_state = ri.cd2i.state2 => 's06-bbx',
						  v_ip_state <> ri.cd2i.state and ~v_IP_nonUS_f and ri.cd2i.state = ri.cd2i.state2 => 's07-ubb',
						  v_ip_state <> ri.cd2i.state and v_IP_nonUS_f and ri.cd2i.state = ri.cd2i.state2 => 's08-nbb',
						  v_ip_state = ri.cd2i.state and v_ip_state <> ri.cd2i.state2 => 's06-bbx',
						  v_ip_state <> ri.cd2i.state and v_ip_state = ri.cd2i.state2 => 's10-xbs',
						  v_ip_state <> ri.cd2i.state and ~v_IP_nonUS_f and v_ip_state <> ri.cd2i.state2 and ri.cd2i.state <> ri.cd2i.state2 => 's10-xbs',
						  v_ip_state <> ri.cd2i.state and v_IP_nonUS_f and v_ip_state <> ri.cd2i.state2 and ri.cd2i.state <> ri.cd2i.state2 => 's12-nbs',
						  's15-oth');


	vs_IPStateMatchCode_m := map(vs_IPStateMatchCode = 's01-tbb' => 0.05158438,
						    vs_IPStateMatchCode = 's02-tbs' => 0.05690141,
						    vs_IPStateMatchCode = 's03-kbb' => 0.00391773,
						    vs_IPStateMatchCode = 's04-kbs' => 0.01018330,
						    vs_IPStateMatchCode = 's05-aol' => 0.03344893,
						    vs_IPStateMatchCode = 's06-bbx' => 0.00811194,
						    vs_IPStateMatchCode = 's07-ubb' => 0.01295371,
						    vs_IPStateMatchCode = 's08-nbb' => 0.06896552,
						    vs_IPStateMatchCode = 's10-xbs' => 0.04517650,
						    vs_IPStateMatchCode = 's12-nbs' => 0.09965103,
						    0.01726424);

	vs_govmil_domain_f := (integer)(v_topDomain in ['GOV','MIL']);


	vs_IP_connection_m := map(v_IP_connection_I = 1 => 0.06871166,
						 v_IP_connection_I = 2 => 0.02338218,
						 v_IP_connection_I = 3 => 0.01562378,
						 v_IP_connection_I = 4 => 0.00682594,
						 0.01726424);

	/* bt model var */

	vb_IPStateMatchCode := map(v_AcqChannel = '02' => 'b1-tbb',
						  v_AcqChannel = '03' => 'b2-kbb',
						  v_ip_state = 'AOL' => 'b3-abb',
						  v_ip_state = ri.cd2i.state => 'b4-bbb',
						  v_ip_state <> ri.cd2i.state and ~v_IP_nonUS_f => 'b5-ubb',
						  v_ip_state <> ri.cd2i.state and v_IP_nonUS_f => 'b6-nbb',
						  'b7-oth');


	vb_IPStateMatchCode_m := map(vb_IPStateMatchCode = 'b1-tbb' => 0.01468450,
						    vb_IPStateMatchCode = 'b2-kbb' => 0.00116516,
						    vb_IPStateMatchCode = 'b3-abb' => 0.01282519,
						    vb_IPStateMatchCode = 'b4-bbb' => 0.00241351,
						    vb_IPStateMatchCode = 'b5-ubb' => 0.00559825,
						    vb_IPStateMatchCode = 'b6-nbb' => 0.08118619,
						    0.00445174);


	vb_IP_connection_x_m := map(v_IP_connection_I = 1 => 0.01423514,
						   v_IP_connection_I = 2 => 0.00780172,
						   v_IP_connection_I = 3 => 0.00392964,
						   v_IP_connection_I = 4 => 0.00264921,
						   0.00445174);

	vb_mil_domain_f := (integer)(v_topDomain = 'MIL');

	/* IS model var */

	vi_IPStateMatchCode_m := map(vb_IPStateMatchCode = 'b1-tbb' => 0.01381410,
						    vb_IPStateMatchCode = 'b2-kbb' => 0.00228102,
						    vb_IPStateMatchCode = 'b3-abb' => 0.00200506,
						    vb_IPStateMatchCode = 'b4-bbb' => 0.00055952,
						    vb_IPStateMatchCode = 'b5-ubb' => 0.00131975,
						    vb_IPStateMatchCode = 'b6-nbb' => 0.04330709,
						    0.00102799);

	vi_IP_connection_x_m := map(v_IP_connection_I = 1 => 0.01484650,
						   v_IP_connection_I = 2 => 0.00140127,
						   v_IP_connection_I = 3 => 0.00083684,
						   v_IP_connection_I = 4 => 0.00058018,
						   0.00102799);


	/*** make Name/Address/Email Score var ***/

	vs_IST_first_diff_f := (integer)le.eddo.firstscore < 100;
	vs_IST_last_diff_f  := (integer)le.eddo.lastscore  < 100;

	vs_IST_nameDiff := map(vs_IST_last_diff_f => if(vs_IST_first_diff_f, 1, 2),
					   ~vs_IST_last_diff_f => if(vs_IST_first_diff_f, 3, 4),
					   -1);

	vs_IST_nameDiff_m := map(vs_IST_nameDiff = 1 => 0.02859490,
						vs_IST_nameDiff = 2 => 0.02107220,
						vs_IST_nameDiff = 3 => 0.00982646,
						vs_IST_nameDiff = 4 => 0.01128350,
						0.01726424);


	/*** make Distance var ***/

	vs_distX := map((integer)le.eddo.distaddraddr2 <= 50 => 0,
				 (integer)le.eddo.distaddraddr2 <= 500 => 1,
				 2);

	/*** make billto Boca var ***/

	/* shared var */

	/*verification;*/

	verphn_p := if(le.bill_to_out.iid.nap_summary in [4,6,7,9,10,11,12], 1, 0);

	v_add1_year_firstSeen := (integer)(string)(le.bill_to_out.address_verification.input_address_information.date_first_seen[1..4]);
	v_lres_years := if(v_add1_year_firstSeen = 0, -1, (archive_y - v_add1_year_firstSeen));


	/* Property;*/
	
	NaProp4_any := if(le.Bill_To_Out.address_verification.input_address_information.naprop = 4 or le.Bill_To_Out.address_verification.address_history_1.naprop = 4 or le.Bill_To_Out.address_verification.address_history_2.naprop = 4, 1,0);
	NaProp3_any := if(le.Bill_To_Out.address_verification.input_address_information.naprop = 3 or le.Bill_To_Out.address_verification.address_history_1.naprop = 3 or le.Bill_To_Out.address_verification.address_history_2.naprop = 3, 1,0);
	
	NaProp_Tree := map(NaProp4_any = 1 => 2,
				    NaProp3_any = 1 => 1,
				    0);

	
	/* Add/Phone problem;*/

	v_NOT_usps_deliverable := ~le.bill_to_out.address_validation.usps_deliverable;
	v_apt_f := StringLib.StringToUpperCase(le.bill_to_out.address_validation.dwelling_type) = 'A';
	v_mil_zip := le.bill_to_out.address_validation.zip_type = '3';


	v_addProbX := map(~v_NOT_usps_deliverable and ~v_apt_f => map(~le.bill_to_out.address_validation.hr_address and v_mil_zip => '1 LR-NONAPT-MIL',
													  ~le.bill_to_out.address_validation.hr_address and ~v_mil_zip => '2 LR-NONAPT-NONMIL',
													  '3 HR-NONAPT'),
				   ~v_NOT_usps_deliverable and v_apt_f => if(~le.bill_to_out.address_validation.hr_address, '4 LR-APT', '5 HR-APT'),
				   '6 INVALID');


	v_pnotpots := if(le.bill_to_out.phone_verification.telcordia_type in ['00','50','51','52','54'], 0, 1);
	phone_zip_mismatch := (integer)le.bill_to_out.phone_verification.phone_zip_mismatch;
	disconnected := (integer)le.bill_to_out.phone_verification.disconnected;

	v_PhoneProbX := map(v_pnotpots = 0 and phone_zip_mismatch = 0 and disconnected = 0 => 'POTS-ZIPMATCH-CON',
					v_pnotpots = 0 and phone_zip_mismatch = 0 and disconnected = 1 => 'POTS-ZIPMATCH-DISCON',
					v_pnotpots = 0 and phone_zip_mismatch = 1 => 'POTS-ZIPNOMATCH',
					v_pnotpots = 1 and phone_zip_mismatch = 0 => 'NOTPOTS-ZIPMATCH',
					v_pnotpots = 1 and phone_zip_mismatch = 1 => 'NOTPOTS-ZIPNOMATCH',
					'WRONG');


	/* rel;*/
	v_no_rel_f := (integer)(le.bill_to_out.relatives.relative_count = 0);

	/* st model var */

	vs_creditsourced_bt := le.bill_to_out.name_verification.lname_credit_sourced or le.bill_to_out.name_verification.lname_tu_sourced;

	vs_verphn_bt := verphn_p;

	vs_nas_bt := map(le.bill_to_out.iid.nas_summary = 0 => 1,
				  le.bill_to_out.iid.nas_summary in [2,3,5] => 2,
				  le.bill_to_out.iid.nas_summary = 8 => 3,
				  1);

	vs_nap_bt := map(le.bill_to_out.iid.nap_summary = 1 => 1,
				  le.bill_to_out.iid.nap_summary in [0,2,3] => 2,
				  le.bill_to_out.iid.nap_summary in [4,5,6,7,8,9,10] => 3,
				  le.bill_to_out.iid.nap_summary in [11,12] => 4,
				  2);


	vs_verx_bt := map(vs_nap_bt = 1 => map(vs_nas_bt = 1 => 1,
								    vs_nas_bt in [2,3] and ~vs_creditsourced_bt => 3,
								    3.5),
				   vs_nap_bt = 2 => map(vs_nas_bt = 1 => 2,
								    vs_nas_bt = 2 and ~vs_creditsourced_bt => 3,
								    vs_nas_bt = 2 and vs_creditsourced_bt => 3.5,
								    vs_nas_bt = 3 and vs_verphn_bt = 0 => 4,
								    5),
				   vs_nap_bt = 3 => map(vs_nas_bt = 1 and ~vs_creditsourced_bt => 3,
								    vs_nas_bt = 1 and vs_creditsourced_bt => 3.5,
								    vs_nas_bt in [2,3] and vs_verphn_bt = 0 => 4,
								    5),
				   6);

	vs_verx_bt_m := map(vs_verx_bt = 1 => 0.08220025,
					vs_verx_bt = 2 => 0.05376630,
					vs_verx_bt = 3 => 0.02480516,
					vs_verx_bt = 3.5 => 0.02052034,
					vs_verx_bt = 4 => 0.01894453,
					vs_verx_bt = 5 => 0.01167630,
					vs_verx_bt = 6 => 0.00957674,
					0.01726424);

	/* Address/Phone Problem;*/


	vs_PhoneProbX_m := map(v_PhoneProbX = 'NOTPOTS-ZIPMATCH' => 0.01850723,
					   v_PhoneProbX = 'NOTPOTS-ZIPNOMATCH' => 0.03677823,
					   v_PhoneProbX = 'POTS-ZIPMATCH-CON'=> 0.01346091,
					   v_PhoneProbX = 'POTS-ZIPMATCH-DISCON' => 0.02983051,
					   v_PhoneProbX = 'POTS-ZIPNOMATCH'  => 0.03938274,
					   0.01726424);


	/* bt model var */

	/*verification;*/
	vb_creditsourced := le.bill_to_out.name_verification.lname_credit_sourced or le.bill_to_out.name_verification.lname_tu_sourced;

	vb_nas_i := map(le.bill_to_out.iid.nas_summary = 0 => 1,
				 le.bill_to_out.iid.nas_summary in [2,3,5] => 2,
				 le.bill_to_out.iid.nas_summary = 8 => 3,
				 1);

	vb_nap_i := map(le.bill_to_out.iid.nap_summary = 1 => 1,
				 le.bill_to_out.iid.nap_summary in [0,2,3] => 2,
				 le.bill_to_out.iid.nap_summary in [4,5,6,7,8,9,10] => 3,
				 le.bill_to_out.iid.nap_summary in [11,12] => 4,
				 2);

	vb_verx := map(vb_nap_i = 1 => map(vb_nas_i = 1 => 1,
								vb_nas_i = 2 => 3,
								4),
				vb_nap_i = 2 => map(vb_nas_i = 1 => 2,
								vb_nas_i = 2 => 4,
								if(~vb_creditsourced, 4.5, 5)),
				vb_nap_i = 3 => if(vb_nas_i = 1, 3, if(~vb_creditsourced, 4.5, 5)),
				if(vb_nas_i in [1,2], 6, if(~vb_creditsourced, 6, 7)));				// check out the above cluster for errors

	vb_verx_m := map(vb_verx = 1 => 0.0637097,
				  vb_verx = 2 => 0.0339934,
				  vb_verx = 3 => 0.0130342,
				  vb_verx = 4 => 0.0092404,
				  vb_verx = 4.5 => 0.0041885,
				  vb_verx = 5 => 0.0032229,
				  vb_verx = 6 => 0.0016168,
				  0.000672891);


	vb_lres_years_I2 := map(v_lres_years < 0 => 0,
					    v_lres_years < 7 => 1,
					    2);

	/* Property;*/

	vb_NaProp_Tree_m := map(NaProp_Tree = 0 => 0.01087076,
					    NaProp_Tree = 1 => 0.00223639,
					    NaProp_Tree = 2 => 0.00173857,
					    0.00445174);


	/* Add/Phone problem;*/

	vb_PhoneProbX_new_m := map(v_PhoneProbX = 'NOTPOTS-ZIPMATCH' => 0.00740683,
						  v_PhoneProbX = 'NOTPOTS-ZIPNOMATCH' => 0.01196191,
						  v_PhoneProbX = 'POTS-ZIPMATCH-CON' => 0.00252889,
						  v_PhoneProbX = 'POTS-ZIPMATCH-DISCON' => 0.00740363,
						  v_PhoneProbX = 'POTS-ZIPNOMATCH' => 0.02909596,
						  0.00445174);


	/* IS model var */

	/* verification;*/
	vi_verx := map(vb_nap_i = 1 => if(vb_nas_i = 1, 1, 3),
				vb_nap_i = 2 => map(vb_nas_i = 1 => 2,
								vb_nas_i = 2 => 3,
								if(vb_creditsourced, 5, 4)),
				vb_nap_i = 3 => if(vb_nas_i = 1, 3, if(vb_creditsourced, 5, 4)),
				if(vb_nas_i in [1,2], if(vb_creditsourced, 5, 4), if(vb_creditsourced, 6, 4)));

	vi_verx_m := map(vi_verx = 1 => 0.01136364,
				  vi_verx = 2 => 0.00801994,
				  vi_verx = 3 => 0.00218874,
				  vi_verx = 4 => 0.00134886,
				  vi_verx = 5 => 0.00081120,
				  vi_verx = 6 => 0.00038326,
				  0.00102799);


	/* Add/Phone problem;*/

	vi_addProbX_m := map(v_addProbX = '1 LR-NONAPT-MIL' => 0,
					 v_addProbX = '2 LR-NONAPT-NONMIL' => 0.00085945,
					 v_addProbX = '3 HR-NONAPT' => 0.00760456,
					 v_addProbX = '4 LR-APT' => 0.00154440,
					 v_addProbX = '5 HR-APT' => 0.00987306,
					 v_addProbX = '6 INVALID' => 0.00251889,
					 0.00102799);


	vi_phnprobX := map(v_pnotpots = 0 and phone_zip_mismatch = 1 => 1,
				    v_pnotpots = 1 or phone_zip_mismatch = 1 or disconnected = 1 or le.bill_to_out.phone_verification.hr_phone => 2,
				    3);

	vi_phnprobX_m := map(vi_phnprobX = 1 => 0.00268489,
					 vi_phnprobX = 2 => 0.00162861,
					 vi_phnprobX = 3 => 0.00069785,
					 0.00102799);

	/*** make shipto Boca var ***/

	/* st model var */

	/* Verification;*/

	vs_nas_st := map(le.ship_to_out.iid.nas_summary = 0 => 1,
				  le.ship_to_out.iid.nas_summary in [2,3,5] => 2,
				  le.ship_to_out.iid.nas_summary = 8 => 3,
				  -1);

	vs_nap_st := map(le.ship_to_out.iid.nap_summary = 1 => 1,
				  le.ship_to_out.iid.nap_summary in [0,2,3] => 2,
				  le.ship_to_out.iid.nap_summary in [4,5,7,8,9] => 3,
				  le.ship_to_out.iid.nap_summary = 6 => 4,
				  5);

	vs_verx_st := map(vs_nap_st = 1 => map(vs_nas_st = 1 => 1,
								    vs_nas_st = 2 => 2,
								    3),
				   vs_nap_st = 2 => map(vs_nas_st = 1 => 2,
								    vs_nas_st = 2 => 3,
								    4),
				   vs_nap_st = 3 => map(vs_nas_st = 1 => 3,
								    vs_nas_st = 2 => 4,
								    4),
				   vs_nap_st = 4 => map(vs_nas_st = 1 => 3,
								    vs_nas_st = 2 => 5,
								    5),
				   map(vs_nas_st = 1 => 5,
					  vs_nas_st = 2 => 6,
					  6));

	vs_verx_st_m := map(vs_verx_st = 1 => 0.05601700,
					vs_verx_st = 2 => 0.03714635,
					vs_verx_st = 3 => 0.01645429,
					vs_verx_st = 4 => 0.01069934,
					vs_verx_st = 5 => 0.00609394,
					vs_verx_st = 6 => 0.00399813,
					0.01726424);


	/* Property;*/

	property_owned_total_x_s := if(le.ship_to_out.address_verification.owned.property_total > 0, true, false);
	property_sold_total_x_s := if(le.ship_to_out.address_verification.sold.property_total > 0, true, false);
	property_ambig_total_x_s := if(le.ship_to_out.address_verification.ambiguous.property_total > 0, true, false);
	
	property_total_x_s := property_owned_total_x_s or property_sold_total_x_s or property_ambig_total_x_s;
	
	NaProp4_any_s := if(le.ship_to_out.address_verification.input_address_information.naprop = 4 or le.ship_to_out.address_verification.address_history_1.naprop = 4 or le.ship_to_out.address_verification.address_history_2.naprop = 4, 1,0);
	NaProp3_any_s := if(le.ship_to_out.address_verification.input_address_information.naprop = 3 or le.ship_to_out.address_verification.address_history_1.naprop = 3 or le.ship_to_out.address_verification.address_history_2.naprop = 3, 1,0);
	
	NaProp_Tree_s := map(NaProp4_any = 1 => 2,
				      NaProp3_any = 1 => 1,
				      0);

	vs_property_tree_st := map(le.ship_to_out.address_verification.input_address_information.naprop = 4 => 3,
						  le.ship_to_out.address_verification.input_address_information.family_owned => 3,
						  le.ship_to_out.address_verification.input_address_information.naprop in [2,3] => 1,
						  NaProp_Tree_s = 2 => 2,
						  NaProp_Tree_s = 1 or property_total_x_s => 1,
						  0);


	/* lres;*/

	v_add1_year_firstSeen_st := (integer)(string)(le.ship_to_out.address_verification.input_address_information.date_first_seen[1..4]);

	v_lres_years_st := if(v_add1_year_firstSeen_st = 0,  -999, (archive_y_st - v_add1_year_firstSeen_st));

	vs_lres_years_st := map(v_lres_years_st < 0 => 0,
					    v_lres_years_st <= 2 => 1,
					    v_lres_years_st <= 10 => 2,
					    3);

	vs_lres_years_st_m := map(vs_lres_years_st = 0 => 0.02273969,
						 vs_lres_years_st = 1 => 0.01158291,
						 vs_lres_years_st = 2 => 0.00789663,
						 vs_lres_years_st = 3 => 0.00657779,
						 0.01726424);



	/* Address/Phone Problem;*/


	v_pnotpots_st := if(le.ship_to_out.phone_verification.telcordia_type in ['00','50','51','52','54'], 0, 1);
	phone_zip_mismatch_s := (integer)le.ship_to_out.phone_verification.phone_zip_mismatch;
	disconnected_s := (integer)le.ship_to_out.phone_verification.disconnected;

	v_PhoneProbX_st := map(v_pnotpots_st = 0 and phone_zip_mismatch_s = 0 and disconnected_s = 0 and ~le.ship_to_out.phone_verification.hr_phone => 'POTS-ZIPMATCH-CON-LR',
					   v_pnotpots_st = 0 and phone_zip_mismatch_s = 0 and disconnected_s = 0 and le.ship_to_out.phone_verification.hr_phone => 'POTS-ZIPMATCH-CON-HR',
					   v_pnotpots_st = 0 and phone_zip_mismatch_s = 0 and disconnected_s = 1 => 'POTS-ZIPMATCH-DISCON',
					   v_pnotpots_st = 0 and phone_zip_mismatch_s = 1 => 'POTS-ZIPNOMATCH',
					   v_pnotpots_st = 1 and phone_zip_mismatch_s = 0 => 'NOTPOTS-ZIPMATCH',
					   v_pnotpots_st = 1 and phone_zip_mismatch_s = 1 => 'NOTPOTS-ZIPNOMATCH',
					   'WRONG');

	vs_PhoneProbX_st_m := map(v_PhoneProbX_st = 'NOTPOTS-ZIPMATCH' => 0.01852325,
						 v_PhoneProbX_st = 'NOTPOTS-ZIPNOMATCH' => 0.04600249,
						 v_PhoneProbX_st = 'POTS-ZIPMATCH-CON-HR' => 0.01639344,
						 v_PhoneProbX_st = 'POTS-ZIPMATCH-CON-LR' => 0.01238042,
						 v_PhoneProbX_st = 'POTS-ZIPMATCH-DISCON' => 0.03139013,
						 v_PhoneProbX_st = 'POTS-ZIPNOMATCH' => 0.02152328,
						 0.01726424);


	/*** make billto easi census var ***/

	/* bt model var */

	vb_C_MED_HHINC_raw := if(ri.easi.MED_HHINC in ['','0'], 90000, (real)ri.easi.MED_HHINC);
	v_C_FAMMAR_P10 := if(ri.easi.families in ['0',''], -99, ceil((real)ri.easi.FAMMAR_P/10)*10);

	vb_C_FAMMAR_P := map(v_C_FAMMAR_P10 = -99 => 0,
					 v_C_FAMMAR_P10 <= 10 => 10,
					 v_C_FAMMAR_P10);


	vb_C_FAMMAR_P_m := map(vb_C_FAMMAR_P = 0 => 0.00425961,
					   vb_C_FAMMAR_P = 10 => 0.10096670,
					   vb_C_FAMMAR_P = 20 => 0.03874346,
					   vb_C_FAMMAR_P = 30 => 0.02433628,
					   vb_C_FAMMAR_P = 40 => 0.01693138,
					   vb_C_FAMMAR_P = 50 => 0.01294745,
					   vb_C_FAMMAR_P = 60 => 0.01103526,
					   vb_C_FAMMAR_P = 70 => 0.00681333,
					   vb_C_FAMMAR_P = 80 => 0.00429748,
					   vb_C_FAMMAR_P = 90 => 0.00318898,
					   vb_C_FAMMAR_P = 100 => 0.00265202,
					   0.00445174);

	v_C_ROBBERY20 := ceil((real)ri.easi.ROBBERY/20)*20;

	vb_C_ROBBERY := map(ri.easi.robbery = '' => 0,
					v_C_ROBBERY20 <= 40 => v_C_ROBBERY20,
					v_C_ROBBERY20 <=120 => 80,
					v_C_ROBBERY20 <=160 => v_C_ROBBERY20,
					180);

	vb_C_ROBBERY_m := map(vb_C_ROBBERY = 0 => 0.00114025,
					  vb_C_ROBBERY = 20 => 0.00264934,
					  vb_C_ROBBERY = 40 => 0.00270447,
					  vb_C_ROBBERY = 80 => 0.00285731,
					  vb_C_ROBBERY = 140 => 0.00470166,
					  vb_C_ROBBERY = 160 => 0.00632588,
					  vb_C_ROBBERY = 180 => 0.01107325,
					  0.00445174);


	/* IS model var */

	v_C_MED_HHINC5000 := ceil((real)ri.easi.MED_HHINC/5000)*5000;

	vi_C_MED_HHINC := map(ri.easi.MED_HHINC = '' => 0,
					  v_C_MED_HHINC5000 <= 35000 => 35000,
					  v_C_MED_HHINC5000 <= 40000 => v_C_MED_HHINC5000,
					  v_C_MED_HHINC5000 <= 55000 => 47500,
					  47501);

	vi_C_MED_HHINC_m := map(vi_C_MED_HHINC = 0 => 0.00088106,
					    vi_C_MED_HHINC = 35000 => 0.00188608,
					    vi_C_MED_HHINC = 40000 => 0.00149487,
					    vi_C_MED_HHINC = 47500 => 0.00124816,
					    vi_C_MED_HHINC = 47501 => 0.00082361,
					    0.00102799);

	vi_C_FAMMAR_P := map(v_C_FAMMAR_P10 = -99 => 0,
					 v_C_FAMMAR_P10 <= 50 => 50,
					 v_C_FAMMAR_P10);

	vi_C_FAMMAR_P_m := map(vi_C_FAMMAR_P = 0 => 0.00112108,
					   vi_C_FAMMAR_P = 50 => 0.00204884,
					   vi_C_FAMMAR_P = 60 => 0.00158762,
					   vi_C_FAMMAR_P = 70 => 0.00144423,
					   vi_C_FAMMAR_P = 80 => 0.00112923,
					   vi_C_FAMMAR_P = 90 => 0.00083306,
					   vi_C_FAMMAR_P = 100 => 0.00078514,
					   0.00102799);

	vi_C_ROBBERY_high := (integer)(v_C_ROBBERY20 > 100);



	/*** make shipto easi census var ***/

	/* ST model var */

	v_C_FAMMAR_P_st := map(ri.easi2.FAMMAR_P= '' => -2,
					   ri.easi2.families = '0' => -1,
					   (real)ri.easi2.FAMMAR_P);

	vs_c_FAMMAR_P_st := if(v_c_FAMMAR_P_st < 0, 85, v_c_FAMMAR_P_st);


	v_lowed10_st := ceil((real)ri.easi2.LOW_ED/10)*10;

	vs_lowed_st := map(ri.easi2.low_ed = '' => 999,
				    v_lowed10_st < 80 => v_lowed10_st,
				    80);

	vs_lowed_st_m := map(vs_lowed_st = 0 => 0.00558036,
					 vs_lowed_st = 10 => 0.00729592,
					 vs_lowed_st = 20 => 0.01007328,
					 vs_lowed_st = 30 => 0.01199893,
					 vs_lowed_st = 40 => 0.01488747,
					 vs_lowed_st = 50 => 0.01706210,
					 vs_lowed_st = 60 => 0.02327427,
					 vs_lowed_st = 70 => 0.03884491,
					 vs_lowed_st = 80 => 0.05300314,
					 vs_lowed_st = 999 => 0.00977995,
					 0.01726424);

	v_C_ROBBERY20_st := ceil((real)ri.easi2.ROBBERY/20)*20;

	vs_C_ROBBERY_st := map(ri.easi2.robbery = '' => 999,
					   v_C_ROBBERY20_st < 60 => v_C_ROBBERY20_st,
					   v_C_ROBBERY20_st < 140 => 100,
					   v_C_ROBBERY20_st);

	vs_C_ROBBERY_st_m := map(vs_C_ROBBERY_st = 20 => 0.00909526,
						vs_C_ROBBERY_st = 40 => 0.00996483,
						vs_C_ROBBERY_st = 100 => 0.01049009,
						vs_C_ROBBERY_st = 140 => 0.01952429,
						vs_C_ROBBERY_st = 160 => 0.02331642,
						vs_C_ROBBERY_st = 180 => 0.03253707,
						vs_C_ROBBERY_st = 200 => 0.03489005,
						vs_C_ROBBERY_st = 999 => 0.00977995,
						0.01726424);


	/*** scoring ***/

	uv_shipto := if((integer)le.eddo.addrscore < 100, 1, 0);

	uv_instore := if(ri.cd2i.shipmode = '', 1, 0);

	uv_dataset := map(uv_instore = 1 => 'IS',
				   uv_shipto = 1 => 'ST',
				   'BT ');
			   
	logit := map(uv_dataset = 'ST'=>
								-11.41254158
								   + vs_order_amt  * 0.0064513686
								   + vs_order_amt_ge1400  * 0.6885416165
								   + vs_avscode_m  * 27.093968429
								   + vs_cid_m  * 39.352831415
								   + vs_shippingMode_m  * 19.765967785
								   + vs_govmil_domain_f  * -1.067372034
								   + vs_IP_connection_m  * 5.0545842299
								   + vs_IPStateMatchCode_m  * 19.890079532
								   + vs_IST_nameDiff_m  * 49.380495872
								   + vs_distX  * 0.3826888917
								   + vs_verx_bt_m  * 14.879070588
								   + v_no_rel_f  * 0.1674996646
								   + vs_PhoneProbX_m  * 14.933890444
								   + vs_verx_st_m  * 30.164143582
								   + vs_property_tree_st  * -0.15175826
								   + vs_lres_years_st_m  * 11.765479907
								   + vs_PhoneProbX_st_m  * 12.839918104
								   + vs_lowed_st_m  * 18.928204756
								   + vs_C_ROBBERY_st_m  * 17.069847307
								   + vs_c_FAMMAR_P_st  * -0.005984273,
						
						
			   uv_dataset = 'BT' =>
								-13.57351047
								   + vb_CUS_ORDER_AMT  * 1.0458639562
								   + vb_avs_bad_f  * 2.8706879799
								   + vb_shippingMode_m  * 76.095561055
								   + vb_avscode_m  * 1.8036262095
								   + vb_cid_nonMatch_f  * 0.3632105019
								   + vb_mil_domain_f  * -1.928029898
								   + vb_IP_connection_x_m  * 108.49256657
								   + vb_IPStateMatchCode_m  * 13.597085001
								   + vb_verx_m  * 24.63884963
								   + vb_NaProp_Tree_m  * 37.078297804
								   + vb_lres_years_I2  * -0.409265898
								   + vb_PhoneProbX_new_m  * 49.312013511
								   + vb_C_MED_HHINC_raw  * -3.59178E-6
								   + vb_C_FAMMAR_P_m  * 7.3692092381
								   + vb_C_ROBBERY_m  * 39.569191056,
						
						
			   -10.85232751
				   + vi_order_amt_m  * 171.33674569
				   + vb_avs_bad_f  * 3.2893066506
				   + vi_avscode_m  * 24.148215563
				   + vi_cid_nonMatch_f  * 1.1658163067
				   + vi_IP_connection_x_m  * 177.4426706
				   + vi_IPStateMatchCode_m  * 50.185983745
				   + vi_verx_m  * 62.907785651
				   + vi_phnprobX_m  * 370.48859169
				   + vi_addProbX_m  * 145.91924356
				   + vi_C_MED_HHINC_m  * 379.78471218
				   + vi_C_FAMMAR_P_m  * 393.9984306
				   + vi_C_ROBBERY_high  * 0.3744696803);
				   
	phat := (exp(logit )) / (1+exp(logit ));
		
			   


	base := 660;
	point :=  -25;
	odds := 0.0059373;

	CDN606_1_0 := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

	score := map(CDN606_1_0 < 250 => 250,
			   CDN606_1_0 > 999 => 999,
			   CDN606_1_0);
			   
	self.score := (string)score;
	self.seq := le.bill_to_out.seq;
	self.ri := [];
END;
model := join(clam, ineasi, left.bill_to_out.seq=(right.cd2i.seq*2), doModel(left,right), left outer);



// need to project billto boca shell results into layout.output
Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
	self.seq := le.Bill_To_Out.seq;
	self.socllowissue := (string)le.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.Bill_To_Out.iid.NAS_summary;
	self := le.Bill_To_Out.iid;
	self := le.Bill_To_Out.shell_input;
	self := [];
END;
iidBT := project(clam, into_layout_output(left));

RiskWise.Layout_IP2O fill_ip(clam le) := TRANSFORM
	self.countrycode := le.ip2o.countrycode[1..2];
	self := le.ip2o;
END;
ipInfo := PROJECT(clam, fill_ip(left));


Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
	self.seq := le.seq;
	self.ri := RiskWise.cdReasonCodes(le, 6, rt, true, IBICID);
	self := [];
END;
BTReasons := join(iidBT, ipInfo, left.seq = right.seq, addBTReasons(left, right), left outer);

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
	self := le.Ship_To_Out.iid;
	self := le.Ship_To_Out.shell_input;
	self := [];
END;
iidST := project(clam, into_layout_output2(left));


Layout_ModelOut addSTReasons(iidST le, ipInfo rt) := TRANSFORM
	self.seq := le.seq;
	self.ri := RiskWise.cdReasonCodes(le, 6, rt, false, IBICID);
	self := [];
END;
STReasons := join(iidST, ipInfo, left.seq=((right.seq*2)-1), addSTReasons(left, right), left outer);

Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := TRANSFORM
	self.ri := le.ri + rt.ri;
	self := le;
END;
STRecord := JOIN(BTRecord, STReasons, ((left.seq*2)-1) = right.seq, fillReasons2(left,right), left outer);

RETURN (STRecord);

END;

