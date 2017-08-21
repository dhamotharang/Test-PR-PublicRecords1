export Address_Table := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100105a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__key__address_table	:=
record
	string5 zip;
	string28 prim_name;
	string10 prim_range;
	string8 sec_range;
	string2 predir;
	string4 suffix;
	string2 postdir;
	integer8 ssn_ct;
	integer8 ssn_ct_c6;
	integer8 phone_ct;
	integer8 phone_ct_c6;
	integer8 did_ct;
	integer8 did_ct_c6;
	string5 fips_code;
	string7 geo_blk;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;
	string11 assessed_total_value;
	string11 market_total_value;
	integer8 price_index_valuation;
	integer8 tax_assessment_valuation;
	integer8 hedonic_valuation;
	integer8 automated_valuation;
	integer8 confidence_score;
	integer8 median_fips_valuation;
	integer8 median_tract_valuation;
	integer8 median_block_valuation;
end;

export dthor_data400__key__address_table := dataset(lCSVFileNamePrefix + 'thor_data400__key__' + lCSVVersion + '__address_table.csv', rthor_data400__key__address_table, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;