import Gateway;
EXPORT Boca_Shell_Function_AML (GROUPED DATASET (Layout_output) iid1,
                            DATASET (Gateway.Layouts.Config) gateways,
                            unsigned1 dppa, unsigned1 glb, boolean isUtility=false, boolean isLN=false,

                            // optimization options
                            boolean includeRelativeInfo=true, boolean includeDLInfo=true,
                            boolean includeVehInfo=true, boolean includeDerogInfo=true, unsigned1 BSversion=1,
														boolean doScore=false, boolean nugen = false, boolean filter_out_fares = false,
														string50 DataRestriction=iid_constants.default_DataRestriction,
														unsigned8 BSOptions = 0,
														string50 DataPermission=iid_constants.default_DataPermission) :=  
FUNCTION


// for batch queries, dedup the input to reduce searching
iid_deduped := dedup(sort(ungroup(iid1), 
	historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did, seq),
	historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did);

seq_map := join( iid1, iid_deduped,
	left.historydate=right.historydate
		and left.fname=right.fname
		and left.mname=right.mname
		and left.lname=right.lname
		and left.suffix=right.suffix
		and left.ssn=right.ssn
		and left.dob=right.dob
		and left.phone10=right.phone10
		and left.wphone10=right.wphone10
		and left.in_streetAddress=right.in_streetAddress
		and left.in_city=right.in_city
		and left.in_state=right.in_state
		and left.in_zipcode=right.in_zipcode
		and left.dl_number=right.dl_number
		and left.dl_state=right.dl_state
		and left.email_address=right.email_address
		and left.did=right.did,
	transform( {unsigned input_seq, unsigned deduped_seq}, self.input_seq := left.seq, self.deduped_seq := right.seq ), keep(1) );
  
iid := group(iid_deduped, seq);
	
  ids_wide := boca_shell_FCRA_Neutral_Function_AML (iid, dppa, glb,  
                                                isUtility, isLN, includeRelativeInfo, false, BSversion, nugen := nugen, DataRestriction:=DataRestriction, BSOptions := BSOptions);
 	
  p := dedup(group(sort(project(ids_wide(~isrelat), transform (Layout_Boca_Shell, self := LEFT)), seq), seq), seq);

  dppa_ok := dppa > 0 and dppa < 8;
  per_prop := getAllBocaShellData_AML (iid, ids_wide, p,
                                   FALSE, isLN, dppa, dppa_ok,
                                   includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo, BSversion,
																	 false, doScore, filter_out_fares,
																	 DataRestriction, BSOptions, glb, DataPermission);

	shell_results := per_prop;

// join the results back to the original input so that every record on input has a response populated
full_response := join( seq_map, shell_results, left.deduped_seq=right.seq, transform( Layout_Boca_Shell, self.seq := left.input_seq, self.shell_input.seq := left.input_seq, self := right ), keep(1) );
return group(full_response, seq);
  
END;
