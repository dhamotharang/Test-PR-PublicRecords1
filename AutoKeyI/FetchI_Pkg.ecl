/*2009-04-07T19:46:40Z (trent buck)
38673 - allow for the secondary range in the data to be blank or wrong when the name is also part of the search.
*/
import AutoStandardI, AutoKeyI,lib_thorlib;
export FetchI_Pkg := module
	export old := module
		export params := module
			export base := interface(AutoKeyI.FetchI_Indv_Pkg.old.params.base,AutoKeyI.FetchI_Biz_Pkg.old.params.base)
			end;
			export full := interface(AutoKeyI.FetchI_Indv_Pkg.old.params.full,AutoKeyI.FetchI_Biz_Pkg.old.params.full)
				export boolean workHard := true;
				export boolean noFail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export val(params.full in_mod) := function
			temp_mod := module(project(in_mod,params.full,opt))
				export boolean workHard := thorlib.getenv('WorkHard',if(in_mod.workHard, '1', '0')) = '1';
			end;
			tempmmod := module(AutoKeyI.FetchI_Indv_Pkg.old.val(temp_mod),AutoKeyI.FetchI_Biz_Pkg.old.val(temp_mod))
			end;
			return project(tempmmod,AutoKeyI.FetchI.functions);
		end;
	end;
	export new := module
		export params := module
			export base := interface(AutoKeyI.FetchI_Indv_Pkg.new.params.base,AutoKeyI.FetchI_Biz_Pkg.new.params.base)
			end;
			export full := interface(AutoKeyI.FetchI_Indv_Pkg.new.params.full,AutoKeyI.FetchI_Biz_Pkg.new.params.full)
				export boolean workHard := true;
				export boolean noFail := true;
				export boolean useAllLookups := false;
			end;
		end;
		export val(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean workHard := in_mod.workHard;
				export boolean noFail := in_mod.noFail;
				export boolean useAllLookups := in_mod.useAllLookups;
				export boolean isCRS := AutoStandardI.InterfaceTranslator.isCRS.val(project(in_mod,AutoStandardI.InterfaceTranslator.isCRS.params));
				export string fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
				export boolean nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(project(in_mod,AutoStandardI.InterfaceTranslator.nicknames.params));
				export string mname_value := AutoStandardI.InterfaceTranslator.mname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.mname_value.params));
				export string lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
				export set of string lname_set_value := AutoStandardI.InterfaceTranslator.lname_set_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_set_value.params));
				export set of string20 lname_set_value_20 := AutoStandardI.InterfaceTranslator.lname_set_value_20.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_set_value_20.params));
				export boolean phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(project(in_mod,AutoStandardI.InterfaceTranslator.phonetics.params));
				export string comp_name_value := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_value.params));
				export string comp_name_indic_value := AutoStandardI.InterfaceTranslator.comp_name_indic_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_indic_value.params));
				export string comp_name_sec_value := AutoStandardI.InterfaceTranslator.comp_name_sec_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_sec_value.params));
				export string120 company_name_val_filt := AutoStandardI.InterfaceTranslator.company_name_val_filt.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_val_filt.params));
				export string120 company_name_val_filt2 := AutoStandardI.InterfaceTranslator.company_name_val_filt2.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_val_filt2.params));
				export string prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_value.params));
				export string pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
				export string sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.sec_range_value.params));
				export boolean addr_loose := AutoStandardI.InterfaceTranslator.addr_loose.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_loose.params));
				export boolean addr_range := AutoStandardI.InterfaceTranslator.addr_range.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_range.params));
				export set of string10 prim_range_set_value := AutoStandardI.InterfaceTranslator.prim_range_set_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prim_range_set_value.params));
				export boolean addr_error_value := AutoStandardI.InterfaceTranslator.addr_error_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_error_value.params));
				export string city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
				export set of unsigned city_codes_set := AutoStandardI.InterfaceTranslator.city_codes_set.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_codes_set.params));
				export string state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
				export string5 zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_val.params));
				export set of integer4 zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
				export string5 city_zip_value := AutoStandardI.InterfaceTranslator.city_zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_zip_value.params));
				export unsigned2 zipradius_value := AutoStandardI.InterfaceTranslator.zipradius_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zipradius_value.params));
				export string10 phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
				export string9 ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
				export boolean fuzzy_ssn := AutoStandardI.InterfaceTranslator.fuzzy_ssn.val(project(in_mod,AutoStandardI.InterfaceTranslator.fuzzy_ssn.params));
				export string14 did_value := AutoStandardI.InterfaceTranslator.did_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.did_value.params));
				export string10 fein_val := AutoStandardI.InterfaceTranslator.fein_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.fein_val.params));
				export unsigned4 fein_value := AutoStandardI.InterfaceTranslator.fein_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fein_value.params));
				export unsigned6 bdid_value := AutoStandardI.InterfaceTranslator.bdid_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.bdid_value.params));
				export unsigned find_year_high := AutoStandardI.InterfaceTranslator.find_year_high.val(project(in_mod,AutoStandardI.InterfaceTranslator.find_year_high.params));
				export unsigned find_year_low := AutoStandardI.InterfaceTranslator.find_year_low.val(project(in_mod,AutoStandardI.InterfaceTranslator.find_year_low.params));
				export unsigned find_month := AutoStandardI.InterfaceTranslator.find_month.val(project(in_mod,AutoStandardI.InterfaceTranslator.find_month.params));
				export unsigned find_day := AutoStandardI.InterfaceTranslator.find_day.val(project(in_mod,AutoStandardI.InterfaceTranslator.find_day.params));
				export string2 prev_state_val1 := AutoStandardI.InterfaceTranslator.prev_state_val1.val(project(in_mod,AutoStandardI.InterfaceTranslator.prev_state_val1.params));
				export string2 prev_state_val2 := AutoStandardI.InterfaceTranslator.prev_state_val2.val(project(in_mod,AutoStandardI.InterfaceTranslator.prev_state_val2.params));
				export string30 other_lname_value1 := AutoStandardI.InterfaceTranslator.other_lname_value1.val(project(in_mod,AutoStandardI.InterfaceTranslator.other_lname_value1.params));
				export string25 other_city_value := AutoStandardI.InterfaceTranslator.other_city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.other_city_value.params));
				export string30 rel_fname_value1 := AutoStandardI.InterfaceTranslator.rel_fname_value1.val(project(in_mod,AutoStandardI.InterfaceTranslator.rel_fname_value1.params));
				export string rel_fname_value2 := AutoStandardI.InterfaceTranslator.rel_fname_value2.val(project(in_mod,AutoStandardI.InterfaceTranslator.rel_fname_value2.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
				export unsigned4 lookup_value2 := AutoStandardI.InterfaceTranslator.lookup_value2.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value2.params));
				export integer FuzzySecRange_value := AutoStandardI.InterfaceTranslator.FuzzySecRange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.FuzzySecRange_value.params));
				export boolean SearchAroundAddress_value := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params));
				export boolean do_primname_word_match := AutoStandardI.InterfaceTranslator.do_primname_word_match.val(project(in_mod,AutoStandardI.InterfaceTranslator.do_primname_word_match.params));
				export string6 can_poscode_value := AutoStandardI.InterfaceTranslator.can_poscode_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.can_poscode_value.params));

			end;
			return old.val(tempmod);
		end;
	end;
end;
