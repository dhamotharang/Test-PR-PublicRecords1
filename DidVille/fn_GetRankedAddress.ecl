IMPORT doxie, Address, Address_Rank, Didville, Patriot;

EXPORT fn_GetRankedAddress(DATASET(DidVille.Layout_Did_OutBatch) batch_in,
													 doxie.IDataAccess in_mod) := FUNCTION

	address_batch_params := MODULE(PROJECT(in_mod, Address_Rank.IParams.BatchParams, OPT))
			EXPORT BOOLEAN IncludeShortTermRental := FALSE;
			EXPORT BOOLEAN getDids							  := FALSE;
	END;
	
	batch_in_comb := RECORD
		UNSIGNED seq;
		UNSIGNED2 score := 0;
		UNSIGNED6 hhid := 0;
		STRING5 name_title;
		Address_Rank.Layouts.Batch_in;
		didville.layout_best_append;
		patriot.Layout_PatriotAppend;
		didville.layout_lookups;
		didville.layout_livingsits;
	END;
	
	ds_batch_in_comb := PROJECT(batch_in, 
													TRANSFORM(batch_in_comb, 
														  SELF.name_title := LEFT.title,
															SELF.name_first := LEFT.fname,
															SELF.name_middle := LEFT.mname,
															SELF.name_last := LEFT.lname,
															SELF.name_suffix := LEFT.suffix,
															SELF.phone := LEFT.phone10,
															SELF := LEFT, 
															SELF := []));

	processed_input := Address_Rank.fn_processInput(ds_batch_in_comb, , TRUE);

	ds_addresses_in := PROJECT(processed_input(error_code = 0), 
												TRANSFORM(Address_Rank.Layouts.Batch_in, 
															SELF := LEFT));
						
	ds_addresses_out := Address_Rank.Records(ds_addresses_in, address_batch_params);
	
	batch_in xform_w_address(batch_in_comb le, ds_addresses_out ri) := TRANSFORM
		SELF.did := le.did;
		SELF.best_addr1 := Address.Addr1FromComponents(ri.BA_prim_range, ri.BA_predir, ri.BA_prim_name, 
																									 ri.BA_addr_suffix, ri.BA_postdir, ri.BA_unit_desig, 
																									 ri.BA_sec_range);
		SELF.best_city := ri.BA_p_city_name;
		SELF.best_state := ri.BA_st;
		SELF.best_zip := ri.BA_z5;
		SELF.best_zip4 := ri.BA_zip4;
		SELF.best_addr_date := (UNSIGNED)ri.ba_dt_last_seen;
    SELF.location_id := ri.location_id;
		
		SELF.phone10 := le.phone;
		SELF.title := le.name_title;
		SELF.fname := le.name_first;
		SELF.mname := le.name_middle;
		SELF.lname := le.name_last;
		SELF.suffix := le.name_suffix;
		SELF := le;
	END;
												
	ds_addr_ranked := JOIN(processed_input, ds_addresses_out,
												LEFT.acctno = RIGHT.acctno,
														//FULL OUTER so address will be blanked out 
														//if no govt best addr was returned.
														xform_w_address(LEFT, RIGHT), FULL OUTER);	

	RETURN ds_addr_ranked;

END;
