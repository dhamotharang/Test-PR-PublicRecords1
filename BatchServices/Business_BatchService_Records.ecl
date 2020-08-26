// NOTE: In DCA, the root-sub expression is a compound value: the root (nine digits) followed by a dash,
// followed by the sub(sidiary) value (four digits). e.g. 123456789-1234. The root denotes the top-level
// company at the head of a conglomerate or set of subsidiaries. e.g. RIAG's root is Reed-Elsevier. The
// sub is simply a surrogate identifier denoting a particular subsidiary in the root's tree. Several
// times in the code below we'll see the expression:
//     LEFT.parent_number[1..9] = RIGHT.root AND
//     LEFT.parent_number[11..14] = RIGHT.sub
//
// Or something similar. [1..9] refers to the root, and [11..14] refers to the particular subsidiary.
// We omit [10] of course, which is the dash.

IMPORT BatchServices, Business_Header_SS, Doxie, DCA, Doxie_cbrs, dx_dca, YellowPages, Business_Header, STD;

EXPORT Business_BatchService_Records(BOOLEAN useCannedRecs, Doxie.IDataAccess mod_access) :=
	FUNCTION

		// Set DPPA and GLBA values to a default value to overcome system restrictions for header lookup and
		// driver's license lookup, if necessary.
		UNSIGNED1 DPPA_Purpose  := 1     : STORED('DPPAPurpose');
		UNSIGNED1 GLB_Purpose   := 8     : STORED('GLBPurpose');
		UNSIGNED4 Max_Results   := 10000 : STORED('MaxResults');

		UNSIGNED1 PenaltThreshold := 10  : STORED('PenaltThreshold');

		/* ***** System flags and values ***** */
		BOOLEAN forceSeqNumber  := TRUE;

		/* ***** Constants ***** */
		INTEGER FOR_PARENT      := 1;  // : for retrieving parent records

		ds_batch_in := IF( NOT useCannedRecs,
											 BatchServices.file_inBatchMaster(forceSeqNumber),
											 BatchServices._Sample_inBatchMaster('Business')
											);

		inBatch_rec := rECORD
				String20  acctno;
				Business_Header_SS.Layout_BDID_InBatch;
		END;

		inBatch_rec xfm_clean_input(ds_batch_in in_bt, unsigned c) := TRANSFORM
			SELF.company_name := STD.Str.ToUpperCase(in_bt.comp_name);
			SELF.prim_range := STD.Str.ToUpperCase(in_bt.prim_range);
			SELF.predir := STD.Str.ToUpperCase(in_bt.predir);
			SELF.prim_name := STD.Str.ToUpperCase(in_bt.prim_name);
			SELF.addr_suffix := STD.Str.ToUpperCase(in_bt.addr_suffix);
			SELF.postdir := STD.Str.ToUpperCase(in_bt.postdir);
			SELF.unit_desig := STD.Str.ToUpperCase(in_bt.unit_desig);
			SELF.sec_range := STD.Str.ToUpperCase(in_bt.sec_range);
			SELF.p_city_name := STD.Str.ToUpperCase(in_bt.p_city_name);
			SELF.st := STD.Str.ToUpperCase(in_bt.st);
			SELF.phone10 := (string10)choose(c,in_bt.homephone,in_bt.workphone);
			SELF.z5 := if(in_bt.z5 != '',in_bt.z5,ziplib.CityToZip5(self.st,self.p_city_name));
			SELF := in_bt;
		END;

		cleaned_in := NORMALIZE(ds_batch_in,2,xfm_clean_input(LEFT,COUNTER));


		Business_Header_SS.MAC_BDID_Append(cleaned_in,match_res0,1)

		match_res := dedup(sort(project(match_res0,{match_res0;string8 dt_last_seen := ''}),seq,-score,bdid),seq);

		// CRIBBING FROM Business_Header_SS/MAC_BestAppend SO THAT I CAN GET DATE LAST SEEN
		os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

		TYPEOF(match_res) append_best(match_res l, Business_Header.Key_BH_Best r) := TRANSFORM
			SELF.best_phone := IF (0 = r.phone, '', INTFORMAT(r.phone, 10, 1));
			SELF.best_fein := IF(0 = r.fein, '', INTFORMAT(r.fein, 9, 1));
			SELF.best_CompanyName := r.company_name;
			SELF.best_addr1 :=
					os(r.prim_range) +
					os(r.predir) +
					os(r.prim_name) +
					os(r.addr_suffix) +
					os(r.postdir) +
						IF (STD.Str.EndsWith (r.prim_name, os(r.unit_desig) + os(r.sec_range)),
							'',
							os(r.unit_desig) + os(r.sec_range));
			SELF.best_city := r.city;
			SELF.best_state := r.state;
			SELF.best_zip := IF(r.zip = 0, '', INTFORMAT(r.zip, 5, 1));
			SELF.best_zip4 := IF(r.zip4 = 0, '', INTFORMAT(r.zip4, 4, 1));
			SELF.dt_last_seen := IF(0 = r.dt_last_seen, '', INTFORMAT(r.dt_last_seen, 8, 1));
			SELF := l;
		END;

		best_res := JOIN(match_res, Business_Header.Key_BH_Best,
							KEYED((UNSIGNED6) LEFT.bdid != 0 AND (UNSIGNED6) LEFT.bdid = RIGHT.bdid) AND 
              doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
							append_best(LEFT, RIGHT),
							LEFT OUTER,
							KEEP (1), LIMIT (0)
							);

		/* convert output to all strings */
		BatchServices.layout_Business_Batch_out xfm_best_res(cleaned_in l,best_res r) := TRANSFORM
				SELF.process_date := r.dt_last_seen;
				SELF.company_name := r.best_companyname;
				SELF.street       := r.best_addr1;
				SELF.city         := r.best_city;
				SELF.state        := r.best_state;
				SELF.zip          := r.best_zip;
				SELF.phone        := r.best_phone;
				SELF.bdid         := r.bdid;
				SELF.acctno       := l.acctno;
				SELF := [];
		END;

		out_res_acctno := JOIN(cleaned_in,best_res
														,LEFT.seq = RIGHT.seq
														,xfm_best_res(LEFT,RIGHT));

		dca_xform_layout := RECORD
			BatchServices.layout_Business_Batch_out;
			boolean appended := false;
			string9 ent_num;
		END;

		dca_xform_layout add_DCA_data_xform(BatchServices.layout_Business_Batch_out L,
			DCA.Layout_DCA_Base_slim R) := TRANSFORM
				self.ent_num := R.Enterprise_num;
				self.appended     := R.bdid != 0;
				self.level        := R.level;
				self.root         := R.root;
				self.sub          := R.sub;
				self.parent_number:= R.parent_number;
				self.sic_cd       := R.sic1;
				self.sic_desc     := STD.Str.ToUpperCase(R.text1);
				self.sales        := R.sales;
				self.earnings     := R.earnings;
				self.num_employees:= R.emp_num;
				self.email        := R.e_mail;
				self.url          := R.url;
				SELF.executive_1_name := STD.Str.ToUpperCase(R.name_1);
				SELF.executive_1_title := STD.Str.ToUpperCase(R.title_1);
				SELF.executive_2_name := STD.Str.ToUpperCase(R.name_2);
				SELF.executive_2_title := STD.Str.ToUpperCase(R.title_2);
				SELF.executive_3_name := STD.Str.ToUpperCase(R.name_3);
				SELF.executive_3_title := STD.Str.ToUpperCase(R.title_3);
				SELF.executive_4_name := STD.Str.ToUpperCase(R.name_4);
				SELF.executive_4_title := STD.Str.ToUpperCase(R.title_4);
				SELF.executive_5_name := STD.Str.ToUpperCase(R.name_5);
				SELF.executive_5_title := STD.Str.ToUpperCase(R.title_5);
				SELF.executive_6_name := STD.Str.ToUpperCase(R.name_6);
				SELF.executive_6_title := STD.Str.ToUpperCase(R.title_6);
				SELF.executive_7_name := STD.Str.ToUpperCase(R.name_7);
				SELF.executive_7_title := STD.Str.ToUpperCase(R.title_7);
				SELF.executive_8_name := STD.Str.ToUpperCase(R.name_8);
				SELF.executive_8_title := STD.Str.ToUpperCase(R.title_8);
				SELF.executive_9_name := STD.Str.ToUpperCase(R.name_9);
				SELF.executive_9_title := STD.Str.ToUpperCase(R.title_9);
				SELF.executive_10_name := STD.Str.ToUpperCase(R.name_10);
				SELF.executive_10_title := STD.Str.ToUpperCase(R.title_10);
				self.secondary_sic_1_cd   := R.sic2;
				self.secondary_sic_1_desc := STD.Str.ToUpperCase(R.text2);
				self.secondary_sic_2_cd   := R.sic3;
				self.secondary_sic_2_desc := STD.Str.ToUpperCase(R.text3);
				self.secondary_sic_3_cd   := R.sic4;
				self.secondary_sic_3_desc := STD.Str.ToUpperCase(R.text4);
				self.secondary_sic_4_cd   := R.sic5;
				self.secondary_sic_4_desc := STD.Str.ToUpperCase(R.text5);
				self := L;
		END;

		dca_data_raw := dx_dca.get_bdid(out_res_acctno, mod_access, add_contacts:=TRUE);

		add_DCA_data := JOIN(out_res_acctno, dca_data_raw,
			left.bdid = right.bdid,
			add_DCA_data_xform(LEFT, RIGHT),
			keep(1), limit (0),
			left outer);

		add_YP_data := JOIN(add_DCA_data,YellowPages.key_YellowPages_BDID,
			left.bdid = right.bdid and
			not left.appended and
			right.source = 'Y',
			transform(recordof(out_res_acctno),
				tempmatch := right.bdid != 0;
				self.sic_cd        := if(tempmatch,right.sic_code,left.sic_cd),
				self.sic_desc      := if(tempmatch,right.heading_string,left.sic_desc),
				self.num_employees := if(tempmatch,case(STD.Str.ToUpperCase(right.Employee_Code),
																	 'A' => '1-4',
																	 'B' => '5-9',
																	 'C' => '10-19',
																	 'D' => '20-49',
																	 'E' => '50-99',
																	 'F' => '100-249',
																	 'G' => '250-499',
																	 'H' => '500-999',
																	 'I' => '1000+',
																	 ''),left.num_employees),
				self.email         := if(tempmatch,right.email_address,left.email),
				self.url           := if(tempmatch,right.web_address,left.url),
				self.executive_1_name  := if(tempmatch,right.executive_name,left.executive_1_name),
				self.executive_1_title := if(tempmatch,right.executive_title,left.executive_1_title),
				self := left),
			keep(1),
			left outer);

		// 9. Next, get parent company and add to output layout.
		ds_parents := doxie_cbrs.get_DCA_records( dedup(sort(project(add_YP_data(root != ''),doxie_cbrs.layout_references),bdid),bdid), FOR_PARENT );

		BatchServices.layout_Business_Batch_out xfm_add_parent(BatchServices.layout_Business_Batch_out l, recordof(ds_parents) r) :=
			TRANSFORM
				SELF.parent_company_name := STD.Str.ToUpperCase(r.Name);
				SELF.parent_street       := STD.Str.ToUpperCase(r.Street);
				SELF.parent_city         := STD.Str.ToUpperCase(r.City);
				SELF.parent_state        := STD.Str.ToUpperCase(r.State);
				SELF.parent_zip          := r.Zip;
				SELF.parent_phone        := r.Phone;
				SELF                     := l;
			END;

		ds_flat_recs_with_parent := JOIN(add_YP_data, ds_parents,
																		 LEFT.parent_number[1..9] = RIGHT.root AND
																		 LEFT.parent_number[11..14] = RIGHT.sub,
																		 xfm_add_parent(LEFT,RIGHT),
																		 LEFT OUTER, LIMIT(1000,SKIP) );

		// 10. Isolate the bdid from each input business along with its parent root and sub. We'll use this
		// structure to tie any parent subsidiaries back to the input companies.
		rec_business_root_sub := RECORD
			UNSIGNED6 bdid       :=  0;
			STRING9 parent_root  := '';
			STRING4 parent_sub   := '';
		END;

		rec_business_root_sub xfm_isolate_parent_root_and_sub(BatchServices.layout_Business_Batch_out l) :=
			TRANSFORM
				SELF.bdid        := l.bdid;
				SELF.parent_root := l.parent_number[1..9];
				SELF.parent_sub  := l.parent_number[11..14];
			END;

		ds_bdid_plus_parent_root_and_sub := PROJECT(ds_flat_recs_with_parent, xfm_isolate_parent_root_and_sub(LEFT));

		ds_bdid_plus_parent_root_and_sub_deduped :=
						DEDUP(SORT(ds_bdid_plus_parent_root_and_sub(parent_root != '' AND parent_sub != ''),
											 parent_root, parent_sub),
									parent_root, parent_sub);

		// 11. Get parent subsidiaries.

		key_parent_to_child := DCA.Key_DCA_Hierarchy_Parent_to_Child_Root_Sub;

		ds_parent_root_and_sub := PROJECT(ds_bdid_plus_parent_root_and_sub_deduped, rec_business_root_sub AND NOT bdid);

		rec_parent_subsid := RECORD
			STRING9 parent_root         := '';
			STRING4 parent_sub          := '';
			STRING9 parent_subsid_root  := '';
			STRING4 parent_subsid_sub   := '';
			STRING2 parent_subsid_level := '';
		END;

		rec_parent_subsid xfm_get_parent_subsids(ds_parent_root_and_sub l, key_parent_to_child r) :=
			TRANSFORM
				SELF.parent_root         := l.parent_root;
				SELF.parent_sub          := l.parent_sub;
				SELF.parent_subsid_root  := r.child_root;
				SELF.parent_subsid_sub   := r.child_sub;
				SELF.parent_subsid_level := r.child_level;
			END;

		ds_parent_subsid_root_sub := JOIN( ds_parent_root_and_sub, key_parent_to_child,
																 KEYED(RIGHT.parent_root = LEFT.parent_root) AND
																 KEYED(RIGHT.parent_sub = LEFT.parent_sub),
																 xfm_get_parent_subsids(LEFT,RIGHT),
																 LEFT OUTER, LIMIT(1000,SKIP) );

		// .. Grab the top three parent subsidies for each root-sub group.
		ds_parent_subsids_root_sub_grouped := GROUP(SORT(ds_parent_subsid_root_sub, parent_root, parent_sub), parent_root, parent_sub);
		ds_parent_subsids_root_sub_topped := TOPN(ds_parent_subsids_root_sub_grouped, 3, parent_root, parent_sub);

		// .. Remove any subsidiaries that happen to be the input business.
		ds_parent_subsids_root_sub_no_input := JOIN(ds_parent_subsids_root_sub_topped, add_YP_data,
																								LEFT.parent_subsid_root = RIGHT.root AND
																								LEFT.parent_subsid_sub = RIGHT.sub,
																								TRANSFORM(rec_parent_subsid, SELF := LEFT;),
																								LEFT ONLY);

		// .. TOPN the top 2; displaying a max of 2 subsidiaries is a RIAG contractual limitation.
		ds_parent_subsids_root_sub_no_input_grouped := GROUP(SORT(ds_parent_subsids_root_sub_no_input, parent_root, parent_sub), parent_root, parent_sub);
		ds_parent_subsids_root_sub_no_input_topped := TOPN(ds_parent_subsids_root_sub_no_input_grouped, 2, parent_root, parent_sub);

		// .. Go and get the two parent subsidiary records...finally.
		ds_parent_subsids := JOIN( ds_parent_subsids_root_sub_no_input_topped, DCA.Key_DCA_Root_Sub,
															 KEYED(RIGHT.root = LEFT.parent_subsid_root) AND
															 KEYED(RIGHT.sub = LEFT.parent_subsid_sub),
															 LEFT OUTER, LIMIT(1,SKIP));

		ds_input_bdid_and_parent_subsids := JOIN(ds_bdid_plus_parent_root_and_sub, ds_parent_subsids,
																						 LEFT.parent_root = RIGHT.parent_root AND
																						 LEFT.parent_sub = RIGHT.parent_sub,
																						 INNER);

		ds_input_bdid_and_parent_subsids_grouped := GROUP(SORT(ds_input_bdid_and_parent_subsids, bdid, parent_root, parent_sub), bdid, parent_root, parent_sub);

		ds_first_parent_subsid := TOPN(ds_input_bdid_and_parent_subsids_grouped, 1, bdid, parent_root, parent_sub);

		ds_secnd_parent_subsid := JOIN(ds_input_bdid_and_parent_subsids_grouped, ds_first_parent_subsid,
																		LEFT.bdid = RIGHT.bdid AND
																		LEFT.root = RIGHT.root AND
																		LEFT.sub = RIGHT.sub,
																		LEFT ONLY);

		// .. add up to two parent subsidiaries to the output layout.
		BatchServices.layout_Business_Batch_out xfm_add_first_subsid(BatchServices.layout_Business_Batch_out l, RECORDOF(ds_first_parent_subsid) r) :=
			TRANSFORM
				SELF.parent_subsid_1_company_name := STD.Str.ToUpperCase(r.Name);
				SELF.parent_subsid_1_street       := STD.Str.ToUpperCase(r.Street);
				SELF.parent_subsid_1_city         := STD.Str.ToUpperCase(r.City);
				SELF.parent_subsid_1_state        := STD.Str.ToUpperCase(r.State);
				SELF.parent_subsid_1_zip          := r.Zip;
				SELF.parent_subsid_1_phone        := r.Phone;
				SELF                              := l;
			END;

		ds_flat_recs_with_first_subsid := JOIN(ds_flat_recs_with_parent, ds_first_parent_subsid,
																					 LEFT.bdid = RIGHT.bdid AND
																					 LEFT.parent_number[1..9] = RIGHT.parent_root AND
																					 LEFT.parent_number[11..14] = RIGHT.parent_sub,
																					 xfm_add_first_subsid(LEFT,RIGHT),
																					 LEFT OUTER);

		BatchServices.layout_Business_Batch_out xfm_add_second_subsid(BatchServices.layout_Business_Batch_out l, RECORDOF(ds_secnd_parent_subsid) r) :=
			TRANSFORM
				SELF.parent_subsid_2_company_name := STD.Str.ToUpperCase(r.Name);
				SELF.parent_subsid_2_street       := STD.Str.ToUpperCase(r.Street);
				SELF.parent_subsid_2_city         := STD.Str.ToUpperCase(r.City);
				SELF.parent_subsid_2_state        := STD.Str.ToUpperCase(r.State);
				SELF.parent_subsid_2_zip          := r.Zip;
				SELF.parent_subsid_2_phone        := r.Phone;
				SELF                              := l;
			END;

		ds_flat_recs_with_secnd_subsid := JOIN(ds_flat_recs_with_first_subsid, ds_secnd_parent_subsid,
																					 LEFT.bdid = RIGHT.bdid AND
																					 LEFT.parent_number[1..9] = RIGHT.parent_root AND
																					 LEFT.parent_number[11..14] = RIGHT.parent_sub,
																					 xfm_add_second_subsid(LEFT,RIGHT),
																					 LEFT OUTER);

		// OUTPUT(outPLfat, NAMED('outPLfat'));
		// OUTPUT(ds_acctnos_and_bdids_from_aks, NAMED('ds_acctnos_and_bdids_from_aks'));
		// OUTPUT(ds_acctnos_and_bdids_from_fein_key, NAMED('ds_acctnos_and_bdids_from_fein_key'));
		// OUTPUT(ds_acctnos_and_bdids, NAMED('ds_acctnos_and_bdids'));
		// OUTPUT(ds_batch_in, named('ds_batch_in'));
		// OUTPUT(ds_fids, NAMED('ds_fids'));
		// output(ds_business_bdids, named('ds_business_bdids'));


		// 12. Slim off Level, Root, Sub, Parent_Number. The customer doesn't need to know those data.
		ds_results := PROJECT(ds_flat_recs_with_secnd_subsid, BatchServices.layout_Business_Batch_out AND NOT [Level, Root, Sub, Parent_Number]);
		// OUTPUT(add_DCA_data, named('add_DCA_data'));

		RETURN DEDUP(SORT(ds_results,acctno,record),acctno,record);
/*return
parallel(
	 output(ds_batch_in																		,named('ds_batch_in'))
	,output(cleaned_in																		,named('cleaned_in'))
	,output(match_res0																		,named('match_res0'))
	,output(match_res																			,named('match_res'))
	,output(best_res																			,named('best_res'))
	,output(out_res_acctno																,named('out_res_acctno'))
	,output(add_DCA_data																	,named('add_DCA_data'))
	,output(add_YP_data																		,named('add_YP_data'))
	,output(ds_parents																		,named('ds_parents'))
	,output(ds_flat_recs_with_parent											,named('ds_flat_recs_with_parent'))
	,output(ds_bdid_plus_parent_root_and_sub							,named('ds_bdid_plus_parent_root_and_sub'))
	,output(ds_bdid_plus_parent_root_and_sub_deduped			,named('ds_bdid_plus_parent_root_and_sub_deduped'))
	,output(key_parent_to_child														,named('key_parent_to_child'))
	,output(ds_parent_root_and_sub												,named('ds_parent_root_and_sub'))
	,output(ds_parent_subsid_root_sub											,named('ds_parent_subsid_root_sub'))
	,output(ds_parent_subsids_root_sub_grouped						,named('ds_parent_subsids_root_sub_grouped'))
	,output(ds_parent_subsids_root_sub_topped							,named('ds_parent_subsids_root_sub_topped'))
	,output(ds_parent_subsids_root_sub_no_input						,named('ds_parent_subsids_root_sub_no_input'))
	,output(ds_parent_subsids_root_sub_no_input_grouped		,named('ds_parent_subsids_root_sub_no_input_grouped'))
	,output(ds_parent_subsids_root_sub_no_input_topped		,named('ds_parent_subsids_root_sub_no_input_topped'))
	,output(ds_parent_subsids															,named('ds_parent_subsids'))
	,output(ds_input_bdid_and_parent_subsids							,named('ds_input_bdid_and_parent_subsids'))
	,output(ds_input_bdid_and_parent_subsids_grouped			,named('ds_input_bdid_and_parent_subsids_grouped'))
	,output(ds_first_parent_subsid												,named('ds_first_parent_subsid'))
	,output(ds_secnd_parent_subsid												,named('ds_secnd_parent_subsid'))
	,output(ds_flat_recs_with_first_subsid								,named('ds_flat_recs_with_first_subsid'))
	,output(ds_flat_recs_with_secnd_subsid								,named('ds_flat_recs_with_secnd_subsid'))
	,output(ds_results																		,named('ds_results'))
);
*/
	END;


	/* Product Requirements ('o' indicates agreed-on requirements; others were in contention):

			Input Field Names:
		Company Name
		Address
		FEIN
		SIC Code -- ***NO...used for internal marketing only. This will be used for the bulk version of this service. ***

			Output Field Names:
		Company name o
		Address o
		SIC Code o
		Revenue/Annual Sales o
		Executives o

			Also:
		Number of employees o
		Parent company \ Ultimate Company o
		Parent Address, City, State, Zip, Phone \ Ultimate Address, City, State, Zip, Phone o
		Subsidiary company(ies) -- *** NO. LEGAL/SHARING ISSUES. ***
		SIC Description o
		URL \ Web site o
		E-mail Addresses -- *** Meh. ***

		Return 4 secondary_sic records; 6 franchise records; 10 contact records
*/
