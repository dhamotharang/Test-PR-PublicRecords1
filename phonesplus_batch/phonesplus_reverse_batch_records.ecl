IMPORT phonesplus_batch, Royalty, Gateway, phonesplus_v2, Phones, MDR, doxie, Gong, ut;
//AutoKey

//Royalty.Layouts.RoyaltyForBatch
// phonesplus_batch.layout_phonesplus_reverse_batch_in
	EXPORT phonesplus_batch.layout_phonesplus_reverse_batch_records_out
					phonesplus_reverse_batch_records( DATASET(phonesplus_batch.layout_phonesplus_reverse_batch_in) f_in,
																						phonesplus_batch.options.IOptions optionsIn) := FUNCTION

    mod_access := PROJECT(optionsIn, Doxie.IDataAccess);

		BOOLEAN ExcludeCurrentGong := optionsIn.ExcludeCurrentGong;
		BOOLEAN use_tg := optionsIn.IncludeTargus;
		BOOLEAN include_qt := optionsIn.IncludeQsent;
		// BOOLEAN use_cfm := optionsIn.IncludeTargusWireless;//Is this been used???????????????????
		gateways := optionsIn.Gateways;
		targus_cfg := gateways(Gateway.Configuration.isTargus(servicename))[1];

		//get the seq for input
		phonesplus_batch.layout_phonesplus_reverse_in_seq get_seq(f_in l, unsigned cnt) := transform
			self.seq := cnt;
			self := l;
		end;

		f_in_seq := project(f_in, get_seq(left, counter));

		//get the phonesplus records
		phonesplus_batch.mac_get_ppl_by_phone(f_in_seq, f_out_ppl
																					,optionsIn.glb
																					,optionsIn.dppa
																					,optionsIn.industry_class
																					, //min_confidencescore, use macro default of 11
																					,doxie.DataRestriction.fixed_DRM);

		//get the gong records(if requested)
		phonesplus_batch.mac_get_gong_by_phone(f_in_seq, f_out_gong, mod_access, ~ExcludeCurrentGong);

		f_in_pp1 := if(ExcludeCurrentGong,
												f_out_ppl(activeflag=''),
												f_out_ppl(activeflag='') + f_out_gong);

		//get the targus records
		phonesplus_batch.layout_phonesplus_reverse_in_seq check_input(f_in_seq l) := transform
			self := l;
		end;

		f_in_seq_targus := join(f_in_seq, f_in_pp1,
														left.seq = right.seq,
														check_input(left),
														left only);

		phonesplus_batch.mac_get_targus_by_phone(f_in_seq_targus, f_out_targus, targus_cfg, use_tg);

		f_in_pp2 := f_in_pp1 + f_out_targus((unsigned)phone<>0);

		//get the qsent records, if qsent in-house data is permitted and it was requested to be included
		f_in_seq_qsent := join(f_in_seq, f_in_pp2,
													 left.seq = right.seq,
													 check_input(left),
													 left only);

		boolean use_qt := doxie.DataPermission.use_qsent and include_qt;

		phonesplus_batch.mac_get_qsent_by_phone(f_in_seq_qsent, f_out_qsent,,use_qt,optionsIn);

		f_in_pp3 := f_in_pp2 + f_out_qsent;

		phonesplus_batch.layout_phonesplus_reverse_common get_no_match(f_in_seq l) := transform
				self.phone := l.phoneno;
				self := l;
				self := [];
		end;

		f_in_pp3_no_match := join(f_in_seq, f_in_pp3,
															left.seq = right.seq,
															get_no_match(left), left only);

		//sort to prepare for dedup
		f_out_pp_srt1 := sort(f_in_pp3 + f_in_pp3_no_match, seq, phone, if(lname<>'',lname, listed_name), fname, prim_range, prim_name, zip,
													penalt, map(phonesplus_v2.IsCell(append_phone_type)=>1,vendor_id=MDR.sourceTools.src_Targus_Gateway=>2, vendor_id='GH'=>3,4), -ConfidenceScore,
													-dt_last_seen, if(activeflag='Y',0,1), doxie.tnt_score(tnt), dt_first_seen);

		f_out_pp_dep := dedup(f_out_pp_srt1, seq, phone, if(lname<>'',lname, listed_name), fname, prim_range, prim_name, zip);

		//sort to pick the 'top' record
		f_out_pp_srt2 := sort(f_out_pp_dep, seq, penalt, map(phonesplus_v2.IsCell(append_phone_type)=>1,vendor_id=MDR.sourceTools.src_Targus_Gateway=>2, vendor_id='GH'=>3,4), -ConfidenceScore,
												-dt_last_seen, if(activeflag='Y',0,1), doxie.tnt_score(tnt), dt_first_seen);

		f_out_exp := doxie.phone_metadata(f_out_pp_srt2,'');

		layout_phonesplus_reverse_batch_pre_out := record
			string seq;
			phonesplus_batch.layout_phonesplus_reverse_batch_out;
		end;

		layout_phonesplus_reverse_batch_pre_out createPreFinalLayout(f_out_exp l) := transform
				self.seq							 := (string)l.seq;
				self.acctno            := l.acctno;
				self.did               := (string)((unsigned6)l.did);
				self.typeFlag          := map(l.src != 'PH' => Phones.Constants.TypeFlag.NonDirectoryAssistance,
																			l.src  = 'PH' and l.tnt = 'H' => Phones.Constants.TypeFlag.DirectoryAssistance_Disconnected,
																			l.src  = 'PH' and l.tnt != 'H' => Phones.Constants.TypeFlag.DirectoryAssistance,
																			'');
				self.dial_indicator    := map(l.dial_ind = '1' => 'Y',
																			l.dial_ind = '0' => 'N',
																			'');
				self.phone_region_city := l.city;
				self.phone_region_st   := l.state;
				self.telcordia_only    := if(l.listed_name='' and l.prim_name='','Y','N');
				self.Carrier_Name      := l.ocn;
				boolean isCell := phonesplus_v2.IsCell(l.append_Phone_type);
				self.COCDescription    := if(isCell,'Cellular', '');
				//multiple of 2 - from ppls, 3 - checked with neustar, 5 - checked with telcordia
				self.cell_type	     := if(isCell,
																	 2*if(l.cellphone<>'',3,1), if(l.cellphone<>'',3,1));
				self                   := l;
				self                   := [];
		end;

	// #######################################################################################
	//  This code prepares the telcordia data in case we need it later

		f_out_final1 := project(f_out_exp, createPreFinalLayout(left))(listed_name <>'' or
																																		prim_name <> '' or
																																		carrier_name <>'' or
																																		phone_region_city <>'');

		//get the description
		layout_phonesplus_reverse_batch_pre_out getDescription(f_out_final1 l) := transform

		cell_filt1 := l.COCType = 'EOC' and (
								stringlib.stringfind(l.ssc, 'C', 1) > 0 or
						 stringlib.stringfind(l.ssc, 'R', 1) > 0);

		cell_filt2 := (l.COCType = 'PMC' or l.COCType = 'RCC' or l.COCType = 'SP1' or l.COCType = 'SP2')
									 and (stringlib.stringfind(l.ssc, 'C', 1) > 0 or
								 stringlib.stringfind(l.ssc, 'R', 1) > 0 or
						stringlib.stringfind(l.ssc, 'S', 1) > 0);

		page_filt1 := l.COCType = 'EOC' and stringlib.stringfind(l.ssc, 'B', 1) > 0;

		page_filt2 := (l.COCType = 'PMC' or l.COCType = 'RCC' or l.COCType = 'SP1' or l.COCType = 'SP2')
									 and stringlib.stringfind(l.ssc, 'B', 1) > 0;

		self.COCDescription := map(l.COCType = 'EOC' => 'LandLine',
															 cell_filt1 or cell_filt2 => 'Cellular',
															 page_filt1 or page_filt2 => 'Paging',
															 '');

		self.cell_type := if(cell_filt1 or cell_filt2,l.cell_type*5, l.cell_type);
		// or l.telcordia_only = 'Y' and exists(h1)
		self.new_type := map(l.typeFlag='G' => 'Current DA',
												 ~(self.cell_type%3=0 or self.cell_type%5=0) and l.confirmed_flag => 'Confirmed non-DA',
						 ~(self.cell_type%3=0 or self.cell_type%5=0) and ~l.confirmed_flag => 'Possible non-DA',
						 self.cell_type%5=0 and l.confirmed_flag => 'Confirmed Cell Phone',
						 self.cell_type%5=0 and ~l.confirmed_flag => 'Possible Cell Phone',
						 self.cell_type%3=0 and ~l.confirmed_flag => 'Possible Ported Cell Phone',
						 self.cell_type%3=0 and l.confirmed_flag => 'Confirmed Ported Cell Phone',
												 '');

			self.sscDescription := Phones.Functions.getSSCDescription(l.ssc);

			self                := l;
		end;
		f_out_final2 := project(f_out_final1, getDescription(left));

		f_out_final3 := sort(f_out_final2, acctno, telcordia_only, penalt, -confirmed_flag, map(phonesplus_v2.IsCell(append_phone_type)=>1,vendor_id='TG'=>2, vendor_id='GH'=>3,4),
												 -ConfidenceScore, listed_name, phone, fname, mname, lname, prim_name, prim_range, city_name, zip, zip4);

		ut.getTimeZone(f_out_final3,phone,timezone,f_out_final4)

		dResults := project(f_out_final4, transform(phonesplus_batch.layout_phonesplus_reverse_string_out,
																										self.penalt := (string3)left.penalt,
																										self.confirmed_flag := if(left.confirmed_flag,'Y','N'),
																										self.ConfidenceScore := (string3)left.ConfidenceScore,
																										self.cell_type := (string5)left.cell_type,
																										self.vendor_dt_last_seen_used := if(left.vendor_dt_last_seen_used,'Y','N'),
																										self := left));

		// ROYALTIES
		boolean ReturnDetailedRoyalties := optionsIn.ReturnDetailedRoyalties;
		dRoyaltiesQSent  := Royalty.RoyaltyQSent.GetBatchRoyaltiesByAcctno(f_in_seq, f_out_final4, vendor_id, typeflag, seq, acctno);
		dRoyaltiesTargus := Royalty.RoyaltyTargus.GetBatchRoyaltiesByAcctno(f_in_seq, f_out_final4, vendor_id, targustype, seq, acctno);

		dRoyaltiesByAcctno :=
			if(use_qt, dRoyaltiesQSent) + // inhouse qsent only
			if(use_tg, dRoyaltiesTargus);
		dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, ReturnDetailedRoyalties);

		RETURN ROW({dResults, dRoyalties},phonesplus_batch.layout_phonesplus_reverse_batch_records_out);
	END;