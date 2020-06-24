// IMPORT Autokey_batch, AutoStandardI, BatchServices, Business_Header_SS, AutokeyB2, Doxie, ut, DCAV2;
IMPORT Autokey_batch, BatchServices, Business_Header_SS, AutokeyB2, ut, DCA, Doxie, dx_dca;

// Local layouts.
rec_keybuild_plus_acctno := RECORD
	STRING20 acctno         := '0';
	STRING8  lookup_type    := '';
	UNSIGNED2 penalty_value :=  0;
	DCA.Layout_DCA_Base_slim;
	// DCAV2.Layouts.base.keybuildSlim;   This line will replace the line above it once DCAV2 is complete
END;

batch_out_plus := RECORD
	UNSIGNED2 penalty_value;
	layouts_batch.Batch_out;
END;

get_penalty_value(DCA_Services.layouts_batch.Batch_in le, rec_keybuild_plus_acctno ri) :=
	FUNCTION

		mod_input_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := le.prim_range;
			EXPORT predir      := le.predir;
			EXPORT prim_name   := le.prim_name;
			EXPORT addr_suffix := le.addr_suffix;
			EXPORT postdir     := le.postdir;
			EXPORT sec_range   := le.sec_range;
			EXPORT p_city_name := le.p_city_name;
			EXPORT st          := le.st;
			EXPORT z5          := le.z5;
		END;

		mod_matched_bus_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := ri.prim_range;
			EXPORT predir      := ri.predir;
			EXPORT prim_name   := ri.prim_name;
			EXPORT addr_suffix := ri.addr_suffix;
			EXPORT postdir     := ri.postdir;
			EXPORT sec_range   := ri.sec_range;
			EXPORT p_city_name := ri.p_city_name;
			EXPORT st          := ri.st;
			EXPORT z5          := ri.z5;
		END;

		mod_matched_mail_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := ri.prim_rangeA;
			EXPORT predir      := ri.predirA;
			EXPORT prim_name   := ri.prim_nameA;
			EXPORT addr_suffix := ri.addr_suffixA;
			EXPORT postdir     := ri.postdirA;
			EXPORT sec_range   := ri.sec_rangeA;
			EXPORT p_city_name := ri.p_city_nameA;
			EXPORT st          := ri.stA;
			EXPORT z5          := ri.zipA;
		END;

		// A company name and a parent name exist for each record, score and take the best(lowest) penalty value
		penalized_companyname := MIN(ut.mod_penalize.company_name(le.comp_name, ri.Name),
																 ut.mod_penalize.company_name(le.comp_name, ri.Parent_Name));
		// A property and mailing address exist for each record, score and take the best(lowest) penalty value
		penalized_address := MIN(ut.mod_penalize.address(mod_input_address, mod_matched_mail_address),
														 ut.mod_penalize.address(mod_input_address, mod_matched_bus_address));

		RETURN penalized_companyname + penalized_address;
	END;

EXPORT Batch_Service_records(
					DATASET(DCA_Services.layouts_batch.Batch_in) ds_batch_in_param,
					Doxie.IDataAccess mod_access,
					BOOLEAN no_comp_hier = FALSE) :=	FUNCTION

		UNSIGNED8 MaxResultsPerAcct := 1000 : STORED('max_results_per_acct');

		DCA_Services.layouts_batch.Batch_in capitalize_input(DCA_Services.layouts_batch.Batch_in l, DCA_Services.layouts_batch.Batch_in r) := TRANSFORM
      SELF.seq				 := if(l.seq=0,thorlib.node()+1,l.seq+thorlib.nodes());
			SELF.prim_range  := StringLib.StringToUpperCase(r.prim_range);
			SELF.predir      := StringLib.StringToUpperCase(r.predir);
			SELF.prim_name   := StringLib.StringToUpperCase(r.prim_name);
			SELF.addr_suffix := StringLib.StringToUpperCase(r.addr_suffix);
			SELF.postdir     := StringLib.StringToUpperCase(r.postdir);
			SELF.unit_desig  := StringLib.StringToUpperCase(r.unit_desig);
			SELF.sec_range   := StringLib.StringToUpperCase(r.sec_range);
			SELF.p_city_name := StringLib.StringToUpperCase(r.p_city_name);
			SELF.st          := StringLib.StringToUpperCase(r.st);
			SELF.comp_name   := StringLib.StringToUpperCase(r.comp_name);
			SELF             := r;
		END;

		// 1. Iterate and transform to convert any lower case input to upper case and to add seq #
		ds_batch_in := ITERATE(ds_batch_in_param,capitalize_input(LEFT,RIGHT));

		slim_batch_rec := RECORD
				STRING20  acctno;
				Business_Header_SS.Layout_BDID_InBatch;
		END;

		slim_batch_rec xfm_slim_batch(ds_batch_in in_data) := TRANSFORM
			SELF.company_name := in_data.comp_name;
			SELF.phone10 := (string10)in_data.workphone;
			SELF.z5 := if(in_data.z5 != '',in_data.z5,ziplib.CityToZip5(in_data.st,in_data.p_city_name));
			SELF := in_data;
		END;

		non_bdid_batch := PROJECT(ds_batch_in(bdid = 0),xfm_slim_batch(LEFT));

    // 2. Append bdids to records w/o one
		UNSIGNED6 bdid_score_threshold := 1;
		Business_Header_SS.MAC_BDID_Append(non_bdid_batch,batch_outBdid,bdid_score_threshold)

		bdid_append_results := dedup(sort(batch_outBdid,seq,-score,bdid),seq);

		// Join against batch_in to assign "found" bdids to the batch input records
		bdid_batch_in := JOIN(ds_batch_in,bdid_append_results,
													LEFT.seq = RIGHT.seq,
													TRANSFORM(DCA_Services.layouts_batch.Batch_in,
																		SELF.bdid := IF(RIGHT.bdid != 0,RIGHT.bdid,LEFT.bdid),
																		SELF := LEFT),
													LEFT OUTER);

		// 2. Define values for obtaining autokeys and payloads.
		/* Vern V2
		constants  := DCAV2._Constants();
		SHARED ak_keyname := DCAV2.Keynames().autokeyroot.qa;
		SHARED ak_dataset := dataset([], DCAV2.Layouts.base.autokeybuild);
		SHARED ak_typeStr := DCAV2._constants().ak_typeStr; */

		constants  := DCA.Constants();
		SHARED ak_keyname := constants.ak_qa_keyname;
		SHARED ak_dataset := constants.ak_dataset;
		SHARED ak_typeStr := constants.ak_typeStr;

		// 3. Configure  autokey search.
		/* Vern V2
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			EXPORT workHard        := TRUE;
			EXPORT useAllLookups   := TRUE;
			EXPORT PenaltThreshold := 20;
			EXPORT skip_set        := DCAV2._constants().ak_skipSet;
		END; */

		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			EXPORT workHard        := TRUE;
			EXPORT useAllLookups   := TRUE;
			EXPORT PenaltThreshold := 20;
			EXPORT skip_set        := constants.ak_skipSet;
		END;

		// 4. Get autokey 'fake' ids (fids) based on batch input.
		SHARED ds_fids := Autokey_batch.get_fids(PROJECT(bdid_batch_in,Autokey_batch.Layouts.rec_inBatchMaster), ak_keyname, ak_config_data);

		// 5. Get autokey payloads.
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, SHARED by_Autokey_temp, zero, bdid, ak_typeStr )
		by_Autokey := PROJECT(by_Autokey_temp,TRANSFORM(rec_keybuild_plus_acctno,
																										SELF.lookup_type := 'auto',
																										SELF.name := LEFT.company_name,
																										SELF.phone := LEFT.company_phone,
																										SELF.prim_range := LEFT.bus_addr.prim_range,
																										SELF.predir := LEFT.bus_addr.predir,
																										SELF.prim_name := LEFT.bus_addr.prim_name,
																										SELF.addr_suffix := LEFT.bus_addr.addr_suffix,
																										SELF.postdir := LEFT.bus_addr.postdir,
																										SELF.unit_desig := LEFT.bus_addr.unit_desig,
																										SELF.sec_range := LEFT.bus_addr.sec_range,
																										SELF.p_city_name := LEFT.bus_addr.p_city_name,
																										SELF.v_city_name := LEFT.bus_addr.v_city_name,
																										SELF.st := LEFT.bus_addr.st,
																										SELF.z5 := LEFT.bus_addr.zip5,
																										SELF.zip4 := LEFT.bus_addr.zip4,
																										SELF := LEFT,
																										SELF := []));

		// 6. Search by bdid
		valid_bdid_batch_in := bdid_batch_in(bdid != 0);

		dca_bdid_raw := dx_dca.get_bdid(valid_bdid_batch_in, mod_access, add_contacts:=TRUE);

		by_BDID :=
			JOIN(
				valid_bdid_batch_in,
				dca_bdid_raw,
				LEFT.bdid = RIGHT.bdid,
				TRANSFORM(rec_keybuild_plus_acctno,
					SELF.acctno := LEFT.acctno,
					SELF.lookup_type := 'bdid',
					SELF := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);

		// Dedup to remove identical records
		by_all_temp := DEDUP(SORT(by_Autokey + by_BDID,RECORD,EXCEPT lookup_type),RECORD,EXCEPT lookup_type);
		// Dedup to remove matching bdids (keeping the record from bdid file). The Bdid record will
		// always be "second" or RIGHT based on the sort on lookup_type.
		by_all := DEDUP(SORT(by_all_temp,acctno,bdid,lookup_type),LEFT.acctno = RIGHT.acctno and
																									LEFT.bdid != 0 and
																									LEFT.bdid = RIGHT.bdid,RIGHT);

		// Join condition of RIGHT OUTER (
		by_all_penalized :=
			 JOIN(
				ds_batch_in,
				by_all,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM(rec_keybuild_plus_acctno,
					 SELF.penalty_value := get_penalty_value(LEFT,RIGHT),
					 SELF               := RIGHT
				)
		);

		// Keep only the records less than the allowed penalty and limit the max results per acctno.
		by_all_keep := by_all_penalized(penalty_value <= ak_config_data.PenaltThreshold);

		// Pull out records results that have bdids and retrieve the hierarchy info
		dca_bdids_only := PROJECT(by_all_keep(bdid != 0), TRANSFORM(Layouts.Layout_DCA_in,SELF.bdid := LEFT.bdid));
		// Call function with bdids, with 5 being the how high up the tree (levels of parents) and -2 being how low (num subsidiarys)
		dca_hierarchy_recs := GROUP(DCA_Services.get_DCA_records(dca_bdids_only,5,-2).denorm,passed_bdid);

		/* For the output only 2 levels of subsdiaries are to be kept, and for each level a maximum of 5
		is to be kept. The criteria for determing which 5 to keep is the number of employees
    largest the better and then on percent owned. The logic below will extract the subsdiary
    records from the parent records and then sort and combine the subsdiary records as a child
    of their parent. Finally the subsdiary records will be joined back to all of there parent records. */

		// Transform to sort the sub level 2 records on employee numbers and percent owned
		Layouts.layout_subs_level1 sub2_sort_transform(Layouts.layout_subs_level1 l) := TRANSFORM
				SELF.subs_level2 := SORT(l.subs_level2,
																		IF(emp_num != '',0,1),-(INTEGER) emp_num,
																		IF(percent_owned != '',0,1),-(INTEGER) percent_owned);
				SELF := l;
		END;

		// Transform to sort the sub level 1 records on employee num and percent owned
		Layouts.Layout_DCA_norm sub1_sort_transform(Layouts.Layout_DCA_norm l) := TRANSFORM
				SELF.subs_level1 := SORT(PROJECT(l.subs_level1,sub2_sort_transform(LEFT)),
																IF(emp_num != '',0,1),-(INTEGER) emp_num,
																IF(percent_owned != '',0,1),-(INTEGER) percent_owned);
				SELF := l;
		END;

		// Sort the records on employee number and percent owned
		dca_hierarchy_sorted := PROJECT(dca_hierarchy_recs,sub1_sort_transform(LEFT));

		// Convert to batch output layout
		result_nohier := PROJECT(by_all_keep,TRANSFORM(batch_out_plus,SELF := LEFT,SELF := []));

		// Add hierarchy info
		batch_out_plus Attach_Hier_Info(batch_out_plus l, Layouts.Layout_DCA_norm r) := TRANSFORM
				SELF.company_name_parent_up1 		:= r.parent_up1[1].name;
				SELF.company_city_parent_up1 		:= r.parent_up1[1].city;
				SELF.company_state_parent_up1 	:= r.parent_up1[1].state;
				SELF.company_country_parent_up1 := r.parent_up1[1].country;
				SELF.company_name_parent_up2 		:= r.parent_up2[1].name;
				SELF.company_city_parent_up2 		:= r.parent_up2[1].city;
				SELF.company_state_parent_up2 	:= r.parent_up2[1].state;
				SELF.company_country_parent_up2 := r.parent_up2[1].country;
				SELF.company_name_parent_up3 		:= r.parent_up3[1].name;
				SELF.company_city_parent_up3 		:= r.parent_up3[1].city;
				SELF.company_state_parent_up3 	:= r.parent_up3[1].state;
				SELF.company_country_parent_up3 := r.parent_up3[1].country;
				SELF.company_name_parent_up4 		:= r.parent_up4[1].name;
				SELF.company_city_parent_up4 		:= r.parent_up4[1].city;
				SELF.company_state_parent_up4 	:= r.parent_up4[1].state;
				SELF.company_country_parent_up4 := r.parent_up4[1].country;
				SELF.company_name_parent_up5 		:= r.parent_up5[1].name;
				SELF.company_city_parent_up5 		:= r.parent_up5[1].city;
				SELF.company_state_parent_up5 	:= r.parent_up5[1].state;
				SELF.company_country_parent_up5 := r.parent_up5[1].country;
				SELF.company_name_sub_1 				:= r.subs_level1[1].name;
				SELF.company_city_sub_1 				:= r.subs_level1[1].city;
				SELF.company_state_sub_1 				:= r.subs_level1[1].state;
				SELF.company_country_sub_1 			:= r.subs_level1[1].country;
				SELF.company_name_sub_1_1 			:= r.subs_level1[1].subs_level2[1].name;
				SELF.company_city_sub_1_1 			:= r.subs_level1[1].subs_level2[1].city;
				SELF.company_state_sub_1_1 			:= r.subs_level1[1].subs_level2[1].state;
				SELF.company_country_sub_1_1 		:= r.subs_level1[1].subs_level2[1].country;
				SELF.company_name_sub_1_2 			:= r.subs_level1[1].subs_level2[2].name;
				SELF.company_city_sub_1_2 			:= r.subs_level1[1].subs_level2[2].city;
				SELF.company_state_sub_1_2 			:= r.subs_level1[1].subs_level2[2].state;
				SELF.company_country_sub_1_2 		:= r.subs_level1[1].subs_level2[2].country;
				SELF.company_name_sub_1_3 			:= r.subs_level1[1].subs_level2[3].name;
				SELF.company_city_sub_1_3 			:= r.subs_level1[1].subs_level2[3].city;
				SELF.company_state_sub_1_3 			:= r.subs_level1[1].subs_level2[3].state;
				SELF.company_country_sub_1_3 		:= r.subs_level1[1].subs_level2[3].country;
				SELF.company_name_sub_1_4 			:= r.subs_level1[1].subs_level2[4].name;
				SELF.company_city_sub_1_4 			:= r.subs_level1[1].subs_level2[4].city;
				SELF.company_state_sub_1_4 			:= r.subs_level1[1].subs_level2[4].state;
				SELF.company_country_sub_1_4 		:= r.subs_level1[1].subs_level2[4].country;
				SELF.company_name_sub_1_5 			:= r.subs_level1[1].subs_level2[5].name;
				SELF.company_city_sub_1_5 			:= r.subs_level1[1].subs_level2[5].city;
				SELF.company_state_sub_1_5 			:= r.subs_level1[1].subs_level2[5].state;
				SELF.company_country_sub_1_5 		:= r.subs_level1[1].subs_level2[5].country;
				SELF.company_name_sub_2 				:= r.subs_level1[2].name;
				SELF.company_city_sub_2 				:= r.subs_level1[2].city;
				SELF.company_state_sub_2 				:= r.subs_level1[2].state;
				SELF.company_country_sub_2 			:= r.subs_level1[2].country;
				SELF.company_name_sub_2_1 			:= r.subs_level1[2].subs_level2[1].name;
				SELF.company_city_sub_2_1 			:= r.subs_level1[2].subs_level2[1].city;
				SELF.company_state_sub_2_1 			:= r.subs_level1[2].subs_level2[1].state;
				SELF.company_country_sub_2_1 		:= r.subs_level1[2].subs_level2[1].country;
				SELF.company_name_sub_2_2 			:= r.subs_level1[2].subs_level2[2].name;
				SELF.company_city_sub_2_2 			:= r.subs_level1[2].subs_level2[2].city;
				SELF.company_state_sub_2_2 			:= r.subs_level1[2].subs_level2[2].state;
				SELF.company_country_sub_2_2 		:= r.subs_level1[2].subs_level2[2].country;
				SELF.company_name_sub_2_3 			:= r.subs_level1[2].subs_level2[3].name;
				SELF.company_city_sub_2_3 			:= r.subs_level1[2].subs_level2[3].city;
				SELF.company_state_sub_2_3 			:= r.subs_level1[2].subs_level2[3].state;
				SELF.company_country_sub_2_3 		:= r.subs_level1[2].subs_level2[3].country;
				SELF.company_name_sub_2_4 			:= r.subs_level1[2].subs_level2[4].name;
				SELF.company_city_sub_2_4 			:= r.subs_level1[2].subs_level2[4].city;
				SELF.company_state_sub_2_4 			:= r.subs_level1[2].subs_level2[4].state;
				SELF.company_country_sub_2_4 		:= r.subs_level1[2].subs_level2[4].country;
				SELF.company_name_sub_2_5 			:= r.subs_level1[2].subs_level2[5].name;
				SELF.company_city_sub_2_5 			:= r.subs_level1[2].subs_level2[5].city;
				SELF.company_state_sub_2_5 			:= r.subs_level1[2].subs_level2[5].state;
				SELF.company_country_sub_2_5 		:= r.subs_level1[2].subs_level2[5].country;
				SELF.company_name_sub_3 				:= r.subs_level1[3].name;
				SELF.company_city_sub_3 				:= r.subs_level1[3].city;
				SELF.company_state_sub_3 				:= r.subs_level1[3].state;
				SELF.company_country_sub_3 			:= r.subs_level1[3].country;
				SELF.company_name_sub_3_1 			:= r.subs_level1[3].subs_level2[1].name;
				SELF.company_city_sub_3_1 			:= r.subs_level1[3].subs_level2[1].city;
				SELF.company_state_sub_3_1 			:= r.subs_level1[3].subs_level2[1].state;
				SELF.company_country_sub_3_1 		:= r.subs_level1[3].subs_level2[1].country;
				SELF.company_name_sub_3_2 			:= r.subs_level1[3].subs_level2[2].name;
				SELF.company_city_sub_3_2 			:= r.subs_level1[3].subs_level2[2].city;
				SELF.company_state_sub_3_2 			:= r.subs_level1[3].subs_level2[2].state;
				SELF.company_country_sub_3_2 		:= r.subs_level1[3].subs_level2[2].country;
				SELF.company_name_sub_3_3 			:= r.subs_level1[3].subs_level2[3].name;
				SELF.company_city_sub_3_3 			:= r.subs_level1[3].subs_level2[3].city;
				SELF.company_state_sub_3_3 			:= r.subs_level1[3].subs_level2[3].state;
				SELF.company_country_sub_3_3 		:= r.subs_level1[3].subs_level2[3].country;
				SELF.company_name_sub_3_4 			:= r.subs_level1[3].subs_level2[4].name;
				SELF.company_city_sub_3_4 			:= r.subs_level1[3].subs_level2[4].city;
				SELF.company_state_sub_3_4 			:= r.subs_level1[3].subs_level2[4].state;
				SELF.company_country_sub_3_4 		:= r.subs_level1[3].subs_level2[4].country;
				SELF.company_name_sub_3_5 			:= r.subs_level1[3].subs_level2[5].name;
				SELF.company_city_sub_3_5 			:= r.subs_level1[3].subs_level2[5].city;
				SELF.company_state_sub_3_5 			:= r.subs_level1[3].subs_level2[5].state;
				SELF.company_country_sub_3_5 		:= r.subs_level1[3].subs_level2[5].country;
				SELF.company_name_sub_4 				:= r.subs_level1[4].name;
				SELF.company_city_sub_4 				:= r.subs_level1[4].city;
				SELF.company_state_sub_4 				:= r.subs_level1[4].state;
				SELF.company_country_sub_4 			:= r.subs_level1[4].country;
				SELF.company_name_sub_4_1 			:= r.subs_level1[4].subs_level2[1].name;
				SELF.company_city_sub_4_1 			:= r.subs_level1[4].subs_level2[1].city;
				SELF.company_state_sub_4_1 			:= r.subs_level1[4].subs_level2[1].state;
				SELF.company_country_sub_4_1 		:= r.subs_level1[4].subs_level2[1].country;
				SELF.company_name_sub_4_2 			:= r.subs_level1[4].subs_level2[2].name;
				SELF.company_city_sub_4_2 			:= r.subs_level1[4].subs_level2[2].city;
				SELF.company_state_sub_4_2 			:= r.subs_level1[4].subs_level2[2].state;
				SELF.company_country_sub_4_2 		:= r.subs_level1[4].subs_level2[2].country;
				SELF.company_name_sub_4_3 			:= r.subs_level1[4].subs_level2[3].name;
				SELF.company_city_sub_4_3 			:= r.subs_level1[4].subs_level2[3].city;
				SELF.company_state_sub_4_3 			:= r.subs_level1[4].subs_level2[3].state;
				SELF.company_country_sub_4_3 		:= r.subs_level1[4].subs_level2[3].country;
				SELF.company_name_sub_4_4 			:= r.subs_level1[4].subs_level2[4].name;
				SELF.company_city_sub_4_4 			:= r.subs_level1[4].subs_level2[4].city;
				SELF.company_state_sub_4_4 			:= r.subs_level1[4].subs_level2[4].state;
				SELF.company_country_sub_4_4 		:= r.subs_level1[4].subs_level2[4].country;
				SELF.company_name_sub_4_5 			:= r.subs_level1[4].subs_level2[5].name;
				SELF.company_city_sub_4_5 			:= r.subs_level1[4].subs_level2[5].city;
				SELF.company_state_sub_4_5 			:= r.subs_level1[4].subs_level2[5].state;
				SELF.company_country_sub_4_5 		:= r.subs_level1[4].subs_level2[5].country;
				SELF.company_name_sub_5 				:= r.subs_level1[5].name;
				SELF.company_city_sub_5 				:= r.subs_level1[5].city;
				SELF.company_state_sub_5 				:= r.subs_level1[5].state;
				SELF.company_country_sub_5 			:= r.subs_level1[5].country;
				SELF.company_name_sub_5_1 			:= r.subs_level1[5].subs_level2[1].name;
				SELF.company_city_sub_5_1 			:= r.subs_level1[5].subs_level2[1].city;
				SELF.company_state_sub_5_1 			:= r.subs_level1[5].subs_level2[1].state;
				SELF.company_country_sub_5_1 		:= r.subs_level1[5].subs_level2[1].country;
				SELF.company_name_sub_5_2 			:= r.subs_level1[5].subs_level2[2].name;
				SELF.company_city_sub_5_2 			:= r.subs_level1[5].subs_level2[2].city;
				SELF.company_state_sub_5_2 			:= r.subs_level1[5].subs_level2[2].state;
				SELF.company_country_sub_5_2 		:= r.subs_level1[5].subs_level2[2].country;
				SELF.company_name_sub_5_3 			:= r.subs_level1[5].subs_level2[3].name;
				SELF.company_city_sub_5_3 			:= r.subs_level1[5].subs_level2[3].city;
				SELF.company_state_sub_5_3 			:= r.subs_level1[5].subs_level2[3].state;
				SELF.company_country_sub_5_3 		:= r.subs_level1[5].subs_level2[3].country;
				SELF.company_name_sub_5_4 			:= r.subs_level1[5].subs_level2[4].name;
				SELF.company_city_sub_5_4 			:= r.subs_level1[5].subs_level2[4].city;
				SELF.company_state_sub_5_4 			:= r.subs_level1[5].subs_level2[4].state;
				SELF.company_country_sub_5_4 		:= r.subs_level1[5].subs_level2[4].country;
				SELF.company_name_sub_5_5 			:= r.subs_level1[5].subs_level2[5].name;
				SELF.company_city_sub_5_5 			:= r.subs_level1[5].subs_level2[5].city;
				SELF.company_state_sub_5_5 			:= r.subs_level1[5].subs_level2[5].state;
				SELF.company_country_sub_5_5 		:= r.subs_level1[5].subs_level2[5].country;
				SELF := l;
				SELF := [];
		END;

		result_hier := JOIN(result_nohier,dca_hierarchy_sorted,
												LEFT.bdid = RIGHT.bdid,
												Attach_Hier_Info(LEFT,RIGHT),
												LEFT OUTER);

		result_temp := IF(no_comp_hier,result_nohier,result_hier);

		// Sort on acctno and penalty, project into final layout and dedup and limit by max results per acct
		results := DEDUP(PROJECT(SORT(result_temp, acctno, penalty_value),
											TRANSFORM(layouts_batch.Batch_out,SELF := LEFT)),
									acctno, KEEP MaxResultsPerAcct);

		RETURN(results);
END;
