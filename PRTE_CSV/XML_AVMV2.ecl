export XML_AVMV2 := 

module
   
  EXPORT integer8 avm_v2__max_history := 10;

	shared	lSubDirName					:=	'';
	shared	lXMLVersion					:=	'20100105';
	shared	lXMLFileNamePrefix	:=	PRTE_CSV.Constants.XMLFilesBaseName + lSubDirName;
	
export layout_history_slim :=
record
	string8 history_date;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;
	string11 assessed_total_value;
	string11 market_total_value;
	integer8 tax_assessment_valuation;
	integer8 price_index_valuation;
	integer8 hedonic_valuation;
	integer8 automated_valuation;
	integer8 confidence_score;
end;

export rthor_data400__key__avm_v2__address :=
record
	string28 prim_name;
	string2 st;
	string5 zip;
	string10 prim_range;
	string8 sec_range;
	string8 history_date;
	string12 ln_fares_id_ta;
	string12 ln_fares_id_pi;
	string45 unformatted_apn;
	string2 predir;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string25 p_city_name;
	string4 zip4;
	string10 lat;
	string11 long;
	string7 geo_blk;
	string5 fips_code;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;
	string11 assessed_total_value;
	string11 market_total_value;
	integer8 tax_assessment_valuation;
	integer8 price_index_valuation;
	integer8 hedonic_valuation;
	integer8 automated_valuation;
	integer8 confidence_score;
	string12 comp1;
	string12 comp2;
	string12 comp3;
	string12 comp4;
	string12 comp5;
	string12 nearby1;
	string12 nearby2;
	string12 nearby3;
	string12 nearby4;
	string12 nearby5;
	DATASET(layout_history_slim) history{maxCount(avm_v2__max_history)};
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__avm_v2__apn :=
record
	string45 unformatted_apn;
	string8 history_date;
	string12 ln_fares_id_ta;
	string12 ln_fares_id_pi;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string10 lat;
	string11 long;
	string7 geo_blk;
	string5 fips_code;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;
	string11 assessed_total_value;
	string11 market_total_value;
	integer8 tax_assessment_valuation;
	integer8 price_index_valuation;
	integer8 hedonic_valuation;
	integer8 automated_valuation;
	integer8 confidence_score;
	string12 comp1;
	string12 comp2;
	string12 comp3;
	string12 comp4;
	string12 comp5;
	string12 nearby1;
	string12 nearby2;
	string12 nearby3;
	string12 nearby4;
	string12 nearby5;
	DATASET(layout_history_slim) history{maxCount(avm_v2__max_history)};
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__avm_v2__address:= dataset(lXMLFileNamePrefix + 'thor_data400__key__avm_v2__' + lXMLVersion + '__address.xml', rthor_data400__key__avm_v2__address, xml('Dataset/Row'));
export dthor_data400__key__avm_v2__apn		:= dataset(lXMLFileNamePrefix + 'thor_data400__key__avm_v2__' + lXMLVersion + '__apn.xml', rthor_data400__key__avm_v2__apn, xml('Dataset/Row'));
end;