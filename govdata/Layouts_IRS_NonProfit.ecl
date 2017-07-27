import aid, bipv2;

export Layouts_IRS_NonProfit := module

	export Sprayed := record					 //##Went from a flat file to a CSV file 3/2014
		string Employer_ID_Number;
		string Primary_Name_Of_Organization;
		string In_Care_Of_Name;
		string Street_Address;
		string City;
		string State;
		string Zip_Code;
		string Group_Exemption_Number;
		string Subsection_Code;
		string Affiliation_Code;
		string Classification_Code;
		string Ruling_Date;
		string Deductibility_Code;
		string Foundation_Code;
		string Activity_Codes;
		string Organization_Code;
		string Exempt_Org_Status_Code;	//##Vendor layout change 3/2014 - new		
		string Tax_Period;
		string Asset_Code;
		string Income_Code;
		string filing_requirement_code_part1;
		string filing_requirement_code_part2;
		string Accounting_Period;
		string Asset_Amount;
		string Income_Amount;
		string Form_990_Revenue_Amount;
		string National_Taxonomy_Exempt;
		string Sort_Name;
	end;

	export Sprayed_Fixed := record
		string9  Employer_ID_Number;
		string70 Primary_Name_Of_Organization;
		string35 In_Care_Of_Name;
		string35 Street_Address;
		string22 City;
		string2  State;
		string10 Zip_Code;
		string4  Group_Exemption_Number;
		string2  Subsection_Code;
		string1  Affiliation_Code;
		string4  Classification_Code;
		string6  Ruling_Date;
		string1  Deductibility_Code;
		string2  Foundation_Code;
		string9  Activity_Codes;
		string1  Organization_Code;
		string2  Univ_Loc_Code;
		string6  Advance_Ruling_Exp_Date;
		string2	 Exempt_Org_Status_Code;	//##Vendor layout change 3/2014 - new				
		string6  Tax_Period;
		string1  Asset_Code;
		string1  Income_Code;
		//string3  Filing_Requirement_Code; ##Vendor split field into 2 4/2012
		string2  filing_requirement_code_part1;
		string1  filing_requirement_code_part2;
		string2  Accounting_Period;
		string13 Asset_Amount;
		string13 Income_Amount;
		string1  Negative_Sign;
		string13 Form_990_Revenue_Amount;
		string1  Negative_Rev_Amount;
		string4  National_Taxonomy_Exempt;
		string35 Sort_Name;
	end;
	
	export Clean_Name := record
		string8 	Process_Date;
		Sprayed_Fixed;
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5 	name_suffix;
		string3		name_score;
	end;

	export Addr_Prep_For_AID := record
		AID.Common.xAID	Append_RawAID;		
		string100	prep_addr_line1;
		string50	prep_addr_last_line;		
	end;
	
	export Common := record
		Clean_Name;
		Addr_Prep_For_AID;
	end;
	
	export Base_AID := record
		govdata.Layout_IRS_NonProfit_Base.BDID;
		Clean_Name;
		string10  prim_range;
		string2   predir;
		string28  prim_name;
		string4   addr_suffix;
		string2   postdir;
		string10  unit_desig;
		string8   sec_range;
		string25  p_city_name;
		string25  v_city_name;
		string2   st;
		string5   zip;
		string4   zip4;
		string4   cart;
		string1   cr_sort_sz;
		string4   lot;
		string1   lot_order;
		string2   dbpc;
		string1   chk_digit;
		string2   rec_type;
		string5   county;
		string10  geo_lat;
		string11  geo_long;
		string4   msa;
		string7   geo_blk;
		string1   geo_match;
		string4   err_stat;
		string35  cname;
		AID.Common.xAID	Append_RawAID;
		AID.Common.xAID	Append_ACEAID;
		string100	prep_addr_line1;
		string50	prep_addr_last_line;	
		bipv2.IDlayouts.l_xlink_ids;
		unsigned8 source_rec_id := 0;
	end;
	
end;