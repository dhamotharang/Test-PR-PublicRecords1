import BIPV2, doxie, doxie_cbrs, liensv2, suppress, ut, FFD, FCRA, STD;
// This module will provide liens data in different formats.

//IMPORTANT FCRA-NOTE:
//  Corresponding FCRA-compliant/neutral data are used here,
//  fcra-corrections, if required by a service, should be applied to the output result by a caller
export liens_raw := module

	shared with_did := {liensv2_services.layout_rmsid or doxie.layout_references};
	shared with_bdid := {liensv2_services.layout_rmsid or doxie_cbrs.layout_references};

  // Gets RMSIDs from TMSIDs
	shared get_rmsids_from_tmsids(dataset(liensv2_services.layout_tmsid) in_tmsids, boolean isFCRA=false) := function
	  key := if(isFCRA, LiensV2.key_liens_main_ID_FCRA, liensv2.key_liens_main_ID);
		res := join(dedup(sort(in_tmsids,tmsid),tmsid),key,
		            keyed(left.tmsid = right.tmsid),
								transform(liensv2_services.layout_rmsid,self := right),
								limit(10000));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
	// Gets RMSIDs from DIDs
	export get_rmsids_from_dids (dataset(doxie.layout_references) in_dids,
                               boolean isMoxie = false,
                               boolean IsFCRA = FALSE,
															 string1 in_party_type = '') := function

		MAC_GetLiens (key_attr,key_attr2, out_file) := MACRO
      #uniquename (res1);
			%res1% := join(dedup(sort(in_dids,did),did), key_attr,
										keyed(left.did = right.did),						
										transform(with_did,self := left,self := right),
										limit(10000));

      #uniquename (party_checked);
			%party_checked% := join(%res1%, key_attr2,
										 keyed(left.tmsid = right.tmsid and left.rmsid = right.rmsid) and 
										 left.did = (unsigned)right.did and 
										 right.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
										 transform(liensv2_services.layout_rmsid,self := right),
										 limit(10000));
										 
      #uniquename (res_slim1);
			ut.MAC_Slim_Back(%res1%,liensv2_services.layout_rmsid,%res_slim1%);
      #uniquename (use_res);
			%use_res% := if(in_party_type = '', %res_slim1%, %party_checked%);
										 
      #uniquename (res2);
			// NB: when we hit the limit for DID, we SKIP all records,
			// because I assert that there should be no person with that many liens
			// Compare to bdid below
			%res2% := join(dedup(sort(in_dids,did),did),key_attr,
										keyed(left.did = right.did) and
									 (In_Party_Type = '' or exists(key_attr2((unsigned)did = left.did and tmsid = right.tmsid and rmsid=right.rmsid and name_type[1] = STD.Str.ToUpperCase(In_Party_Type)[1]))),								
										transform(liensv2_services.layout_rmsid,self := right),
										LIMIT(200,SKIP));
			out_file := IF(isMoxie,%res2%,%use_res%);
		ENDMACRO;

		MAC_GetLiens (liensv2.key_liens_did,Liensv2.key_liens_party_id, res_reg);
		MAC_GetLiens (liensv2.key_liens_did_fcra,Liensv2.key_liens_party_id_FCRA, res_fcra);
    res := IF (IsFCRA, res_fcra, res_reg);

		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;

	// Gets RMSIDs from BDIDs
	export get_rmsids_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
	                             unsigned in_limit = 0,
															 boolean isMoxie = false,
															 string1 in_party_type = '',
															 boolean isFCRA = false) := function

		key := if(isFCRA, liensv2.Key_FCRA_Liens_BDID, liensv2.key_liens_bdid);
		
		res1 := join(dedup(sort(in_bdids,bdid),bdid),key,
								keyed(left.bdid = right.p_bdid), 
								transform(with_bdid,self := left,self := right), 
								keep(10000));
								
		party_checked1 := join(res1, liensv2.key_liens_party_ID,
										 keyed(left.tmsid = right.tmsid and left.rmsid = right.rmsid) and 
										 left.bdid = (unsigned)right.bdid and 
										 right.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
										 transform(liensv2_services.layout_rmsid,self := right),
										 keep(10000));
								
		ut.MAC_Slim_Back(res1,liensv2_services.layout_rmsid,res_slim1);
		use_res1 := if(in_party_type = '', res_slim1, party_checked1);

		res2 := join(dedup(sort(in_bdids,bdid),bdid),key,
								keyed(left.bdid = right.p_bdid), 
								transform(with_bdid,self := left,self := right), 
								keep(500));

		party_checked2 := join(res2, liensv2.key_liens_party_ID,
										 keyed(left.tmsid = right.tmsid and left.rmsid = right.rmsid) and 
										 left.bdid = (unsigned)right.bdid and 
										 right.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
										 transform(liensv2_services.layout_rmsid,self := right),
										 keep(500));
								
		ut.MAC_Slim_Back(res2,liensv2_services.layout_rmsid,res_slim2);
		use_res2 := if(in_party_type = '', res_slim2, party_checked2);
								
		use_res := IF(isMoxie,use_res2,use_res1);
		
		ded := dedup(sort(use_res,tmsid,rmsid),tmsid,rmsid);
		
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;
	
	// Get RMSIDs from 7 business ids
	export get_tmsids_from_bids(dataset(BIPV2.IDlayouts.l_xlink_ids) in_bids,
                              string1 bid_fetch_level,
                              string1 in_party_type = '') := function    
    res1 := LiensV2.Key_LinkIds.KeyFetch(in_bids,bid_fetch_level);
								
		party_checked1 := join(res1, liensv2.key_liens_party_ID,
										 keyed(left.tmsid = right.tmsid and left.rmsid = right.rmsid) and 
										 left.ultid = right.ultid and
                     left.orgid = right.orgid and
                     left.seleid = right.seleid and
                     left.proxid = right.proxid and
										 right.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
										 transform(liensv2_services.layout_rmsid,self := right),
										 keep(10000));
								
		ut.MAC_Slim_Back(res1,liensv2_services.layout_rmsid,res_slim1);
    
		use_res1 := if(in_party_type = '', res_slim1, party_checked1);
    
		return dedup(sort(use_res1,tmsid,rmsid),tmsid,rmsid);
	end;
	
	// Gets RMSIDs from Casenumber ST
	export get_rmsids_from_casenumber_st(dataset(LiensV2_Services.layout_casenumber_st) in_casenumber_st, boolean isFCRA=false) := function
		key := if(isFCRA, liensv2.Key_FCRA_Liens_case_number, liensv2.key_liens_case_number);
		res := join(dedup(sort(in_casenumber_st,case_number,filing_state),case_number,filing_state),key,
								keyed(trim(left.case_number) = right.case_number) and
								keyed(left.filing_state = '' or trim(left.filing_state) = right.filing_state),
								transform(liensv2_services.layout_rmsid,self := right),
								keep(1000));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
	// Gets RMSIDs from Filing Number
	export get_rmsids_from_Filing_Number(dataset(liensv2_services.layout_filing_number) in_filing_number, boolean isFCRA=false) := function
		key := if(isFCRA, LiensV2.Key_FCRA_Liens_Filing, LiensV2.key_liens_filing);
		res := join(dedup(sort(in_filing_number,filing_number,filing_state),filing_number,filing_state),key,
								keyed(left.filing_number = right.filing_number) and
								keyed(left.filing_state = '' or trim(left.filing_state) = right.filing_state),
								transform(liensv2_services.layout_rmsid,self := right),
								keep(1000));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;	

	// Gets RMSIDs from IRS Serial Number
	export get_rmsids_from_IRS_Serial_Number(dataset(liensv2_services.layout_irs_serial_number) in_serial_number, boolean isFCRA=false) := function
		key := if(isFCRA, LiensV2.Key_FCRA_Liens_Irs_serial_number, LiensV2.key_liens_irs_serial_number);
		res := join(dedup(sort(in_serial_number,irs_serial_number),irs_serial_number),key,
								keyed(left.irs_serial_number = right.irs_serial_number),
								transform(liensv2_services.layout_rmsid,self := right),
								keep(1000));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);	
	end;
	
	// Gets RMSIDs from Certificate Number
	export get_rmsids_from_CertificateNumber(dataset(liensv2_services.layout_CertificateNumber) in_CertificateNumber, boolean isFCRA=false) := function
		key := if(isFCRA, LiensV2.Key_FCRA_Liens_Certificate_Number, LiensV2.key_liens_certificate_number);
		res := join(dedup(sort(in_CertificateNumber,certificate_number),certificate_number),key,
								keyed(left.certificate_number = right.certificate_number),
								transform(liensv2_services.layout_rmsid,self := right),
								keep(1000));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);	
	end;
	
	// Batch - Gets TMSIDs from DIDs
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_dids_batch(grouped dataset(doxie.layout_references_acctno) in_dids,
																		boolean IsFCRA = FALSE,
																		string1 in_party_type = '') := function
		res_reg := join(dedup(sort(in_dids,did),did),liensv2.key_liens_did,
								keyed(left.did = right.did),
								transform(with_did,self := left,self := right),
								keep(1000)); // actual number might be higher than that...

		res_reg_checked := join(res_reg, liensv2.key_liens_party_ID,
														keyed(left.tmsid = right.tmsid) and 
														left.did = (unsigned)right.did and 
														right.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
														transform(liensv2_services.layout_tmsid,self.acctno := left.acctno, self := right),
														keep(1000));

		ut.MAC_Slim_Back(res_reg,liensv2_services.layout_tmsid,res_reg_slim);
		use_res_reg := if(in_party_type = '', res_reg_slim, res_reg_checked);

		res_fcra := join(dedup(sort(in_dids,did),did),liensv2.key_liens_did_fcra,
								keyed(left.did = right.did),
								transform(with_did,self.acctno := left.acctno,self := right),
								keep(1000)); // actual number might be higher than that...

		res_fcra_checked := join(res_fcra, liensv2.key_liens_party_id_FCRA,
														keyed(left.tmsid = right.tmsid) and 
														left.did = (unsigned)right.did and 
														right.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
														transform(liensv2_services.layout_tmsid,self.acctno := left.acctno,self := right),
														keep(1000));

		ut.MAC_Slim_Back(res_fcra,liensv2_services.layout_tmsid,res_fcra_slim);
		use_res_fcra := if(in_party_type = '', res_fcra_slim, res_fcra_checked);

    res := IF (IsFCRA, use_res_fcra, use_res_reg);
		
		return dedup(sort(res,tmsid),tmsid);
	end;
	
	// Gets TMSIDs from DIDs
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_dids(dataset(doxie.layout_references) in_dids,string1 in_party_type = '', boolean IsFCRA = false) := function

		return ungroup(get_tmsids_from_dids_batch(group(sorted(project(in_dids, doxie.layout_references_acctno), acctno), acctno),IsFCRA,in_party_type));
	end;

	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_bdids_batch(dataset(doxie_cbrs.layout_references_acctno) in_bdids,
																		 unsigned in_limit = 0
																		 ) := function
		res := join(dedup(sort(in_bdids, acctno, bdid), acctno, bdid), liensv2.key_liens_bdid,
								keyed(left.bdid = right.p_bdid),
								transform(liensv2_services.layout_tmsid, self := right, self := left),
								keep(1000));                
		ded := dedup(sort(res, acctno, tmsid), acctno, tmsid);
		
		return if( in_limit = 0, ded, choosen(ded,in_limit) );
	end;    
	
	// Gets TMSIDs from BDIDs
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
	                             unsigned in_limit = 0,
															 string1 in_party_type = '',
															 boolean isFCRA=false) := function
		key := if(isFCRA, liensv2.Key_FCRA_Liens_BDID, liensv2.key_liens_bdid);
		
		res := join(dedup(sort(in_bdids,bdid),bdid),key,
								keyed(left.bdid = right.p_bdid), 
								transform(with_bdid,self := left,self := right), 
								keep(1000));
		
		party_checked := join(res, liensv2.key_liens_party_ID,
										 keyed(left.tmsid = right.tmsid) and 
										 left.bdid = (unsigned)right.bdid and 
										 right.name_type[1] = STD.Str.ToUpperCase(in_party_type)[1],
										 transform(liensv2_services.layout_tmsid,self := right),
										 keep(1000));
								
		ut.MAC_Slim_Back(res,liensv2_services.layout_tmsid,res_slim);
		use_res := if(in_party_type = '', res_slim, party_checked);
		
		ded := dedup(sort(use_res,tmsid),tmsid);
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;
	
	// Gets TMSIDs from RMSIDs
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_rmsids(dataset(liensv2_services.layout_rmsid) in_rmsids,
																boolean isFCRA=false
																) := function
	  key := if(isFCRA, LiensV2.key_liens_RMSID_FCRA, liensv2.key_liens_rmsid);
		res := join(dedup(sort(in_rmsids,rmsid),rmsid),key,
		            keyed(left.rmsid = right.rmsid),
								transform(liensv2_services.layout_rmsid,self := right),
								keep(1000));
		
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
  // Gets TMSIDs from Casenumber ST
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_casenumber_st(	dataset(LiensV2_Services.layout_casenumber_st) in_casenumber_st) := function
		key := liensv2.key_liens_case_number;
		res := join(dedup(sort(in_casenumber_st,case_number,filing_state),case_number,filing_state),key,
								keyed(trim(left.case_number) = right.case_number) and
								keyed(left.filing_state = '' or trim(left.filing_state) = right.filing_state),
								transform(liensv2_services.layout_tmsid,self := right),
								keep(1000));
		
		return dedup(sort(res,tmsid),tmsid);
	end;
	
	
  // ======================================================================
  // Returns the liens data in the report summary view (grouped and rolled up by TMSID)
  // ======================================================================
  export report_view := module
	
	  // Batch - Returns the liens data in the report summary view using TMSIDs as a lookup mechanism.
		export by_tmsid_batch(grouped dataset(liensv2_services.layout_tmsid) in_tmsids,
		                string in_ssn_mask_type = '',
                    boolean IsFCRA = FALSE,
										string in_filing_jurisdiction = '',
										string person_filter_id = '',
										BOOLEAN return_multiple_pages = FALSE,
										string32 appType,
                    boolean includeCriminalIndicators=false,
										DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
										integer8 inFFDOptionsMask = 0,
										integer FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided, 
										boolean rollup_by_case_link = false) := function
			
			tmsidsgrpd	:=	group(sort(in_tmsids,acctno,tmsid),acctno);
		
		  return liensv2_services.fn_get_liens_tmsid(tmsidsgrpd,in_ssn_mask_type,IsFCRA,in_filing_jurisdiction, 
																								  person_filter_id,return_multiple_pages,appType,includeCriminalIndicators,
																									ds_slim_pc,inFFDOptionsMask,FCRAPurpose,rollup_by_case_link);
		end;	
		
	  // Returns the liens data in the report summary view using TMSIDs as a lookup mechanism.
		export by_tmsid(dataset(liensv2_services.layout_tmsid) in_tmsids,
		                string in_ssn_mask_type = '', 
										boolean IsFCRA = false,
										string in_filing_jurisdiction = '',
										string person_filter_id = '',
										BOOLEAN return_multiple_pages = FALSE,
										string32 appType,
                    boolean includeCriminalIndicators=false,
										DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim,
										integer8 inFFDOptionsMask = 0,
										integer FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided, 
										boolean rollup_by_case_link = false ) := function						
			return ungroup(by_tmsid_batch(group(sorted(in_tmsids, acctno), acctno),in_ssn_mask_type,
			                                IsFCRA,in_filing_jurisdiction,person_filter_id, 
											                return_multiple_pages,appType,includeCriminalIndicators, 
											                ds_slim_pc,inFFDOptionsMask,FCRAPurpose,rollup_by_case_link));
		end;	
 	
   	  // Batch - Returns the liens data in the report summary view using DIDs as a lookup mechanism.
   	  export by_did_batch(grouped dataset(doxie.layout_references_acctno) in_dids,
   		              string in_ssn_mask_type = '',
   									boolean IsFCRA = FALSE,
   									string1 in_party_type = '',
   									string32 appType,
                    boolean includeCriminalIndicators=false,
										DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc  = FFD.Constants.BlankPersonContextBatchSlim,
									  integer8 inFFDOptionsMask = 0,
										integer FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided, 
										boolean rollup_by_case_link = false ) := function
   		  return by_tmsid_batch(get_tmsids_from_dids_batch(in_dids, IsFCRA, in_party_type),
				                        in_ssn_mask_type,IsFCRA,'','',false,appType,includeCriminalIndicators,
										ds_slim_pc,inFFDOptionsMask,FCRAPurpose,rollup_by_case_link);
   		end;

	
	  // Returns the liens data in the report summary view using DIDs as a lookup mechanism.
	  export by_did(dataset(doxie.layout_references) in_dids,
		              string in_ssn_mask_type = '',
									boolean IsFCRA = FALSE,
									string1 in_party_type = '',
									string32 appType,
                  boolean includeCriminalIndicators=false,
									DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc  = FFD.Constants.BlankPersonContextBatchSlim,
									integer8 inFFDOptionsMask = 0,
									integer FCRAPurpose = FCRA.FCRAPurpose.NoValueProvided, 
									boolean rollup_by_case_link = false ) := function
      ds_batch := group(sorted(project(in_dids, doxie.layout_references_acctno), acctno), acctno);
		  return ungroup(by_did_batch(ds_batch,in_ssn_mask_type,IsFCRA,in_party_type,
			                              appType,includeCriminalIndicators,ds_slim_pc,
										  inFFDOptionsMask,FCRAPurpose,rollup_by_case_link));
		end;
	
		
		// Returns the liens data in the report summary view using BDIDs as a lookup mechanism.
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		               unsigned in_limit = 0,
		               string in_ssn_mask_type = '',
									 string1 in_party_type = '',
									 string32 appType,
                   boolean includeCriminalIndicators=false,
									 DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc  = FFD.Constants.BlankPersonContextBatchSlim,
									 integer8 inFFDOptionsMask = 0, 
									 boolean rollup_by_case_link = false) := function
		  return by_tmsid(get_tmsids_from_bdids(in_bdids,in_limit,in_party_type),in_ssn_mask_type,false,'','',
			              false,appType,includeCriminalIndicators,ds_slim_pc,inFFDOptionsMask,,rollup_by_case_link);
		end;
		
	end;
	
  // ======================================================================
  // Returns non-FCRA liens data in the moxie view (ungrouped and not rolled up)
  // ======================================================================
	export moxie_view := module
	
	  // Returns the liens data in the moxie view using tmsids as a lookup mechanism.
		export by_rmsid(dataset(liensv2_services.layout_rmsid) in_rmsids,
		                string in_ssn_mask_type, SET OF STRING1 name_types = ALL,
                    boolean isReport = false, string32 appType='') := function

      ds_dedup := dedup(sort(in_rmsids,tmsid,rmsid),tmsid,rmsid);
			res_main := join (ds_dedup, liensv2.key_liens_main_id,
												keyed(left.tmsid = right.tmsid) and keyed(left.rmsid = right.rmsid),
												limit(10000));

      // Get party; use penalty to retain or skip records depending on the query type
			liensv2.layout_liens_party GetParty (liensv2_services.layout_rmsid le, liensv2.key_liens_party_id ri) := TRANSFORM
					penaddr := doxie.FN_Tra_Penalty_addr(ri.predir,ri.prim_range,ri.prim_name,ri.addr_suffix,ri.postdir,ri.sec_range,ri.p_city_name,ri.st,ri.zip);
		
					dpenalt	:=  penaddr +
										doxie.FN_Tra_Penalty_DID(ri.did) +
										doxie.FN_Tra_Penalty_SSN(ri.ssn) +
										doxie.FN_Tra_Penalty_Name(ri.fname, ri.mname, ri.lname);
					bpenalt	:=  penaddr +
										doxie.FN_Tra_Penalty_BDID(ri.bdid) +
										doxie.FN_Tra_Penalty_CName(ri.cname);
					
					ReportSkip := isReport AND ri.name_type='D' AND ~(doxie.FN_Tra_Penalty_BDID(ri.bdid) = 0 OR doxie.FN_Tra_Penalty_DID(ri.did) = 0);
					RegularSkip := ~isReport AND ri.name_type='D' AND dpenalt>0 AND bpenalt>0;
					
					SELF.rmsid := IF(ReportSkip OR RegularSkip,SKIP,ri.rmsid);
					SELF := ri;
			END;

			res_party := join (ds_dedup, liensv2.key_liens_party_id,
													keyed(left.tmsid = right.tmsid) and keyed(left.rmsid = right.rmsid) and 
													right.name_type IN name_types,
													GetParty (LEFT,RIGHT), limit(10000));

			res_joined := join(res_main,res_party,left.tmsid = right.tmsid and left.rmsid = right.rmsid,left outer);
			
      // pull, mask
			Suppress.MAC_pullIDs_tmsid(res_joined, pulled,false,true,appType,'LIENS');
			Suppress.MAC_Mask(pulled, res_masked, ssn, null, true, false, maskVal:=in_ssn_mask_type);

			return dedup(sort(res_masked,record),record);
		end;
		
	  // Returns the liens data in the moxie view using dids as a lookup mechanism.
	  export by_did(dataset(doxie.layout_references) in_dids,
                  string in_ssn_mask_type = '',
									string1 in_party_type = '', boolean isReport = false,string32 appType='') := function
      return by_rmsid(get_rmsids_from_dids(in_dids, , FALSE, in_party_type), in_ssn_mask_type, , isReport,appType);
		end;

		// Returns the liens data in the moxie view using bdids as a lookup mechanism.
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		               string in_ssn_mask_type = '',
									 string1 in_party_type = '',
									 string32 appType='') := function
			return by_rmsid(get_rmsids_from_bdids(in_bdids, , , in_party_type),in_ssn_mask_type, , false, appType);
		end;
	end;

	
  // ==========================================================================
  // Returns the liens data in the source view (grouped and rolled up by RMSID)
  // ==========================================================================
	export source_view := module
	
	  // Returns the liens data in the source view using rmsids as a lookup mechanism.
		shared by_rmsid(dataset(liensv2_services.layout_rmsid) in_rmsids,
		                string in_ssn_mask_type,
										string32 appType,
                    boolean includeCriminalIndicators=false) := function
		  return liensv2_services.fn_get_liens_rmsid(group(sorted(in_rmsids, acctno), acctno),in_ssn_mask_type,appType,includeCriminalIndicators);
		end;
		
		// Returns the liens data in the source view using tmsids as a lookup mechanism.
		export by_tmsid(dataset(liensv2_services.layout_tmsid) in_tmsids,
		                string in_ssn_mask_type = '',
										string32 appType,
                    boolean includeCriminalIndicators=false) := function
		  return by_rmsid(get_rmsids_from_tmsids(in_tmsids),in_ssn_mask_type,appType,includeCriminalIndicators);
		end;
		
		// Returns the liens data in the source view using dids as a lookup mechanism.
		export by_did(dataset(doxie.layout_references) in_dids,
		              string in_ssn_mask_type = '',
									string1 in_party_type = '',
									string32 appType,
                  boolean includeCriminalIndicators=false) := function
		  return by_rmsid(get_rmsids_from_dids(in_dids, , , in_party_type),in_ssn_mask_type,appType,includeCriminalIndicators);
		end;
		
		// Returns the liens data in the source view using bdids as a lookup mechanism.
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		               unsigned in_limit = 0,
		               string in_ssn_mask_type = '',
									 string1 in_party_type = '',
									 string32 appType,
                   boolean includeCriminalIndicators=false) := function
		  return by_rmsid(get_rmsids_from_bdids(in_bdids,in_limit, ,in_party_type),in_ssn_mask_type,appType,includeCriminalIndicators);
		end;
	end;
end;