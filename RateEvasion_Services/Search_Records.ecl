import Address,AutoStandardI,Didville,doxie,iesp,ut,suppress;

export Search_Records := module
	export params := interface(RateEvasion_Services.Functions.params)
	end;

	export val(params in_mod) := function
 
		// Put input fields in a layout to be used by DidVille.MAC_DidAppend
		in_fname	     := AutoStandardI.InterfaceTranslator.fname_value.val(in_mod);
		in_mname	     := AutoStandardI.InterfaceTranslator.mname_value.val(in_mod);
		in_lname	     := AutoStandardI.InterfaceTranslator.lname_value.val(in_mod);
		in_name_suffix := AutoStandardI.InterfaceTranslator.name_suffix_val.val(in_mod);
		in_prim_range	 := AutoStandardI.InterfaceTranslator.prange_value.val(in_mod);
		in_predir      := AutoStandardI.InterfaceTranslator.predir_value.val(in_mod);
		in_prim_name	 := AutoStandardI.InterfaceTranslator.pname_value.val(in_mod);
		in_addr_suffix := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(in_mod);
		in_postdir     :=	AutoStandardI.InterfaceTranslator.postdir_value.val(in_mod);
		in_sec_range   :=	AutoStandardI.InterfaceTranslator.sec_range_value.val(in_mod);
		in_city	       := AutoStandardI.InterfaceTranslator.city_value.val(in_mod);
		in_state	     := AutoStandardI.InterfaceTranslator.state_value.val(in_mod);
		in_zip         := AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(in_mod);
		in_ssn         := AutoStandardI.InterfaceTranslator.ssn_value.val(in_mod);
		in_dob         := AutoStandardI.InterfaceTranslator.dob_val.val(in_mod);
		in_phone10     := AutoStandardI.InterfaceTranslator.phone_value.val(in_mod);
		
		input_data_layout := record
      unsigned4 seq;
      qSTRING9  ssn;
	    qSTRING8  dob;
	    qstring10 phone10;
			qSTRING5  title;
	    qSTRING20 fname;
	    qSTRING20 mname;
	    qSTRING20 lname;
	    qSTRING5  suffix;
	    qSTRING10 prim_range;
	    qSTRING2  predir;
	    qSTRING28 prim_name;
	    qSTRING4  addr_suffix;
	    qSTRING2  postdir;
	    qSTRING10 unit_desig;
	    qSTRING8  sec_range;
	    qSTRING25 p_city_name;
	    qSTRING2  st;
	    qSTRING5  z5;
      qSTRING4  zip4;
    end;

    ds_input_data := dataset([{0,in_ssn,in_dob,in_phone10,
		                           '',in_fname,in_mname,in_lname,in_name_suffix,
															 in_prim_range,in_predir,in_prim_name,in_addr_suffix,
															 in_postdir,'',in_sec_range,in_city,in_state,in_zip,''}
		                         ], input_data_layout);	
		
		macroInput := PROJECT(ds_input_data, DidVille.Layout_Did_OutBatch);
	  DidVille.MAC_DidAppend(macroInput, macroOutput, TRUE, '4NGZ');

    target_did := macroOutput[1].did;
    
		ds_did_for_input := ungroup(PROJECT(macroOutput, doxie.layout_references_hh));

		recs_for_did1 := doxie.header_records_byDID(ds_did_for_input, true, true);

		// Filter the returned header recs to just keep the records for the target did.
		recs_for_did := recs_for_did1(did=target_did);

		// ***** DID & SSN pulling ****
		Suppress.MAC_Suppress(recs_for_did,dids_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did);
		Suppress.MAC_Suppress(dids_pulled,ssns_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.SSN,ssn);
		doxie.MAC_PruneOldSSNs(ssns_pulled, recs_pulled, ssn, did);

 		// Call Functions to format records for searchservice XML output
		added_functions_in_mod := project(in_mod, functions.params);
		recs_fmtd := RateEvasion_Services.Functions.fnSearchVal(recs_pulled,
																						 			          added_functions_in_mod); 

    // Project onto appropriate Rate Evasion Search Response record layout limiting the 
		// returned output records to the current max value of 1 record. 
    recs_proj := project(choosen(recs_fmtd,
		                             iesp.Constants.RATEEVA_MAX_COUNT_SEARCH_RESPONSE_RECORDS),
		                     iesp.rateevasion.t_RateEvasionSearchResponse);
		
    //Uncomment lines below as needed to assist in debugging
		//output(ds_input_data, named('sr_recs_ds_input_data'));	
    //output(macroOutput, named('sr_recs_macroOutput'));
		//output(target_did, named('sr_target_did'));
		//output(ds_did_for_input, named('sr_recs_ds_did_for_input'));
		//output(recs_for_did1, named('sr_recs_for_did1'));
		//output(recs_for_did, named('sr_recs_for_did'));	
		//output(dids_pulled,named('sr_dids_pulled'));
		//output(ssns_pulled,named('sr_ssns_pulled'));
		//output(recs_pulled,named('sr_recs_pulled'));
		//output(recs_fmtd, named('sr_recs_fmt'));
		//output(recs_proj, named('sr_recs_proj'));
		
		return recs_proj;
		
  end;
 
end;
