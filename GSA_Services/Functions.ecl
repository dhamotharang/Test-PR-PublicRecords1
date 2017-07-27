import AutoStandardI,AutoHeaderI,Address, iesp,STD;

export Functions := Module
gm := AutoStandardI.GlobalModule();
AI:=AutoStandardI.InterfaceTranslator;

//transform function to get input data
	export Layouts.batchin_sequenced getInputItems(iesp.gsaverification.t_BatchGSASearchByItem l, INTEGER C) := TRANSFORM		

			in_mod_name := module(project (gm, AI.cleaned_name.params))
				export UnparsedFullName := l.Name.Full;
			end;			
			
			in_mod_cname := module(project (gm, AI.company_name.params))
				export companyname := l.Name.CompanyName;
			end;
			
			in_mod_addr := module(project (gm, AI.clean_address.params))
				export Addr := l.Address.StreetAddress1 + ' ' + l.Address.StreetAddress2;
				export prim_name := l.Address.StreetName;
				export prim_range := l.Address.StreetNumber;
				export predir := l.Address.StreetPreDirection;
				export addr_suffix := l.Address.StreetSuffix;
				export postdir := l.Address.StreetPostDirection;
				export sec_range := l.Address.UnitNumber;
				export city := l.Address.city;
				export state := l.Address.state;
				export zip := l.Address.zip5;
				export statecityzip := l.Address.statecityzip;
			end;

			//address fields
			boolean valid_cleaned_addr := l.Address.StreetAddress1 <> '';
			clean_addr	:=ai.clean_address.val (in_mod_addr);
			split_addr:=Address.CleanFields(clean_addr);	
			
			//name fields
			boolean valid_cleaned := l.Name.Full <> '';
			clean_name	:= ai.cleaned_name.val (in_mod_name);
			split_name:= Address.CleanNameFields(clean_name);	
			//company name
			companyName := ai.company_name.val(in_mod_cname);
			
			//apply transform
			self.search_id := l.searchid;
			self.acctno := (String)C;
			self.name_first := STD.Str.ToUpperCase(if(l.Name.First='' AND valid_cleaned, split_name.fname, l.Name.First));
			self.name_last := STD.Str.ToUpperCase(if(l.Name.Last='' AND valid_cleaned, split_name.lname, l.Name.Last));
			self.name_middle := STD.Str.ToUpperCase(if(l.Name.Middle='' AND valid_cleaned, split_name.mname, l.Name.Middle));
			self.name_suffix := STD.Str.ToUpperCase(if(l.Name.Suffix ='' AND valid_cleaned, split_name.name_suffix, l.Name.Suffix));	
			self.comp_name := companyName;
			self.prim_range 	:= STD.Str.ToUpperCase(if(l.Address.StreetNumber='' AND valid_cleaned_addr, split_addr.prim_range, l.Address.StreetNumber));
			self.predir 			:= STD.Str.ToUpperCase(if(l.Address.StreetPreDirection='' AND valid_cleaned_addr, split_addr.predir,l.Address.StreetPreDirection)); 
			self.prim_name 		:= STD.Str.ToUpperCase(if(l.Address.StreetName='' AND valid_cleaned_addr, split_addr.prim_name, l.Address.StreetName));
			self.addr_suffix 	:= STD.Str.ToUpperCase(if(l.Address.StreetSuffix='' AND valid_cleaned_addr, split_addr.addr_suffix, l.Address.StreetSuffix));
			self.postdir			:= STD.Str.ToUpperCase(if(l.Address.StreetPostDirection='' AND valid_cleaned_addr, split_addr.postdir, l.Address.StreetPostDirection));
			self.sec_range 		:= STD.Str.ToUpperCase(if(l.Address.UnitNumber='' AND valid_cleaned_addr, split_addr.sec_range, l.Address.UnitNumber));
			self.p_city_name 	:= STD.Str.ToUpperCase(
												MAP(l.Address.City='' AND valid_cleaned_addr => split_addr.p_city_name,
														l.Address.City='' => split_addr.p_city_name,
														l.Address.City));
			self.st 					:= STD.Str.ToUpperCase(
													MAP(l.Address.State='' AND valid_cleaned_addr => split_addr.st,
														l.Address.State='' => split_addr.st,
														l.Address.State));
			self.z5 					:= STD.Str.ToUpperCase(
													MAP(l.Address.Zip5='' AND valid_cleaned_addr => split_addr.zip,
														l.Address.Zip5='' => split_addr.zip,
														l.Address.Zip5));
			self := [];
	end;


//transform function to get input data

	export params := interface(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, 
														 AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full)
    //to avoid a collision with string4 'namesuffix' in global module
    export string5 name_suffix := '';
	end;
	
	export fn_getInputData(params in_mod) := FUNCTION
			//address fields
			AI:=AutoStandardI.InterfaceTranslator;
			clean_addr	:=ai.clean_address.val (project (in_mod, AI.clean_address.params));
			split_addr:=Address.CleanFields(clean_addr);	
			
			//name fields
			clean_name	:=ai.cleaned_name.val (project (in_mod, AI.cleaned_name.params));
			split_name:= Address.CleanNameFields(clean_name);	
			
			//company name
			companyName := ai.company_name.val(project(in_mod,ai.company_name.params));
			
			//input name parsed fields
			in_fname	     := AI.fname_value.val(project(in_mod,ai.fname_value.params));
			in_mname	     := AI.mname_value.val(project(in_mod,ai.mname_value.params));

          // if really desired, then: 
          // in_mod_temp := MODULE (AI.name_suffix_val.params)
            // export string4 NameSuffix := (string4) in_mod.name_suffix;
          // end;
          // in_name_suffix := AI.name_suffix_val.val(in_mod_temp);
			in_name_suffix := in_mod.name_suffix;
			in_lname	     := AI.lname_value.val(project(in_mod,ai.lname_value.params));
			
				
			prange_value := AI.prange_value.val(project(in_mod,AI.prange_value.params)); 
			predir_value := AI.predir_value.val(project(in_mod,AI.predir_value.params)); 
			pname_value := AI.pname_value.val(project(in_mod,AI.pname_value.params)); 
			addr_suffix_value := AI.addr_suffix_value.val(project(in_mod,AI.addr_suffix_value.params)); 
			postdir_value := AI.postdir_value.val(project(in_mod,AI.postdir_value.params)); 
			sec_range_value := AI.sec_range_value.val(project(in_mod,AI.sec_range_value.params));

			state_value := AI.state_value.val(project(in_mod,AI.state_value.params)); 
			city_value := AI.city_value.val(project(in_mod,AI.city_value.params)); 
			zip_value := AI.zip_val.val(project(in_mod,AI.zip_val.params));
				
			Layouts.gsa_rec_inBatchMaster getGlobalComponents := TRANSFORM		
		
			self.acctno := '1';
			
			self.name_first := STD.Str.ToUpperCase(if(in_fname='', split_name.fname, in_fname));
			self.name_middle := STD.Str.ToUpperCase(if(in_mname='', split_name.mname, in_mname));
			self.name_last := STD.Str.ToUpperCase(if(in_lname='', split_name.lname, in_lname));
			self.name_suffix := STD.Str.ToUpperCase(if(in_name_suffix='', split_name.name_suffix, in_name_suffix));
			self.comp_name := companyName;
			
			self.cln_prim_range 	:= STD.Str.ToUpperCase(if(prange_value='',split_addr.prim_range,prange_value));
			self.cln_predir 			:= STD.Str.ToUpperCase(if(predir_value='',split_addr.predir,predir_value));
			self.cln_prim_name 		:= STD.Str.ToUpperCase(if(pname_value='',split_addr.prim_name,pname_value));
			self.cln_addr_suffix 	:= STD.Str.ToUpperCase(if(addr_suffix_value='',split_addr.addr_suffix,addr_suffix_value));
			self.cln_postdir			:= STD.Str.ToUpperCase(if(postdir_value='',split_addr.postdir,postdir_value));
			self.cln_sec_range 		:= STD.Str.ToUpperCase(if(sec_range_value='',split_addr.sec_range,sec_range_value));
			self.p_city_name 	:= STD.Str.ToUpperCase(if(city_value='',split_addr.p_city_name,city_value));
			self.st 					:= STD.Str.ToUpperCase(if(state_value='',split_addr.st,state_value));
			self.z5 					:= STD.Str.ToUpperCase(if(zip_value='',split_addr.zip,zip_value));
			self := [];
			END;
		RETURN DATASET([getGlobalComponents]);
	END;

end;