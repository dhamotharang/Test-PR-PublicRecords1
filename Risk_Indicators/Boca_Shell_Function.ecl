import _control, Gateway, risk_indicators;

USE_BOCA_SHELL_LIBRARY := not _Control.LibraryUse.ForceOff_Risk_Indicators__LIB_Boca_Shell_Function;
OnThor := _control.Environment.OnThor;


EXPORT Boca_Shell_Function (GROUPED DATASET (risk_indicators.Layout_output) iid1,
                            DATASET (Gateway.Layouts.Config) gateways,
                            unsigned1 dppa, unsigned1 glb, boolean isUtility=false, boolean isLN=false,

                            // optimization options
                            boolean includeRelativeInfo=true, boolean includeDLInfo=true,
                            boolean includeVehInfo=true, boolean includeDerogInfo=true, unsigned1 BSversion=1,
								boolean doScore=false, boolean nugen = false, boolean filter_out_fares = false,
								string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
								unsigned8 BSOptions = 0,
								string50 DataPermission=risk_indicators.iid_constants.default_DataPermission, 
                            unsigned1 LexIdSourceOptout = 1,
                            string TransactionID = '',
                            string BatchUID = '',
                            unsigned6 GlobalCompanyId = 0) :=  
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
	transform( {unsigned input_seq, unsigned deduped_seq}, self.input_seq := left.seq, self.deduped_seq := right.seq ), keep(1), ALL);

iid_distr := distribute(iid1, hash64(seq));
iid_deduped_thor := dedup(sort(ungroup(iid_distr), 
	historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did, seq, local),
	historydate, fname, mname, lname, suffix, ssn, dob, phone10, wphone10, in_streetAddress, in_city, in_state, in_zipcode, dl_number, dl_state, email_address, did, local);

seq_map_thor := join( iid_distr, iid_deduped_thor,
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
	transform( {unsigned input_seq, unsigned deduped_seq}, self.input_seq := left.seq, self.deduped_seq := right.seq ), keep(1), ALL, local);

#if(OnThor)
    iid := group(iid_deduped_thor, seq);
#else
    iid := group(iid_deduped, seq);
#end

	
#if(USE_BOCA_SHELL_LIBRARY)
	args := MODULE(risk_indicators.BS_LIBIN)
			export unsigned1 bs_dppa     := dppa;
			export unsigned1 bs_glb      := glb;
			export boolean bs_isUtility  := isUtility;
			export boolean bs_isLN       := isLN;

			// optimization options
			export boolean bs_includeRelativeInfo := includeRelativeInfo;
			export boolean bs_includeDLInfo       := includeDLInfo;
			export boolean bs_includeVehInfo      := includeVehInfo;
			export boolean bs_includeDerogInfo    := includeDerogInfo;
			export unsigned1 bs_BSversion         := BSversion;
			export boolean bs_doScore             := doScore;
			export boolean bs_nugen               := nugen;
			export boolean bs_filter_out_fares    := filter_out_fares;
			export string50 bs_DataRestriction    := DataRestriction;
			export unsigned8 bs_BSOptions         := BSOptions;
			export string50 bs_DataPermission    	:= DataPermission;
			export unsigned1 bs_LexIdSourceOptout := LexIdSourceOptout;
			export string16 bs_TransactionID := (string16)TransactionID;
			export string16 bs_BatchUID := (string16)BatchUID;
			export unsigned6 bs_GlobalCompanyId := GlobalCompanyId;
	END;

	shell_results := library('Risk_Indicators.LIB_Boca_Shell_Function', risk_indicators.IBoca_Shell_Function(iid, gateways, args)).results;

#else
  ids_wide := boca_shell_FCRA_Neutral_Function (iid, dppa, glb,  
                                                isUtility, isLN, includeRelativeInfo, false, BSversion, nugen := nugen, 
																								DataRestriction:=DataRestriction, BSOptions := BSOptions);
 	
#if(OnThor)
  p := dedup(group(sort(project(distribute(ids_wide(~isrelat), hash64(seq)), transform (risk_indicators.Layout_Boca_Shell, self := LEFT)), seq, local), seq, LOCAL), seq);
#else
  p := dedup(group(sort(project(ids_wide(~isrelat), transform (risk_indicators.Layout_Boca_Shell, self := LEFT)), seq), seq), seq);    
#end
  
  dppa_ok := dppa > 0 and dppa < 8;
  per_prop := getAllBocaShellData (iid, ids_wide, p,
                                   FALSE, isLN, dppa, dppa_ok,
                                   includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo, BSversion,
																	 false, doScore, filter_out_fares,
																	 DataRestriction, BSOptions, glb, gateways, DataPermission,
                                   LexIdSourceOptout := LexIdSourceOptout, 
                                   TransactionID := TransactionID, 
                                   BatchUID := BatchUID, 
                                   GlobalCompanyID := GlobalCompanyID);

	shell_results := per_prop;
#end

// join the results back to the original input so that every record on input has a response populated
#if(OnThor)
  full_response := join( distribute(seq_map_thor, hash64(deduped_seq)), 
                         distribute(shell_results, hash64(seq)), 
                         left.deduped_seq=right.seq, transform( risk_indicators.Layout_Boca_Shell, self.seq := left.input_seq, self.shell_input.seq := left.input_seq, self := right ), keep(1), local );
#else
  full_response := join( seq_map, shell_results, left.deduped_seq=right.seq, transform( risk_indicators.Layout_Boca_Shell, self.seq := left.input_seq, self.shell_input.seq := left.input_seq, self := right ), keep(1) );
#end

return group(full_response, seq);
  
END;
