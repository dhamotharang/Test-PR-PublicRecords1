import prte2_business_credit, BIPV2, Address;

//Create AB record
layouts.BusinessInformation		xformBusInfo_AB(files.basefile L) := transform
	self.Version															:= L.process_date;
	self.Original_Version											:= L.process_date;;
	//Should be AB/IS	
	self.record_type													:= L.Segment_Identifier; //AB
		// BIPV2.IDlayouts.l_xlink_ids;	//	Added for BIP project
	//Populated via separate IS record	
	self.did																	:= 0;
	self.did_score														:= 0;
	self.Sbfe_Contributor_Number							:= L.Header_Sbfe_Contributor_Number;
	self.Contract_Account_Number							:= L.contract_account_number;
	self.Original_Contract_Account_Number			:= L.Original_Contract_Account_Number;
	self.Account_Type_Reported								:= L.account_type_reported; //003
	self.dt_first_seen												:= L.dt_first_seen;
	self.dt_last_seen													:= L.dt_last_seen;
	self.dt_vendor_first_reported							:= L.dt_vendor_first_reported;	
	self.dt_vendor_last_reported							:= L.dt_vendor_last_reported;
	self.dt_datawarehouse_first_reported			:= L.dt_datawarehouse_first_reported;
	self.dt_datawarehouse_last_reported				:= L.dt_datawarehouse_last_reported;
	self.Account_Holder_Business_Name					:= L.Account_Holder_Business_Name;
	self.Clean_Account_Holder_Business_Name		:= L.Account_Holder_Business_Name;
	self.DBA																	:= L.DBA;
	self.Clean_DBA														:= L.DBA;
	self.Business_Name												:= L.Account_Holder_Business_Name;
	self.Clean_Business_Name									:= L.Account_Holder_Business_Name;
	self.Company_Website											:= L.company_website;
//Populated via seaparate IS records	
	self.Original_fname												:= '';
	self.Original_mname												:= '';	
	self.Original_lname												:= '';
	self.Original_suffix											:= '';
	self.E_Mail_Address												:= '';
	self.Clean_title													:= '';
	self.Clean_fname													:= '';
	self.Clean_mname													:= '';
	self.Clean_lname													:= '';
	self.Clean_suffix													:= '';
	self.Original_Address_Line_1							:= L.Address_Line_1;
	self.Original_Address_Line_2							:= L.Address_Line_2;
	self.Original_City												:= L.City;
	self.Original_State												:= L.State;
	self.Original_Zip_Code_or_CA_Postal_Code	:= L.Zip_Code_or_CA_Postal_Code;
	self.Original_Postal_Code									:= L.Postal_Code;
	self.Original_Country_Code								:= L.Country_Code;
	self.Primary_Address_Indicator						:= L.Primary_Address_Indicator;
	self.Address_Classification								:= L.Address_Classification;
		// Address.Layout_Clean182_fips;
	self.rawaid																:= L.rawaid;
	self.Original_Area_Code										:= L.Area_Code;
	self.Original_Phone_Number								:= L.Phone_Number;
	self.Phone_Extension											:= L.Phone_Extension;
	self.Primary_Phone_Indicator							:= L.Primary_Phone_Indicator;
	self.Published_Unlisted_Indicator					:= L.Published_Unlisted_Indicator;
	self.Phone_Type														:= L.Phone_Type;
	self.Phone_Number													:= L.Phone_Number;
	self.Federal_TaxID_SSN										:= L.Federal_TaxID_SSN;
	self.Federal_TaxID_SSN_Identifier					:= L.Federal_TaxID_SSN_Identifier;
	self.source																:= L.source;
	self 	:= L;
	self	:= [];
	END;

	dsBusinessInfo_AB := project(prte2_business_credit.files.basefile, xformBusInfo_AB(left)); 


layouts.BusinessInformation		xformBusInfo_IS(files.basefile L) := transform
	self.Version															:= L.process_date;
	self.Original_Version											:= L.process_date;;
	//Should be AB/IS	
	self.record_type													:= L.IndividualOwner_Segment_Identifier; //IS
		// BIPV2.IDlayouts.l_xlink_ids;	//	Added for BIP project
	//Populated via separate IS record	
	self.did																	:= L.DID;
	self.did_score														:= 0;
	self.Sbfe_Contributor_Number							:= L.Header_Sbfe_Contributor_Number;
	self.Contract_Account_Number							:= L.contract_account_number;
	self.Original_Contract_Account_Number			:= L.Original_Contract_Account_Number;
	self.Account_Type_Reported								:= L.account_type_reported; //003
	self.dt_first_seen												:= L.dt_first_seen;
	self.dt_last_seen													:= L.dt_last_seen;
	self.dt_vendor_first_reported							:= L.dt_vendor_first_reported;	
	self.dt_vendor_last_reported							:= L.dt_vendor_last_reported;
	self.dt_datawarehouse_first_reported			:= L.dt_datawarehouse_first_reported;
	self.dt_datawarehouse_last_reported				:= L.dt_datawarehouse_last_reported;
	self.Account_Holder_Business_Name					:= L.Account_Holder_Business_Name;
	self.Clean_Account_Holder_Business_Name		:= L.Account_Holder_Business_Name;
	self.DBA																	:= L.DBA;
	self.Clean_DBA														:= L.DBA;
	self.Business_Name												:= L.Account_Holder_Business_Name;
	self.Clean_Business_Name									:= L.Account_Holder_Business_Name;
	self.Company_Website											:= L.company_website;
//Populated via seaparate IS records	
	self.Original_fname												:= L.Original_fname;
	self.Original_mname												:= L.Original_mname;	
	self.Original_lname												:= L.Original_lname;
	self.Original_suffix											:= L.Original_suffix;
	self.E_Mail_Address												:= L.E_Mail_Address;
	self.Clean_title													:= L.Clean_title;
	self.Clean_fname													:= L.Clean_fname;
	self.Clean_mname													:= L.Clean_mname;
	self.Clean_lname													:= L.Clean_lname;
	self.Clean_suffix													:= L.Clean_suffix;
	self.Original_Address_Line_1							:= L.IndividualOwner_Address_Line_1;
	self.Original_Address_Line_2							:= L.IndividualOwner_Address_Line_2;
	self.Original_City												:= L.IndividualOwner_Address_City;
	self.Original_State												:= L.IndividualOwner_Address_State;
	self.Original_Zip_Code_or_CA_Postal_Code	:= L.IndividualOwner_Address_Zip_Code_or_CA_Postal_Code;
	self.Original_Postal_Code									:= L.IndividualOwner_Address_Postal_Code;
	self.Original_Country_Code								:= L.IndividualOwner_Address_Country_Code;
	self.Primary_Address_Indicator						:= L.IndividualOwner_Address_Primary_Address_Indicator;
	self.Address_Classification								:= L.IndividualOwner_Address_Address_Classification;
	
	self.rawaid																:= L.indvowner_rawaid;
	self.Original_Area_Code										:= L.IndividualOwner_PhoneNumber_Area_Code;
	self.Original_Phone_Number								:= L.IndividualOwner_PhoneNumber_Phone_Number;
	self.Phone_Extension											:= L.IndividualOwner_PhoneNumber_Phone_Extension;
	self.Primary_Phone_Indicator							:= L.IndividualOwner_PhoneNumber_Primary_Phone_Indicator;
	self.Published_Unlisted_Indicator					:= L.IndividualOwner_PhoneNumber_Published_Unlisted_Indicator;
	self.Phone_Type														:= L.IndividualOwner_PhoneNumber_Phone_Type;
	self.Phone_Number													:= L.IndividualOwner_PhoneNumber_Phone_Number;
	self.Federal_TaxID_SSN										:= L.IndividualOwner_Federal_TaxID_SSN;
	self.Federal_TaxID_SSN_Identifier					:= L.IndividualOwner_Federal_TaxID_SSN_Identifier;
	self.source																:= L.source;
	
	self.prim_range		:= L.clean_indvowner.prim_range; 
	self.predir				:= L.clean_indvowner.predir;
	self.prim_name		:= L.clean_indvowner.prim_name;	
	self.addr_suffix	:= L.clean_indvowner.addr_suffix; 
	self.postdir			:= L.clean_indvowner.postdir;
	self.unit_desig		:= L.clean_indvowner.unit_desig;	
	self.sec_range		:= L.clean_indvowner.sec_range;	
	self.p_city_name	:= L.clean_indvowner.p_city_name;	
	self.v_city_name	:= L.clean_indvowner.v_city_name; 
	self.st						:= L.clean_indvowner.st;	
	self.zip					:= L.clean_indvowner.zip;	
	self.zip4					:= L.clean_indvowner.zip4;		
	self.cart					:= L.clean_indvowner.cart;
	self.cr_sort_sz		:= L.clean_indvowner.cr_sort_sz;	
	self.lot					:= L.clean_indvowner.lot;	
	self.lot_order		:= L.clean_indvowner.lot_order;	
	self.dbpc					:= L.clean_indvowner.dbpc;	
	self.chk_digit		:= L.clean_indvowner.chk_digit;		
	self.rec_type			:= L.clean_indvowner.rec_type;
	self.fips_state		:= L.clean_indvowner.fips_state;
	self.fips_county	:= L.clean_indvowner.fips_county;	
	self.geo_lat			:= L.clean_indvowner.geo_lat;
	self.geo_long			:= L.clean_indvowner.geo_long;	
	self.msa					:= L.clean_indvowner.msa;	
	self.geo_blk			:= L.clean_indvowner.geo_blk;	
	self.geo_match		:= L.clean_indvowner.geo_match;	
	self.err_stat			:= L.clean_indvowner.err_stat;	
	self 	:= L;
	self	:= [];
	END;

	dsBusinessInfo_IS := project(prte2_business_credit.files.basefile(IndividualOwner_Address_Segment_Identifier <> ''), xformBusInfo_IS(left)); 
	
	
EXPORT File_BusinessInformation := dsBusinessInfo_AB + dsBusinessInfo_IS;