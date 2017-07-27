IMPORT IESP, InstantID_Archiving, Standard, Address, Gateway;
EXPORT Transforms :=  MODULE

		EXPORT Layouts.delta_input	xToSelf(Layouts.delta_input	l , dataset(Gateway.layouts.config) gateways_cfg)	:= 	TRANSFORM
				SELF._Blind := Gateway.Configuration.GetBlindOption(gateways_cfg);
				SELF	:=	l;
		END;
		
		EXPORT Layouts.uni_delta_input	iidi2_xToSelf(Layouts.uni_delta_input	l, dataset(Gateway.layouts.config) gateways_cfg)	:= 	TRANSFORM
				SELF._Blind := Gateway.Configuration.GetBlindOption(gateways_cfg);
				SELF	:=	l;
		END;
		
		EXPORT Layouts.layout_dobmask pre_dm_trans(Layouts.layout_in l) := TRANSFORM
			self.dob_unmasked := (unsigned4) l.dob;
			self.dob_masked := ROW ({'', '', ''}, Standard.Date.Datestr);
			self := L;
		END;
						
		EXPORT Layouts.denorm_searchNameAddr FillNamesAddrsFromDBRecs(Layouts.Single_DeNormed_Records l) := TRANSFORM
			SELF.Name := iesp.ECL2ESP.SetName(StringLib.StringToUppercase(l.first_name), '',
																				StringLib.StringToUppercase(l.last_name), '', '', ''); 			
			//Get Address info																																				
			AppendedStreet := stringlib.StringCleanSpaces(l.street_number +' '+ l.street_name + ' ' + l.street_type);
			street2use := if (l.street <> '', l.street, AppendedStreet);
			ZipToUse := IF(l.PostalCode != '', l.PostalCode, l.zip);
			cityStZip := stringlib.StringCleanSpaces(l.city + ' ' + l.state + ' ' + ZipToUse);
			CleanAddressUS :=Address.CleanAddressParsed(street2use, cityStZip);
			//using this as we have international addresses
			CleanAddressIntrntl := 	Address.CleanAddressFieldsFips(datalib.AddressClean(street2use, cityStZip));		
			//determine which address to use										
			USAddress := IF(CleanAddressUS.Prim_range != '' or CleanAddressUS.prim_name != '' or CleanAddressUS.zip != '',
				true, false);
			tmpAddr := Address.Addr1FromComponents(StringLib.StringToUppercase(if(USAddress, CleanAddressUS.prim_range, CleanAddressIntrntl.prim_range)),
						StringLib.StringToUppercase(if(USAddress, CleanAddressUS.predir, CleanAddressIntrntl.predir)),
						StringLib.StringToUppercase(if(USAddress, CleanAddressUS.prim_name, CleanAddressIntrntl.prim_name)),
						StringLib.StringToUppercase(if(USAddress, CleanAddressUS.addr_suffix, CleanAddressIntrntl.addr_suffix)),
						StringLib.StringToUppercase(if(USAddress, CleanAddressUS.postdir, CleanAddressIntrntl.postdir)),
						StringLib.StringToUppercase(if(USAddress, CleanAddressUS.unit_desig, CleanAddressIntrntl.unit_desig)),
						StringLib.StringToUppercase(if(USAddress, CleanAddressUS.sec_range, CleanAddressIntrntl.sec_range)));		
		
			SELF.Address := iesp.ECL2ESP.SetUniversalAddress(
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.prim_name, CleanAddressIntrntl.prim_name)), 
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.prim_range, CleanAddressIntrntl.prim_range)),
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.predir, CleanAddressIntrntl.predir)),
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.postdir, CleanAddressIntrntl.postdir)),
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.addr_suffix, CleanAddressIntrntl.addr_suffix)),
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.unit_desig, CleanAddressIntrntl.unit_desig)) ,
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.sec_range, CleanAddressIntrntl.sec_range)),
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.v_city_name, CleanAddressIntrntl.p_city_name)), 
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.st, CleanAddressIntrntl.v_city_name[..2])),
															StringLib.StringToUppercase(if(USAddress, CleanAddressUS.zip,'')),  '',  '', 
															StringLib.StringToUppercase(if(USAddress, '', CleanAddressIntrntl.v_city_name[3..7])),
															tmpAddr,
															'',  '', '',  '', false); 
			SELF.TransactionTimestamp := iesp.ECL2ESP.toTimeStamp(l.date_added[1..4] + l.date_added[6..7] + l.date_added[9..10] + ' ' + l.date_added[12..13] +
																			l.date_added[15..16]	+ l.date_added[18..19]);
			SELF := L;
		END;	
		
		//Transform to assign data back to output of correct country
		EXPORT Layouts.denorm_IIDI2searchNameAddr FillNamesAddrsFromIIDI2DBRecs(Layouts.Single_IIDI2_DeNormed_Records l, integer i) := TRANSFORM
			UCase := UnicodeLib.UnicodeToUpperCase;
			SCase := StringLib.StringToUpperCase;
			
			//AustaliaFields
			self.AustraliaVerification.FirstName := if(l.country = Constants.Australia, UCase(l.first_name), '');
			self.AustraliaVerification.MiddleName := if(l.country = Constants.Australia, UCase(l.middle_name), '');
			self.AustraliaVerification.LastName := if(l.country = Constants.Australia, UCase(l.last_name), '');
			self.AustraliaVerification.YearOfBirth := if(l.country = Constants.Australia, l.dob[1..4], '');
			self.AustraliaVerification.MonthOfBirth := if(l.country = Constants.Australia, l.dob[6..7], '');
			self.AustraliaVerification.DayOfBirth := if(l.country = Constants.Australia, l.dob[9..10], '');
			self.AustraliaVerification.StreetNumber := if(l.country = Constants.Australia, l.street_number, '');
			self.AustraliaVerification.StreetName := if(l.country = Constants.Australia, UCase(l.street_name), '');
			self.AustraliaVerification.StreetType := if(l.country = Constants.Australia, UCase(l.street_type), '');
			self.AustraliaVerification.UnitNumber := if(l.country = Constants.Australia, l.unit_number, '');
			self.AustraliaVerification.Suburb := if(l.country = Constants.Australia, UCase(l.suburb), '');
			self.AustraliaVerification.State := if(l.country = Constants.Australia, UCase(l.state), '');
			self.AustraliaVerification.PostalCode := if(l.country = Constants.Australia, l.postal_code, '');
			self.AustraliaVerification.Telephone := if(l.country = Constants.Australia, l.telephone, '');
			self.AustraliaVerification.RTACardNumber := if(l.country = Constants.Australia, SCase(l.national_id), '');
			self.AustraliaVerification.DriverLicenceNumber := if(l.country = Constants.Australia, SCase(l.dl_number), '');
			self.AustraliaVerification.DriverLicenceState := if(l.country = Constants.Australia, SCase(l.dl_state), '');
			self.AustraliaVerification.YearOfExpiry := if(l.country = Constants.Australia, l.dl_expire_date[1..4], '');
			self.AustraliaVerification.MonthOfExpiry := if(l.country = Constants.Australia, l.dl_expire_date[6..7], '');
			self.AustraliaVerification.DayOfExpiry := if(l.country = Constants.Australia, l.dl_expire_date[9..10], '');
			self.AustraliaVerification.Passport.PassportNumber := if(l.country = Constants.Australia, SCase(l.passport_number), '');
			self.AustraliaVerification.Passport.PassportYearOfExpiry := if(l.country = Constants.Australia, l.passport_expire_date[1..4], '');
			self.AustraliaVerification.Passport.PassportMonthOfExpiry := if(l.country = Constants.Australia, l.passport_expire_date[6..7], '');
			self.AustraliaVerification.Passport.PassportDayOfExpiry := if(l.country = Constants.Australia, l.passport_expire_date[9..10], '');
			self.AustraliaVerification.Passport.PlaceOfBirth := if(l.country = Constants.Australia, UCase(l.passport_place_birth), '');
			self.AustraliaVerification.Passport.CountryOfBirth := if(l.country = Constants.Australia, UCase(l.passport_country_birth), '');
			self.AustraliaVerification.Passport.FamilyNameAtBirth := if(l.country = Constants.Australia, UCase(l.passport_family_name_birth), '');
			
			//AustriaFields
			self.AustriaVerification.FirstName := if(l.country = Constants.Austria, UCase(l.first_name), '');
			self.AustriaVerification.LastName := if(l.country = Constants.Austria, UCase(l.last_name), '');
			self.AustriaVerification.YearOfBirth := if(l.country = Constants.Austria, l.dob[1..4], '');
			self.AustriaVerification.MonthOfBirth := if(l.country = Constants.Austria, l.dob[6..7], '');
			self.AustriaVerification.DayOfBirth := if(l.country = Constants.Austria, l.dob[9..10], '');
			self.AustriaVerification.HouseNumber := if(l.country = Constants.Austria, l.street_number, '');
			self.AustriaVerification.StreetName := if(l.country = Constants.Austria, UCase(l.street_name), '');
			self.AustriaVerification.City := if(l.country = Constants.Austria, UCase(l.city), '');
			self.AustriaVerification.PostalCode := if(l.country = Constants.Austria, l.postal_code, '');
			self.AustriaVerification.Telephone := if(l.country = Constants.Austria, l.telephone, '');
			
			//BrazilFields
			self.BrazilVerification.FirstName := if(l.country = Constants.Brazil, UCase(l.first_name), '');
			self.BrazilVerification.LastName := if(l.country = Constants.Brazil, UCase(l.last_name), '');
			self.BrazilVerification.Gender := if(l.country = Constants.Brazil, SCase(l.gender), '');
			self.BrazilVerification.YearOfBirth := if(l.country = Constants.Brazil, l.dob[1..4], '');
			self.BrazilVerification.MonthOfBirth := if(l.country = Constants.Brazil, l.dob[6..7], '');
			self.BrazilVerification.DayOfBirth := if(l.country = Constants.Brazil, l.dob[9..10], '');
			self.BrazilVerification.Address1 := if(l.country = Constants.Brazil, UCase(l.street_address1), '');
			self.BrazilVerification.StreetNumber := if(l.country = Constants.Brazil, l.street_number, '');
			self.BrazilVerification.UnitNumber := if(l.country = Constants.Brazil, l.unit_number, '');
			self.BrazilVerification.Suburb := if(l.country = Constants.Brazil, UCase(l.suburb), '');
			self.BrazilVerification.City := if(l.country = Constants.Brazil, UCase(l.city), '');
			self.BrazilVerification.State := if(l.country = Constants.Brazil, UCase(l.state), '');
			self.BrazilVerification.PostalCode := if(l.country = Constants.Brazil, l.postal_code, '');
			self.BrazilVerification.Telephone := if(l.country = Constants.Brazil, l.telephone, '');
			self.BrazilVerification.NationalIDNumber := if(l.country = Constants.Brazil, SCase(l.national_id), '');
			
			//CanandaFields
			self.CanadaVerification.FirstName := if(l.country = Constants.Canada, UCase(l.first_name), '');
			self.CanadaVerification.MiddleName := if(l.country = Constants.Canada, UCase(l.middle_name), '');
			self.CanadaVerification.LastName := if(l.country = Constants.Canada, UCase(l.last_name), '');
			self.CanadaVerification.YearOfBirth := if(l.country = Constants.Canada, l.dob[1..4], '');
			self.CanadaVerification.MonthOfBirth := if(l.country = Constants.Canada, l.dob[6..7], '');
			self.CanadaVerification.DayOfBirth := if(l.country = Constants.Canada, l.dob[9..10], '');
			self.CanadaVerification.CivicNumber := if(l.country = Constants.Canada, l.street_number, '');
			self.CanadaVerification.StreetName := if(l.country = Constants.Canada, UCase(l.street_name), '');
			self.CanadaVerification.StreetType := if(l.country = Constants.Canada, UCase(l.street_type), '');
			self.CanadaVerification.UnitNumber := if(l.country = Constants.Canada, l.unit_number, '');
			self.CanadaVerification.Municipality := if(l.country = Constants.Canada, UCase(l.city), '');
			self.CanadaVerification.Province := if(l.country = Constants.Canada, UCase(l.county), '');
			self.CanadaVerification.Telephone := if(l.country = Constants.Canada, l.telephone, '');
			self.CanadaVerification.SocialInsuranceNumber := if(l.country = Constants.Canada, SCase(l.national_id), '');
			
			//ChinaFields
			self.ChinaVerification.ChinesePersonalName := if(l.country = Constants.China, UCase(l.full_name), '');
			self.ChinaVerification.GivenNames := if(l.country = Constants.China, UCase(l.first_name), '');
			self.ChinaVerification.SurName := if(l.country = Constants.China, UCase(l.last_name), '');
			self.ChinaVerification.YearOfBirth := if(l.country = Constants.China, l.dob[1..4], '');
			self.ChinaVerification.MonthOfBirth := if(l.country = Constants.China, l.dob[6..7], '');
			self.ChinaVerification.DayOfBirth := if(l.country = Constants.China, l.dob[9..10], '');
			self.ChinaVerification.StreetNumber := if(l.country = Constants.China, l.street_number, '');
			self.ChinaVerification.StreetName := if(l.country = Constants.China, UCase(l.street_name), '');
			self.ChinaVerification.StreetType := if(l.country = Constants.China, UCase(l.street_type), '');
			self.ChinaVerification.BuildingName := if(l.country = Constants.China, UCase(l.building_name), '');
			self.ChinaVerification.BuildingNumber := if(l.country = Constants.China, UCase(l.building_number), '');
			self.ChinaVerification.RoomNumber := if(l.country = Constants.China, l.unit_number, '');
			self.ChinaVerification.City := if(l.country = Constants.China, UCase(l.city), '');
			self.ChinaVerification.Province := if(l.country = Constants.China, UCase(l.suburb), '');
			self.ChinaVerification.County := if(l.country = Constants.China, UCase(l.county), '');
			self.ChinaVerification.Telephone := if(l.country = Constants.China, l.telephone, '');
			self.ChinaVerification.NationalIDNumber := if(l.country = Constants.China, SCase(l.national_id), '');
			self.ChinaVerification.CityOfIssue := if(l.country = Constants.China, UCase(l.national_id_city_issued), '');
			self.ChinaVerification.CountyOfIssue := if(l.country = Constants.China, UCase(l.national_id_county_issued), '');
			self.ChinaVerification.DistrictOfIssue := if(l.country = Constants.China, UCase(l.national_id_district_issued), '');
			self.ChinaVerification.ProvinceOfIssue := if(l.country = Constants.China, UCase(l.national_id_province_issued), '');
			
			//GermanyFields
			self.GermanyVerification.FirstName := if(l.country = Constants.Germany, UCase(l.first_name), '');
			self.GermanyVerification.MiddleName := if(l.country = Constants.Germany, UCase(l.middle_name), '');
			self.GermanyVerification.Gender := if(l.country = Constants.Germany, SCase(l.gender), '');
			self.GermanyVerification.MaidenName := if(l.country = Constants.Germany, UCase(l.maiden_name), '');
			self.GermanyVerification.YearOfBirth := if(l.country = Constants.Germany, l.dob[1..4], '');
			self.GermanyVerification.MonthOfBirth := if(l.country = Constants.Germany, l.dob[6..7], '');
			self.GermanyVerification.DayOfBirth := if(l.country = Constants.Germany, l.dob[9..10], '');
			self.GermanyVerification.HouseNumber := if(l.country = Constants.Germany, l.street_number, '');
			self.GermanyVerification.StreetName := if(l.country = Constants.Germany, UCase(l.street_name), '');
			self.GermanyVerification.City := if(l.country = Constants.Germany, UCase(l.city), '');
			self.GermanyVerification.PostalCode := if(l.country = Constants.Germany, l.postal_code, '');
			self.GermanyVerification.Telephone := if(l.country = Constants.Germany, l.telephone, '');
			
			//HongKongFields
			self.HongKongVerification.FirstName := if(l.country = Constants.HongKong, UCase(l.first_name), '');
			self.HongKongVerification.LastName := if(l.country = Constants.HongKong, UCase(l.last_name), '');
			self.HongKongVerification.YearOfBirth := if(l.country = Constants.HongKong, l.dob[1..4], '');
			self.HongKongVerification.MonthOfBirth := if(l.country = Constants.HongKong, l.dob[6..7], '');
			self.HongKongVerification.DayOfBirth := if(l.country = Constants.HongKong, l.dob[9..10], '');
			self.HongKongVerification.StreetName := if(l.country = Constants.HongKong, UCase(l.street_name), '');
			self.HongKongVerification.BuildingName := if(l.country = Constants.HongKong, UCase(l.building_name), '');
			self.HongKongVerification.BuildingNumber := if(l.country = Constants.HongKong, UCase(l.building_number), '');
			self.HongKongVerification.UnitNumber := if(l.country = Constants.HongKong, l.unit_number, '');
			self.HongKongVerification.FloorNumber := if(l.country = Constants.HongKong, l.floor_number, '');
			self.HongKongVerification.City := if(l.country = Constants.HongKong, UCase(l.city), '');
			self.HongKongVerification.District := if(l.country = Constants.HongKong, UCase(l.district), '');
			self.HongKongVerification.Telephone := if(l.country = Constants.HongKong, l.telephone, '');
			self.HongKongVerification.HongKongIDNumber := if(l.country = Constants.HongKong, SCase(l.national_id), '');
			
			//IrelandFields
			self.IrelandVerification.FirstName := if(l.country = Constants.Ireland, UCase(l.first_name), '');
			self.IrelandVerification.MiddleName := if(l.country = Constants.Ireland, UCase(l.middle_name), '');
			self.IrelandVerification.LastName := if(l.country = Constants.Ireland, UCase(l.last_name), '');
			self.IrelandVerification.YearOfBirth := if(l.country = Constants.Ireland, l.dob[1..4], '');
			self.IrelandVerification.MonthOfBirth := if(l.country = Constants.Ireland, l.dob[6..7], '');
			self.IrelandVerification.DayOfBirth := if(l.country = Constants.Ireland, l.dob[9..10], '');
			self.IrelandVerification.Address1 := if(l.country = Constants.Ireland, UCase(l.street_address1), '');
			self.IrelandVerification.City := if(l.country = Constants.Ireland, UCase(l.city), '');
			self.IrelandVerification.County := if(l.country = Constants.Ireland, UCase(l.county), '');
			self.IrelandVerification.Telephone := if(l.country = Constants.Ireland, l.telephone, '');
			self.IrelandVerification.PersonalPublicServiceNumber := if(l.country = Constants.Ireland, SCase(l.national_id), '');
			
			//JapanFields
			self.JapanVerification.FirstName := if(l.country = Constants.Japan, UCase(l.first_name), '');
			self.JapanVerification.Surname := if(l.country = Constants.Japan, UCase(l.last_name), '');
			self.JapanVerification.Gender := if(l.country = Constants.Japan, SCase(l.gender), '');
			self.JapanVerification.YearOfBirth := if(l.country = Constants.Japan, l.dob[1..4], '');
			self.JapanVerification.MonthOfBirth := if(l.country = Constants.Japan, l.dob[6..7], '');
			self.JapanVerification.DayOfBirth := if(l.country = Constants.Japan, l.dob[9..10], '');
			self.JapanVerification.AreaNumbers := if(l.country = Constants.Japan, l.street_number, '');
			self.JapanVerification.BuildingName := if(l.country = Constants.Japan, UCase(l.building_name), '');
			self.JapanVerification.Aza := if(l.country = Constants.Japan, UCase(l.suburb), '');
			self.JapanVerification.Municipality := if(l.country = Constants.Japan, UCase(l.city), '');
			self.JapanVerification.Prefecture := if(l.country = Constants.Japan, UCase(l.county), '');
			self.JapanVerification.PostalCode := if(l.country = Constants.Japan, l.postal_code, '');
			self.JapanVerification.Telephone := if(l.country = Constants.Japan, l.telephone, '');
			
			//LuxembourgFields
			self.LuxembourgVerification.FirstName := if(l.country = Constants.Luxembourg, UCase(l.first_name), '');
			self.LuxembourgVerification.LastName := if(l.country = Constants.Luxembourg, UCase(l.last_name), '');
			self.LuxembourgVerification.YearOfBirth := if(l.country = Constants.Luxembourg, l.dob[1..4], '');
			self.LuxembourgVerification.MonthOfBirth := if(l.country = Constants.Luxembourg, l.dob[6..7], '');
			self.LuxembourgVerification.DayOfBirth := if(l.country = Constants.Luxembourg, l.dob[9..10], '');
			self.LuxembourgVerification.HouseNumber := if(l.country = Constants.Luxembourg, l.street_number, '');
			self.LuxembourgVerification.StreetName := if(l.country = Constants.Luxembourg, UCase(l.street_name), '');
			self.LuxembourgVerification.City := if(l.country = Constants.Luxembourg, UCase(l.city), '');
			self.LuxembourgVerification.PostalCode := if(l.country = Constants.Luxembourg, l.postal_code, '');
			self.LuxembourgVerification.Telephone := if(l.country = Constants.Luxembourg, l.telephone, '');
			
			//MexicoFields
			self.MexicoVerification.FirstName := if(l.country = Constants.Mexico, UCase(l.first_name), '');
			self.MexicoVerification.FirstSurname := if(l.country = Constants.Mexico, UCase(l.middle_name), '');
			self.MexicoVerification.SecondSurname := if(l.country = Constants.Mexico, UCase(l.last_name), '');
			self.MexicoVerification.Gender := if(l.country = Constants.Mexico, SCase(l.gender), '');
			self.MexicoVerification.YearOfBirth := if(l.country = Constants.Mexico, l.dob[1..4], '');
			self.MexicoVerification.MonthOfBirth := if(l.country = Constants.Mexico, l.dob[6..7], '');
			self.MexicoVerification.DayOfBirth := if(l.country = Constants.Mexico, l.dob[9..10], '');
			self.MexicoVerification.Address1 := if(l.country = Constants.Mexico, UCase(l.street_address1), '');
			self.MexicoVerification.City := if(l.country = Constants.Mexico, UCase(l.city), '');
			self.MexicoVerification.State := if(l.country = Constants.Mexico, UCase(l.state), '');
			self.MexicoVerification.PostalCode := if(l.country = Constants.Mexico, l.postal_code, '');
			self.MexicoVerification.Telephone := if(l.country = Constants.Mexico, l.telephone, '');
			self.MexicoVerification.CURPIDNumber := if(l.country = Constants.Mexico, SCase(l.national_id), '');
			// self.MexicoVerification.StateOfBirth := if(l.country = Constants.Mexico, UCase(l.StateOfBirth), '');
			
			//NetherlandsFields
			self.NetherlandsVerification.GivenNames := if(l.country = Constants.Netherlands, UCase(l.first_name), '');
			self.NetherlandsVerification.MiddleName := if(l.country = Constants.Netherlands, UCase(l.middle_name), '');
			self.NetherlandsVerification.LastName := if(l.country = Constants.Netherlands, UCase(l.last_name), '');
			self.NetherlandsVerification.YearOfBirth := if(l.country = Constants.Netherlands, l.dob[1..4], '');
			self.NetherlandsVerification.MonthOfBirth := if(l.country = Constants.Netherlands, l.dob[6..7], '');
			self.NetherlandsVerification.DayOfBirth := if(l.country = Constants.Netherlands, l.dob[9..10], '');
			self.NetherlandsVerification.HouseNumber := if(l.country = Constants.Netherlands, l.street_number, '');
			self.NetherlandsVerification.StreetName := if(l.country = Constants.Netherlands, UCase(l.street_name), '');
			self.NetherlandsVerification.HouseExtension := if(l.country = Constants.Netherlands, UCase(l.building_number), '');
			self.NetherlandsVerification.City := if(l.country = Constants.Netherlands, UCase(l.city), '');
			self.NetherlandsVerification.PostalCode := if(l.country = Constants.Netherlands, l.postal_code, '');
			self.NetherlandsVerification.Telephone := if(l.country = Constants.Netherlands, l.telephone, '');
			
			//NewZealandFields
			self.NewZealandVerification.FirstName := if(l.country = Constants.NewZealand, UCase(l.first_name), '');
			self.NewZealandVerification.MiddleName := if(l.country = Constants.NewZealand, UCase(l.middle_name), '');
			self.NewZealandVerification.LastName := if(l.country = Constants.NewZealand, UCase(l.last_name), '');
			self.NewZealandVerification.YearOfBirth := if(l.country = Constants.NewZealand, l.dob[1..4], '');
			self.NewZealandVerification.MonthOfBirth := if(l.country = Constants.NewZealand, l.dob[6..7], '');
			self.NewZealandVerification.DayOfBirth := if(l.country = Constants.NewZealand, l.dob[9..10], '');
			self.NewZealandVerification.HouseNumber := if(l.country = Constants.NewZealand, l.street_number, '');
			self.NewZealandVerification.StreetName := if(l.country = Constants.NewZealand, UCase(l.street_name), '');
			self.NewZealandVerification.StreetType := if(l.country = Constants.NewZealand, UCase(l.street_type), '');
			self.NewZealandVerification.UnitNumber := if(l.country = Constants.NewZealand, l.unit_number, '');
			self.NewZealandVerification.Suburb := if(l.country = Constants.NewZealand, UCase(l.suburb), '');
			self.NewZealandVerification.City := if(l.country = Constants.NewZealand, UCase(l.city), '');
			self.NewZealandVerification.PostalCode := if(l.country = Constants.NewZealand, l.postal_code, '');
			self.NewZealandVerification.Telephone := if(l.country = Constants.NewZealand, l.telephone, '');
			self.NewZealandVerification.DriverLicenceNumber := if(l.country = Constants.NewZealand, SCase(l.dl_number), '');
			self.NewZealandVerification.DriverLicenceVersionNumber := if(l.country = Constants.NewZealand, SCase(l.dl_version_number), '');
			
			//SingaporeFields
			self.SingaporeVerification.FirstName := if(l.country = Constants.Singapore, UCase(l.first_name), '');
			self.SingaporeVerification.LastName := if(l.country = Constants.Singapore, UCase(l.last_name), '');
			self.SingaporeVerification.YearOfBirth := if(l.country = Constants.Singapore, l.dob[1..4], '');
			self.SingaporeVerification.MonthOfBirth := if(l.country = Constants.Singapore, l.dob[6..7], '');
			self.SingaporeVerification.DayOfBirth := if(l.country = Constants.Singapore, l.dob[9..10], '');
			self.SingaporeVerification.StreetNumber := if(l.country = Constants.Singapore, l.street_number, '');
			self.SingaporeVerification.StreetName := if(l.country = Constants.Singapore, UCase(l.street_name), '');
			self.SingaporeVerification.StreetType := if(l.country = Constants.Singapore, UCase(l.street_type), '');
			self.SingaporeVerification.BlockNumber := if(l.country = Constants.Singapore, l.unit_number, '');
			self.SingaporeVerification.BuildingName := if(l.country = Constants.Singapore, UCase(l.building_name), '');
			self.SingaporeVerification.City := if(l.country = Constants.Singapore, UCase(l.city), '');
			self.SingaporeVerification.PostalCode := if(l.country = Constants.Singapore, l.postal_code, '');
			self.SingaporeVerification.Telephone := if(l.country = Constants.Singapore, l.telephone, '');
			self.SingaporeVerification.NricNumber := if(l.country = Constants.Singapore, SCase(l.national_id), '');
			
			//SouthAfricaFields
			self.SouthAfricaVerification.FirstName := if(l.country = Constants.SouthAfrica, UCase(l.first_name), '');
			self.SouthAfricaVerification.MiddleName := if(l.country = Constants.SouthAfrica, UCase(l.middle_name), '');
			self.SouthAfricaVerification.LastName := if(l.country = Constants.SouthAfrica, UCase(l.last_name), '');
			self.SouthAfricaVerification.YearOfBirth := if(l.country = Constants.SouthAfrica, l.dob[1..4], '');
			self.SouthAfricaVerification.MonthOfBirth := if(l.country = Constants.SouthAfrica, l.dob[6..7], '');
			self.SouthAfricaVerification.DayOfBirth := if(l.country = Constants.SouthAfrica, l.dob[9..10], '');
			self.SouthAfricaVerification.Address1 := if(l.country = Constants.SouthAfrica, UCase(l.street_address1), '');
			self.SouthAfricaVerification.Address2 := if(l.country = Constants.SouthAfrica, UCase(l.street_address2), '');
			self.SouthAfricaVerification.Suburb := if(l.country = Constants.SouthAfrica, UCase(l.suburb), '');
			self.SouthAfricaVerification.City := if(l.country = Constants.SouthAfrica, UCase(l.city), '');
			self.SouthAfricaVerification.Province := if(l.country = Constants.SouthAfrica, UCase(l.county), '');
			self.SouthAfricaVerification.PostalCode := if(l.country = Constants.SouthAfrica, l.postal_code, '');
			self.SouthAfricaVerification.Telephone := if(l.country = Constants.SouthAfrica, l.telephone, '');
			self.SouthAfricaVerification.CellNumber := if(l.country = Constants.SouthAfrica, l.mobile_phone, '');
			self.SouthAfricaVerification.WorkTelephone := if(l.country = Constants.SouthAfrica, l.work_phone, '');
			self.SouthAfricaVerification.NationalIDNumber := if(l.country = Constants.SouthAfrica, SCase(l.national_id), '');
			
			//SwitzerlandFields
			self.SwitzerlandVerification.FirstName := if(l.country = Constants.Switzerland, UCase(l.first_name), '');
			self.SwitzerlandVerification.LastName := if(l.country = Constants.Switzerland, UCase(l.last_name), '');
			self.SwitzerlandVerification.Gender := if(l.country = Constants.Switzerland, SCase(l.gender), '');
			self.SwitzerlandVerification.YearOfBirth := if(l.country = Constants.Switzerland, l.dob[1..4], '');
			self.SwitzerlandVerification.MonthOfBirth := if(l.country = Constants.Switzerland, l.dob[6..7], '');
			self.SwitzerlandVerification.DayOfBirth := if(l.country = Constants.Switzerland, l.dob[9..10], '');
			self.SwitzerlandVerification.StreetName := if(l.country = Constants.Switzerland, UCase(l.street_name), '');
			self.SwitzerlandVerification.BuildingNumber := if(l.country = Constants.Switzerland, l.street_number, '');
			self.SwitzerlandVerification.UnitNumber := if(l.country = Constants.Switzerland, l.unit_number, '');
			self.SwitzerlandVerification.city := if(l.country = Constants.Switzerland, UCase(l.city), '');
			self.SwitzerlandVerification.PostalCode := if(l.country = Constants.Switzerland, l.postal_code, '');
			self.SwitzerlandVerification.Telephone := if(l.country = Constants.Switzerland, l.telephone, '');
			
			//UnitedKingdomFields
			self.UnitedKingdomVerification.FirstName := if(l.country = Constants.UnitedKingdom, UCase(l.first_name), '');
			self.UnitedKingdomVerification.MiddleName := if(l.country = Constants.UnitedKingdom, UCase(l.middle_name), '');
			self.UnitedKingdomVerification.LastName := if(l.country = Constants.UnitedKingdom, UCase(l.last_name), '');
			self.UnitedKingdomVerification.YearOfBirth := if(l.country = Constants.UnitedKingdom, l.dob[1..4], '');
			self.UnitedKingdomVerification.MonthOfBirth := if(l.country = Constants.UnitedKingdom, l.dob[6..7], '');
			self.UnitedKingdomVerification.DayOfBirth := if(l.country = Constants.UnitedKingdom, l.dob[9..10], '');
			self.UnitedKingdomVerification.StreetName := if(l.country = Constants.UnitedKingdom, UCase(l.street_name), '');
			self.UnitedKingdomVerification.StreetType := if(l.country = Constants.UnitedKingdom, UCase(l.street_type), '');
			self.UnitedKingdomVerification.BuildingName := if(l.country = Constants.UnitedKingdom, UCase(l.building_name), '');
			self.UnitedKingdomVerification.BuildingNumber := if(l.country = Constants.UnitedKingdom, UCase(l.building_number), '');
			self.UnitedKingdomVerification.UnitNumber := if(l.country = Constants.UnitedKingdom, l.unit_number, '');
			self.UnitedKingdomVerification.City := if(l.country = Constants.UnitedKingdom, UCase(l.city), '');
			self.UnitedKingdomVerification.PostalCode := if(l.country = Constants.UnitedKingdom, l.postal_code, '');
			self.UnitedKingdomVerification.Telephone := if(l.country = Constants.UnitedKingdom, l.telephone, '');
			
			self.TransactionTimestamp := if(i = 1, iesp.ECL2ESP.toTimeStamp(l.date_added[1..4] + l.date_added[6..7] + l.date_added[9..10] + ' ' +
																						 l.date_added[12..13] + l.date_added[15..16]	+ l.date_added[18..19]),
																						 iesp.ECL2ESP.toTimeStamp(l.date_added));
			
			SELF := L;
			Self := [];
		END;

		EXPORT Layouts.denorm_searchNameAddr FillNamesAddrsFromAKRecs(InstantID_Archiving.Layout_Base l) := 
			TRANSFORM
				use_first_addr := TRIM(l.prim_name) != '';
				
				SELF.transactionid := StringLib.StringToUppercase(l.Transaction_Id); 
				SELF.Name := iesp.ECL2ESP.SetName(StringLib.StringToUppercase(l.fname), '',
																					StringLib.StringToUppercase(l.lname), '', '', '');				
				tmpAddr := Address.Addr1FromComponents(
															StringLib.StringToUppercase(IF( use_first_addr, l.prim_range, l.prim_range2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.predir, l.predir2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.prim_name, l.prim_name2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.addr_suffix, l.addr_suffix2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.postdir, l.postdir2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.unit_desig, l.unit_desig2)),
															StringLib.StringToUppercase(IF( use_first_addr, l.sec_range, l.sec_range2 )));
				
				SELF.Address := iesp.ECL2ESP.SetUniversalAddress(StringLib.StringToUppercase(IF( use_first_addr, l.prim_name, l.prim_name2 )), 
															StringLib.StringToUppercase(IF( use_first_addr, l.prim_range, l.prim_range2 )), 
															StringLib.StringToUppercase(IF( use_first_addr, l.predir, l.predir2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.postdir, l.postdir2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.addr_suffix, l.addr_suffix2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.unit_desig, l.unit_desig2)) ,
															StringLib.StringToUppercase(IF( use_first_addr, l.sec_range, l.sec_range2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.v_city_name, l.v_city_name2 )),
															StringLib.StringToUppercase(IF( use_first_addr, l.st, l.st2 )),
															if(l.product <> Constants.InstantIdIntrnatl, StringLib.StringToUppercase(IF( use_first_addr, l.zip5, l.zip52 )),''),'','',
															if(l.product = Constants.InstantIdIntrnatl, StringLib.StringToUppercase(IF( use_first_addr, l.zip5, l.zip52 )), ''),// postal code
															tmpAddr	,
														  '',  '', '',  '', false); 																		
				SELF.TransactionTimestamp := iesp.ECL2ESP.toTimeStamp(l.date_added); 
				SELF.queryId := l.query_id;		
				SELF.uniqueId := l.unique_Id;
				SELF := L;
			END;	

//-------------------Report Transforms-------------------------------------//	
		EXPORT Layouts.denorm_inputandblobs denorm_report_AK_inputandblobs(Layouts.Report_DeNormed_Records l) := TRANSFORM
			SELF.TransactionTimestamp := iesp.ECL2ESP.toTimeStamp(l.date_added); 
			SELF.transactionid := StringLib.StringToUppercase(l.transactionid);
			SELF.queryid := l.queryid;
			SELF.Header := iesp.ECL2ESP.GetHeaderRow();
			SELF := L;
		END;	
		
		EXPORT Layouts.denorm_IIDI2_inputandblobs denorm_report_IIDI2_Keys_inputandblobs(Layouts.Report_DeNormed_Records l) := TRANSFORM
			SELF.TransactionTimestamp := iesp.ECL2ESP.toTimeStamp(l.date_added); 
			SELF.transactionid := StringLib.StringToUppercase(l.transactionid);
			SELF.queryid := l.queryid;
			SELF.Header := iesp.ECL2ESP.GetHeaderRow();
			SELF := L;
		END;
		
		EXPORT Layouts.denorm_IIDI2_inputandblobs denorm_report_IIDI2_DB_inputandblobs(Layouts.Report_DeNormed_Records l) := TRANSFORM
			SELF.TransactionTimestamp := iesp.ECL2ESP.toTimeStamp(l.date_added[1..4] + l.date_added[6..7] + l.date_added[9..10] + ' ' + l.date_added[12..13] +
                                l.date_added[15..16]     + l.date_added[18..19]);
			SELF.transactionid := StringLib.StringToUppercase(l.transactionid);
			SELF.queryid := l.queryid;
			SELF.Header := iesp.ECL2ESP.GetHeaderRow();
			SELF := L;
		END;
		
		EXPORT Layouts.denorm_inputandblobs denorm_report_inputandblobs(Layouts.Report_DeNormed_Records l) := TRANSFORM
			SELF.TransactionTimestamp := iesp.ECL2ESP.toTimeStamp(l.date_added[1..4] + l.date_added[6..7] + l.date_added[9..10] + ' ' + l.date_added[12..13] +
																			l.date_added[15..16]	+ l.date_added[18..19]);				
			SELF.transactionid := StringLib.StringToUppercase(l.transactionid);
			SELF.queryid := l.queryid;
			SELF.Header := iesp.ECL2ESP.GetHeaderRow();
			SELF := L;
		END;			
		//StringLib.StringToUppercase is done in Functions on Input
		EXPORT iesp.iidsinglereport.t_InstantIDArchiveSingleReportSearchBy InputToBeEchoed(Layouts.Layout_in L) := TRANSFORM
				SELF.Name := iesp.ECL2ESP.SetName(StringLib.StringToUppercase(l.firstname), '',
																					StringLib.StringToUppercase(l.lastname), '', '', '');
				SELF.Address := iesp.ECL2ESP.SetUniversalAddress(StringLib.StringToUppercase(l.prim_name),
																					StringLib.StringToUppercase(l.prim_range),  '',  '', 
																					StringLib.StringToUppercase(l.suffix),  '',  '', 
																					StringLib.StringToUppercase(l.city),
																					StringLib.StringToUppercase(l.state),
																					StringLib.StringToUppercase(l.zip),  '',  '', 
																					StringLib.StringToUppercase(l.PostalCode),
																					StringLib.StringToUppercase(l.Addr),  '',  '', '',  '', false); 
				SELF.dob := iesp.ECL2ESP.toDatestring8(L.dob);
				SELF := L;
		END;
		
	// -----------------------------------[ Fraud Point ]-----------------------------------	
		EXPORT Layouts.FraudPt_slim xfm_GetFraudPtRpt(Layouts.FraudPt_Records l) := TRANSFORM 
			SELF.Risk_code := l.risk_code;
			SELF.score := l.score;
			int_score := (INTEGER) SELF.score;
			SELF.type := map(int_score <= 300 => 2, 
											int_score > 300 and int_score < 400 => 3,
											int_score >=400 and int_score < 500 => 4, 
											int_score >=500 and int_score < 600 => 5,
											int_score >=600 and int_score < 700 => 6,
											int_score >=700 => 7, 
											0);// 0 should never be hit
			SELF.cnt := 0;
			SELF.Description := l.description;
			SELF.transaction_id := l.transaction_id;
			SELF.score_type := l.score_type;
			self := [];
		END;
		
		EXPORT Layouts.FraudPt_slim xfm_GetFraudPtRpt_50(Layouts.FraudPt_Records l) := TRANSFORM 
			SELF.Risk_code := l.risk_code;
			SELF.score := l.score;
			int_score := (INTEGER) SELF.score;
			SELF.type := map(int_score <= 10 => 2, 
											int_score > 10 and int_score <= 20 => 3,
											int_score > 20 and int_score <= 30 => 4, 
											int_score > 30 and int_score <= 40 => 5,
											int_score > 40 and int_score <= 50 => 6,
											0);// 0 should never be hit
			SELF.cnt := 0;
			SELF.Description := l.description;
			SELF.transaction_id := l.transaction_id;
			SELF.score_type := l.score_type;
			self := [];
		END;
		
		EXPORT Layouts.FraudPt_slim xfm_GetFraudPtRpt_90(Layouts.FraudPt_Records l) := TRANSFORM 
			SELF.Risk_code := l.risk_code;
			SELF.score := l.score;
			int_score := (INTEGER) SELF.score;
			SELF.type := map(int_score <= 10 => 2, 
											int_score > 10 and int_score <= 20 => 3,
											int_score > 20 and int_score <= 30 => 4, 
											int_score > 30 and int_score <= 40 => 5,
											int_score > 40 and int_score <= 50 => 6,
											int_score > 50 and int_score <= 60 => 7,
											int_score > 60 and int_score <= 70 => 8,
											int_score > 70 and int_score <= 80 => 9,
											int_score > 80 and int_score <= 90 => 10,
											0);// 0 should never be hit
			SELF.cnt := 0;
			SELF.Description := l.description;
			SELF.transaction_id := l.transaction_id;
			SELF.score_type := l.score_type;
			self := [];
		END;
END;