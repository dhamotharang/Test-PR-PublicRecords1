export Layout_In_Clean_Provider := record

string  FILETYP;
string  PROCESSDATE;
string	ProviderID;
string	AddressID;
string	LastName;
string	FirstName;
string	MiddleName;
string	Suffix;
string	Gender;
string	ProviderNameCompanyCount;
string	ProviderNameTierID;
string	Address;
string	Address2;
string	City;
string	State;
string	County;
string	ZIP;
string 	ExtZip;
string	Latitude;
string	Longitute;
string	GeoReturn;
string	HighRisk;
string	ProviderAddressCompanyCount;
string	ProviderAddressTierTypeID;
string	ProviderAddressTypeCode;
string  ProviderAddressVerificationStatusCode;
string  ProviderAddressVerificationDate;
string	BirthDate;
string	BirthDateCompanyCount;
string	BirthDateTierTypeID;
string	TaxID;
string	TaxIDCompanyCount;
string	TaxIDTierTypeID;
string	PhoneNumber;
string	PhoneType;
string	PhoneNumberCompanyCount;
string	PhoneNumberTierTypeID;


string5   			Prov_Clean_title						;
string20 	 		Prov_Clean_fname						;
string20  			Prov_Clean_mname						;
string20 			Prov_Clean_lname						;
string5  		 	Prov_Clean_name_suffix 					;
string3     		Prov_Clean_cleaning_score 	    		;
string10  			prov_Clean_prim_range		;
string2  			prov_Clean_predir			;
string28 			prov_Clean_prim_name		;
string4   			prov_Clean_addr_suffix	    ;
string2  			prov_Clean_postdir			;
string10  			prov_Clean_unit_desig		;
string8   			prov_Clean_sec_range		;
string25 			prov_Clean_p_city_name	    ;
string25 			prov_Clean_v_city_name	    ;
string2  			prov_Clean_st				;
string5  			prov_Clean_zip			    ;
string4  			prov_Clean_zip4			    ;
string4  			prov_Clean_cart				;
string1  			prov_Clean_cr_sort_sz		;
string4   			prov_Clean_lot				;
string1  			prov_Clean_lot_order	    ;
string2  			prov_Clean_dpbc			  	;
string1  			prov_Clean_chk_digit	    ;
string2  			prov_Clean_record_type		;
string2  			prov_Clean_ace_fips_st		;
string3  			prov_Clean_fipscounty	    ;
string10 			prov_Clean_geo_lat			;
string11 			prov_Clean_geo_long			;
string4 			prov_Clean_msa				;
string7  			prov_Clean_geo_match	    ;
string4  			prov_Clean_err_stat			;
string8  			dt_first_seen;
string8  			dt_last_seen;
string8 			dt_vendor_first_reported;
string8  			dt_vendor_last_reported;
					
string 				OptOutSiteDescription ;
string 				AffidavitReceivedDate ;
string 				OptOutEffectiveDate ;
string 				DateOptOutTerminationDate;
string 			    OptOutStatus;
string 				LastUpdate;
string				DeceasedIndicator ; 
string				DeceasedDate ;

end;



