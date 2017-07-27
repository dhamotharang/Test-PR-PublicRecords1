export layout_property_hedonic := record
	string12 ln_fares_id;  // for internal testing
	string64 address;
	string30 city;
	string2 st;
	string5 zip;
	STRING10 lat;  // for internal testing of distance
	STRING11 long;  // for internal testing of distance
	real distance;
	string1 land_use_code;
	string25 land_use_description;
	string11 sales_price;
	string8 recording_date;
	string4 assessed_value_year;
	string11 assessed_total_value;
	string11 market_total_value;
	string4	year_built;
	string30 lot_size;
	string9	building_area;
	string5	no_of_rooms;
	string5	no_of_bedrooms;
	string7	no_of_baths;
	string5	no_of_stories;
end;
