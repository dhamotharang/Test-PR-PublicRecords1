EXPORT Layouts := module

export PreProcess_Assessor_Layout := record
	LN_PropertyV2.layout_property_common_model_base-[ln_ownership_rights,
		ln_relationship_type,
		ln_mailing_country_code,
		ln_property_name,
		ln_property_name_type,
		ln_land_use_category,
		ln_lot,
		ln_block,
		ln_unit,
		ln_subfloor,
    ln_floor_cover,
		ln_mobile_home_indicator,
		ln_condo_indicator,
		ln_property_tax_exemption,
		ln_veteran_status,
		ln_old_apn_indicator];
end;

export PreProcess_Deed_Layout := record
	LN_PropertyV2.layout_deed_mortgage_common_model_base-[ln_ownership_rights,
		ln_relationship_type,
		ln_buyer_mailing_country_code,
		ln_seller_mailing_country_code];
end;

export PreProcess_Search_Layout := record
	LN_PropertyV2.Layout_DID_Out-[ln_party_status,
		ln_percentage_ownership,
		ln_entity_type,
		ln_estate_trust_date,
		ln_goverment_type,
		nid,
		xadl2_weight];
end;

export layout_property_common_model_base_scrubs := record
  LN_PropertyV2.layout_property_common_model_base;
	unsigned8 RuleBitMap := 0 ; 
end;

export layout_deed_mortgage_common_model_base_scrubs := record
  LN_PropertyV2.layout_deed_mortgage_common_model_base;
  unsigned8 RuleBitMap := 0 ; 
end;

export StatsLayout       := record 
				
  string8		process_date;
  string1		vendor_source_flag;
	unsigned8 RuleBitMap ; 
	string500 RuleDesc ;
	unsigned4 RecordsTotal ;

end;

export RawcodeStatsLayout := record 

	unsigned4       RecordsTotal; 
	string8					process_date;
	string1					vendor_source_flag;
	string100       RuleDesc ;
	unsigned4       Rulecnt ;
	unsigned2       RulePct;
	string1         RejectWarning;  
	string25        RawCodeMissing ;
	unsigned4       RawCodeMissingcnt ;
	String3         Code:= '';
	string1         Severity := ''; 
end; 

export RawcodeStatsLayoutOut := record 

	unsigned4       RecordsTotal; 
	string8					ProcessDate;
	string5					SourceCode;
	string100       RuleDesc ;
	unsigned4       Rulecnt ;
	unsigned2       RulePct;
	string1         RejectWarning;  // Rule pct > Threshold reject then Y else N 
	string25        RawCodeMissing ;
	unsigned4       RawCodeMissingcnt ;

end; 

export rRuleCodeDescription :=
record
	string1			Severity;
	string3			RuleCode;
	string100		RuleDesc;
  string100		RuledisplayName;
end;
end;