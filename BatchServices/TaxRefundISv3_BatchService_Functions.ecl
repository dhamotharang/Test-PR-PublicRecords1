IMPORT AddrBest, Address, Address_Attributes, Autokey_batch, AutoStandardI, 
       batchservices, BatchShare, CriminalRecords_BatchService, Didville, Gateway, Models, 
			 NID, progressive_phone, Risk_Indicators, Std, tris_lnssi_build;

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
		// TRIS v3.2.1 Enhancement: Updated HRI codes per Req 4.1.4 (remove S5)
		aRisk2 := IF(allFieldsBlank, '11,14', aRisk);
		iRisk2 := IF(allFieldsBlank, '03,72,IS,QD,QA,QE,BO,S2,S1',iRisk);
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

      // *--- DEBUG ---* //
			//output(ds_batch_in, named('fnccb_ds_batch_in'));
 			//output(ds_batch_clean, named('fnccb_ds_batch_clean'));
			
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
				export ReturnLatLong        				:= TRUE; // added for TRISv3.0.1 2015 enhancement
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
        self.hasInputAddr  := L.hasInputAddr or R.hasInputAddr;
        self.InputAddrDate := map(L.hasInputAddr => L.InputAddrDate,
                                  R.hasInputAddr => R.InputAddrDate,
                                  '');
        self.InputAddrFirstSeen :=	map(L.hasInputAddr => L.InputAddrFirstSeen,
																				R.hasInputAddr => R.InputAddrFirstSeen,
																				'');
        self.InputAddrLastSeen :=		map(L.hasInputAddr => L.InputAddrLastSeen,
																				R.hasInputAddr => R.InputAddrLastSeen,
																				'');																	
        leftZipDate  := if (L.InputZipMatch, l.InputZipMatchDate,'');
				rightZipDate := if (R.InputZipMatch, R.InputZipMatchDate,''); 
        self.InputZipMatchDate	:= max(leftZipDate, rightZipDate);																
        self.InputZipMatch	 := L.InputZipMatch or R.InputZipMatch;	
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
											 paroleFlag    = 'Y' => 2,
											 incarFlag     = 'Y' => 3,
											 probationFlag = 'U' => 4,
											 paroleFlag    = 'U' => 5,
											 incarFlag     = 'U' => 6,
											 probationFlag = 'N' => 7,
											 paroleFlag    = 'N' => 8,
											 incarFlag     = 'N' => 9,
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
													(left.data_type  = BatchServices.Constants.TRISV3.Data_Type_1 or 
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

      // *--- DEBUG ---* //
			//output(in_clean_batch, named('gcr_in_clean_batch'));
		  //output(crim_batch,     named('gcr_crim_batch'));
		  //output(crim_res_all,   named('gcr_crim_res_all'));
		  //output(crim_res,       named('gcr_crim_res'));
		  //output(filt_crim_res,  named('gcr_filt_crim_res'));
		  //output(filt_crim_res_w_dates, named('gcr_filt_crim_res_w_dates'));
		  //output(filt_crim_res_sorted,  named('gcr_filt_crim_res_sorted'));
																												
		return filt_crim_res_sorted;
	end;

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


 // *--- Function to get HRI Address/"prison" info ---* //
  export getHRIRecords(dataset(rec_in_wdid) ds_in_clnbatch_wdid) := function

      // *** Tris v3.2.2, 2018-04-10 RR-12192 InputAddrPrison=Y determination logic enhancement
      rec_inaddrs_with_keyfields := record
        string4   pseudo_sic_code;
        string120 company_name;
        rec_in_wdid;
      end;

      // Join input addresses to Risk Indicators (Business Header) HRI address_to_sic_QA Key
      // and filter for key sic_code='2225' 
      // NOTE: '2225' is not really a "sic_code", but it is a "pseudo" internal sic_code.
      //       (see Risk_Indicators.HRI_Businesses clean1:= ... for more info)
      ds_inaddrs_onhrikey2225 := join(ds_in_clnbatch_wdid, Risk_Indicators.key_HRI_Address_To_SIC,
												              keyed(left.z5          = right.z5         and 
												                    left.prim_name   = right.prim_name  and 
												                    left.addr_suffix = right.suffix     and 
												                    left.predir      = right.predir     and
												                    left.postdir     = right.postdir    and
												                    left.prim_range  = right.prim_range and  
												                    left.sec_range   = right.sec_range)     
												              AND 
 												                right.sic_code = BatchServices.Constants.TRISV3.Correctional_Institution, // '2225'
												              transform(rec_inaddrs_with_keyfields,
												                self.pseudo_sic_code := right.sic_code,
                                        self.company_name    := right.company_name,
													              self                 := left),
												              inner, 
                                      limit(0),
												              keep(10)); // might be more than 1 '2225' code per address

      // Next filter using STRINGFIND to look for certain "non-prison name" terms in the 
			// 'company_name' field of the address matched/'2225' key recs and only keep the 
			// record if any of these terms DO NOT exist.
      ds_outrecs_filt := ds_inaddrs_onhrikey2225(
			                        // Only keep records if they DO NOT contain certain terms
															// Law Enforcement related non-prison/jail name terms
															STD.str.Find(company_name,' PD',1)=0            AND //must have space b4 the "PD"
															STD.str.Find(company_name,'POLICE',1)=0         AND 
                              STD.str.Find(company_name,'MARSHAL OF',1)=0     AND
                              STD.str.Find(company_name,'MARSHALS OF',1)=0    AND
                              STD.str.Find(company_name,'MARSHAL\'S OF',1)=0  AND
                              STD.str.Find(company_name,'TROOPERS',1)=0       AND
                              STD.str.Find(company_name,'TRPRS',1)=0          AND
                              //Other non-Law Enforcement name terms
                              STD.str.Find(company_name,'ASSOC',1)=0          AND //covers ASSOC, ASSOCIATES & ASSOCIATION
                              STD.str.Find(company_name,'ASSN',1)=0           AND
                              STD.str.Find(company_name,' BOARD',1)=0         AND //must have space b4 the beginning "B"
															STD.str.Find(company_name,'CHAPLAIN',1)=0       AND //covers CHAPLAIN(S) & CHAPLAINCY
														  STD.str.Find(company_name,'CHAPTER',1)=0        AND
                              STD.str.Find(company_name,'COMMISSION',1)=0     AND
                              STD.str.Find(company_name,'CONSULT',1)=0        AND //covers CONSULTANT(S) & CONSULTING 
                              STD.str.Find(company_name,'FEDERATION',1)=0     AND
                              STD.str.Find(company_name,'FOUNDATION',1)=0     AND
                              STD.str.Find(company_name,'JAIL BUILDING',1)=0  AND
                              STD.str.Find(company_name,' MINIST',1)=0        AND //must have space b4 the beginning "M", covers MINISTRIES, MINISTRY & "... MINIST"
															STD.str.Find(company_name,'OUTREACH',1)=0       AND
                              STD.str.Find(company_name,'VA CTR',1)=0         AND 
                              STD.str.Find(company_name,'VETERAN',1)=0
                            ); 

	    //OUTPUT(ds_in_clnbatch_wdid,     NAMED('funcs_ds_in_clnbatch_wdid'));
	    //OUTPUT(ds_inaddrs_onhrikey2225, NAMED('funcs_ds_inaddrs_onhrikey2225'));
			//OUTPUT(ds_outrecs_filt,         NAMED('funcs_ds_outrecs_filt'));

			return ds_outrecs_filt;
			
  end;	


  // *--- Function to get SSNIssuance issued start date ---* //
  export getSSNIssuanceRecords(dataset(rec_final) in_data) := function
  
			//Tris 3.2 Enhancement : Per req 3.1.10, removing possible_age_dob = '' condition and 
			// project to SSNIssuance batch input layout (acctno + ssn)
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
          export boolean doParo_attrs         := false;
          export string requestedattributegroups := '';
		end;

		wModel := Models.FraudAdvisor_Batch_Service_Records(InputArgs,batch_in_FP,
																												Gateway.Constants.void_gateway);

    ds_wModel_slimmed := project(wmodel,
                            BatchServices.TaxRefundISv3_BatchService_Layouts.rec_fp_res_slim);

    // *--- DEBUG ---* //
		//output(wModel,            named('fnccfp2_wModel'));
    //output(ds_wModel_slimmed, named('fnccfp2_ds_wModel_slimmed'));

		return ds_wModel_slimmed;
	end;

	EXPORT getContribRecs (dataset(rec_final) recs_in, string in_DataPermissionMask) := FUNCTION

			contributory_key := tris_lnssi_build.key_field_value;

			dataPermissionTempMod := module (AutoStandardI.DataPermissionI.params)
				export dataPermissionMask := in_DataPermissionMask;
			end;
			boolean use_ContributoryData := 
			        AutoStandardI.DataPermissionI.val(dataPermissionTempMod).use_TrisContributoryData;
			
			slim_input_fields :=  record
				string30  acctno;
				string2	  st	:= '';
				string200 isp_name1	:= '';
				string200 isp_name2	:= '';
				string200 isp_name3	:= '';
				string25  Contrib_Risk_field :='';
				string50  Contrib_Risk_Value :='';
				string    Contrib_Risk_Attr  :='';
				string    Contrib_State_Excl :='';					
			end;

			slim_input_fields appendAcctNo(rec_final L, recordof(contributory_key) R) := transform
				self.Contrib_Risk_field := R.Contrib_Risk_field;
				self.Contrib_Risk_Value	:= R.Contrib_Risk_Value;
				self.Contrib_Risk_Attr  := R.Contrib_Risk_Attr;
				// Due to tris "contributory" key data inconsistencies, just to be safe in the state
				// exclusion field, remove any imbedded space and convert lowercase to uppercase .
				self.Contrib_State_Excl	:= Std.Str.ToUpperCase(trim(R.Contrib_State_Excl,ALL));
				self := L;
			end;
		
			contrib_recs_rtn  := join(recs_in, contributory_key, 
																keyed(right.contrib_risk_field	= BatchServices.Constants.TRISv3.RTNbr) and 
																Std.Str.ToUpperCase(right.contrib_risk_value) = left.routing_transit_nbr,
																	appendAcctNo(left, right), limit(0), 
																	keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));
																									
			contrib_recs_abrn := join(recs_in, contributory_key, 
																keyed(right.contrib_risk_field	= BatchServices.Constants.TRISv3.ARNbr) and
																Std.Str.ToUpperCase(right.contrib_risk_value) = left.aba_rout_nbr, 
																	appendAcctNo(left, right), limit(0), 
																	keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));
																									
			contrib_recs_prep := join(recs_in, contributory_key, 
																keyed(right.contrib_risk_field	= BatchServices.Constants.TRISv3.PrepID) and
																Std.Str.ToUpperCase(right.contrib_risk_value) = left.prep_id2, 
																	appendAcctNo(left, right), limit(0), 
																	keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));

			contrib_recs_email := join(recs_in, contributory_key, 
																 keyed(right.contrib_risk_field	= BatchServices.Constants.TRISv3.EmailAdd) and 
																 Std.Str.ToUpperCase(right.contrib_risk_value) = left.email_address, 
																	 appendAcctNo(left, right), limit(0), 
																	 keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));
			
      contrib_recs_isp2 := 
			   join(recs_in, contributory_key, 
							keyed(right.contrib_risk_field = BatchServices.Constants.TRISv3.ISPName2) AND
						  (Std.Str.ToUpperCase(right.contrib_risk_value) = 
						                                             Std.Str.ToUpperCase(left.isp_name2)),
							appendAcctNo(left, right), 
							limit(0), keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));
			
			contrib_recs_isp3 := 
			   join(recs_in, contributory_key, 
							keyed(right.contrib_risk_field = BatchServices.Constants.TRISv3.ISPName3) AND
						  (Std.Str.ToUpperCase(right.contrib_risk_value) = 
						                                             Std.Str.ToUpperCase(left.isp_name3)),
							appendAcctNo(left, right), 
							limit(0), keep(BatchServices.Constants.TRISv3.Contributory_Rec_Join_Limit));


			contrib_recs := contrib_recs_rtn  + contrib_recs_abrn  + 
                      contrib_recs_prep + contrib_recs_email + 
											contrib_recs_isp2 + contrib_recs_isp3;
			
			contrib_recs_to_return := 
			   if(use_ContributoryData, 
						contrib_recs(st not in [Std.Str.SplitWords(contrib_state_excl,',')] and 
						             contrib_risk_value <> ''), 
						dataset([], slim_input_fields)); 
		
			// Return in a certain order as specified by the product manager via a 12/07/17 email
			// for the RQ-13866 changes.
			pre_contrib_recs:= sort(contrib_recs_to_return,
				      acctno,
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.EmailAdd and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR2),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.PrepID   and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR2),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.ISPName3 and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR2),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.RTNbr    and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR2),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.ISPName2 and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR2),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.ARNbr    and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR2),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.EmailAdd and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR1),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.PrepID   and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR1),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.ISPName3 and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR1),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.RTNbr    and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR1),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.ISPName2 and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR1),
							-(Contrib_Risk_field = BatchServices.Constants.TRISv3.ARNbr    and 
							  Contrib_Risk_Attr  = BatchServices.Constants.TRISv3.RISK_ATTR1)
						 );
			
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

      // *--- DEBUG ---* //
			//output(recs_in,                named('fncgcr_recs_in'));
			//output(contrib_recs,           named('fncgcr_contrib_recs'));
 			//output(contrib_recs_to_return, named('fncgcr_contrib_recs_to_return'));		
			//output(pre_contrib_recs,       named('fncgcr_pre_contrib_recs'));
			//output(final_recs_flat,        named('fncgcr_final_recs_flat'));

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