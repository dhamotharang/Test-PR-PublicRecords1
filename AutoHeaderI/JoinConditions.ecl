export JoinConditions := module

	export NEGATIVE_FEIN() := macro
		(not(left.fein_value != 0) or not(left.fein_mandatory_match))
	endmacro;
	
	export NEGATIVE_PHONE() := macro
		(not(left.phone_value != '') or not(left.phone_mandatory_match))
	endmacro;
	
	export NEGATIVE_STREET() := macro
		(not(left.pname_value <> '' and left.zip_value <> [] and (left.prange_value='' or left.addr_error_value or left.addr_loose)))
	endmacro;
	
	export NEGATIVE_ADDRESS() := macro
		(not(left.pname_value<>'' and (left.prange_value<>'' or left.company_name_value='') and (not left.addr_error_value or left.addr_loose)))
	endmacro;
	
	export NEGATIVE_ZIP() := macro
		(not(left.zip_value <> []))
	endmacro;
	
	export NEGATIVE_NAME() := macro
		(not(left.city_value = '' and left.state_value = ''))
	endmacro;
	
	export NEGATIVE_STNAME() := macro
		(not(left.city_value = ''))
	endmacro;
	
	export STATE() := macro
		(right.state = left.state_value)
	endmacro;
	
	export ZIP() := macro
		(right.zip IN left.zip_value)
	endmacro;
	
	export ZIP_EXTENDED() := macro
		(right.zip in Functions.ExtendedZips(left.zip_value,left.state_value,left.city_value))
	endmacro;
	
	export CITY() := macro
		(right.city_code in doxie.Make_CityCodes(left.city_value).rox)
	endmacro;
	
	export PNAME() := macro
		(left.pname_value = right.prim_name or Functions.AddOrdinal(left.pname_value) = right.prim_name)
	endmacro;
	
	export PRANGE() := macro
		(left.prange_value = right.prim_range)
	endmacro;
	
	export SRANGE() := macro
		(left.sec_range_value = right.sec_range)
	endmacro;
	
	export FEIN() := macro
		(left.fein_value = right.fein)
	endmacro;
	
	export P7() := macro
		(right.p7 = if(length(trim(left.phone_value)) = 10,left.phone_value[4..10],(string7)left.phone_value))
	endmacro;
	
	export P3() := macro
		(length(trim(left.phone_value)) != 10 or right.p3 = left.phone_value[1..3])
	endmacro;
	
	export WORD() := macro
		(
			left.allow_wild_match_value and
			right.word[1..length(Functions.FilteredName(left.company_name_value))]=Functions.FilteredName(left.company_name_value)
		) 
		or
		(
			right.word[1..length(Functions.FilteredName(trim(left.cleaned_cname[1..map(left.allow_wild_match_value or left.allow_indic_match_value => 40,left.allow_close_match_value => 80,120)])))]=Functions.FilteredName(trim(left.cleaned_cname[1..map(left.allow_wild_match_value or left.allow_indic_match_value => 40,left.allow_close_match_value => 80,120)]))
		)
	endmacro;
	
	export INDIC() := macro
		(left.allow_wild_match_value or right.indic = trim(left.cleaned_cname[1..40]))
	endmacro;
	
	export SEC() := macro
		(left.allow_indic_match_value or right.sec=trim(left.cleaned_cname[41..80]))
	endmacro;
	
	export CNAME() := macro
		(left.allow_close_match_value or right.cname=left.company_name_value)
	endmacro;
	
	// Non-mandatory key fields

	export STATE_OPT() := macro
		(left.state_value = '' or JoinConditions.STATE())
	endmacro;
	
	export ZIP_OPT() := macro
		(left.zip_value = [] or JoinConditions.ZIP())
	endmacro;
	
	export ZIP_EXTENDED_OPT() := macro
		(Functions.ExtendedZips(left.zip_value,left.state_value,left.city_value) = [] or JoinConditions.ZIP_EXTENDED())
	endmacro;
	
	export CITY_OPT() := macro
		(left.city_value = '' or JoinConditions.CITY())
	endmacro;
	
	export PNAME_OPT() := macro
		(left.pname_value = '' or JoinConditions.PNAME())
	endmacro;
	
	export PRANGE_OPT() := macro
		(left.prange_value = '' or left.addr_loose or JoinConditions.PRANGE())
	endmacro;
	
	export SRANGE_OPT() := macro
		(left.sec_range_value = '' or JoinConditions.SRANGE())
	endmacro;
	
	export FEIN_OPT() := macro
		((not left.fein_mandatory_match) or left.fein_value = 0 or JoinConditions.FEIN())
	endmacro;
	
	export WORD_OPT() := macro
		(left.company_name_value = '' or JoinConditions.WORD())
	endmacro;
	
	export INDIC_OPT() := macro
		(left.company_name_value = '' or JoinConditions.INDIC())
	endmacro;
	
	export SEC_OPT() := macro
		(left.company_name_value = '' or JoinConditions.SEC())
	endmacro;
	
	export CNAME_OPT() := macro
		(left.company_name_value = '' or JoinConditions.CNAME())
	endmacro;
	

	
	
	
	export STATE_KEYED() := macro
		keyed(JoinConditions.STATE())
	endmacro;
	
	export STATE_OPT_KEYED() := macro
		keyed(JoinConditions.STATE_OPT())
	endmacro;
	
	export ZIP_KEYED() := macro
		keyed(JoinConditions.ZIP())
	endmacro;
	
	export ZIP_OPT_KEYED() := macro
		keyed(JoinConditions.ZIP_OPT())
	endmacro;
	
	export ZIP_EXTENDED_KEYED() := macro
		keyed(JoinConditions.ZIP_EXTENDED())
	endmacro;
	
	export ZIP_EXTENDED_OPT_KEYED() := macro
		keyed(JoinConditions.ZIP_EXTENDED_OPT())
	endmacro;
	
	export CITY_KEYED() := macro
		keyed(JoinConditions.CITY())
	endmacro;
	
	export CITY_OPT_KEYED() := macro
		keyed(JoinConditions.CITY_OPT())
	endmacro;
			
	export PNAME_KEYED() := macro
		keyed(JoinConditions.PNAME())
	endmacro;
	
	export PNAME_OPT_KEYED() := macro
		keyed(JoinConditions.PNAME_OPT())
	endmacro;
	
	export PRANGE_KEYED() := macro
		keyed(JoinConditions.PRANGE())
	endmacro;
	
	export PRANGE_OPT_KEYED() := macro
		keyed(JoinConditions.PRANGE_OPT())
	endmacro;
	
	export SRANGE_KEYED() := macro
		keyed(JoinConditions.SRANGE())
	endmacro;
	
	export SRANGE_OPT_KEYED() := macro
		keyed(JoinConditions.SRANGE_OPT())
	endmacro;
	
	export FEIN_KEYED() := macro
		keyed(JoinConditions.FEIN())
	endmacro;
	
	export FEIN_PARTS_KEYED() := macro
		keyed(right.f1 = intformat(left.fein_value,9,1)[1]) and
		keyed(right.f2 = intformat(left.fein_value,9,1)[2]) and
		keyed(right.f3 = intformat(left.fein_value,9,1)[3]) and
		keyed(right.f4 = intformat(left.fein_value,9,1)[4]) and
		keyed(right.f5 = intformat(left.fein_value,9,1)[5]) and
		keyed(right.f6 = intformat(left.fein_value,9,1)[6]) and
		keyed(right.f7 = intformat(left.fein_value,9,1)[7]) and
		keyed(right.f8 = intformat(left.fein_value,9,1)[8]) and
		keyed(right.f9 = intformat(left.fein_value,9,1)[9])
	endmacro;
	
	export FEIN_OPT_KEYED() := macro
		keyed(JoinConditions.FEIN_OPT())
	endmacro;
	
	export P7_KEYED() := macro
		keyed(JoinConditions.P7())
	endmacro;
	
	export P3_KEYED() := macro
		keyed(JoinConditions.P3())
	endmacro;
	
	export PHONE() := macro
		(
			JoinConditions.P7() and JoinConditions.P3()
		)
	endmacro;
	
	export PHONE_KEYED() := macro
		JoinConditions.P7_KEYED() and JoinConditions.P3_KEYED()
	endmacro;
	
	export WORD_KEYED() := macro
		keyed(JoinConditions.WORD())
	endmacro;
	
	export WORD_OPT_KEYED() := macro
		keyed(JoinConditions.WORD_OPT())
	endmacro;
	
	export INDIC_KEYED() := macro
		keyed(JoinConditions.INDIC())
	endmacro;
	
	export INDIC_OPT_KEYED() := macro
		keyed(JoinConditions.INDIC_OPT())
	endmacro;
	
	export SEC_KEYED() := macro
		keyed(JoinConditions.SEC())
	endmacro;
	
	export SEC_OPT_KEYED() := macro
		keyed(JoinConditions.SEC_OPT())
	endmacro;
	
	export CNAME_KEYED() := macro
		keyed(JoinConditions.CNAME())
	endmacro;
	
	export CNAME_OPT_KEYED() := macro
		keyed(JoinConditions.CNAME_OPT())
	endmacro;
	
	export CNAME_DIAL() := macro
		(
			JoinConditions.WORD() and JoinConditions.INDIC() and JoinConditions.SEC() and JoinConditions.CNAME()
		)
	endmacro;
	
	export CNAME_DIAL_OPT() := macro
		(
			JoinConditions.WORD_OPT() and JoinConditions.INDIC_OPT() and JoinConditions.SEC_OPT() and JoinConditions.CNAME_OPT()
		)
	endmacro;
	
	export CNAME_DIAL_KEYED() := macro
		JoinConditions.WORD_KEYED() and JoinConditions.INDIC_KEYED() and JoinConditions.SEC_KEYED() and JoinConditions.CNAME_KEYED()
	endmacro;
	
	export CNAME_DIAL_OPT_KEYED() := macro
		JoinConditions.WORD_OPT_KEYED() and JoinConditions.INDIC_OPT_KEYED() and JoinConditions.SEC_OPT_KEYED() and JoinConditions.CNAME_OPT_KEYED()
	endmacro;

end;
