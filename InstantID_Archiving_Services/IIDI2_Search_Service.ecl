/*--SOAP--
<message name="InstantIDArchiveSearchRequest"  wuTimeout="300000">	
	<part name="gateways" 						type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name="_CompanyId"  					type="xsd:string"/>
	<part name="InstantIDIntl2ArchiveSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/

IMPORT iesp, InstantID_Archiving_Services;

EXPORT IIDI2_Search_Service := MACRO

  // rec_in     := iesp.iidarchivesearch.t_InstantIDArchiveSearchRequest;
  rec_in     := iesp.iidi2archivesearch.t_InstantIDIntl2ArchiveSearchRequest;
	ds_in      := DATASET([],rec_in) : STORED('InstantIDIntl2ArchiveSearchRequest',few);	

  first_row := ds_in[1] : INDEPENDENT;

	search_by := GLOBAL (first_row.SearchBy);
	
	input_params := AutoStandardI.GlobalModule();
	tempmod := MODULE(PROJECT(input_params, InstantID_Archiving_Services.IParam.IIDI2_search_params, opt));
		// EXPORT string		ProductType   := search_options.ProductType;
		EXPORT STRING		QueryId       := search_by.QueryId;
		EXPORT STRING		CompanyId     := first_row.user.CompanyId : STORED('_CompanyId');	
		Shared String2	CountryCode		:= StringLib.StringToUppercase(search_by.Country);
		EXPORT STRING2	CountryId			:= StringLib.StringToUppercase(search_by.Country);	
		
		EXPORT Unicode	NewFirstName	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Austria => search_by.AustriaVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.GivenNames,
																					CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Ireland => search_by.IrelandVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Luxembourg => search_by.LuxembourgVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Netherlands => search_by.NetherlandsVerification.GivenNames,
																					CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.Switzerland => search_by.SwitzerlandVerification.FirstName,
																					CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.FirstName,
																																			''
																				);
		EXPORT Unicode	NewMiddleName	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.MiddleName,
																					CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.MiddleName,
																					CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.MiddleName,
																					CountryCode = InstantID_Archiving_Services.Constants.Ireland => search_by.IrelandVerification.MiddleName,
																					CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.FirstSurname,
																					CountryCode = InstantID_Archiving_Services.Constants.Netherlands => search_by.NetherlandsVerification.MiddleName,
																					CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.MiddleName,
																					CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.MiddleName,
																					CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.MiddleName,
																																			''
																				);
		EXPORT Unicode	NewLastName		:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.Austria => search_by.AustriaVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.Surname,
																					CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.Ireland => search_by.IrelandVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.Surname,
																					CountryCode = InstantID_Archiving_Services.Constants.Luxembourg => search_by.LuxembourgVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.SecondSurname,
																					CountryCode = InstantID_Archiving_Services.Constants.Netherlands => search_by.NetherlandsVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.Switzerland => search_by.SwitzerlandVerification.LastName,
																					CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.LastName,
																																			''
																				);
		EXPORT Unicode	FullName	:= map( CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.ChinesePersonalName,
																																	'');//unparsedfullname
																																			
		EXPORT Unicode	MaidenName	:= map( CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.MaidenName,
																																			'');
		EXPORT STRING		IGender		:= map( CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.Gender,
																			CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.Gender,
																			CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.Gender,
																			CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.Gender,
																			CountryCode = InstantID_Archiving_Services.Constants.Switzerland => search_by.SwitzerlandVerification.Gender,
																																	''
																		);
		EXPORT Unicode	StreetAddress1	:= map( CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.Address1,
																						CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.Address1,
																						CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.Address1,
																																				''
																					);
		EXPORT Unicode		StreetAddress2	:= map( CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.Address2,
																																					''
																				);
		EXPORT STRING		UnitNumber	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.UnitNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.UnitNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.UnitNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.RoomNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.UnitNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.UnitNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.BlockNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.Switzerland => search_by.SwitzerlandVerification.UnitNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.UnitNumber,
																																		''
																			);
		EXPORT Unicode	BuildingNumber	:= map( CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.BuildingNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.BuildingNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.Netherlands => search_by.NetherlandsVerification.HouseExtension,
																						CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.BuildingNumber,
																																				''
																					);
		EXPORT Unicode	BuildingName	:= map( CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.BuildingName,
																					CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.BuildingName,
																					CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.BuildingName,
																					CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.BuildingName,
																					CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.BuildingName,
																																			''
																				);
		EXPORT STRING		FloorNumber	:= map( CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.FloorNumber,
																																		''
																			);
		EXPORT Unicode		StreetNumber	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.StreetNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.Austria => search_by.AustriaVerification.HouseNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.StreetNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.CivicNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.StreetNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.HouseNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.AreaNumbers,
																						CountryCode = InstantID_Archiving_Services.Constants.Luxembourg => search_by.LuxembourgVerification.HouseNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.Netherlands => search_by.NetherlandsVerification.HouseNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.HouseNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.StreetNumber,
																						CountryCode = InstantID_Archiving_Services.Constants.Switzerland => search_by.SwitzerlandVerification.BuildingNumber,
																																				''
																					);
		EXPORT Unicode	StreetName	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.Austria => search_by.AustriaVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.Luxembourg => search_by.LuxembourgVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.Netherlands => search_by.NetherlandsVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.Switzerland => search_by.SwitzerlandVerification.StreetName,
																				CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.StreetName,
																																		''
																			);
		EXPORT Unicode	StreetType	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.StreetType,
																				CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.StreetType,
																				CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.StreetType,
																				CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.StreetType,
																				CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.StreetType,
																				CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.StreetType,
																																		''
																			);
		EXPORT Unicode	Suburb	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.Suburb,
																		CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.Suburb,
																		CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.Province,
																		CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.Aza,
																		CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.Suburb,
																		CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.Suburb,
																																''
																	);
		EXPORT Unicode	ICity	:= map( CountryCode = InstantID_Archiving_Services.Constants.Austria => search_by.AustriaVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.Municipality,
																	CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.Ireland => search_by.IrelandVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.Municipality,
																	CountryCode = InstantID_Archiving_Services.Constants.Luxembourg => search_by.LuxembourgVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.Netherlands => search_by.NetherlandsVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.Switzerland => search_by.SwitzerlandVerification.City,
																	CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.City,
																															''
																);
		EXPORT Unicode	District	:= map( CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.District,
																			CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.District,
																																	''
																		);
		EXPORT Unicode	ICounty	:= map( CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.Province,
																		CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.County,
																		CountryCode = InstantID_Archiving_Services.Constants.Ireland => search_by.IrelandVerification.County,
																		CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.Prefecture,
																		CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.Province,
																																''
																	);
		EXPORT Unicode	IState	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.State,
																		CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.State,
																		CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.State,
																																''
																	);
		EXPORT STRING	Postal_Code	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Austria => search_by.AustriaVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Luxembourg => search_by.LuxembourgVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Netherlands => search_by.NetherlandsVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.Switzerland => search_by.SwitzerlandVerification.PostalCode,
																			CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.PostalCode,
																																	''
																		);
		EXPORT STRING		IPhone	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Austria => search_by.AustriaVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Germany => search_by.GermanyVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Ireland => search_by.IrelandVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Japan => search_by.JapanVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Luxembourg => search_by.LuxembourgVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Netherlands => search_by.NetherlandsVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.Switzerland => search_by.SwitzerlandVerification.Telephone,
																		CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => search_by.UnitedKingdomVerification.Telephone,
																																''
																	);
		EXPORT STRING		MobilePhone	:= map( CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.CellNumber,
																																		''
																		);
		EXPORT STRING		WorkPhone	:= map( CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.WorkTelephone,
																																	''
																		);
		EXPORT String	DateOfBirth	:= map(	CountryCode = InstantID_Archiving_Services.Constants.Australia => trim(search_by.AustraliaVerification.YearOfBirth) + '-' + trim(search_by.AustraliaVerification.MonthOfBirth) + '-' + trim(search_by.AustraliaVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Austria => trim(search_by.AustriaVerification.YearOfBirth) + '-' + trim(search_by.AustriaVerification.MonthOfBirth) + '-' + trim(search_by.AustriaVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Brazil => trim(search_by.BrazilVerification.YearOfBirth) + '-' + trim(search_by.BrazilVerification.MonthOfBirth) + '-' + trim(search_by.BrazilVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Canada => trim(search_by.CanadaVerification.YearOfBirth) + '-' + trim(search_by.CanadaVerification.MonthOfBirth) + '-' + trim(search_by.CanadaVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.China => trim(search_by.ChinaVerification.YearOfBirth) + '-' + trim(search_by.ChinaVerification.MonthOfBirth) + '-' + trim(search_by.ChinaVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Germany => trim(search_by.GermanyVerification.YearOfBirth) + '-' + trim(search_by.GermanyVerification.MonthOfBirth) + '-' + trim(search_by.GermanyVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.HongKong => trim(search_by.HongKongVerification.YearOfBirth) + '-' + trim(search_by.HongKongVerification.MonthOfBirth) + '-' + trim(search_by.HongKongVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Ireland => trim(search_by.IrelandVerification.YearOfBirth) + '-' + trim(search_by.IrelandVerification.MonthOfBirth) + '-' + trim(search_by.IrelandVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Japan => trim(search_by.JapanVerification.YearOfBirth) + '-' + trim(search_by.JapanVerification.MonthOfBirth) + '-' + trim(search_by.JapanVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Luxembourg => trim(search_by.LuxembourgVerification.YearOfBirth) + '-' + trim(search_by.LuxembourgVerification.MonthOfBirth) + '-' + trim(search_by.LuxembourgVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Mexico => trim(search_by.MexicoVerification.YearOfBirth) + '-' + trim(search_by.MexicoVerification.MonthOfBirth) + '-' + trim(search_by.MexicoVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Netherlands => trim(search_by.NetherlandsVerification.YearOfBirth) + '-' + trim(search_by.NetherlandsVerification.MonthOfBirth) + '-' + trim(search_by.NetherlandsVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.NewZealand => trim(search_by.NewZealandVerification.YearOfBirth) + '-' + trim(search_by.NewZealandVerification.MonthOfBirth) + '-' + trim(search_by.NewZealandVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Singapore => trim(search_by.SingaporeVerification.YearOfBirth) + '-' + trim(search_by.SingaporeVerification.MonthOfBirth) + '-' + trim(search_by.SingaporeVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => trim(search_by.SouthAfricaVerification.YearOfBirth) + '-' + trim(search_by.SouthAfricaVerification.MonthOfBirth) + '-' + trim(search_by.SouthAfricaVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.Switzerland => trim(search_by.SwitzerlandVerification.YearOfBirth) + '-' + trim(search_by.SwitzerlandVerification.MonthOfBirth) + '-' + trim(search_by.SwitzerlandVerification.DayofBirth),
																			CountryCode = InstantID_Archiving_Services.Constants.UnitedKingdom => trim(search_by.UnitedKingdomVerification.YearOfBirth) + '-' + trim(search_by.UnitedKingdomVerification.MonthOfBirth) + '-' + trim(search_by.UnitedKingdomVerification.DayofBirth),
																																	'--'
																		);
		EXPORT STRING		NationalId	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.RTACardNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.Brazil => search_by.BrazilVerification.NationalIDNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.Canada => search_by.CanadaVerification.SocialInsuranceNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.NationalIDNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.HongKong => search_by.HongKongVerification.HongKongIDNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.Ireland => search_by.IrelandVerification.PersonalPublicServiceNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.Mexico => search_by.MexicoVerification.CURPIDNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.Singapore => search_by.SingaporeVerification.NricNumber,
																				CountryCode = InstantID_Archiving_Services.Constants.SouthAfrica => search_by.SouthAfricaVerification.NationalIDNumber,
																																		''
																			);
		EXPORT Unicode	NationalId_City_Issued	:= map( CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.CityOfIssue,
																																								''
																									);
		EXPORT Unicode	NationalId_District_Issued	:= map( CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.DistrictOfIssue,
																																										''
																											);
		EXPORT Unicode	NationalId_County_Issued	:= map( CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.CountyOfIssue,
																																									''
																										);
		EXPORT Unicode	NationalId_Province_Issued	:= map( CountryCode = InstantID_Archiving_Services.Constants.China => search_by.ChinaVerification.ProvinceOfIssue,
																																								''
																									);
		EXPORT STRING	IDL_Number	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.DriverLicenceNumber,
																			CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.DriverLicenceNumber,
																																	''
																		);
		EXPORT STRING	DL_Version_Number	:= map( CountryCode = InstantID_Archiving_Services.Constants.NewZealand => search_by.NewZealandVerification.DriverLicenceVersionNumber,
																																				''
																					);
		EXPORT STRING	IDL_State	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.DriverLicenceState,
																																''
																	);
		EXPORT STRING	DL_Expire_Date	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia =>
																																trim(search_by.AustraliaVerification.YearOfExpiry) + '-' +
																																trim(search_by.AustraliaVerification.MonthOfExpiry) + '-' +
																																trim(search_by.AustraliaVerification.DayOfExpiry),
																																'--'
																				);
		EXPORT STRING	Passport_Number	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.Passport.PassportNumber,
																																			''
																				);
		EXPORT STRING	Passport_Expire_Date	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia =>
																																			trim(search_by.AustraliaVerification.Passport.PassportYearOfExpiry) + '-' +
																																			trim(search_by.AustraliaVerification.Passport.PassportMonthOfExpiry) + '-' +
																																			trim(search_by.AustraliaVerification.Passport.PassportDayOfExpiry),
																																			'--'
																								);
		EXPORT Unicode	Passport_Place_Birth	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.Passport.PlaceOfBirth,
																																							''
																					      );
		EXPORT Unicode	Passport_Country_Birth	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.Passport.CountryOfBirth,
																																								''
																									);
		EXPORT Unicode	Passport_Family_Name_Birth	:= map( CountryCode = InstantID_Archiving_Services.Constants.Australia => search_by.AustraliaVerification.Passport.FamilyNameatBirth,
																																										''
																											);
	END;
	
	// Gateway configurations
	dGateways := Gateway.Configuration.Get();
	
	results :=	InstantID_Archiving_Services.IIDI2_Search_Records.doSingleSearch(tempmod, dGateways);					
	
	output(results, named('Results'));
	
ENDMACRO;
