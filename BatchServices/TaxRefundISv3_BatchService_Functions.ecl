IMPORT AddrBest, Address, Address_Attributes, Autokey_batch, AutoStandardI, batchservices, BatchShare, 
			 CriminalRecords_BatchService, Didville, Models, Gateway, NID, progressive_phone,Std, tris_lnssi_build;

EXPORT TaxRefundISv3_BatchService_Functions := MODULE

	EXPORT ProcessHRICodes(BatchServices.TaxRefundISv3_BatchService_Interfaces.Input mod_args) := FUNCTION 
		//
		// Instantiate the normal defaults ONLY when NO arguments are specified on any of the parameters.
		// Note that these strings are supposed to be strings of HRI_Codes separated by commas.
		//
		aRisk := Std.Str.ToUppercase(TRIM(mod_args.AddressRiskHRICodes, ALL));
		iRisk := Std.Str.ToUppercase(TRIM(mod_args.IdentityRiskHRICodes, ALL));
		rOnly := Std.Str.ToUppercase(TRIM(mod_args.ReportOnlyHRICodes, ALL));
		boolean allFieldsBlank := aRisk='' AND iRisk='' AND rOnly='';
		
		// TRIS v3.2 Enhancement : Updated HRI codes per Req # 3.1.3.8
		aRisk2 := IF(allFieldsBlank, '11,14', aRisk);
		iRisk2 := IF(allFieldsBlank, '03,72,IS,QD,QA,QE,BO,S5,S2,S1',iRisk);
		rOnly2 := IF(allFieldsBlank, '71,RS,MO', rOnly);
		
		finalResults := MODULE(PROJECT(mod_args, BatchServices.TaxRefundISv3_BatchService_Interfaces.Input))
			EXPORT string AddressRiskHRICodes  := aRisk2;
			EXPORT string IdentityRiskHRICodes := iRisk2;
			EXPORT string ReportOnlyHRICodes   := rOnly2;
			EXPORT string AllHRICodes := aRisk2 + ',' + iRisk2 + ',' + rOnly2;
		END;
		
		RETURN finalResults;
	END;

  shared rec_extra_address_info := record
    string10 lat := '';
    string11 long := '';
    string3  county := '';
    string7  geo_blk := '';
    string1  addr_type := '';
    string4  addr_status := '';
  end;
	
	shared rec_in_batch := record
    Autokey_batch.Layouts.rec_inBatchMaster;
    rec_extra_address_info;
    BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.county_name;
    BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.refund_amount;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.ip_address;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.aba_rout_nbr;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.txpy_bank_acct_nbr;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.routing_transit_nbr;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.depositor_account_num;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.device_ini_ip_address;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.device_submit_ip_address;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.email_address;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.prep_id2;
		BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in.filer_type;
		boolean is_rejected_rec;
	end;

  // layout name aliases to use in multiple functions
  shared rec_in  			:= BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in;
  shared rec_in_wdid 	:= BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in_wdid;
	shared rec_final    := BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_out;
  
	// *--- Function to clean batch input ---* //
	EXPORT fnc_clean_batch(dataset(rec_in) ds_batch_in) := FUNCTION
    rec_in_batch tf_clean_batch_in(rec_in l, integer C) := TRANSFORM
				// --- ADDRESS INFORMATION
				addr1			 				:= Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
		                                     l.addr_suffix, l.postdir, 
																				 l.unit_desig, l.sec_range);
				addr2 						:= Address.Addr2FromComponents(l.p_city_name, l.st, l.z5);
				addr1_final 			:= if (addr1 = '', l.address, addr1);
				clean_addr 				:= address.GetCleanAddress(addr1_final,addr2,address.Components.country.US);
				ca								:= clean_addr.results;

				self.prim_range 	:= ca.prim_range;
				self.prim_name 		:= ca.prim_name;
				self.sec_range 		:= ca.sec_range;
				self.addr_suffix 	:= ca.suffix;
				self.predir 			:= ca.predir;
				self.postdir 			:= ca.postdir;
				self.unit_desig 	:= ca.unit_desig;
				self.p_city_name 	:= ca.p_city;
				self.z5						:= ca.zip;
				self.zip4					:= ca.zip4;
				self.st						:= ca.state;
        self.county       := ca.county;
        self.geo_blk      := ca.geo_blk;
        self.lat          := ca.latitude;
        self.long         := ca.longitude;
        self.addr_type    := ca.address_type;
        self.addr_status  := ca.error_msg;
        self.seq          := C;
				self.acctno 			:= L.acctno;
				ssn_filtered      := Stringlib.StringFilterOut(l.ssn, '0');
				self.ssn					:= if(ssn_filtered <> '', 
				                        stringlib.stringfilter(l.ssn,'0123456789'), '');

				self.name_first := Stringlib.StringFilter(Stringlib.StringToUpperCase(L.name_first), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ -\'');
				self.name_middle := Stringlib.StringFilter(Stringlib.StringToUpperCase(L.name_middle), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ -\'');
				self.name_last := Stringlib.StringFilter(Stringlib.StringToUpperCase(L.name_last), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ -\'');
				self 							:= l;
				self 							:= [];
			END;
					
			ds_batch_clean := project(ds_batch_in, tf_clean_batch_in(LEFT, COUNTER));
			
			RETURN ds_batch_clean;
	END; 


	// *--- Transform to check for missing/invalid input---* //
	EXPORT rec_in_batch xfm_in_marked(rec_in_batch le) := 
	  TRANSFORM
				  has_full_name := le.name_last != '' AND (le.name_first != '' OR le.name_middle != '');
					has_cityst_or_zip := (le.p_city_name != '' AND le.st != '') OR le.z5 != '';
					//bug 172344 remove requirement for both streetname and streetnumber, and just check for either one to exist on input after cleaning.
					has_full_address := (le.prim_range != '' OR le.prim_name != '') and has_cityst_or_zip;												
					has_SSN := LENGTH(TRIM(le.ssn))=9;    
					has_suff_input := has_full_name AND has_full_address AND has_SSN;
					is_rejected_rec := NOT has_suff_input;					
					SELF.is_rejected_rec := is_rejected_rec;
					SELF := le;
					SELF := [];
		END;


	// *--- Function to get DID & Best info from ADL Best --> didville.did_service_common_function ---* //
	export getAdlBestInfo(dataset(rec_in_batch) in_clean_batch,
				 BatchServices.TaxRefundISv3_BatchService_Interfaces.Input args_in) := function

			p := module(AutoStandardI.PermissionI_Tools.params)
				export boolean AllowAll := false;
				export boolean AllowGLB := false;
				export boolean AllowDPPA := false;
				export unsigned1 DPPAPurpose := args_in.DPPAPurpose;
				export unsigned1 GLBPurpose := args_in.GLBPurpose;
				export boolean IncludeMinors := false;
			END;
			GLB := AutoStandardI.PermissionI_Tools.val(p).glb.ok(args_in.GLBPurpose);
			hhidplus := stringlib.stringfind(args_in.append_l,'HHID_PLUS',1)<>0;
      edabest := stringlib.stringfind(args_in.append_l,'BEST_EDA',1)<>0;

			DidVille.Layout_Did_OutBatch into(rec_in_batch l) := transform
				 self.seq := l.seq;
				 self.phone10 := '';
				 self.title := '';
				 self.fname := l.name_first;
				 self.mname := l.name_middle;
				 self.lname := l.name_last;
				 self.suffix := l.name_suffix;
				 self.ssn := stringlib.stringfilter(l.ssn,'0123456789');
				 self.did := (unsigned)l.did;
				 self := l;
			end;

			recs := project(in_clean_batch,into(left));

      AdlBestInfo_res
                 := didville.did_service_common_function(recs,
																												 appends_value      := args_in.append_l,
																												 verify_value       := args_in.verify_l,
																												 glb_flag           := GLB,
																												 hhidplus_value     := hhidplus,
																												 edabest_value      := edabest,
																												 glb_purpose_value  := args_in.GLBPurpose,
																												 appType            := args_in.ApplicationType,
																												 include_minors     := args_in.IncludeMinors,
																												 dppa_purpose_value := args_in.DPPAPurpose,
																												 IndustryClass_val  := args_in.IndustryClass,
																												 DRM_val            := args_in.DataRestriction,
																												 GetSSNBest         := args_in.GetSSNBest);

      // *--- DEBUG ---* //
      // output(AdlBestInfo_res, named('AdlBestInfo_res'));
      return AdlBestInfo_res; //???
	end;

	
	// *--- Function to get Best Address & Address history (batch) records ---* //
	export getBestAddress(dataset(rec_in_wdid) in_clean_batch,
												BatchServices.TaxRefundISv3_BatchService_Interfaces.Input args_in) := function
												
			AddrBest.Layout_BestAddr.Batch_in makeAddrBestBatch(rec_in_wdid L) := transform
        self.suffix := L.addr_suffix;
				self := L;
				self := [];
			end;
			
			addrBest_batch := project(in_clean_batch, makeAddrBestBatch(left));
			    
			addrBest_mod := module(AddrBest.Iparams.SearchParams) 
				export ReturnLatLong        				:= TRUE; // added for 2015 enhancements
				export HistoricMatchCodes   				:= TRUE;
				export ReturnConfidenceFlag 				:= TRUE;
				export MaxRecordsToReturn						:= 20;
				export IncludeBlankDateLastSeen 		:= TRUE;
				export IncludeRanking								:= FALSE; //automatically applied to GOV applications to always get best ranked addr
																											//TRISv3.2 Enhancement : As per requirement, GBA should not be used for both 3.1 and 3.2 versions. Switching it back to Traditional Best.
				export isV2Score										:= TRUE;  //RQ-13614: Switching to use V2 scores as defined in "AddrBest.BestAddr_common", for improving name_score & ssn_score results
																											// ..to be used later on for returning "inputaddrdate" and other significant fields.
				export IncludeHistoricRecords				:= TRUE;  //RQ-13700 : Defaulting to TRUE, so we get address/dates older than 10 years.																											
			end;

			addrBest_res := AddrBest.Records(addrBest_batch, addrBest_mod).best_records;
	    
			address_record := record
        addrBest_res;
        boolean hasInputAddr;
        string6 InputAddrDate; //YYYYMM format
				string6 InputZipMatchDate;
				boolean InputZipMatch;
				boolean InputStateMatch;
				string6 InputAddrFirstSeen;
				string6 InputAddrLastSeen;
      end;
     
      address_record xformFindMatch(addrBest_res L) := transform
        string acct_no := L.acctno;
        string prim_range_in := addrBest_batch(acctno = acct_no)[1].prim_range;
        string prim_name_in := addrBest_batch(acctno = acct_no)[1].prim_name;
        string zip_in := addrBest_batch(acctno = acct_no)[1].z5;
        string city_in := addrBest_batch(acctno = acct_no)[1].p_city_name;
        string state_in := addrBest_batch(acctno = acct_no)[1].st;

        // RQ-13765 added comments and re-organized order of coding from here to the end
        // Is the addrbest hist rec marked as matching the input? OR 
        // does the addrbest hist rec street/C/S/Z fields match the corresponding input fields?
        inputAddrMatch    := L.is_input OR 
                             (prim_range_in = L.prim_range and
															prim_name_in  = L.prim_name  and 
															(zip_in = L.z5 or 
                               (city_in = L.p_city_name and state_in = L.st))
                             );
        self.hasInputAddr := inputAddrMatch;
        // RQ-13765, added if conditional check in 3 lines below to fix the bug
        self.InputAddrDate      := if(inputAddrMatch,L.addr_dt_last_seen,'');
        self.InputAddrFirstSeen := if(inputAddrMatch,L.addr_dt_first_seen,'');
        self.InputAddrLastSeen  := if(inputAddrMatch,L.addr_dt_last_seen,'');

        // does the addrbest hist rec zip field match the corresponding input field?
        inputZipMatch          := L.z5 = zip_in;
				self.InputZipMatchDate := if (inputZipMatch, L.addr_dt_last_seen,'');  //assigned later in rollup logic
				self.InputZipMatch     := inputZipMatch;

        // does the addrbest hist rec state field match the customer state the batch is being run for?
       	self.InputStateMatch := L.st = args_in.input_state;
        self := L;
      end;
      
      with_input_indicator_recs := project(addrBest_res, xformFindMatch(left));
      
			address_record xformRollup(address_record L, address_record R) := transform
        self.hasInputAddr := L.hasInputAddr or R.hasInputAddr;
        self.InputAddrDate := map(L.hasInputAddr => L.InputAddrDate,
                                  R.hasInputAddr => R.InputAddrDate,
                                  '');
        self.InputAddrFirstSeen :=	map(L.hasInputAddr => L.InputAddrFirstSeen,
																				R.hasInputAddr => R.InputAddrFirstSeen,
																				'');
        self.InputAddrLastSeen :=		map(L.hasInputAddr => L.InputAddrLastSeen,
																				R.hasInputAddr => R.InputAddrLastSeen,
																				'');																	
        leftZipDate := if (L.InputZipMatch, l.InputZipMatchDate,'');
				rightZipDate := if (R.InputZipMatch, R.InputZipMatchDate,''); 
        self.InputZipMatchDate	:= max(leftZipDate, rightZipDate);																
        self.InputZipMatch	:= L.InputZipMatch or R.InputZipMatch;	
				self.InputStateMatch := L.InputStateMatch or R.InputStateMatch;
        self := L; //first record per acctno is best address
      end;
      
      addrBest_res_final := rollup(with_input_indicator_recs, left.acctno = right.acctno, //previously sorted by acctno in AddrBest.records.best_records
																		xformRollup(left, right));
                                                             
      // *--- DEBUG ---* //
			// output(addrBest_batch, named('addrBest_batch'));
			// output(addrBest_res, named('addrBest_res'));
			// output(with_input_indicator_recs, named('with_input_indicator_recs'));   
      // output(addrBest_res_final, named('addrBest_res_final'));
			return addrBest_res_final;
	end;


	// *--- Function to get criminal batch records with Department of Corrections as datasource ---* //
	export getCriminalRecords(dataset(rec_in_wdid) in_clean_batch) := function

		unsigned2 flag_value(string1 probationFlag, string1 paroleFlag, string1 incarFlag) := function
			 flag_val := map(probationFlag = 'Y' => 1,
											 paroleFlag = 'Y' => 2,
											 incarFlag = 'Y' => 3,
											 probationFlag = 'U' => 4,
											 paroleFlag = 'U' => 5,
											 incarFlag = 'U' => 6,
											 probationFlag = 'N' => 7,
											 paroleFlag = 'N' => 8,
											 incarFlag = 'N' => 9,
											 10);
			 return flag_val;
		end;
		
		CriminalRecords_BatchService.Layouts.batch_in xformToCrimBatch(in_clean_batch L) := transform
			self.acctno := L.acctno;
			self.ssn := L.ssn;
			self := [];
		end;

		crim_batch := project(in_clean_batch, xformToCrimBatch(left));
		batch_params		:= BatchShare.IParam.getBatchParams();

		crim_batch_params := module(project(batch_params, CriminalRecords_BatchService.IParam.batch_params, opt))	
			unsigned2 MaxResults_val := 50 : stored('MaxResults');
		end;

		crim_res_all := CriminalRecords_BatchService.BatchRecords(crim_batch_params, crim_batch); 
		crim_res := crim_res_all.Records;
        
		filt_crim_res := join(crim_res, in_clean_batch, 
													left.acctno = right.acctno and
													(left.data_type = BatchServices.Constants.TRISV3.Data_Type_1 or 
																left.datasource = BatchServices.Constants.TRISV3.Department_of_Corrections) and //need to return only Department of Corrections datasource!
													StringLib.StringToUpperCase(left.lname) = StringLib.StringToUpperCase(right.name_last) and
													(StringLib.StringToUpperCase(left.fname[1]) = right.name_first[1] or
														NID.PreferredFirstNew(left.fname) = right.name_first),
													transform(recordof(crim_res), self := left), limit(0), keep(100));

		CriminalRecordsSort := record
			crim_res;
			unsigned2 sFlag; 
			string8 sDate1 ;
			string8 sDate2 ;
			string8 sDate3 ;
			string8 sDate4 ;
			string8 sDate5 ;
			string8 sDate6 ;
			string8 sDate7 ;
			string8 sDate8 ;
			string8 sDate9 ;
		end;

		CriminalRecordsSort  fillSortFields(filt_crim_res L) := transform
			self.sFlag   := flag_value(L.curr_probation_flag, L.curr_parole_flag, L.curr_incar_flag); 
			self.sDate1  := max(L.in_event_dt_1,L.in_event_dt_2,L.in_event_dt_3,L.in_event_dt_4,L.in_event_dt_5,L.in_event_dt_6,
													L.par_event_dt_1,L.par_event_dt_2,L.par_event_dt_3,L.par_event_dt_4,L.par_event_dt_5,L.par_event_dt_6);
			self.sDate2  := max(L.par_st_dt_1,L.par_st_dt_2,L.par_st_dt_3,L.par_st_dt_4,L.par_st_dt_5,L.par_st_dt_6);
			self.sDate3  := max(L.par_act_end_dt_1,L.par_act_end_dt_2,L.par_act_end_dt_3,L.par_act_end_dt_4,L.par_act_end_dt_5,L.par_act_end_dt_6);
			self.sDate4  := max(L.par_sch_end_dt_1,L.par_sch_end_dt_2,L.par_sch_end_dt_3,L.par_sch_end_dt_4,L.par_sch_end_dt_5,L.par_sch_end_dt_6);
			self.sDate5  := max(L.act_rel_dt_1,L.act_rel_dt_2,L.act_rel_dt_3,L.act_rel_dt_4,L.act_rel_dt_5,L.act_rel_dt_6);			
			self.sDate6  := max(L.ctl_rel_dt_1,L.ctl_rel_dt_2,L.ctl_rel_dt_3,L.ctl_rel_dt_4,L.ctl_rel_dt_5,L.ctl_rel_dt_6);  
			self.sDate7  := max(L.sch_rel_dt_1,L.sch_rel_dt_2,L.sch_rel_dt_3,L.sch_rel_dt_4,L.sch_rel_dt_5,L.sch_rel_dt_6);
			self.sDate8  := max(L.latest_adm_dt_1,L.latest_adm_dt_2,L.latest_adm_dt_3,L.latest_adm_dt_4,L.latest_adm_dt_5,L.latest_adm_dt_6);
			self.sDate9  := max(L.inc_adm_dt_1,L.inc_adm_dt_2,L.inc_adm_dt_3,L.inc_adm_dt_4,L.inc_adm_dt_5,L.inc_adm_dt_6);			 
		 self := l;
		end;

		filt_crim_res_w_dates := project(filt_crim_res, fillSortFields(LEFT));
		filt_crim_res_sorted := SORT(filt_crim_res_w_dates, -sDate1, sFlag, 

																												-sDate2, sFlag, 
																												-sDate3, sFlag, 
																												-sDate4, sFlag, 
																												-sDate5, sFlag, 
																												-sDate6, sFlag,
																												-sDate7, sFlag, 
																												-sDate8, sFlag, 
																												-sDate9, sFlag,
																												-process_date,sFlag);
																												
		return filt_crim_res_sorted;
	end;
	
	/* Tris 3.2 Enhancement : Since InputAddrFelonyCount is blanked out, this function will not be used, so commenting out....
	// * --- Function to get criminal batch records at input address --- * //
	export getFeloniesAtAddressRecords(dataset(rec_in_wdid) in_clean_batch) := function

		CriminalRecords_BatchService.Layouts.batch_in xformToCrimBatch(in_clean_batch L) := transform
			self.acctno := L.acctno;
			self.prim_range := L.prim_range;
			self.prim_name := L.prim_name;
			self.addr_suffix := L.addr_suffix;
			self.postdir := L.postdir;
			self.unit_desig := L.unit_desig;
			self.sec_range := L.sec_range;
			self.p_city_name := L.p_city_name;
			self.st := L.st;
			self.z5 := L.z5;
			self.zip4 := L.zip4;
			self := [];
		end;
		crim_batch := project(in_clean_batch, xformToCrimBatch(left));
		
		batch_params		:= BatchShare.IParam.getBatchParams();
		crim_batch_params := module(project(batch_params, CriminalRecords_BatchService.IParam.batch_params, opt))	
			unsigned2 MaxResults_val 		:= 50 : stored('MaxResults');
			export boolean MatchStrAddr	:= true;      
		  export boolean MatchState   := true;            
		end;
		
		crim_res_all := CriminalRecords_BatchService.BatchRecords(crim_batch_params, crim_batch);
		crim_res := crim_res_all.Records(did <> 0);
			
		filt_crim_res := join(crim_res, in_clean_batch, 
													left.acctno = right.acctno and
													(left.data_type = BatchServices.Constants.TRISV3.Data_Type_2 or 
																left.datasource = BatchServices.Constants.TRISV3.Criminal_Court) and 
													left.prim_range = right.prim_range and
												  StringLib.StringToUpperCase(left.prim_name) = StringLib.StringToUpperCase(right.prim_name) and
													StringLib.StringToUpperCase(left.p_city_name) = StringLib.StringToUpperCase(right.p_city_name) and
													StringLib.StringToUpperCase(left.st) = StringLib.StringToUpperCase(right.st) and
													left.zip5 = right.z5,
													transform(recordof(crim_res), self := left), limit(0), keep(100));	
	
			filt_crim_res_felony := filt_crim_res(std.str.find(stringlib.StringToUpperCase(
                  off_desc_1_1 + off_desc_1_2 + off_desc_1_3 + off_desc_1_4 + off_desc_1_5 + off_desc_1_6 +
                  off_desc_2_1 + off_desc_2_2 + off_desc_2_3 + off_desc_2_4 + off_desc_2_5 + off_desc_2_6 +
                  add_off_desc_1 + add_off_desc_2 + add_off_desc_3 + add_off_desc_4 + add_off_desc_5 + add_off_desc_6 +
                  off_typ_1 +off_typ_2 + off_typ_3 + off_typ_4 + off_typ_5 + off_typ_6 +
                  off_lev_1 +off_lev_2 + off_lev_3 + off_lev_4 + off_lev_5 + off_lev_6), 'FELONY') > 0 );
			
			crim_felony_recs_deduped := dedup(sort(filt_crim_res_felony, acctno, did), did);
			
			//Constant
      max_address_rec := 20;
      
			AddrBest.Layout_BestAddr.Batch_in makeAddrBestBatch(crim_felony_recs_deduped L, integer C) := transform
        self.did := L.did;
			  // Can't run a batch of dids with the same account number.  Prepend a unique number that will
				// be stripped off later.
				self.acctno := (string)C + '_' + L.acctno;	
				self := [];
			end;
					
			addrBest_batch := project(crim_felony_recs_deduped, makeAddrBestBatch(left, counter));
			    
			addrBest_mod := module(AddrBest.Iparams.SearchParams) 
				export IncludeRanking 				 := FALSE; //automatically applied to GOV applications to always get best ranked addr
																								 //TRISv3.2 Enhancement : As per requirement, GBA should not be used for both 3.1 and 3.2 versions. Switching it back to Traditional Best.

			end;
			addrBest_res := AddrBest.Records(addrBest_batch, addrBest_mod).best_records;
			
			addrBest_res xform_w_acct(addrBest_res L) := transform
				acctno := L.acctno;
				SET OF STRING acct_elems := Std.Str.SplitWords(L.acctno, '_');
				self.acctno := L.acctno[length(acct_elems[1]) + 2..length(acctno)];
				self := L;
			end;
			
			addrBest_res_w_acct := project(addrBest_res, xform_w_acct(left));

			ds_felonies_at_addr := join(in_clean_batch, addrBest_res_w_acct,
																	left.acctno = right.acctno and
																	left.prim_range = right.prim_range and
																	left.prim_name = right.prim_name and
																	(left.sec_range = right.sec_range or left.sec_range = '' 
																			or right.sec_range = '') and
																	left.z5 = right.z5,
																	transform(recordof(addrBest_res), self := right, self := []));
																	
		return ds_felonies_at_addr;
	end;
	*/


	// *--- Function to get phone recs ---* //
	EXPORT getPhoneRecords(DATASET(rec_in_wdid) in_clean_batch,
												 UNSIGNED1 glb_purpose_value,
												 UNSIGNED1 dppa_purpose_value) := FUNCTION
				 
		tmpMod :=
			MODULE(PROJECT(AutoStandardI.GlobalModule(),progressive_phone.iParam.Batch,OPT))
				EXPORT INTEGER MaxPhoneCount       	:= 1; 
				EXPORT INTEGER CountPP             	:= 1;
				EXPORT INTEGER CountES						 	:= 1;
				EXPORT INTEGER CountSE						 	:= 1;
			END;
		
			f_in_progressive_phone := PROJECT(in_clean_batch,
																		TRANSFORM(progressive_phone.layout_progressive_batch_in,
																				SELF := LEFT,
																				SELF := []));
		
		ProgressivePhones := AddrBest.Progressive_phone_common(f_in_progressive_phone, tmpMod);

		RETURN ProgressivePhones;

	END;

	
	// Tris 3.2 Enhancement : Since Net Acuity is no longer in used, commenting out this function....
	/*
	EXPORT getIPAddressRecords(DATASET(rec_in_wdid) in_clean_batch,
														 UNSIGNED1 glb_purpose_value,
												     UNSIGNED1 dppa_purpose_value,
														 DATASET(Gateway.Layouts.Config) gateways_in) := FUNCTION
		
		formattedInput := PROJECT(in_clean_batch, TRANSFORM(RiskWise.Layout_IPAI,
																									SELF.Seq := LEFT.Seq,
																									SELF.IPAddr := LEFT.ip_Address,
																									SELF := []));
																																						 
	  netAcuityResults := Risk_Indicators.getNetAcuity(formattedInput, 
																										 gateways_in, 
																										 dppa_purpose_value, 
																										 glb_purpose_value);
	
		RETURN netAcuityResults;
	END;
	*/
  

	// *--- Function to get in-house IP_Metadata info for all 3 input ip addresses ---* //
  // 08/11/2017 v3.2 enhancements requirement 3.1.3.12
	EXPORT getIPMetaDataRecords(DATASET(rec_in_wdid) in_clean_batch) := FUNCTION
		
			ds_IP_Metadata_batch_in := PROJECT(in_clean_batch , 
                                         TRANSFORM(BatchServices.IP_Metadata_Layouts.batch_in_raw,
																				   SELF.acctno			:= LEFT.acctno,
																					 SELF.ip_address1 := LEFT.ip_address,
																					 SELF.ip_address2 := LEFT.device_ini_ip_address,
																					 SELF.ip_address3 := LEFT.device_submit_ip_address));

			BatchServices.IP_Metadata_Layouts.batch_in normBatchRecs(ds_IP_Metadata_batch_in L,INTEGER C) := TRANSFORM
				STRING IP_address	:=CHOOSE(C,L.IP_address1,L.IP_address2,L.IP_address3);
				SELF.orig_acctno 	:= L.acctno;
        // Need to maintain the order of input ip addresses as output 1, 2 & 3 even if 1 
        // or more of the input values are blank.  So allow a blank ip_address to go thru.
				SELF.IP_address		:= Std.Str.ToUpperCase(IP_address); 
				SELF:=L;
			END;

			ds_batch_in_normalized := NORMALIZE(ds_IP_Metadata_batch_in,3,normBatchRecs(LEFT,COUNTER));

			ds_child_recs_raw := BatchServices.IP_Metadata_Records(ds_batch_in_normalized);

      // A blank input ip_address causes some bogus info to be returned by 
      // BatchServices.IP_Metadata_Records above; 
      // So when that situation exists, null out the fields we are using for TRIS output.
 			ds_child_recs := PROJECT(ds_child_recs_raw,
         TRANSFORM(BatchServices.IP_Metadata_Layouts.batch_out,
				 BlankIPAddress           := LEFT.ip_address = '';
         SELF.edge_country			  := IF(BlankIPAddress,'',LEFT.edge_country);
	       SELF.edge_region         := IF(BlankIPAddress,'',LEFT.edge_region);
         SELF.edge_city           := IF(BlankIPAddress,'',LEFT.edge_city);
         SELF.edge_conn_speed     := IF(BlankIPAddress,'',LEFT.edge_conn_speed);
         SELF.edge_latitude       := IF(BlankIPAddress,'',LEFT.edge_latitude);
         SELF.edge_longitude      := IF(BlankIPAddress,'',LEFT.edge_longitude);
	       SELF.edge_postal_code    := IF(BlankIPAddress,'',LEFT.edge_postal_code);
	       SELF.edge_continent_code := IF(BlankIPAddress,0, LEFT.edge_continent_code);
		     SELF.edge_country_conf   := IF(BlankIPAddress,0, LEFT.edge_country_conf);
         SELF.edge_region_conf    := IF(BlankIPAddress,0, LEFT.edge_region_conf);
         SELF.edge_city_conf      := IF(BlankIPAddress,0, LEFT.edge_city_conf);
         SELF.edge_postal_conf    := IF(BlankIPAddress,0, LEFT.edge_postal_conf);
	       SELF.isp_name            := IF(BlankIPAddress,'',LEFT.isp_name);
	       SELF.edge_gmt_offset     := IF(BlankIPAddress,0, LEFT.edge_gmt_offset);
	       SELF.domain_name         := IF(BlankIPAddress,'',LEFT.domain_name);
	       SELF.proxy_type          := IF(BlankIPAddress,'',LEFT.proxy_type);
         SELF.proxy_description   := IF(BlankIPAddress,'',LEFT.proxy_description);
         SELF.asn                 := IF(BlankIPAddress,0, LEFT.asn);
         SELF.asn_name            := IF(BlankIPAddress,'',LEFT.asn_name);
         SELF                     := LEFT;));

			ds_parent_recs := PROJECT(DEDUP(SORT(ds_batch_in_normalized,acctno),acctno),TRANSFORM(BatchServices.IP_Metadata_Layouts.batch_out_flat_acctno,SELF:=LEFT,SELF:=[]));

			ds_batch_out_denormalized := BatchShare.MAC_ExpandLayout.Denorm(ds_parent_recs,ds_child_recs,BatchServices.IP_Metadata_Layouts.batch_out_raw,'');
                                                             
      // *--- DEBUG ---* //
		  // output(in_clean_batch, named('in_clean_batch'));
		  // output(ds_IP_Metadata_batch_in, named('ds_IP_Metadata_batch_in'));
      // output(ds_batch_in_normalized, named('ds_batch_in_normalized'));
      // output(ds_child_recs_raw, named('ds_child_recs_raw'));
      // output(ds_child_recs, named('ds_child_recs'));
      // output(ds_parent_recs, named('ds_parent_recs'));
      // output(ds_batch_out_denormalized, named('ds_batch_out_denormalized'));
			
			RETURN ds_batch_out_denormalized;
	END;

  // 08/11/2017 v3.2 enhancements requirement 3.1.4
	EXPORT getValidationIpProblems(string45 input_ip_address , string45 ip_metadata_ip_address, string5 country_code) := FUNCTION
	
		string5  ipcountry				  := if(ip_metadata_ip_address = '',
                                      '', trim(StringLib.StringToUpperCase(country_code)));
    
		validationIpProblems 		:= 
       map( input_ip_address = ''	                                      => '-1',
						ipcountry     IN BatchServices.Constants.TRISv3.IP_Country	=> '0',
						ipcountry NOT IN BatchServices.Constants.TRISv3.IP_Country 
            and ipcountry <>''                                          => '1',
						// anything else is '2'
						                                                               '2');
            
		RETURN validationIpProblems;
	END;

  // 08/11/2017 v3.2 enhancements requirement 3.1.5
	EXPORT getIPAddrExceedsInputAddr(	REAL input_lat, 
																		REAL input_long,
																		string45 ipaddress, 
																		string10 latitude,
																		string10 longitude, 
																		BatchServices.TaxRefundISv3_BatchService_Interfaces.Input args_in) := FUNCTION
																																		
			//TRIS v3.0 : IP Address indicator req. 4.1.47
			ip_lat     := (REAL)latitude;
			ip_long    := (REAL)longitude;
			geo_dist   := IF(	ipaddress <> '',
												Address_Attributes.functions.GeoDist(	input_lat,
																															input_long,
																															ip_lat,
																															ip_long),
												0);

			ipInvalid := if(// line below added due to 2015 enhancements, req 4.1.7 new input option
											Stringlib.StringFilterOut(ipaddress[1],'0123456789') <> '' or 
											ipaddress = '' or ipaddress = '0' or
											(ip_lat = 0 and ip_long = 0), TRUE, FALSE);	
								
			IPAddrExceedsInputAddr := MAP(ipInvalid	=> '',
																		StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER' and geo_dist >= args_in.IPAddrExceedsRange => '1', 
																		(NOT StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER') and geo_dist >= 100 => '1',
																		'');
			RETURN IPAddrExceedsInputAddr;
	END;
	

 // *--- Function to get HRI Address codes ---* //
  export getHRIRecords(dataset(rec_in_wdid) in_clean_batch) := function
  
      Autokey_batch.Layouts.rec_inBatchMaster xformToBatchRec(rec_in_wdid L) := transform
        SELF.acctno      := l.acctno;
        
        SELF.prim_range  := StringLib.StringToUpperCase(l.prim_range);	
        SELF.predir      := StringLib.StringToUpperCase(l.predir);	
        SELF.prim_name   := StringLib.StringToUpperCase(l.prim_name);	
        SELF.addr_suffix := StringLib.StringToUpperCase(l.addr_suffix);	
        SELF.postdir     := StringLib.StringToUpperCase(l.postdir);	
        SELF.unit_desig  := StringLib.StringToUpperCase(l.unit_desig);	
        SELF.sec_range   := StringLib.StringToUpperCase(l.sec_range);	

        SELF.p_city_name := StringLib.StringToUpperCase(l.p_city_name);	
        SELF.st          := StringLib.StringToUpperCase(l.st);
        SELF.z5          := l.z5;
        
        self := [];
      end;
      
      indata := project(in_clean_batch, xformToBatchRec(left));

      // Retrieve and output records
      ds_outrecs := BatchServices.HRI_Address_Records(indata);
      
			// 2015 enhancements/fix req 4.1.13 to only use the first 4 digits of the sic_code 
			// returned from BatchServices.HRI_Address_Records.
			ds_outrecs_filt := ds_outrecs(sic_code[1..4] = 
	                              BatchServices.Constants.TRISV3.Correctional_Institution);

			return ds_outrecs_filt;
			
  end;	


  // *--- Function to get SSNIssuance issued start date ---* //
  export getSSNIssuanceRecords(dataset(rec_final) in_data) := function
  
			//Tris 3.2 Enhancement : Per req 3.1.10, removing possible_age_dob = '' condition and project to SSNIssuance batch input layout (acctno + ssn)
			no_dob_recs := project(in_data, BatchServices.Layouts.SsnIssuance.batch_in);
    
      ssn_issuance_res := BatchServices.SSN_Issuance_BatchService_Records (no_dob_recs);

      return ssn_issuance_res;
  end;
	
	
  // *--- Function to get flags indicating input address matched a relatives address ---* //
	export get_rel_addr_match(dataset(rec_in_wdid) in_clean_batch) := function
	   DidVille.Layout_RAN_BestInfo_BatchIn  fillInput(rec_in_wdid l) := transform
			self.acctno := l.acctno;
		 	self.ssn := l.ssn;
			self.name_first := l.name_first;
			self.name_middle := l.name_middle;
			self.name_last := l.name_last;
			self.name_suffix := l.name_suffix;
			self.prim_range := l.prim_range;
			self.predir := l.predir;
			self.prim_name := l.prim_name;
			self.suffix := l.addr_suffix;
			self.postdir := l.postdir;
			self.unit_desig := l.unit_desig;
			self.sec_range := l.sec_range;
			self.p_city_name := l.p_city_name;
			self.st := l.st;
			self.z5 := l.z5; 
			self.z4 := l.zip4;
			self := [];
		 end;
	   inputRecs := project(in_clean_batch, fillInput(LEFT));
	   bestRecs := DidVille.RAN_BestInfo_Batch_Service_Records(inputRecs,
																														 CompareInputAddrWithRel := TRUE,
																														 CompareInputAddrNameWithRel := TRUE, 
  																													 UseBlankPhoneNumberRecords := TRUE);
		
	   //only need to keep 2 fields for lookup purposes later on.	 
		 slimRec := record
		   STRING20 acctno;
		   boolean input_addr_matched_rel;
			 boolean input_addr_name_matched_rel;
		 end;
		 outRecs := project(bestRecs, transform(slimRec, self := LEFT));
		  
		 return outRecs;
	end;


 // *--- Function to get FraudPoint2.0 data ---* //
  export callFraudPoint2(unsigned1 GLBPurpose,
												 unsigned1 DPPAPurpose,
												 string DataRestrictionMask,
												 string IndustryClass,
												 string20 ModelName,
												 dataset(rec_in_wdid) in_clean_batch, 
												 string DataPermissionMask
												 ) := function
		
	  // Layout for batch input to FraudPoint 2.0 :
	  layout_fp_batch_in := Models.FraudAdvisor_Batch_Service_Layouts.BatchInput;
		
		layout_fp_batch_in fill_fpBatch (in_clean_batch L) := TRANSFORM
				self := L;
				self.Suffix := L.Addr_Suffix;
				self := [];
		end;
		batch_in_FP := project(in_clean_batch,fill_fpBatch(LEFT));


    // module here inherits the interface & overrides it
		InputArgs := module (Models.FraudAdvisor_Batch_Service_Interfaces.Input)
					export string ModelName_in 					:= ModelName;
					export boolean   doVersion1 				:= false;
					export boolean   doVersion2 				:= true;
					export unsigned1 dppa 							:= DPPAPurpose;
					export unsigned1 glb								:= GLBPurpose;
					export string5   industry_class_val := IndustryClass;
					export boolean   ofac_Only 					:= true ;
					export boolean   ofacSearching 			:= true ;
					export boolean   excludewatchlists 	:= false ;
					export unsigned1 OFACVersion       	:= 1 ;
					export boolean   IncludeOfac       	:= false;
					export real      gwThreshold       	:= 0.84 ;
					export boolean   addtl_watchlists  	:= false ;
					export boolean   usedobFilter      	:= false ;
					export integer2  dobradius         	:= 2 ;
					export unsigned1 RedFlag_version   	:= 0 ;
					export string DataRestriction      	:= DataRestrictionMask; // 0000000000000000000 to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
					export string DataPermission    	  := DataPermissionMask; 
		end;

		wModel := Models.FraudAdvisor_Batch_Service_Records(InputArgs,batch_in_FP,
																												Gateway.Constants.void_gateway
																												);

		return wModel;
	end;


	/* Tris 3.2 Enhancement : Since dod_bkr_flag is blanked out, this function will not be used, so commenting out....
  // *--- Function to get Bankruptcy data for the min input and did for req 4.1.31 ---* // 
	export func_get_bankr_data(dataset(rec_in_wdid) ds_batch_in_wdid) := function

    // Project input dataset onto layout needed by the bankruptcy batch service
		ds_bankr_input := project(ds_batch_in_wdid,
															transform(BatchServices.layout_BankruptcyV3_Batch_in,
																	        self := left));

    // Call the bankruptcy batch service to get the bankruptcy data.
    ds_bankr_recs := BatchServices.Bankruptcy_BatchService_records.Search(
		                    // Some input parms copied from BatchServices.Bankruptcy_BatchService
		                    ds_bankr_input, // input data to get bankruptcies for
												['D'],  // party_types, [D]=match debtors only, req 4.1.31
										    false,  // isFCRA, 
												false,  // isDeepDive,  //not needed since did is input
												'NONE', // in_ssn_mask, value doesn't really matter since we are not returning the bankr ssn
												true    // use_namessnlast4 // true = BatchServices.Bankruptcy_BatchService default
										 );
	
		// Then sort/dedup on data to be returned in case same address on more than 1 input record
		ds_bankr_recs_kept := dedup(sort(ds_bankr_recs,
																			 debtor_did,-date_filed,-orig_filing_date),
																debtor_did,date_filed);

     // Join input dataset to bankr recs kept on did to re-attach acctnos and to 
		 // return all recs passed into this function, whether they had bankr data or not.
		 ds_bankr_data_returned := join(ds_batch_in_wdid, ds_bankr_recs_kept,
																		  left.did = (unsigned) right.debtor_did,
																		transform(batchservices.TaxRefundISv3_BatchService_Layouts.rec_bankr_res,
																		  self.acctno    := left.acctno, // re-attach input acctno
																			self.bankr_did := (unsigned) right.debtor_did,
																			self := right), // rest of fields right (bankr data)
																		left outer // keep all input recs
																	 );

     // For debugging, uncomment lines below as needed
	   // output(ds_batch_in_wdid,       named('ds_batch_in_wdid'));
		 // output(ds_bankr_input,         named('ds_bankr_input'));
     // output(ds_bankr_recs,          named('ds_bankr_recs'));
		 // output(ds_bankr_recs_kept,     named('ds_bankr_recs_kept')); 
     // output(ds_bankr_data_returned, named('ds_bankr_data_returned')); 

		 return ds_bankr_data_returned;

	end; // end of func_get_bankr_data
	*/

	/* Tris 3.2 Enhancement : Since dod_dl_flag is blanked out, this function will not be used, so commenting out....
  // *--- Function to get Driver's License data for the min input and did for req 4.1.32 ---* // 
	export func_get_dl_data(dataset(rec_in_wdid) ds_batch_in_wdid) := function

    // Project input dataset onto layout needed by the bankruptcy batch service
		ds_dl_input := project(ds_batch_in_wdid,
															transform(Autokey_batch.Layouts.rec_inBatchMaster,
																	        self := left));

    // DL batch service config info (copied from DriversV2_Services.Batch_Service)
		mod_dl_config := MODULE(DriversV2_Services.GetDLParams.batch_params)
		  export useAllLookups := TRUE;
		  export skip_set      := DriversV2.Constants.autokey_skipSet;
			EXPORT boolean return_current_only	:= FALSE : STORED('Return_Current_Only');
			EXPORT UNSIGNED8 MaxResultsPerAcct := 2000;
	  end;

    // Call the DL batch service to get the dl data.
    ds_dl_recs := DriversV2_Services.Batch_Service_Records(ds_dl_input,
										                                       mod_dl_config);

    // Filter to only keep Current(not Historical) recs and recs where the status or 
		// cdl_status do not indicate the person is "Deceased", req 4.1.32
		// Then sort/dedup to only keep 1 most recent (highest lic_issue_date) record per did.
		// See DriversV2_Services.fn_getDL_report (lines 129-137) use of the "Codes" key for: 
		// history_name, status_name & cdl_status_name fields.  Then see the actual values
		// on the prod codes_v3 key for those 3 fields.
		// Note: The "raw" status & cdl_status data values mentioned in req 4.1.32, 
		// bullet point 2, item #2 do not get returned in the dl batch service, only the 
		// exploded/standardized values are returned from the Codes key join
		// (i.e. "DECEASED" or "Deceased").  Therefore only the standardized values were
		// checked for in the filter below.
		ds_dl_recs_kept := dedup(sort(ds_dl_recs((history_name[1] != 'H'
																					    // ^--- history_name filter should not be
																						  // needed since input Return_Current_Only
																							// option was set to TRUE,
																							// but left it in to be safe.
																						 )
																						 and (Stringlib.StringToUpperCase(
																									   status_name) != 'DECEASED')
		                                         and (Stringlib.StringToUpperCase(
																									   cdl_status_name) != 'DECEASED')
																						 and (lic_issue_date !=0)
																						),
		                              did,-lic_issue_date,record),
	                           did);

     // Join input dataset to dl recs kept on did to re-attach acctnos and to 
		 // return all recs passed into this function, whether they had dl data or not.
		 ds_dl_data_returned := join(ds_batch_in_wdid,ds_dl_recs_kept,
		                               left.did = right.did,
																 transform(batchservices.TaxRefundISv3_BatchService_Layouts.rec_dl_res,
																	 self.acctno := left.acctno, // re-attach input acctno
																   self.dl_did := right.did,
																	 self := right), // rest of fields right (dl data)
																 left outer // keep all input recs
															  );

     // For debugging, uncomment lines below as needed
	   // output(ds_batch_in_wdid,    named('ds_batch_in_wdid'));
		 // output(ds_dl_input,         named('ds_dl_input'));
     // output(ds_dl_recs,          named('ds_dl_recs'));
		 // output(ds_dl_recs_kept,     named('ds_dl_recs_kept')); 
     // output(ds_dl_data_returned, named('ds_dl_data_returned')); 

		 return ds_dl_data_returned;

	end; // end of func_get_dl_data
	*/
		
	/* Tris 3.2 Enhancement : Since dod_deed_flag is blanked out, this function will not be used, so commenting out....
  // *--- Function to get Property deeds data for the min input and did for req 4.1.33 ---* // 
	export func_get_propdeed_data(dataset(rec_in_wdid) ds_batch_in_wdid) := function

		// Capitalize any lower case alpha letters in the acctno field for matching later, 
		// since the output of BatchServices.Property_BatchCommon also has that field capitalized.
		ds_batch_in_wdid_cap := project(ds_batch_in_wdid,
		                                transform(rec_in_wdid,
																		  self.acctno := StringLib.StringToUpperCase(left.acctno),
																			self        := left
																		));

    // Project input dataset onto layout needed by the property batch service.
		ds_propdeed_input := project(ds_batch_in_wdid,
	                               transform(LN_PropertyV2_Services.layouts.batch_in_plus_date_filter,
																	  self := left
																));

 		// The line below was copied from BatchServices.Property_BatchService where it was
		// passed into Property_BatchCommon.
    nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.doNothing);

    // Call the Property batch service "Common" function to get the property data.
		// NOTE: The Property batch service input options need to be set in 
		//       BatchServices.TaxRefundISv3_BatchService_Records, before this  
		//       func_get_propdeed_data function is called.
    ds_propdeed_recs := BatchServices.Property_BatchCommon(false, // 1st parm=isFCRA
		                                                       nss,   // 2nd parm nss unsigned1 value 
																													 false,  // 3rd parm = useCannedrecs s/b false
																											     ds_propdeed_input // 4th parm=input dataset,
																													 ).Records;

    // Normalize the non-empty recs out of the property batch service to split out 
		// buyer_1 & buyer 2 names onto separate recs and only keeping
		// the deed fields we will need later.
    rec_prop_slim := record
			 string30  acctno;
       // will need to append 2 input name fields
			 string3   input_name_first3;
			 string20  input_name_last;
		   string8   deed_contract_date  := '';
		   string8   deed_recording_date := '';
		   string70  deed_document_type_desc := '';					
			 string120 buyer_orig_name   := '';
		   string3   buyer_first_name3 := ''; // only need to compare first 3 chars
		   string20  buyer_last_name   := '';
		   string12  buyer_did         := '';
		end;

    rec_prop_slim tf_norm_names(recordof(ds_propdeed_recs) L,
		                            integer C) := transform
       self.input_name_first3 := '';
			 self.input_name_last   := '';
       self.buyer_orig_name	  := choose(C,L.buyer_1_orig_name,L.buyer_2_orig_name); 
	     self.buyer_first_name3 := choose(C,L.buyer_1_first_name[1..3],L.buyer_2_first_name[1..3]);
       self.buyer_last_name	  := choose(C,L.buyer_1_last_name,L.buyer_2_last_name);
       self.buyer_did         := choose(C,L.buyer_1_did,L.buyer_2_did);
			 self                   := L;	 
		end;

    ds_propdeed_recs_normed := normalize(ds_propdeed_recs
																					 // filter to only keep recs where buyer names exist
		                                       (buyer_1_orig_name !='' or
		                                        buyer_2_orig_name !=''),
		                                     2, // twice for buyer 1&2
	                                       tf_norm_names(left,counter));

   // Join normed recs back to input ds to get the input name info for comparision later.
   ds_propdeed_recs_winputname := join(ds_propdeed_recs_normed, ds_batch_in_wdid_cap,
	                                       left.acctno = right.acctno,
																			 transform(rec_prop_slim,
																			   // 2 fields from input (right), the rest from left
																			   self.input_name_first3 := Stringlib.StringToUpperCase(
																									                  right.name_first[1..3]),
																				 self.input_name_last   := Stringlib.StringToUpperCase(
																				                            right.name_last),
																				 self            := left)
	                                    );    
  
    // Filter to keep recs with certain conditions per req 4.1.33, bullet point 2,items 2-4
		ds_propdeed_recs_kept := ds_propdeed_recs_winputname(
															 // req item #3, match last/first name except if recs have
															 // *TRUST* or *ESTATE* in buyer 1/2 orig  name fields
															 (Stringlib.StringFind(buyer_orig_name,'TRUST',1)=0 and
															  Stringlib.StringFind(buyer_orig_name,'ESTATE',1)=0)
														   // req item #2, only recs with buyer1 or buyer 2 lastname &
														   // firstname(first 3 chars) that match the input last/first name
															 and (input_name_first3 = buyer_first_name3 and
																    input_name_last   = buyer_last_name)
                               // req item #4, recs that do not contain certain terms																		
	                             and (deed_document_type_desc not in 
															      batchservices.Constants.TRISv3.set_ExcludedDeedTypes)
                               // req item #5a, have non-zero dates
															 and ((unsigned)deed_contract_date  !=0 or 
																	  (unsigned)deed_recording_date !=0)
														 );

     // Join input dataset to deed recs kept on did to re-attach acctnos and to 
		 // return all recs passed into this function, whether they had deed data or not.
		 ds_propdeed_data_returned := join(ds_batch_in_wdid,ds_propdeed_recs_kept,
		                                     left.did = (unsigned) right.buyer_did,
																		   transform(batchservices.TaxRefundISv3_BatchService_Layouts.rec_propdeed_res,
																		     self.acctno   := left.acctno, //re-attach input acctno
																			   self.deed_did := (unsigned) right.buyer_did,
																			   self := right), // rest of fields right (dl data)
																		   left outer // keep all input recs
																	    );

     // For debugging, uncomment lines below as needed
	   // output(ds_batch_in_wdid,            named('ds_batch_in_wdid'));
		 // output(ds_batch_in_wdid_cap,        named('ds_batch_in_wdid_cap'));
		 // output(ds_propdeed_input,           named('ds_propdeed_input'));
     // output(ds_propdeed_recs,            named('ds_propdeed_recs'));
		 // output(ds_propdeed_recs_normed,     named('ds_propdeed_recs_normed')); 
     // output(ds_propdeed_recs_winputname, named('ds_propdeed_recs_winputname')); 
		 // output(ds_propdeed_recs_kept,       named('ds_propdeed_recs_kept')); 
     // output(ds_propdeed_data_returned,   named('ds_propdeed_data_returned')); 

		 return ds_propdeed_data_returned;

	end; // end of func_get_propdeed_data
	*/
	
	/* Tris 3.2 Enhancement : Since dod_mvr_flag is blanked out, this function will not be used, so commenting out....
  // *--- Function to get vehicle/mvr data for the min input and did for req 4.1.34 ---* // 
	export func_get_mvr_data(dataset(rec_in_wdid) ds_batch_in_wdid) := function

    // Use VehicleV2_Services.RealTime_Batch_Service_V2_records. 
    // NOTE: According to the product manager, Jennifer Paganacci on 09/10/14, due to 
		// improvements/enhancements in the RTBSV2 she wants to use it instead of the 
		// VehicleV2_Services.Vin_Batch_Service_records, even though the RT batch servicev2
		// calls the Vin Batch Service.
		//
    // Project common TRISv3 batch input with did appended layout onto the layout 
		// expected by VehicleV2_Services.RealTime_Batch_Service_Records.
		ds_mvr_input := project(ds_batch_in_wdid,
														transform(VehicleV2_Services.Batch_Layout.RealTime_InLayout_V2,
																				 // Build "addr1" field from pieces
																				 self.addr1      := Address.Addr1FromComponents(
																														   left.prim_range, 
																														   left.predir, 
																															 left.prim_name,
																															 left.addr_suffix, 
																															 left.postdir, 
																															 left.unit_desig, 
																															 left.sec_range);
                                         //  null out these
																				 self.name_full  :='';
																				 self.comp_name  := '';
																				 self.addr2      := '';
																				 self.year       := '';
																				 self.make       := '';
																				 self.model      := '';
		                                     self.vinIn      :='';
		                                     self.plate      :='';
		                                     self.plateState := '';
		                                     self.date       := '';
																				 // name parts, p_city_name, st ,z5 & ssn fields
																				 // have same field name as left so use left
																				 self := left, 
																		 ));

    // Vehicle RealTime batch service config info module, 
		//  (copied from VehicleV2_Services.RealTime_Batch_Service_V2)
		mod_mvr := module(VehicleV2_Services.IParam.RTBatch_V2_params)
		// most/all of these input options should not be needed since they 
        // are not being input to this new TRISV3 Batch Service. 
        // The only exception might be GatewayNameMatch and AlwaysHitGateway since they
				// mentioned in req 4.1.34, but they are being set to FALSE in  
        //   BatchServices.TaxRefundISv3_BatchService_Records.
		    export boolean GatewayNameMatch    	:= false; // NOTE: default value diff than req 4.1.34, but matches the Veh RTBSV2
	      // export BOOLEAN AlwaysHitGateway    := ~doxie.DataPermission.use_Polk;
				export boolean Is_UseDate 					:= false; //use_date and is_veh2; since use_date defaults to false then is_UseDate is always false
				export boolean ReturnCurrent				:= TRUE;  // NOTE: option name diff than req 4.1.34, but matches the Veh RTBSV2
				export string32 ApplicationType 		:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(
                AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
			// export BOOLEAN AlwaysHitGateway    := ~doxie.DataPermission.use_Polk;
		//
	  end;

		// NOTE: The VehicleV2.RealTime_Batch_Service_V2 input options like:
		//           ReturnCurrent = TRUE,
		//           GatewayNameMatch = Blank
		//           RealTimePermissibleUse = Blank (causes the RTBSV2 to only access in-house MVR data???)
		//  		 NEED to be set in BatchServices.TaxRefundISv3_BatchService_Records,
		//            before this func_get_mvr_data function is called.
	  ds_mvr_recs := VehicleV2_Services.RealTime_Batch_Service_V2_records(
									     ds_mvr_input, 
									     mod_mvr, 
									 		 true);   //Is_Veh2

    // Normalize the non-empty recs out of the vehicle rt batch service to split out 
		// registrant names 1, 2 & 3 (with registration dates) onto separate recs 
		// and only keep the mvr fields we will need later.
    rec_mvr_slim := record
		   string30 acctno;
       // will need to append 2 input name fields
			 string3   input_name_first3;
			 string20  input_name_last;
			 // only keep certain fields from veh batch service output
			 string25  vin        :='';
		   string3   reg_fname3 := ''; // only need to compare first 3 letters
		   string20  reg_lname  := '';
		   string12  reg_did    := '';
			 string8   reg_first_date            := '';
			 string8   reg_latest_effective_date := '';
		end;

    rec_mvr_slim tf_norm_registrants(recordof(ds_mvr_recs) L,
	      	                           integer C) := transform
       self.input_name_first3 := ''; //just null here, will be assigned below
			 self.input_name_last   := ''; //just null here, will be assigned below
			 // only need to save/check first 3 chars of first name.
	     self.reg_fname3        := choose(C,L.reg_1_fname[1..3],L.reg_2_fname[1..3],L.reg_3_fname[1..3]);
       self.reg_lname	        := choose(C,L.reg_1_lname,L.reg_2_lname,L.reg_3_lname);
       self.reg_did           := choose(C,L.reg_1_did,L.reg_2_did,L.reg_3_did);
			 // only 1 set of reg dates in Vehv2.RTbsV2 output, so put the 2 date fields on all recs
			 // v--- since reg_first_date not populated on some(all?) source_code=DI recs, 
			 //      if the reg_first_date is blank, use the reg_earliest_effective_date
       self.reg_first_date            := if(L.reg_first_date != '', 
			                                      L.reg_first_date,
			                                      L.reg_earliest_effective_date);
			 self.reg_latest_effective_date := L.reg_latest_effective_date;
			 self                           := L;	 
		end;

    ds_mvr_recs_normed := normalize(ds_mvr_recs
																	    // filter to only keep recs where a registrant name exists
		                                  (reg_1_lname !='' or
		                                   reg_2_lname !='' or 
																			 reg_3_lname != ''),
		                                   3, // 3 times for registrant 1, 2 & 3
	                                     tf_norm_registrants(left,counter));

   // Join normed recs back to input ds to get the input name info for comparision later.
   ds_mvr_recs_winputname := join(ds_mvr_recs_normed,ds_batch_in_wdid,
	                                   left.acctno = right.acctno,
																	transform(rec_mvr_slim,
																	   // 2 fields from input (right), the rest from left
																		 self.input_name_first3 := Stringlib.StringToUpperCase(
																						                  right.name_first[1..3]),
																		 self.input_name_last   := Stringlib.StringToUpperCase(
																				                            right.name_last),
																		 self                   := left)
	                               );

    // Filter to only keep recs with certain conditions per req 4.1.34, bullet point 2,
		// item #s 1 & 2.
		// Then sort/dedup to only keep the 1 most recent (highest reg_latest_effective_date &
		// highest reg_first_date) record per did.
		ds_mvr_recs_kept := dedup(sort(ds_mvr_recs_winputname(
		                                 // Filter first
														         // req item #1, only recs with registrant 1, 2 or 3 
																	   // lastname & firstname(first 3 chars) that match 
																	   // the input last/first(3 chars) names.
															       (input_name_first3 = reg_fname3 and
																      input_name_last   = reg_lname)
                                     // req item #2, reg dates match
															       and (reg_first_date = reg_latest_effective_date)
														        ), // end of filter
																	 //Sort by:
																	 reg_did,
																	 -reg_latest_effective_date,
																	 -reg_first_date),
															//Dedup by:
															reg_did
															);														 

     // Join input dataset to mvr recs kept on did to return all recs passed into
		 // this function, whether they had mvr data or not.
		 ds_mvr_data_returned := join(ds_batch_in_wdid, ds_mvr_recs_kept,
																		left.did = (unsigned) right.reg_did,
																	transform(batchservices.TaxRefundISv3_BatchService_Layouts.rec_mvr_res,
																	  self.acctno  := left.acctno, // re-attach input acctno
																	  self.mvr_did := (unsigned) right.reg_did,
																		self         := right), // rest of fields right (voter data)
																	left outer // keep all input recs
																 );

     // For debugging, uncomment lines below as needed
     // output(ds_batch_in_wdid,       named('ds_batch_in_wdid'));
		 // output(ds_mvr_input,           named('ds_mvr_input'));
     // output(ds_mvr_recs,            named('ds_mvr_recs'));
		 // output(ds_mvr_recs_normed,     named('ds_mvr_recs_normed')); 
     // output(ds_mvr_recs_winputname, named('ds_mvr_recs_winputname')); 
		 // output(ds_mvr_recs_kept,       named('ds_mvr_recs_kept')); 
     // output(ds_mvr_data_returned,   named('ds_mvr_data_returned')); 

		 return ds_mvr_data_returned;

	end; // end of func_get_mvr_data
	*/
	
	/* Tris 3.2 Enhancement : Since dod_voter_flag is blanked out, this function will not be used, so commenting out....
  // *--- Function to get voter data for the min input and did for req 4.1.35 ---* // 
	export func_get_voter_data(dataset(rec_in_wdid) ds_batch_in_wdid) := function

    // Project input dataset onto layout needed by the voter batch service
		ds_voter_input := project(ds_batch_in_wdid,
															transform(Autokey_batch.Layouts.rec_inBatchMaster,
																	        self := left));

    // Voter batch service config info (copied from VotersV2_Services.BAtch_SErvice)
	  mod_voter_config := MODULE(BatchServices.Interfaces.i_AK_Config)
			export UseAllLookUps := TRUE; // used in VotersV2_Services.BAtch_SErvice, BUT
			// it causes all dids at the input address to be returned regardless of input name.
			// However if removed, there is an issue with the voter ssn autokey.
			export skip_set      := ['B'];  //skip business related autokeys
	  end;

    // Call the voter batch service to get the voter data
	  ds_voter_recs := VotersV2_Services.Batch_Service_Records(ds_voter_input,
											                                       mod_voter_config);
		
    // Filter to only keep A(ctive) and not ABSENTEE recs. req 4.1.35
		// Then sort/dedup to only keep 1 most recent (highest process_date and highest
		// lastdatevote) record per did.
		ds_voter_recs_kept := dedup(sort(ds_voter_recs(active_status = 'A' and
																									 Stringlib.StringToUpperCase(
																									   voter_status_exp) != 'ABSENTEE'),
		                                 did,-process_date,-LastDateVote,record),
	                              did);

     // Join input dataset to voter recs kept on did to re-attach acctnos and to
     // return all recs passed into this function, whether they had voter data or not.
		 ds_voter_data_returned := join(ds_batch_in_wdid, ds_voter_recs_kept, 
																			// need to match on did since all dids for an
																			// addr are returned by the voter batch service.
																			left.did = (unsigned) right.did,
																		transform(batchservices.TaxRefundISv3_BatchService_Layouts.rec_voter_res,       
																		  self.acctno    := left.acctno, // re-attach input acctno
																			self.voter_did := (unsigned) right.did,
																			self := right), // rest of fields right (voter data)
																		left outer // keep all input recs
																	 );

     // For debugging, uncomment lines below as needed
	   // output(ds_batch_in_wdid,       named('ds_batch_in_wdid'));
		 // output(ds_voter_input,         named('ds_voter_input'));
     // output(ds_voter_recs,          named('ds_voter_recs'));
		 // output(ds_voter_recs_kept,     named('ds_voter_recs_kept')); 
     // output(ds_voter_data_returned, named('ds_voter_data_returned')); 

		 return ds_voter_data_returned;

	end; // end of func_get_voter_data

	
  // *--- Functions related to getting Liens data ---* //
	EXPORT LJcleanName(string Name) := FUNCTION
				stripNameAnp := stringlib.stringfindreplace(Name,             '&',' ');
				stripNameSlash := stringlib.stringfindreplace(stripNameAnp,   '/',' ');
				stripDash := stringlib.stringfindreplace(stripNameSlash,          '-',' ');
				stripNamePeriod := stringlib.stringfindreplace(stripDash,     '.','');
				stripNameAppos := stringlib.stringfindreplace(stripNamePeriod,',','');
				nydeptof := stringlib.stringfindreplace(stripNamePeriod,'NYDEPTOF','NY DEPT OF');
				oftaxation := stringlib.stringfindreplace(stripNamePeriod,'OFTAXATION','OF TAXATION');
				cleanName := stringlib.StringToUpperCase(nydeptof);
				onespaceName := stringlib.StringCleanSpaces(cleanName);
		RETURN onespaceName;
	END; 
	
	EXPORT isCreditorState(string creditName) := FUNCTION
		RETURN LJcleanName(creditName) in BatchServices.Constants.TRISv3.creditorStateSet;
	END;
	
	EXPORT isStateLien(string OrigName) := FUNCTION
		RETURN LJcleanName(OrigName) in BatchServices.Constants.TRISv3.stateLienSet;
	END;
	
	EXPORT isLienReleased(string filingStatus) := FUNCTION
		RETURN LJcleanName(filingStatus) in BatchServices.Constants.TRISv3.lienReleasedSet;
	END;
	
  EXPORT LJoutputFilingState(string stateName) := FUNCTION
		stateUpper := stringlib.StringToUpperCase(stateName);
		stateDesc := if (codes.valid_st (stateUpper), codes.general.STATE_LONG(stateUpper), '');
		retVal := if (stateDesc <> '', stateDesc, stateUpper);
		RETURN retVal;
	END;
	
	// SHARED TRISv3out := BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_out;
  //SHARED TRISv3in_wDID  := BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in_wdid;
	
	// Tris 3.2 Enhancement : Since All 30 J&L fields are blanked out, this function will not be used, so commenting out....
  EXPORT rec_final getLienRecords(Dataset(rec_final) trisOut, Dataset(rec_in_wdid) trisIn, BatchServices.TaxRefundISv3_BatchService_Interfaces.Input args_in) := function

    LiensV2_Services.Batch_Layouts.batch_in fillinLien(trisIn l) := TRANSFORM
      self := l;    //self := []  intentionally left out so I know I'm assigning all the fields and there are no extra I missed.
 		  self.bdid := 0;
		  self.FEIN := '';
		  self.comp_name := '';	
		  self.addr := '';
    END;

    batch_in := project(trisIn,  fillinLien(left));

	  //==================================================================================
    // this below is all taken from JudgmentsAndLiens_BatchService before and after its call to LiensV2_Services.Batch_records()
    //==================================================================================

		//*********************************************************************
  	//if we knew application type for TRIS V3 we could remove global module.
		//*********************************************************************
		gm := AutoStandardI.GlobalModule();								
		batch_params		:= BatchShare.IParam.getBatchParams();
		jl_batch_params := module(project(batch_params, LiensV2_Services.IParam.batch_params, opt))
			export unsigned8 MaxResults   					:= 10000 : STORED('MaxResults');	
			export BOOLEAN no_did_append					 	:= FALSE : STORED('NoDIDAppend');
			export BOOLEAN no_bdid_append				 		:= FALSE : STORED('NoBDIDAppend');
			export UNSIGNED2 PenaltThreshold   			:= 10    : STORED('PenaltThreshold');
			INTEGER max_results_per_acct 						:= 100   : STORED('Max_Results_Per_Acct');
			export MaxResultsPerAcct 								:= 30    ;  //max 30
			export SET OF STRING1 party_types				:= ['D'] ;  //debtor only 
			export MatchName												:= FALSE : STORED('Match_Name');
			export MatchStrAddr											:= FALSE : STORED('Match_Street_Address');
			export MatchCity												:= FALSE : STORED('Match_City');
			export MatchState												:= FALSE : STORED('Match_State');  
			export MatchZip												  := FALSE : STORED('Match_Zip');   
			export MatchSSN												  := FALSE : STORED('Match_SSN'); 	
			export applicationType 									:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(gm,AutoStandardI.InterfaceTranslator.application_type_val.params));
		END;
		
		BatchShare.MAC_SequenceInput(batch_in, ds_batch_in);
		//get liens that match debtor up to 30	  
  	ds_batch_out := LiensV2_Services.Batch_records(ds_batch_in, jl_batch_params);
		// Restore original acctno and format to output layout.	
		BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_out, ds_batch_ready, false);	
		ds_JL_recs_flat := PROJECT(ds_batch_ready, LiensV2_Services.batch_make_flat(LEFT));		
		pre_result := SORT(ds_JL_recs_flat, acctno, penalt, -orig_filing_date, -release_Date, filing_jurisdiction, orig_filing_number);
		ut.mac_TrimFields(pre_result, 'pre_result', result);
	 //==================================================================================
   // end of code pulled from JudgmentsAndLiens_BatchService
   //                MATCH RULES   REQ 4.1.49	 
	 //==================================================================================

   result fillRule1(result L) := transform
	   self := L;
	 end;
	 
	 resultsRule1 := JOIN(result, trisIn, left.acctno = right.acctno and 
		                                    (((integer)left.debtor_1_party_1_did = right.did) or
																				 ((integer)left.debtor_1_party_2_did = right.did) or
																				 ((integer)left.debtor_2_party_1_did = right.did) or
																				 ((integer)left.debtor_2_party_2_did = right.did) or
																				 ((integer)left.debtor_3_party_1_did = right.did) or
																				 ((integer)left.debtor_3_party_2_did = right.did) or
																				 ((integer)left.debtor_4_party_1_did = right.did) or
																				 ((integer)left.debtor_4_party_2_did = right.did) or
																				 ((integer)left.debtor_5_party_1_did = right.did) or
																				 ((integer)left.debtor_5_party_2_did = right.did) or
																				 ((integer)left.debtor_6_party_1_did = right.did) or
																				 ((integer)left.debtor_6_party_2_did = right.did) or
																				 ((integer)left.debtor_7_party_1_did = right.did) or
																				 ((integer)left.debtor_7_party_2_did = right.did)
																				 ),	fillRule1(left));
 		  //rule 2
		inputValidCreditor := isCreditorState(args_in.Creditor) ;
		cleanCreditor := LJcleanName(args_in.Creditor);
		rule2recs := resultsRule1(((isCreditorState(creditor_cname) and inputValidCreditor) and 
		                           (LJcleanName(creditor_cname) = cleanCreditor))
		                            or 
															((isCreditorState(creditor_orig_name) and inputValidCreditor) and 
															 (LJcleanName(creditor_orig_name) = cleanCreditor))
														 );				 
    resultsRule2 := if (inputValidCreditor and (args_in.Creditor <> '') , rule2recs ,resultsRule1);		
 	  //rule 3 and 4          
		resultsRule3and4 := resultsRule2((isStateLien(orig_filing_type) or
																			isStateLien(filing_1_filing_type_desc) or
																			isStateLien(filing_2_filing_type_desc) or
																			isStateLien(filing_3_filing_type_desc) or
																			isStateLien(filing_4_filing_type_desc)
																			)
																		and 
																			((release_date < stringlib.GetDateYYYYMMDD()) or 
 																		   NOT (
																		     isLienReleased(filing_1_filing_type_desc) or
																				 isLienReleased(filing_2_filing_type_desc) or 
																				 isLienReleased(filing_3_filing_type_desc) or
																				 isLienReleased(filing_4_filing_type_desc) or
																				 isLienReleased(filing_status))
																			 )
																			);
			 // pull out all the field TRIS v3 is interested in 
		liensRulesApplied := project(resultsRule3and4, TRANSFORM(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_lien, 
		                                                         self.filing_jurisdiction_name := if (left.filing_jurisdiction_name = '', LJoutputFilingState(left.filing_jurisdiction),left.filing_jurisdiction_name),
																														 self := left));
		liensNormalized := sort(liensRulesApplied, acctno, -orig_filing_date);																						 
       // flatten the output, up to 30 liens and judgements.		
    liensFlat30 := denormalize(trisOut, liensNormalized, left.acctno = right.acctno, 
		                           BatchServices.TaxRefundISv3_BatchService_transforms.xfm_30_lien(left, right, counter)); 
    // DEBUG															 
	  // output(ds_batch_in,named('ds_batch_in'));
	  // output(ds_batch_out,named('ds_batch_out'));
	  // output(resultsRule1,named('resultsRule1'));
	  // output(resultsRule2,named('resultsRule2'));
	  // output(resultsRule3and4,named('resultsRule3and4'));
		
		RETURN liensFlat30;
  END; //end of getLienRecords function		
	*/	


	EXPORT getContribRecs (dataset(rec_final) recs_in, string in_DataPermissionMask) := FUNCTION
			contributory_key := tris_lnssi_build.key_field_value;

			dataPermissionTempMod := module (AutoStandardI.DataPermissionI.params)
				export dataPermissionMask := in_DataPermissionMask;
			end;
			boolean use_ContributoryData := AutoStandardI.DataPermissionI.val(dataPermissionTempMod).use_TrisContributoryData;
			
			slim_input_fields :=  record
				string30 acctno;
				string2	st	:= '';
				string200 isp_name1	:= '';
				string200 isp_name2	:= '';
				string200 isp_name3	:= '';
				string25 Contrib_Risk_field:='';
				string50 Contrib_Risk_Value:='';
				string Contrib_Risk_Attr:='';
				string Contrib_State_Excl:='';					
			end;

			slim_input_fields appendAcctNo(rec_final L, recordof(contributory_key) R) := transform
				self.Contrib_Risk_field := R.Contrib_Risk_field;
				self.Contrib_Risk_Value	:= R.Contrib_Risk_Value;
				self.Contrib_Risk_Attr  := R.Contrib_Risk_Attr;
				self.Contrib_State_Excl	:= R.Contrib_State_Excl;	
				self := L;
			end;
		
			contrib_recs_rtn := join(recs_in, contributory_key, 
																keyed(right.contrib_risk_field	= BatchServices.Constants.TRISv3.RTNbr) and 
																StringLib.StringToUpperCase(right.contrib_risk_value) = left.routing_transit_nbr,
																	appendAcctNo(left, right), limit(0), keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));
																									
			contrib_recs_abrn:= join(recs_in, contributory_key, 
																keyed(right.contrib_risk_field	= BatchServices.Constants.TRISv3.ARNbr) and
																StringLib.StringToUpperCase(right.contrib_risk_value) = left.aba_rout_nbr, 
																	appendAcctNo(left, right), limit(0), keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));
																									
			contrib_recs_prep:= join(recs_in, contributory_key, 
																keyed(right.contrib_risk_field	= BatchServices.Constants.TRISv3.PrepID) and
																StringLib.StringToUpperCase(right.contrib_risk_value) = left.prep_id2, 
																	appendAcctNo(left, right), limit(0), keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));

			contrib_recs_email:= join(recs_in, contributory_key, 
																keyed(right.contrib_risk_field	= BatchServices.Constants.TRISv3.EmailAdd) and 
																StringLib.StringToUpperCase(right.contrib_risk_value) = left.email_address, 
																	appendAcctNo(left, right), limit(0), keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));
																									
			contrib_recs_isp	:= join(recs_in, contributory_key, 
																keyed(right.contrib_risk_field	= BatchServices.Constants.TRISv3.ISPName OR
																			right.contrib_risk_field	= BatchServices.Constants.TRISv3.ISPName2 OR
																			right.contrib_risk_field	= BatchServices.Constants.TRISv3.ISPName3)
																AND 
																(StringLib.StringToUpperCase(right.contrib_risk_value) = StringLib.StringToUpperCase(left.isp_name1) OR 
																 StringLib.StringToUpperCase(right.contrib_risk_value) = StringLib.StringToUpperCase(left.isp_name2) OR 
																 StringLib.StringToUpperCase(right.contrib_risk_value) = StringLib.StringToUpperCase(left.isp_name3)),
																	appendAcctNo(left, right), limit(0), keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));

			contrib_recs := contrib_recs_rtn + contrib_recs_abrn + contrib_recs_prep + contrib_recs_email + contrib_recs_isp;
			
			contrib_recs_to_return := if(	use_ContributoryData, 
																		contrib_recs(st not in [Std.Str.SplitWords(contrib_state_excl,',')] and contrib_risk_value <> ''), 
																		dataset([], slim_input_fields)); 
		
			pre_contrib_recs:= dedup(sort(contrib_recs_to_return,acctno,(contrib_risk_field	= BatchServices.Constants.TRISv3.RTNbr), 
																																	(contrib_risk_field	= BatchServices.Constants.TRISv3.ISPName),
																																	(contrib_risk_field	= BatchServices.Constants.TRISv3.ARNbr), 
																																	(contrib_risk_field	= BatchServices.Constants.TRISv3.PrepID),
																																	(contrib_risk_field	= BatchServices.Constants.TRISv3.EmailAdd)), 
																acctno, contrib_risk_value);
			
			rec_final deNorm (rec_final L, slim_input_fields R, INTEGER C) := transform
				self.Contrib_Risk_Field1	:= if(C=1, R.Contrib_Risk_field, L.Contrib_Risk_field1);
				self.Contrib_Risk_Value1 	:= if(C=1, R.Contrib_Risk_Value, L.Contrib_Risk_Value1);
				self.Contrib_Risk_Attr1		:= if(C=1, R.Contrib_Risk_Attr, L.Contrib_Risk_Attr1);

				self.Contrib_Risk_Field2  := if(C=2, R.Contrib_Risk_field, L.Contrib_Risk_Field2);
				self.Contrib_Risk_Value2  := if(C=2, R.Contrib_Risk_Value, L.Contrib_Risk_Value2);
				self.Contrib_Risk_Attr2 	:= if(C=2, R.Contrib_Risk_Attr, L.Contrib_Risk_Attr2);

				self.Contrib_Risk_Field3  := if(C=3, R.Contrib_Risk_field, L.Contrib_Risk_Field3);
				self.Contrib_Risk_Value3  := if(C=3, R.Contrib_Risk_Value, L.Contrib_Risk_Value3);
				self.Contrib_Risk_Attr3		:= if(C=3, R.Contrib_Risk_Attr, L.Contrib_Risk_Attr3);
				self := L;
			end;

			final_recs_flat := denormalize(recs_in , pre_contrib_recs,
																			left.acctno = right.acctno,
																			deNorm(left, right, counter));
		return final_recs_flat;
	END;	

	
	//*******************************************************************************************
	//***********   V3_1  FILTER   ****************************************************************
	//*******************************************************************************************

	string30 v3_1Filter(string10 curr_incar_flag, string10 curr_incar_flag_BestSSN,string10 act_rel_date_1,
											string10 ctrl_rel_date_1,string10 sch_rel_dt_1,string10 act_rel_dt_1_BestSSN,
											string10 ctl_rel_dt_1_BestSSN,string10 sch_rel_dt_1_BestSSN,string10 Input_Address_Prison,
											string10 DOD, string10 deceased_matchcode,string10 score, string10 VariationSSNCount,
											string10 IdentityRecordCount,string10 addr_outside_of_agency_state,string10 IDVerSSN,
											string10 Best_SSN, string10 InputAddrRel,string10 possible_age_dob,
											string10 possible_age_ssn_issuance,string10 LexID ,
											string10 DivSSNLNameCount, string10 IDVerName,string10 ValidationAddrProblems, 
											string10 InputAddrFelonyCount, string10 InputAddrDwellType, string10 IDVerAddress, 
											string10 InputAddrDate, string10 MatchedInputAddr, string10 DivAddrIdentityCount,
											string10 DivAddrIdentityCountNew,	string10 InputAddrZipDate, string10 BestAddrChangeDistance,
											string10 InputAddrState, string10 ValidationIPProblems,string10 IPAddrExceedsInputAdd,
											string10 phone_number_1, string10 Refund_Amount, 
											string10 scorecut, unsigned3 RefundThreshold, string20 modelname, string50 filing_jurisdiction_01) 
						         := FUNCTION; 

		boolean lienFound    := filing_jurisdiction_01 <> '';
		string8 today        := StringLib.getdateYYYYMMDD();
		integer2 CurrentYear := (INTEGER4)(today[1..4]);
		integer2 CYearMinus1 := CurrentYear -1;
		boolean isDOD        := DOD <> ''; 
		integer2 dodYear     := if (isDOD, (INTEGER2)dod[1..4], 0);
		boolean isDOD_greater_2_years := isDOD and ((CYearMinus1 - dodYear) >= 2);

		SET OF INTEGER2 SetRelDates := [(integer2)act_rel_date_1[1..4],(integer2)ctrl_rel_date_1[1..4], (integer2)sch_rel_dt_1[1..4]];	
		SET OF INTEGER2 setRelBestDates := [(integer2)act_rel_dt_1_BestSSN[1..4], (integer2)ctl_rel_dt_1_BestSSN[1..4],(integer2)sch_rel_dt_1_BestSSN[1..4]];
		
		UNSIGNED2 scoreNum    := (unsigned2) score;
		UNSIGNED2 scoreCutNum := (unsigned2) scoreCut;
		
		boolean scoreFailed    := (scoreNum <= scoreCutNum) or (modelname = '') or (scoreCutNum = 0);
		boolean noInputRelAddr := InputAddrRel = 'N';
		set of string2 set15to21 := ['15','16','17','18','19','20','21'];
		boolean dobAge15to21   := possible_age_dob in set15to21 ;
		boolean ssnAge15to21   := possible_age_ssn_issuance in set15to21;
		//====================   R  U  L  E  S      ===========================================================================
		boolean isCrimManual1 :=  stringlib.StringToUpperCase(curr_incar_flag) ='Y'  OR 
															stringlib.StringToUpperCase(curr_incar_flag_BestSSN) ='Y';
		boolean isCrimManual2 := stringlib.stringcontains(deceased_matchcode,'SN',true) and isDOD_greater_2_years;

		boolean isCrimRisk1 := curr_incar_flag in ['U','N'] AND CYearMinus1 in SetRelDates AND Input_Address_Prison = 'Y' AND scoreFailed;
		boolean isCrimRisk2 := curr_incar_flag_BestSSN in['U','N'] AND CYearMinus1 in setRelBestDates AND Input_Address_Prison = 'Y' AND 
													 scoreFailed;
		boolean isCrimRisk3 := curr_incar_flag  in ['U','N'] AND CYearMinus1 in SetRelDates AND scoreFailed;
		boolean isCrimRisk4 := curr_incar_flag_BestSSN in ['U','N'] AND CYearMinus1 in setRelBestDates AND scoreFailed; 
		boolean isCrimRisk5 := deceased_matchcode ='S'; 
		//==================
		boolean isCrimRiskQuiz := isCrimRisk1 or isCrimRisk2 or isCrimRisk3 or isCrimRisk4 or isCrimRisk5; 

		//==================
	
		boolean isIdRisk1  := (integer)VariationSSNCount >= (integer)'3';
		boolean isIdRisk2  := VariationSSNCount = '2' AND scoreFailed;
		boolean isIdRisk3  := (integer)IdentityRecordCount >= (integer)'4';
		boolean isIdRisk4  := IdentityRecordCount = '2' AND addr_outside_of_agency_state = 'OS';
		boolean isIdRisk5  := IdentityRecordCount = '2' AND scoreFailed;
		//=============================================================== 
		boolean isIdRiskQuiz1	:= isIdRisk1 or isIdRisk2 or isIdRisk3 or isIdRisk4 or isIdRisk5;

		boolean isIdRisk6  := IDVerSSN in ['0','1','2','3'] AND lienFound ; 
		boolean isIdRisk10 := Best_SSN <> '' AND lienFound;
		//===================
		boolean isIdRiskDebt := isIdRisk6 or isIdRisk10;

		boolean isIdRiskQuiz3  := IDVerSSN in ['0','1','2','3'] AND ~lienFound ; 
		//====================
		boolean isIDRiskDivQuiz  := ((possible_age_dob = ''	and possible_age_ssn_issuance = '')	OR NOT (dobAge15to21 OR ssnAge15to21))
																 AND
																((LexID = '' AND  noInputRelAddr));

		boolean isIdRisk15 := (integer)DivSSNLNameCount >= (integer)'3';
		boolean isIdRisk16 := DIVSSNLNameCount = '2' AND scoreFailed;
		boolean isIdRisk17 := Best_SSN <> '' AND ~lienFound AND scoreFailed;
		boolean isIdRisk18 := IDVerName = '0';
		//===================
		boolean isIdRiskQuiz2 := isIdRisk15 or isIdRisk16 or isIdRisk17 or isIdRisk18; 

		boolean isAddrRiskValid  := ValidationAddrProblems = '3';
		boolean isAddrRiskFelony := (integer)InputAddrFelonyCount >= (integer)'3' AND InputAddrDwellType in ['R','S'];
		boolean isAddrRiskId     := (IDVerAddress = '0' OR InputAddrZipDate = '') AND MatchedInputAddr <> 'Y' AND InputAddrRel = 'N'; 
		boolean isAddrRiskDivCnt := (integer)DivAddrIdentityCount >= (integer)'100' AND scoreFailed;     
		boolean isAddrRiskDivNew := (integer)DivAddrIdentityCountNew >= (integer)'20' AND scoreFailed; 
		boolean isAddrRiskProb   := ValidationAddrProblems = '4' AND scoreFailed; 
		boolean isAddrRiskZipDate:= InputAddrZipDate = '';
		boolean isAddrRiskDist   := (integer)BestAddrChangeDistance >= (integer)'50'; 
		boolean isAddrRiskSt     := InputAddrState = 'N' AND scoreFailed;
		//=========================
		boolean isAddrRiskQuiz    := isAddrRiskValid or isAddrRiskFelony or isAddrRiskId or isAddrRiskDivCnt or isAddrRiskDivNew or 
																 isAddrRiskProb or isAddrRiskZipDate or isAddrRiskDist or isAddrRiskSt;

		boolean isIPrisk       := ValidationIPProblems = '1' ;
		boolean isIPaddrRisk   := IPAddrExceedsInputAdd = 'Y' ;
		boolean isTechRiskAge  := (possible_age_dob <> '') and (integer)possible_age_dob <= (integer)'50' AND phone_number_1 = '' AND scoreFailed;
		boolean isTechRiskSSn  :=  if (((possible_age_dob = '') and (possible_age_ssn_issuance <>'')),((integer)possible_age_ssn_issuance <= (integer)'50') AND phone_number_1 = '' AND scoreFailed, FALSE); 
		//=================
		boolean isTechRiskQuiz     := isIPrisk or isIPaddrRisk or isTechRiskAge or isTechRiskSSn;													
		boolean isRefundManual := ((unsigned3)Refund_Amount >= RefundThreshold) and (RefundThreshold <> 0); 
	 
		//MAP picks the first assignment that is TRUE so the order is important.				
		string30 identity_filter := MAP( isCrimManual1   => 'Manual Review',
																		 isCrimManual2   => 'Manual Review',
																		 isCrimRiskQuiz  => 'Quiz',
																		 isIdRiskQuiz1   => 'Quiz',
																		 isIdRiskDebt    => 'Debt Evasion',
																		 isIdRiskQuiz3   => 'Quiz',
																		 isIDRiskDivQuiz => 'Diversionary Quiz',
																		 isIdRiskQuiz2   => 'Quiz',
																		 isAddrRiskQuiz  => 'Quiz',
																		 isTechRiskQuiz  => 'Quiz',
																		 isRefundManual  => 'Manual Review',  					    
																		 'No Quiz');																				
		return identity_filter;
	end;
	
	string30 v3fdn_Filter(string10 curr_incar_flag, string10 curr_incar_flag_BestSSN,string10 act_rel_date_1,
												string10 ctrl_rel_date_1,string10 sch_rel_dt_1,string10 act_rel_dt_1_BestSSN,
												string10 ctl_rel_dt_1_BestSSN,string10 sch_rel_dt_1_BestSSN,string10 Input_Address_Prison,
												string10 DOD, string10 deceased_matchcode,string10 score, string10 VariationSSNCount,
												string10 IdentityRecordCount,string10 addr_outside_of_agency_state,string10 IDVerSSN,
												string10 Best_SSN, string10 InputAddrRel,string10 possible_age_dob,
												string10 possible_age_ssn_issuance,string10 LexID ,
												string10 DivSSNLNameCount, string10 IDVerName,string10 ValidationAddrProblems, 
												string10 InputAddrFelonyCount, string10 InputAddrDwellType, string10 IDVerAddress, 
												string10 InputAddrDate, string10 MatchedInputAddr, string10 DivAddrIdentityCount,
												string10 DivAddrIdentityCountNew,	string10 InputAddrZipDate, string10 BestAddrChangeDistance,
												string10 InputAddrState, string10 ValidationIPProblems,string10 IPAddrExceedsInputAdd,
												string10 phone_number_1, string10 Refund_Amount,
												string10 scorecut, unsigned3 RefundThreshold, string20 modelname, string50 filing_jurisdiction_01,
												string1 address_risk,string1 identity_risk,boolean FDN_ID_Risk,string4 hri_1_code,string4 hri_2_code,
												string4 hri_3_code,string4 hri_4_code, string8 in_event_dt_1) := FUNCTION; 

		boolean lienFound									:= filing_jurisdiction_01 <> '';
		string8 today											:= StringLib.getdateYYYYMMDD();
		string10 curr_u_incar_flag				:= stringlib.StringToUpperCase(curr_incar_flag);
		string10 curr_u_incar_flag_BestSSN:= stringlib.StringToUpperCase(curr_incar_flag_BestSSN);
		integer2 CurrentYear 							:= (INTEGER4)(today[1..4]);
		integer2 CYearMinus1 							:= CurrentYear -1;
		integer2 CYearMinus5 							:= CurrentYear -5;
		integer2 AddrDtYr    							:= (INTEGER2)(InputAddrDate[1..4]);
		boolean isDOD        							:= DOD <> ''; 
		integer2 dodYear     							:= if (isDOD, (INTEGER2)dod[1..4], 0);
		boolean isDOD_greater_2_years 		:= isDOD and ((CYearMinus1 - dodYear) >= 2);
		boolean Hri71        							:= hri_1_code = '71' or hri_2_code ='71' or hri_3_code = '71' or hri_4_code ='71';

		SET OF INTEGER2 SetRelDates 			:= [(integer2)act_rel_date_1[1..4],(integer2)ctrl_rel_date_1[1..4], (integer2)sch_rel_dt_1[1..4]];	
		SET OF INTEGER2 setRelBestDates   := [(integer2)act_rel_dt_1_BestSSN[1..4],	(integer2)ctl_rel_dt_1_BestSSN[1..4],(integer2)sch_rel_dt_1_BestSSN[1..4]];
		// SET OF INTEGER2 set_Rel_Dates 	:= [(integer2)act_rel_date_1[1..4],(integer2)act_rel_dt_1_BestSSN[1..4]];
	
		boolean noInputRelAddr	:= InputAddrRel = 'N';
		set of string2 set15to21:= ['15','16','17','18','19','20','21'];
		boolean dobAge15to21   	:= possible_age_dob in set15to21 ;
		boolean ssnAge15to21   	:= possible_age_ssn_issuance in set15to21;
		//====================   R  U  L  E  S      ===========================================================================
		
		//====================== v3.1 1.8.3 & appendix cond B==========================================================================
		//====================== Revised logic for "isincarcerated2" as required in TRIS v3.2 Enhancement project, Requirement # 3.1.9============
		boolean isincarcerated1 := curr_u_incar_flag ='Y'  OR curr_u_incar_flag_BestSSN ='Y';
		boolean isincarcerated2 := (curr_u_incar_flag in ['U','N'] OR curr_u_incar_flag_BestSSN in['U','N']) AND 
															 ((integer2)act_rel_date_1[1..4] > CYearMinus1 OR (integer2)ctl_rel_dt_1_BestSSN[1..4] > CYearMinus1) AND
															 ((integer2)in_event_dt_1[1..4] < CYearMinus1);
		
		boolean isDeceased 	:= stringlib.stringcontains(deceased_matchcode,'SN',true) and isDOD_greater_2_years;
		boolean isCrimRisk1 := Input_Address_Prison = 'Y';
		boolean isCrimRisk2 := deceased_matchcode ='S'; 
		
		boolean isincarcerated := isincarcerated1 or isincarcerated2;
		boolean isCrimRisk     := isCrimRisk1 or isCrimRisk2; 
		
		//=========================== v3.1 req 1.4.2 & appendix cond C ===========================================================
		boolean isIdRiskv1  := (integer)VariationSSNCount > 4; // v3.1 req 1.4.2 & 1.10																	
		boolean isIdRiskv2  := (integer)IdentityRecordCount > 4;													
		boolean isIDRiskv3  := (LexID = '' AND Hri71 AND noInputRelAddr);
		boolean isIDRisk1   := identity_risk = 'Y';
																	
		boolean isIDRisk := isIdRiskv1 OR isIdRiskv2 OR isIDRiskv3 OR isIDRisk1;
	
		//=========================== v3.1 req 1.4.1 & appendix cond D ===============================
		boolean isAddrRiskFelony 	:= (integer)InputAddrFelonyCount > 3 AND InputAddrDwellType in ['R','S'];
		boolean isAddrRiskId     	:= InputAddrDate = '' AND MatchedInputAddr <> 'Y' AND noInputRelAddr; 
		boolean isAddrRiskZipDate := InputAddrDate <> '' AND AddrDtYr < CYearMinus5 AND noInputRelAddr;
		boolean isAddrRiskDivNew 	:= (integer)DivAddrIdentityCountNew >= 10 AND InputAddrDwellType <> 'H';
		boolean isAddrRiskProb   	:= ValidationAddrProblems = '4'; 
		// boolean isAddrRiskDist	:= (integer)BestAddrChangeDistance >= 100; 
		boolean isAddrRisk1       := address_risk = 'Y';
		boolean isAddrRisk				:= isAddrRiskFelony or 
																 isAddrRiskId or 
																 isAddrRiskDivNew or 
																 isAddrRiskProb or 
																 isAddrRiskZipDate or 
																 isAddrRisk1;  //isAddrRiskQuiz or isAddrRiskDist
		//=========================== appendix cond E ===============================================================
		boolean isIPrisk			:= ValidationIPProblems = '1' ;
		boolean isIPaddrRisk	:= IPAddrExceedsInputAdd = 'Y' ;
		boolean isTechRisk		:= isIPrisk or isIPaddrRisk;													
		
		//MAP picks the first assignment that is TRUE so the order is important.				
		string30 risk_status := MAP(isincarcerated  => 'INCARCERATED',
																isDeceased      => 'DECEASED',
																isCrimRisk      => 'HIGH RISK',
																isIDRisk        => 'HIGH RISK',
																isAddrRisk      => 'HIGH RISK',
																isTechRisk      => 'HIGH RISK',				    
																'LOW RISK');				  
		return risk_status;
	end;
	
	// The main filter. 
		// - This calls the required filter function. 
		// - In the future, there will be more than one filters. 
		// - This returns the result batch or nothing.
	// 
	export MainFilter(dataset(rec_final) batch_res_before_filter, 
										BatchServices.TaxRefundISv3_BatchService_Interfaces.Input args_in ):=	function
									
		// for default and version v3					
		rec_final xformBatchOut( rec_final l) := TRANSFORM
			self.output_status :=	if(l.output_status = '', 
																v3_1Filter( l.curr_incar_flag, l.curr_incar_flag_BestSSN,l.act_rel_dt_1,l.ctl_rel_dt_1,l.sch_rel_dt_1,l.act_rel_dt_1_BestSSN,
																				l.ctl_rel_dt_1_BestSSN,l.sch_rel_dt_1_BestSSN,l.InputAddrPrison,l.DOD,l.deceased_matchcode,l.score,
																				l.VariationSSNCount,l.DivSSNIdentityCount,l.address_outside_of_agency_state,l.IDVerSSN,l.Best_SSN,
																				l.InputAddrRel,l.possible_age_dob,l.possible_age_ssn_issuance,l.did,
																				l.DivSSNLNameCount,l.IDVerName,l.ValidationAddrProblem,l. InputAddrFelonyCount,l.InputAddrDwellType,l.IDVerAddress,
																				l.InputAddrDate,l.MatchedInputAddr,l.DivAddrIdentityCount,l.DivAddrIdentityCountNew,l.InputAddrZipDate,
																				l.BestAddrChangeDistance,l.InputAddrState,l.ValidationIPProblems, l.IPAddrExceedsInputAddr,l.phone_number,
																				l.Refund_Amount, args_in.scorecut, args_in.RefundThreshold, args_in.modelname, l.filing_jurisdiction_01),
																l.output_status); 
			self := l;
			self := [];
		END;

		v3_1Filter_res	:=  project(batch_res_before_filter, xformBatchOut(left));

		// for version v3.1 with fdn
		rec_final v31fdnBatchOut( rec_final l) := TRANSFORM
		self.risk_status :=  if (l.output_status = '', 
														 v3fdn_Filter(l.curr_incar_flag, l.curr_incar_flag_BestSSN,l.act_rel_dt_1,l.ctl_rel_dt_1,l.sch_rel_dt_1,l.act_rel_dt_1_BestSSN,
																					l.ctl_rel_dt_1_BestSSN,l.sch_rel_dt_1_BestSSN,l.InputAddrPrison,l.DOD,l.deceased_matchcode,l.score,
																					l.VariationSSNCount,l.DivSSNIdentityCount,l.address_outside_of_agency_state,l.IDVerSSN,l.Best_SSN,
																					l.InputAddrRel,l.possible_age_dob,l.possible_age_ssn_issuance,l.did,
																					l.DivSSNLNameCount,l.IDVerName,l.ValidationAddrProblem,l. InputAddrFelonyCount,l.InputAddrDwellType,l.IDVerAddress,
																					l.InputAddrDate,l.MatchedInputAddr,l.DivAddrIdentityCount,l.DivAddrIdentityCountNew,l.InputAddrZipDate,
																					l.BestAddrChangeDistance,l.InputAddrState,l.ValidationIPProblems, l.IPAddrExceedsInputAddr,l.phone_number,
																					l.Refund_Amount, args_in.scorecut, args_in.RefundThreshold, args_in.modelname, l.filing_jurisdiction_01,l.address_risk,l.identity_risk,
																					l.fdn_id_risk, l.hri_1_code, l.hri_2_code, l.hri_3_code, l.hri_4_code, l.in_event_dt_1),
															l.output_status); 
			self := l;
		END;
			
		v3fdn_Filter_res    		 :=  project(batch_res_before_filter, v31fdnBatchOut(left));
		
		batch_res_after_filter :=  map(StringLib.StringToUpperCase(args_in.FilterRule)='V3FDN_FILTER' => v3fdn_Filter_res, 
																	 StringLib.StringToUpperCase(args_in.FilterRule)='V3_FILTER' => v3_1Filter_res, 
																	 batch_res_before_filter); 
		
		return batch_res_after_filter;
	end;

END;