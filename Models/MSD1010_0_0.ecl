import risk_indicators;

export MSD1010_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam ) := FUNCTION
	MSD_DEBUG := false;

	#if(MSD_DEBUG)
	layout_debug := record
		risk_indicators.layout_boca_shell;
		boolean add1_isbestmatch;
		unsigned add1_date_first_seen;
		unsigned add1_date_last_seen;
		boolean add2_isbestmatch;
		unsigned add2_date_first_seen;
		unsigned add2_date_last_seen;
		boolean add3_isbestmatch;
		unsigned add3_date_first_seen;
		unsigned add3_date_last_seen;
		unsigned addrs_5yr;
		unsigned credit_first_seen;
		unsigned header_first_seen;
		integer curr_fs;
		integer curr_ls;
		integer prev_fs;
		integer prev_ls;
		integer curr_fs2;
		integer curr_ls2;
		integer prev_fs2;
		integer prev_ls2;
		real tot_stay_curr;
		real tot_stay_prev;
		real tot_stay_last_two_new;
		boolean zero_fs;
		integer MSD1010;
	end;
	layout_debug doModel( clam le ) := TRANSFORM
	#else
	risk_indicators.layout_boca_shell doModel( clam le ) := TRANSFORM
	#end
		/************************************************************************************/
		/* MSD1010.0.0                      Version 01                                BY BS */
		/*                               Project ID:  ????                       12/10/2010 */
		/************************************************************************************/

		/************************************************************************************/
		/* Fields from Modeling Shell 3.0                                                   */
		/************************************************************************************/
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		add1_date_last_seen              := le.address_verification.input_address_information.date_last_seen;
		add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
		add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
		add2_date_last_seen              := le.address_verification.address_history_1.date_last_seen;
		add3_isbestmatch                 := le.address_verification.address_history_2.isbestmatch;
		add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
		add3_date_last_seen              := le.address_verification.address_history_2.date_last_seen;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		credit_first_seen                := le.ssn_verification.credit_first_seen;
		header_first_seen                := le.ssn_verification.header_first_seen;

		/************************************************************************************/
		/* Code Starts Here                                                                 */
		/************************************************************************************/
		picker := map(
			add1_isbestmatch => 1,
			add2_isbestmatch and ( add1_date_last_seen > add3_date_last_seen ) => 2,
			add2_isbestmatch and ( add1_date_last_seen = add3_date_last_seen ) and ( add1_date_first_seen >= add3_date_first_seen ) => 3,
			add3_isbestmatch and ( add1_date_last_seen > add2_date_last_seen ) => 4,
			add3_isbestmatch and ( add1_date_last_seen = add2_date_last_seen ) and ( add1_date_first_seen >= add2_date_first_seen ) => 5,
			add2_isbestmatch => 6,
			add3_isbestmatch => 7,
			add2_date_first_seen > 0 => 8,
			9
		);

		curr_fs := choose( picker, add1_date_first_seen, add2_date_first_seen, add2_date_first_seen, add3_date_first_seen, add3_date_first_seen, add2_date_first_seen, add3_date_first_seen, add2_date_first_seen, 0);
		curr_ls := choose( picker, add1_date_last_seen , add2_date_last_seen , add2_date_last_seen , add3_date_last_seen , add3_date_last_seen , add2_date_last_seen , add3_date_last_seen , add2_date_last_seen , 0);
		prev_fs := choose( picker, add2_date_first_seen, add1_date_first_seen, add1_date_first_seen, add1_date_first_seen, add1_date_first_seen, add3_date_first_seen, add2_date_first_seen, add3_date_first_seen, 0);
		prev_ls := choose( picker, add2_date_last_seen , add1_date_last_seen  ,add1_date_last_seen , add1_date_last_seen , add1_date_last_seen , add3_date_last_seen , add2_date_last_seen , add3_date_last_seen , 0);
		
		curr_fs2 := models.common.sas_date((string)curr_fs);
		curr_ls2 := models.common.sas_date((string)curr_ls);
		prev_fs2 := models.common.sas_date((string)prev_fs);
		prev_ls2 := models.common.sas_date((string)prev_ls);


		tot_stay_curr := if( curr_ls2=common.null or curr_fs2=common.null, common.null, ( curr_ls2 - curr_fs2 ) / 365.25);
		tot_stay_prev := if( prev_ls2=common.null or prev_fs2=common.null, common.null, ( prev_ls2 - prev_fs2 ) / 365.25);

		tot_stay_last_two_new := map(
			tot_stay_prev = common.null   => tot_stay_curr,
			curr_ls2 > prev_ls2 => ( curr_ls2 - prev_fs2 ) / 365.25,
			( prev_ls2 - prev_fs2 ) / 365.25
		);

		zero_fs := ( header_first_seen = 0 ) and ( credit_first_seen = 0 );

		MSD1010 := map(
			(tot_stay_curr = common.null) or zero_fs       => 0,
			(tot_stay_curr >= 7)                           => 6,
			(tot_stay_last_two_new >= 7)                   => 5,
			(tot_stay_last_two_new >= 5) and (addrs_5yr=0) => 5,
			(tot_stay_last_two_new >= 4)                   => 4,
			(tot_stay_last_two_new >= 2) and (addrs_5yr=0) => 4,
			(tot_stay_last_two_new >= 2)                   => 3,
			(tot_stay_last_two_new >= 1) and (addrs_5yr=0) => 3,
			(tot_stay_last_two_new >= 1)                   => 2,
			(addrs_5yr=0) => 2,
			1
		);
	
		#if(MSD_DEBUG)
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_date_first_seen := add1_date_first_seen;
			self.add1_date_last_seen := add1_date_last_seen;
			self.add2_isbestmatch := add2_isbestmatch;
			self.add2_date_first_seen := add2_date_first_seen;
			self.add2_date_last_seen := add2_date_last_seen;
			self.add3_isbestmatch := add3_isbestmatch;
			self.add3_date_first_seen := add3_date_first_seen;
			self.add3_date_last_seen := add3_date_last_seen;
			self.addrs_5yr := addrs_5yr;
			self.credit_first_seen := credit_first_seen;
			self.header_first_seen := header_first_seen;
			self.curr_fs := curr_fs;
			self.curr_ls := curr_ls;
			self.prev_fs := prev_fs;
			self.prev_ls := prev_ls;
			self.curr_fs2 := curr_fs2;
			self.curr_ls2 := curr_ls2;
			self.prev_fs2 := prev_fs2;
			self.prev_ls2 := prev_ls2;
			self.tot_stay_curr := tot_stay_curr;
			self.tot_stay_prev := tot_stay_prev;
			self.tot_stay_last_two_new := tot_stay_last_two_new;
			self.zero_fs := zero_fs;
			self.MSD1010 := MSD1010;
		#end
		
		// self.? := MSD1010;
		self.addr_stability := (string)MSD1010;
		self := le;

	end;
	
	scored := project( clam, doModel(left) );
	return scored;
end;