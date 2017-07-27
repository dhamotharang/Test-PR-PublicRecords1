
import AutoHeaderI,AutoStandardI,fedex,doxie_cbrs,address,ut,doxie_cbrs,Business_Header;

export mod_AddressCorrection := 
MODULE

	export params := 
		interface(
			AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full, 
			AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full
		)
		export string5 	industryclass;
		export boolean 	ExcludeSecondSearch;
		export unsigned6 Seq;
	end;

	export records(params in_mod) := function
	
		outrec := Fedex_Services.Layouts_AddressCorrection.out;
		con := Fedex_Services.Constants_AddressCorrection;
	
		//***** Decide which searches to do
		cni := AutoStandardI.InterfaceTranslator.comp_name_indic_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_indic_value.params));
		boolean DoCSearch := cni <> '';
		lna := AutoStandardI.InterfaceTranslator.lname_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_val.params));
		boolean DoPSearch := lna <> '';
		
		
		//***** See if there were problems with the input address
		zip_value_input := in_mod.zip; 
		clean_address := AutoStandardI.InterfaceTranslator.clean_address.val(project(in_mod,AutoStandardI.InterfaceTranslator.clean_address.params));
		acf := address.CleanFields(clean_address);
		zip_value_cleaned := acf.zip;
		zip4_value_cleaned := acf.zip4;  
		err_stat := AutoStandardI.InterfaceTranslator.err_stat.val(project(in_mod,AutoStandardI.InterfaceTranslator.err_stat.params));

		boolean isBadInputAddr  := zip4_value_cleaned = '';
		boolean isBadInputZip		:= zip_value_input <> '' and zip_value_cleaned <> '' and zip_value_input <> zip_value_cleaned;
		boolean DoSecondSearch := not in_mod.ExcludeSecondSearch and (isBadInputAddr or isBadInputZip);

				
		//***** Searches by biz
		mb1 :=  
			module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
				export score_results := false;
			end;
		bdids1 := if(DoCSearch, 	AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(mb1));
		
		mb2 := 
			module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
				export score_results := false;
				export addr := if(isBadInputAddr,	'',	in_mod.addr);
				export zip	:= if(isBadInputZip,	zip_value_cleaned, zip_value_input);
			end;
		bdids2 := if(DoCSearch and DoSecondSearch, 	AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(mb2));  //***** POSSIBLE THAT ALWAYS DOING TWO SEARCHES WOULD BE FASTER...EASY ENOUGH TO TEST
		
		noBus1Hit := not(exists(bdids1)) ; 
		bdids := 
			if(
				noBus1Hit,
				bdids2,
				bdids1
			);
			
		
		//***** Gather the business records
		dppa_ok := AutoStandardI.InterfaceTranslator.dppa_ok.val(project(in_mod,AutoStandardI.InterfaceTranslator.dppa_ok.params));
		dppa_purpose := AutoStandardI.InterfaceTranslator.dppa_purpose.val(project(in_mod,AutoStandardI.InterfaceTranslator.dppa_purpose.params));
		doxie_cbrs.mac_best_records(bdids, biz)
	
		
		
		//***** Searches by person
		mp1 :=  
			module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
			end;
		dids1 := if(DoPSearch, 	AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(mp1));
		
		mp2 := 
			module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
					export addr := if(isBadInputAddr,	'',	in_mod.addr);
					export zip	:= if(isBadInputZip,	zip_value_cleaned, zip_value_input);
			end;
		dids2 := if(DoPSearch and DoSecondSearch, 	AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(mp2));
		
		noPer1Hit := not(exists(dids1)) ; 
		dids := 
			if(
				noPer1Hit,
				dids1,
				dids2
			);


		//***** Gather the person records, and also pick up some extra daily searches, then rollup
		glb_purpose := AutoStandardI.InterfaceTranslator.glb_purpose.val(project(in_mod,AutoStandardI.InterfaceTranslator.glb_purpose.params));
		industry_class_value := AutoStandardI.InterfaceTranslator.industry_class_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.industry_class_value.params));
		per := 
			doxie.mod_header_records(
				DoSearch := true,													
				include_dailies := true, 					
				allow_wildcard := false,
				dateVal := 0,
				dppa_purpose := dppa_purpose,
				glb_purpose := glb_purpose,
				ln_branded_value := false,
				include_gong := true,
				probation_override_value := false,
				industry_class_value := industry_class_value,
				no_scrub := true, 
				suppress_gong_noncurrent := true,
				daily_autokey_skipset := []
			).Results(project(dids, transform(doxie.layout_references_hh, self := left, self := [])));
		
		
		//***** Format and filter out non USPS deliverable
		pre_f_biz := 
			project(
				biz,
				transform(
					recordof(fedex_Services.mod_Searches.BusinessSearch),
					self.dt_last_seen := (integer)left.dt_last_seen,
					self.zip := (integer)left.zip,
					self.zip4 := (integer)left.zip4,
					self.phone := (integer)left.phone,
					self.fein := (integer)left.fein,
					self.source := '',
					self.dppa_state := '',
					self := left
				)
			);
		pre_f_per := 
			project(
				per,
				transform(
					recordof(fedex_Services.mod_Searches.HeaderSearch),
					self := left
				)
			);
		f_biz := Fedex_Services.mod_Formatting.BusinessFormat(pre_f_biz);
		f_per := Fedex_Services.mod_Formatting.HeaderFormat(pre_f_per);
		f_both := Fedex_Services.fn_Rollup(f_biz + f_per);
		
		
		//***** score everything
		myMin2(integer L, integer R) :=  if ( l>r , r, l );
		outrec trascore(f_both l) := transform
		
			pp_mod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
				export fname_field := l.fname;
				export mname_field := l.mname;
				export lname_field := l.lname;
				export allow_wildcard := false;
			end;	
			pp := myMin2(AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(pp_mod), con.max_penalty_personName);

			pc_mod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
				export cname_field := l.company_name;
			end;				
			pc := myMin2(AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(pc_mod), con.max_penalty_companyName);

			pa_mod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
				export allow_wildcard := false;
				export city_field := l.v_city_name;
				export city2_field := '';
				export pname_field := l.prim_range;
				export postdir_field := l.postdir;
				export prange_field := l.prim_range;
				export predir_field := l.predir;
				export state_field := l.st;
				export suffix_field := l.addr_suffix;
				export zip_field := l.zip5;
			end;	
			pa := myMin2((unsigned2)(AutoStandardI.LIBCALL_PenaltyI_Addr.val(pa_mod)/3), con.max_penalty_address);

			ph_mod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
				export phone_field := l.phone;
			end;	
			ph := myMin2(AutoStandardI.LIBCALL_PenaltyI_Phone.val(ph_mod), con.max_penalty_phone);

			pd := myMin2(abs(ut.GetAgeI(l.dt_last_seen)), con.max_penalty_date);
			
			self.resident_Confidence := con.Max_Confidence - myMin2(con.Max_Confidence, pp + pc + pa + ph + pd);
			self.internal_penalty_personName := pp;
			self.internal_penalty_companyName := pc;
			self.internal_penalty_address := pa;
			self.internal_penalty_phone := pp;
			self.internal_penalty_date := pd;
			self := l;
		end;


		scored := project(f_both, trascore(left));
		
		
		//***** Filter by penalty
		
		//**************** TODO ************* 	
		//Match on Person Name /Company Name and Zip at least to be reasonable match  //and i wonder if zip is really necessary..maybe zip or street addr
		//**************** TODO ************* 
		
		filtered := scored(resident_confidence >= in_mod.scoreThreshold);
		
		
		//***** Sort
		
		//**************** TODO ************* 
		// •	Rank importance on Person – Name, Address, Phone
		// •	Rank importance on Company – Company Name, Address, Phone, Person Name
		//**************** TODO ************* 
		
		//***** Debug
		// output(bdids1, named('bdids1'));
		// output(bdids2, named('bdids2'));
		// output(dids1, named('dids1'));
		// output(dids2, named('dids2'));
		// output(biz, named('biz'));
		// output(per, named('per'));
		// output(isBadInputAddr, named('isBadInputAddr'));
		// output(isBadInputZip, named('isBadInputZip'));
		// output(DoSecondSearch, named('DoSecondSearch'));
		
		
		//***** Messages
		map(
			DoSecondSearch =>
				map(
					isBadInputAddr	=> ut.outputMessage(0, 'No results with original input.  Subsequent search performed with blank street address.'),
					isBadInputZip		=> ut.outputMessage(0, 'No results with original input.  Subsequent search performed with zip chosen by address cleaner (' + zip_value_cleaned + ').')
				)
		);


		//***** Gather results and slap the input seq on there for testing
		return project(
				sort(filtered, -resident_confidence, dt_last_seen),
				transform(
					Fedex_Services.Layouts_AddressCorrection.out,
					self.internal_seq := in_mod.seq,
					self := left
				)
			);
			
	end;
	
END;