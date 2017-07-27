import business_risk,easi,riskwise;


export RSB801_1_0(
	dataset(Business_Risk.Layout_Business_Shell) bshell
) := FUNCTION
	


	models.Layout_Model_Batch doModel( Business_Risk.Layout_Business_Shell le, Easi.Key_Easi_Census ri ) := TRANSFORM
		 // ******  mk_RSB801_1_0 *****;

		 // ******  IRS proj 586 *****;

		// ****** Business Shell Variables  ******;
		// VARIABLE            Loc          Description

		addr1               := le.biid.addr1;
		st                  := le.biid.st;
		z5                  := le.biid.z5;
		unreleasedliencount := le.biid.unreleasedliencount;
		vernotrecentflag    := le.biid.vernotrecentflag;
		company_status      := trim(le.biid.company_status);
		bkfeinflag          := le.biid.bkfeinflag;
		irs5500_emps        := le.prs.irs5500_emps;
		currt1src4          := le.prs.currt1src4;
		cnt_ia              := le.prs.cnt_ia;
		cnt_bm              := le.prs.cnt_bm;
		cnt_bn              := le.prs.cnt_bn;
		cnt_br              := le.prs.cnt_br;
		cnt_fa              := le.prs.cnt_fa;
		cnt_fc              := le.prs.cnt_fc;
		cnt_i               := le.prs.cnt_i;
		cnt_id              := le.prs.cnt_id;
		cnt_ii              := le.prs.cnt_ii;
		cnt_in              := le.prs.cnt_in;
		cnt_lp              := le.prs.cnt_lp;
		cnt_md              := le.prs.cnt_md;
		cnt_pl              := le.prs.cnt_pl;
		cnt_pr              := le.prs.cnt_pr;
		cnt_w               := le.prs.cnt_w;
		currcorp            := le.prs.currcorp;
		currdnb             := le.prs.currdnb;
		currucc             := le.prs.currucc;
		curry               := le.prs.curry;
		currphn             := le.prs.currphn;
		yp_flag             := le.prs.yp_flag;
		corp_flag           := le.prs.corp_flag;

		// ******  Census Variables ******;
		B_CPIALL            := trim(ri.CPIALL);



		// helpers
		mymax(a,b) := MACRO if((a)>(b),(a),(b)) ENDMACRO;
		mymin(a,b) := MACRO if((a)<(b),(a),(b)) ENDMACRO;

	 // **** CODE START  ****;
	 // data temp;
	 // set irs586.irs3;


		addr1_p := (integer)(trim(addr1)[1] != ' ');
		st_p    := (integer)(trim(st)[1] != ' ');
		z5_p    := (integer)(trim(z5)[1] != ' ');

		field_pop := addr1_p + st_p + z5_p;

		unrel_lienct := map(
			unreleasedliencount < 0 => 0,
			unreleasedliencount <=2 => unreleasedliencount,
			3
		);
			
		
		// ****  vernotrecentflag1  ****;
		vernotrecentflag1 := (integer)vernotrecentflag;


		// **** id_ct ****;
		id_ct := if( cnt_id > 0, -1, 0 );
		
		if field_pop = 3 then
			//======================================================//
			//  To suppress conditional assignment warning messages //
			//======================================================//
			unrel_lienct_m2 := 0.0;
			irs_miss1a := 0;
			irs_miss1b := 0;
			irs_miss1c := 0;
			yp_corp := 0;
			irs_miss := 0;
			cur_x := 0;
			cur_x1 := 0;
			//======================================================//

			// **** cpiall_i calc  ****;
			cpiall := map(
						 B_CPIALL = '' => 190,
				(integer)B_CPIALL = -1 => 190,
				(integer)B_CPIALL >200 => 200,
				(integer)B_CPIALL
			);
			cpiall_i := cpiall;

			// **** cmpy_stat_m ****;
			cmpy_stat_m := map(
				company_status='A' => 0.5075757576,
				company_status='U' => 0.376709008,
				0.2887804878
			);

			// **** bkfeinflag1 ****;
			bkfeinflag1 := (integer)bkfeinflag;

			// **** unrel_lienct_m ****;
			unrel_lienct := map(
				unreleasedliencount = 0 => 0,
				unreleasedliencount <=2 => unreleasedliencount,
				3
			);

			unrel_lienct_m := case( unrel_lienct,
				0 => 0.4815250994,
				1 => 0.4158106297,
				2 => 0.4065261727,
				0.3252316839
				// 3 => 0.3252316839
			);

			// **** irs_emp ****;

			irs5500_emps1 := irs5500_emps;
			irs_emp := (integer)(irs5500_emps1 != 0);


			// **** currt1src4_m ****;
			currt1src4_m := case( currt1src4,
				0 => 0.3534473125,
				1 => 0.4303016453,
				2 => 0.5249119275,
				3 => 0.5988700565,
				0.7277227723
				// 4 => 0.7277227723
			);

			// **** ia_ct_m ****;
			ia_ct_m := case( cnt_ia,
				0 => 0.3752558968,
				1 => 0.4685977954,
				0.5672191529
			);

			// **** id_cnt ****;

			/* calculated above */


			// **** brk1_source_m ****;

			bm_ct := (integer)(cnt_bm > 0);
			bn_ct := (integer)(cnt_bn > 0);
			br_ct := (integer)(cnt_br > 0);
			fa_ct := (integer)(cnt_fa > 0);
			fc_ct := (integer)(cnt_fc > 0);
			i_ct  := (integer)(cnt_i  > 0);
			ii_ct := (integer)(cnt_ii > 0);
			in_ct := (integer)(cnt_in > 0);
			lp_ct := (integer)(cnt_lp > 0);
			md_ct := (integer)(cnt_md > 0);
			pl_ct := (integer)(cnt_pl > 0);
			pr_ct := (integer)(cnt_pr > 0);
			w_ct  := (integer)(cnt_w  > 0);


			brk1_source := mymin(6,(w_ct + pr_ct + pl_ct + md_ct + fc_ct + lp_ct + in_ct + ii_ct + i_ct + fc_ct + fa_ct + br_ct + bn_ct + bm_ct));
			
			brk1_source_m := case( brk1_source,
				0 => 0.3690391096,
				1 => 0.4294911097,
				2 => 0.4594427245,
				3 => 0.5360962567,
				4 => 0.5798816568,
				5 => 0.5901639344,
				// 6 => 0.6996466431
				0.6996466431
			);


			irs_mod1a := -11.053985
				+ cpiall_i  * 0.0245817842
				+ vernotrecentflag1  * -0.199431406
				+ cmpy_stat_m  * 2.3592138917
				+ bkfeinflag1  * -0.877323162
				+ unrel_lienct_m  * 5.8356504364
				+ irs_emp  * 0.4095932706
				+ currt1src4_m  * 2.4089229347
				+ ia_ct_m  * 2.3154359612
				+ id_ct  * 0.6145875613
				+ brk1_source_m  * 2.1968700134
			;
			irs_mod1b := (exp(irs_mod1a )) / (1+exp(irs_mod1a ));
			phat := irs_mod1b;
			irs_mod1c := round(1000 * irs_mod1b )/10.0;

			base  := 700;
			odds  := 0.25/0.75;
			point := 40;

			irs_scr1 := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

			rsb801_1_0a := irs_scr1;


		else
			//======================================================//
			//  To suppress conditional assignment warning messages //
			//======================================================//
			unrel_lienct_m := 0.0;
			bm_ct := 0;
			bn_ct := 0;
			br_ct := 0;
			fa_ct := 0;
			fc_ct := 0;
			i_ct  := 0;
			ii_ct := 0;
			in_ct := 0;
			lp_ct := 0;
			md_ct := 0;
			pl_ct := 0;
			pr_ct := 0;
			w_ct  := 0;
			irs_scr1 := 0;
			irs_mod1c := 0;
			irs_mod1b := 0;
			irs_mod1a := 0;
			irs_emp := 0;
			irs5500_emps1 := 0;
			ia_ct_m := 0.0;
			cpiall_i := 0;
			currt1src4_m := 0.0;
			cpiall := 0;
			cmpy_stat_m := 0.0;
			brk1_source := 0;
			brk1_source_m := 0.0;
			bkfeinflag1 := 0;
			//======================================================//

			 // **** vernotrecentflag1 ****;

				 /* Calculated above */

			 // **** cur_x1 ****;

			cur_x :=  currcorp+ currdnb+ currucc+ curry+ currphn;
			cur_x1 := map(
				cur_x <= 1 => 16,
				cur_x <= 2 => 19,
				47
			);


			// **** unrel_lienct_m2 ****;
			unrel_lienct_m2 := case( unrel_lienct,
				0 => 0.2025751073,
				1 => 0.174796748,
				2 => 0.1523178808,
				// 3 => 0.1111111111
				0.1111111111
			);

			// ****  id_cnt ****;
			/* calculated above */


			// **** yp_corp ****;
			yp_corp := (integer)(yp_flag=1 and corp_flag=1);


			irs_miss1a := -3.3997365
				+ vernotrecentflag1  * -0.385459851
				+ cur_x1  * 0.0314122779
				+ unrel_lienct_m2  * 8.1417716396
				+ id_ct  * 0.8508359397
				+ yp_corp  * 1.0449934449
			;
			irs_miss1b := (exp(irs_miss1a )) / (1+exp(irs_miss1a ));
			phat := irs_miss1b;
			irs_miss1c := round(1000 * irs_miss1b )/10.0;


			base  := 700;
			odds  :=  .25/.75 ;
			point := 40;

			irs_miss := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

			rsb801_1_0a := irs_miss;

		end;

		// *** score caps ***

		rsb801_1_0b := map(
			rsb801_1_0a > 999 => 999,
			rsb801_1_0a < 300 => 300,
			rsb801_1_0a
		);

		self.seq := le.biid.seq;
		self.acctno := le.biid.account;
		self.score_0_to_999 := intformat(rsb801_1_0b,3,1);
		self := [];
	end;

	model := join( bshell, easi.Key_Easi_Census,
		 keyed(right.geolink=left.biid.st+left.biid.county+left.biid.geo_blk),
		 doModel(left,right),
		 left outer,
		 ATMOST(keyed(right.geolink=left.biid.st+left.biid.county+left.biid.geo_blk),RiskWise.max_atmost),
		 keep(1)
	);


	return model;
END;