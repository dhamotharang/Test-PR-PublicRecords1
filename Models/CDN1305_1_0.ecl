IMPORT EASI, Business_Risk, ut, RiskWise, RiskWiseFCRA, Risk_Indicators;

EXPORT cdn1305_1_0 (GROUPED DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
										DATASET(Models.Layout_CD_CustomModelInputs) customInputs,
										BOOLEAN IBICID,
										BOOLEAN WantstoSeeBillToShipToDifferenceFlag) := FUNCTION

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
		Layout_Debug := RECORD, maxlength(50000)
			
			string  AVS;
			real	  product_dollars;
			string	ship_method;
			string	pay_method;
			boolean avs_addr                         ;  //avs_addr;
			boolean avs_zip                          ;  //avs_zip;
			string  pf_pmt_type                      ;  //pf_pmt_type;
			boolean bt_add_apt                       ;  //bt_add_apt;
			boolean st_add_apt                       ;  //st_add_apt;
			integer bt_bus_addr_match_count          ;  //bt_bus_addr_match_count;
			string  st_vp091_phnzip_mismatch         ;  //st_vp091_phnzip_mismatch;
			integer st_adls_per_sfd_addr_c6          ;  //st_adls_per_sfd_addr_c6;
			boolean ver_phn_inf_s                    ;  //ver_phn_inf_s;
			boolean ver_phn_nap_s                    ;  //ver_phn_nap_s;
			integer inf_phn_ver_lvl_s                ;  //inf_phn_ver_lvl_s;
			integer nap_phn_ver_lvl_s                ;  //nap_phn_ver_lvl_s;
			string  st_nap_phn_ver_x_inf_phn_ver     ;  //st_nap_phn_ver_x_inf_phn_ver;
			string  btst_email_first_x_last_score    ;  //btst_email_first_x_last_score;
			string  ip_routingmethod                 ;  //ip_routingmethod;
			string  bt_phn_miskey                    ;  //bt_phn_miskey;
			string  st_va011_add_business            ;  //st_va011_add_business;
			string  st_bus_phone_match               ;  //st_bus_phone_match;
			integer st_max_ids_per_sfd_addr_c6       ;  //st_max_ids_per_sfd_addr_c6;
			string  bt_fp_validationrisktype         ;  //bt_fp_validationrisktype;
			string  st_vp001_phn_not_issued          ;  //st_vp001_phn_not_issued;
			integer st_inq_highriskcredit_recency    ;  //st_inq_highriskcredit_recency;
			string  ip_dma_lvl                       ;  //ip_dma_lvl;
			string  bt_fp_idverrisktype              ;  //bt_fp_idverrisktype;
			integer bt_fp_srchfraudsrchcount         ;  //bt_fp_srchfraudsrchcount;
			string  st_fp_srchvelocityrisktype       ;  //st_fp_srchvelocityrisktype;
			string  btst_relatives_lvl               ;  //btst_relatives_lvl;
			string  bt_vp091_phnzip_mismatch         ;  //bt_vp091_phnzip_mismatch;
			string  bt_po001_inp_addr_naprop         ;  //bt_po001_inp_addr_naprop;
			string  bt_bus_name_match                ;  //bt_bus_name_match;
			boolean ver_phn_inf                      ;  //ver_phn_inf;
			boolean ver_phn_nap                      ;  //ver_phn_nap;
			integer inf_phn_ver_lvl                  ;  //inf_phn_ver_lvl;
			integer nap_phn_ver_lvl                  ;  //nap_phn_ver_lvl;
			string  bt_nap_phn_ver_x_inf_phn_ver     ;  //bt_nap_phn_ver_x_inf_phn_ver;
			integer bt_in001_estimated_income        ;  //bt_in001_estimated_income;
			integer bt_max_lres                      ;  //bt_max_lres;
			integer bt_adls_per_sfd_addr             ;  //bt_adls_per_sfd_addr;
			string  ip_state_match                   ;  //ip_state_match;
			boolean addr_match                       ;  //addr_match;
			string  tidi_seg1_lvl                    ;  //tidi_seg1_lvl;
			real    seg1r_subscore0                  ;  //seg1r_subscore0;
			real    seg1r_subscore1                  ;  //seg1r_subscore1;
			real    seg1r_subscore2                  ;  //seg1r_subscore2;
			real    seg1r_subscore3                  ;  //seg1r_subscore3;
			real    seg1r_subscore4                  ;  //seg1r_subscore4;
			real    seg1r_subscore5                  ;  //seg1r_subscore5;
			real    seg1r_subscore6                  ;  //seg1r_subscore6;
			real    seg1r_subscore7                  ;  //seg1r_subscore7;
			real    seg1r_subscore8                  ;  //seg1r_subscore8;
			real    seg1r_subscore9                  ;  //seg1r_subscore9;
			real    seg1r_rawscore                   ;  //seg1r_rawscore;
			real    seg1r_lnoddsscore                ;  //seg1r_lnoddsscore;
			real    seg2r_subscore0                  ;  //seg2r_subscore0;
			real    seg2r_subscore1                  ;  //seg2r_subscore1;
			real    seg2r_subscore2                  ;  //seg2r_subscore2;
			real    seg2r_subscore3                  ;  //seg2r_subscore3;
			real    seg2r_subscore4                  ;  //seg2r_subscore4;
			real    seg2r_subscore5                  ;  //seg2r_subscore5;
			real    seg2r_subscore6                  ;  //seg2r_subscore6;
			real    seg2r_subscore7                  ;  //seg2r_subscore7;
			real    seg2r_subscore8                  ;  //seg2r_subscore8;
			real    seg2r_subscore9                  ;  //seg2r_subscore9;
			real    seg2r_subscore10                 ;  //seg2r_subscore10;
			real    seg2r_subscore11                 ;  //seg2r_subscore11;
			real    seg2r_rawscore                   ;  //seg2r_rawscore;
			real    seg2r_lnoddsscore                ;  //seg2r_lnoddsscore;
			real    seg3r_subscore0                  ;  //seg3r_subscore0;
			real    seg3r_subscore1                  ;  //seg3r_subscore1;
			real    seg3r_subscore2                  ;  //seg3r_subscore2;
			real    seg3r_subscore3                  ;  //seg3r_subscore3;
			real    seg3r_subscore4                  ;  //seg3r_subscore4;
			real    seg3r_subscore5                  ;  //seg3r_subscore5;
			real    seg3r_subscore6                  ;  //seg3r_subscore6;
			real    seg3r_subscore7                  ;  //seg3r_subscore7;
			real    seg3r_subscore8                  ;  //seg3r_subscore8;
			real    seg3r_subscore9                  ;  //seg3r_subscore9;
			real    seg3r_subscore10                 ;  //seg3r_subscore10;
			real    seg3r_subscore11                 ;  //seg3r_subscore11;
			real    seg3r_rawscore                   ;  //seg3r_rawscore;
			real    seg3r_lnoddsscore                ;  //seg3r_lnoddsscore;
			real    seg4r_subscore0                  ;  //seg4r_subscore0;
			real    seg4r_subscore1                  ;  //seg4r_subscore1;
			real    seg4r_subscore2                  ;  //seg4r_subscore2;
			real    seg4r_subscore3                  ;  //seg4r_subscore3;
			real    seg4r_subscore4                  ;  //seg4r_subscore4;
			real    seg4r_subscore5                  ;  //seg4r_subscore5;
			real    seg4r_subscore6                  ;  //seg4r_subscore6;
			real    seg4r_rawscore                   ;  //seg4r_rawscore;
			real    seg4r_lnoddsscore                ;  //seg4r_lnoddsscore;
			real    seg5r_subscore0                  ;  //seg5r_subscore0;
			real    seg5r_subscore1                  ;  //seg5r_subscore1;
			real    seg5r_subscore2                  ;  //seg5r_subscore2;
			real    seg5r_subscore3                  ;  //seg5r_subscore3;
			real    seg5r_subscore4                  ;  //seg5r_subscore4;
			real    seg5r_subscore5                  ;  //seg5r_subscore5;
			real    seg5r_subscore6                  ;  //seg5r_subscore6;
			real    seg5r_subscore7                  ;  //seg5r_subscore7;
			real    seg5r_subscore8                  ;  //seg5r_subscore8;
			real    seg5r_rawscore                   ;  //seg5r_rawscore;
			real    seg5r_lnoddsscore                ;  //seg5r_lnoddsscore;
			real    seg6r_subscore0                  ;  //seg6r_subscore0;
			real    seg6r_subscore1                  ;  //seg6r_subscore1;
			real    seg6r_subscore2                  ;  //seg6r_subscore2;
			real    seg6r_subscore3                  ;  //seg6r_subscore3;
			real    seg6r_subscore4                  ;  //seg6r_subscore4;
			real    seg6r_subscore5                  ;  //seg6r_subscore5;
			real    seg6r_subscore6                  ;  //seg6r_subscore6;
			real    seg6r_subscore7                  ;  //seg6r_subscore7;
			real    seg6r_subscore8                  ;  //seg6r_subscore8;
			real    seg6r_subscore9                  ;  //seg6r_subscore9;
			real    seg6r_subscore10                 ;  //seg6r_subscore10;
			real    seg6r_subscore11                 ;  //seg6r_subscore11;
			real    seg6r_rawscore                   ;  //seg6r_rawscore;
			real    seg6r_lnoddsscore                ;  //seg6r_lnoddsscore;
			integer model_segment                    ;  //model_segment;
			real    final_score                      ;  //final_score;
			integer base                             ;  //base;
			integer pts                              ;  //pts;
			integer odds                             ;  //odds;
			integer cdn1305_1_0                      ;  //cdn1305_1_0;
			models.layout_modelout;
			Risk_Indicators.Layout_BocaShell_BtSt_Out clam;
		END;
		Layout_Debug doModel(clam_with_easi le, customInputs ri) := TRANSFORM
	#else
		Layout_ModelOut doModel( clam_with_easi le, customInputs ri ) := TRANSFORM
	#end

		AVS                              := ri.TD_avs;
		PAY_METHOD                       := ri.TD_pay_method;
		PRODUCT_DOLLARS                  := ri.TD_product_dollars;
		SHIP_METHOD                      := ri.TD_ship_method;
		C_BORN_USA                       := le.census.easi.born_usa;
		C_HHSIZE_s                       := le.census.easi2.hhsize;
		efirstscore                      := le.bs.eddo.efirstscore;
		elastscore                       := le.bs.eddo.elastscore;
		ipaddr                           := le.bs.ip2o.ipaddr;
		iproutingmethod                  := le.bs.ip2o.iproutingmethod;
		ipdma                            := le.bs.ip2o.ipdma;
		btst_are_relatives               := le.bs.eddo.btst_are_relatives;
		btst_relatives_in_common         := le.bs.eddo.btst_relatives_in_common;
		state                            := le.bs.ip2o.state;
		addrscore                        := le.bs.eddo.addrscore;
		distaddraddr2                    := le.bs.eddo.distaddraddr2;
		did                              := le.bs.Bill_To_Out.did;
		truedid                          := le.bs.Bill_To_Out.truedid;
		out_unit_desig                   := le.bs.Bill_To_Out.shell_input.unit_desig;
		out_sec_range                    := le.bs.Bill_To_Out.shell_input.sec_range;
		out_st                           := le.bs.Bill_To_Out.shell_input.st;
		out_z5                           := le.bs.Bill_To_Out.shell_input.z5;
		out_addr_type                    := le.bs.Bill_To_Out.shell_input.addr_type;
		nap_summary                      := le.bs.Bill_To_Out.iid.nap_summary;
		rc_phonezipflag                  := le.bs.Bill_To_Out.iid.phonezipflag;
		rc_pwphonezipflag                := le.bs.Bill_To_Out.iid.pwphonezipflag;
		rc_dwelltype                     := le.bs.Bill_To_Out.iid.dwelltype;
		rc_hphonemiskeyflag              := le.bs.Bill_To_Out.iid.hphonemiskeyflag;
		bus_addr_match_count             := le.bs.Bill_To_Out.business_header_address_summary.bus_addr_match_cnt;
		bus_name_match                   := le.bs.Bill_To_Out.business_header_address_summary.bus_name_match;
		addrpop                          := le.bs.Bill_To_Out.input_validation.address;
		hphnpop                          := le.bs.Bill_To_Out.input_validation.homephone;
		add1_naprop                      := le.bs.Bill_To_Out.address_verification.input_address_information.naprop;
		max_lres                         := le.bs.Bill_To_Out.other_address_info.max_lres;
		adls_per_addr                    := le.bs.Bill_To_Out.velocity_counters.adls_per_addr;
		fp_idverrisktype                 := le.bs.Bill_To_Out.fdattributesv2.idverrisklevel;
		fp_srchfraudsrchcount            := le.bs.Bill_To_Out.fdattributesv2.searchfraudsearchcount;
		fp_validationrisktype            := le.bs.Bill_To_Out.fdattributesv2.validationrisklevel;
		estimated_income                 := le.bs.Bill_To_Out.estimated_income;
		did_s                            := le.bs.Ship_To_Out.did;
		truedid_s		                     := le.bs.Ship_To_Out.truedid;
		out_unit_desig_s                 := le.bs.Ship_To_Out.shell_input.unit_desig;
		out_sec_range_s                  := le.bs.Ship_To_Out.shell_input.sec_range;
		out_z5_s                         := le.bs.Ship_To_Out.shell_input.z5;
		out_addr_type_s                  := le.bs.Ship_To_Out.shell_input.addr_type;
		nap_summary_s                    := le.bs.Ship_To_Out.iid.nap_summary;
		rc_phonezipflag_s                := le.bs.Ship_To_Out.iid.phonezipflag;
		rc_pwphonezipflag_s              := le.bs.Ship_To_Out.iid.pwphonezipflag;
		rc_dwelltype_s                   := le.bs.Ship_To_Out.iid.dwelltype;
		bus_phone_match	                 := le.bs.Ship_To_Out.business_header_address_summary.bus_phone_match;
		addrpop_s                        := le.bs.Ship_To_Out.input_validation.address;
		hphnpop_s                        := le.bs.Ship_To_Out.input_validation.homephone;
		adls_per_addr_c6_s               := le.bs.Ship_To_Out.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6_s               := le.bs.Ship_To_Out.velocity_counters.ssns_per_addr_created_6months;
		inq_highRiskCredit_count_s       := le.bs.Ship_To_Out.acc_logs.highriskcredit.counttotal;
		inq_highRiskCredit_count01_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count01;
		inq_highRiskCredit_count03_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count03;
		inq_highRiskCredit_count06_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count06;
		inq_highRiskCredit_count12_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count12;
		inq_highRiskCredit_count24_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count24;
		fp_srchvelocityrisktype_s        := le.bs.Ship_To_Out.fdattributesv2.searchvelocityrisklevel;
		add1_pop                         := le.bs.Bill_To_Out.addrpop;
		infutor_nap                      := le.bs.Bill_To_Out.infutor_phone.infutor_nap;
		add1_advo_res_or_business_s      := le.bs.Ship_To_Out.advo_input_addr.residential_or_business_ind;
		add1_pop_s                       := le.bs.Ship_To_Out.addrpop;
		infutor_nap_s                    := le.bs.Ship_To_Out.infutor_phone.infutor_nap;
		isShipToBillToDifferent					 := le.bs.isShipToBillToDifferent;
//		attr 														 := Models.Attributes_Master(le,true);
//		BillToShipToAssociated					 := (integer)attr.BillToShipToAssociated;

NULL := -999999999;

avs_addr := (AVS in ['A3', 'A7', 'B3', 'B7', 'I1', 'I3', 'I7']);

avs_zip := (AVS in ['A3', 'A4', 'B3', 'B4', 'I1', 'I2', 'I3', 'I4']);

pf_pmt_type := map(
		PAY_METHOD = 'VM'						 => 'PayPal Card     ',
    PAY_METHOD = 'AX'            => 'American Express',
    (PAY_METHOD in ['BL', 'BP']) => 'BillMe Later    ',
    (PAY_METHOD in ['CM'])       => 'Check in Mail   ',
    (PAY_METHOD in ['DI'])       => 'Discover        ',
    (PAY_METHOD in ['GG'])       => 'Google Checkout ',
    (PAY_METHOD in ['MC'])       => 'MasterCard      ',
    (PAY_METHOD in ['MX'])       => 'Multiple Cards  ',
    (PAY_METHOD in ['OA'])       => 'Open Account    ',
    (PAY_METHOD in ['PP'])       => 'PayPal Card     ',
    (PAY_METHOD in ['PX'])       => 'Exchange Credits',
    (PAY_METHOD in ['VI'])       => 'Visa            ',
    (PAY_METHOD in ['WT'])       => 'Wire Transfer   ',
                                    'OTHER');

bt_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

st_add_apt := StringLib.StringToUpperCase(trim((string)rc_dwelltype_s, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim((string)out_addr_type_s, LEFT, RIGHT)) = 'H' or out_unit_desig_s != ' ' or out_sec_range_s != ' ';

bt_bus_addr_match_count := if(not(add1_pop), NULL, bus_addr_match_count);

st_vp091_phnzip_mismatch := map(
    not((boolean)(integer)hphnpop_s and not(out_z5_s = '')) 	=> ' ',
    rc_phonezipflag_s = '1' or rc_pwphonezipflag_s = '1'      => '1',
    rc_phonezipflag_s = '0' or rc_pwphonezipflag_s = '0'      => '0',
                                                                 ' ');

st_adls_per_sfd_addr_c6 := map(
    not((boolean)(integer)add1_pop_s) => NULL,
    st_add_apt                        => -1,
                                         adls_per_addr_c6_s);

ver_phn_inf_s := (infutor_nap_s in [4, 6, 7, 9, 10, 11, 12]);

ver_phn_nap_s := (nap_summary_s in [4, 6, 7, 9, 10, 11, 12]);

inf_phn_ver_lvl_s := map(
    ver_phn_inf_s     => 3,
    infutor_nap_s = 1 => 1,
    infutor_nap_s = 0 => 0,
                         2);

nap_phn_ver_lvl_s := map(
    ver_phn_nap_s     => 3,
    nap_summary_s = 1 => 1,
    nap_summary_s = 0 => 0,
                         2);

st_nap_phn_ver_x_inf_phn_ver := map(
    not((boolean)(integer)addrpop_s or (boolean)(integer)hphnpop_s) => '   ',
    not((boolean)(integer)hphnpop_s)                                => ' -1',
                                                                       trim((string)nap_phn_ver_lvl_s, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl_s, LEFT, RIGHT));

btst_email_first_x_last_score := trim(efirstscore, LEFT, RIGHT) + trim(':', LEFT, RIGHT) + trim(elastscore, LEFT, RIGHT);

ip_routingmethod := map(
    ipaddr = ''		          => '  ',
    iproutingmethod = ''  	=> '-1',
                               iproutingmethod);

bt_phn_miskey := if(not(truedid and (hphnpop or addrpop)), '', if(rc_hphonemiskeyflag, '1', '0'));

st_va011_add_business := map(
    not((boolean)(integer)add1_pop_s)                                                  => ' ',
    (trim(trim((string)add1_advo_res_or_business_s, LEFT), LEFT, RIGHT) in ['B', 'D']) => '1',
                                                                                          '0');

st_bus_phone_match := if(not((boolean)(integer)add1_pop_s), '', (string)bus_phone_match);

st_max_ids_per_sfd_addr_c6 := map(
    not((boolean)(integer)add1_pop_s) => NULL,
    st_add_apt                        => -1,
                                         max(adls_per_addr_c6_s, ssns_per_addr_c6_s));

bt_fp_validationrisktype := if(not(truedid), '', trim((string)fp_validationrisktype, LEFT));

st_vp001_phn_not_issued := map(
    not((boolean)(integer)hphnpop_s) => '',
    (rc_pwphonezipflag_s in ['4'])   => '1',
                                        '0');

st_inq_highriskcredit_recency := map(
    not((boolean)(integer)truedid_s) => NULL,
    inq_highRiskCredit_count01_s >0  => 1,
    inq_highRiskCredit_count03_s >0  => 3,
    inq_highRiskCredit_count06_s >0  => 6,
    inq_highRiskCredit_count12_s >0  => 12,
    inq_highRiskCredit_count24_s >0  => 24,
    inq_highRiskCredit_count_s   >0  => 99,
                                        0);

ip_dma_lvl := map(
    ipaddr = ''        				=> '               ',
    ipdma = ''         				=> '1. Missing DMA ',
    ipdma = '-1'       				=> '2. DMA: -1     ',
    ipdma = '0'        				=> '3. DMA: 0      ',
    length(trim(ipdma)) = 3  	=> '4. DMA: US Code',
    length(trim(ipdma)) != 3 	=> '5. DMA: Unkown ',
																 '6. Other');

bt_fp_idverrisktype := if(not(truedid), '', trim((string)fp_idverrisktype, LEFT));

bt_fp_srchfraudsrchcount := if(not(truedid), NULL, (integer)fp_srchfraudsrchcount);

st_fp_srchvelocityrisktype := if(not((boolean)(integer)truedid_s), '', trim((string)fp_srchvelocityrisktype_s, LEFT));

btst_relatives_lvl := map(
    did = 0 and did_s = 0    => '1. BOTH DID 0         ',
    did = 0                  => '2. BILLTO DID 0       ',
    did_s = 0                => '3. SHIPTO DID 0       ',
    did = did_s              => '4. DIDS EQUAL         ',
    btst_are_relatives       => '5. RELATIVES          ',
    btst_relatives_in_common => '6. RELATIVES IN COMMON',
                                '7. NO RELATION');

bt_vp091_phnzip_mismatch := map(
    not(hphnpop and not(out_z5 = ''))                => '',
    rc_phonezipflag = '1' or rc_pwphonezipflag = '1' => '1',
    rc_phonezipflag = '0' or rc_pwphonezipflag = '0' => '0',
                                                        ' ');

bt_po001_inp_addr_naprop := if(not(add1_pop), '', (string)add1_naprop);

bt_bus_name_match := if(not(add1_pop), '', (string)bus_name_match);

ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

inf_phn_ver_lvl := map(
    ver_phn_inf     => 3,
    infutor_nap = 1 => 1,
    infutor_nap = 0 => 0,
                       2);

nap_phn_ver_lvl := map(
    ver_phn_nap     => 3,
    nap_summary = 1 => 1,
    nap_summary = 0 => 0,
                       2);

bt_nap_phn_ver_x_inf_phn_ver := map(
    not(addrpop or hphnpop) => '   ',
    not(hphnpop)            => ' -1',
                               trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT));

bt_in001_estimated_income := if(not(truedid), NULL, estimated_income);

bt_max_lres := if(not(truedid), NULL, max_lres);

bt_adls_per_sfd_addr := map(
    not(add1_pop) => NULL,
    bt_add_apt    => -1,
                     adls_per_addr);

ip_state_match := if(out_st = '' or state = '', '', if(StringLib.StringToUpperCase(trim(out_st, LEFT, RIGHT)) = StringLib.StringToUpperCase(trim(state, LEFT, RIGHT)), '1', '0'));

addr_match := 80 <= (integer)addrscore AND (integer)addrscore <= 100 or not((boolean)(integer)addrpop_s);

tidi_seg1_lvl_c32 := map(
    (btst_relatives_lvl in ['1. BOTH DID 0', '2. BILLTO DID 0']) => '1. ST - BT DID 0',
    btst_relatives_lvl = '3. SHIPTO DID 0'                       => '2. ST - ST DID 0',
    btst_relatives_lvl = '7. NO RELATION'                        => '3. ST - NO REL  ',
                                                                    '4. ST - OTHER   ');

tidi_seg1_lvl_c33 := if((btst_relatives_lvl in ['1. BOTH DID 0', '2. BILLTO DID 0']), '5. BT - BT DID 0', '6. BT - OTHER   ');

tidi_seg1_lvl := if(not addr_match , tidi_seg1_lvl_c32, tidi_seg1_lvl_c33);

seg1r_subscore0 := map(
    NULL < bt_bus_addr_match_count AND bt_bus_addr_match_count < 1 => -0.710506,
    1 <= bt_bus_addr_match_count AND bt_bus_addr_match_count < 10  => -0.203754,
    10 <= bt_bus_addr_match_count                                  => 0.600264,
                                                                      -0.000000);

seg1r_subscore1 := map(
    (st_vp091_phnzip_mismatch in ['0'])     => 0.316625,
    (st_vp091_phnzip_mismatch in ['1'])     => -0.743992,
                                               -0.000000);

seg1r_subscore2 := map(
    NULL < st_adls_per_sfd_addr_c6 AND st_adls_per_sfd_addr_c6 < 0 => -0.000000,
    0 <= st_adls_per_sfd_addr_c6 AND st_adls_per_sfd_addr_c6 < 3   => 0.237641,
    3 <= st_adls_per_sfd_addr_c6                                   => -1.218789,
                                                                      -0.000000);

seg1r_subscore3 := map(
    (st_nap_phn_ver_x_inf_phn_ver in ['-1'])                                            => 0.000000,
    (st_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-0', '2-1']) => -0.312632,
    (st_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-0', '3-1', '3-3'])               => 1.315989,
                                                                                           0.000000);

seg1r_subscore4 := map(
    NULL < PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 200 => 0.471728,
    200 <= PRODUCT_DOLLARS                           => -0.406456,
                                                        0.000000);

seg1r_subscore5 := map(
    (SHIP_METHOD in ['01', '52'])                                                                                     => -0.934944,
    (SHIP_METHOD in ['03', '05', '07', '19', '20', '33', '35', '38', '50', '53', '62', '66', '80', '83', '88', '91']) => 0.046705,
    (SHIP_METHOD in ['02'])                                                                                           => 0.719222,
                                                                                                                         -0.000000);

seg1r_subscore6 := map(
    distaddraddr2 = ''																							=> 0.000000,
    NULL < (integer)distaddraddr2 AND (integer)distaddraddr2 < 20 	=> 1.324448,
    20 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 215 	=> 0.088628,
    215 <= (integer)distaddraddr2                        						=> -1.086738,
																																			 0.000000);

seg1r_subscore7 := map(
    (btst_email_first_x_last_score in ['0:0'])                                                                                                                              => -0.447249,
    (btst_email_first_x_last_score in ['-1:-1', '-1:0', '-1:1', '0:-1', '0:1', '0:2', '1:-1', '1:0', '1:1', '1:2', '1:3', '2:0', '2:1', '2:2', '2:3', '3:1', '3:2', '3:3']) => 0.516252,
                                                                                                                                                                               -0.000000);

seg1r_subscore8 := map(
    (ip_routingmethod in ['02', '16'])                                        => -1.658080,
    (ip_routingmethod in ['Other', '06', '10', '11', '12', '13', '14', '15']) => 0.155662,
                                                                                 -0.000000);

seg1r_subscore9 := map(
    (pf_pmt_type in ['American Express', 'PayPal Card'])                                    => 0.927750,
    (pf_pmt_type in ['BillMe Later', 'Google Checkout', 'Multiple Cards', 'OTHER', 'Visa']) => 0.277163,
    (pf_pmt_type in ['Discover', 'MasterCard'])                                             => -0.770601,
                                                                                               -0.000000);

seg1r_rawscore := seg1r_subscore0 +
    seg1r_subscore1 +
    seg1r_subscore2 +
    seg1r_subscore3 +
    seg1r_subscore4 +
    seg1r_subscore5 +
    seg1r_subscore6 +
    seg1r_subscore7 +
    seg1r_subscore8 +
    seg1r_subscore9;

seg1r_lnoddsscore := seg1r_rawscore + 2.330662;

seg2r_subscore0 := map(
    (bt_phn_miskey in ['0']) 					=> 0.053237,
    (bt_phn_miskey in ['1'])          => -1.536872,
                                         0.000000);

seg2r_subscore1 := map(
		C_HHSIZE_s = ''																				=> -0.000000,
    NULL < (real)C_HHSIZE_s AND (real)C_HHSIZE_s < 2.36  	=> 0.415904,
    2.36 <= (real)C_HHSIZE_s AND (real)C_HHSIZE_s < 2.62 	=> 0.130922,
    2.62 <= (real)C_HHSIZE_s AND (real)C_HHSIZE_s < 2.84 	=> -0.254385,
    2.84 <= (real)C_HHSIZE_s                       				=> -0.546154,
																														 -0.000000);

seg2r_subscore2 := map(
    (st_vp091_phnzip_mismatch in ['0']) 				 => 0.253159,
    (st_vp091_phnzip_mismatch in ['1'])          => -0.778895,
                                                    0.000000);

seg2r_subscore3 := map(
    (st_va011_add_business in ['Other', '0']) => -0.239219,
    (st_va011_add_business in ['1'])          => 0.643353,
                                                 -0.000000);

seg2r_subscore4 := map(
    (st_bus_phone_match in ['Other', '0', '1', '2']) => -0.207898,
    (st_bus_phone_match in ['3'])                    => 1.298175,
                                                        -0.000000);

seg2r_subscore5 := map(
    NULL < st_max_ids_per_sfd_addr_c6 AND st_max_ids_per_sfd_addr_c6 < 0 => -0.069917,
    0 <= st_max_ids_per_sfd_addr_c6 AND st_max_ids_per_sfd_addr_c6 < 1   => 0.360148,
    1 <= st_max_ids_per_sfd_addr_c6 AND st_max_ids_per_sfd_addr_c6 < 3   => -0.068533,
    3 <= st_max_ids_per_sfd_addr_c6                                      => -0.996253,
                                                                            0.000000);

seg2r_subscore6 := map(
    NULL < PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 47.58     => 2.454022,
    47.58 <= PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 177.97  => 1.171858,
    177.97 <= PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 248.88 => -0.258473,
    248.88 <= PRODUCT_DOLLARS                              => -0.836065,
                                                              -0.000000);

seg2r_subscore7 := map(
    (SHIP_METHOD in ['01', '52'])                                                                                                 => -0.906514,
    (SHIP_METHOD in ['03', '05', '07', '20', '33', '35', '36', '38', '40', '50', '53', '62', '66', '80', '83', '85', '88', '91']) => -0.148701,
    (SHIP_METHOD in ['02'])                                                                                                       => 0.764163,
                                                                                                                                     0.000000);

seg2r_subscore8 := map(
    distaddraddr2 = ''																						 => -0.000000,
    NULL < (integer)distaddraddr2 AND (integer)distaddraddr2 < 2   => 1.433970,
    2 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 5     => 1.099074,
    5 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 11    => 1.025052,
    11 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 16   => 0.655205,
    16 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 27   => 0.640387,
    27 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 37   => -0.057004,
    37 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 89   => -0.319552,
    89 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 1328 => -0.930326,
    1328 <= (integer)distaddraddr2                        				 => -1.242331,
																																			-0.000000);

seg2r_subscore9 := map(
    (btst_email_first_x_last_score in ['0:0'])                                                                                                         => -0.574987,
    (btst_email_first_x_last_score in ['-1:-1', '-1:0', '-1:1', '0:-1', '0:1', '0:2', '1:-1', '1:0', '1:1', '1:2', '1:3', '2:0', '2:1', '2:2', '2:3']) => 0.439741,
    (btst_email_first_x_last_score in ['3:1', '3:2', '3:3'])                                                                                           => 0.864231,
                                                                                                                                                          0.000000);

seg2r_subscore10 := map(
    (ip_routingmethod in ['02', '16'])                                        => -2.069884,
    (ip_routingmethod in ['Other', '06', '10', '11', '12', '13', '14', '15']) => 0.232150,
                                                                                 0.000000);

seg2r_subscore11 := map(
    (pf_pmt_type in ['American Express', 'PayPal Card'])                                    => 0.693144,
    (pf_pmt_type in ['BillMe Later', 'Google Checkout', 'Multiple Cards', 'OTHER', 'Visa']) => 0.177989,
    (pf_pmt_type in ['MasterCard'])                                                         => -0.302677,
    (pf_pmt_type in ['Discover'])                                                           => -0.949139,
                                                                                               0.000000);

seg2r_rawscore := seg2r_subscore0 +
    seg2r_subscore1 +
    seg2r_subscore2 +
    seg2r_subscore3 +
    seg2r_subscore4 +
    seg2r_subscore5 +
    seg2r_subscore6 +
    seg2r_subscore7 +
    seg2r_subscore8 +
    seg2r_subscore9 +
    seg2r_subscore10 +
    seg2r_subscore11;

seg2r_lnoddsscore := seg2r_rawscore + 3.760028;

seg3r_subscore0 := map(
    (bt_phn_miskey in ['0']) 					=> 0.065896,
    (bt_phn_miskey in ['1'])          => -1.427701,
                                         0.000000);

seg3r_subscore1 := map(
    (bt_fp_validationrisktype in ['1'])                              => 0.191032,
    (bt_fp_validationrisktype in ['Other', '2', '3', '4', '5', '6']) => -0.554470,
                                                                        -0.000000);

seg3r_subscore2 := map(
    (st_vp091_phnzip_mismatch in ['0']) 				 => 0.287673,
    (st_vp091_phnzip_mismatch in ['1'])          => -0.829452,
                                                    -0.000000);

seg3r_subscore3 := map(
    (st_vp001_phn_not_issued in ['0']) 					=> 0.086707,
    (st_vp001_phn_not_issued in ['1'])          => -1.296925,
                                                   0.000000);

seg3r_subscore4 := map(
    NULL < st_inq_highriskcredit_recency AND st_inq_highriskcredit_recency < 1 => 0.170026,
    1 <= st_inq_highriskcredit_recency AND st_inq_highriskcredit_recency < 6   => -1.036912,
    6 <= st_inq_highriskcredit_recency AND st_inq_highriskcredit_recency < 24  => -0.656924,
    24 <= st_inq_highriskcredit_recency                                        => -0.387507,
                                                                                  0.000000);

seg3r_subscore5 := map(
    (st_nap_phn_ver_x_inf_phn_ver in ['-1'])                              => -0.000000,
    (st_nap_phn_ver_x_inf_phn_ver in ['1-0', '1-1', '1-3'])               => -0.712849,
    (st_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '2-0', '2-1'])        => -0.219265,
    (st_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-0', '3-1', '3-3']) => 0.767067,
                                                                             -0.000000);

seg3r_subscore6 := map(
    NULL < PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 100.49    => 1.198164,
    100.49 <= PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 199.96 => 0.103827,
    199.96 <= PRODUCT_DOLLARS                              => -0.543395,
                                                              0.000000);

seg3r_subscore7 := map(
    (SHIP_METHOD in ['52'])                                                                                           => -1.312331,
    (SHIP_METHOD in ['01'])                                                                                           => -0.542821,
    (SHIP_METHOD in ['03', '05', '07', '20', '30', '33', '35', '36', '50', '53', '62', '80', '83', '85', '88', '91']) => -0.293202,
    (SHIP_METHOD in ['02'])                                                                                           => 0.952719,
                                                                                                                         0.000000);

seg3r_subscore8 := map(
    distaddraddr2 = '' 																							=> 0.000000,
    NULL < (integer)distaddraddr2 AND (integer)distaddraddr2 < 10   => 1.549500,
    10 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 51    => 0.701276,
    51 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 201   => -0.492825,
    201 <= (integer)distaddraddr2 AND (integer)distaddraddr2 < 1479 => -0.851966,
    1479 <= (integer)distaddraddr2                         					=> -0.969593,
																																			 0.000000);

seg3r_subscore9 := map(
    (btst_email_first_x_last_score in ['0:0'])                                                                             => -0.483478,
    (btst_email_first_x_last_score in ['-1:-1', '-1:0', '-1:1', '0:-1', '0:1', '0:2', '1:-1', '1:0', '1:1', '1:2', '1:3']) => 0.360027,
    (btst_email_first_x_last_score in ['2:0', '2:1', '2:2', '2:3', '3:1', '3:2', '3:3'])                                   => 1.119215,
                                                                                                                              -0.000000);

seg3r_subscore10 := map(
    (ip_dma_lvl in ['Other', '2. DMA: -1', '3. DMA: 0', '5. DMA: Unkown']) => -0.040060,
    (ip_dma_lvl in ['4. DMA: US Code'])                                    => 0.009520,
                                                                              0.000000);

seg3r_subscore11 := map(
    (pf_pmt_type in ['American Express', 'PayPal Card'])                                    => 0.913488,
    (pf_pmt_type in ['BillMe Later', 'Google Checkout', 'Multiple Cards', 'OTHER', 'Visa']) => 0.172404,
    (pf_pmt_type in ['MasterCard'])                                                         => -0.208073,
    (pf_pmt_type in ['Discover'])                                                           => -1.307803,
                                                                                               -0.000000);

seg3r_rawscore := seg3r_subscore0 +
    seg3r_subscore1 +
    seg3r_subscore2 +
    seg3r_subscore3 +
    seg3r_subscore4 +
    seg3r_subscore5 +
    seg3r_subscore6 +
    seg3r_subscore7 +
    seg3r_subscore8 +
    seg3r_subscore9 +
    seg3r_subscore10 +
    seg3r_subscore11;

seg3r_lnoddsscore := seg3r_rawscore + 2.841413;

seg4r_subscore0 := map(
    (bt_fp_idverrisktype in ['Other', '1', '2', '3']) => 0.295149,
    (bt_fp_idverrisktype in ['5', '6'])               => -0.852193,
                                                         0.000000);

seg4r_subscore1 := map(
    NULL < bt_fp_srchfraudsrchcount AND bt_fp_srchfraudsrchcount < 2 => 0.186727,
    2 <= bt_fp_srchfraudsrchcount                                    => -0.211400,
                                                                        0.000000);

seg4r_subscore2 := map(
    (st_fp_srchvelocityrisktype in ['1', '2', '3', '4', '5']) 				 => 0.080337,
    (st_fp_srchvelocityrisktype in ['6', '7', '8', '9'])               => -0.308170,
                                                                          0.000000);

seg4r_subscore3 := map(
    NULL < PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 249.99    => 0.329636,
    249.99 <= PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 499.99 => -0.218188,
    499.99 <= PRODUCT_DOLLARS                              => -0.526439,
                                                              -0.000000);

seg4r_subscore4 := map(
    (btst_relatives_lvl in ['4. DIDS EQUAL'])                          => 0.318742,
    (btst_relatives_lvl in ['5. RELATIVES', '6. RELATIVES IN COMMON']) => -0.497663,
                                                                          0.000000);

seg4r_subscore5 := map(
    (avs_addr in [0]) => -0.426976,
    (avs_addr in [1]) => 0.388210,
                         -0.000000);

seg4r_subScore6 := if(seg3R_lnOddsScore > NULL, 0.523173844278166 * seg3R_lnOddsScore, 2.358394);

seg4r_rawscore := seg4r_subscore0 +
    seg4r_subscore1 +
    seg4r_subscore2 +
    seg4r_subscore3 +
    seg4r_subscore4 +
    seg4r_subscore5 +
    seg4r_subscore6;

seg4r_lnoddsscore := seg4r_rawscore + 3.480575;

seg5r_subscore0 := map(
    (bt_vp091_phnzip_mismatch in ['0']) => 0.293057,
    (bt_vp091_phnzip_mismatch in ['1'])          => -1.106939,
                                                    0.000000);

seg5r_subscore1 := map(
    (bt_po001_inp_addr_naprop in ['0'])      => -0.686975,
    (bt_po001_inp_addr_naprop in ['1', '2']) => 0.543283,
    (bt_po001_inp_addr_naprop in ['3', '4']) => 1.383903,
                                                -0.000000);

seg5r_subscore2 := map(
    (bt_bus_name_match in ['0', '1', '2']) 					=> -0.080000,
    (bt_bus_name_match in ['3', '4'])               => 2.351301,
                                                       -0.000000);

seg5r_subscore3 := map(
    (bt_nap_phn_ver_x_inf_phn_ver in ['-1'])                                                                        => 0.000000,
    (bt_nap_phn_ver_x_inf_phn_ver in ['0-1'])                                                                       => -0.679557,
    (bt_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-3', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => 0.296719,
                                                                                                                       0.000000);

seg5r_subscore4 := map(
    NULL < PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 253.97 => 0.368618,
    253.97 <= PRODUCT_DOLLARS                           => -0.698170,
                                                           -0.000000);

seg5r_subscore5 := map(
    (SHIP_METHOD in ['01', '52'])                                                                               => -1.428792,
    (SHIP_METHOD in ['02', '03', '05', '07', '20', '33', '35', '50', '53', '62', '80', '83', '85', '88', '91']) => 0.897684,
                                                                                                                   0.000000);

seg5r_subscore6 := map(
    (ip_routingmethod in ['02', '16'])                                        => -2.312410,
    (ip_routingmethod in ['Other', '06', '10', '11', '12', '13', '14', '15']) => 0.311150,
                                                                                 0.000000);

seg5r_subscore7 := map(
    (avs_zip in [0]) => -0.579638,
    (avs_zip in [1]) => 1.063485,
                        -0.000000);

seg5r_subscore8 := map(
    (pf_pmt_type in ['American Express', 'BillMe Later', 'Google Checkout', 'Multiple Cards', 'OTHER', 'PayPal Card', 'Visa']) => 0.372703,
    (pf_pmt_type in ['Discover', 'MasterCard'])                                                                                => -0.630563,
                                                                                                                                  -0.000000);

seg5r_rawscore := seg5r_subscore0 +
    seg5r_subscore1 +
    seg5r_subscore2 +
    seg5r_subscore3 +
    seg5r_subscore4 +
    seg5r_subscore5 +
    seg5r_subscore6 +
    seg5r_subscore7 +
    seg5r_subscore8;

seg5r_lnoddsscore := seg5r_rawscore + 3.656067;

seg6r_subscore0 := map(
		C_BORN_USA = ''																						=> -0.000000,
    NULL < (integer)C_BORN_USA AND (integer)C_BORN_USA < 44 	=> -0.371386,
    44 <= (integer)C_BORN_USA                      						=> 0.189032,
																																 -0.000000);

seg6r_subscore1 := map(
    NULL < bt_in001_estimated_income AND bt_in001_estimated_income < 40000 => -0.307813,
    40000 <= bt_in001_estimated_income                                     => 0.166469,
                                                                              -0.000000);

seg6r_subscore2 := map(
    NULL < bt_max_lres AND bt_max_lres < 36 => -0.370044,
    36 <= bt_max_lres                       => 0.047221,
                                               0.000000);

seg6r_subscore3 := map(
    NULL < bt_adls_per_sfd_addr AND bt_adls_per_sfd_addr < 0 => 0.060044,
    0 <= bt_adls_per_sfd_addr AND bt_adls_per_sfd_addr < 1   => -0.756299,
    1 <= bt_adls_per_sfd_addr AND bt_adls_per_sfd_addr < 7   => -0.107037,
    7 <= bt_adls_per_sfd_addr AND bt_adls_per_sfd_addr < 26  => 0.206006,
    26 <= bt_adls_per_sfd_addr AND bt_adls_per_sfd_addr < 48 => -0.168668,
    48 <= bt_adls_per_sfd_addr                               => -0.580649,
                                                                -0.000000);

seg6r_subscore4 := map(
    (bt_nap_phn_ver_x_inf_phn_ver in ['-1'])                                            => 0.000000,
    (bt_nap_phn_ver_x_inf_phn_ver in ['0-0'])                                           => -0.577895,
    (bt_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3']) => -0.130855,
    (bt_nap_phn_ver_x_inf_phn_ver in ['0-3', '3-0', '3-1', '3-3'])                      => 0.439471,
                                                                                           0.000000);

seg6r_subscore5 := map(
    NULL < PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 47        => 1.078671,
    47 <= PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 119.98     => 0.518620,
    119.98 <= PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 190.94 => 0.372505,
    190.94 <= PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 397.99 => -0.316577,
    397.99 <= PRODUCT_DOLLARS AND PRODUCT_DOLLARS < 1099.9 => -0.829175,
    1099.9 <= PRODUCT_DOLLARS                              => -1.656077,
                                                              -0.000000);

seg6r_subscore6 := map(
    (SHIP_METHOD in ['05', '52', '53'])                                                             => -1.383672,
    (SHIP_METHOD in ['01'])                                                                         => -0.116906,
    (SHIP_METHOD in ['02', '03', '07', '20', '33', '35', '50', '62', '80', '83', '85', '88', '91']) => 0.267383,
                                                                                                       -0.000000);

seg6r_subscore7 := map(
    (btst_relatives_lvl in ['7. NO RELATION'])                                          => -0.487749,
    (btst_relatives_lvl in ['2. SHIPTO DID 0'])                                         => -0.288422,
    (btst_relatives_lvl in ['4. DIDS EQUAL', '5. RELATIVES', '6. RELATIVES IN COMMON']) => 0.154108,
                                                                                           0.000000);

seg6r_subscore8 := map(
    (ip_state_match in ['0']) => -0.443326,
    (ip_state_match in ['1']) => 0.168738,
                                 -0.000000);

seg6r_subscore9 := map(
    (ip_routingmethod in ['02', '16'])                                        => -2.173385,
    (ip_routingmethod in ['Other', '06', '10', '11', '12', '13', '14', '15']) => 0.160439,
                                                                                 -0.000000);

seg6r_subscore10 := map(
    (avs_addr in [0]) => -0.522191,
    (avs_addr in [1]) => 0.538414,
                         0.000000);

seg6r_subscore11 := map(
    (pf_pmt_type in ['American Express', 'PayPal Card'])                                    => 0.450868,
    (pf_pmt_type in ['BillMe Later', 'Google Checkout', 'Multiple Cards', 'OTHER', 'Visa']) => 0.084754,
    (pf_pmt_type in ['MasterCard'])                                                         => -0.081977,
    (pf_pmt_type in ['Discover'])                                                           => -1.212983,
                                                                                               0.000000);

seg6r_rawscore := seg6r_subscore0 +
    seg6r_subscore1 +
    seg6r_subscore2 +
    seg6r_subscore3 +
    seg6r_subscore4 +
    seg6r_subscore5 +
    seg6r_subscore6 +
    seg6r_subscore7 +
    seg6r_subscore8 +
    seg6r_subscore9 +
    seg6r_subscore10 +
    seg6r_subscore11;

seg6r_lnoddsscore := seg6r_rawscore + 6.305607;

model_segment := (integer)((string)tidi_seg1_lvl)[1..1];

final_score := map(
    model_segment = 1 => seg1r_lnoddsscore,
    model_segment = 2 => seg2r_lnoddsscore,
    model_segment = 3 => seg3r_lnoddsscore,
    model_segment = 4 => seg4r_lnoddsscore,
    model_segment = 5 => seg5r_lnoddsscore,
                         seg6r_lnoddsscore);

base := 700;

pts := 40;

odds := 150;

cdn1305_1_0 := min(if(max(round(pts * (final_score - ln(odds)) / 2 + base), 300) = NULL, -NULL, max(round(pts * (final_score - ln(odds)) / 2 + base), 300)), 999);

	#if(MODEL_DEBUG)
		/* Model Input Variables */							
		self.AVS															:= AVS;
		self.product_dollars									:= product_dollars;
		self.ship_method											:= ship_method;
		self.pay_method												:= pay_method;
		self.avs_addr                         := avs_addr;
		self.avs_zip                          := avs_zip;
		self.pf_pmt_type                      := pf_pmt_type;
		self.bt_add_apt                       := bt_add_apt;
		self.st_add_apt                       := st_add_apt;
		self.bt_bus_addr_match_count          := bt_bus_addr_match_count;
		self.st_vp091_phnzip_mismatch         := st_vp091_phnzip_mismatch;
		self.st_adls_per_sfd_addr_c6          := st_adls_per_sfd_addr_c6;
		self.ver_phn_inf_s                    := ver_phn_inf_s;
		self.ver_phn_nap_s                    := ver_phn_nap_s;
		self.inf_phn_ver_lvl_s                := inf_phn_ver_lvl_s;
		self.nap_phn_ver_lvl_s                := nap_phn_ver_lvl_s;
		self.st_nap_phn_ver_x_inf_phn_ver     := st_nap_phn_ver_x_inf_phn_ver;
		self.btst_email_first_x_last_score    := btst_email_first_x_last_score;
		self.ip_routingmethod                 := ip_routingmethod;
		self.bt_phn_miskey                    := bt_phn_miskey;
		self.st_va011_add_business            := st_va011_add_business;
		self.st_bus_phone_match               := st_bus_phone_match;
		self.st_max_ids_per_sfd_addr_c6       := st_max_ids_per_sfd_addr_c6;
		self.bt_fp_validationrisktype         := bt_fp_validationrisktype;
		self.st_vp001_phn_not_issued          := st_vp001_phn_not_issued;
		self.st_inq_highriskcredit_recency    := st_inq_highriskcredit_recency;
		self.ip_dma_lvl                       := ip_dma_lvl;
		self.bt_fp_idverrisktype              := bt_fp_idverrisktype;
		self.bt_fp_srchfraudsrchcount         := bt_fp_srchfraudsrchcount;
		self.st_fp_srchvelocityrisktype       := st_fp_srchvelocityrisktype;
		self.btst_relatives_lvl               := btst_relatives_lvl;
		self.bt_vp091_phnzip_mismatch         := bt_vp091_phnzip_mismatch;
		self.bt_po001_inp_addr_naprop         := bt_po001_inp_addr_naprop;
		self.bt_bus_name_match                := bt_bus_name_match;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.bt_nap_phn_ver_x_inf_phn_ver     := bt_nap_phn_ver_x_inf_phn_ver;
		self.bt_in001_estimated_income        := bt_in001_estimated_income;
		self.bt_max_lres                      := bt_max_lres;
		self.bt_adls_per_sfd_addr             := bt_adls_per_sfd_addr;
		self.ip_state_match                   := ip_state_match;
		self.addr_match                       := addr_match;
		self.tidi_seg1_lvl                    := tidi_seg1_lvl;
		self.seg1r_subscore0                  := seg1r_subscore0;
		self.seg1r_subscore1                  := seg1r_subscore1;
		self.seg1r_subscore2                  := seg1r_subscore2;
		self.seg1r_subscore3                  := seg1r_subscore3;
		self.seg1r_subscore4                  := seg1r_subscore4;
		self.seg1r_subscore5                  := seg1r_subscore5;
		self.seg1r_subscore6                  := seg1r_subscore6;
		self.seg1r_subscore7                  := seg1r_subscore7;
		self.seg1r_subscore8                  := seg1r_subscore8;
		self.seg1r_subscore9                  := seg1r_subscore9;
		self.seg1r_rawscore                   := seg1r_rawscore;
		self.seg1r_lnoddsscore                := seg1r_lnoddsscore;
		self.seg2r_subscore0                  := seg2r_subscore0;
		self.seg2r_subscore1                  := seg2r_subscore1;
		self.seg2r_subscore2                  := seg2r_subscore2;
		self.seg2r_subscore3                  := seg2r_subscore3;
		self.seg2r_subscore4                  := seg2r_subscore4;
		self.seg2r_subscore5                  := seg2r_subscore5;
		self.seg2r_subscore6                  := seg2r_subscore6;
		self.seg2r_subscore7                  := seg2r_subscore7;
		self.seg2r_subscore8                  := seg2r_subscore8;
		self.seg2r_subscore9                  := seg2r_subscore9;
		self.seg2r_subscore10                 := seg2r_subscore10;
		self.seg2r_subscore11                 := seg2r_subscore11;
		self.seg2r_rawscore                   := seg2r_rawscore;
		self.seg2r_lnoddsscore                := seg2r_lnoddsscore;
		self.seg3r_subscore0                  := seg3r_subscore0;
		self.seg3r_subscore1                  := seg3r_subscore1;
		self.seg3r_subscore2                  := seg3r_subscore2;
		self.seg3r_subscore3                  := seg3r_subscore3;
		self.seg3r_subscore4                  := seg3r_subscore4;
		self.seg3r_subscore5                  := seg3r_subscore5;
		self.seg3r_subscore6                  := seg3r_subscore6;
		self.seg3r_subscore7                  := seg3r_subscore7;
		self.seg3r_subscore8                  := seg3r_subscore8;
		self.seg3r_subscore9                  := seg3r_subscore9;
		self.seg3r_subscore10                 := seg3r_subscore10;
		self.seg3r_subscore11                 := seg3r_subscore11;
		self.seg3r_rawscore                   := seg3r_rawscore;
		self.seg3r_lnoddsscore                := seg3r_lnoddsscore;
		self.seg4r_subscore0                  := seg4r_subscore0;
		self.seg4r_subscore1                  := seg4r_subscore1;
		self.seg4r_subscore2                  := seg4r_subscore2;
		self.seg4r_subscore3                  := seg4r_subscore3;
		self.seg4r_subscore4                  := seg4r_subscore4;
		self.seg4r_subscore5                  := seg4r_subscore5;
		self.seg4r_subscore6                  := seg4r_subscore6;
		self.seg4r_rawscore                   := seg4r_rawscore;
		self.seg4r_lnoddsscore                := seg4r_lnoddsscore;
		self.seg5r_subscore0                  := seg5r_subscore0;
		self.seg5r_subscore1                  := seg5r_subscore1;
		self.seg5r_subscore2                  := seg5r_subscore2;
		self.seg5r_subscore3                  := seg5r_subscore3;
		self.seg5r_subscore4                  := seg5r_subscore4;
		self.seg5r_subscore5                  := seg5r_subscore5;
		self.seg5r_subscore6                  := seg5r_subscore6;
		self.seg5r_subscore7                  := seg5r_subscore7;
		self.seg5r_subscore8                  := seg5r_subscore8;
		self.seg5r_rawscore                   := seg5r_rawscore;
		self.seg5r_lnoddsscore                := seg5r_lnoddsscore;
		self.seg6r_subscore0                  := seg6r_subscore0;
		self.seg6r_subscore1                  := seg6r_subscore1;
		self.seg6r_subscore2                  := seg6r_subscore2;
		self.seg6r_subscore3                  := seg6r_subscore3;
		self.seg6r_subscore4                  := seg6r_subscore4;
		self.seg6r_subscore5                  := seg6r_subscore5;
		self.seg6r_subscore6                  := seg6r_subscore6;
		self.seg6r_subscore7                  := seg6r_subscore7;
		self.seg6r_subscore8                  := seg6r_subscore8;
		self.seg6r_subscore9                  := seg6r_subscore9;
		self.seg6r_subscore10                 := seg6r_subscore10;
		self.seg6r_subscore11                 := seg6r_subscore11;
		self.seg6r_rawscore                   := seg6r_rawscore;
		self.seg6r_lnoddsscore                := seg6r_lnoddsscore;
		self.model_segment                    := model_segment;
		self.final_score                      := final_score;
		self.base                             := base;
		self.pts                              := pts;
		self.odds                             := odds;
		self.cdn1305_1_0                      := cdn1305_1_0;
		SELF.seq 															:= ri.seq;
		SELF.score := (STRING3)cdn1305_1_0;
		SELF.clam := le.bs;
		self := [];
	#else
		SELF.ri := [];
		SELF.seq := le.bs.Bill_To_Out.seq;
		SELF.score := (STRING3)cdn1305_1_0;
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
		SELF.isShipToBillToDifferent := le.bs.isShipToBillToDifferent;
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
		SELF.ri := RiskWise.cdReasonCodes(le, 6, rt, TRUE, IBICID, WantstoSeeBillToShipToDifferenceFlag);
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
	STRecord := JOIN(BTRecord, STReasons, (LEFT.clam.Bill_To_Out.seq+1) = RIGHT.seq, fillReasons2(LEFT, RIGHT), LEFT OUTER);
	#else
	STRecord := JOIN(BTRecord, STReasons, ((LEFT.seq*2)-1) = RIGHT.seq, fillReasons2(LEFT, RIGHT), LEFT OUTER);

	#end
	
	RETURN(STRecord);
END;