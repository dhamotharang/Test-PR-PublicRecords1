import AutoStandardI, AutoKeyI;
export FetchI_Biz_Pkg := module
	export old := module
		export params := module
			export base := interface(
				AutoKeyI.FetchI_Biz_Address.old.params.base,
				AutoKeyI.FetchI_Biz_FEIN.old.params.base,
				AutoKeyI.FetchI_Biz_Name.old.params.base,
				AutoKeyI.FetchI_Biz_NameWords.old.params.base,
				AutoKeyI.FetchI_Biz_Phone.old.params.base,
				AutoKeyI.FetchI_Biz_StCityName.old.params.base,
				AutoKeyI.FetchI_Biz_StName.old.params.base,
				AutoKeyI.FetchI_Biz_Zip.old.params.base)
			end;
			export full := interface(
				AutoKeyI.FetchI_Biz_Address.old.params.full,
				AutoKeyI.FetchI_Biz_FEIN.old.params.full,
				AutoKeyI.FetchI_Biz_Name.old.params.full,
				AutoKeyI.FetchI_Biz_NameWords.old.params.full,
				AutoKeyI.FetchI_Biz_Phone.old.params.full,
				AutoKeyI.FetchI_Biz_StCityName.old.params.full,
				AutoKeyI.FetchI_Biz_StName.old.params.full,
				AutoKeyI.FetchI_Biz_Zip.old.params.full)
				export boolean workHard := true;
				export boolean noFail := true;
				export boolean useAllLookups := false;
				export set of string1 get_skip_set := [];
			end;
		end;
		export val(params.full in_mod) := module(AutoKeyI.FetchI_Biz.functions)
			export FetchI_Biz_Address() := autokeyi.FetchI_Biz_Address.old.do(in_mod);
			export FetchI_Biz_FEIN() := autokeyi.FetchI_Biz_FEIN.old.do(in_mod);
			export FetchI_Biz_Name() := autokeyi.FetchI_Biz_Name.old.do(in_mod);
			export FetchI_Biz_NameWords() := autokeyi.FetchI_Biz_NameWords.old.do(in_mod);
			export FetchI_Biz_Phone() := autokeyi.FetchI_Biz_Phone.old.do(in_mod);
			export FetchI_Biz_StCityName() := autokeyi.FetchI_Biz_StCityName.old.do(in_mod);
			export FetchI_Biz_StName() := autokeyi.FetchI_Biz_StName.old.do(in_mod);
			export FetchI_Biz_Zip() := autokeyi.FetchI_Biz_Zip.old.do(in_mod);
		end;
	end;
	export new := module
		export params := module
			export base := interface(
				AutoKeyI.FetchI_Biz_Address.new.params.base,
				AutoKeyI.FetchI_Biz_FEIN.new.params.base,
				AutoKeyI.FetchI_Biz_Name.new.params.base,
				AutoKeyI.FetchI_Biz_NameWords.new.params.base,
				AutoKeyI.FetchI_Biz_Phone.new.params.base,
				AutoKeyI.FetchI_Biz_StCityName.new.params.base,
				AutoKeyI.FetchI_Biz_StName.new.params.base,
				AutoKeyI.FetchI_Biz_Zip.new.params.base)
			end;
			export full := interface(
				AutoKeyI.FetchI_Biz_Address.new.params.full,
				AutoKeyI.FetchI_Biz_FEIN.new.params.full,
				AutoKeyI.FetchI_Biz_Name.new.params.full,
				AutoKeyI.FetchI_Biz_NameWords.new.params.full,
				AutoKeyI.FetchI_Biz_Phone.new.params.full,
				AutoKeyI.FetchI_Biz_StCityName.new.params.full,
				AutoKeyI.FetchI_Biz_StName.new.params.full,
				AutoKeyI.FetchI_Biz_Zip.new.params.full)
				export boolean workHard := true;
				export boolean noFail := true;
				export boolean useAllLookups := false;
				export set of string1 get_skip_set := [];
			end;
		end;
		export val(params.full in_mod) := function
			tempmod := module(old.params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean workHard := in_mod.workHard;
				export boolean noFail := in_mod.noFail;
				export boolean useAllLookups := in_mod.useAllLookups;
				export set of string1 get_skip_set := in_mod.get_skip_set;
				export string comp_name_value := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_value.params));
				export string comp_name_indic_value := AutoStandardI.InterfaceTranslator.comp_name_indic_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_indic_value.params));
				export string comp_name_sec_value := AutoStandardI.InterfaceTranslator.comp_name_sec_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.comp_name_sec_value.params));
				export string120 company_name_val_filt := AutoStandardI.InterfaceTranslator.company_name_val_filt.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_val_filt.params));
				export string120 company_name_val_filt2 := AutoStandardI.InterfaceTranslator.company_name_val_filt2.val(project(in_mod,AutoStandardI.InterfaceTranslator.company_name_val_filt2.params));
				export string prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.prange_value.params));
				export string pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
				export string sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.sec_range_value.params));
				export boolean addr_loose := AutoStandardI.InterfaceTranslator.addr_loose.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_loose.params));
				export boolean addr_error_value := AutoStandardI.InterfaceTranslator.addr_error_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.addr_error_value.params));
				export string city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
				export set of unsigned city_codes_set := AutoStandardI.InterfaceTranslator.city_codes_set.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_codes_set.params));
				export string state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
				export string5 zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_val.params));
				export set of integer4 zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
				export string10 phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.phone_value.params));
				export string10 fein_val := AutoStandardI.InterfaceTranslator.fein_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.fein_val.params));
				export unsigned4 fein_value := AutoStandardI.InterfaceTranslator.fein_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fein_value.params));
				export unsigned6 bdid_value := AutoStandardI.InterfaceTranslator.bdid_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.bdid_value.params));
				export unsigned4 lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lookup_value.params));
				export string6 can_poscode_value := AutoStandardI.InterfaceTranslator.can_poscode_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.can_poscode_value.params));
			end;
			return old.val(tempmod);
		end;
	end;
end;
