/* ******************************************************************************************************
Below in xfMoveNameAddress - we need to scramble names also.
If we want to keep data in the ones that are not blank - basically I think I’ll have to:
1.	Ensure all name/addresses for owner, buyer, assessee and borrower are replaced by the original name/property info
2.	Ensure all name/addresses for seller come from the sister address and replace any real production name/address
3.	I’m thinking we should only do this for the 1st value,  and all _2 values we should just blank out.
                  IE: buyer_1, owner_1, assessee_1, borrower_1, seller_1  –VS–  buyer_2, owner_2, assessee_2, borrower_2, seller_2
SSN values. I don’t think we have SSN in the XREF do we?  Have to decide if we blank those or link bogus ones.
WHAT ABOUT PHONE#s ???
WHAT ARE ID_DESC as in buyer_1_id_desc

DID VALUES: DO WE NEED TO ALSO DIG INTO THE HEADER AND LOAD DID/BDID VALUES ?????????????????????????????? I THINK SO YES.
MAKE SURE THE XREF HAS CLEAN ADDRESS INFO - ELSE WE MAY HAVE TO ADD THAT
****************************************************************************************************** */

// R = original home address
// L = XREF sister address

Layout2 	:= Layouts_LNP.LNP_XRef_Layout2;

EXPORT Layout2 transformScramble_LNP(Layout2 L,Layout2 R) := TRANSFORM
		appendSpaceIf(STRING base, STRING appnd) := IF(appnd='',base,base+' '+appnd);
		replaceIfNotBlank(STRING base, STRING replaceIf) := IF(base='', base, replaceIf);

			BLANK := '';
			homePersonName := appendSpaceIf(appendSpaceIf(R.fname,R.mname),R.lname);
			xrefPersonName := appendSpaceIf(appendSpaceIf(L.fname,L.mname),L.lname);
			xrefFName := L.fname;
			xrefMName := L.mname;
			xrefLName := L.lname;
			// DID values ???  I'm going to start with blanks, 
			// the actual build process - PRTE2_LNProperty.Get_payload - loads the main did from Boca HDR
			// self.did := BLANK;		
			SELF.BaseRec := R.BaseRec;
			SELF.MatchRec := L.BaseRec;
			SELF.XRec1 := R.XRec1;
			SELF.XRec2 := R.XRec2;
			SELF.fname := R.fname;
			SELF.mname := R.mname;
			SELF.lname := R.lname;
			SELF.SSN := R.SSN;
			SELF.dob := R.dob;
			SELF.address := R.address;
			SELF.apt := R.apt;
			SELF.city := R.city;
			SELF.st := R.st;
			SELF.zip := R.zip;
			SELF.acctno := R.acctno;
			SELF.error_code := R.error_code;
			SELF.matchcodes := R.matchcodes;
// Penny requested we keep:	County,City,State,Latitude,Longitude,Census Tract,Sq. Footage
// These are above and also spread among owner, buyer, assessee, etc...
			
			SELF.property_address1 := R.property_address1;
			SELF.property_address2 := R.property_address2;
			SELF.property_p_city_name := R.property_p_city_name;
			SELF.property_v_city_name := R.property_v_city_name;
			SELF.property_st := R.property_st;
			SELF.property_zip := R.property_zip;
			SELF.property_zip4 := R.property_zip4;
			SELF.property_county_name := R.property_county_name;
			SELF.property_geo_lat := R.property_geo_lat;
			SELF.property_geo_long := R.property_geo_long;
			SELF.property_msa := R.property_msa;
			SELF.property_orig_address := R.property_orig_address;
			SELF.property_orig_unit := R.property_orig_unit;
			SELF.property_orig_csz := R.property_orig_csz;

			//***************************************************************************************************
			//---------- CONTROL BUYER INFO FROM PRODUCTION --------------- use Property Info as BUYER
			SELF.buyer_address1 := replaceIfNotBlank(R.buyer_address1,SELF.property_address1);
			SELF.buyer_address2 := replaceIfNotBlank(R.buyer_address2,SELF.property_address2);
			SELF.buyer_p_city_name := replaceIfNotBlank(R.buyer_p_city_name,SELF.property_p_city_name);
			SELF.buyer_v_city_name := replaceIfNotBlank(R.buyer_v_city_name,SELF.property_v_city_name);
			SELF.buyer_st := replaceIfNotBlank(R.buyer_st,SELF.property_st);
			SELF.buyer_zip := replaceIfNotBlank(R.buyer_zip,SELF.property_zip);
			SELF.buyer_zip4 := replaceIfNotBlank(R.buyer_zip4,SELF.property_zip4);
			SELF.buyer_county_name := replaceIfNotBlank(R.buyer_county_name,SELF.property_county_name);
			SELF.buyer_geo_lat := replaceIfNotBlank(R.buyer_geo_lat,SELF.property_geo_lat);
			SELF.buyer_geo_long := replaceIfNotBlank(R.buyer_geo_long,SELF.property_geo_long);
			SELF.buyer_msa := replaceIfNotBlank(R.buyer_msa,SELF.property_msa);
			SELF.buyer_orig_address := replaceIfNotBlank(R.buyer_orig_address,SELF.property_orig_address);
			SELF.buyer_orig_unit := replaceIfNotBlank(R.buyer_orig_unit,SELF.property_orig_unit);
			SELF.buyer_orig_csz := replaceIfNotBlank(R.buyer_orig_csz,SELF.property_orig_csz);
			SELF.buyer_phone_number := BLANK;									//???
			SELF.buyer_vesting_desc := BLANK;									//???
			SELF.buyer_1_orig_name := replaceIfNotBlank(R.buyer_1_orig_name,homePersonName);
			SELF.buyer_1_id_desc := BLANK;
			SELF.buyer_1_title := BLANK;
			SELF.buyer_1_first_name := replaceIfNotBlank(R.buyer_1_first_name,SELF.fname);
			SELF.buyer_1_middle_name := replaceIfNotBlank(R.buyer_1_middle_name,SELF.mname);
			SELF.buyer_1_last_name := replaceIfNotBlank(R.buyer_1_last_name,SELF.lname);
			SELF.buyer_1_name_suffix := BLANK;
			SELF.buyer_1_company_name := BLANK;
			SELF.buyer_1_did := BLANK;
			SELF.buyer_1_bdid := BLANK;
			SELF.buyer_1_ssn := BLANK;
			//---------- BLANK BUYER, SELLER, ETC, BEYOND THE FIRST ---------------
			SELF.buyer_2_orig_name := BLANK;
			SELF.buyer_2_id_desc := BLANK;
			SELF.buyer_2_title := BLANK;
			SELF.buyer_2_first_name := BLANK;
			SELF.buyer_2_middle_name := BLANK;
			SELF.buyer_2_last_name := BLANK;
			SELF.buyer_2_name_suffix := BLANK;
			SELF.buyer_2_company_name := BLANK;
			SELF.buyer_2_did := BLANK;
			SELF.buyer_2_bdid := BLANK;
			SELF.buyer_2_ssn := BLANK;

			//***************************************************************************************************
			//---------- CONTROL SELLER INFO FROM PRODUCTION ---------------   USE XREF AS THE SELLER INFO
			SELF.seller_address1 := replaceIfNotBlank(R.seller_address1,L.property_address1);
			SELF.seller_address2 := replaceIfNotBlank(R.seller_address2,L.property_address2);
			SELF.seller_p_city_name := replaceIfNotBlank(R.seller_p_city_name,L.property_p_city_name);
			SELF.seller_v_city_name := replaceIfNotBlank(R.seller_v_city_name,L.property_v_city_name);
			SELF.seller_st := replaceIfNotBlank(R.seller_st,L.property_st);
			SELF.seller_zip := replaceIfNotBlank(R.seller_zip,L.property_zip);
			SELF.seller_zip4 := replaceIfNotBlank(R.seller_zip4,L.property_zip4);
			SELF.seller_county_name := replaceIfNotBlank(R.seller_county_name,L.property_county_name);
			SELF.seller_geo_lat := replaceIfNotBlank(R.seller_geo_lat,L.property_geo_lat);
			SELF.seller_geo_long := replaceIfNotBlank(R.seller_geo_long,L.property_geo_long);
			SELF.seller_msa := replaceIfNotBlank(R.seller_msa,L.property_msa);
			SELF.seller_orig_address := replaceIfNotBlank(R.seller_orig_address,L.property_orig_address);
			SELF.seller_orig_unit := replaceIfNotBlank(R.seller_orig_unit,L.property_orig_unit);
			SELF.seller_orig_csz := replaceIfNotBlank(R.seller_orig_csz,L.property_orig_csz);
			SELF.seller_phone_number := BLANK;
			SELF.seller_1_orig_name := replaceIfNotBlank(R.seller_1_orig_name,xrefPersonName);
			SELF.seller_1_first_name := replaceIfNotBlank(R.seller_1_first_name,xrefFName);
			SELF.seller_1_middle_name := replaceIfNotBlank(R.seller_1_middle_name,xrefMName);
			SELF.seller_1_last_name := replaceIfNotBlank(R.seller_1_last_name,xrefLName);
			SELF.seller_1_id_desc := BLANK;
			SELF.seller_1_title := BLANK;
			SELF.seller_1_name_suffix := BLANK;
			SELF.seller_1_company_name := BLANK;
			SELF.seller_1_did := BLANK;
			SELF.seller_1_bdid := BLANK;
			SELF.seller_1_ssn := BLANK;

			//---------- BLANK BUYER, SELLER, ETC, BEYOND THE FIRST ---------------
			SELF.seller_2_orig_name := BLANK;
			SELF.seller_2_id_desc := BLANK;
			SELF.seller_2_title := BLANK;
			SELF.seller_2_first_name := BLANK;
			SELF.seller_2_middle_name := BLANK;
			SELF.seller_2_last_name := BLANK;
			SELF.seller_2_name_suffix := BLANK;
			SELF.seller_2_company_name := BLANK;
			SELF.seller_2_did := BLANK;
			SELF.seller_2_bdid := BLANK;
			SELF.seller_2_ssn := BLANK;

			//***************************************************************************************************
			//---------- CONTROL OWNER INFO FROM PRODUCTION ---------------  USE PROPERTY INFO as OWNER
			SELF.owner_address1 := replaceIfNotBlank(R.owner_address1,SELF.property_address1);
			SELF.owner_address2 := replaceIfNotBlank(R.owner_address2,SELF.property_address2);
			SELF.owner_p_city_name := replaceIfNotBlank(R.owner_p_city_name,SELF.property_p_city_name);
			SELF.owner_v_city_name := replaceIfNotBlank(R.owner_v_city_name,SELF.property_v_city_name);
			SELF.owner_st := replaceIfNotBlank(R.owner_st,SELF.property_st);
			SELF.owner_zip := replaceIfNotBlank(R.owner_zip,SELF.property_zip);
			SELF.owner_zip4 := replaceIfNotBlank(R.owner_zip4,SELF.property_zip4);
			SELF.owner_county_name := replaceIfNotBlank(R.owner_county_name,SELF.property_county_name);
			SELF.owner_geo_lat := replaceIfNotBlank(R.owner_geo_lat,SELF.property_geo_lat);
			SELF.owner_geo_long := replaceIfNotBlank(R.owner_geo_long,SELF.property_geo_long);
			SELF.owner_msa := replaceIfNotBlank(R.owner_msa,SELF.property_msa);
			SELF.owner_orig_address := replaceIfNotBlank(R.owner_orig_address,SELF.property_orig_address);
			SELF.owner_orig_unit := replaceIfNotBlank(R.owner_orig_unit,SELF.property_orig_unit);
			SELF.owner_orig_csz := replaceIfNotBlank(R.owner_orig_csz,SELF.property_orig_csz);
			SELF.owner_phone_number := BLANK;
			SELF.owner_1_orig_name := replaceIfNotBlank(R.owner_1_orig_name,homePersonName);
			SELF.owner_1_title := BLANK;
			SELF.owner_1_first_name := replaceIfNotBlank(R.owner_1_first_name,SELF.fname);
			SELF.owner_1_middle_name := replaceIfNotBlank(R.owner_1_middle_name,SELF.mname);
			SELF.owner_1_last_name := replaceIfNotBlank(R.owner_1_last_name,SELF.lname);
			SELF.owner_1_name_suffix := BLANK;
			SELF.owner_1_company_name := BLANK;
			SELF.owner_1_did := BLANK;
			SELF.owner_1_bdid := BLANK;
			SELF.owner_1_ssn := BLANK;

			//---------- BLANK BUYER, SELLER, ETC, BEYOND THE FIRST ---------------
			SELF.owner_2_orig_name := BLANK;
			SELF.owner_2_title := BLANK;
			SELF.owner_2_first_name := BLANK;
			SELF.owner_2_middle_name := BLANK;
			SELF.owner_2_last_name := BLANK;
			SELF.owner_2_name_suffix := BLANK;
			SELF.owner_2_company_name := BLANK;
			SELF.owner_2_did := BLANK;
			SELF.owner_2_bdid := BLANK;
			SELF.owner_2_ssn := BLANK;

			//***************************************************************************************************
			//---------- CONTROL ASSESSEE INFO FROM PRODUCTION --------------- USE PROPERTY INFO as ASSESSEE
			SELF.assessee_address1 := replaceIfNotBlank(R.assessee_address1,SELF.property_address1);
			SELF.assessee_address2 := replaceIfNotBlank(R.assessee_address2,SELF.property_address2);
			SELF.assessee_p_city_name := replaceIfNotBlank(R.assessee_p_city_name,SELF.property_p_city_name);
			SELF.assessee_v_city_name := replaceIfNotBlank(R.assessee_v_city_name,SELF.property_v_city_name);
			SELF.assessee_st := replaceIfNotBlank(R.assessee_st,SELF.property_st);
			SELF.assessee_zip := replaceIfNotBlank(R.assessee_zip,SELF.property_zip);
			SELF.assessee_zip4 := replaceIfNotBlank(R.assessee_zip4,SELF.property_zip4);
			SELF.assessee_county_name := replaceIfNotBlank(R.assessee_county_name,SELF.property_county_name);
			SELF.assessee_geo_lat := replaceIfNotBlank(R.assessee_geo_lat,SELF.property_geo_lat);
			SELF.assessee_geo_long := replaceIfNotBlank(R.assessee_geo_long,SELF.property_geo_long);
			SELF.assessee_msa := replaceIfNotBlank(R.assessee_msa,SELF.property_msa);
			SELF.assessee_orig_address := replaceIfNotBlank(R.assessee_orig_address,SELF.property_orig_address);
			SELF.assessee_orig_unit := replaceIfNotBlank(R.assessee_orig_unit,SELF.property_orig_unit);
			SELF.assesee_orig_csz := replaceIfNotBlank(R.assesee_orig_csz,SELF.property_orig_csz);
			SELF.assessee_phone_number := BLANK;
			SELF.assessee_1_orig_name := replaceIfNotBlank(R.assessee_1_orig_name,homePersonName);
			SELF.assessee_1_title := R.assessee_1_title;
			SELF.assessee_1_first_name := replaceIfNotBlank(R.assessee_1_first_name,SELF.fname);
			SELF.assessee_1_middle_name := replaceIfNotBlank(R.assessee_1_middle_name,SELF.mname);
			SELF.assessee_1_last_name := replaceIfNotBlank(R.assessee_1_last_name,SELF.lname);
			SELF.assessee_1_name_suffix := R.assessee_1_name_suffix;
			SELF.assessee_1_company_name := BLANK;
			SELF.assessee_1_did := BLANK;
			SELF.assessee_1_bdid := BLANK;
			SELF.assessee_1_ssn := BLANK;
			//---------- BLANK BUYER, SELLER, ETC, BEYOND THE FIRST ---------------
			SELF.assessee_2_orig_name := BLANK;
			SELF.assessee_2_title := BLANK;
			SELF.assessee_2_first_name := BLANK;
			SELF.assessee_2_middle_name := BLANK;
			SELF.assessee_2_last_name := BLANK;
			SELF.assessee_2_name_suffix := BLANK;
			SELF.assessee_2_company_name := BLANK;
			SELF.assessee_2_did := BLANK;
			SELF.assessee_2_bdid := BLANK;
			SELF.assessee_2_ssn := BLANK;
			// Penny requested we keep with the original address
			SELF.assess_census_tract := R.assess_census_tract;
			SELF.assess_land_square_footage := R.assess_land_square_footage;
			SELF.assess_living_square_feet := R.assess_living_square_feet;
			SELF.assess_adjusted_gross_sq_ft := R.assess_adjusted_gross_sq_ft;

			//***************************************************************************************************
			//---------- CONTROL BORROWER INFO FROM PRODUCTION --------------- USE PROPERTY INFO as BORROWER
			SELF.borrower_address1 := replaceIfNotBlank(R.borrower_address1,SELF.property_address1);
			SELF.borrower_address2 := replaceIfNotBlank(R.borrower_address2,SELF.property_address2);
			SELF.borrower_p_city_name := replaceIfNotBlank(R.borrower_p_city_name,SELF.property_p_city_name);
			SELF.borrower_v_city_name := replaceIfNotBlank(R.borrower_v_city_name,SELF.property_v_city_name);
			SELF.borrower_st := replaceIfNotBlank(R.borrower_st,SELF.property_st);
			SELF.borrower_zip := replaceIfNotBlank(R.borrower_zip,SELF.property_zip);
			SELF.borrower_zip4 := replaceIfNotBlank(R.borrower_zip4,SELF.property_zip4);
			SELF.borrower_county_name := replaceIfNotBlank(R.borrower_county_name,SELF.property_county_name);
			SELF.borrower_geo_lat := replaceIfNotBlank(R.borrower_geo_lat,SELF.property_geo_lat);
			SELF.borrower_geo_long := replaceIfNotBlank(R.borrower_geo_long,SELF.property_geo_long);
			SELF.borrower_msa := replaceIfNotBlank(R.borrower_msa,SELF.property_msa);
			SELF.borrower_orig_address := replaceIfNotBlank(R.borrower_orig_address,SELF.property_orig_address);
			SELF.borrower_orig_unit := replaceIfNotBlank(R.borrower_orig_unit,SELF.property_orig_unit);
			SELF.borrower_orig_csz := replaceIfNotBlank(R.borrower_orig_csz,SELF.property_orig_csz);
			SELF.borrower_phone_number := BLANK;
			SELF.borrower_vesting_desc := BLANK;
			SELF.borrower_1_orig_name := replaceIfNotBlank(R.borrower_1_orig_name,homePersonName);
			SELF.borrower_1_id_desc := BLANK;
			SELF.borrower_1_title := R.borrower_1_title;
			SELF.borrower_1_first_name := replaceIfNotBlank(R.borrower_1_first_name,SELF.fname);
			SELF.borrower_1_middle_name := replaceIfNotBlank(R.borrower_1_middle_name,SELF.mname);
			SELF.borrower_1_last_name := replaceIfNotBlank(R.borrower_1_last_name,SELF.lname);
			SELF.borrower_1_name_suffix := R.borrower_1_name_suffix;
			SELF.borrower_1_company_name := BLANK;
			SELF.borrower_1_did := BLANK;
			SELF.borrower_1_bdid := BLANK;
			SELF.borrower_1_ssn := BLANK;
			//---------- BLANK BUYER, SELLER, ETC, BEYOND THE FIRST ---------------
			SELF.borrower_2_orig_name := BLANK;
			SELF.borrower_2_id_desc := BLANK;
			SELF.borrower_2_title := BLANK;
			SELF.borrower_2_first_name := BLANK;
			SELF.borrower_2_middle_name := BLANK;
			SELF.borrower_2_last_name := BLANK;
			SELF.borrower_2_name_suffix := BLANK;
			SELF.borrower_2_company_name := BLANK;
			SELF.borrower_2_did := BLANK;
			SELF.borrower_2_bdid := BLANK;
			SELF.borrower_2_ssn := BLANK;

			//***************************************************************************************************
			//---------- CONTROL DEED INFO FROM PRODUCTION --------------- USE PROPERTY INFO for county/st
			SELF.deed_state := replaceIfNotBlank(R.deed_state,SELF.property_st);
			SELF.deed_county_name := replaceIfNotBlank(R.deed_county_name,SELF.property_county_name);
			//----- CONTROL DEED INFO FROM PRODUCTION ------- ELSE let's try to keep original for some of these
			// keeping size, sqft, legal fields
			SELF.deed_land_lot_size := R.deed_land_lot_size;
			SELF.deed_legal_lot_desc := R.deed_legal_lot_desc;
			SELF.deed_legal_lot_no := R.deed_legal_lot_no;
			SELF.deed_legal_block := R.deed_legal_block;
			SELF.deed_legal_section := R.deed_legal_section;
			SELF.deed_legal_district := R.deed_legal_district;
			SELF.deed_legal_land_lot := R.deed_legal_land_lot;
			SELF.deed_legal_unit := R.deed_legal_unit;
			SELF.deed_legal_city_municipal_town := R.deed_legal_city_municipal_town;
			SELF.deed_legal_subdivision_name := R.deed_legal_subdivision_name;
			SELF.deed_legal_phase_number := R.deed_legal_phase_number;
			SELF.deed_legal_tract_number := R.deed_legal_tract_number;
			SELF.deed_legal_sec_twn_rng_mer := R.deed_legal_sec_twn_rng_mer;
			SELF.deed_recorder_map_reference := R.deed_recorder_map_reference;
			SELF.deed_complete_legal_desc_code := R.deed_complete_legal_desc_code;
			SELF.deed_building_square_feet := R.deed_building_square_feet;
			SELF.deed_phone_number := BLANK;
			SELF.deed_loan_number := BLANK;

			SELF.other := R.other;
			SELF  := L;
			SELF  := [];
END;