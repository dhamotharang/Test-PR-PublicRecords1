import easi, ut, address, riskwise, risk_indicators;

export CDN707_1_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, 
		dataset(RiskWise.Layout_CD2I) indata,
		boolean IBICID, boolean WantstoSeeBillToShipToDifferenceFlag) := FUNCTION

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
		layout_ineasi; //census
	END;
	layout_model_in join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
		SELF.bs := le;
		SELF.easi := ri;	
		self.cd2i.county := le.bill_to_out.shell_input.county;
		self.cd2i.state := le.bill_to_out.shell_input.st;
		self.cd2i.geo_blk := le.bill_to_out.shell_input.geo_blk;
		self.cd2i.seq := le.bill_to_out.shell_input.seq;
		self.cd2i := le;		
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
		self.easi2 := ri;
		self.cd2i.county2 := le.bs.ship_to_out.shell_input.county;
		self.cd2i.state := le.bs.ship_to_out.shell_input.st;
		self.cd2i.geo_blk2 := le.bs.ship_to_out.shell_input.geo_blk;
		self.cd2i := le;
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

	with_census := join(indata, clam_with_easi,
		(left.seq*2) = right.bs.bill_to_out.seq,
		transform(layout_model_in, 
			self.cd2i.seq 			 := left.seq,
			self.cd2i.orderamt   := left.orderamt,
			self.cd2i.pymtmethod := left.pymtmethod,
			self.cd2i.avscode    := left.avscode ,
			self.cd2i.cidcode    := left.cidcode ,
			self.cd2i.channel    := left.channel,
			self.cd2i.shipmode   := left.shipmode,
			self := right));

	ineasi := project(with_census, transform(layout_ineasi,
			self := left, self := []));

	Layout_ModelOut doModel( clam le, ineasi ri ) := TRANSFORM

		// input fields
			cus_ORDAMT             := ri.cd2i.orderamt;
			cus_pmttype            := ri.cd2i.pymtmethod;
			cus_avs                := ri.cd2i.avscode;
			cus_CID                := ri.cd2i.cidcode;
			cus_ACQ_CHANNE         := ri.cd2i.channel;
			cus_SHIPMODE           := ri.cd2i.shipmode;
										
			IP_topleveldomain      := le.ip2o.topleveldomain;
			IP_connection          := StringLib.StringtoUppercase(trim(le.ip2o.ipconnection));
			IP_continent           := le.ip2o.continent;
			IP_countrycode         := le.ip2o.countrycode;
			IP_state               := le.ip2o.state;
		
		
			IST_addrscore          := (INTEGER)le.eddo.addrscore;
			IST_firstscore         := (INTEGER)le.eddo.firstscore;					
			distaddraddr2          := (INTEGER)le.eddo.distaddraddr2;
			in_state               := le.Bill_to_Out.shell_input.in_state;
			nas_summary            := le.Bill_to_Out.iid.nas_summary;
			nap_summary            := le.Bill_to_Out.iid.nap_summary;
			usps_deliverable       := le.Bill_to_Out.address_validation.usps_deliverable;
			dwelling_type          := trim(le.Bill_to_Out.address_validation.dwelling_type);
			zip_type               := le.Bill_to_Out.address_validation.zip_type;
			hr_address             := le.Bill_to_Out.address_validation.hr_address;
			lname_credit_sourced   := le.Bill_to_Out.name_verification.lname_credit_sourced;
			fname_tu_sourced       := le.Bill_to_Out.name_verification.fname_tu_sourced;
			lname_tu_sourced       := le.Bill_to_Out.name_verification.lname_tu_sourced;
			lname_eda_sourced      := le.Bill_to_Out.name_verification.lname_eda_sourced;
			add1_naprop            := le.Bill_to_Out.address_verification.input_address_information.naprop;
			add1_date_first_seen   := le.Bill_to_Out.address_verification.input_address_information.date_first_seen;
			add2_naprop            := le.Bill_to_Out.address_verification.address_history_1.naprop;
			add3_naprop            := le.Bill_to_Out.address_verification.address_history_2.naprop;
			telcordia_type         := le.Bill_to_Out.phone_verification.telcordia_type;
			phone_zip_mismatch     := le.Bill_to_Out.phone_verification.phone_zip_mismatch;
			archive_date           := if(le.bill_to_out.historydate <> 999999, (integer)(string)le.bill_to_out.historydate[1..4], (integer)(ut.GetDate[1..4])); // same value as used in cdn606_1_0


			in_state_s             := le.Ship_to_Out.shell_input.in_state;
			nas_summary_s          := le.Ship_to_Out.iid.nas_summary;
			nap_summary_s          := le.Ship_to_Out.iid.nap_summary;
			add1_family_owned_s    := le.Ship_to_Out.address_verification.input_address_information.family_owned;
			add1_naprop_s          := le.Ship_to_Out.address_verification.input_address_information.naprop;
			add1_date_first_seen_s := le.Ship_to_Out.address_verification.input_address_information.date_first_seen;

			property_owned_total_s := le.Ship_to_Out.address_verification.owned.property_total;
			property_sold_total_s  := le.Ship_to_Out.address_verification.sold.property_total;
			property_ambig_total_s := le.Ship_to_Out.address_verification.ambiguous.property_total;

			add2_naprop_s          := le.Ship_to_Out.address_verification.address_history_1.naprop;
			add3_naprop_s          := le.Ship_to_Out.address_verification.address_history_2.naprop;
			telcordia_type_s       := le.Ship_to_Out.phone_verification.telcordia_type;
			phone_zip_mismatch_s   := le.Ship_to_Out.phone_verification.phone_zip_mismatch;
			archive_date_s         := if(le.ship_to_out.historydate <> 999999, (integer)(string)le.ship_to_out.historydate[1..4], (integer)(ut.GetDate[1..4])); // same value as used in cdn606_1_0


			C_MED_HHINC            := (INTEGER)ri.easi.MED_HHINC;
			c_families             := (INTEGER)ri.easi.families;
			C_FAMMAR_P             := /*(INTEGER)*/ri.easi.FAMMAR_P;
			C_ROBBERY              := ri.easi.ROBBERY;
			C_SPAN_LANG            := (INTEGER)ri.easi.SPAN_LANG;

							 
			C_LOW_ED_s             := trim(ri.easi2.LOW_ED);
			C_FAMMAR_P_s           := trim(ri.easi2.FAMMAR_P);
			C_ROBBERY_s            := ri.easi2.ROBBERY;
			C_TOTCRIME_s           := (INTEGER)ri.easi2.TOTCRIME;
			C_SPAN_LANG_s          := (INTEGER)ri.easi2.SPAN_LANG;
		//


		/****** helper functions ******/
		real min2(real a, real b) := if( a<b, a, b );
		// integer ceil(real val) := if((integer)val = val, (integer)val, (integer)(val + 1));			
		integer ceil(real val) := (integer)val + (integer)(val != (integer)val);
		integer floor( real val ) := (integer)val;
		boolean isMissing( string val ) := trim(val)='';




		/************** order attributes ***************/

		V_in_cid := trim(cus_CID);
		v_in_cid_match := (INTEGER)(v_in_cid = '1');


		 /******** translate new AVS codes to standard AVS codes, 9/10/07 DY *********/
		v_in_avs := case( cus_avs,
			'0' => 'N',
			'1' => 'Z',
			'2' => 'Y',
			'3' => 'A',
			'4' => 'N',
			'7' => 'Z',
			'8' => 'Y',
			'9' => 'A',
			cus_avs
		);
		 /******** end of AVS translation *********/

		 v_in_avs_bad := (INTEGER)( v_in_avs in ['N','M','V','6','D','U'] );
		 v_in_pmt := StringLib.StringtoUppercase(cus_pmttype);
		 v_in_shipmode := StringLib.StringtoUppercase(cus_shipmode);
		 v_in_AcqChannel := trim(cus_ACQ_CHANNE);


		vs_CID := map(
			v_in_cid='1' => 0,
			v_in_cid in ['2','4','6'] => 2,
			1
		);

		vs_cid_m := case( vs_cid,
			0 => 0.01482903,
			1 => 0.01882216,
			2 => 0.04311544,
			0.01567308
		);

		 vs_in_ordAmt := ln((real)cus_ORDAMT+0.01);

		vs_avs_x := map(
			v_in_pmt = 'G' => 6,
			v_in_avs in ['M','V',' ','6','D','U'] => 1,
			v_in_avs = 'N'                        => 2,
			v_in_avs in ['B','G','R','X']         => 3,
			v_in_avs in ['A','Z','W']             => 4,
			v_in_avs = 'Y'                        => 5,
			2
		);


		vs_avs_x_m := map( 
			vs_avs_x = 1 => 0.33054393,
			vs_avs_x = 2 => 0.07483950,
			vs_avs_x = 3 => 0.05420992,
			vs_avs_x = 4 => 0.01908826,
			vs_avs_x = 5 => 0.01220460,
			vs_avs_x = 6 => 0.00013439,
			0.01567308
		);

		vs_in_shipmode_m := map( 
			v_in_shipmode = '2' => 0.08810957,
			v_in_shipmode = '7' => 0.02726099,
			v_in_shipmode = 'G' => 0.00741520,
			v_in_shipmode = 'R' => 0.03060033,
			0.01567308
		);


		vb_in_ordAmt := if(isMissing(cus_ORDAMT), 0, ln(min2((real)cus_ORDAMT,2500)+0.01) );

		vb_in_avs_x := map( 
			v_in_pmt = 'G'                                   =>  9,
			v_in_avs = 'Y' and v_in_pmt in ['B','D','M','V'] =>  8,
			v_in_avs = 'Y'                                   =>  7,
			v_in_avs = 'A'                                   =>  6,
			v_in_avs = 'Z'                                   =>  5,
			v_in_avs in ['B','G']                            =>  4,
			v_in_avs = 'N' and v_in_pmt in ['B','D','M','V'] =>  3,
			v_in_avs = 'N'                                   =>  2,
			v_in_avs in [' ','M','V','6','D','U']            =>  1,
			4
		);

		vb_in_avs_x_m := map( 
			vb_in_avs_x = 1 => 0.19087700,
			vb_in_avs_x = 2 => 0.10207214,
			vb_in_avs_x = 3 => 0.04519649,
			vb_in_avs_x = 4 => 0.01837270,
			vb_in_avs_x = 5 => 0.00459954,
			vb_in_avs_x = 6 => 0.00259326,
			vb_in_avs_x = 7 => 0.00163910,
			vb_in_avs_x = 8 => 0.00084954,
			vb_in_avs_x = 9 => 0.00004654,
			0.00323641
		);

		vb_in_shipmode_m := map( 
			v_in_shipmode = '2' => 0.02183087,
			v_in_shipmode = '7' => 0.00762471,
			v_in_shipmode = 'G' => 0.00189901,
			v_in_shipmode = 'R' => 0.00921368,
			0.00323641
		);


		vi_in_ordAmt := min2( 2000, abs((real)cus_ORDAMT-20) );

		vi_in_avsX1 := map( 
			v_in_pmt = 'G'                          => 7,
			v_in_avs ='Y' and v_in_pmt in ['M','V'] => 6,
			v_in_avs ='Y'                           => 5,
			v_in_avs in ['A','Z']                   => 4,
			v_in_avs='N' and  v_in_pmt in ['A','X'] => 1,
			v_in_avs = 'N'                          => 2,
			v_in_avs in ['M','V','6','D','U',' ']   => 1,
			2
		);


		vi_in_avsX := if( vi_in_avsX1 <= 2 and v_in_cid_match=0, vi_in_avsX1 - 0.5, vi_in_avsX1 );

		vi_in_avsx_m := map( 
			vi_in_avsx = 0.5 => 0.07246377,
			vi_in_avsx =   1 => 0.05059990,
			vi_in_avsx = 1.5 => 0.03157895,
			vi_in_avsx =   2 => 0.00706184,
			vi_in_avsx =   4 => 0.00083172,
			vi_in_avsx =   5 => 0.00037856,
			vi_in_avsx =   6 => 0.00021947,
			vi_in_avsx =   7 => 0.00013191,
			0.00083048
		);


		/************** Verification***************/

			 v_phn_Verified := ( nap_summary in [4,6,7,9,10,11,12] );

		vs_nas := map(
			nas_summary = 0 => 1,
			nas_summary in [2,3,5] => 2,
			nas_summary = 8 => 3,
			1
		);

		vs_nap := map(
			nap_summary = 1 => 1,
			nap_summary in [0,2,3] => 2,
			nap_summary BETWEEN 4 AND 10 => 3,
			nap_summary in [11,12] => 4,
			2
		);

		vs_ver_xa := map(
			vs_nap=1              => 1,
			vs_nap=2 and vs_nas=1 => 1,
			vs_nap=2 and vs_nas=2 => 2,
			vs_nap=2 and vs_nas=3 => 5,
			vs_nap=3 and vs_nas=1 => 3,
			vs_nap=3 and vs_nas=2 => 4,
			vs_nap=3 and vs_nas=3 => 6,
			vs_nap=4 and vs_nas=1 => 4,
			vs_nap=4 and vs_nas=2 => 7,
			vs_nap=4 and vs_nas=3 => 7,
			1
		);

		vs_ver_xb := if( vs_ver_xa = 6 and v_phn_verified, 7, vs_ver_xa );
		vs_ver_x  := if( vs_ver_xb = 7 and ~lname_eda_sourced, 6, vs_ver_xb );


		vs_ver_x_m := case( vs_ver_x,
			1 => 0.06982033,
			2 => 0.04426976,
			3 => 0.04095493,
			4 => 0.02326771,
			5 => 0.01758146,
			6 => 0.01551313,
			7 => 0.00704190,
			0.01567308
		);


		vs_s_nas := map(
			nas_summary = 0        => 1,
			nas_summary in [2,3,5] => 2,
			nas_summary = 8        => 3,
			1
		);
			
		vs_s_nap := map(
			nap_summary_s  = 1          => 1,
			nap_summary_s in [0,2,3]    => 2,
			nap_summary_s in [4,5,6]    => 3,
			nap_summary_s in [7,8,9,10] => 4,
			nap_summary_s in [11,12]    => 5,
			2
		);



		vs_s_ver_x := map(
			vs_s_nap=1                  => 1,
			vs_s_nap=2 and vs_s_nas = 1 => 1,
			vs_s_nap=2 and vs_s_nas = 2 => 2,
			vs_s_nap=2 and vs_s_nas = 3 => 3,
			vs_s_nap=3 and vs_s_nas = 1 => 2,
			vs_s_nap=3 and vs_s_nas = 2 => 3,
			vs_s_nap=3 and vs_s_nas = 3 => 4,
			vs_s_nap=4 and vs_s_nas = 1 => 3,
			vs_s_nap=4 and vs_s_nas = 2 => 4,
			vs_s_nap=4 and vs_s_nas = 3 => 5,
			vs_s_nap=5 and vs_s_nas = 1 => 5,
			vs_s_nap=5 and vs_s_nas = 2 => 5,
			vs_s_nap=5 and vs_s_nas = 3 => 6,
			1
		);

		vs_s_ver_x_m := case( vs_s_ver_x,
			1 => 0.03775644,
			2 => 0.01587973,
			3 => 0.00701647,
			4 => 0.00512925,
			5 => 0.00305295,
			6 => 0.00219298,
			0.01567308
		);  





		vb_ver_name_tu_sourced := (fname_tu_sourced or lname_tu_sourced);
		vb_ver_name_credit_sourced := (INTEGER)vb_ver_name_tu_sourced + (INTEGER)lname_credit_sourced;

		vb_nas := map(
			nas_summary in [2,3,5] => 2,
			nas_summary  =  8      => 3,
			1
		);

		vb_nap := map(
			nap_summary  =  1            => 1,
			nap_summary in [0,2,3]       => 2,
			nap_summary between 4 and 10 => 3,
			nap_summary in [11,12]       => 4,
			2
		);

		vb_verx := map(
			vb_nap=1 and vb_nas=1                     => 1,
			vb_nap=1 and vb_nas=2                     => 2,
			vb_nap=1                                  => 3,
			vb_nap=2 and vb_nas=1                     => 2,
			vb_nap=2 and vb_nas=2                     => 3,
			vb_nap=2 and vb_ver_name_credit_sourced=2 => 6,
			vb_nap=2                                  => 5,
			vb_nap=3 and vb_nas=1                     => 3,
			vb_nap=3 and vb_nas=2                     => 4,
			vb_nap=3 and vb_ver_name_credit_sourced=2 => 7,
			vb_nap=3                                  => 6,
						 vb_nas=1                     => 7,
						 vb_nas=2                     => 7,
			8
		);

		vb_verx_m := case( vb_verx,
			1 => 0.0637097,
			2 => 0.04806948,
			3 => 0.01865649,
			4 => 0.00711355,
			5 => 0.00575731,
			6 => 0.00242386,
			7 => 0.00125607,
			8 => 0.00046172,
			0.00323641
		);


		vi_verx := map(
			vb_nap=1              => 1,
			vb_nap=2 and vb_nas=1 => 1,
			vb_nap=2 and vb_nas=2 => 3,
			vb_nap=2 and vb_nas=3 => 5,
			vb_nap=3 and vb_nas=1 => 2,
			vb_nap=3 and vb_nas=2 => 4,
			vb_nap=3 and vb_nas=3 => 7,
			vb_nap=4 and vb_nas=1 => 5,
			vb_nap=4 and vb_nas=2 => 7,
			vb_nap=4 and vb_nas=3 => 8,
			1
		);

		vi_verx_m := case( vi_verx,
			1 => 0.01375792,
			2 => 0.00721402,
			3 => 0.00450344,
			4 => 0.00156986,
			5 => 0.00099539,
			7 => 0.00042594,
			8 => 0.00026789,
			0.00083048
		);

		/************** Property ***************/

		v_prop_tree := map(
			(add1_naprop=4) or (add2_naprop=4) or (add3_naprop=4) => 2,
			(add1_naprop=3) or (add2_naprop=3) or (add3_naprop=3) => 1,
			0
		);

		v_add1_year_firstSeen := (INTEGER)add1_date_first_seen[1..4];
		v_lres_years := if(v_add1_year_firstSeen = 0, -999, (archive_date - v_add1_year_firstSeen));


		v_s_add1_year_firstSeen := (INTEGER)add1_date_first_seen_s[1..4];
		v_s_lres_years := if(v_s_add1_year_firstSeen = 0, -999, (archive_date_s - v_s_add1_year_firstSeen) );

		vs_s_naprop_tree := map(
			(add1_naprop_s= 4) or (add2_naprop_s=4 ) or (add3_naprop_s=4) => 2,
			(add1_naprop_s= 3) or (add2_naprop_s=3 ) or (add3_naprop_s=3) => 1,
			0
		);


		vs_s_prop_any :=  (property_owned_total_s>0  or  property_sold_total_s >0  or  property_ambig_total_s>0);

		vs_s_property_tree := map(
			add1_naprop_s = 4 or add1_family_owned_s => 3,
			add1_naprop_s in [2,3]                   => 1,
			vs_s_NaProp_Tree = 2                     => 2,
			vs_s_NaProp_Tree = 1 or vs_s_prop_any    => 1,
			0
		);

		vs_s_property_tree_m := case( vs_s_property_tree,
			0 => 0.02500519,
			1 => 0.00966872,
			2 => 0.00911976,
			3 => 0.00320118,
			0.01567308
		);



		vs_s_lres_i := map(
			v_s_lres_years <   0 => 0,
			v_s_lres_years <=  2 => 1,
			v_s_lres_years <= 10 => 2,
			3
		);

		vs_s_lres_i_m := case( vs_s_lres_i,
			0 => 0.02214767,
			1 => 0.00590364,
			2 => 0.00461959,
			3 => 0.00329164,
			0.01567308
		);


		vb_prop_tree_m := case( v_prop_tree,
			0 => 0.00964153,
			1 => 0.00174614,
			2 => 0.00110972,
			0.00323641
		);

		vb_lres_i := map(
			v_lres_years<  0 => 0,
			v_lres_years<= 0 => 1,
			v_lres_years<= 2 => 2,
			v_lres_years<= 5 => 3,
			4
		);


		/************** FP ***************/


		v_phn_notpots := not( telcordia_type in ['00', '50', '51', '52', '54'] );

		v_phn_probx2 := map(
			~v_phn_notpots and ~phone_zip_mismatch => 'POTS-ZIPMATCH',
			~v_phn_notpots and  phone_zip_mismatch => 'POTS-ZIPNOMATCH',
			 v_phn_notpots and ~phone_zip_mismatch => 'NOTPOTS-ZIPMATCH',
			 v_phn_notpots and  phone_zip_mismatch => 'NOTPOTS-ZIPNOMATCH',
			'WRONG'
		);

		v_s_phn_notpots := not( telcordia_type_s in ['00', '50', '51', '52', '54'] );


		v_s_Phn_ProbX2 := map(
			~v_s_phn_notpots and ~phone_zip_mismatch_s => 'POTS-ZIPMATCH',
			~v_s_phn_notpots and  phone_zip_mismatch_s => 'POTS-ZIPNOMATCH',
			 v_s_phn_notpots and ~phone_zip_mismatch_s => 'NOTPOTS-ZIPMATCH',
			 v_s_phn_notpots and  phone_zip_mismatch_s => 'NOTPOTS-ZIPNOMATCH',
			'WRONG'
		);

		v_add_apt_f := (StringLib.StringtoUppercase(dwelling_type)='A');
		v_add_mil_f := (zip_type = '3');



		v_addval_pt1 := map(
			~hr_address and  v_add_mil_f => '1 LR-NONAPT-MIL',
			~hr_address and ~v_add_mil_f => '2 LR-NONAPT',
			'3 HR-NONAPT'
		);
		v_addval_pt2 := if( usps_deliverable and v_add_apt_f, if( ~hr_address, '4 LR-APT', '5 HR-APT' ), '6 INVALID' );
		v_addval := if( usps_deliverable and ~v_add_apt_f, v_addval_pt1, v_addval_pt2 );	


		vs_Phn_ProbX2_m := case( v_Phn_Probx2,
			'NOTPOTS-ZIPMATCH'   => 0.01846044,
			'NOTPOTS-ZIPNOMATCH' => 0.03131913,
			'POTS-ZIPMATCH'      => 0.01109182,
			'POTS-ZIPNOMATCH'    => 0.03754627,
			0.01567308
		);

		vs_s_Phn_ProbX2_m := case( v_s_Phn_Probx2,
			'NOTPOTS-ZIPMATCH'   => 0.01768469,
			'NOTPOTS-ZIPNOMATCH' => 0.03544776,
			'POTS-ZIPMATCH'      => 0.01097552,
			'POTS-ZIPNOMATCH'    => 0.01823164,
			0.01567308
		);

		vb_Phn_ProbX2_m := case( v_phn_probx2,
			'NOTPOTS-ZIPMATCH'   => 0.00538031,
			'NOTPOTS-ZIPNOMATCH' => 0.00949473,
			'POTS-ZIPMATCH'      => 0.00185210,
			'POTS-ZIPNOMATCH'    => 0.01697313,
			0.00323641
		);

		vi_Phn_ProbX2_m := case( v_phn_probx2,
			'NOTPOTS-ZIPMATCH'   => 0.00125961,
			'NOTPOTS-ZIPNOMATCH' => 0.00182359,
			'POTS-ZIPMATCH'      => 0.00053599,
			'POTS-ZIPNOMATCH'    => 0.00199867,
			0.00083048           
		);

		vi_addVal_m := case( v_addVal,
			'1 LR-NONAPT-MIL' => 0.00000000,
			'2 LR-NONAPT'     => 0.00065904,
			'3 HR-NONAPT'     => 0.01401142,
			'4 LR-APT'        => 0.00108856,
			'5 HR-APT'        => 0.00653595,
			'6 INVALID'       => 0.00667780,
			0.00083048
		);

		v_IST_firstScorelt100 := (INTEGER)(IST_firstscore < 100);

		/************** distance calculation ********/

		vs_dist_i3 := map(
			distaddraddr2 <= 50   => 0,
			distaddraddr2 <= 500  => 1,
			distaddraddr2 <= 1000 => 2,
			3
		);

		vs_dist_i3_m := case( vs_dist_i3,
			0 => 0.01226250,
			1 => 0.01674016,
			2 => 0.01865811,
			3 => 0.02339894,
			0.01567308
		);

		/************** IP ***************/

		v_ip_topDomain := StringLib.StringtoUppercase(trim(IP_topleveldomain));
		v_ip_domain_GovMil := (INTEGER)(v_ip_topDomain in ['GOV','MIL']);


		v_IP_Connection_I := map(
			cus_ACQ_CHANNE not in ['01','02']      => 5,
			cus_ACQ_CHANNE != '01'                 => 0,
			IP_connection in ['SATELLITE','WIRELESS']     => 1,
			IP_connection in ['DIALUP']                   => 2,
			IP_connection in ['BROADBAND','CABLE','XDSL'] => 3,
			IP_connection in ['T1','T3']                  => 4,
			1
		);

		 v_IP_continent   := trim(IP_continent);
		 v_IP_countrycode := StringLib.StringtoUppercase(trim(IP_countrycode));
		 v_ip_state := StringLib.StringtoUppercase(trim(IP_state));


		vs_ip_connection_i_m := case( v_ip_connection_i,
			0 => 0.04582667,
			1 => 0.03738168,
			2 => 0.01563937,
			3 => 0.01429068,
			4 => 0.00944344,
			5 => 0.00563813,
			0.01567308
		);

		vs_IPMatch_Code := map(
			v_in_AcqChannel = '02' and in_state=in_state_s => 's11-telstatematch',
			v_in_AcqChannel = '02'                         => 's12-telstatediff',
			v_in_AcqChannel = '03' and in_state=in_state_s => 's21-kioskstatematch',
			v_in_AcqChannel = '03'                         => 's22-kioskstatediff',
			v_IP_Continent in ['1','7']                    => 's32-badIP',
			v_IP_countrycode != 'US'                       => 's31-foreignIP',
			v_ip_state = 'AOL' and v_IP_countrycode = 'US' => 's40-AOL',
			in_state = in_state_s                          => map(
																	 v_ip_state=in_state  => 's51-ipmatch',
																	 v_IP_countrycode='US'=> 's52-usIP',
																	 ''
																  ),
			v_ip_state = in_state                          => 's61-ipbtstate',
			v_ip_state = in_state_s                        => 's62-ipststate',
			v_IP_countrycode = 'US'                        => 's63-usIP',
			's70-other'
		);

		vs_IPMatchCode_m := case( vs_IPMatch_Code,
			's11-telstatematch'   => 0.03859174,
			's12-telstatediff'    => 0.05488451,
			's21-kioskstatematch' => 0.00434611,
			's22-kioskstatediff'  => 0.00802334,
			's31-foreignIP'       => 0.05948863,
			's32-badIP'           => 0.28682171,
			's40-AOL'             => 0.02197258,
			's51-ipmatch'         => 0.01049363,
			's52-usIP'            => 0.01044276,
			's61-ipbtstate'       => 0.00560349,
			's62-ipststate'       => 0.05424406,
			's63-usIP'            => 0.02915617,
			0.01567308
		);

		if( cus_ACQ_CHANNE = '01' ) then
			vb_ip_domain := map(
				v_ip_topdomain in ['COM','NET','EDU','MIL','ORG'] => 'commondomain',
				v_ip_topdomain  =  'GOV'                          => 'govdomain',
				'uncommondomain'
			);
		else
			vb_ip_domain := if( cus_ACQ_CHANNE = '02', 'telorder','kioskorder' );
		end;

		vb_ip_domain_m := case( vb_ip_domain,
			'commondomain'   => 0.00261916,
			'govdomain'      => 0.00049480,
			'kioskorder'     => 0.00047240,
			'telorder'       => 0.01048993,
			'uncommondomain' => 0.01385575,
			0.00323641
		);

		vb_IP_Connection_I := map(
			cus_ACQ_CHANNE = '01' AND IP_CONNECTION in ['SATELLITE','WIRELESS'] => 1,
			cus_ACQ_CHANNE = '01'                                               => 2,
			cus_ACQ_CHANNE = '02'                                               => 0,
			3
		);


		vb_ip_Connection_i_m := case( vb_ip_connection_i,
			0 => 0.01048993,
			1 => 0.00492961,
			2 => 0.00318695,
			3 => 0.00047240,
			0.00323641
		);

		vb_IPMatchCode := map(
			v_in_AcqChannel = '02' => 'b1-tel',
			v_in_AcqChannel = '03' => 'b2-kiosk',
			v_ip_state = 'AOL' and v_IP_countrycode = 'US' => 'b3-aol',
			v_ip_state = in_state   => 'b4-statematch',
			v_IP_countrycode = 'US' => 'b5-us',
			v_IP_countrycode = 'CA' => 'b6-canada',
			v_IP_continent in ['1','7'] => 'b8-badcontinent',
			'b7-othercontinent'
		);

		vb_IPMatchCode_m := case( vb_IPMatchCode,
			'b1-tel'            => 0.01048993,
			'b2-kiosk'          => 0.00047240,
			'b3-aol'            => 0.00258309,
			'b4-statematch'     => 0.00208766,
			'b5-us'             => 0.00345128,
			'b6-canada'         => 0.01800327,
			'b7-othercontinent' => 0.04863424,
			'b8-badcontinent'   => 0.25596891,
			0.00323641
		);

		vi_IP_connection_I := map(
			v_IP_connection_I in [0,5] => 0,
			v_IP_connection_I = 1 => 1,
			2
		);

		vi_ip_connection_i_m := case( vi_ip_connection_i,
			0 => 0.00358190,
			1 => 0.00219723,
			2 => 0.00071860,
			0.00083048
		);

		vi_IPMatchCode := map(
			v_in_AcqChannel = '02'      => 'b1-tel',
			v_in_AcqChannel = '03'      => 'b2-kiosk',
			v_IP_countrycode = 'CA'     => 'b6-canada',
			v_IP_continent in ['1','7'] => 'b8-badcontinent',
			v_IP_countrycode != 'US'    => 'b7-othercountry',
			v_ip_state = 'AOL'          => 'b3-aol',
			v_ip_state = in_state       => 'b4-statematch',
			'b5-statediff'
		);

		vi_IPMatchCode_m := case( vi_IPMatchCode,
			'b1-tel'          => 0.00334376,
			'b2-kiosk'        => 0.00431464,
			'b3-aol'          => 0.00053163,
			'b4-statematch'   => 0.00049325,
			'b5-statediff'    => 0.00121690,
			'b6-canada'       => 0.01449275,
			'b7-othercountry' => 0.03448276,
			'b8-badcontinent' => 0.09502262,
			0.00083048
		);

		/************** EASI census ***************/
		realC_LOW_ED_s := (real)C_LOW_ED_s;
		vs_s_c_lowed := map(
			isMissing(C_LOW_ED_s)=> 0,
			realC_LOW_ED_s = -1  => 50,
			realC_LOW_ED_s = 100 => 60,
			ceil(realC_LOW_ED_s/10)*10
		);

		vs_s_c_lowed_i := map(
			vs_s_c_lowed <= 20 => 1,
			vs_s_c_lowed <= 30 => 2,
			vs_s_c_lowed <= 40 => 3,
			vs_s_c_lowed <= 50 => 4,
			vs_s_c_lowed <= 60 => 5,
			vs_s_c_lowed <= 70 => 6,
			vs_s_c_lowed <= 90 => 7,
			8
		);

		vs_s_c_lowed_i_m := case( vs_s_c_lowed_i,
			1 => 0.00911810,
			2 => 0.01246979,
			3 => 0.01384207,
			4 => 0.01397589,
			5 => 0.01968523,
			6 => 0.02881634,
			7 => 0.05797997,
			8 => 0.09604520,
			0.01567308
		);

		realC_FAMMAR_P_s := (real)C_FAMMAR_P_s;
		vs_s_c_FAMMAR_P := map(
			isMissing(C_FAMMAR_P)  => 95,
			realC_FAMMAR_P_s = -1  => 65,
			realC_FAMMAR_P_s = 100 => 75,
			realC_FAMMAR_P_s
		);


		vs_s_C_ROBBERY := map(
			isMissing(C_ROBBERY)=> 0,
			(integer)C_ROBBERY_s <= 20   => 1,
			(integer)C_ROBBERY_s <= 120  => 2,
			(integer)C_ROBBERY_s <= 140  => 3,
			(integer)C_ROBBERY_s <= 160  => 4,
			5
		);

		vs_s_c_ROBBERY_m := case( vs_s_C_ROBBERY,
			0 => 0.00717044,
			1 => 0.00716479,
			2 => 0.01021576,
			3 => 0.01773533,
			4 => 0.02029433,
			5 => 0.03109918,
			0.01567308
		);

		vs_C_SPAN_LANG := map(
			C_SPAN_LANG <= 100 => 1,
			C_SPAN_LANG <= 120 => 2,
			C_SPAN_LANG <= 140 => 3,
			C_SPAN_LANG <= 160 => 4,
			C_SPAN_LANG <= 180 => 5,
			6
		);

		vs_C_SPAN_LANG_m := case( vs_C_SPAN_LANG,
			1 => 0.01198970,
			2 => 0.01372334,
			3 => 0.01610818,
			4 => 0.01634040,
			5 => 0.02018189,
			6 => 0.03574049,
			0.01567308
		);

		vs_s_C_TOTCRIME := map(
			C_TOTCRIME_s<50 => 1,
			C_TOTCRIME_s<150=> 2,
			3
		);

		vs_s_C_SPAN_LANG := map(
			C_SPAN_LANG_s<=125 => 1,
			C_SPAN_LANG_s<=140 => 2,
			C_SPAN_LANG_s<=160 => 3,
			C_SPAN_LANG_s<=180 => 4,
			5
		);

		vs_s_C_SPAN_LANG_m := case( vs_s_C_SPAN_LANG,
			1 => 0.01011561,
			2 => 0.01430202,
			3 => 0.01738514,
			4 => 0.02300152,
			5 => 0.05428543,
			0.01567308
		);




		vb_C_FAMMAR_p  := if(c_families = 0, -1, floor((REAL)C_FAMMAR_P/5)*5);
		vb_C_FAMMAR_p2 := if( isMissing(C_FAMMAR_P) or (integer)C_FAMMAR_P<0, 75, ut.min2(85,ut.max2(20,floor((real)C_FAMMAR_P/10)*10)));

		vb_C_FAMMAR_P2_m := case( vb_C_FAMMAR_P2,
			20 => 0.03037383,
			30 => 0.01040277,
			40 => 0.00994116,
			50 => 0.00693926,
			60 => 0.00450401,
			70 => 0.00352218,
			75 => 0.00319048,
			80 => 0.00245700,
			85 => 0.00193974,
			0.00323641
		);

		vb_C_ROBBERY := if( isMissing(C_ROBBERY), -1, ceil((real)C_ROBBERY/20)*20);
		vb_C_ROBBERY2 := map(
			vb_C_ROBBERY <= 20  => vb_C_ROBBERY,
			vb_C_ROBBERY <= 120 => 120,
			vb_C_ROBBERY <= 160 => vb_C_ROBBERY,
			180
		);

		vb_C_ROBBERY2_m := case( vb_C_ROBBERY2,
			 -1 => 0.00099108,
			 20 => 0.00160986,
			120 => 0.00190236,
			140 => 0.00355199,
			160 => 0.00448895,
			180 => 0.00925933,
			0.00323641
		);


		vi_C_MED_HHINC := map(
			C_MED_HHINC<=37000 => 37000,
			C_MED_HHINC<=56000 => 56000,
			C_MED_HHINC<=60000 => 60000,
			C_MED_HHINC<=90000 => 90000,
			90001
		);

		vi_C_MED_HHINC_m := case( vi_C_MED_HHINC,
			37000 => 0.00223948,
			56000 => 0.00102621,
			60000 => 0.00101222,
			90000 => 0.00051978,
			90001 => 0.00042345,
			0.00083048
		);

		vi_C_ROBBERY := map(
			isMissing(C_ROBBERY) => -1,
			(INTEGER)C_ROBBERY =0=> 0,
			ceil((REAL)C_ROBBERY/10)*10
		);


		vi_C_ROBBERY2 := map(
			vi_C_ROBBERY <= 0  => 0,
			vi_C_ROBBERY <=10  => 2,
			vi_C_ROBBERY <=140 => 1,
			0
		);

		vi_C_ROBBERY2_m := case( vi_C_ROBBERY2,
			0 => 0.00148904,
			1 => 0.00058456,
			2 => 0.00048085,
			0.00083048
		);

		/*********** final model ***************/

		uv_billto := ( IST_addrscore = 100 );
		uv_instore := ( trim(cus_SHIPMODE) = '');

		uv_dataset := map(
			uv_instore => 'instore',
			uv_billto  => 'billto',
			'shipto'
		);


		logit := map(
		 uv_dataset = 'instore' => -9.825756098
					  + v_in_cid_match  * -0.782490441
					  + vi_in_ordAmt  * 0.0010922822
					  + v_in_avs_bad  * 2.5727329197
					  + vi_in_avsx_m  * 28.416558477
					  + vi_ip_connection_i_m  * 322.82390232
					  + vi_IPMatchCode_m  * 20.394183025
					  + vi_verx_m  * 89.526976452
					  + vi_Phn_ProbX2_m  * 765.22815766
					  + vi_addVal_m  * 54.258820311
					  + vi_C_MED_HHINC_m  * 534.38386024
					  + vi_C_ROBBERY2_m  * 405.72030925,
		uv_dataset = 'billto' => -12.40549116
					  + vb_in_ordAmt  * 0.9076384021
					  + v_in_avs_bad  * 2.6757669519
					  + vb_in_shipmode_m  * 85.994543047
					  + vb_in_avs_x_m  * 0.2967512661
					  + vb_ip_domain_m  * 45.504514462
					  + vb_ip_connection_i_m  * 51.901394393
					  + vb_IPMatchCode_m  * 3.5716571056
					  + vb_verx_m  * 19.381998899
					  + vb_prop_tree_m  * 43.00093485
					  + vb_lres_i  * -0.363129869
					  + vb_Phn_ProbX2_m  * 56.002110031
					  + vb_C_FAMMAR_P2_m  * 34.250204791
					  + vb_C_ROBBERY2_m  * 89.727625879,
		-14.92604818
					  + vs_ver_x_m  * 14.761219723
					  + vs_s_ver_x_m  * 20.347091
					  + vs_s_property_tree_m  * 25.806489315
					  + vs_s_lres_i_m  * 50.791094039
					  + vs_Phn_ProbX2_m  * 33.414229096
					  + vs_s_Phn_ProbX2_m  * 12.496268717
					  + vs_s_c_lowed_i_m  * 16.913309979
					  + vs_s_c_FAMMAR_P  * -0.01426352
					  + vs_s_C_ROBBERY_m  * 12.259477749
					  + vs_C_SPAN_LANG_m  * 6.711921896
					  + vs_s_C_TOTCRIME  * 0.0930471822
					  + vs_s_C_SPAN_LANG_m  * 11.561654577
					  + v_IST_firstScorelt100  * 0.5074697156
					  + vs_dist_i3_m  * 69.864131431
					  + vs_ip_connection_i_m  * 8.1768362654
					  + vs_IPMatchCode_m  * 9.4174327371
					  + v_ip_domain_GovMil  * -1.979226761
					  + vs_in_ordAmt  * 0.929869406
					  + vs_avs_x_m  * 1.7023793849
					  + vs_cid_m  * 23.831483916
					  + vs_in_shipmode_m  * 24.315770826
					  + v_in_avs_bad  * 1.5026304127
		);

		phat := (exp(logit )) / (1+exp(logit ));

		base  := 660;
		point :=  -25;
		odds  := 0.0059373;

		CDN707_1_0a := round(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
		CDN707_1_0  := ut.max2(250,ut.min2(999,CDN707_1_0a));


		self.score := (STRING)cdn707_1_0;
		self.seq := le.bill_to_out.seq;
		self := [];
	end;

	model := join(clam, ineasi, 
		left.bill_to_out.seq=right.cd2i.seq*2, 
			doModel(left,right), left outer);


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

	RiskWise.Layout_IP2O fill_ip(clam le) := TRANSFORM
		self.countrycode := le.ip2o.countrycode[1..2];
		self := le.ip2o;
	END;
	ipInfo := PROJECT(clam, fill_ip(left));


	Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
		self.seq := le.seq;
		self.ri := RiskWise.cdReasonCodes(le, 6, rt, true, IBICID, WantstoSeeBillToShipToDifferenceFlag);
		self := [];
	END;
	BTReasons := join(iidBT, ipInfo, 
		left.seq = right.seq, addBTReasons(left, right), left outer);

	Layout_ModelOut fillReasons(Layout_ModelOut le, BTreasons rt) := TRANSFORM
		self.ri := rt.ri;
		self := le;
	END;
	BTrecord := JOIN(model, BTReasons, 
		left.seq = right.seq, fillReasons(left,right), left outer);


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


	Layout_ModelOut addSTReasons(iidST le, ipInfo rt) := TRANSFORM
		self.seq := le.seq;
		self.ri := RiskWise.cdReasonCodes(le, 6, rt, false, IBICID, false);
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