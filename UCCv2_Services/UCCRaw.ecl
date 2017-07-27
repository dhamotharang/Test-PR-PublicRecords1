import BIPV2, doxie, doxie_cbrs, UCCv2, suppress,autokeyb2,BatchServices,ut,DNB_dmi,tools, FCRA, AutoStandardI, FFD;

// This module provides UCC data in different formats.
export UCCRaw := module

  // Gets RMSIDs from TMSIDs
	export get_rmsids_from_tmsids(dataset(UCCv2_Services.layout_tmsid) in_tmsids) := function
	  key := UCCV2.Key_Rmsid_Main ();
		res := join(dedup(sort(in_tmsids,tmsid),tmsid),key,
		            keyed(left.tmsid = right.tmsid),
								transform(UCCv2_Services.layout_rmsid,self := right),
								limit(10000,skip));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
	// Gets RMSIDs from DIDs
	// FCRA: this function is for producing internal IDs, no overrides required
	export get_rmsids_from_dids(dataset(doxie.layout_references) in_dids,string1 in_party_type = '', boolean IsFCRA = false) := function
	  key := uccv2.key_did_w_Type (IsFCRA);
		res := join(dedup(sort(in_dids,did),did),key,
		            keyed(left.did = right.did) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_rmsid,self := right),
								limit(10000,skip));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;

	// Gets RMSIDs from BDIDs
	export get_rmsids_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
	                             unsigned in_limit = 0, boolean isMoxie = false,
															 string1 in_party_type = '') := function
	  key := UCCV2.Key_Bdid_w_Type;
		res_r := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.bdid) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_rmsid,self := right),
								limit(10000,skip));
		res_m := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.bdid) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_rmsid,self := right),
								limit(500,skip));
		res := if(isMoxie,res_m,res_r);
		ded := dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;

	// Gets RMSIDs from Filing Number
	export get_rmsids_from_Filing_Number(dataset(UCCv2_Services.layout_filing_number) in_filing_number) := function
		key := UCCV2.Key_filing_number;
		res := join(dedup(sort(in_filing_number,filing_number),filing_number),key,
								keyed(left.filing_number = right.filing_number),
								transform(UCCv2_Services.layout_rmsid, self := right),
								limit(1000,skip));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;

	// Gets RMSIDs from FEIN
	export get_rmsids_from_FEIN(dataset(UCCv2_Services.layout_fein) in_fein) := function
		key := UCCV2.Key_Fein;
		res := join(dedup(sort(in_fein,fein),fein),key,
								keyed(left.fein = right.fein),
								transform(UCCv2_Services.layout_rmsid, self := right),
								limit(1000,skip));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
	// Gets TMSIDs from DIDs
	// FCRA: this function is for producing internal IDs, no overrides required
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_dids(dataset(doxie.layout_references) in_dids,
															string1 in_party_type = '',
															boolean IsFCRA = false
															) := function
		key := uccv2.key_did_w_Type (IsFCRA);
		res := join(dedup(sort(in_dids,did),did),key,
								keyed(left.did = right.did) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_tmsid, self := right),
								limit(1000,skip));
		
		return dedup(sort(res,tmsid),tmsid);
	end;

	// Gets TMSIDs from BDIDs
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
	                             unsigned in_limit = 0,
															 string1 in_party_type = '') := function
		key := UCCV2.Key_Bdid_w_Type;
		res := join(dedup(sort(in_bdids,bdid),bdid),key,
								keyed(left.bdid = right.bdid) and
								keyed(in_party_type='' or right.party_type=in_party_type),
								transform(UCCv2_Services.layout_tmsid, self := right),
								limit(1000,skip));
		ded := dedup(sort(res,tmsid),tmsid);
		
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;

  EXPORT get_tmsids_from_linkIds(dataset(BIPV2.IDlayouts.l_xlink_ids) in_linkIds,
															   string1 businessIdFetchLevel,
	                               unsigned in_limit = 0,
															   string1 in_party_type = '') := FUNCTION

		// *** Key fetch to get ucc tmsids from linkids
		ds_ucclink := UCCv2.Key_LinkIds.KeyFetch(in_linkIds, businessIdFetchLevel);
															
		ds_ucckeys := PROJECT(ds_ucclink(party_type != 'A'),
																TRANSFORM(UCCv2_Services.layout_tmsid,
																					SELF := LEFT));																			
																					
																					
		ded := dedup(sort(ds_ucckeys, tmsid), tmsid);

		RETURN if(in_limit = 0, ded, choosen(ded,in_limit));																
	END;

	// Gets TMSIDs from RMSIDs
	// Note: TMSID suppressions not done here. They are being done in the report section
	// and is the responsibility of the caller to suppress them if not using the standard functions
	export get_tmsids_from_rmsids(dataset(UCCv2_Services.layout_rmsid) in_rmsids) := function
	  key := UCCV2.Key_Rmsid;
		res := join(dedup(sort(in_rmsids,rmsid),rmsid),key,
		            keyed(left.rmsid = right.rmsid),
								transform(UCCv2_Services.layout_rmsid, self := right),
								limit(1000,skip));
		
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
  // Returns UCC data in Legacy format (matches old-style UCC)
  export legacy_view := module
	
	  // ...using TMSIDs as the lookup mechanism.
		export raw_by_tmsid(
			dataset(UCCv2_services.layout_tmsid) in_tmsids,
			string in_ssn_mask_type = ''
		) := function
		  return UCCv2_services.Legacy.fn_getUCC_legacy_raw(in_tmsids, in_ssn_mask_type);
		end;

	  // ...using TMSIDs/Levels as the lookup mechanism.
		export raw_with_levels(
			dataset(UCCv2_services.Legacy.layout_levelRec) in_levels,
			string in_ssn_mask_type = ''
		) := function
		  return UCCv2_services.Legacy.fn_getUCC_legacy_rawLevels(in_levels, in_ssn_mask_type);
		end;

	  // ...using TMSIDs as the lookup mechanism.
		export by_tmsid(
			dataset(UCCv2_services.layout_tmsid) in_tmsids,
			string in_ssn_mask_type = ''
		) := function
		  return UCCv2_services.Legacy.fn_getUCC_legacy(in_tmsids, in_ssn_mask_type);
		end;

	  // ...using DIDs as the lookup mechanism.
	  export by_did(dataset(doxie.layout_references) in_dids,
		              string in_ssn_mask_type = '',
									string1 in_party_type = '') := function
		  return by_tmsid(get_tmsids_from_dids(in_dids,in_party_type),in_ssn_mask_type);
		end;
		
		// ...using BDIDs as the lookup mechanism.
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		               unsigned in_limit = 0,
		               string in_ssn_mask_type = '',
									 string1 in_party_type = '') := function
		  return by_tmsid(get_tmsids_from_bdids(in_bdids,in_limit,in_party_type),in_ssn_mask_type);
		end;
		
		// ...using both DIDs & BDIDs as the lookup mechanism.
		export by_both_ids(
			dataset(doxie.layout_references) in_dids,
			dataset(doxie_cbrs.layout_references) in_bdids,
			string in_ssn_mask_type = '',
			string1 in_party_type = '') := function
			
		  tmsids := dedup(
				get_tmsids_from_dids(in_dids,in_party_type)
					+ get_tmsids_from_bdids(in_bdids,0,in_party_type),
				record,
				all
			);
			
		  return by_tmsid(tmsids,in_ssn_mask_type);
		end;
	end;
	
  // Returns UCC data in the report summary view (grouped and rolled up by TMSID)
  export report_view := module
	
	  // ...using TMSIDs as the lookup mechanism.
		export by_tmsid(
			dataset(UCCv2_services.layout_tmsid) in_tmsids,
			string in_ssn_mask_type = '',
			boolean IsFCRA = false,
			dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
			dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0
		) := function
		  return UCCv2_services.fn_getUCC_tmsid (in_tmsids, in_ssn_mask_type, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
		end;

	  // ...using DIDs as the lookup mechanism.
	  export by_did(dataset(doxie.layout_references) in_dids,
		              string in_ssn_mask_type = '',
									string1 in_party_type = '',
									boolean IsFCRA = false,
									dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
									dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
									integer8 inFFDOptionsMask = 0
		) := function
			tmsids := get_tmsids_from_dids(in_dids,in_party_type,IsFCRA);
			res := by_tmsid(tmsids,in_ssn_mask_type, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
		  return res;
		end;

		// ...using BDIDs as the lookup mechanism.
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		               unsigned in_limit = 0,
		               string in_ssn_mask_type = '',
									 string1 in_party_type = ''
									 ) := function
		  return by_tmsid(get_tmsids_from_bdids(in_bdids,in_limit,in_party_type),in_ssn_mask_type);
		end;
	end;

	// Returns UCC data in the moxie view (ungrouped and not rolled up)
	export moxie_view := module
	
	  // ...using tmsids as a lookup mechanism.
		export by_rmsid(
			dataset(UCCv2_services.layout_rmsid) in_rmsids,
			string in_ssn_mask_type,
			string32	appType	=	Suppress.Constants.ApplicationTypes.DEFAULT
		) := function
			key_main	:= UCCV2.Key_Rmsid_Main ();
			key_party	:= UCCV2.Key_Rmsid_Party ();
			rmsids		:= dedup(sort(in_rmsids,tmsid,rmsid),tmsid,rmsid);
			res_main	:= join(
				rmsids, key_main,
				keyed(left.tmsid = right.tmsid) and keyed(left.rmsid = right.rmsid),
				limit(10000,skip)
			);
			// output(in_rmsids, named('in_rmsids')); 								// DEBUG
			// output(res_main, named('res_main')); 									// DEBUG
			
			res_party_raw := join(
				rmsids, key_party,
				keyed(left.tmsid = right.tmsid) and keyed(left.rmsid = right.rmsid),
				limit(10000,skip)
			);

			//pt was defaulting to 5 here and 20 in globalmodule, but uccsearchservice has #stored('PenaltThreshold',20) so i think we are ok
			unsigned2 pt := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
			party_rec := record
				unsigned2 penalt;
				res_party_raw;
			end;
			party_rec partyjoin(res_party_raw R) := TRANSFORM
				penalt :=
					doxie.FN_Tra_Penalty_DID( (string)R.did ) +
					doxie.FN_Tra_Penalty_SSN(R.ssn) +
					doxie.FN_Tra_Penalty_Name(R.fname, R.mname, R.lname) +
					doxie.FN_Tra_Penalty_BDID( (string)R.bdid ) +
					doxie.FN_Tra_Penalty_CName(R.company_name) +
					doxie.FN_Tra_Penalty_addr(R.predir,R.prim_range,R.prim_name,R.suffix,R.postdir,R.sec_range,R.v_city_name,R.st,R.zip5);
				self.penalt := penalt;
				SELF.orig_name := IF(R.party_type='D' AND penalt>pt, SKIP, R.orig_name);
				SELF := R;
			END;
			res_party := project(res_party_raw, partyjoin(LEFT));
			// output(res_party, named('res_party')); 									// DEBUG
			// output(res_party(party_type='D'), named('res_party_d'));	// DEBUG
			
			res_joined := join(
				res_main, res_party,
				left.tmsid = right.tmsid and left.rmsid = right.rmsid,
				left outer,
				keep(10000)
			);
			Suppress.MAC_Mask(res_joined, res_masked, ssn, null, true, false, maskVal:=in_ssn_mask_type);
			Suppress.MAC_Suppress(res_masked,res_suppress,appType,,,Suppress.Constants.DocTypes.UCC_TMSID,tmsid);
			
			return dedup(sort(res_suppress,record),record);
		end;
		
	  // ...using dids as a lookup mechanism.
	  export by_did(dataset(doxie.layout_references) in_dids,
		              string in_ssn_mask_type = '',
									string1 in_party_type = '') := function
			return by_rmsid(get_rmsids_from_dids(in_dids,in_party_type),in_ssn_mask_type);
		end;
		
		// ...using bdids as a lookup mechanism.
		export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
		               string in_ssn_mask_type = '',
									 string1 in_party_type = '') := function
			return by_rmsid(get_rmsids_from_bdids(in_bdids,,,in_party_type),in_ssn_mask_type);
		end;
	end;
	
	// Returns UCC data in the source view (grouped and rolled up by RMSID)
	export source_view := module
	
	  // ...using rmsids as a lookup mechanism.
		export by_rmsid(
			dataset(UCCv2_services.layout_rmsid) in_rmsids,
			string in_ssn_mask_type,
			BOOLEAN return_multiple_pages = FALSE,
			string32 appType
		) := function
		  return UCCv2_Services.fn_getUCC_rmsid(in_rmsids, in_ssn_mask_type, return_multiple_pages,appType);
		end;
		
		// ...using tmsids as a lookup mechanism.
		export by_tmsid(
			dataset(UCCv2_services.layout_tmsid) in_tmsids,
			string in_ssn_mask_type = '',
			BOOLEAN return_multiple_pages = FALSE,
			string32 appType
		) := function
		  return by_rmsid(get_rmsids_from_tmsids(in_tmsids), in_ssn_mask_type, return_multiple_pages,appType);
		end;
		
		// ...using dids as a lookup mechanism.
		export by_did(
			dataset(doxie.layout_references) in_dids,
			string in_ssn_mask_type = '',
			string1 in_party_type = '',
			string32 appType
		) := function
		  return by_rmsid(get_rmsids_from_dids(in_dids,in_party_type), in_ssn_mask_type, false, appType);
		end;
		
		// ...using bdids as a lookup mechanism.
		export by_bdid(
			dataset(doxie_cbrs.layout_references) in_bdids,
			unsigned in_limit = 0,
			string in_ssn_mask_type = '',
			string1 in_party_type = '',
			string32 appType
		) := function
		  return by_rmsid(get_rmsids_from_bdids(in_bdids,in_limit,,in_party_type), in_ssn_mask_type, false, appType);
		end;
	end;

  /* UCC Reverse serach logic*/
	export thor_view := MODULE
	
	  // shared filename(string filetype) := FUNCTION
		    // ver := did_add.get_EnvVariable('UCC_version');
				// thor_data400::base::ucc::partyw20081009-205030				
				// fn := MAP(filetype='MAIN' => cluster.cluster_out+'base::ucc::main'+WID
				//           filetype='PARTY' => cluster.cluster_out+'base::ucc::party'+WID
				//          );     

		// END;

		//input interface
		shared inp_rec := assorted_layouts.inp_rec;
    
		/* Tmsids by SIC code*/
		export tmsid_by_SIC(inp_rec inp_data) := FUNCTION
		    sic := inp_data.sic_code;
		    in_st := inp_data.st;
				zip5 := inp_data.Secured_zip5;
				bdids := dnb_dmi.files(,tools._Constants.IsDataland).base.companies.qa	//will hit production file when on dataland
				(bdid <> 0 and rawfields.sic1 =sic 
				                           and (in_st='' or clean_address.st =in_st) 
																	 and(zip5=0 or clean_address.zip=(string)zip5));

				tmsids := JOIN(DATASET(ut.foreign_prod + 'thor_data400::' + 'base::ucc::party',UCCv2.Layout_UCC_Common.Layout_Party , thor)(party_type='S'),bdids
				// tmsids := JOIN(UCCV2.File_UCC_Party_Base(party_type='S'),bdids
											,LEFT.bdid = RIGHT.bdid
											,TRANSFORM(assorted_layouts.tmsid_acctno,SELF.acctno := inp_data.acctno,SELF := LEFT)
											,lookup
											);
				RETURN tmsids;							
		END;
		
		/* Tmsids by filing number*/
		export tmsid_by_filNum(inp_rec inp_data) := FUNCTION
				RETURN PROJECT(INDEX(UCCV2.File_UCC_Main_Base  ,{filing_number},{tmsid,rmsid},ut.foreign_prod + 'thor_data400::key::ucc::filing_Number_' + Doxie.Version_SuperKey)(filing_number = inp_data.filing_number)
				// RETURN PROJECT(UCCV2.Key_filing_number(filing_number = inp_data.filing_number)
											,TRANSFORM(assorted_layouts.tmsid_acctno,SELF.acctno := inp_data.acctno,SELF := LEFT));
		END;

    /* Tmsids by filing date*/
		export tmsid_by_filDT(inp_rec inp_data) := FUNCTION
			RETURN PROJECT(IF( inp_data.Fg_StartDate<>'' and inp_data.Fg_EndDate<>''
												,INDEX(TABLE(UCCV2.File_UCC_Main_Base, {Filing_date ,tmsid,rmsid})  ,{filing_date},{tmsid,rmsid},ut.foreign_prod + 'thor_data400::key::ucc::filing_date_' + Doxie.Version_SuperKey)(filing_date >= inp_data.Fg_StartDate and filing_date <= inp_data.Fg_EndDate)
												// ,UCCV2.Key_filing_date(filing_date >= inp_data.Fg_StartDate and filing_date <= inp_data.Fg_EndDate)
												,IF( inp_data.Fg_StartDate<>''
														 ,INDEX(TABLE(UCCV2.File_UCC_Main_Base, {Filing_date ,tmsid,rmsid})  ,{filing_date},{tmsid,rmsid},ut.foreign_prod + 'thor_data400::key::ucc::filing_date_' + Doxie.Version_SuperKey)(filing_date >= inp_data.Fg_StartDate)
														 // ,UCCV2.Key_filing_date(filing_date >= inp_data.Fg_StartDate)
												,IF( inp_data.Fg_EndDate<>''		 
														,INDEX(TABLE(UCCV2.File_UCC_Main_Base, {Filing_date ,tmsid,rmsid})  ,{filing_date},{tmsid,rmsid},ut.foreign_prod + 'thor_data400::key::ucc::filing_date_' + Doxie.Version_SuperKey)(filing_date <= inp_data.Fg_EndDate)
														// ,UCCV2.Key_filing_date(filing_date <= inp_data.Fg_EndDate)
														,DATASET([],recordof(INDEX(TABLE(UCCV2.File_UCC_Main_Base, {Filing_date ,tmsid,rmsid})  ,{filing_date},{tmsid,rmsid},ut.foreign_prod + 'thor_data400::key::ucc::filing_date_' + Doxie.Version_SuperKey))))))
														// ,DATASET([],recordof(UCCV2.Key_filing_date)))))
														,TRANSFORM(assorted_layouts.tmsid_acctno,SELF.acctno := inp_data.acctno,SELF := LEFT));
	 ENd;
	 
	 /* Macro to match Cname and Secured parties only - UCC THOR2SErvice */
	 export  cname_match2() := MACRO    
			(%cleaned_in%.comp_name_indic_value = ''
										 OR
										 (AutokeyB2.is_CNameIndicMatch(
																			   datalib.companyclean(company_name)[1..40]
																			 , %cleaned_in%.comp_name_indic_value)
											AND 
											ut.CS100S.current(
																				datalib.companyclean(company_name)[1..40]  
																			 ,datalib.companyclean(company_name)[41..80]
																			 , %cleaned_in%.comp_name_indic_value
																			 , %cleaned_in%.comp_name_sec_value) < 50
											))
											and party_type='S'
	ENDMACRO;
		
	/* Macro to match Cname  - UCC THORSErvice */	
	export 	cname_match() := MACRO
										 (inp_data.comp_name_indic_value = ''
										 OR
										 (AutokeyB2.is_CNameIndicMatch(
																			 cname_indic
																			 , inp_data.comp_name_indic_value)
											AND 
											ut.CS100S.current(
																				cname_indic  
																			 ,cname_sec
																			 , inp_data.comp_name_indic_value
																			 , inp_data.comp_name_sec_value) < 50
											))
		ENDMACRO;
		
		/* Tmsids by Autokey Fetch*/
		export tmsid_by_ak(inp_rec inp_data) := FUNCTION
				//declaration
				constants		:= UCCV2.Constants(UCCv2.Version.key);
				ak_keyname	:= constants.ak_keyname;
				ak_typeStr	:= constants.ak_typeStr;
				ak_dataset	:= UCCV2.file_SearchAutokey;
				out_rec := autokeyb2.layout_fetch;
				
				//Index read
				zip_kb 	:= autokeyb2.key_zip(ak_keyname);
				st_kb 	:= autokeyb2.Key_StName(ak_keyname);
				cn_kb 	:= autokeyb2.Key_Name(ak_keyname);
		
				//Index filters
				ftr_zip := PROJECT(zip_kb(keyed (zip = inp_data.secured_zip5)
													 and cname_match() ),out_rec);
				
				ftr_st := IF(inp_data.secured_zip5=0,PROJECT(st_kb(keyed (st = inp_data.st)
												and cname_match()),out_rec),DATASET([],out_rec));

				ftr_cn := IF(inp_data.secured_zip5=0 and inp_data.st ='' 
				             ,PROJECT( cn_kb(cname_match()),out_rec)
										 ,DATASET([],out_rec));		

				//Autokey IDS
				ak_fids := ftr_zip + ftr_st + ftr_cn;
				ak_ids := SORT(DISTRIBUTE(ak_fids,HASH32(bdid)),bdid,local) ;
											// ,DATASET([],out_rec));
				//tmsids by autokeys
				ak_tmsids := JOIN(ak_ids,UCCV2.key_payload
				             ,RIGHT.party_type='S' 
										  and 
										  RIGHT.fakeid =LEFT.bdid
										 ,TRANSFORM(assorted_layouts.tmsid_acctno,SELF.acctno := inp_data.acctno,SELF := RIGHT)
										 ,local,NOSORT);
		
				RETURN ak_tmsids;
			END;
			
			/* Retrieves the final batch layout*/
			EXPORT get_thor_layout(DATASET(assorted_layouts.tmsid_acctno) tmsids, inp_rec inp_data, string32	appType	=	Suppress.Constants.ApplicationTypes.DEFAULT) := FUNCTION
		
					
					 thor_layout := BatchServices.layout_UCCLiens_Batch_out;
					  tmsids_dis := SORT(DISTRIBUTE(tmsids,HASH32(tmsid)),tmsid,local);
						
						/* Final Fetch using Key files */
						main_recs := JOIN(tmsids_dis,INDEX(dataset([],UCCV2.Layout_UCC_Common.Layout_UCC_New) ,{tmsid,rmsid},{UCCV2.Layout_UCC_Common.Layout_UCC_New - [tmsid,rmsid]},ut.foreign_prod + 'thor_data400::key::ucc::main_Rmsid_' +  doxie.Version_SuperKey)
						// main_recs := JOIN(tmsids_dis,UCCV2.Key_Rmsid_Main
															,LEFT.tmsid = RIGHT.tmsid
															,local);
						main_recs_ded := DEDUP(SORT(main_recs,tmsid,local),tmsid,local);
				    
						/*debtor zip exists*/
				    deb_ftr_recs :=   JOIN(main_recs,INDEX(dataset([],UCCV2.Layout_UCC_Common.Layout_Party) ,{tmsid,rmsid},{UCCV2.Layout_UCC_Common.Layout_Party - [tmsid,rmsid]},ut.foreign_prod + 'thor_data400::key::ucc::party_Rmsid_' + Doxie.Version_SuperKey)
				    // deb_ftr_recs :=   JOIN(main_recs,UCCV2.Key_Rmsid_Party
  																 ,
																	 LEFT.tmsid = RIGHT.tmsid
																	 and 
																	 RIGHT.party_type ='D'
																	 and 
																	 (unsigned6)RIGHT.zip5 in inp_data.debtor_zip5
																	 ,TRANSFORM(recordof(main_recs),SELF := LEFT)
																	 ,local
																	 );
								
						in_party_recs := IF(EXISTS(inp_data.debtor_zip5) and inp_data.debtor_zip5[1] <> 0,deb_ftr_recs,main_recs_ded);
						
						/* complete party info */
						ucc_recs := JOIN(in_party_recs,INDEX(dataset([],UCCV2.Layout_UCC_Common.Layout_Party) ,{tmsid,rmsid},{UCCV2.Layout_UCC_Common.Layout_Party - [tmsid,rmsid]},ut.foreign_prod + 'thor_data400::key::ucc::party_Rmsid_' + Doxie.Version_SuperKey)
						// ucc_recs := JOIN(in_party_recs,UCCV2.Key_Rmsid_Party
															 ,LEFT.tmsid = RIGHT.tmsid
															 ,local
															 );

            
						/* final fetch using base files */
						/*
            main_recs := JOIN(tmsids_dis,UCCV2.File_UCC_Main_Base
															,LEFT.tmsid = RIGHT.tmsid
															,local);
												 
						ucc_recs := JOIN(main_recs,UCCV2.File_UCC_Party_Name
														 ,LEFT.tmsid = RIGHT.tmsid
														 ,local);		
						
           */
					thor_layout.final_out xfm_final(recordof(ucc_recs) p_ds, unsigned6 cnt) := TRANSFORM
						 pt := p_ds.Party_type;
					  SELF.filing_1_filing_number   := if(cnt =1, p_ds.filing_number,'');  
						SELF.filing_1_filing_type     := if(cnt =1,p_ds.filing_type,'');    
						SELF.filing_1_filing_date     := if(cnt =1,p_ds.filing_date,'');   
						SELF.filing_1_expiration_date := if(cnt =1,p_ds.expiration_date,'');
						SELF.filing_1_contract_type   := if(cnt =1,p_ds.contract_type,'');  
						SELF.filing_1_amount          := if(cnt =1,p_ds.amount,'');
						
					  SELF.filing_2_filing_number   := if(cnt =2, p_ds.filing_number,'');  
						SELF.filing_2_filing_type     := if(cnt =2,p_ds.filing_type,'');    
						SELF.filing_2_filing_date     := if(cnt =2,p_ds.filing_date,'');   
						SELF.filing_2_expiration_date := if(cnt =2,p_ds.expiration_date,'');
						SELF.filing_2_contract_type   := if(cnt =2,p_ds.contract_type,'');  
						SELF.filing_2_amount          := if(cnt =2,p_ds.amount,'');
						
					  SELF.filing_3_filing_number   := if(cnt =3, p_ds.filing_number,'');  
						SELF.filing_3_filing_type     := if(cnt =3,p_ds.filing_type,'');    
						SELF.filing_3_filing_date     := if(cnt =3,p_ds.filing_date,'');   
						SELF.filing_3_expiration_date := if(cnt =3,p_ds.expiration_date,'');
						SELF.filing_3_contract_type   := if(cnt =3,p_ds.contract_type,'');  
						SELF.filing_3_amount          := if(cnt =3,p_ds.amount,'');
						
					  SELF.filing_4_filing_number   := if(cnt =4, p_ds.filing_number,'');  
						SELF.filing_4_filing_type     := if(cnt =4,p_ds.filing_type,'');    
						SELF.filing_4_filing_date     := if(cnt =4,p_ds.filing_date,'');   
						SELF.filing_4_expiration_date := if(cnt =4,p_ds.expiration_date,'');
						SELF.filing_4_contract_type   := if(cnt =4,p_ds.contract_type,'');  
						SELF.filing_4_amount          := if(cnt =4,p_ds.amount,'');
						
					  SELF.filing_5_filing_number   := if(cnt =5, p_ds.filing_number,'');  
						SELF.filing_5_filing_type     := if(cnt =5,p_ds.filing_type,'');    
						SELF.filing_5_filing_date     := if(cnt =5,p_ds.filing_date,'');   
						SELF.filing_5_expiration_date := if(cnt =5,p_ds.expiration_date,'');
						SELF.filing_5_contract_type   := if(cnt =5,p_ds.contract_type,'');  
						SELF.filing_5_amount          := if(cnt =5,p_ds.amount,'');
						
					  SELF.filing_6_filing_number   := if(cnt =6,p_ds.filing_number,'');  
						SELF.filing_6_filing_type     := if(cnt =6,p_ds.filing_type,'');    
						SELF.filing_6_filing_date     := if(cnt =6,p_ds.filing_date,'');   
						SELF.filing_6_expiration_date := if(cnt =6,p_ds.expiration_date,'');
						SELF.filing_6_contract_type   := if(cnt =6,p_ds.contract_type,'');  
						SELF.filing_6_amount          := if(cnt =6,p_ds.amount,'');
						
						SELF.debtor_1_party_1_orig_name   := if(pt ='D' and cnt =1 ,p_ds.orig_name,'');
						SELF.debtor_1_party_1_addr_1      := if(pt ='D' and cnt =1 ,p_ds.orig_address1,'');
						SELF.debtor_1_party_1_addr_2      := if(pt ='D' and cnt =1 ,p_ds.orig_address2,'');
						SELF.debtor_1_party_1_v_city_name := if(pt ='D' and cnt =1 ,p_ds.v_city_name,'');
						SELF.debtor_1_party_1_st          := if(pt ='D' and cnt =1 ,p_ds.st,'');
						SELF.debtor_1_party_1_zip         := if(pt ='D' and cnt =1 ,p_ds.zip5,'');
						SELF.debtor_1_party_2_addr_1      := if(pt ='D' and cnt =1 ,p_ds.orig_address1,'');
						SELF.debtor_1_party_2_addr_2      := if(pt ='D' and cnt =1 ,p_ds.orig_address2,'');
						SELF.debtor_1_party_2_v_city_name := if(pt ='D' and cnt =1 ,p_ds.v_city_name,'');
						SELF.debtor_1_party_2_st          := if(pt ='D' and cnt =1 ,p_ds.st,'');
						SELF.debtor_1_party_2_zip         := if(pt ='D' and cnt =1 ,p_ds.zip5,'');
						
						SELF.debtor_2_party_1_orig_name   := if(pt ='D' and cnt =2 ,p_ds.orig_name,'');
						SELF.debtor_2_party_1_addr_1      := if(pt ='D' and cnt =2 ,p_ds.orig_address1,'');
						SELF.debtor_2_party_1_addr_2      := if(pt ='D' and cnt =2 ,p_ds.orig_address2,'');
						SELF.debtor_2_party_1_v_city_name := if(pt ='D' and cnt =2 ,p_ds.v_city_name,'');
						SELF.debtor_2_party_1_st          := if(pt ='D' and cnt =2 ,p_ds.st,'');
						SELF.debtor_2_party_1_zip         := if(pt ='D' and cnt =2 ,p_ds.zip5,'');
						SELF.debtor_2_party_2_addr_1      := if(pt ='D' and cnt =2 ,p_ds.orig_address1,'');
						SELF.debtor_2_party_2_addr_2      := if(pt ='D' and cnt =2 ,p_ds.orig_address2,'');
						SELF.debtor_2_party_2_v_city_name := if(pt ='D' and cnt =2 ,p_ds.v_city_name,'');
						SELF.debtor_2_party_2_st          := if(pt ='D' and cnt =2 ,p_ds.st,'');
						SELF.debtor_2_party_2_zip         := if(pt ='D' and cnt =2 ,p_ds.zip5,'');

						SELF.debtor_3_party_1_orig_name   := if(pt ='D' and cnt =3 ,p_ds.orig_name,'');
						SELF.debtor_3_party_1_addr_1      := if(pt ='D' and cnt =3 ,p_ds.orig_address1,'');
						SELF.debtor_3_party_1_addr_2      := if(pt ='D' and cnt =3 ,p_ds.orig_address2,'');
						SELF.debtor_3_party_1_v_city_name := if(pt ='D' and cnt =3 ,p_ds.v_city_name,'');
						SELF.debtor_3_party_1_st          := if(pt ='D' and cnt =3 ,p_ds.st,'');
						SELF.debtor_3_party_1_zip         := if(pt ='D' and cnt =3 ,p_ds.zip5,'');
						SELF.debtor_3_party_2_addr_1      := if(pt ='D' and cnt =3 ,p_ds.orig_address1,'');
						SELF.debtor_3_party_2_addr_2      := if(pt ='D' and cnt =3 ,p_ds.orig_address2,'');
						SELF.debtor_3_party_2_v_city_name := if(pt ='D' and cnt =3 ,p_ds.v_city_name,'');
						SELF.debtor_3_party_2_st          := if(pt ='D' and cnt =3 ,p_ds.st,'');
						SELF.debtor_3_party_2_zip         := if(pt ='D' and cnt =3 ,p_ds.zip5,'');

						SELF.debtor_4_party_1_orig_name   := if(pt ='D' and cnt =4 ,p_ds.orig_name,'');
						SELF.debtor_4_party_1_addr_1      := if(pt ='D' and cnt =4 ,p_ds.orig_address1,'');
						SELF.debtor_4_party_1_addr_2      := if(pt ='D' and cnt =4 ,p_ds.orig_address2,'');
						SELF.debtor_4_party_1_v_city_name := if(pt ='D' and cnt =4 ,p_ds.v_city_name,'');
						SELF.debtor_4_party_1_st          := if(pt ='D' and cnt =4 ,p_ds.st,'');
						SELF.debtor_4_party_1_zip         := if(pt ='D' and cnt =4 ,p_ds.zip5,'');
						SELF.debtor_4_party_2_addr_1      := if(pt ='D' and cnt =4 ,p_ds.orig_address1,'');
						SELF.debtor_4_party_2_addr_2      := if(pt ='D' and cnt =4 ,p_ds.orig_address2,'');
						SELF.debtor_4_party_2_v_city_name := if(pt ='D' and cnt =4 ,p_ds.v_city_name,'');
						SELF.debtor_4_party_2_st          := if(pt ='D' and cnt =4 ,p_ds.st,'');
						SELF.debtor_4_party_2_zip         := if(pt ='D' and cnt =4 ,p_ds.zip5,'');

						SELF.debtor_5_party_1_orig_name   := if(pt ='D' and cnt =5 ,p_ds.orig_name,'');
						SELF.debtor_5_party_1_addr_1      := if(pt ='D' and cnt =5 ,p_ds.orig_address1,'');
						SELF.debtor_5_party_1_addr_2      := if(pt ='D' and cnt =5 ,p_ds.orig_address2,'');
						SELF.debtor_5_party_1_v_city_name := if(pt ='D' and cnt =5 ,p_ds.v_city_name,'');
						SELF.debtor_5_party_1_st          := if(pt ='D' and cnt =5 ,p_ds.st,'');
						SELF.debtor_5_party_1_zip         := if(pt ='D' and cnt =5 ,p_ds.zip5,'');
						SELF.debtor_5_party_2_addr_1      := if(pt ='D' and cnt =5 ,p_ds.orig_address1,'');
						SELF.debtor_5_party_2_addr_2      := if(pt ='D' and cnt =5 ,p_ds.orig_address2,'');
						SELF.debtor_5_party_2_v_city_name := if(pt ='D' and cnt =5 ,p_ds.v_city_name,'');
						SELF.debtor_5_party_2_st          := if(pt ='D' and cnt =5 ,p_ds.st,'');
						SELF.debtor_5_party_2_zip         := if(pt ='D' and cnt =5 ,p_ds.zip5,'');

						SELF.debtor_6_party_1_orig_name   := if(pt ='D' and cnt =6 ,p_ds.orig_name,'');
						SELF.debtor_6_party_1_addr_1      := if(pt ='D' and cnt =6 ,p_ds.orig_address1,'');
						SELF.debtor_6_party_1_addr_2      := if(pt ='D' and cnt =6 ,p_ds.orig_address2,'');
						SELF.debtor_6_party_1_v_city_name := if(pt ='D' and cnt =6 ,p_ds.v_city_name,'');
						SELF.debtor_6_party_1_st          := if(pt ='D' and cnt =6 ,p_ds.st,'');
						SELF.debtor_6_party_1_zip         := if(pt ='D' and cnt =6 ,p_ds.zip5,'');
						SELF.debtor_6_party_2_addr_1      := if(pt ='D' and cnt =6 ,p_ds.orig_address1,'');
						SELF.debtor_6_party_2_addr_2      := if(pt ='D' and cnt =6 ,p_ds.orig_address2,'');
						SELF.debtor_6_party_2_v_city_name := if(pt ='D' and cnt =6 ,p_ds.v_city_name,'');
						SELF.debtor_6_party_2_st          := if(pt ='D' and cnt =6 ,p_ds.st,'');
						SELF.debtor_6_party_2_zip         := if(pt ='D' and cnt =6 ,p_ds.zip5,'');
						
						
						SELF.debtor_7_party_1_orig_name   := if(pt ='D' and cnt =7 ,p_ds.orig_name,'');
						SELF.debtor_7_party_1_addr_1      := if(pt ='D' and cnt =7 ,p_ds.orig_address1,'');
						SELF.debtor_7_party_1_addr_2      := if(pt ='D' and cnt =7 ,p_ds.orig_address2,'');
						SELF.debtor_7_party_1_v_city_name := if(pt ='D' and cnt =7 ,p_ds.v_city_name,'');
						SELF.debtor_7_party_1_st          := if(pt ='D' and cnt =7 ,p_ds.st,'');
						SELF.debtor_7_party_1_zip         := if(pt ='D' and cnt =7 ,p_ds.zip5,'');
						SELF.debtor_7_party_2_addr_1      := if(pt ='D' and cnt =7 ,p_ds.orig_address1,'');
						SELF.debtor_7_party_2_addr_2      := if(pt ='D' and cnt =7 ,p_ds.orig_address2,'');
						SELF.debtor_7_party_2_v_city_name := if(pt ='D' and cnt =7 ,p_ds.v_city_name,'');
						SELF.debtor_7_party_2_st          := if(pt ='D' and cnt =7 ,p_ds.st,'');
						SELF.debtor_7_party_2_zip         := if(pt ='D' and cnt =7 ,p_ds.zip5,'');						
						
						SELF.debtor_8_party_1_orig_name   := if(pt ='D' and cnt =8 ,p_ds.orig_name,'');
						SELF.debtor_8_party_1_addr_1      := if(pt ='D' and cnt =8 ,p_ds.orig_address1,'');
						SELF.debtor_8_party_1_addr_2      := if(pt ='D' and cnt =8 ,p_ds.orig_address2,'');
						SELF.debtor_8_party_1_v_city_name := if(pt ='D' and cnt =8 ,p_ds.v_city_name,'');
						SELF.debtor_8_party_1_st          := if(pt ='D' and cnt =8 ,p_ds.st,'');
						SELF.debtor_8_party_1_zip         := if(pt ='D' and cnt =8 ,p_ds.zip5,'');
						SELF.debtor_8_party_2_addr_1      := if(pt ='D' and cnt =8 ,p_ds.orig_address1,'');
						SELF.debtor_8_party_2_addr_2      := if(pt ='D' and cnt =8 ,p_ds.orig_address2,'');
						SELF.debtor_8_party_2_v_city_name := if(pt ='D' and cnt =8 ,p_ds.v_city_name,'');
						SELF.debtor_8_party_2_st          := if(pt ='D' and cnt =8 ,p_ds.st,'');
						SELF.debtor_8_party_2_zip         := if(pt ='D' and cnt =8 ,p_ds.zip5,'');

						SELF.debtor_9_party_1_orig_name   := if(pt ='D' and cnt =9 ,p_ds.orig_name,'');
						SELF.debtor_9_party_1_addr_1      := if(pt ='D' and cnt =9 ,p_ds.orig_address1,'');
						SELF.debtor_9_party_1_addr_2      := if(pt ='D' and cnt =9 ,p_ds.orig_address2,'');
						SELF.debtor_9_party_1_v_city_name := if(pt ='D' and cnt =9 ,p_ds.v_city_name,'');
						SELF.debtor_9_party_1_st          := if(pt ='D' and cnt =9 ,p_ds.st,'');
						SELF.debtor_9_party_1_zip         := if(pt ='D' and cnt =9 ,p_ds.zip5,'');
						SELF.debtor_9_party_2_addr_1      := if(pt ='D' and cnt =9 ,p_ds.orig_address1,'');
						SELF.debtor_9_party_2_addr_2      := if(pt ='D' and cnt =9 ,p_ds.orig_address2,'');
						SELF.debtor_9_party_2_v_city_name := if(pt ='D' and cnt =9 ,p_ds.v_city_name,'');
						SELF.debtor_9_party_2_st          := if(pt ='D' and cnt =9 ,p_ds.st,'');
						SELF.debtor_9_party_2_zip         := if(pt ='D' and cnt =9 ,p_ds.zip5,'');
						
						
						SELF.debtor_10_party_1_orig_name   := if(pt ='D' and cnt =10 ,p_ds.orig_name,'');
						SELF.debtor_10_party_1_addr_1      := if(pt ='D' and cnt =10 ,p_ds.orig_address1,'');
						SELF.debtor_10_party_1_addr_2      := if(pt ='D' and cnt =10 ,p_ds.orig_address2,'');
						SELF.debtor_10_party_1_v_city_name := if(pt ='D' and cnt =10 ,p_ds.v_city_name,'');
						SELF.debtor_10_party_1_st          := if(pt ='D' and cnt =10 ,p_ds.st,'');
						SELF.debtor_10_party_1_zip         := if(pt ='D' and cnt =10 ,p_ds.zip5,'');
						SELF.debtor_10_party_2_addr_1      := if(pt ='D' and cnt =10 ,p_ds.orig_address1,'');
						SELF.debtor_10_party_2_addr_2      := if(pt ='D' and cnt =10 ,p_ds.orig_address2,'');
						SELF.debtor_10_party_2_v_city_name := if(pt ='D' and cnt =10 ,p_ds.v_city_name,'');
						SELF.debtor_10_party_2_st          := if(pt ='D' and cnt =10 ,p_ds.st,'');
						SELF.debtor_10_party_2_zip         := if(pt ='D' and cnt =10 ,p_ds.zip5,'');

						sec_jurs := p_ds.filing_jurisdiction;
						
						SELF.secured_1_orig_name   := IF( (pt='S' or pt='C') and cnt=1, p_ds.orig_name                ,'');
						SELF.secured_1_addr_1      := IF( (pt='S' or pt='C') and cnt=1, p_ds.orig_address1    ,'');
						SELF.secured_1_addr_2      := IF( (pt='S' or pt='C') and cnt=1, p_ds.orig_address2    ,'');
						SELF.secured_1_v_city_name := IF( (pt='S' or pt='C') and cnt=1, p_ds.v_city_name ,'');
						SELF.secured_1_st          := IF( (pt='S' or pt='C') and cnt=1, p_ds.st          ,'');
						SELF.secured_1_zip         := IF( (pt='S' or pt='C') and cnt=1, p_ds.zip5        ,'');
						
						SELF.secured_2_orig_name   := IF( (pt='S' or pt='C') and cnt=2, p_ds.orig_name                ,'');
						SELF.secured_2_addr_1      := IF( (pt='S' or pt='C') and cnt=2, p_ds.orig_address1    ,'');
						SELF.secured_2_addr_2      := IF( (pt='S' or pt='C') and cnt=2, p_ds.orig_address2    ,'');
						SELF.secured_2_v_city_name := IF( (pt='S' or pt='C') and cnt=2, p_ds.v_city_name ,'');
						SELF.secured_2_st          := IF( (pt='S' or pt='C') and cnt=2, p_ds.st          ,'');
						SELF.secured_2_zip         := IF( (pt='S' or pt='C') and cnt=2, p_ds.zip5        ,'');
						
						SELF.secured_3_orig_name   := IF( (pt='S' or pt='C') and cnt=3, p_ds.orig_name                ,'');
						SELF.secured_3_addr_1      := IF( (pt='S' or pt='C') and cnt=3, p_ds.orig_address1    ,'');
						SELF.secured_3_addr_2      := IF( (pt='S' or pt='C') and cnt=3, p_ds.orig_address2    ,'');
						SELF.secured_3_v_city_name := IF( (pt='S' or pt='C') and cnt=3, p_ds.v_city_name ,'');
						SELF.secured_3_st          := IF( (pt='S' or pt='C') and cnt=3, p_ds.st          ,'');
						SELF.secured_3_zip         := IF( (pt='S' or pt='C') and cnt=3, p_ds.zip5        ,'');
						
						SELF.secured_4_orig_name   := IF( (pt='S' or pt='C') and cnt=4, p_ds.orig_name                ,'');
						SELF.secured_4_addr_1      := IF( (pt='S' or pt='C') and cnt=4, p_ds.orig_address1    ,'');
						SELF.secured_4_addr_2      := IF( (pt='S' or pt='C') and cnt=4, p_ds.orig_address2    ,'');
						SELF.secured_4_v_city_name := IF( (pt='S' or pt='C') and cnt=4, p_ds.v_city_name ,'');
						SELF.secured_4_st          := IF( (pt='S' or pt='C') and cnt=4, p_ds.st          ,'');
						SELF.secured_4_zip         := IF( (pt='S' or pt='C') and cnt=4, p_ds.zip5        ,'');
						
						SELF.secured_5_orig_name   := IF( (pt='S' or pt='C') and cnt=5, p_ds.orig_name                ,'');
						SELF.secured_5_addr_1      := IF( (pt='S' or pt='C') and cnt=5, p_ds.orig_address1    ,'');
						SELF.secured_5_addr_2      := IF( (pt='S' or pt='C') and cnt=5, p_ds.orig_address2   ,'');
						SELF.secured_5_v_city_name := IF( (pt='S' or pt='C') and cnt=5, p_ds.v_city_name ,'');
						SELF.secured_5_st          := IF( (pt='S' or pt='C') and cnt=5, p_ds.st          ,'');
						SELF.secured_5_zip         := IF( (pt='S' or pt='C') and cnt=5, p_ds.zip5        ,'');
						
						SELF.assignee_1_orig_name   := IF(pt='A' and cnt =1, p_ds.orig_name,'');
						SELF.assignee_1_addr_1      := IF(pt='A' and cnt =1, p_ds.orig_address1,'');
						SELF.assignee_1_addr_2      := IF(pt='A' and cnt =1, p_ds.orig_address2,'');
						SELF.assignee_1_v_city_name := IF(pt='A' and cnt =1, p_ds.v_city_name,'');
						SELF.assignee_1_st          := IF(pt='A' and cnt =1, p_ds.st,'');
						SELF.assignee_1_zip         := IF(pt='A' and cnt =1, p_ds.zip5,'');
						
						SELF.assignee_2_orig_name   := IF(pt='A' and cnt =2, p_ds.orig_name,'');
						SELF.assignee_2_addr_1      := IF(pt='A' and cnt =2, p_ds.orig_address1,'');
						SELF.assignee_2_addr_2      := IF(pt='A' and cnt =2, p_ds.orig_address2,'');
						SELF.assignee_2_v_city_name := IF(pt='A' and cnt =2, p_ds.v_city_name,'');
						SELF.assignee_2_st          := IF(pt='A' and cnt =2, p_ds.st,'');
						SELF.assignee_2_zip         := IF(pt='A' and cnt =2, p_ds.zip5,'');
						
						SELF.assignee_3_orig_name   := IF(pt='A' and cnt =3, p_ds.orig_name,'');
						SELF.assignee_3_addr_1      := IF(pt='A' and cnt =3, p_ds.orig_address1,'');
						SELF.assignee_3_addr_2      := IF(pt='A' and cnt =3, p_ds.orig_address2,'');
						SELF.assignee_3_v_city_name := IF(pt='A' and cnt =3, p_ds.v_city_name,'');
						SELF.assignee_3_st          := IF(pt='A' and cnt =3, p_ds.st,'');
						SELF.assignee_3_zip         := IF(pt='A' and cnt =3, p_ds.zip5,'');
						
						SELF.assignee_4_orig_name   := IF(pt='A' and cnt =4, p_ds.orig_name,'');
						SELF.assignee_4_addr_1      := IF(pt='A' and cnt =4, p_ds.orig_address1,'');
						SELF.assignee_4_addr_2      := IF(pt='A' and cnt =4, p_ds.orig_address2,'');
						SELF.assignee_4_v_city_name := IF(pt='A' and cnt =4, p_ds.v_city_name,'');
						SELF.assignee_4_st          := IF(pt='A' and cnt =4, p_ds.st,'');
						SELF.assignee_4_zip         := IF(pt='A' and cnt =4, p_ds.zip5,'');
						
						SELF.assignee_5_orig_name   := IF(pt='A' and cnt =5, p_ds.orig_name,'');
						SELF.assignee_5_addr_1      := IF(pt='A' and cnt =5, p_ds.orig_address1,'');
						SELF.assignee_5_addr_2      := IF(pt='A' and cnt =5, p_ds.orig_address2,'');
						SELF.assignee_5_v_city_name := IF(pt='A' and cnt =5, p_ds.v_city_name,'');
						SELF.assignee_5_st          := IF(pt='A' and cnt =5, p_ds.st,'');
						SELF.assignee_5_zip         := IF(pt='A' and cnt =5, p_ds.zip5,'');
					 SELF.Filing_status_desc := p_ds.Status_type;				 
           SELF := p_ds;					 
					 SELF :=[];
					END;		 
				  ucc_recs_grp := GROUP(SORT(ucc_recs,tmsid,rmsid,party_type,local),tmsid,rmsid,party_type,local);
					recs_prt := PROJECT(ucc_recs_grp,xfm_final(LEFT,counter),local);

					select_str(string l, string r) := FUNCTION
					  RETURN IF(l<>'',l,r);
					END;
					
					thor_layout.final_out xfm_rollup(recordof(recs_prt) l, recordof(recs_prt) r ) := TRANSFORM
					  SELF.filing_1_filing_number   := select_str(l.filing_1_filing_number,r.filing_1_filing_number);
						SELF.filing_1_filing_type     := select_str(l.filing_1_filing_type,r.filing_1_filing_type);
						SELF.filing_1_filing_date     := select_str(l.filing_1_filing_date,r.filing_1_filing_date);
						SELF.filing_1_expiration_date := select_str(l.filing_1_expiration_date,r.filing_1_expiration_date);
						SELF.filing_1_contract_type   := select_str(l.filing_1_contract_type,r.filing_1_contract_type);
						SELF.filing_1_amount          := select_str(l.filing_1_amount,r.filing_1_amount);
						
					  SELF.filing_2_filing_number   := select_str(l.filing_2_filing_number,r.filing_2_filing_number);
						SELF.filing_2_filing_type     := select_str(l.filing_2_filing_type,r.filing_2_filing_type);
						SELF.filing_2_filing_date     := select_str(l.filing_2_filing_date,r.filing_2_filing_date);
						SELF.filing_2_expiration_date := select_str(l.filing_2_expiration_date,r.filing_2_expiration_date);
						SELF.filing_2_contract_type   := select_str(l.filing_2_contract_type,r.filing_2_contract_type);
						SELF.filing_2_amount          := select_str(l.filing_2_amount,r.filing_2_amount);
												
					  SELF.filing_3_filing_number   := select_str(l.filing_3_filing_number,r.filing_3_filing_number);
						SELF.filing_3_filing_type     := select_str(l.filing_3_filing_type,r.filing_3_filing_type);
						SELF.filing_3_filing_date     := select_str(l.filing_3_filing_date,r.filing_3_filing_date);
						SELF.filing_3_expiration_date := select_str(l.filing_3_expiration_date,r.filing_3_expiration_date);
						SELF.filing_3_contract_type   := select_str(l.filing_3_contract_type,r.filing_3_contract_type);
						SELF.filing_3_amount          := select_str(l.filing_3_amount,r.filing_3_amount);
						
					  SELF.filing_4_filing_number   := select_str(l.filing_4_filing_number,r.filing_4_filing_number);
						SELF.filing_4_filing_type     := select_str(l.filing_4_filing_type,r.filing_4_filing_type);
						SELF.filing_4_filing_date     := select_str(l.filing_4_filing_date,r.filing_4_filing_date);
						SELF.filing_4_expiration_date := select_str(l.filing_4_expiration_date,r.filing_4_expiration_date);
						SELF.filing_4_contract_type   := select_str(l.filing_4_contract_type,r.filing_4_contract_type);
						SELF.filing_4_amount          := select_str(l.filing_4_amount,r.filing_4_amount);
						
					  SELF.filing_5_filing_number   := select_str(l.filing_5_filing_number,r.filing_5_filing_number);
						SELF.filing_5_filing_type     := select_str(l.filing_5_filing_type,r.filing_5_filing_type);
						SELF.filing_5_filing_date     := select_str(l.filing_5_filing_date,r.filing_5_filing_date);
						SELF.filing_5_expiration_date := select_str(l.filing_5_expiration_date,r.filing_5_expiration_date);
						SELF.filing_5_contract_type   := select_str(l.filing_5_contract_type,r.filing_5_contract_type);
						SELF.filing_5_amount          := select_str(l.filing_5_amount,r.filing_5_amount);
						
					  SELF.filing_6_filing_number   := select_str(l.filing_6_filing_number,r.filing_6_filing_number);
						SELF.filing_6_filing_type     := select_str(l.filing_6_filing_type,r.filing_6_filing_type);
						SELF.filing_6_filing_date     := select_str(l.filing_6_filing_date,r.filing_6_filing_date);
						SELF.filing_6_expiration_date := select_str(l.filing_6_expiration_date,r.filing_6_expiration_date);
						SELF.filing_6_contract_type   := select_str(l.filing_6_contract_type,r.filing_6_contract_type);
						SELF.filing_6_amount          := select_str(l.filing_6_amount,r.filing_6_amount);
						
						
						SELF.debtor_1_party_1_orig_name   := select_str(l.debtor_1_party_1_orig_name,r.debtor_1_party_1_orig_name);
						SELF.debtor_1_party_1_addr_1      := select_str(l.debtor_1_party_1_addr_1,r.debtor_1_party_1_addr_1);
						SELF.debtor_1_party_1_addr_2      := select_str(l.debtor_1_party_1_addr_2,r.debtor_1_party_1_addr_2);
						SELF.debtor_1_party_1_v_city_name := select_str(l.debtor_1_party_1_v_city_name,r.debtor_1_party_1_v_city_name);
						SELF.debtor_1_party_1_st          := select_str(l.debtor_1_party_1_st,r.debtor_1_party_1_st);
						SELF.debtor_1_party_1_zip         := select_str(l.debtor_1_party_1_zip,r.debtor_1_party_1_zip);
						SELF.debtor_1_party_2_addr_1      := select_str(l.debtor_1_party_2_addr_1,r.debtor_1_party_2_addr_1);
						SELF.debtor_1_party_2_addr_2      := select_str(l.debtor_1_party_2_addr_2,r.debtor_1_party_2_addr_2);
						SELF.debtor_1_party_2_v_city_name := select_str(l.debtor_1_party_2_v_city_name,r.debtor_1_party_2_v_city_name);
						SELF.debtor_1_party_2_st          := select_str(l.debtor_1_party_2_st,r.debtor_1_party_2_st);
						SELF.debtor_1_party_2_zip         := select_str(l.debtor_1_party_2_zip,r.debtor_1_party_2_zip);
						
						SELF.debtor_2_party_1_orig_name   := select_str(l.debtor_2_party_1_orig_name,r.debtor_2_party_1_orig_name);
						SELF.debtor_2_party_1_addr_1      := select_str(l.debtor_2_party_1_addr_1,r.debtor_2_party_1_addr_1);
						SELF.debtor_2_party_1_addr_2      := select_str(l.debtor_2_party_1_addr_2,r.debtor_2_party_1_addr_2);
						SELF.debtor_2_party_1_v_city_name := select_str(l.debtor_2_party_1_v_city_name,r.debtor_2_party_1_v_city_name);
						SELF.debtor_2_party_1_st          := select_str(l.debtor_2_party_1_st,r.debtor_2_party_1_st);
						SELF.debtor_2_party_1_zip         := select_str(l.debtor_2_party_1_zip,r.debtor_2_party_1_zip);
						SELF.debtor_2_party_2_addr_1      := select_str(l.debtor_2_party_2_addr_1,r.debtor_2_party_2_addr_1);
						SELF.debtor_2_party_2_addr_2      := select_str(l.debtor_2_party_2_addr_2,r.debtor_2_party_2_addr_2);
						SELF.debtor_2_party_2_v_city_name := select_str(l.debtor_2_party_2_v_city_name,r.debtor_2_party_2_v_city_name);
						SELF.debtor_2_party_2_st          := select_str(l.debtor_2_party_2_st,r.debtor_2_party_2_st);
						SELF.debtor_2_party_2_zip         := select_str(l.debtor_2_party_2_zip,r.debtor_2_party_2_zip);

						SELF.debtor_3_party_1_orig_name   := select_str(l.debtor_3_party_1_orig_name,r.debtor_3_party_1_orig_name);
						SELF.debtor_3_party_1_addr_1      := select_str(l.debtor_3_party_1_addr_1,r.debtor_3_party_1_addr_1);
						SELF.debtor_3_party_1_addr_2      := select_str(l.debtor_3_party_1_addr_2,r.debtor_3_party_1_addr_2);
						SELF.debtor_3_party_1_v_city_name := select_str(l.debtor_3_party_1_v_city_name,r.debtor_3_party_1_v_city_name);
						SELF.debtor_3_party_1_st          := select_str(l.debtor_3_party_1_st,r.debtor_3_party_1_st);
						SELF.debtor_3_party_1_zip         := select_str(l.debtor_3_party_1_zip,r.debtor_3_party_1_zip);
						SELF.debtor_3_party_2_addr_1      := select_str(l.debtor_3_party_2_addr_1,r.debtor_3_party_2_addr_1);
						SELF.debtor_3_party_2_addr_2      := select_str(l.debtor_3_party_2_addr_2,r.debtor_3_party_2_addr_2);
						SELF.debtor_3_party_2_v_city_name := select_str(l.debtor_3_party_2_v_city_name,r.debtor_3_party_2_v_city_name);
						SELF.debtor_3_party_2_st          := select_str(l.debtor_3_party_2_st,r.debtor_3_party_2_st);
						SELF.debtor_3_party_2_zip         := select_str(l.debtor_3_party_2_zip,r.debtor_3_party_2_zip);

						SELF.debtor_4_party_1_orig_name   := select_str(l.debtor_4_party_1_orig_name,r.debtor_4_party_1_orig_name);
						SELF.debtor_4_party_1_addr_1      := select_str(l.debtor_4_party_1_addr_1,r.debtor_4_party_1_addr_1);
						SELF.debtor_4_party_1_addr_2      := select_str(l.debtor_4_party_1_addr_2,r.debtor_4_party_1_addr_2);
						SELF.debtor_4_party_1_v_city_name := select_str(l.debtor_4_party_1_v_city_name,r.debtor_4_party_1_v_city_name);
						SELF.debtor_4_party_1_st          := select_str(l.debtor_4_party_1_st,r.debtor_4_party_1_st);
						SELF.debtor_4_party_1_zip         := select_str(l.debtor_4_party_1_zip,r.debtor_4_party_1_zip);
						SELF.debtor_4_party_2_addr_1      := select_str(l.debtor_4_party_2_addr_1,r.debtor_4_party_2_addr_1);
						SELF.debtor_4_party_2_addr_2      := select_str(l.debtor_4_party_2_addr_2,r.debtor_4_party_2_addr_2);
						SELF.debtor_4_party_2_v_city_name := select_str(l.debtor_4_party_2_v_city_name,r.debtor_4_party_2_v_city_name);
						SELF.debtor_4_party_2_st          := select_str(l.debtor_4_party_2_st,r.debtor_4_party_2_st);
						SELF.debtor_4_party_2_zip         := select_str(l.debtor_4_party_2_zip,r.debtor_4_party_2_zip);

						SELF.debtor_5_party_1_orig_name   := select_str(l.debtor_5_party_1_orig_name,r.debtor_5_party_1_orig_name);
						SELF.debtor_5_party_1_addr_1      := select_str(l.debtor_5_party_1_addr_1,r.debtor_5_party_1_addr_1);
						SELF.debtor_5_party_1_addr_2      := select_str(l.debtor_5_party_1_addr_2,r.debtor_5_party_1_addr_2);
						SELF.debtor_5_party_1_v_city_name := select_str(l.debtor_5_party_1_v_city_name,r.debtor_5_party_1_v_city_name);
						SELF.debtor_5_party_1_st          := select_str(l.debtor_5_party_1_st,r.debtor_5_party_1_st);
						SELF.debtor_5_party_1_zip         := select_str(l.debtor_5_party_1_zip,r.debtor_5_party_1_zip);
						SELF.debtor_5_party_2_addr_1      := select_str(l.debtor_5_party_2_addr_1,r.debtor_5_party_2_addr_1);
						SELF.debtor_5_party_2_addr_2      := select_str(l.debtor_5_party_2_addr_2,r.debtor_5_party_2_addr_2);
						SELF.debtor_5_party_2_v_city_name := select_str(l.debtor_5_party_2_v_city_name,r.debtor_5_party_2_v_city_name);
						SELF.debtor_5_party_2_st          := select_str(l.debtor_5_party_2_st,r.debtor_5_party_2_st);
						SELF.debtor_5_party_2_zip         := select_str(l.debtor_5_party_2_zip,r.debtor_5_party_2_zip);
						
						SELF.debtor_6_party_1_orig_name   := select_str(l.debtor_6_party_1_orig_name,r.debtor_6_party_1_orig_name);
						SELF.debtor_6_party_1_addr_1      := select_str(l.debtor_6_party_1_addr_1,r.debtor_6_party_1_addr_1);
						SELF.debtor_6_party_1_addr_2      := select_str(l.debtor_6_party_1_addr_2,r.debtor_6_party_1_addr_2);
						SELF.debtor_6_party_1_v_city_name := select_str(l.debtor_6_party_1_v_city_name,r.debtor_6_party_1_v_city_name);
						SELF.debtor_6_party_1_st          := select_str(l.debtor_6_party_1_st,r.debtor_6_party_1_st);
						SELF.debtor_6_party_1_zip         := select_str(l.debtor_6_party_1_zip,r.debtor_6_party_1_zip);
						SELF.debtor_6_party_2_addr_1      := select_str(l.debtor_6_party_2_addr_1,r.debtor_6_party_2_addr_1);
						SELF.debtor_6_party_2_addr_2      := select_str(l.debtor_6_party_2_addr_2,r.debtor_6_party_2_addr_2);
						SELF.debtor_6_party_2_v_city_name := select_str(l.debtor_6_party_2_v_city_name,r.debtor_6_party_2_v_city_name);
						SELF.debtor_6_party_2_st          := select_str(l.debtor_6_party_2_st,r.debtor_6_party_2_st);
						SELF.debtor_6_party_2_zip         := select_str(l.debtor_6_party_2_zip,r.debtor_6_party_2_zip);	
						
						SELF.debtor_7_party_1_orig_name   := select_str(l.debtor_7_party_1_orig_name,r.debtor_7_party_1_orig_name);
						SELF.debtor_7_party_1_addr_1      := select_str(l.debtor_7_party_1_addr_1,r.debtor_7_party_1_addr_1);
						SELF.debtor_7_party_1_addr_2      := select_str(l.debtor_7_party_1_addr_2,r.debtor_7_party_1_addr_2);
						SELF.debtor_7_party_1_v_city_name := select_str(l.debtor_7_party_1_v_city_name,r.debtor_7_party_1_v_city_name);
						SELF.debtor_7_party_1_st          := select_str(l.debtor_7_party_1_st,r.debtor_7_party_1_st);
						SELF.debtor_7_party_1_zip         := select_str(l.debtor_7_party_1_zip,r.debtor_7_party_1_zip);
						SELF.debtor_7_party_2_addr_1      := select_str(l.debtor_7_party_2_addr_1,r.debtor_7_party_2_addr_1);
						SELF.debtor_7_party_2_addr_2      := select_str(l.debtor_7_party_2_addr_2,r.debtor_7_party_2_addr_2);
						SELF.debtor_7_party_2_v_city_name := select_str(l.debtor_7_party_2_v_city_name,r.debtor_7_party_2_v_city_name);
						SELF.debtor_7_party_2_st          := select_str(l.debtor_7_party_2_st,r.debtor_7_party_2_st);
						SELF.debtor_7_party_2_zip         := select_str(l.debtor_7_party_2_zip,r.debtor_7_party_2_zip);
						
						SELF.debtor_8_party_1_orig_name   := select_str(l.debtor_8_party_1_orig_name,r.debtor_8_party_1_orig_name);
						SELF.debtor_8_party_1_addr_1      := select_str(l.debtor_8_party_1_addr_1,r.debtor_8_party_1_addr_1);
						SELF.debtor_8_party_1_addr_2      := select_str(l.debtor_8_party_1_addr_2,r.debtor_8_party_1_addr_2);
						SELF.debtor_8_party_1_v_city_name := select_str(l.debtor_8_party_1_v_city_name,r.debtor_8_party_1_v_city_name);
						SELF.debtor_8_party_1_st          := select_str(l.debtor_8_party_1_st,r.debtor_8_party_1_st);
						SELF.debtor_8_party_1_zip         := select_str(l.debtor_8_party_1_zip,r.debtor_8_party_1_zip);
						SELF.debtor_8_party_2_addr_1      := select_str(l.debtor_8_party_2_addr_1,r.debtor_8_party_2_addr_1);
						SELF.debtor_8_party_2_addr_2      := select_str(l.debtor_8_party_2_addr_2,r.debtor_8_party_2_addr_2);
						SELF.debtor_8_party_2_v_city_name := select_str(l.debtor_8_party_2_v_city_name,r.debtor_8_party_2_v_city_name);
						SELF.debtor_8_party_2_st          := select_str(l.debtor_8_party_2_st,r.debtor_8_party_2_st);
						SELF.debtor_8_party_2_zip         := select_str(l.debtor_8_party_2_zip,r.debtor_8_party_2_zip);						
						
						SELF.debtor_9_party_1_orig_name   := select_str(l.debtor_9_party_1_orig_name,r.debtor_9_party_1_orig_name);
						SELF.debtor_9_party_1_addr_1      := select_str(l.debtor_9_party_1_addr_1,r.debtor_9_party_1_addr_1);
						SELF.debtor_9_party_1_addr_2      := select_str(l.debtor_9_party_1_addr_2,r.debtor_9_party_1_addr_2);
						SELF.debtor_9_party_1_v_city_name := select_str(l.debtor_9_party_1_v_city_name,r.debtor_9_party_1_v_city_name);
						SELF.debtor_9_party_1_st          := select_str(l.debtor_9_party_1_st,r.debtor_9_party_1_st);
						SELF.debtor_9_party_1_zip         := select_str(l.debtor_9_party_1_zip,r.debtor_9_party_1_zip);
						SELF.debtor_9_party_2_addr_1      := select_str(l.debtor_9_party_2_addr_1,r.debtor_9_party_2_addr_1);
						SELF.debtor_9_party_2_addr_2      := select_str(l.debtor_9_party_2_addr_2,r.debtor_9_party_2_addr_2);
						SELF.debtor_9_party_2_v_city_name := select_str(l.debtor_9_party_2_v_city_name,r.debtor_9_party_2_v_city_name);
						SELF.debtor_9_party_2_st          := select_str(l.debtor_9_party_2_st,r.debtor_9_party_2_st);
						SELF.debtor_9_party_2_zip         := select_str(l.debtor_9_party_2_zip,r.debtor_9_party_2_zip);	
						
						SELF.debtor_10_party_1_orig_name   := select_str(l.debtor_10_party_1_orig_name,r.debtor_10_party_1_orig_name);
						SELF.debtor_10_party_1_addr_1      := select_str(l.debtor_10_party_1_addr_1,r.debtor_10_party_1_addr_1);
						SELF.debtor_10_party_1_addr_2      := select_str(l.debtor_10_party_1_addr_2,r.debtor_10_party_1_addr_2);
						SELF.debtor_10_party_1_v_city_name := select_str(l.debtor_10_party_1_v_city_name,r.debtor_10_party_1_v_city_name);
						SELF.debtor_10_party_1_st          := select_str(l.debtor_10_party_1_st,r.debtor_10_party_1_st);
						SELF.debtor_10_party_1_zip         := select_str(l.debtor_10_party_1_zip,r.debtor_10_party_1_zip);
						SELF.debtor_10_party_2_addr_1      := select_str(l.debtor_10_party_2_addr_1,r.debtor_10_party_2_addr_1);
						SELF.debtor_10_party_2_addr_2      := select_str(l.debtor_10_party_2_addr_2,r.debtor_10_party_2_addr_2);
						SELF.debtor_10_party_2_v_city_name := select_str(l.debtor_10_party_2_v_city_name,r.debtor_10_party_2_v_city_name);
						SELF.debtor_10_party_2_st          := select_str(l.debtor_10_party_2_st,r.debtor_10_party_2_st);
						SELF.debtor_10_party_2_zip         := select_str(l.debtor_10_party_2_zip,r.debtor_10_party_2_zip);

						SELF.secured_1_orig_name   := select_str(l.secured_1_orig_name,r.secured_1_orig_name);
						SELF.secured_1_addr_1      := select_str(l.secured_1_addr_1,r.secured_1_addr_1);
						SELF.secured_1_addr_2      := select_str(l.secured_1_addr_2,r.secured_1_addr_2);
						SELF.secured_1_v_city_name := select_str(l.secured_1_v_city_name,r.secured_1_v_city_name);
						SELF.secured_1_st          := select_str(l.secured_1_st,r.secured_1_st);
						SELF.secured_1_zip         := select_str(l.secured_1_zip,r.secured_1_zip);

						SELF.secured_2_orig_name   := select_str(l.secured_2_orig_name,r.secured_2_orig_name);
						SELF.secured_2_addr_1      := select_str(l.secured_2_addr_1,r.secured_2_addr_1);
						SELF.secured_2_addr_2      := select_str(l.secured_2_addr_2,r.secured_2_addr_2);
						SELF.secured_2_v_city_name := select_str(l.secured_2_v_city_name,r.secured_2_v_city_name);
						SELF.secured_2_st          := select_str(l.secured_2_st,r.secured_2_st);
						SELF.secured_2_zip         := select_str(l.secured_2_zip,r.secured_2_zip);					
																			 
						
						SELF.secured_3_orig_name   := select_str(l.secured_3_orig_name,r.secured_3_orig_name);
						SELF.secured_3_addr_1      := select_str(l.secured_3_addr_1,r.secured_3_addr_1);
						SELF.secured_3_addr_2      := select_str(l.secured_3_addr_2,r.secured_3_addr_2);
						SELF.secured_3_v_city_name := select_str(l.secured_3_v_city_name,r.secured_3_v_city_name);
						SELF.secured_3_st          := select_str(l.secured_3_st,r.secured_3_st);
						SELF.secured_3_zip         := select_str(l.secured_3_zip,r.secured_3_zip);

						SELF.secured_4_orig_name   := select_str(l.secured_4_orig_name,r.secured_4_orig_name);
						SELF.secured_4_addr_1      := select_str(l.secured_4_addr_1,r.secured_4_addr_1);
						SELF.secured_4_addr_2      := select_str(l.secured_4_addr_2,r.secured_4_addr_2);
						SELF.secured_4_v_city_name := select_str(l.secured_4_v_city_name,r.secured_4_v_city_name);
						SELF.secured_4_st          := select_str(l.secured_4_st,r.secured_4_st);
						SELF.secured_4_zip         := select_str(l.secured_4_zip,r.secured_4_zip);	
						
						SELF.secured_5_orig_name   := select_str(l.secured_5_orig_name,r.secured_5_orig_name);
						SELF.secured_5_addr_1      := select_str(l.secured_5_addr_1,r.secured_5_addr_1);
						SELF.secured_5_addr_2      := select_str(l.secured_5_addr_2,r.secured_5_addr_2);
						SELF.secured_5_v_city_name := select_str(l.secured_5_v_city_name,r.secured_5_v_city_name);
						SELF.secured_5_st          := select_str(l.secured_5_st,r.secured_5_st);
						SELF.secured_5_zip         := select_str(l.secured_5_zip,r.secured_5_zip);		
						
						SELF.assignee_1_orig_name   := select_str(l.assignee_1_orig_name,r.assignee_1_orig_name);
						SELF.assignee_1_addr_1      := select_str(l.assignee_1_addr_1,r.assignee_1_addr_1);
						SELF.assignee_1_addr_2      := select_str(l.assignee_1_addr_2,r.assignee_1_addr_2);
						SELF.assignee_1_v_city_name := select_str(l.assignee_1_v_city_name,r.assignee_1_v_city_name);
						SELF.assignee_1_st          := select_str(l.assignee_1_st,r.assignee_1_st);
						SELF.assignee_1_zip         := select_str(l.assignee_1_zip,r.assignee_1_zip);

						
						SELF.assignee_2_orig_name   := select_str(l.assignee_2_orig_name,r.assignee_2_orig_name);
						SELF.assignee_2_addr_1      := select_str(l.assignee_2_addr_1,r.assignee_2_addr_1);
						SELF.assignee_2_addr_2      := select_str(l.assignee_2_addr_2,r.assignee_2_addr_2);
						SELF.assignee_2_v_city_name := select_str(l.assignee_2_v_city_name,r.assignee_2_v_city_name);
						SELF.assignee_2_st          := select_str(l.assignee_2_st,r.assignee_2_st);
						SELF.assignee_2_zip         := select_str(l.assignee_2_zip,r.assignee_2_zip);
						

						
						SELF.assignee_3_orig_name   := select_str(l.assignee_3_orig_name,r.assignee_3_orig_name);
						SELF.assignee_3_addr_1      := select_str(l.assignee_3_addr_1,r.assignee_3_addr_1);
						SELF.assignee_3_addr_2      := select_str(l.assignee_3_addr_2,r.assignee_3_addr_2);
						SELF.assignee_3_v_city_name := select_str(l.assignee_3_v_city_name,r.assignee_3_v_city_name);
						SELF.assignee_3_st          := select_str(l.assignee_3_st,r.assignee_3_st);
						SELF.assignee_3_zip         := select_str(l.assignee_3_zip,r.assignee_3_zip);
						
						SELF.assignee_4_orig_name   := select_str(l.assignee_4_orig_name,r.assignee_4_orig_name);
						SELF.assignee_4_addr_1      := select_str(l.assignee_4_addr_1,r.assignee_4_addr_1);
						SELF.assignee_4_addr_2      := select_str(l.assignee_4_addr_2,r.assignee_4_addr_2);
						SELF.assignee_4_v_city_name := select_str(l.assignee_4_v_city_name,r.assignee_4_v_city_name);
						SELF.assignee_4_st          := select_str(l.assignee_4_st,r.assignee_4_st);
						SELF.assignee_4_zip         := select_str(l.assignee_4_zip,r.assignee_4_zip);

						
						SELF.assignee_5_orig_name   := select_str(l.assignee_5_orig_name,r.assignee_5_orig_name);
						SELF.assignee_5_addr_1      := select_str(l.assignee_5_addr_1,r.assignee_5_addr_1);
						SELF.assignee_5_addr_2      := select_str(l.assignee_5_addr_2,r.assignee_5_addr_2);
						SELF.assignee_5_v_city_name := select_str(l.assignee_5_v_city_name,r.assignee_5_v_city_name);
						SELF.assignee_5_st          := select_str(l.assignee_5_st,r.assignee_5_st);
						SELF.assignee_5_zip         := select_str(l.assignee_5_zip,r.assignee_5_zip);
								SELF := l;
								SELF := r;
					ENd;
					
					recs_rollup := ROLLUP(ungroup(recs_prt),LEFT.tmsid=RIGHT.tmsid and LEFT.rmsid = RIGHT.rmsid,xfm_rollup(LEFT,RIGHT),local);
					
					// Suppress by TMSID
					Suppress.MAC_Suppress(recs_rollup,recs_suppress,appType,,,Suppress.Constants.DocTypes.UCC_TMSID,tmsid);
					
					RETURN recs_suppress;

			END;	
		END;
end;