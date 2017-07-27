export	Layout_Codes	:=
module

	// Layout containing the raw and standardized codes
	export	Raw2Standardized	:=
	record
		string35	file_name;
		string50	field_name;
		string5		raw_source;
		string15	raw_source_code;
		string15	standardized_code;
		string350	standardized_code_desc;
		string1		lf;
	end;
	
	// Layout for property codes
	export	MLS2Common	:=
	record
		string	file_name;
		string	source_code;
		string	field_name;
		string	raw_desc;
		string	common_code;
	end;
	
	// Layout for the structure attributes
	export	TradeMaterials	:=
	record
		string3		category;
		string3		material;
		real8			value;
		string1		quality;
		string1		condition;
		unsigned2	age;
	end;

	// Lookup for InsurBase category and material codes for Insurance and Appraisal files
	export	BB2IBCodeLookup	:=
	record
		string	category_code;
		string	trade_id;
		string	feature_name;
		string	material_code;
		string	material_description;
	end;
	
	// Common lookup layout for material codes and values
	export	MLS2IBCodeLookup	:=
	record
		unsigned2	which_node;
		unsigned1	data_source_id;
		string3		category_code;
		unsigned1	trade_id;
		string500	feature_description;
		string30	material_code;
		string15	value;
		string1		dynamic_value;
	end;
	
	export	DataFeatureCodes	:=
	record,maxlength(4098)
		string	feature_id;
		string	feature_name;
		string	data_source_id;
		string	feature_code;
		string	feature_description;
		string	trade_id;
		string	user_id;
		string	last_updated_date;
	end;
	
	export	DataFeatureValues	:=
	record,maxlength(4098)
		string	feature_id;
		string	material_code;
		string	value;
		string	dynamic_value;
		string	score;
		string	user_id;
		string	last_updated_date;
	end;
	
	export	ZipCodeDefaults	:=
	record
		string	zip_code;
		string	trade_id;
		string	trade_desc;
		string	subtrade_id;
		string	subtrade_desc;
		string	xmlxref;
		string	default_value;
	end;
	
	export	CensusTractDefaults	:=
	record
		string	fips_code;
		string	census_tract;
		string	trade_id;
		string	trade_desc;
		string	subtrade_id;
		string	subtrade_desc;
		string	xmlxref;
		string	default_value;
	end;
	
	export	ZipDefault2Common	:=
	record
		string5		zip_code;
		unsigned1	trade_id;
		string3		xmlxref;
		string3		common_code;
		string3		default_value;
	end;
	
	export	CensusDefault2Common	:=
	record
		string5		fips_code;
		string8		census_tract;
		unsigned1	trade_id;
		string3		xmlxref;
		string3		common_code;
		string3		default_value;
	end;
	
	// Layout for property codes
	export	LNPropertyCodes	:=
	record
		string50	field_name;
		string5		source_code;
		string15	raw_code;
		string15	common_code;
	end;
	
end;