export AVM := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100110a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__avm_v2__comp_fid	:=
record
	string12 ln_fares_id;
	unsigned8 seq;
	string45 unformatted_apn;
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
	string4 land_use_code;
	string11 sales_price;
	string1 sales_price_code;
	string8 recording_date;
	string4 assessed_value_year;
	string11 assessed_total_value;
	string11 market_total_value;
	string30 lot_size;
	string9 building_area;
	string4 year_built;
	string5 no_of_stories;
	string5 no_of_rooms;
	string5 no_of_bedrooms;
	string7 no_of_baths;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__avm_v2__comp_fid := dataset(lCSVFileNamePrefix + 'thor_data400__key__avm_v2__' + lCSVVersion + '__comp_fid.csv', rthor_data400__key__avm_v2__comp_fid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;