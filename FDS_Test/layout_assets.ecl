export layout_assets :=
module

	export	Input	:=
	module
	
		export	rAssetsIn_layout	:=
		record
			string	Record_ID;
			string	Name;
			string	Business_Name;
			string	Address;
			string	Secondary_Address;
			string	City;
			string	State;
			string	Zip_Code;
			string	Phone_Number;
			string	SSN;
			string	Tax_ID_Number;
			string	VIN;
			string	Craft_ID;
			string	License_Plate_Number;
			string	License_Plate_State;
		end;
		
	end;
	
	export	Response	:=
	module
	
		export	rAssesAppendClnNameAddr_layout	:=
		record
			string12	ln_fares_id;
			string5		fips_code;
			string30	county_name;
			string45	apna_or_pin_number;
			string45	fares_unformatted_apn;
			string80	assessee_name;
			string60	second_assessee_name;
			string60	property_full_street_address;
			string6		property_unit_number;
			string51	property_city_state_zip;
			string80	mailing_full_street_address;
			string6		mailing_unit_number;
			string51	mailing_city_state_zip;
			string10	assessee_phone_number;
			string1		homestead_homeowner_exemption;
			string4		tax_year;
			string13	tax_amount;
			string4		assessed_value_year;
			string11	assessed_total_value;
			string11	assessed_improvement_value;
			string4		standardized_land_use_code;
			string4		year_built;
			string4		effective_year_built;
			string5		no_of_rooms;
			string8		no_of_baths;
			string5		no_of_units;
			string5		no_of_stories;
			string5		no_of_bedrooms;
			string3		fireplace_number;
			string5		roof_type_code;
			string3		garage_type_code;
			string5		parking_no_of_cars;
			string3		pool_code;
			string3		heating_code;
			string3		air_conditioning_code;
			string3		type_construction_code;
			string20	lot_size;
			string10	lot_size_frontage_feet;
			string10	lot_size_depth_feet;
			string9		building_area;
			string1		building_area_indicator;
			string8		building_area1;
			string2		building_area1_indicator;
			string8		building_area2;
			string2		building_area2_indicator;
			string8		building_area3;
			string2		building_area3_indicator;
			string8		building_area4;
			string2		building_area4_indicator;
			string8		building_area5;
			string2		building_area5_indicator;
			string8		building_area6;
			string2		building_area6_indicator;
			string8		building_area7;
			string2		building_area7_indicator;
			string10	legal_tract_number;
			string7		legal_lot_number;
			string30	legal_city_municipality_township;
			string40	legal_subdivision_name;
			string7		legal_block;
			string12	legal_district;
			string7		legal_section;
			string25	zoning;
			
			string5		vendor_source_flag;
			string330	standard_use_description	:=	'';
			string330	garage_description				:=	'';
			string330	construction_description	:=	'';
			string330	heating_description				:=	'';
			string330	cooling_description				:=	'';
			string330	roofing_description				:=	'';
			
			string20	owner1_fname;
			string20	owner1_lname;
			string20	owner1_mname;
			string80	owner1_cname;
			unsigned6	owner1_did;
			string9		owner1_ssn;
			
			string20	owner2_fname;
			string20	owner2_lname;
			string20	owner2_mname;
			string80	owner2_cname;
			unsigned6	owner2_did;
			string9		owner2_ssn;
			
			string10  property_prim_range;
			string2   property_predir;
			string28  property_prim_name;
			string4   property_addr_suffix;
			string2   property_postdir;
			string10  property_unit_desig;
			string8   property_sec_range;
			string25  property_city_name;
			string2   property_st;
			string5   property_zip;
			string4   property_zip4;
			
			string10  mail_prim_range;
			string2   mail_predir;
			string28  mail_prim_name;
			string4   mail_addr_suffix;
			string2   mail_postdir;
			string10  mail_unit_desig;
			string8   mail_sec_range;
			string25  mail_city_name;
			string2   mail_st;
			string5   mail_zip;
			string4   mail_zip4;
		end;
		
		export	rDeedsAppendClnNameAddr_layout	:=
		record
			string12	ln_fares_id;
			string5		fips_code;
			string18	county_name;
			string45	apnt_or_pin_number;
			string45	fares_unformatted_apn;
			string1		buyer_or_borrower_ind;
			string80	name1;
			string80	name2;
			string80	seller1;
			string80	seller2;
			string70	property_full_street_address;
			string6		property_address_unit_number;
			string51	property_address_citystatezip;
			string70	mailing_street;
			string6		mailing_unit_number;
			string51	mailing_csz;
			string10	phone_number;
			string40	lender_name;
			string60	title_company_name;
			string8		contract_date;
			string8		recording_date;
			string11	sales_price;
			string11	first_td_loan_amount;
			string5		first_td_loan_type_code;
			string11	second_td_loan_amount;
			string20	document_number;
			string3		document_type_code;
			string8		first_td_due_date;
			string10	land_lot_size;
			string100	legal_brief_description;
			string10	legal_tract_number;
			string10	legal_lot_number;
			string30	legal_city_municipality_township;
			string50	legal_subdivision_name;
			string7		legal_block;
			string7		legal_district;
			string7		legal_section;
			string5		vendor_source_flag;
			string330	loan_type_description			:=	'';
			string330	document_type_description	:=	'';
	
			string20	owner1_fname;
			string20	owner1_lname;
			string20	owner1_mname;
			string80	owner1_cname;
			unsigned6	owner1_did;
			string9		owner1_ssn;
			
			string20	owner2_fname;
			string20	owner2_lname;
			string20	owner2_mname;
			string80	owner2_cname;
			unsigned6	owner2_did;
			string9		owner2_ssn;
						
			string20	seller1_fname;
			string20	seller1_lname;
			string20	seller1_mname;
			string80	seller1_cname;
			unsigned6	seller1_did;
			string9		seller1_ssn;
			
			string20	seller2_fname;
			string20	seller2_lname;
			string20	seller2_mname;
			string80	seller2_cname;
			unsigned6	seller2_did;
			string9		seller2_ssn;
			
			string10  property_prim_range;
			string2   property_predir;
			string28  property_prim_name;
			string4   property_addr_suffix;
			string2   property_postdir;
			string10  property_unit_desig;
			string8   property_sec_range;
			string25  property_city_name;
			string2   property_st;
			string5   property_zip;
			string4   property_zip4;
			
			string10  mail_prim_range;
			string2   mail_predir;
			string28  mail_prim_name;
			string4   mail_addr_suffix;
			string2   mail_postdir;
			string10  mail_unit_desig;
			string8   mail_sec_range;
			string25  mail_city_name;
			string2   mail_st;
			string5   mail_zip;
			string4   mail_zip4;
		end;

		export	rFDSProperty_layout	:=
		record,maxlength(8192)
			string	Record_ID;
			string	Owner1_First_Name;
			string	Owner1_Middle_Name;
			string	Owner1_Last_Name;
			string	Owner1_Company_Name;
			string	Owner2_First_Name;
			string	Owner2_Middle_Name;
			string	Owner2_Last_Name;
			string	Owner2_Company_Name;
			string	Property_Street_Address;
			string	Property_Street_Address2;
			string	Property_City;
			string	Property_State;
			string	Property_Zip;
			string	Mailing_Street_Address;
			string	Mailing_Street_Address2;
			string	Mailing_City;
			string	Mailing_State;
			string	Mailing_Zip;
			string	Indicator_Addresses_Same;
			string	Phone;
			string	Business_Indicator;
			string	Lender_Name;
			string	Title_Company;
			string	County;
			string	Parcel_Number;
			string	Assessed_Value;
			string	Homeowner_Exempt;
			string	Tax_Amount;
			string	Improvement_Value;
			string	Sale_Date;
			string	Sale_Amount;
			string	First_Loan_Amount;
			string	Loan_Type;
			string	Seller_First_Name;
			string	Seller_Middle_Name;
			string	Seller_Last_Name;
			string	Seller_Company_Name;
			string	Sale_Doc_Number;
			string	Transaction;
			string	Second_Loan_Amount;
			string	Deed_Description;
			string	Mortgage_Due_Date;
			string	Standard_Use_Description;
			string	Year_Built;
			string	Number_of_Units;
			string	Number_Fireplaces;
			string	Garage;
			string	Number_of_Garage_Stalls;
			string	Construction_desc;
			string	Effective_Year_Built;
			string	Number_of_Stories;
			string	Pool_Indicator;
			string	Garage_Sq_Feet;
			string	Roofing_Description;
			string	Total_Sq_Feet;
			string	Basement_Sq_Feet;
			string	Number_of_Bedrooms;
			string	Heating_Detail;
			string	Number_of_Rooms;
			string	Number_of_Baths;
			string	Cooling_Detail;
			string	Lot_Size;
			string	Lot_Depth;
			string	Tract_Number;
			string	Lot_Number;
			string	Township;
			string	Subdivision_Name;
			string	Lot_Width;
			string	Zoning;
			string	Block_Number;
			string	District;
			string	Section;
		end;
		
		export	rFDSAircraft_layout	:=
		record
			string	Record_ID;
			string	First_Name;
			string	Middle_Name;
			string	Last_Name;
			string	Company_Name;
			string	Address_Line1;
			string	Address_Line2;
			string	City;
			string	State;
			string	Zip;
			string	Aircraft_Number;
			string	Model_Name;
			string	Manufacture_Year;
			string	Engine_Model;
			string	History_Flag;
			string	Registration_Type;
			string	Record_Type;
			string	Serial_Number;
			string	Model_Code;
			string	Manufacturer_Name;
			string	Aircraft_Type;
			string	Year_First_Seen;
			string	Year_Last_Seen;
		end;

	end;
	
end;