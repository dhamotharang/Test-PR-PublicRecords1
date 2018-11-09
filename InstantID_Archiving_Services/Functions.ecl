IMPORT iesp, Doxie, risk_indicators, std;

EXPORT Functions :=  MODULE;
/*search_type mapping:
	1 = flexid
	2 = instantidinternational
	3 = instantid
*/

	EXPORT DefineSQLParamsValues(IParam.search_params in_mod, STRING search_type = Constants.InstantId) := MODULE
		//******original DefineSQLParamsValues module/function
			SHARED boolean	hasUniqueId 				:= in_mod.UniqueId <> '';
			SHARED boolean  hasFirstName				:= in_mod.firstname <> '';
			SHARED boolean  hasLastName					:= in_mod.lastname <> '';
			//no iidi search BUT has address info split up...need to put together for SQL query
			SHARED string   tmpStreet := IF(in_mod.addr = '' AND (in_mod.Prim_range <> '' OR in_mod.Prim_name <> '' OR in_mod.Suffix <> ''), 
														TRIM(in_mod.Prim_range, LEFT, RIGHT)  + ' ' + TRIM(in_mod.Prim_name, LEFT, RIGHT) + ' ' + TRIM(in_mod.Suffix, LEFT, RIGHT), '');	
									
			SHARED boolean	hasStreet  					:= if(search_type != Constants.InputInstantIdIntrnatl and (in_mod.addr <> '' OR tmpStreet <> ''), true, false);//flexid and instantid only 

			SHARED boolean	hasStreetNumber			:= if(search_type = Constants.InputInstantIdIntrnatl and in_mod.Prim_range <> '', true, false); //instantidinternational only
			SHARED boolean	hasStreetName  			:= if(search_type = Constants.InputInstantIdIntrnatl and in_mod.Prim_name <> '', true, false); //instantidinternational only
			SHARED boolean	hasStreetType  			:= if(search_type = Constants.InputInstantIdIntrnatl and in_mod.Suffix <> '', true, false); //instantidinternational only
			SHARED boolean  hasCity							:= in_mod.city <> '';
			SHARED boolean  hasState						:= in_mod.state <> '';
			SHARED boolean  hasZip							:= in_mod.z5 <> '';
			SHARED boolean  hasPostalCode				:= if(search_type = Constants.InputInstantIdIntrnatl and in_mod.PostalCode <> '', true, false);	
			SHARED boolean  hasDOB							:= in_mod.DOB <> 0;
			SHARED boolean  hasSSN							:= if(search_type != Constants.InputInstantIdIntrnatl and in_mod.SSN <> '', true, false); //flexid and instantid only
			SHARED boolean  hasNationalId     	:= if(search_type = Constants.InputInstantIdIntrnatl and in_mod.NationalId <> '', true, false); //instantidinternational only
			SHARED boolean  hasQueryId					:= in_mod.QueryId <> '';	
			SHARED boolean  hasTransactionId		:= in_mod.TransactionId <> '';	
			SHARED boolean  hasCompanyId				:= in_mod.CompanyId <> '';		
	
			SHARED string		UniqueIdSQL 				:= IF(hasUniqueId, ' unique_id = ? and ','');	
			SHARED DATASET	UniqueIdValueSQL 		:= if(hasUniqueId, dataset([{trim(in_mod.UniqueId, left, right)}], Layouts.delta_value));	
			SHARED string		FirstNameSQL		 		:= IF(hasFirstName, ' first_name = ? and ','');
			SHARED DATASET	FirstNameValueSQL		:= if(hasFirstName, dataset([{trim(in_mod.firstname, left, right)}], Layouts.delta_value));				
			SHARED string		LastNameSQL		 			:= IF(hasLastName, ' last_name = ? and ','');
			SHARED DATASET	LastNameValueSQL		:= if(hasLastName, dataset([{trim(in_mod.lastname, left, right)}], Layouts.delta_value))	;		
			SHARED string		StreetSQL 					:= IF(hasStreet, ' street = ? and ','');	
			SHARED DATASET	StreetValueSQL 			:= if(hasStreet, dataset([{if(in_mod.Addr <> '', trim(in_mod.Addr, left, right), tmpStreet)}], Layouts.delta_value));		
			SHARED string		StreetNumSQL 				:= IF(hasStreetNumber, ' street_number = ? and ','');	
			SHARED DATASET	StreetNumValueSQL 	:= if(hasStreetNumber, dataset([{trim(in_mod.Prim_range, left, right)}], Layouts.delta_value));			
			SHARED string		StreetNameSQL 			:= IF(hasStreetName, ' street_name = ? and ','');	
			SHARED DATASET	StreetNameValueSQL 	:= if(hasStreetName, dataset([{trim(in_mod.Prim_name, left, right)}], Layouts.delta_value));	
			//address input on iesp is only 4 but our DB holds more. So just look up the first four characters
			SHARED string		StreetTypeSQL 			:= IF(hasStreetType, ' substring(street_type, 1, 4) = ? and ','');			
			SHARED DATASET	StreetTypeValueSQL 	:= if(hasStreetType, dataset([{trim(in_mod.Suffix, left, right)[1..4]}], Layouts.delta_value));			
			SHARED string		CitySQL		 					:= IF(hasCity, ' city = ? and ','');
			SHARED DATASET	CityValueSQL		 		:= if(hasCity, dataset([{trim(in_mod.city, left, right)}], Layouts.delta_value));				
			SHARED string		StateSQL		 				:= IF(hasState, ' state = ? and ','');
			SHARED DATASET	StateValueSQL		 		:= if(hasState, dataset([{trim(in_mod.state, left, right)}], Layouts.delta_value))	;	
			SHARED string		ZipSQL 							:= IF(hasZip, ' zip = ? and ','');	
			SHARED DATASET	ZipValueSQL 				:= if(hasZip, dataset([{trim(in_mod.z5, left, right)}], Layouts.delta_value));		
			SHARED string		PostalCodeSQL				:= IF(hasPostalCode, ' postal_code = ? and ','');	
			SHARED DATASET	PostalCodeValueSQL 	:= if(hasPostalCode, dataset([{trim(in_mod.postalcode, left, right)}], Layouts.delta_value));		
			SHARED string		DOBSQL		 					:= IF(hasDOB, ' dob = ? and ','');
			SHARED string		stringDOB						:= (string) in_mod.dob;
			SHARED STRING		tmpDOB              := IF(stringDOB = '0', '', stringDOB[1..4]+'-'+stringDOB[5..6]+'-'+stringDOB[7..8]);
			SHARED DATASET	DOBValueSQL		 			:= if(hasDOB, dataset([{tmpDOB}], Layouts.delta_value));	
			SHARED string		SSNSQL		 					:= IF(hasSSN, ' ssn = ? and ','');
			SHARED DATASET	SSNValueSQL		 			:= if(hasSSN, dataset([{trim(in_mod.SSN, left, right)}], Layouts.delta_value))	;	
			SHARED string		NationalIdQL				:= IF(hasNationalId, ' national_id = ? and ','');
			SHARED DATASET	NationalIdValueSQL	:= IF(hasNationalId, dataset([{trim(in_mod.NationalId, left, right)}], Layouts.delta_value))	;	
			SHARED string		QueryIdSQL		 			:= IF(hasQueryId, ' query_id = ? and ','');
			SHARED DATASET	QueryIdValueSQL			:= if(hasQueryId, dataset([{trim(in_mod.QueryId, left, right)}], Layouts.delta_value));		
			SHARED string		TransactionIdSQL		:= IF(hasTransactionId, ' i.transaction_id = ? and ','');
			SHARED DATASET	TransactionIdValueSQL	:= if(hasTransactionId, dataset([{trim(in_mod.TransactionId, left, right)}], Layouts.delta_value))	;		
			SHARED string		CompanyIdSQL				:= IF(hasCompanyId, ' company_id = ? and ','');
			SHARED DATASET	CompanyIdValueSQL		:= if(hasCompanyId, dataset([{trim(in_mod.CompanyId, left, right)}], Layouts.delta_value))	;	

			SHARED tmpFieldsSQL := trim(CompanyIdSQL + FirstNameSQL + LastNameSQL + TransactionIdSQL + UniqueIdSQL + StreetSQL + StreetNumSQL +
							StreetNameSQL + StreetTypeSQL + CitySQL + StateSQL + ZipSQL + PostalCodeSQL + 
							DOBSQL +	SSNSQL + NationalIdQL + QueryIdSQL, LEFT, RIGHT);
			SHARED ValuesSQL := CompanyIdValueSQL + FirstNameValueSQL + LastNameValueSQL + TransactionIdValueSQL +  UniqueIdValueSQL + StreetValueSQL + 
					StreetNumValueSQL + StreetNameValueSQL +StreetTypeValueSQL + CityValueSQL + StateValueSQL + 
					ZipValueSQL + PostalCodeValueSQL + DOBValueSQL + SSNValueSQL + NationalIdValueSQL + 
					QueryIdValueSQL ;

			SHARED SQL_Values_List:= dataset([{ValuesSQL}], Layouts.delta_parameter);	
		
			//taking off the last AND below
			SHARED FieldsSQL := trim(tmpFieldsSQL[1..length(tmpFieldsSQL) -3], left, right);	
	
		//exportables
			EXPORT SQLWhereCriteria := FieldsSQL;
			EXPORT SQLValues := SQL_Values_List;
		//******end original module/function
	END;

	Layouts.IIDI2SQLlayout DefineIIDI2SQLParamsValues(IParam.IIDI2_search_params in_mod) := Function
			hasFirstName						:= in_mod.newfirstname <> '';
			hasMiddleName						:= in_mod.newmiddlename <> '';
			hasLastName							:= in_mod.newlastname <> '';
			hasFullName							:= in_mod.fullname <> '';
			hasMaidenName						:= in_mod.maidenname <> '';
			hasGender								:= in_mod.igender <> '';
			hasAddr1  			    		:= in_mod.StreetAddress1 <> '';
			hasAddr2  			    		:= in_mod.StreetAddress2 <> '';
			hasUnitNumber						:= in_mod.unitnumber <> '';
			hasBuildingNumber				:= in_mod.buildingnumber <> '';
			hasBuildingName					:= in_mod.buildingname <> '';
			hasFloorNumber					:= in_mod.FloorNumber <> '';
			hasStreetNumber					:= in_mod.StreetNumber <> '';
			hasStreetName  					:= in_mod.StreetName <> '';
			hasStreetType						:= in_mod.StreetType <> '';
			hasSuburb								:= in_mod.suburb <> '';
			hasCity									:= in_mod.icity <> '';
			hasDistrict							:= in_mod.district <> '';
			hasCounty								:= in_mod.icounty <> '';
			hasState								:= in_mod.istate <> '';
			hasCountry							:= in_mod.CountryId <> '';
			hasPostalCode						:= in_mod.Postal_Code <> '';
			hasPhone								:= in_mod.iPhone <> '';
			hasMobilePhone					:= in_mod.MobilePhone <> '';
			hasWorkPhone						:= in_mod.WorkPhone <> '';
			hasDOB									:= if(trim(in_mod.DateOfBirth) = '--', false, true);
			hasNationalId     			:= in_mod.NationalId <> '';
			hasCityOfIssue     			:= in_mod.NationalId_City_Issued <> '';
			hasCountyOfIssue    		:= in_mod.NationalId_County_Issued <> '';
			hasDistrictOfIssue  		:= in_mod.NationalId_District_Issued <> '';
			hasProvinceOfIssue  		:= in_mod.NationalId_Province_Issued <> '';
			hasDLNumber							:= in_mod.IDL_Number <> '';
			hasDLVersionNumber			:= in_mod.DL_Version_Number <> '';
			hasDLState							:= in_mod.IDL_State <> '';
			hasDLExpireDate					:= trim(in_mod.DL_Expire_Date) <> '--';
			hasPassportNumber				:= in_mod.Passport_Number <> '';
			hasPassportExpireDate		:= trim(in_mod.Passport_Expire_Date) <> '--';
			hasPassportPlaceOfBirth	:= in_mod.Passport_Place_Birth <> '';
			hasPassportCountryOfBirth			:= in_mod.Passport_Country_Birth <> '';
			hasPassportFamilyNameAtBirth	:= in_mod.Passport_Family_Name_Birth <> '';

			// hasUniqueId 						:= in_mod.UniqueId <> '';
			hasQueryId							:= in_mod.QueryId <> '';
			hasTransactionId				:= in_mod.TransactionId <> '';
			hasCompanyId						:= in_mod.CompanyId <> '';
	
			FirstNameSQL		 				:= IF(hasFirstName, ' first_name = ? and ','');
			FirstNameValueSQL				:= IF(hasFirstName, dataset([{trim(in_mod.newfirstname, left, right)}], Layouts.uni_delta_value));				
			MiddleNameSQL		 				:= IF(hasMiddleName, ' middle_name = ? and ','');
			MiddleNameValueSQL			:= if(hasMiddleName, dataset([{trim(in_mod.newmiddlename, left, right)}], Layouts.uni_delta_value));
			LastNameSQL		 					:= IF(hasLastName, ' last_name = ? and ','');
			LastNameValueSQL				:= IF(hasLastName, dataset([{trim(in_mod.newlastname, left, right)}], Layouts.uni_delta_value))	;		
			FullNameSQL		 					:= IF(hasFullName, ' full_name = ? and ','');
			FullNameValueSQL				:= IF(hasFullName, dataset([{trim(in_mod.fullname, left, right)}], Layouts.uni_delta_value));
			MaidenNameSQL		 				:= IF(hasMaidenName, ' maiden_name = ? and ','');
			MaidenNameValueSQL			:= IF(hasMaidenName, dataset([{trim(in_mod.maidenname, left, right)}], Layouts.uni_delta_value))	;
			GenderSQL		 						:= IF(hasGender, ' (gender = ? or gender = ?) and ','');
			GenderValueSQL					:= IF(hasGender, dataset([{trim(in_mod.igender, left, right)}, {trim(in_mod.igender, left, right)[1]}], Layouts.uni_delta_value))	;
			Addr1SQL 			      		:= IF(hasAddr1, ' street_address1 = ? and ','');			
			Addr1ValueSQL 	    		:= IF(hasAddr1, dataset([{trim(in_mod.StreetAddress1, left, right)}], Layouts.uni_delta_value));
			Addr2SQL 			      		:= IF(hasAddr2, ' street_address2 = ? and ','');			
			Addr2ValueSQL 	    		:= IF(hasAddr2, dataset([{trim(in_mod.StreetAddress2, left, right)}], Layouts.uni_delta_value));
			UnitNumSQL 							:= IF(hasUnitNumber, ' unit_number = ? and ','');	
			UnitNumValueSQL 				:= IF(hasUnitNumber, dataset([{trim(in_mod.unitnumber, left, right)}], Layouts.uni_delta_value));
			BuildingNumSQL 					:= IF(hasBuildingNumber, ' building_number = ? and ','');	
			BuildingNumValueSQL 		:= IF(hasBuildingNumber, dataset([{trim(in_mod.buildingnumber, left, right)}], Layouts.uni_delta_value));
			BuildingNameSQL 				:= IF(hasBuildingName, ' building_name = ? and ','');	
			BuildingNameValueSQL		:= IF(hasBuildingName, dataset([{trim(in_mod.buildingname, left, right)}], Layouts.uni_delta_value));
			FloorNumSQL 						:= IF(hasFloorNumber, ' floor_number = ? and ','');	
			FloorNumValueSQL 				:= IF(hasFloorNumber, dataset([{trim(in_mod.floornumber, left, right)}], Layouts.uni_delta_value));
			StreetNumSQL 						:= IF(hasStreetNumber, ' street_number = ? and ','');	
			StreetNumValueSQL 			:= IF(hasStreetNumber, dataset([{trim(in_mod.streetnumber, left, right)}], Layouts.uni_delta_value));			
			StreetNameSQL 					:= IF(hasStreetName, ' street_name = ? and ','');	
			StreetNameValueSQL 			:= IF(hasStreetName, dataset([{trim(in_mod.streetname, left, right)}], Layouts.uni_delta_value));
			StreetTypeSQL 					:= IF(hasStreetType, ' street_type = ? and ','');	
			StreetTypeValueSQL 			:= IF(hasStreetType, dataset([{trim(in_mod.streettype, left, right)}], Layouts.uni_delta_value));
			SuburbSQL		 						:= IF(hasSuburb, ' suburb = ? and ','');
			SuburbValueSQL		 			:= IF(hasSuburb, dataset([{trim(in_mod.suburb, left, right)}], Layouts.uni_delta_value));
			CitySQL		 							:= IF(hasCity, ' city = ? and ','');
			CityValueSQL		 				:= IF(hasCity, dataset([{trim(in_mod.icity, left, right)}], Layouts.uni_delta_value));
			DistrictSQL		 					:= IF(hasDistrict, ' district = ? and ','');
			DistrictValueSQL				:= IF(hasDistrict, dataset([{trim(in_mod.district, left, right)}], Layouts.uni_delta_value));
			CountySQL		 						:= IF(hasCounty, ' county = ? and ','');
			CountyValueSQL		 			:= IF(hasCounty, dataset([{trim(in_mod.icounty, left, right)}], Layouts.uni_delta_value));	
			StateSQL		 						:= IF(hasState, ' state = ? and ','');
			StateValueSQL		 				:= IF(hasState, dataset([{trim(in_mod.istate, left, right)}], Layouts.uni_delta_value))	;
			CountrySQL		 					:= IF(hasCountry, ' country = ? and ','');
			CountryValueSQL		 			:= IF(hasCountry, dataset([{trim(in_mod.CountryId, left, right)}], Layouts.uni_delta_value))	;		
			PostalCodeSQL						:= IF(hasPostalCode, ' postal_code = ? and ','');	
			PostalCodeValueSQL 			:= IF(hasPostalCode, dataset([{trim(in_mod.postal_code, left, right)}], Layouts.uni_delta_value));
			DOBSQL		 							:= IF(hasDOB, ' dob = ? and ','');
			stringDOB								:= (string) in_mod.dateofbirth;
			tmpDOB              		:= IF(trim(stringDOB) = '--', '', stringDOB);
			DOBValueSQL		 					:= IF(hasDOB, dataset([{tmpDOB}], Layouts.uni_delta_value));
			PhoneSQL								:= IF(hasPhone, ' phone = ? and ','');
			PhoneValueSQL						:= IF(hasPhone, dataset([{trim(in_mod.iphone, left, right)}], Layouts.uni_delta_value));
			MobilePhoneSQL					:= IF(hasMobilePhone, ' mobile_phone = ? and ','');
			MobilePhoneValueSQL			:= IF(hasMobilePhone, dataset([{trim(in_mod.mobilephone, left, right)}], Layouts.uni_delta_value));
			WorkPhoneSQL						:= IF(hasWorkPhone, ' work_phone = ? and ','');
			WorkPhoneValueSQL				:= IF(hasWorkPhone, dataset([{trim(in_mod.workphone, left, right)}], Layouts.uni_delta_value));
			NationalIdSQL						:= IF(hasNationalId, ' national_id = ? and ','');
			NationalIdValueSQL			:= IF(hasNationalId, dataset([{trim(in_mod.NationalId, left, right)}], Layouts.uni_delta_value));
			CityIssuedSQL						:= IF(hasCityOfIssue, ' national_id_city_issued = ? and ','');
			CityIssuedValueSQL			:= IF(hasCityOfIssue, dataset([{trim(in_mod.NationalId_City_Issued, left, right)}], Layouts.uni_delta_value));	
			CountyIssuedSQL					:= IF(hasCountyOfIssue, ' national_id_county_issued = ? and ','');
			CountyIssuedValueSQL		:= IF(hasCountyOfIssue, dataset([{trim(in_mod.NationalId_County_Issued, left, right)}], Layouts.uni_delta_value));	
			DistrictIssuedSQL				:= IF(hasDistrictOfIssue, ' national_id_district_issued = ? and ','');
			DistrictIssuedValueSQL	:= IF(hasDistrictOfIssue, dataset([{trim(in_mod.NationalId_District_Issued, left, right)}], Layouts.uni_delta_value));	
			ProvinceIssuedSQL				:= IF(hasProvinceOfIssue, ' national_id_province_issued = ? and ','');
			ProvinceIssuedValueSQL	:= IF(hasProvinceOfIssue, dataset([{trim(in_mod.NationalId_Province_Issued, left, right)}], Layouts.uni_delta_value));	
			DLNumSQL								:= IF(hasDLNumber, ' dl_number = ? and ','');
			DLNumValueSQL						:= IF(hasDLNumber, dataset([{trim(in_mod.IDL_Number, left, right)}], Layouts.uni_delta_value));
			DLVersionNumSQL					:= IF(hasDLVersionNumber, ' dl_version_number = ? and ','');
			DLVersionNumValueSQL		:= IF(hasDLVersionNumber, dataset([{trim(in_mod.DL_Version_Number, left, right)}], Layouts.uni_delta_value));	
			DLStateSQL							:= IF(hasDLState, ' dl_state = ? and ','');
			DLStateValueSQL					:= IF(hasDLState, dataset([{trim(in_mod.IDL_State, left, right)}], Layouts.uni_delta_value));	
			tmpDLDate              		:= IF(trim(in_mod.DL_Expire_Date) = '--', '', in_mod.DL_Expire_Date);
			DLExpireSQL							:= IF(hasDLExpireDate, ' dl_expire_date = ? and ','');
			DLExpireValueSQL				:= IF(hasDLExpireDate, dataset([{trim(tmpDLDate, left, right)}], Layouts.uni_delta_value));	
			PassNumSQL							:= IF(hasPassportNumber, ' passport_number = ? and ','');
			PassNumValueSQL					:= IF(hasPassportNumber, dataset([{trim(in_mod.Passport_Number, left, right)}], Layouts.uni_delta_value));	
			tmpPassDate              		:= IF(trim(in_mod.Passport_Expire_Date) = '--', '', in_mod.Passport_Expire_Date);
			PassExpireSQL						:= IF(hasPassportExpireDate, ' passport_expire_date = ? and ','');
			PassExpireValueSQL			:= IF(hasPassportExpireDate, dataset([{trim(tmpPassDate, left, right)}], Layouts.uni_delta_value));	
			PassPlaceSQL						:= IF(hasPassportPlaceOfBirth, ' passport_place_birth = ? and ','');
			PassPlaceValueSQL				:= IF(hasPassportPlaceOfBirth, dataset([{trim(in_mod.Passport_Place_Birth, left, right)}], Layouts.uni_delta_value));	
			PassCountrySQL					:= IF(hasPassportCountryOfBirth, ' passport_country_birth = ? and ','');
			PassCountryValueSQL			:= IF(hasPassportCountryOfBirth, dataset([{trim(in_mod.Passport_Country_Birth, left, right)}], Layouts.uni_delta_value));	
			PassFamilyNameSQL				:= IF(hasPassportFamilyNameAtBirth, ' passport_family_name_birth = ? and ','');
			PassFamilyNameValueSQL	:= IF(hasPassportFamilyNameAtBirth, dataset([{trim(in_mod.Passport_Family_Name_Birth, left, right)}], Layouts.uni_delta_value));

			// UniqueIdSQL 						:= IF(hasUniqueId, ' unique_id = ? and ','');	
			// UniqueIdValueSQL 				:= IF(hasUniqueId, dataset([{trim(in_mod.UniqueId, left, right)}], Layouts.uni_delta_value));	
			QueryIdSQL		 					:= IF(hasQueryId, ' query_id = ? and ','');
			QueryIdValueSQL					:= IF(hasQueryId, dataset([{trim(in_mod.QueryId, left, right)}], Layouts.uni_delta_value));		
			TransactionIdSQL				:= IF(hasTransactionId, ' i.transaction_id = ? and ','');
			TransactionIdValueSQL		:= IF(hasTransactionId, dataset([{trim(in_mod.TransactionId, left, right)}], Layouts.uni_delta_value))	;		
			CompanyIdSQL						:= IF(hasCompanyId, ' company_id = ? and ','');
			CompanyIdValueSQL				:= IF(hasCompanyId, dataset([{trim(in_mod.CompanyId, left, right)}], Layouts.uni_delta_value))	;	

			tmpFieldsSQL := trim( CompanyIdSQL + FirstNameSQL + LastNameSQL + TransactionIdSQL + QueryIdSQL + MiddleNameSQL + FullNameSQL +
														MaidenNameSQL + GenderSQL + Addr1SQL + Addr2SQL + UnitNumSQL + BuildingNumSQL + BuildingNameSQL + FloorNumSQL +
														StreetNumSQL + StreetNameSQL + StreetTypeSQL + SuburbSQL + CitySQL + DistrictSQL + CountySQL + StateSQL + CountrySQL +
														PostalCodeSQL + DOBSQL + PhoneSQL + MobilePhoneSQL + WorkPhoneSQL + NationalIdSQL + CityIssuedSQL + CountyIssuedSQL +
														DistrictIssuedSQL + ProvinceIssuedSQL + DLNumSQL + DLVersionNumSQL + DLStateSQL + DLExpireSQL + PassNumSQL + PassExpireSQL + PassPlaceSQL +
														PassCountrySQL + PassFamilyNameSQL, LEFT, RIGHT);
			ValuesSQL :=	CompanyIdValueSQL + FirstNameValueSQL + LastNameValueSQL + TransactionIdValueSQL + QueryIdValueSQL + MiddleNameValueSQL +
										FullNameValueSQL + MaidenNameValueSQL + GenderValueSQL + Addr1ValueSQL + Addr2ValueSQL + UnitNumValueSQL + BuildingNumValueSQL +
										BuildingNameValueSQL + FloorNumValueSQL + StreetNumValueSQL + StreetNameValueSQL + StreetTypeValueSQL + SuburbValueSQL +
										CityValueSQL + DistrictValueSQL + CountyValueSQL + StateValueSQL + CountryValueSQL + PostalCodeValueSQL + DOBValueSQL +
										PhoneValueSQL + MobilePhoneValueSQL + WorkPhoneValueSQL + NationalIdValueSQL + CityIssuedValueSQL + CountyIssuedValueSQL +
										DistrictIssuedValueSQL + ProvinceIssuedValueSQL + DLNumValueSQL + DLVersionNumValueSQL + DLStateValueSQL + DLExpireValueSQL +
										PassNumValueSQL + PassExpireValueSQL + PassPlaceValueSQL + PassCountryValueSQL + PassFamilyNameValueSQL;

			SQL_Values_List:= dataset([{ValuesSQL}], Layouts.uni_delta_parameter);	
		
			//taking off the last AND below
			FieldsSQL := trim(tmpFieldsSQL[1..length(tmpFieldsSQL) -3], left, right);	
	
			final:= project(Risk_Indicators.iid_constants.ds_Record, transform(Layouts.IIDI2SQLlayout, 
											self.SQLWhereCriteria := FieldsSQL;
											self.SQLValues := SQL_Values_List;
											));
			return final;
	END;
	
	EXPORT DefineSQLParamsValues2(IParam.IIDI2_search_params in_mod) := Module
		EXPORT SQLWhereCriteria := DefineIIDI2SQLParamsValues(in_mod)[1].SQLWhereCriteria;
		EXPORT SQLValues := DefineIIDI2SQLParamsValues(in_mod)[1].SQLValues;
	END;

	EXPORT GetInputDS(IParam.search_params in_mod) := FUNCTION 
		ds_set_input := dataset([TRANSFORM(Layouts.layout_in, 
				SELF.lastname := in_mod.lastname;
				SELF.firstname := in_mod.firstname;
				SELF.Addr := in_mod.Addr;
				SELF.Prim_range := in_mod.Prim_range;
				SELF.Prim_name := in_mod.Prim_name;
				SELF.Suffix := in_mod.Suffix;
				SELF.city := in_mod.city;
				SELF.state := in_mod.state;
				SELF.zip := in_mod.zip;
				SELF.postalcode := in_mod.postalcode;
				SELF.dob := (STRING) in_mod.dob;
				SELF.ssn := in_mod.ssn;
				SELF.NationalId := in_mod.NationalId;
				SELF.queryid  := in_mod.queryid;
				SELF.uniqueid :=in_mod.uniqueid;
				SELF.TransactionId := in_mod.TransactionId,
				SELF.CompanyId := in_mod.CompanyId)]);
		RETURN ds_set_input;
	END;

	EXPORT SetProductType(string ProductType = Constants.InstantId) := FUNCTION
		prod_type := StringLib.StringToUppercase(ProductType);
		type_of_product := MAP(prod_type = Constants.Flexid => Constants.Flexid,
													 prod_type = Constants.InputInstantIdIntrnatl => Constants.InputInstantIdIntrnatl,
													 prod_type = Constants.RedFlags => Constants.RedFlags,
													 prod_type = Constants.FraudPoint => Constants.FraudPoint,
													 Constants.InstantId); // =>'INSTANTID'
		RETURN type_of_product;
	END;	
	
	EXPORT RetrieveProductType(STRING ProductType = Constants.InstantId) := FUNCTION			
		product_name := MAP(ProductType = Constants.Flexid => [Constants.Flexid] ,
												ProductType = Constants.InputInstantIdIntrnatl => [Constants.InstantIdIntrnatl],
												ProductType = Constants.RedFlags => [Constants.InstantId],//Constants.RedFlags,
												ProductType = Constants.FraudPoint => [Constants.InstantId,Constants.Flexid],  //Constants.FraudPoint,
												[Constants.InstantId] ); // =>'INSTANTID'
		RETURN product_name;
	END;		
	
	EXPORT GetSummarySQLFields(IParam.summary_params in_mod) := MODULE
		SHARED boolean   hasCompanyId				:= in_mod.CompanyId <> '';	
		SHARED boolean   hasStartDate				:= in_mod.StartDate <> '';
		SHARED boolean   hasEndDate					:= in_mod.EndDate <> '';			
	
		SHARED string 	StartDateSQL				:= ' date_format(i.date_added, \'%Y%m%d\')  >= ? and ';	//default is per Greg Bethke
		SHARED string 	EndDateSQL					:= IF(hasEndDate, 'date_format(i.date_added, \'%Y%m%d\') <= ? and ','');		
		SHARED string		CompanyIdSQL				:= IF(hasCompanyId, ' company_id = ? and ','');	
		
		SHARED tmpDates := '(' + StartDateSQL + ' date_format(i.date_added, \'%Y%m%d\') <= ? ) and ';
		SHARED tmpFieldsSQL := tmpDates + CompanyIdSQL;
	
		SHARED tmpStartDate := if(hasStartDate, in_mod.StartDate, '20130101');
		SHARED tmpEndDate := if(hasEndDate, (string) in_mod.EndDate, (string) STD.Date.Today());
		SHARED DATASET		StartDateValueSQL		:= dataset([{trim(tmpStartDate, left, right)}], Layouts.delta_value)	;
		SHARED DATASET		EndDateValueSQL		 	:= dataset([{trim(tmpEndDate, left, right)}], Layouts.delta_value)	;
		SHARED DATASET		CompanyIdValueSQL		:= if(hasCompanyId, dataset([{trim(in_mod.CompanyId, left, right)}], Layouts.delta_value))	;
		
		SHARED ValuesSQL := StartDateValueSQL + EndDateValueSQL + CompanyIdValueSQL ;
		SHARED SQL_Values_List:= dataset([{ValuesSQL}], Layouts.delta_parameter);			
		//taking off the last AND and space below
		SHARED FieldsSQL := tmpFieldsSQL[1..length(tmpFieldsSQL) -4];		
		
		EXPORT SQLSummaryFields := FieldsSQL;
		EXPORT SQLSummaryValues := SQL_Values_List;
	END;
	
	EXPORT GetIIDI2SummarySQLFields(IParam.IIDI2_summary_params in_mod) := MODULE
		SHARED boolean   hasCompanyId				:= in_mod.CompanyId <> '';
		SHARED boolean   hasCountryId				:= in_mod.CountryId <> '';
		SHARED boolean   hasStartDate				:= in_mod.StartDate <> '';
		SHARED boolean   hasEndDate					:= in_mod.EndDate <> '';		
	
		SHARED string 	StartDateSQL				:= ' date_format(i.date_added, \'%Y%m%d\')  >= ? and ';	//default is per Greg Bethke
		SHARED string 	EndDateSQL					:= IF(hasEndDate, 'date_format(i.date_added, \'%Y%m%d\') <= ? and ','');		
		SHARED string		CompanyIdSQL				:= IF(hasCompanyId, ' company_id = ? and ','');	
		SHARED string		CountryIdSQL				:= IF(hasCountryId, ' country = ? and ','');	
		
		SHARED tmpDates := '(' + StartDateSQL + ' date_format(i.date_added, \'%Y%m%d\') <= ? ) and ';
		SHARED tmpFieldsSQL := tmpDates + CompanyIdSQL + CountryIdSQL;
	
		SHARED tmpStartDate := if(hasStartDate, in_mod.StartDate, '20150101');
		SHARED tmpEndDate := if(hasEndDate, (string) in_mod.EndDate, (string) STD.Date.Today());
		SHARED DATASET		StartDateValueSQL		:= dataset([{trim(tmpStartDate, left, right)}], Layouts.delta_value);
		SHARED DATASET		EndDateValueSQL		 	:= dataset([{trim(tmpEndDate, left, right)}], Layouts.delta_value);
		SHARED DATASET		CompanyIdValueSQL		:= if(hasCompanyId, dataset([{trim(in_mod.CompanyId, left, right)}], Layouts.delta_value))	;
		SHARED DATASET		CountryIdValueSQL		:= if(hasCountryId, dataset([{trim(in_mod.CountryId, left, right)}], Layouts.delta_value))	;
		
		SHARED ValuesSQL := StartDateValueSQL + EndDateValueSQL + CompanyIdValueSQL + CountryIdValueSQL;
		SHARED SQL_Values_List:= dataset([{ValuesSQL}], Layouts.delta_parameter);			
		//taking off the last AND and space below
		SHARED FieldsSQL := tmpFieldsSQL[1..length(tmpFieldsSQL) -4];		
		
		EXPORT SQLSummaryFields := FieldsSQL;
		EXPORT SQLSummaryValues := SQL_Values_List;
	END;
	
	EXPORT GetStartDate(IParam.summary_params in_mod) := FUNCTION
			tmpStartDate := if(in_mod.StartDate <> '', in_mod.StartDate, '20130101');
			RETURN tmpStartDate;
	END;
	
	EXPORT GetIIDI2StartDate(IParam.IIDI2_summary_params in_mod) := FUNCTION
			tmpStartDate := if(in_mod.StartDate <> '', in_mod.StartDate, '20150101');
			RETURN tmpStartDate;
	END;

	EXPORT GetEndDate(IParam.summary_params in_mod) := FUNCTION
			tmpEndDate := if(in_mod.EndDate <> '', in_mod.EndDate, (string) STD.Date.Today());
			RETURN tmpEndDate;
	END;
	
	EXPORT GetIIDI2EndDate(IParam.IIDI2_summary_params in_mod) := FUNCTION
			tmpEndDate := if(in_mod.EndDate <> '', in_mod.EndDate, (string) STD.Date.Today());
			RETURN tmpEndDate;
	END;
	
	EXPORT mac_filterByNonAutoKeyFields( ds_recs, search_Type ) := FUNCTIONMACRO

		BOOLEAN	  hasUniqueId 				:= in_mod.UniqueId      <> '';
		BOOLEAN   hasQueryId					:= in_mod.QueryId       <> '';	
		BOOLEAN   hasTransactionId		:= in_mod.TransactionId <> '';	
		BOOLEAN   hasCompanyId				:= in_mod.CompanyId     <> '';	
		BOOLEAN   hasDOB							:= in_mod.DOB 					<> 0;
		BOOLEAN		TransactionIdKeys		:= IF(hasTransactionId  ,ds_recs.transaction_id = in_mod.transactionid  ,true);			
		BOOLEAN		CompanyIdKeys				:= IF(hasCompanyId      ,ds_recs.company_id     = in_mod.Companyid      ,true);
		BOOLEAN		QueryIdKeys					:= IF(hasQueryId        ,ds_recs.query_id       = in_mod.queryid        ,true);			
		BOOLEAN		UniqueIdKeys 				:= IF(hasUniqueId       ,ds_recs.unique_id      = in_mod.uniqueid       ,true);
		STRING		stringyDOB					:= (string) in_mod.dob;
		STRING8		tmpyDOB             := IF(stringyDOB = '0', '', stringyDOB[1..8]);		
		BOOLEAN		DOBKeys 						:= IF(hasDOB  					,ds_recs.DOB 						= tmpyDOB								,true);
		
		search_name_type := Functions.RetrieveProductType(search_type);
		ds_filter_key := ds_recs(ds_recs.Product in search_name_type, TransactionIdKeys,CompanyIdKeys,QueryIdKeys,UniqueIdKeys); 
	RETURN ds_filter_key;
  
	ENDMACRO;	
	
	EXPORT mac_filterByIIDI2KeyFields(ds_recs) := FUNCTIONMACRO

			hasFirstName						:= in_mod.newfirstname <> '';
			hasMiddleName						:= in_mod.newmiddlename <> '';
			hasLastName							:= in_mod.newlastname <> '';
			hasFullName							:= in_mod.fullname <> '';
			hasMaidenName						:= in_mod.maidenname <> '';
			hasGender								:= in_mod.igender <> '';
			hasAddr1  			    		:= in_mod.StreetAddress1 <> '';
			hasAddr2  			    		:= in_mod.StreetAddress2 <> '';
			hasUnitNumber						:= in_mod.unitnumber <> '';
			hasBuildingNumber				:= in_mod.buildingnumber <> '';
			hasBuildingName					:= in_mod.buildingname <> '';
			hasFloorNumber					:= in_mod.fullname <> '';
			hasStreetNumber					:= in_mod.StreetNumber <> '';
			hasStreetName  					:= in_mod.StreetName <> '';
			hasStreetType						:= in_mod.StreetType <> '';
			hasSuburb								:= in_mod.suburb <> '';
			hasCity									:= in_mod.icity <> '';
			hasDistrict							:= in_mod.district <> '';
			hasCounty								:= in_mod.icounty <> '';
			hasState								:= in_mod.istate <> '';
			hasPostalCode						:= in_mod.Postal_Code <> '';
			hasPhone								:= in_mod.iPhone <> '';
			hasMobilePhone					:= in_mod.MobilePhone <> '';
			hasWorkPhone						:= in_mod.WorkPhone <> '';
			hasDOB									:= if(trim(in_mod.DateOfBirth) = '--', false, true);
			hasNationalId     			:= in_mod.NationalId <> '';
			hasCityOfIssue     			:= in_mod.NationalId_City_Issued <> '';
			hasCountyOfIssue    		:= in_mod.NationalId_County_Issued <> '';
			hasDistrictOfIssue  		:= in_mod.NationalId_District_Issued <> '';
			hasProvinceOfIssue  		:= in_mod.NationalId_Province_Issued <> '';
			hasDLNumber							:= in_mod.IDL_Number <> '';
			hasDLVersionNumber			:= in_mod.DL_Version_Number <> '';
			hasDLState							:= in_mod.IDL_State <> '';
			hasDLExpireDate					:= trim(in_mod.DL_Expire_Date) <> '--';
			hasPassportNumber				:= in_mod.Passport_Number <> '';
			hasPassportExpireDate		:= trim(in_mod.Passport_Expire_Date) <> '--';
			hasPassportPlaceOfBirth	:= in_mod.Passport_Place_Birth <> '';
			hasPassportCountryOfBirth			:= in_mod.Passport_Country_Birth <> '';
			hasPassportFamilyNameAtBirth	:= in_mod.Passport_Family_Name_Birth <> '';

			hasQueryId							:= in_mod.QueryId <> '';
			hasTransactionId				:= in_mod.TransactionId <> '';
			// hasCompanyId						:= in_mod.CompanyId <> '';
			
		UCase := UnicodeLib.UnicodeToUpperCase;

		BOOLEAN		TransactionIdKeys		:= IF(hasTransactionId  	,trim(UCase(ds_recs.transaction_id))		= trim(UCase(in_mod.transactionid))  ,true);			
		// BOOLEAN		CompanyIdKeys			:= IF(hasCompanyId      	,trim(UCase(ds_recs.company_id))     	= trim(UCase(in_mod.Companyid))      ,true);
		BOOLEAN		QueryIdKeys					:= IF(hasQueryId        	,trim(UCase(ds_recs.query_id))					= trim(UCase(in_mod.queryid))        ,true);			
		STRING		stringyDOB					:= (string) in_mod.DateOfBirth;
		STRING		tmpyDOB           	:= IF(stringyDOB = '--', '', stringyDOB);		
		BOOLEAN		DOBKeys 						:= IF(hasDOB  						,trim(UCase(ds_recs.orig_dob)) 					= trim(UCase(tmpyDOB))								,true);
		BOOLEAN		MiddleNameKeys			:= IF(hasMiddleName				,trim(UCase(ds_recs.orig_mname)) 				= trim(UCase(in_mod.newmiddlename)) 	,true);
		BOOLEAN		FullNameKeys				:= IF(hasFullName					,trim(UCase(ds_recs.fullname)) 					= trim(UCase(in_mod.fullname)) 				,true);
		BOOLEAN		MaidenNameKeys			:= IF(hasMaidenName				,trim(UCase(ds_recs.maiden_name)) 			= trim(UCase(in_mod.maidenname)) 			,true);
		BOOLEAN		GenderKeys					:= IF(hasGender						,trim(UCase(ds_recs.gender)) 						= trim(UCase(in_mod.igender)) 				,true);
		BOOLEAN		Addr1Keys						:= IF(hasAddr1						,trim(UCase(ds_recs.Street_Address1))		= trim(UCase(in_mod.StreetAddress1))	,true);
		BOOLEAN		Addr2Keys						:= IF(hasAddr2						,trim(UCase(ds_recs.Street_Address2))		= trim(UCase(in_mod.StreetAddress2))	,true);
		BOOLEAN		UnitNumberKeys			:= IF(hasUnitNumber				,trim(UCase(ds_recs.unit_number)) 			= trim(UCase(in_mod.unitnumber)) 			,true);
		BOOLEAN		BuildingNumKeys			:= IF(hasBuildingNumber		,trim(UCase(ds_recs.building_number))		= trim(UCase(in_mod.buildingnumber))	,true);
		BOOLEAN		BuildingNameKeys		:= IF(hasBuildingName			,trim(UCase(ds_recs.building_name)) 		= trim(UCase(in_mod.buildingname)) 		,true);
		BOOLEAN		FloorNumKeys				:= IF(hasFloorNumber			,trim(UCase(ds_recs.Floor_Number)) 			= trim(UCase(in_mod.fullname)) 				,true);
		BOOLEAN		StreetNumKeys				:= IF(hasStreetNumber			,trim(UCase(ds_recs.orig_address_number))	= trim(UCase(in_mod.StreetNumber))	,true);
		BOOLEAN		StreetNameKeys			:= IF(hasStreetName				,trim(UCase(ds_recs.orig_address)) 			= trim(UCase(in_mod.StreetName)) 			,true);
		BOOLEAN		StreetTypeKeys			:= IF(hasStreetType				,trim(UCase(ds_recs.orig_address_type))	= trim(UCase(in_mod.StreetType)) 			,true);
		BOOLEAN		SuburbKeys					:= IF(hasSuburb						,trim(UCase(ds_recs.suburb)) 						= trim(UCase(in_mod.suburb)) 					,true);
		BOOLEAN		CityKeys						:= IF(hasCity							,trim(UCase(ds_recs.orig_city)) 				= trim(UCase(in_mod.icity))						,true);
		BOOLEAN		DistrictKeys				:= IF(hasDistrict					,trim(UCase(ds_recs.district)) 					= trim(UCase(in_mod.district)) 				,true);
		BOOLEAN		CountyKeys					:= IF(hasCounty						,trim(UCase(ds_recs.county)) 						= trim(UCase(in_mod.icounty)) 				,true);
		BOOLEAN		StateKeys						:= IF(hasState						,trim(UCase(ds_recs.orig_state)) 				= trim(UCase(in_mod.istate)) 					,true);
		BOOLEAN		PostalCodeKeys			:= IF(hasPostalCode				,trim(UCase(ds_recs.orig_zip)) 					= trim(UCase(in_mod.Postal_Code)) 		,true);
		BOOLEAN		PhoneKeys						:= IF(hasPhone						,trim(UCase(ds_recs.Phone)) 						= trim(UCase(in_mod.iPhone)) 					,true);
		BOOLEAN		MobilePhoneKeys			:= IF(hasMobilePhone			,trim(UCase(ds_recs.Mobile_Phone)) 			= trim(UCase(in_mod.MobilePhone)) 		,true);
		BOOLEAN		WorkPhoneKeys				:= IF(hasWorkPhone				,trim(UCase(ds_recs.Work_Phone)) 				= trim(UCase(in_mod.WorkPhone)) 			,true);
		BOOLEAN		NaionalIDKeys				:= IF(hasNationalId				,trim(UCase(ds_recs.National_Id)) 			= trim(UCase(in_mod.NationalId)) 			,true);
		BOOLEAN		CityIssuedKeys			:= IF(hasCityOfIssue			,trim(UCase(ds_recs.National_Id_City_Issued)) 		= trim(UCase(in_mod.NationalId_City_Issued)) 			,true);
		BOOLEAN		CountyIssuedKeys		:= IF(hasCountyOfIssue		,trim(UCase(ds_recs.National_Id_County_Issued)) 	= trim(UCase(in_mod.NationalId_County_Issued)) 		,true);
		BOOLEAN		DistrictIssuedKeys	:= IF(hasDistrictOfIssue	,trim(UCase(ds_recs.National_Id_District_Issued))	= trim(UCase(in_mod.NationalId_District_Issued))	,true);
		BOOLEAN		ProvinceIssuedKeys	:= IF(hasProvinceOfIssue	,trim(UCase(ds_recs.National_Id_Province_Issued))	= trim(UCase(in_mod.NationalId_Province_Issued))	,true);
		BOOLEAN		DLNumberKeys				:= IF(hasDLNumber					,trim(UCase(ds_recs.DL_Number)) 				= trim(UCase(in_mod.IDL_Number)) 					,true);
		BOOLEAN		DLVersionNumberKeys	:= IF(hasDLVersionNumber	,trim(UCase(ds_recs.DL_Version_Number)) = trim(UCase(in_mod.DL_Version_Number))		,true);
		BOOLEAN		DLStateKeys					:= IF(hasDLState					,trim(UCase(ds_recs.DL_State)) 					= trim(UCase(in_mod.IDL_State)) 					,true);
		STRING		tempDLDate          := IF(trim(in_mod.DL_Expire_Date) = '--', '', trim(in_mod.DL_Expire_Date));
		BOOLEAN		DLExpireDateKeys		:= IF(hasDLExpireDate			,trim(UCase(ds_recs.DL_Expire_Date)) 		= trim(UCase(tempDLDate)) 								,true);
		BOOLEAN		PassportNumKeys			:= IF(hasPassportNumber		,trim(UCase(ds_recs.Passport_Number)) 	= trim(UCase(in_mod.Passport_Number)) 		,true);
		STRING		tempPassDate        := IF(trim(in_mod.Passport_Expire_Date) = '--', '', trim(in_mod.Passport_Expire_Date));
		BOOLEAN		PassportExpireDateKeys			:= IF(hasPassportExpireDate					,trim(UCase(ds_recs.Passport_Expire_Date)) 				= trim(UCase(tempPassDate)) 											,true);
		BOOLEAN		PassportPlaceBirthKeys			:= IF(hasPassportPlaceOfBirth				,trim(UCase(ds_recs.Passport_Place_Birth)) 				= trim(UCase(in_mod.Passport_Place_Birth)) 				,true);
		BOOLEAN		PassportCountryBirthKeys		:= IF(hasPassportCountryOfBirth			,trim(UCase(ds_recs.Passport_Country_Birth)) 			= trim(UCase(in_mod.Passport_Country_Birth)) 			,true);
		BOOLEAN		PassportFamilyNameBirthKeys	:= IF(hasPassportFamilyNameAtBirth	,trim(UCase(ds_recs.Passport_Family_Name_Birth))	= trim(UCase(in_mod.Passport_Family_Name_Birth))	,true);

		ds_filter_key := ds_recs(	TransactionIdKeys, QueryIdKeys, DOBKeys, MiddleNameKeys, FullNameKeys, MaidenNameKeys,
															GenderKeys, Addr1Keys, Addr2Keys, UnitNumberKeys, BuildingNumKeys, BuildingNameKeys, FloorNumKeys,
															StreetNumKeys, StreetNameKeys, StreetTypeKeys, SuburbKeys, CityKeys, DistrictKeys, CountyKeys, StateKeys,
															PostalCodeKeys, PhoneKeys, MobilePhoneKeys, WorkPhoneKeys, NaionalIDKeys, CityIssuedKeys, CountyIssuedKeys,
															DistrictIssuedKeys, ProvinceIssuedKeys, DLNumberKeys, DLStateKeys, DLExpireDateKeys, PassportNumKeys,
															PassportExpireDateKeys, PassportPlaceBirthKeys, PassportCountryBirthKeys, PassportFamilyNameBirthKeys); 
	
		// output(ds_filter_key);
		
	RETURN ds_filter_key;
  
	ENDMACRO;
	
END;

	