import autokeyb,AutoStandardI,doxie,AutoKeyI;
export FetchI := module
	export functions := interface(AutoKeyI.FetchI_Biz.functions,AutoKeyI.FetchI_Indv.functions)
	end;
	export old := module
		export params := module
			export base := interface
				export string comp_name_value;
				export string pname_value;
				export string lname_value;
				export string ssn_value;
			end;
			export full := interface(base)
				export string typestr;
				export set of string1 get_skip_set := [];
			end;
		end;
		export do(functions in_functions,params.full in_mod) := function
			//***** SOME BOOLEANS TO DIRECT BEHAVIOR
			isCompanyNameSearch := in_mod.comp_name_value <> '';
			isPersonSearch := in_mod.lname_value <> '' or in_mod.ssn_value <> '';
			isAddrSearch := in_mod.pname_value <> '';
			isBareAddr := isAddrSearch and not isCompanyNameSearch and 'C' not in in_mod.get_skip_set;

			//***** MODULE CALLS FOR PERSON SEARCH AND BUSINESS SEARCH
			agd := AutoKeyI.FetchI_Indv.old.do(project(in_functions,AutoKeyI.FetchI_Indv.functions),project(in_mod,AutoKeyI.FetchI_Indv.old.params));
			tempmodb := module(project(in_mod,AutoKeyI.FetchI_Biz.old.params,opt))
				export boolean isBareAddr := ^.isBareAddr;
			end;
			agb := AutoKeyI.FetchI_Biz.old.do(project(in_functions,AutoKeyI.FetchI_Biz.functions),tempmodb);


			//***** TRANSFORM RESULTS INTO OUTPUT LAYOUT
			idsrec := {unsigned6 ID, boolean isDID := false, boolean isBDID := false,boolean IsFake};
			 
			idsrec makeids(boolean lisDID, boolean lisBDID, unsigned6 lID) := transform
				self.isDID  := lisDID;
				self.isBDID := lisBDID;
				self.ID := lID;
				self.IsFake := autokeyb.IsFakeID(lID,in_mod.typestr);
			end;
			 
			newdids  := project(agd.result, makeids(true, false, left.did)); 
			newbdids := project(agb.result, makeids(false, true, left.bdid)); 
			 
			ids := newdids+newbdids;


			//***** ONLY FAIL IF SOME FETCH FAILED AND NO OTHER FETCH FOUND RESULTS
      // The search will be considered to fail if no ids were found and 
			// either the person search failed or 
			// the business search failed and it isn't also doing a person search.
			// Bug #53413 - It's not enough to say that the person search failed.  We need to make sure
			//              we don't fail a search when the person portion failed and it was actually a
			//              company name search (aka. business search), not a person search.  We also need
			//              to account for the case of both isCompanyNameSearch and isPersonSearch are true.
			did_fail :=
			  MAP(EXISTS(ids) => FALSE,
			      ((agd.did_fail OR agb.did_fail) AND (isCompanyNameSearch AND isPersonSearch)) => TRUE,
			      ((agd.did_fail AND NOT isCompanyNameSearch) OR (agb.did_fail AND NOT isPersonSearch)));
			
			the_failure := if(agd.did_fail, agd.the_failure, agb.the_failure);
			
      // Uncomment below as needed for debugging
			//output(agd.did_fail,named('akifi_agd_did_fail'));
			//output(agd.the_failure,named('akifi_agd_the_failure'));
			//output(agb.did_fail,named('akifi_agb_did_fail'));
			//output(agb.the_failure,named('akifi_agb_the_failure'));
		  //output(ids,named('akifi_ids'));
			//output(count(ids),named('akifi_ids_count'));
			
			return if(did_fail,
								fail(idsrec, the_failure, doxie.ErrorCodes(the_failure)),
								ids);
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoStandardI.InterfaceTranslator.comp_name_value.params,
				AutoStandardI.InterfaceTranslator.pname_value.params
				,AutoStandardI.InterfaceTranslator.lname_value.params
				,AutoStandardI.InterfaceTranslator.ssn_value.params)
			end;
			export full := interface(base)
				export string typestr;
				export set of string1 get_skip_set := [];
			end;
		end;
		export do(functions in_functions,params.full in_mod) := function
			tempmod := module(old.params.full)
				export string typestr := in_mod.typestr;
				export set of string1 get_skip_set := in_mod.get_skip_set;
				export string comp_name_value := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_value.params));
				export string pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
			  export string lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
			  export string ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
			end;
			return old.do(in_functions,tempmod);
		end;
	end;
end;
