import BO_Address;
export AddrUtils := module

export string prim_range(string payload) := function
return(BO_Address.parse_xml('PRIMARY_NUMBER',payload));
end;
export string predir(string payload) := function
return(BO_Address.parse_xml('PRIMARY_PREFIX',payload));
end;
export string prim_name(string payload) := function
return(BO_Address.parse_xml('PRIMARY_NAME',payload));
end;
export string addr_suffix(string payload) := function
return(BO_Address.parse_xml('PRIMARY_TYPE',payload));
end;
export string postdir(string payload) := function
return(BO_Address.parse_xml('PRIMARY_POSTFIX',payload));
end;
export string unit_desig(string payload) := function
return(BO_Address.parse_xml('UNIT_DESCRIPTION',payload));
end;
export string sec_range(string payload) := function
return(BO_Address.parse_xml('UNIT_NUMBER',payload));
end;
export string p_city_name(string payload) := function
string city_abbr:= BO_Address.parse_xml ('LOCALITY1_OFFICIAL_ABBR',payload);
string city := BO_Address.parse_xml('CITY',payload);
return(if (city_abbr = '',city,city_abbr));
end;
export string v_city_name(string payload) := function
return(BO_Address.parse_xml('V_CITY_NAME',payload));
end;
export string st(string payload) := function
return(BO_Address.parse_xml('REGION',payload));
end;
export string zip(string payload) := function
return(BO_Address.parse_xml('POSTCODE1',payload));
end;
export string zip4(string payload) := function
return(BO_Address.parse_xml('POSTCODE2',payload));
end;
export string cart(string payload) := function
return(BO_Address.parse_xml('CART',payload));
end;
export string cr_sort_sz(string payload) := function
return(BO_Address.parse_xml('CR_SORT_SZ',payload));
end;
export string lot(string payload) := function
return(BO_Address.parse_xml('LOT',payload));
end;
export string lot_order(string payload) := function
return(BO_Address.parse_xml('LOT_ORDER',payload));
end;
export string dpbc(string payload) := function
return(BO_Address.parse_xml('DPBC',payload));
end;
export string chk_digit(string payload) := function
return(BO_Address.parse_xml('CHECK_DIGIT',payload));
end;
export string record_type(string payload) := function
return(BO_Address.parse_xml('RECORD_TYPE',payload));
end;

export string ace_fips_state(string payload) := function
string state := BO_Address.parse_xml('REGION',payload);
string state_code := map(
	state = 'AL' =>  '01',
	state = 'AK' =>  '02',
	state = 'AZ' =>  '04',
	state = 'AR' =>  '05',
	state = 'CA' =>  '06',
	state = 'CO' =>  '08',
	state = 'CT' =>  '09',
	state = 'DE' =>  '10',
	state = 'DC' =>  '11',
	state = 'FL' =>  '12',
	state = 'GA' =>  '13',
	state = 'HI' =>  '15',
	state = 'ID' =>  '16',
	state = 'IL' =>  '17',
	state = 'IN' =>  '18',
	state = 'IA' =>  '19',
	state = 'KS' =>  '20',
	state = 'KY' =>  '21',
	state = 'LA' =>  '22',
	state = 'ME' =>  '23',
	state = 'MD' =>  '24',
	state = 'MA' =>  '25',
	state = 'MI' =>  '26',
	state = 'MN' =>  '27',
	state = 'MS' =>  '28',
	state = 'MO' =>  '29',
	state = 'MT' =>  '30',
	state = 'NE' =>  '31',
	state = 'NV' =>  '32',
	state = 'NH' =>  '33',
	state = 'NJ' =>  '34',
	state = 'NM' =>  '35',
	state = 'NY' =>  '36',
	state = 'NC' =>  '37',
	state = 'ND' =>  '38',
	state = 'OH' =>  '39',
	state = 'OK' =>  '40',
	state = 'OR' =>  '41',
	state = 'PA' =>  '42',
	state = 'RI' =>  '44',
	state = 'SC' =>  '45',
	state = 'SD' =>  '46',
	state = 'TN' =>  '47',
	state = 'TX' =>  '48',
	state = 'UT' =>  '49',
	state = 'VT' =>  '50',
	state = 'VA' =>  '51',
	state = 'WA' =>  '53',
	state = 'WV' =>  '54',
	state = 'WI' =>  '55',
	state = 'WY' =>  '56',

	state = 'AS' =>  '60',
	state = 'FM' =>  '64',
	state = 'GU' =>  '66',
	state = 'MH' =>  '68',
	state = 'MP' =>  '69',
	state = 'PW' =>  '70',
	state = 'PR' =>  '72',
	state = 'UM' =>  '74',
	state = 'VI' =>  '78','');

return(state_code);
end;

export string county(string payload) := function
return(BO_Address.parse_xml('COUNTY',payload));
end;

export string geo_lat(string payload) := function
return(BO_Address.parse_xml('LATITUDE',payload));
end;
export string geo_long(string payload) := function
return(BO_Address.parse_xml('LONGITUDE',payload));
end;
export string msa(string payload) := function
return(BO_Address.parse_xml('METRO_STAT_AREA_CODE',payload));
end;
export string geo_blk(string payload) := function
return(BO_Address.parse_xml('GEO_BLKE',payload));
end;
export string geo_match(string payload) := function
string al :=(BO_Address.parse_xml('ASSIGNMENT_LEVEL',payload));
string rt := map(
  al = 'PRE' =>  '0',
	al = 'PRI' =>  '0',
	al = 'L1' =>  '5',
	al = 'L2' =>  '5',
	al = 'L3' =>  '5',
	al = 'L4' =>  '5',
	al = 'P1' =>  '5',
	al = 'P2P' =>  '4',
	al = 'PF' =>  '1','5');
return(rt);	
	
end;

export string err_stat(string payload) := function
string err := BO_Address.parse_xml('ERR_STAT',payload);
string fault := BO_Address.parse_xml('FAULT_CODE',payload);
return(if(err = '', fault , err));
end;

export string language(string payload) := function
return (BO_Address.parse_xml('LANGUAGE= "" ',payload));
 
end;

export string postcode_full(string payload) := function
string postcode1 := BO_Address.parse_xml('POSTCODE1',payload);
string postcode2 := BO_Address.parse_xml('POSTCODE2',payload);
string postcode_full:= postcode1+postcode2;
return postcode_full;
end;


export string status_code(string payload) := function
return(BO_Address.parse_xml('STATUS_CODE',payload));
end;

export string region1(string payload) := function
return(BO_Address.parse_xml('REGION1',payload));
end;

// these should go into name utils
export string6 dpn(string payload) := function
return(BO_Address.parse_xml('PRENAME',payload));
end;

export string20 fn(string payload) := function
return(BO_Address.parse_xml('FIRST_NAME',payload));
end;

export string20 mn(string payload) := function
return(BO_Address.parse_xml('MIDDLE_NAME',payload));
end;

export string30 dlastn(string payload) := function
return(BO_Address.parse_xml('LAST_NAME',payload));
end;

export string7 dsuf(string payload) := function
return(BO_Address.parse_xml('SUFFIX_NAME',payload));
end;

export string7 dhon(string payload) := function
return(BO_Address.parse_xml('HONORARY_POST',payload));
end;

export string7 dtl(string payload) := function
return(BO_Address.parse_xml('TITLE',payload));
end;



////////////////////////////////////////////////////
// Enclarity
export string9 rural_route_number(string payload) := function
return(BO_Address.parse_xml('RURAL_ROUTE_NUMBER',payload));
end;
export string9 po_box_number(string payload) := function
return(BO_Address.parse_xml('POSTAL_BOX_NUMBER',payload));
end;


export string50 secondary_address(string payload) := function
return(BO_Address.parse_xml('SECONDARY_ADDRESS',payload));
end;


export string1 rdi(string payload) := function
return(BO_Address.parse_xml('RDI_INDICATOR',payload));
end;


//export string10 non_postal_unit(string payload) := function
//return(BO_Address.parse_xml('NON_POSTAL_UNIT_NUMBER',payload));
//end;


export string64 address_line_remainder1(string payload) := function
return(BO_Address.parse_xml('ADDRESS_LINE_REMAINDER1',payload));
end;


export string64 extra1(string payload) := function
return(BO_Address.parse_xml('EXTRA1',payload));
end;


export string64 extra2(string payload) := function
return(BO_Address.parse_xml('EXTRA2',payload));
end;


export string64 extra3(string payload) := function
return(BO_Address.parse_xml('EXTRA3',payload));
end;


export string64 extra4(string payload) := function
return(BO_Address.parse_xml('EXTRA4',payload));
end;


export string64 extra5(string payload) := function
return(BO_Address.parse_xml('EXTRA5',payload));
end;


export string64 extra6(string payload) := function
return(BO_Address.parse_xml('EXTRA6',payload));
end;


export string64 extra7(string payload) := function
return(BO_Address.parse_xml('EXTRA7',payload));
end;


export string64 extra8(string payload) := function
return(BO_Address.parse_xml('EXTRA8',payload));
end;


export string64 extra9(string payload) := function
return(BO_Address.parse_xml('EXTRA9',payload));
end;


export string64 extra10(string payload) := function
return(BO_Address.parse_xml('EXTRA10',payload));
end;


export string64 extra_secondary_address_data(string payload) := function
return(BO_Address.parse_xml('EXTRANEOUS_SECONDARY_ADDRESS_DATA',payload));
end;


export string10 extra_secondary_unit_number(string payload) := function
return(BO_Address.parse_xml('EXTRANEOUS_SECONDARY_UNIT_NUMBER',payload));
end;


export string10 extra_secondary_non_postal(string payload) := function
return(BO_Address.parse_xml('EXTRANEOUS_SECONDARY_NON_POSTAL',payload));
end;


export string10 postal_type(string payload) := function
return(BO_Address.parse_xml('POSTCODE_TYPE',payload));
end;


export string10 non_postal_unit(string payload) := function
return(BO_Address.parse_xml('NON_POSTAL_UNIT',payload));
end;


export string10 non_postal_unit_number(string payload) := function
return(BO_Address.parse_xml('NON_POSTAL_UNIT_NUMBER',payload));
end;


export string10 rural_box_number(string payload) := function
return(BO_Address.parse_xml('RURAL_ROUTE_BOX_NUMBER',payload));
end;




////////////////////////////////////////////////////
// india (gac)  stuff here


export string gac_region1_full(string payload) := function
return(BO_Address.parse_xml('REGION1_FULL',payload));
end;

export string gac_region2_full(string payload) := function
return(BO_Address.parse_xml('REGION2_FULL',payload));
end;

export string gac_postcode_full(string payload) := function
return(BO_Address.parse_xml('POSTCODE_FULL1',payload));
end;

export string gac_primary_name_full(string payload) := function
return(BO_Address.parse_xml('PRIMARY_NAME_FULL1',payload));
end;


export string gac_primary_name_full2(string payload) := function
return(BO_Address.parse_xml('PRIMARY_NAME_FULL2',payload));
end;
export string gac_primary_number_desc(string payload) := function
return(BO_Address.parse_xml('PRIMARY_NUMBER_DESCRIPTION',payload));
end;

export string gac_firm(string payload) := function
return(BO_Address.parse_xml('FIRM',payload));
end;

export string gac_secadd(string payload) := function
return(BO_Address.parse_xml('SECONDARY_ADDRESS',payload));
end;

export string gac_alrem1(string payload) := function
return(BO_Address.parse_xml('ADDRESS_LINE_REMAINDER1',payload));
end;


export string gac_alrem2(string payload) := function
return(BO_Address.parse_xml('ADDRESS_LINE_REMAINDER2',payload));
end;


export string gac_alrem3(string payload) := function
return(BO_Address.parse_xml('ADDRESS_LINE_REMAINDER3',payload));
end;


export string gac_alrem4(string payload) := function
return(BO_Address.parse_xml('ADDRESS_LINE_REMAINDER4',payload));
end;



export string gac_extra1(string payload) := function
return(BO_Address.parse_xml('EXTRA1',payload));
end;

export string gac_extra2(string payload) := function
return(BO_Address.parse_xml('EXTRA2',payload));
end;

export string gac_extra3(string payload) := function
return(BO_Address.parse_xml('EXTRA3',payload));
end;

export string gac_extra4(string payload) := function
return(BO_Address.parse_xml('EXTRA4',payload));
end;

export string gac_extra5(string payload) := function
return(BO_Address.parse_xml('EXTRA5',payload));
end;

export string gac_extra6(string payload) := function
return(BO_Address.parse_xml('EXTRA6',payload));
end;

export string gac_extra7(string payload) := function
return(BO_Address.parse_xml('EXTRA7',payload));
end;

export string gac_extra8(string payload) := function
return(BO_Address.parse_xml('EXTRA8',payload));
end;

export string gac_extra9(string payload) := function
return(BO_Address.parse_xml('EXTRA9',payload));
end;

export string gac_extra10(string payload) := function
return(BO_Address.parse_xml('EXTRA10',payload));
end;

export string gac_extra11(string payload) := function
return(BO_Address.parse_xml('EXTRA11',payload));
end;

export string gac_extra12(string payload) := function
return(BO_Address.parse_xml('EXTRA12',payload));
end;







export string gac_address_type(string payload) := function
return(BO_Address.parse_xml('ADDRESS_TYPE',payload));
end;

export string gac_area_name(string payload) := function
return(BO_Address.parse_xml('AREA_NAME1',payload));
end;

export string gac_building_name1(string payload) := function
return(BO_Address.parse_xml('BUILDING_NAME1',payload));
end;

export string gac_building_name2(string payload) := function
return(BO_Address.parse_xml('BUILDING_NAME2',payload));
end;

export string gac_info_code(string payload) := function
return(BO_Address.parse_xml('INFO_CODE',payload));
end;

export string gac_country(string payload) := function
return(BO_Address.parse_xml('COUNTRY',payload));
end;

export string gac_locality1(string payload) := function
return(BO_Address.parse_xml('LOCALITY1_NAME',payload));
end;

export string gac_locality2(string payload) := function
return(BO_Address.parse_xml('LOCALITY2_NAME',payload));
end;

export string gac_locality3(string payload) := function
return(BO_Address.parse_xml('LOCALITY3_NAME',payload));
end;

export string gac_locality4(string payload) := function
return(BO_Address.parse_xml('LOCALITY4_NAME',payload));
end;

export string gac_point_of_reference1(string payload) := function
return(BO_Address.parse_xml('POINT_OF_REFERENCE1',payload));
end;

export string gac_point_of_reference2(string payload) := function
return(BO_Address.parse_xml('POINT_OF_REFERENCE2',payload));
end;

export string gac_postcode1(string payload) := function
return(BO_Address.parse_xml('POSTCODE1',payload));
end;

export string gac_postcode2(string payload) := function
return(BO_Address.parse_xml('POSTCODE2',payload));
end;

export string gac_primary_name1(string payload) := function
return(BO_Address.parse_xml('PRIMARY_NAME1',payload));
end;

export string gac_primary_name2(string payload) := function
return(BO_Address.parse_xml('PRIMARY_NAME2',payload));
end;

export string gac_primary_number(string payload) := function
return(BO_Address.parse_xml('PRIMARY_NUMBER',payload));
end;

export string gac_primary_postfix1(string payload) := function
return(BO_Address.parse_xml('PRIMARY_POSTFIX1',payload));
end;

export string gac_primary_prefix1(string payload) := function
return(BO_Address.parse_xml('PRIMARY_PREFIX1',payload));
end;

export string gac_primary_type1(string payload) := function
return(BO_Address.parse_xml('PRIMARY_TYPE1',payload));
end;

export string gac_region(string payload) := function
return(BO_Address.parse_xml('REGION1',payload));
end;

export string gac_status_code(string payload) := function
return(BO_Address.parse_xml('STATUS_CODE',payload));
end;

export string gac_unit_desig(string payload) := function
return(BO_Address.parse_xml('UNIT_DESCRIPTION',payload));
end;

export string gac_unit_number(string payload) := function
return(BO_Address.parse_xml('UNIT_NUMBER',payload));
end;

end;