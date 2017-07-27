import ut, Ingenix_NatlProf;

// project Ingenix_NatlProf.Basefile_Provider_Did to layout w/phonetype field re-named to avoid  
// collision in the ut.mac_suppress_by_phonetype macro which also has a phonetype field.

tempLayout := RECORD
	unsigned6	DID;
	string3   DID_SCORE;
	string  	FILETYP;
	string  	PROCESSDATE;
	string		ProviderID;
	string		AddressID;
	string		LastName;
	string		FirstName;
	string		MiddleName;
	string		Suffix;
	string		Gender;
	string		ProviderNameCompanyCount;
	string		ProviderNameTierID;
	string		Address;
	string		Address2;
	string		City;
	string		State;
	string		County;
	string		ZIP;
	string 		ExtZip;
	string		Latitude;
	string		Longitute;
	string		GeoReturn;
	string		HighRisk;
	string		ProviderAddressCompanyCount;
	string		ProviderAddressTierTypeID;
	string		ProviderAddressTypeCode;
  string    ProviderAddressVerificationStatusCode;
  string    ProviderAddressVerificationDate;
	string		BirthDate;
	string		BirthDateCompanyCount;
	string		BirthDateTierTypeID;
	string		TaxID;
	string		TaxIDCompanyCount;
	string		TaxIDTierTypeID;
	string		PhoneNumber;
	string		PhoneTypeOrig;
	string		PhoneNumberCompanyCount;
	string		PhoneNumberTierTypeID;
	string5		Prov_Clean_title;
	string20	Prov_Clean_fname;
	string20	Prov_Clean_mname;
	string20	Prov_Clean_lname;
	string5  	Prov_Clean_name_suffix;
	string3   Prov_Clean_cleaning_score;
	string10 	Prov_Clean_prim_range;
	string2 	Prov_Clean_predir;
	string28	Prov_Clean_prim_name;
	string4  	Prov_Clean_addr_suffix;
	string2 	Prov_Clean_postdir;
	string10 	Prov_Clean_unit_desig;
	string8  	Prov_Clean_sec_range;
	string25	Prov_Clean_p_city_name;
	string25	Prov_Clean_v_city_name;
	string2 	Prov_Clean_st;
	string5 	Prov_Clean_zip;
	string4 	Prov_Clean_zip4;
	string4 	Prov_Clean_cart;
	string1 	Prov_Clean_cr_sort_sz;
	string4  	Prov_Clean_lot;
	string1 	Prov_Clean_lot_order;
	string2 	Prov_Clean_dpbc;
	string1 	Prov_Clean_chk_digit;
	string2 	Prov_Clean_record_type;
	string2 	Prov_Clean_ace_fips_st;
	string3 	Prov_Clean_fipscounty;
	string10	Prov_Clean_geo_lat;
	string11	Prov_Clean_geo_long;
	string4		Prov_Clean_msa;
	string7 	Prov_Clean_geo_match;
	string4 	Prov_Clean_err_stat;
	string8  	dt_first_seen;
	string8  	dt_last_seen;
	string8  	dt_vendor_first_reported;
	string8  	dt_vendor_last_reported;
	string 		OptOutSiteDescription ;
	string 		AffidavitReceivedDate ;
	string 		OptOutEffectiveDate ;
	string 		DateOptOutTerminationDate;
	string 		OptOutStatus;
	string 		LastUpdate;
	string		DeceasedIndicator ; 
	string		DeceasedDate ;
end;

tempLayout trfTempLayout(Ingenix_NatlProf.Layout_Provider_Base input)	:= transform
	self.PhoneTypeOrig	:= input.phoneType;
	self.did						:= (integer)input.did;
	self								:= input;
end;
 
tempBase	:= project(Ingenix_NatlProf.Basefile_Provider_Did, trfTempLayout(left));
																
ut.mac_suppress_by_phonetype(tempBase,PhoneNumber,State,phone_suppression,true,did);	

// project phone suppressed file back to original Ingenix Base file layout to avoid  
// any issues downstream in the keys. 

Ingenix_NatlProf.Layout_Provider_Base trfBaseLayout(tempLayout input)	:= transform
	self.PhoneType			:= input.phoneTypeOrig;
	self.did						:= intformat(input.did,12,1);
	self								:= input;
	self                := [];
end;
 
Base	:= project(phone_suppression, trfBaseLayout(left));																			
																				
export Basefile_Provider_Did_Keybuild := Base : persist('~thor_dell400::persist::provider_did_keybuild');