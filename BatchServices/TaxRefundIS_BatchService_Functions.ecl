import Autokey_batch, Address, AddrBest, AutoStandardI, 
Didville, CriminalRecords_BatchService, risk_indicators, riskwise,
ut, iesp, NID, BatchShare, Models, STD, gateway, BatchServices;

export TaxRefundIS_BatchService_Functions := MODULE

  shared extra_address_info_rec := record
    STRING10 lat := '';
    STRING11 long := '';
    string3 county := '';
    string7 geo_blk := '';
    STRING1  addr_type := '';
    STRING4  addr_status := '';
  end;
	shared in_rec := BatchServices.Layouts.TaxRefundIS.batch_in;
	shared in_batch_rec := record
    Autokey_batch.Layouts.rec_inBatchMaster;
    extra_address_info_rec;
		unsigned2 BestSSNScoreMin := 0;
		unsigned2 BestNameScoreMin := 0;
		unsigned2 SSNScoreMin := 0;
		unsigned2 NAMEScoreMin := 0;
  end;
	shared final_rec := BatchServices.Layouts.TaxRefundIS.batch_out;
  
  shared iid_format := record
    risk_indicators.Layout_Batch_In;
    string4 zip4 := '';
    extra_address_info_rec;
    string6 Gender := '';
    string44 PassportUpperLine := '';
    string44 PassportLowerLine := '';
  end;
  
  shared iid_final_format := record
    string20 acctno;
    string50 nas_summary;
    string50 cvi;
    string4  hri_1;
    string100 hri_desc_1;
    string4  hri_2;
    string100 hri_desc_2;
    string4  hri_3;
    string100 hri_desc_3;
    string4  hri_4;
    string100 hri_desc_4;
    string4  hri_5;
    string100 hri_desc_5;
    string4  hri_6;
    string100 hri_desc_6;
		boolean isInvalidSSN;
		boolean isRandomizedSSN;
  end;
  
	/*--- Function to clean batch input ---*/
	EXPORT clean_batch(dataset(in_rec) batch_in) := function
			in_batch_rec clean_batch_in(in_rec l, integer C) := TRANSFORM

				/* --- ADDRESS INFORMATION --- */
				addr1			 				:= Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
		                                     l.addr_suffix, l.postdir, 
																				 '', l.sec_range);
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
				self.name_first		:= L.name_first;
				ssn_filtered      := Stringlib.StringFilterOut(l.ssn, '0');
				self.ssn					:= if(ssn_filtered <> '', stringlib.stringfilter(l.ssn,'0123456789'), '');
				self 							:= l;
			END;
					
			batch_clean :=  project(batch_in, clean_batch_in(LEFT, COUNTER));
			return batch_clean;
	end;

	/*--- Function to get BestAddress batch records ---*/
	export getBestAddress(dataset(in_batch_rec) in_clean_batch) := function
     
			AddrBest.Layout_BestAddr.Batch_in makeAddrBestBatch(in_batch_rec L) := transform
        self.suffix := L.addr_suffix;
				self := L;
				self := [];
			end;
			addrBest_batch := project(in_clean_batch, makeAddrBestBatch(left));
			    
			addrBest_mod := module(AddrBest.Iparams.SearchParams) 
				export HistoricMatchCodes   := TRUE;
				export ReturnConfidenceFlag := TRUE;
				export MaxRecordsToReturn 	:= 20;
				export IncludeBlankDateLastSeen := TRUE;
			end;
			addrBest_res := AddrBest.Records(addrBest_batch, addrBest_mod).best_records;

			address_record := record
        addrBest_res;
        boolean hasInputAddr;
        string6 InputAddrDate; //YYYYMM format
				string6 InputZipMatchDate;
				boolean InputZipMatch;
      end;
     
      address_record xformFindMatch(addrBest_res L) := transform
        string acct_no := L.acctno;
        string prim_range_in := addrBest_batch(acctno = acct_no)[1].prim_range;
        string prim_name_in := addrBest_batch(acctno = acct_no)[1].prim_name;
        string zip_in := addrBest_batch(acctno = acct_no)[1].z5;
        string city_in := addrBest_batch(acctno = acct_no)[1].p_city_name;
        string state_in := addrBest_batch(acctno = acct_no)[1].st;
        self.hasInputAddr := L.is_input or (prim_range_in = L.prim_range 
                            and prim_name_in = L.prim_name 
                            and (zip_in = L.z5 or (city_in = L.p_city_name and state_in = L.st)));
        self.InputAddrDate := L.addr_dt_last_seen;
				inputZipMatch := L.z5 = zip_in;
				self.InputZipMatchDate := if (inputZipMatch, L.addr_dt_last_seen,'');  //assigned later in rollup logic
				self.InputZipMatch := inputZipMatch;
        self := L;
      end;
      
      with_input_indicator_recs := project(addrBest_res, xformFindMatch(left));
      
      address_record xformRollup(address_record L, address_record R) := transform
        self.hasInputAddr := L.hasInputAddr or R.hasInputAddr;
        self.InputAddrDate := map(L.hasInputAddr => L.InputAddrDate,
                                  R.hasInputAddr => R.InputAddrDate,
                                  '');
        leftZipDate := if (L.InputZipMatch, l.InputZipMatchDate,'');
				rightZipDate := if (R.InputZipMatch, R.InputZipMatchDate,''); 
        self.InputZipMatchDate	:= max(leftZipDate, rightZipDate);																
        self.InputZipMatch	:= L.InputZipMatch or R.InputZipMatch;																
        self := L; //first record per acctno is best address
      end;
      
      addrBest_res_final := rollup(with_input_indicator_recs, left.acctno = right.acctno, //previously sorted by acctno in AddrBest.records.best_records
                                                              xformRollup(left, right));
                                                              
      // /*--- DEBUG ---*/
			//output(addrBest_batch, named('addrBest_batch'));
			//output(addrBest_res, named('addrBest_res'));
			//output(with_input_indicator_recs, named('with_input_indicator_recs'));   
      //output(with_input_indicator_recs, named('with_input_indicator_recs'));

			return addrBest_res_final;
	end;
	
	/*--- Function to get BestSSN from ADLBest -> DidVille.Did_Batch_Service_Raw ---*/
	export getBestSSNInfo(dataset(in_batch_rec) in_clean_batch, 
												unsigned1 glb_purpose_value,
												unsigned1 dppa_purpose_value,
												string120 append_l,
												string32 appType,
												string5  IndustryClass,
												string120 verify_l = '') := function
			p := module(AutoStandardI.PermissionI_Tools.params)
				export boolean AllowAll := false;
				export boolean AllowGLB := false;
				export boolean AllowDPPA := false;
				export unsigned1 DPPAPurpose := dppa_purpose_value;
				export unsigned1 GLBPurpose := glb_purpose_value;
				export boolean IncludeMinors := false;
			END;
			GLB := AutoStandardI.PermissionI_Tools.val(p).glb.ok(glb_purpose_value);
			hhidplus := stringlib.stringfind(append_l,'HHID_PLUS',1)<>0;
      edabest := stringlib.stringfind(append_l,'BEST_EDA',1)<>0;

			DidVille.Layout_Did_OutBatch into(in_batch_rec l) := transform
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
	
			bestSsn_res := didville.did_service_common_function(recs, 
																													hhidplus_value := hhidplus, 
																													edabest_value := edabest, 
																													verify_value := verify_l,
																													appends_value := append_l, 
																													glb_flag := GLB, 
																													glb_purpose_value := glb_purpose_value, 
																													appType := appType,
																													IndustryClass_val := IndustryClass);
			return bestSsn_res;
	end;
	
  /*--- Function to get SSNIssuance issued start date ---*/
  export getSSNIssuanceRecords(dataset(final_rec) in_data) := function
  
      //Get the records that do not have a possible_age_dob and project to SSNIssuance batch input layout (acctno + ssn)
			no_dob_recs := project(in_data(possible_age_dob = ''), BatchServices.Layouts.SsnIssuance.batch_in);
    
      ssn_issuance_res := BatchServices.SSN_Issuance_BatchService_Records (no_dob_recs);

      return ssn_issuance_res;
  end;
  
	/*--- Function to get criminal batch records with Department of Corrections as datasource ---*/
	export getCriminalRecords(dataset(in_batch_rec) in_clean_batch) := function

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
													(left.data_type = '1' or left.datasource = 'Department of Corrections') and //need to return only Department of Corrections datasource!
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
	
  /*--- Function to get flags indicating input address matched a relatives address ---*/
	export get_rel_addr_match(dataset(in_batch_rec) in_clean_batch) := function
	   DidVille.Layout_RAN_BestInfo_BatchIn  fillInput(in_batch_rec l) := transform
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
	   bestRecs := DidVille.RAN_BestInfo_Batch_Service_Records(inputRecs, TRUE);
	   //only need to keep 2 fields for lookup purposes later on.	 
		 slimRec := record
		   STRING20 acctno;
		   boolean input_addr_matched_rel;
		 end;
		 outRecs := project(bestRecs, transform(slimRec, self := LEFT));
		 return outRecs;
	end;
	 /*--- Function to get HRA Service description code ---*/
  shared getHRARecords(dataset(iid_final_format) in_iid_rec, dataset(in_batch_rec) in_clean_batch) := function
  
      Autokey_batch.Layouts.rec_inBatchMaster xformToBatchRec(in_batch_rec L) := transform
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
      
      indata 		:= join(in_clean_batch, in_iid_rec, left.acctno = right.acctno, xformToBatchRec(left));
      
      // Retrieve and output records
      ds_outrecs := BatchServices.HRI_Address_Records(indata);
      
      // Apply max resutls per acct filter.
      hra_results := TOPN(GROUP(sort(ds_outrecs,acctno),acctno), 1, acctno);

      return hra_results;
  end;
  
  /*--- Function to get Instant ID NAS, CVI and High Risk Indicators ---*/
  export getIIDRecords(dataset(in_batch_rec) in_clean_batch, 
                  dataset(Gateway.Layouts.Config) gateways_in = Gateway.Constants.void_gateway,
                  unsigned1 DPPA_Purpose, 
                  unsigned1 GLB_Purpose, 
                  string industry_class_value, 
                  string50 DataRestriction,
                  string50 DataPermission) := function
    
			//Constants to run CIID process
      boolean Ofac_Only := false;
      boolean isPOBoxCompliant := false;
      unsigned3 history_date := 999999;
      boolean ExcludeWatchLists := false;
      integer ofac_version := 2;
      boolean include_additional_watchlists := false;
      boolean include_ofac := false;
      real Global_WatchList_Threshold := .84;
      dob_radius_use := -1; 
      boolean ln_branded_value := false;
      boolean suppressNearDups := false;
      boolean require2ele := false;
      boolean fromBiid := false;
      boolean isFCRA := false;
      boolean runSSNCodes:=  true;
      boolean runBestAddrCheck:= true;
      boolean runChronoPhoneLookup:= true;
      boolean runAreaCodeSplitSearch:=  true;
      integer bsversion := 2;  // always use shell version 2 now
      boolean allowCellPhones := false;
      string CustomDataFilter := '';  // this only for Phillip Morris in Identifier2
      unsigned2 EverOccupant_PastMonths := 0;	// for identifier2
      unsigned4 EverOccupant_StartDate := 99999999;	// for identifier2
      unsigned1 AppendBest := 1;		// search best file
      boolean IncludeDLverification := false;
      boolean IncludeMSoverride := false;
      boolean IncludeCLoverride := false;
      // DOB options
      string15  DOBMatchType := 'FuzzyCCYYMMDD';
      unsigned1 DOBMatchYearRadius := 0;
      DOBMatchOptions := dataset([{DOBMatchType, DOBMatchYearRadius}], risk_indicators.layouts.Layout_DOB_Match_Options);

      string10 ExactMatchLevel := '00000000';
      
      dWL := dataset([], iesp.share.t_StringArrayItem);
      watchlists_request := dWL(value<>'');

      iid_format toFormat(in_clean_batch L) := transform
        self.seq := L.seq;
        self.suffix := L.addr_suffix;
        self.dl_number := '';
        self.dl_state := '';
        self.home_phone := L.homephone;
        self.work_phone := L.workphone;
        self.age := '';
        self.HistoryDateYYYYMM := 0;
        self := L;
      end;
      
      f := project(in_clean_batch, toFormat(left));
      
      unsigned1 NumReturnCodes := risk_indicators.iid_constants.DefaultNumCodes;
      boolean IsInstantID := true;
			unsigned1 IIDVersion := 0;	// 0 will not see new reason codes introduced in ciid v1
      reasoncode_settings := dataset([{IsInstantID,IIDVersion}],riskwise.layouts.reasoncode_settings);
      actioncode_settings := dataset([{IsPOBoxCompliant, IsInstantID}],riskwise.layouts.actioncode_settings);

      risk_indicators.Layout_Input into(iid_format le) := transform
        historydate := if(le.HistoryDateYYYYMM=0, history_date, le.HistoryDateYYYYMM);
        self.historydate := historydate;
        // clean up input
        dob_val := riskwise.cleandob(le.dob);
        dl_num_clean := riskwise.cleanDL_num(le.dl_number);

        self.seq := le.seq;	
        self.ssn := IF(le.ssn='000000000','',le.ssn);	// blank out social if it is all 0's
        self.dob := dob_val;
        self.age := if ((integer)le.age = 0 and (integer)dob_val != 0,(STRING3)ut.Age((integer)dob_val), (le.age));
        
        self.phone10 := le.Home_Phone;
        self.wphone10 := le.Work_Phone;
        
        self.fname := stringlib.stringtouppercase(le.Name_First);
        self.lname := stringlib.stringtouppercase(le.Name_Last);
        self.mname := stringlib.stringtouppercase(le.Name_Middle);
        self.suffix := stringlib.stringtouppercase(le.Name_Suffix);	
        self.title := '';

        street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);	

        SELF.in_streetAddress := street_address;
        SELF.in_city := le.p_City_name;
        SELF.in_state := le.St;
        SELF.in_zipCode := le.Z5;
          
        self.prim_range := le.prim_range;
        self.predir := le.predir;
        self.prim_name := le.prim_name;
        self.addr_suffix := le.suffix;
        self.postdir := le.postdir;
        self.unit_desig := le.unit_desig;
        self.sec_range := le.sec_range;
        self.p_city_name := le.p_city_name;
        self.st := le.st;
        self.z5 := le.z5;
        self.zip4 := le.zip4;
        self.lat := le.lat;
        self.long := le.long;
				// Carrier Route not available - to do if you street style addresses
        self.addr_type := risk_indicators.iid_constants.override_addr_type(street_address, le.addr_type,'');
        self.addr_status := le.addr_status;
        self.county := le.county;
        self.geo_blk := le.geo_blk;
        
        self.dl_number := stringlib.stringtouppercase(dl_num_clean);
        self.dl_state := stringlib.stringtouppercase(le.dl_state);
        
        self.ip_address := le.ip_addr;
        
        self := [];
      end;

      prep := PROJECT(f,into(LEFT));
      
      ciid_recs := risk_indicators.InstantID_Function(prep, gateways_in, DPPA_Purpose, GLB_Purpose, 
                    industry_class_value='UTILI', ln_branded_value, ofac_only, suppressNearDups, 
                    require2ele, fromBiid, isFCRA, ExcludeWatchLists,FALSE,ofac_version,include_ofac,
                    include_additional_watchlists,Global_WatchList_Threshold,dob_radius_use,
                    bsversion, runSSNCodes, runBestAddrCheck, runChronoPhoneLookup, runAreaCodeSplitSearch, 
                    allowCellPhones, ExactMatchLevel, DataRestriction, CustomDataFilter, 
                    IncludeDLverification, watchlists_request, DOBMatchOptions, EverOccupant_PastMonths, 
                    EverOccupant_StartDate, AppendBest, in_datapermission:=datapermission);
     
      Instant_ID_Codes := ['11', '14', '50', 'IT', '71'];
      
      iid_final_format into_final(ciid_recs L, iid_format R) := transform
        self.acctno := R.acctno;
        verlast := IF(L.combo_lastcount>0, L.combo_last, '');
        veraddr := IF(L.combo_addrcount>0, Risk_Indicators.MOD_AddressClean.street_address('',L.combo_prim_range,
                      L.combo_predir,L.combo_prim_name,L.combo_suffix,L.combo_postdir,L.combo_unit_desig,L.combo_sec_range),'');	
        RI := risk_indicators.reasonCodes(L, NumReturnCodes, reasoncode_settings);
				self.isInvalidSSN := RI[1].hri = '06' or RI[2].hri = '06' 
                            or RI[3].hri = '06' or  RI[4].hri = '06' 
                            or RI[5].hri = '06' or RI[6].hri = '06'; //-> 'The input SSN is invalid'
				self.isRandomizedSSN := RI[1].hri = 'RS' or RI[2].hri = 'RS' 
                            or RI[3].hri = 'RS' or  RI[4].hri = 'RS' 
                            or RI[5].hri = 'RS' or RI[6].hri = 'RS'; //-> 'The input SSN was possibly randomly issued by the SSA'
        self.hri_1 := if (count(RI) >= 1 and RI[1].hri in Instant_ID_Codes, RI[1].hri, '');
        self.hri_desc_1 := if (count(RI) >= 1 and RI[1].hri in Instant_ID_Codes, RI[1].desc, '');
        self.hri_2 := if (count(RI) >= 2 and RI[2].hri in Instant_ID_Codes, RI[2].hri, '');
        self.hri_desc_2 := if (count(RI) >= 2 and RI[2].hri in Instant_ID_Codes, RI[2].desc, '');
        self.hri_3 := if (count(RI) >= 3 and RI[3].hri in Instant_ID_Codes, RI[3].hri, '');
        self.hri_desc_3 := if (count(RI) >= 3 and RI[3].hri in Instant_ID_Codes, RI[3].desc, '');
        self.hri_4 := if (count(RI) >= 4 and RI[4].hri in Instant_ID_Codes, RI[4].hri, '');
        self.hri_desc_4 := if (count(RI) >= 4 and RI[4].hri in Instant_ID_Codes, RI[4].desc, '');
        self.hri_5 := if (count(RI) >= 5 and RI[5].hri in Instant_ID_Codes, RI[5].hri, '');
        self.hri_desc_5 := if (count(RI) >= 5 and RI[5].hri in Instant_ID_Codes, RI[5].desc, '');
        self.hri_6 := if (count(RI) >= 6 and RI[6].hri in Instant_ID_Codes, RI[6].hri, '');
        self.hri_desc_6 := if (count(RI) >= 6 and RI[6].hri in Instant_ID_Codes, RI[6].desc, '');
        self.nas_summary := (string)L.socsverlevel;
        cvi_temp := risk_indicators.cviScore(L.phoneverlevel,L.socsverlevel,L,L.correctssn,
                                              L.correctaddr,L.correcthphone,'',veraddr,verlast);	
        self.CVI := map(	IncludeMSoverride and risk_indicators.rcSet.isCodeMS(L.ssns_per_adl_seen_18months) and (integer)cvi_temp > 10 => '10',
                IsPOBoxCompliant AND risk_indicators.rcSet.isCodePO(L.addr_type) and (integer)cvi_temp > 10 => '10',
                IncludeCLoverride and risk_indicators.rcSet.isCodeCL(L.ssn, L.bestSSN, L.socsverlevel, L.combo_ssn) and (integer)cvi_temp > 10 => '10',
                cvi_temp);
      end;

      iid_results := join(ciid_recs, f, left.seq=right.seq, into_final(LEFT,right), left outer, limit(0), keep(1));
      
      hra_recs := getHRARecords(iid_results(hri_1 = '14'or 
                                            hri_2 = '14'or 
                                            hri_3 = '14'or 
                                            hri_4 = '14'or 
                                            hri_5 = '14'or 
                                            hri_6 = '14'), in_clean_batch);
      
      iid_final_format xFormHRA(iid_final_format L, hra_recs R) := transform
        self.hri_desc_1 := if(L.hri_1 = '14', R.sic_code_desc, L.hri_desc_1);
        self.hri_desc_2 := if(L.hri_2 = '14', R.sic_code_desc, L.hri_desc_2);
        self.hri_desc_3 := if(L.hri_3 = '14', R.sic_code_desc, L.hri_desc_3);
        self.hri_desc_4 := if(L.hri_4 = '14', R.sic_code_desc, L.hri_desc_4);
        self.hri_desc_5 := if(L.hri_5 = '14', R.sic_code_desc, L.hri_desc_5);
        self.hri_desc_6 := if(L.hri_6 = '14', R.sic_code_desc, L.hri_desc_6);
        self := L;
      end;
      
      iid_res_w_hra := join(iid_results, hra_recs, left.acctno = right.acctno, xFormHRA(left, right), left outer, limit(0), keep(1));
      
      return iid_res_w_hra;
  end;





   /* v2_1Filter: 
     Input: Takes specific parameters from the penultimate result.  
     Determines as to what category the record (of a person filing for 
     TAX return) should be. The  possiblities are 'Manual Review' ,
     'Not Passed Identity Filter' , 'Passed Identity Filter'. (for more 
		 details see the HLD doc with Bug# 129680)
*/
	 
  export string30 v2_1Filter( string3 possible_age_dob,string3 possible_age_ssn_issuance,string6 InputAddrDate,
															string1 MatchedInputAddr,string3 Identity_Verification_NAS_Code,
															string3 Identity_Verification_CVI_Code,string4 hri_1_indicator, 
										          string4 hri_2_indicator,string4 hri_3_indicator,string4 hri_4_indicator,
															string4 hri_5_indicator,string4 hri_6_indicator, string8 DOD,
															string1 curr_incar_flag,string1 curr_incar_flag_BestSSN,
															string8 InputAddrZipDate,string1 inputAddrRel,string3 npi_indicator, 
															string3 NPIThreshold,string9 SSN ) := function 
   	
        		
				boolean isDOD											:=	DOD <> ''; 
				boolean isDOD_greater_2_years 		:= 	isDOD and (ut.Age((unsigned4) DOD) >=2);
				boolean isDOD_within_2_years 			:= 	isDOD and (ut.Age((unsigned4) DOD) < 2);
				string8 today 										:= 	StringLib.getdateYYYYMMDD();
				integer4 CurrentYear 							:= 	(INTEGER4)(today[1..4]);
				boolean isInputAddrDate_seen_in_last_3_years    := 	InputAddrDate<>'' and (CurrentYear - (INTEGER4)InputAddrDate[1..4] <= 3);
				boolean isInputAddrZipDate_seen_in_last_3_years := 	InputAddrZipDate<>'' and (CurrentYear - (INTEGER4)InputAddrZipDate[1..4] <= 3);
				
				boolean isAge_15_23               :=   ((INTEGER3) possible_age_dob >= 15  AND (INTEGER3) possible_age_dob <= 23) OR
																							 ((INTEGER3) possible_age_ssn_issuance >= 15 AND (INTEGER3) possible_age_ssn_issuance <= 23)OR 
																							 ( possible_age_dob IN ['','***'] AND possible_age_ssn_issuance IN ['','***'] );
																							 
																							 									
																		
				boolean isIncarcerated           	:=    STD.Str.ToUpperCase(curr_incar_flag) ='Y'  OR 
																								STD.Str.ToUpperCase(curr_incar_flag_BestSSN) ='Y';
													 
				boolean isHRI50	                 	:=    STD.Str.CleanSpaces(hri_1_indicator) = '50' OR STD.Str.CleanSpaces(hri_2_indicator) = '50' OR 
																								STD.Str.CleanSpaces(hri_3_indicator) = '50' OR STD.Str.CleanSpaces(hri_4_indicator) = '50' OR 
																								STD.Str.CleanSpaces(hri_5_indicator) = '50' OR STD.Str.CleanSpaces(hri_6_indicator) = '50' ;
				
				boolean isConditionB             	:= 	  isDOD_within_2_years AND 
																								((INTEGER2)Identity_Verification_NAS_Code BETWEEN 0 AND 9) AND 
																								((INTEGER2)Identity_Verification_CVI_Code BETWEEN 0 AND 40);				
													
				boolean isConditionC 						 	:=    NOT(isAge_15_23) AND 
																								((INTEGER2)Identity_Verification_NAS_Code BETWEEN 0 AND 9) AND 
																								((INTEGER2)Identity_Verification_CVI_Code BETWEEN 0 AND 40);									
													
														
				
			boolean isExceptForCondition 				:= 	   (INTEGER2) Identity_Verification_NAS_Code = 9  AND 
																								 (INTEGER2) Identity_Verification_CVI_Code IN [10,20]  AND
																								 (  isInputAddrDate_seen_in_last_3_years OR 
																							      isInputAddrZipDate_seen_in_last_3_years OR 
																								    MatchedInputAddr = 'Y'  OR 
																									  InputAddrRel ='Y' 
																									)AND
																									NOT((INTEGER4)npi_indicator < (INTEGER4)NPIThreshold);
								
				
				
				boolean isHRI_71 									:=	   (INTEGER2)hri_1_indicator = 71  OR (INTEGER2)hri_2_indicator = 71  OR 
																								 (INTEGER2)hri_3_indicator = 71  OR (INTEGER2)hri_4_indicator = 71  OR 
																								 (INTEGER2)hri_5_indicator = 71  OR (INTEGER2)hri_6_indicator = 71 ;
														
														
				boolean isConditionD 							:= 	 isHRI_71 AND NOT
																									( isAge_15_23  OR  STD.Str.CleanSpaces(SSN)[1] = '9' OR 
																										 STD.Str.CleanSpaces(Identity_Verification_NAS_Code) IN ['10','11','12'] OR
																										 (  STD.Str.CleanSpaces(Identity_Verification_NAS_Code) ='9' AND 
																												(   isInputAddrDate_seen_in_last_3_years  OR 
																												    isInputAddrZipDate_seen_in_last_3_years OR
																														MatchedInputAddr = 'Y'  OR 
																														InputAddrRel ='Y'
																												) AND 
																												NOT ((INTEGER4)npi_indicator < (INTEGER4)NPIThreshold)
																											)
																									 );
				
				boolean isFail_1 								:=   isConditionB AND NOT isExceptForCondition;
				
		    boolean isFail_2 								:= 	 isConditionC AND NOT isExceptForCondition;
				
		    boolean isFail_3 								:= 	 isConditionD;
				
				boolean isManual 								:=	 isDOD_greater_2_years or isIncarcerated or isHRI50;
				
    		boolean isFail    							:= 	 isFail_1 OR isFail_2 OR isFail_3; 
				
		    string30 identity_filter 				:= 	 MAP(	isManual    			=>  'Manual Review',
																									isFail       			=>  'Not Passed Identity Filter',
																																				'Passed Identity Filter');
																				
	      return identity_filter;
	end;
	
	
  
		
/* The main filter. 
      - This calls the required filter function. 
      - In the future, there will be more than one filters. 
      - This returns the result batch or nothing.
*/
	
	export MainFilter(dataset(final_rec) batch_res_before_filter, string30 FilterRule, string3 NPIThreshold) :=	function
   
			final_rec xformBatchOut( final_rec l) := TRANSFORM
			  self.identity_filter :=   v2_1Filter( l.possible_age_dob,l.possible_age_ssn_issuance,l.InputAddrDate,l.MatchedInputAddr, 
				 													  					l.Identity_Verification_NAS_Code,l.Identity_Verification_CVI_Code,l.hri_1_indicator,
																						  l.hri_2_indicator,l.hri_3_indicator,l.hri_4_indicator,l.hri_5_indicator,
																						  l.hri_6_indicator,l.DOD,l.curr_incar_flag,l.curr_incar_flag_BestSSN,l.InputAddrZipDate,
																						  l.inputAddrRel, l.npi_indicator,NPIThreshold,l.SSN );               
				self                 :=   l;
		  END;
			
	    v2_1Filter_res    		 :=  project(batch_res_before_filter, xformBatchOut(left));
			batch_res_after_filter :=  if(StringLib.StringToUpperCase(FilterRule)='V2_1FILTER', v2_1Filter_res); 
			return batch_res_after_filter;
	end;
	



export callFraudPoint2(unsigned1 GLBPurpose,unsigned1 DPPAPurpose,string DataRestrictionMask,string 
                               IndustryClass,string20 ModelName,dataset(in_batch_rec) in_clean_batch, string DataPermissionMask) := function

		 
	// Layout for batch input to FraudPoint 2.0 :
	layout_fp_batch_in := Models.FraudAdvisor_Batch_Service_Layouts.BatchInput;
		
			layout_fp_batch_in fill_fpBatch (in_clean_batch L) := TRANSFORM
				self := L;
				self.Suffix := L.Addr_Suffix;
				self := [];
			END;
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
					export string DataRestriction       := DataRestrictionMask; // 0000000000000000000 to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
					export string DataPermission        := DataPermissionMask; 
          export boolean doParo_attrs         := false;
          export string requestedattributegroups := '';
		end;

		// No gateways required
		wModel := Models.FraudAdvisor_Batch_Service_Records(InputArgs,batch_in_FP,Gateway.Constants.void_gateway); 

		return wModel;
	end;



END;