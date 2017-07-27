export Lookup_Descriptions := module

export Record_Type_Description_lookup (string Record_Type_Code) := case(Record_Type_Code,
											'F' => 'FIRM',
											'H' => 'HIGHRISE',
											'G' => 'GENERAL',
											'P' => 'PO BOX',
											'R' => 'RURAL ROUTE',
											'S' => 'STREET',
											'');
export Record_Type_Description_lookup_mixed (string Record_Type_Code) := case(Record_Type_Code,
											'F' => 'Firm',
											'H' => 'High-rise',
											'G' => 'General Delivery',
											'P' => 'PO Box',
											'R' => 'Rural Route',
											'');
export Route_Description_lookup (string Route_Num) := case(Route_Num[1],
											'B' => 'PO BOX',
											'C' => 'CITY DELIVERY',
											'G' => 'GENERAL DELIVERY',
											'H' => 'HIGHWAY CONTRACT',
											'R' => 'RURAL ROUTE',
											'');

export Address_Vacancy_Description_lookup (string Address_Vacancy_Indicator) := case(Address_Vacancy_Indicator,
											'N' => 'NOT VACANT',
											'Y' => 'VACANT 90 DAYS OR MORE',
											'');

export Seasonal_Delivery_Description_lookup (string Seasonal_Delivery_Indicator) := case(Seasonal_Delivery_Indicator,
											'N' => 'NOT APPLICABLE',
											'Y' => 'DELIVERY POINT HAS SEASONAL DELIVERY',
											'');

export Delivery_Type_Description_lookup (string Residential_or_Business_Ind) := case(Residential_or_Business_Ind,
											'A' => 'RESIDENTIAL CURB',
											'B' => 'RESIDENTIAL NEIGHBORHOOD DELIVERY AND COLLECTION BOX UNITS',
											'C' => 'RESIDENTIAL CENTRAL',
											'D' => 'RESIDENTIAL OTHER',
											'E' => 'RESIDENTIAL FACILITY BOX',
											'F' => 'RESIDENTIAL CONTRACT BOX',
											'G' => 'RESIDENTIAL DETACHED BOX',
											'H' => 'RESIDENTIAL NON-PERSONAL UNIT',
											'I' => 'BUSINESS CURB',
											'J' => 'BUSINESS NEIGHBORHOOD DELIVERY AND COLLECTION BOX UNITS',
											'K' => 'BUSINESS CENTRAL',
											'L' => 'BUSINESS OTHER',
											'M' => 'BUSINESS FACILITY BOX',
											'N' => 'BUSINESS CONTRACT BOX',
											'O' => 'BUSINESS DETACHED BOX',
											'P' => 'BUSINESS NON-PERSONAL UNIT',
											'Q' => 'GENERAL DELIVERY',
											'');


  export string  fn_resbus(string1 in_resbus) := function
	   outresbus := case(in_resbus,
		                  'A' => 'RESIDENTIAL',
		                  'C' => 'PRIMARY RESIDENTIAL WITH BUSINESS', 
                      'B' => 'BUSINESS',
											'D' => 'PRIMARY BUSINESS WITH RESIDENTIAL',
											'');
	   return outresbus;
	end;
	export string  fn_resbus_mixed(string1 in_resbus) := function
	   outresbus := case(in_resbus,
		                  'A' => 'Residential',
		                  'C' => 'Primary Residential with Business', 
                      'B' => 'Business',
											'D' => 'Primary Business with Residential',
											'');
	   return outresbus;
	end;
	export string  fn_addrtype(string1 in_addrtype) := function
	   outaddrtype := case(in_addrtype,
		                  '0' => 'UNDEFINED OR BUSINESS',
		                  '1' => 'SINGLE FAMILY DWELLING UNITS', 
                      '2' => 'MULIT- FAMILY DWELLING UNITS',
											'9' => 'PO BOX',
											'');
	   return outaddrtype;
	end;
	export string  fn_mixuse(string1 in_mixuse) := function
	 outMixuse := case(in_mixuse,
       'A' => 'CURBLINE',
       'B' => 'NEIGHBORHOOD DELIVERY AND COLLECTION BOX UNITS',
       'C' => 'CENTRAL', 
       'D' => 'OTHER',
       'E' => 'FACILITY BOX',
       'F' => 'CONTRACT BOX',  
       'G' => 'DETACHED BOX', 
       'H' => 'RESIDENTIAL NON-PERSONNEL UNIT',
       'S' => 'CALLER SERVICE BOX',
       'T' => 'REMITTANCE BOX',
       'U' => 'CONTEST BOX',
       'V' => 'OTHER BOX',
       'Q' => 'GENERAL DELIVERY',
       '');		
	   return outMixuse;
	end;
	export string  fn_mixuse_mixed(string1 in_mixuse) := function
	 outMixuse := case(in_mixuse,
       'F' => 'Contacted USPS Box located in a small community or place of business',  
       'H' => 'Non-staffed or rural unit',
       'S' => 'High volume PO Box',
       'T' => 'Remittance Box, often a payment center',
       'Q' => 'General Delivery Box, may be transient or temporary service',
       '');		
	   return outMixuse;
	end;
end;	