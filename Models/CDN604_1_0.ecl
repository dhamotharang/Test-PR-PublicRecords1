import ut, risk_indicators, Business_Risk;

export CDN604_1_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, dataset(Business_Risk.Layout_BIID_BtSt_Output) biid) := FUNCTION


Layout_ModelOut doModel(clam le, biid ri) := transform

	verlst_s := if(le.bill_to_out.iid.nas_summary in [5,7,8,9,11,12], 1,0);
	veradd_s := if(le.bill_to_out.iid.nas_summary in [5,6,8,10,11,12], 1,0);
	verssn_s := if(le.bill_to_out.iid.nas_summary in [6,7,9,10,11,12], 1,0);

	verlst_p := if(le.bill_to_out.iid.nap_summary in [5,7,8,9,11,12], 1,0);
	veradd_p := if(le.bill_to_out.iid.nap_summary in [5,6,8,10,11,12], 1,0);
	verphn_p := if(le.bill_to_out.iid.nap_summary in [6,7,9,10,11,12], 1,0);


	/* CDN604 Reason Code Stuff */
	
	rc_8 := if(le.bill_to_out.iid.reason1 = '08' or le.bill_to_out.iid.reason2 = '08' or le.bill_to_out.iid.reason3 = '08' or le.bill_to_out.iid.reason4 = '08' or
			 le.bill_to_out.iid.reason5 = '08' or le.bill_to_out.iid.reason6 = '08', true, false);
			 
	rc_11 := if(le.bill_to_out.iid.reason1 = '11' or le.bill_to_out.iid.reason2 = '11' or le.bill_to_out.iid.reason3 = '11' or le.bill_to_out.iid.reason4 = '11' or
			  le.bill_to_out.iid.reason5 = '11' or le.bill_to_out.iid.reason6 = '11', true, false);
			 
	
	/* PB02 Tree */
	
	verlst_pb := if(ri.bill_to_output.bnat_indicator in ['5','6','7','8'] or ri.bill_to_output.bnap_indicator in ['5','6','7','8'], 1,0);
	veradd_pb := if(ri.bill_to_output.bnat_indicator in ['4','6','7','8'] or ri.bill_to_output.bnap_indicator in ['4','6','7','8'], 1,0);
	verphn_pb := if(ri.bill_to_output.bnap_indicator in ['4','5','8'], 1,0);
	
	verlst_pk := (verlst_s + verlst_p + verlst_pb) >= 1;
	veradd_pk := (veradd_s + veradd_p + veradd_pb) >= 1;
	verphn_pk := (verphn_p + verphn_pb) >= 1;
	
	verx_pk_n := map(verlst_pk and veradd_pk and verphn_pk => '60',
				  verlst_pk and veradd_pk => '50',
				  veradd_pk and verphn_pk => '40',
				  verlst_pk and verphn_pk => '30',
				  rc_8 or rc_11 => '00',
				  le.bill_to_out.iid.nap_summary = 1 => '10',
				  '20');


	/* CDN604 Ver - Shipto */
	
	verlst_s_s := if(le.ship_to_out.iid.nas_summary in [5,7,8,9,11,12], 1,0);
	veradd_s_s := if(le.ship_to_out.iid.nas_summary in [5,6,8,10,11,12], 1,0);
	verssn_s_s := if(le.ship_to_out.iid.nas_summary in [6,7,9,10,11,12], 1,0);
	
	verlst_p_s := if(le.ship_to_out.iid.nap_summary in [5,7,8,9,11,12], 1,0);
	veradd_p_s := if(le.ship_to_out.iid.nap_summary in [5,6,8,10,11,12], 1,0);
	verphn_p_s := if(le.ship_to_out.iid.nap_summary in [6,7,9,10,11,12], 1,0);
	
	
	/* CDN604 Reason Code Stuff */
	
	rc_s_8 := if(le.ship_to_out.iid.reason1 = '08' or le.ship_to_out.iid.reason2 = '08' or le.ship_to_out.iid.reason3 = '08' or le.ship_to_out.iid.reason4 = '08' or
			   le.ship_to_out.iid.reason5 = '08' or le.ship_to_out.iid.reason6 = '08', true, false);
			 
	rc_s_11 := if(le.ship_to_out.iid.reason1 = '11' or le.ship_to_out.iid.reason2 = '11' or le.ship_to_out.iid.reason3 = '11' or le.ship_to_out.iid.reason4 = '11' or
			    le.ship_to_out.iid.reason5 = '11' or le.ship_to_out.iid.reason6 = '11', true, false);
	

	/* PB02 Tree */
	
	verlst_pb_s := if(ri.ship_to_output.bnat_indicator in ['5','6','7','8'] or ri.ship_to_output.bnap_indicator in ['5','6','7','8'], 1,0);
	veradd_pb_s := if(ri.ship_to_output.bnat_indicator in ['4','6','7','8'] or ri.ship_to_output.bnap_indicator in ['4','6','7','8'], 1,0);
	verphn_pb_s := if(ri.ship_to_output.bnap_indicator in ['4','5','8'], 1,0);
	
	verlst_pk_s := (verlst_s_s + verlst_p_s + verlst_pb_s) >= 1;
	veradd_pk_s := (veradd_s_s + veradd_p_s + veradd_pb_s) >= 1;
	verphn_pk_s := (verphn_p_s + verphn_pb_s) >= 1;
	
	verx_pk_n_s := map(verlst_pk_s and veradd_pk_s and verphn_pk_s => '60',
				verlst_pk_s and veradd_pk_s => '50',
				veradd_pk_s and verphn_pk_s => '40',
				verlst_pk_s and verphn_pk_s => '30',
				rc_s_8 or rc_s_11 => '00',
				le.ship_to_out.iid.nap_summary = 1 => '10',
				'20');
				

	SELF.score := verx_pk_n + verx_pk_n_s;
	SELF.seq := le.bill_To_out.seq;
	SELF := [];
END;
out := JOIN(clam, biid, left.bill_to_out.seq = right.bill_to_output.seq, doModel(LEFT, RIGHT), left outer);

RETURN out;

END;