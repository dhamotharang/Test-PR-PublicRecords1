import iesp, Seed_Files, Address, risk_indicators, RiskWise, VerificationOfOccupancy;

// for now this only supports a single input record -- that's what the fcradataservice restricts too...

EXPORT Report_TestSeed_Function(DATASET(Seed_Files.VerificationOfOccupancy_report_layouts.in_key ) inData,
																STRING32 TestDataTableName_in) := FUNCTION
		
		

	
	
	
	Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout getSearchKey(Seed_Files.VerificationOfOccupancy_report_layouts.in_key  le) := TRANSFORM
	 self.Seq := le.Seq;
		self.dataset_name := TestDataTableName_in;

		self.hashkey := Seed_Files.Hash_InstantID(
															trim((string15)stringlib.stringtouppercase(le.fname)),
															trim((string20)stringlib.stringtouppercase(le.lname)),
															trim((string9)le.in_ssn),
															risk_indicators.nullstring,
															trim((string9)(le.zip)),
															trim((string10)le.hphone),
															risk_indicators.nullstring
															);
	self := [];														
	END;
	
	inrecs := project(inData, getSearchKey(LEFT));
	
	
	Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout getSummary(Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout le, Seed_Files.VerificationOfOccupancy_Report_keys.Summary rt) := TRANSFORM
	 self.seq := (integer)le.seq;
		Self.Report.summary.uniqueid := rt.uniqueid;
		self.Report.summary.name.full := rt.summary_full;
		self.Report.summary.name.first := rt.summary_first;
  self.Report.summary.name.middle := rt.summary_middle;
	 self.Report.summary.name.last := rt.summary_last;
	 self.Report.summary.name.suffix:= rt.summary_suffix;
	 self.Report.summary.name.prefix:= rt.summary_prefix;
		
		self.Report.summary.CurrentAddress.address.streetnumber:= rt.summary_CurrentAddress_streetnumber;
		self.Report.summary.CurrentAddress.address.streetpredirection:= rt.summary_CurrentAddress_streetpredirection;
		self.Report.summary.CurrentAddress.address.streetname:= rt.summary_CurrentAddress_streetname;
		self.Report.summary.CurrentAddress.address.streetsuffix:= rt.summary_CurrentAddress_streetsuffix;
		self.Report.summary.CurrentAddress.address.streetpostdirection:= rt.summary_CurrentAddress_streetpostdirection;
		self.Report.summary.CurrentAddress.address.unitdesignation:= rt.summary_CurrentAddress_unitdesignation;
		self.Report.summary.CurrentAddress.address.unitnumber:= rt.summary_CurrentAddress_unitnumber;
		self.Report.summary.CurrentAddress.address.streetaddress1:= rt.summary_CurrentAddress_streetaddress1;
		self.Report.summary.CurrentAddress.address.streetaddress2:= rt.summary_CurrentAddress_streetaddress2;
		self.Report.summary.CurrentAddress.address.city:= rt.summary_CurrentAddress_city;
		self.Report.summary.CurrentAddress.address.state:= rt.summary_CurrentAddress_state;
		self.Report.summary.CurrentAddress.address.zip5:= rt.summary_CurrentAddress_zip5;
		self.Report.summary.CurrentAddress.address.zip4:= rt.summary_CurrentAddress_zip4;
		self.Report.summary.CurrentAddress.address.county:= rt.summary_CurrentAddress_county;
		self.Report.summary.CurrentAddress.address.postalcode:= rt.summary_CurrentAddress_postalcode;
		self.Report.summary.CurrentAddress.address.statecityzip:= rt.summary_CurrentAddress_statecityzip;
		
		self.Report.summary.CurrentAddress.residentialorbusiness:= rt.summary_CurrentAddress_residentialorbusiness;
	 self.Report.summary.CurrentAddress._type:= rt.summary_CurrentAddress_type;
	 self.Report.summary.CurrentAddress.mixeduse:= rt.summary_CurrentAddress_mixeduse;
		
	 
		
		highriskindicators1 := project(rt, transform(iesp.share.t_RiskIndicator,
																																	self.riskcode:= rt.summary_CurrentAddress_highriskindicators1_riskcode;
																																	self.description := rt.summary_CurrentAddress_highriskindicators1_description;																	
			));				

			highriskindicators2 := project(rt, transform(iesp.share.t_RiskIndicator,
																																	self.riskcode:= rt.summary_ssn_highriskindicators2_riskcode;
																																	self.description := rt.summary_ssn_highriskindicators2_description;
			));				
					
			self.Report.summary.CurrentAddress.highriskindicators := highriskindicators1 + highriskindicators2 ;
		
		
		
		
		self.Report.summary.ssn.ssn:= rt.summary_ssn_ssn;
	 self.Report.summary.ssn.valid:= rt.summary_ssn_valid;
	 self.Report.summary.ssn.issuedlocation:= rt.summary_ssn_issuedlocation;
		
		self.Report.summary.ssn.issuedstartdate.year:= rt.summary_ssn_issuedstartdate_year;
		self.Report.summary.ssn.issuedstartdate.month:= rt.summary_ssn_issuedstartdate_month;
		self.Report.summary.ssn.issuedstartdate.day:= rt.summary_ssn_issuedstartdate_day;
		
		self.Report.summary.ssn.issuedenddate.year:= rt.summary_ssn_issuedenddate_year;
		self.Report.summary.ssn.issuedenddate.month:= rt.summary_ssn_issuedenddate_month;
		self.Report.summary.ssn.issuedenddate.day:= rt.summary_ssn_issuedenddate_day;
	
	  ssnhighriskindicators1 := project(rt, transform(iesp.share.t_RiskIndicator,
																																	self.riskcode:= rt.summary_ssn_highriskindicators1_riskcode;
																																	self.description := rt.summary_ssn_highriskindicators1_description;																	
			));				

		 ssnhighriskindicators2 := project(rt, transform(iesp.share.t_RiskIndicator,
																																	self.riskcode:= rt.summary_ssn_highriskindicators2_riskcode;
																																	self.description := rt.summary_ssn_highriskindicators2_description;
			));				
					
			self.Report.summary.ssn.highriskindicators := ssnhighriskindicators1 + ssnhighriskindicators2 ;
														
		
	Phones1 := project(rt, transform(iesp.dirassistwireless.t_DirAssistWirelessSearchRecord,
																				self.AlsoFound := rt.summary_phones1_alsofound;
																				self.telcordiaonly:= rt.summary_phones1_telcordiaonly;
																				self.typeflag:= rt.summary_phones1_typeflag;
																				self.uniqueid:= rt.summary_phones1_uniqueid;
																				self.name.full:= rt.summary_phones1_name_full;
																				self.name.first:= rt.summary_phones1_name_first;
																				self.name.middle:= rt.summary_phones1_name_middle;
																				self.name.last:= rt.summary_phones1_name_last;
																				self.name.suffix:= rt.summary_phones1_name_suffix;
																				self.name.prefix:= rt.summary_phones1_name_prefix;
																				self.Address.streetnumber:= rt.summary_phones1_Address_streetnumber;
																				self.Address.streetpredirection:= rt.summary_phones1_Address_streetpredirection;
																				self.Address.streetname:= rt.summary_phones1_Address_streetname;
																				self.Address.streetsuffix:= rt.summary_phones1_Address_streetsuffix;
																				self.Address.streetpostdirection:= rt.summary_phones1_Address_streetpostdirection;
																				self.Address.unitdesignation:= rt.summary_phones1_Address_unitdesignation;
																				self.Address.unitnumber:= rt.summary_phones1_Address_unitnumber;
																				self.Address.streetaddress1:= rt.summary_phones1_Address_streetAddress1;
																				self.Address.streetAddress2:= rt.summary_phones1_Address_streetAddress2;
																				self.Address.city:= rt.summary_phones1_Address_city;
																				self.Address.state:= rt.summary_phones1_Address_state;
																				self.Address.zip5:= rt.summary_phones1_Address_zip5;
																				self.Address.zip4:= rt.summary_phones1_Address_zip4;
																				self.Address.county:= rt.summary_phones1_Address_county;
																				self.Address.postalcode:= rt.summary_phones1_Address_postalcode;
																				self.Address.statecityzip:= rt.summary_phones1_Address_statecityzip;
																				self.companyname:= rt.summary_phones1_companyname;
																				self.listedname:= rt.summary_phones1_listedname;
																				self.phone10:= rt.summary_phones1_phone10;
																				self.timezone:= rt.summary_phones1_timezone;
											
																					
 listingtypes1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																										self.value := rt.summary_phones1_listingtypes1_value));
	listingtypes2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																										self.value :=rt.summary_phones1_listingtypes2_value));
														     self.listingtypes := listingtypes1 + listingtypes2;
											
																			self.captiontext:= rt.summary_phones1_captiontext;
																					
																			self.CentralOfficeCode := project(rt, transform(iesp.dirassistwireless.t_CentralOfficeCode,
																																																						self.Code:= rt.summary_phones1_centralofficecode_code;
	Descriptions1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																											self.value := rt.summary_phones1_centralofficecode_descriptions1_value));
	Descriptions2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																											self.value := rt.summary_phones1_centralofficecode_descriptions2_value));
																											self.Descriptions := Descriptions1 + Descriptions2;
																						));
																					
																					
																					
																				self.SpecialServiceCode := project(rt, transform(iesp.dirassistwireless.t_SpecialServiceCode,
																																																        self.Code:= rt.summary_phones1_SpecialServiceCode_code;
	descriptions1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																											self.value := rt.summary_phones1_SpecialServiceCode_descriptions1_value));
	descriptions2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																											self.value := rt.summary_phones1_SpecialServiceCode_descriptions2_value));
																											self.descriptions := descriptions1 + descriptions2;
																	  ));				
																					

																				self.dialindicator:= rt.summary_phones1_dialindicator;
																				self.phoneregion.city :=rt.summary_phones1_phoneregion_city;
																				self.phoneregion.state := rt.summary_phones1_phoneregion_state;
																				self.carriername:= rt.summary_phones1_carriername;
																				self.isconfirmed:= rt.summary_phones1_isconfirmed;
																				self.listednameverified:= rt.summary_phones1_listednameverified;
																				self.newtype:= rt.summary_phones1_newtype;
																				self.vendorid:= rt.summary_phones1_vendorid;
																				self.datefirstseen.year:= rt.summary_phones1_datefirstseen_year;
																				self.datefirstseen.month:= rt.summary_phones1_datefirstseen_month;
																				self.datefirstseen.day:= rt.summary_phones1_datefirstseen_day;
																				self.datelastseen.year:= rt.summary_phones1_datelastseen_year;
																				self.datelastseen.month:= rt.summary_phones1_datelastseen_month;
																				self.datelastseen.day:= rt.summary_phones1_datelastseen_day;
																				self.phonefeedback.feedbackcount:= rt.summary_phones1_phonefeedback_feedbackcount;
																				self.phonefeedback.lastfeedbackresult:= rt.summary_phones1_phonefeedback_lastfeedbackresult;
																				self.phonefeedback.lastfeedbackresultprovided:= rt.summary_phones1_phonefeedback_lastfeedbackresultprovided;
																				self.addressfeedback.feedbackcount:= rt.summary_phones1_addressfeedback_feedbackcount;
																				self.addressfeedback.lastfeedbackresult:= rt.summary_phones1_addressfeedback_lastfeedbackresult;
																				self.addressfeedback.lastfeedbackresultprovided:= rt.summary_phones1_addressfeedback_lastfeedbackresultprovided;
																				self.realtimephoneinfo.callerid:= rt.summary_phones1_realtimephoneinfo_callerid;
																				self.realtimephoneinfo.status.code:= rt.summary_phones1_realtimephoneinfo_status_code;
																				self.realtimephoneinfo.status.description:= rt.summary_phones1_realtimephoneinfo_status_description;
																				self.realtimephoneinfo.porting.code:= rt.summary_phones1_realtimephoneinfo_porting_code;
																				self.realtimephoneinfo.porting.description:= rt.summary_phones1_realtimephoneinfo_porting_description;
																				self.realtimephoneinfo.operatingcompany.number :=rt.summary_phones1_realtimephoneinfo_operatingcompany_number;
																				self.realtimephoneinfo.operatingcompany.name := rt.summary_phones1_realtimephoneinfo_operatingcompany_name;
																				self.realtimephoneinfo.operatingcompany.affiliatedto := rt.summary_phones1_realtimephoneinfo_operatingcompany_affiliatedto;
																				self.realtimephoneinfo.operatingcompany.address.streetnumber := rt.summary_phones1_realtimephoneinfo_operatingcompany_address_streetnumber;
																				self.realtimephoneinfo.operatingcompany.address.streetpredirection:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_streetpredirection;
																				self.realtimephoneinfo.operatingcompany.address.streetname:=  rt.summary_phones1_realtimephoneinfo_operatingcompany_address_streetname ;
																				self.realtimephoneinfo.operatingcompany.address.streetsuffix:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_streetsuffix;
																				self.realtimephoneinfo.operatingcompany.address.streetpostdirection:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_streetpostdirection;
																				self.realtimephoneinfo.operatingcompany.address.unitdesignation:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_unitdesignation;
																				self.realtimephoneinfo.operatingcompany.address.unitnumber:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_unitnumber;
																				self.realtimephoneinfo.operatingcompany.address.streetaddress1:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_streetaddress1;
																				self.realtimephoneinfo.operatingcompany.address.streetaddress2:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_streetaddress2;
																				self.realtimephoneinfo.operatingcompany.address.city:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_city;
																				self.realtimephoneinfo.operatingcompany.address.state:=  rt.summary_phones1_realtimephoneinfo_operatingcompany_address_state ;
																				self.realtimephoneinfo.operatingcompany.address.zip5:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_zip5;
																				self.realtimephoneinfo.operatingcompany.address.zip4:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_zip4;
																				self.realtimephoneinfo.operatingcompany.address.county:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_county;
																				self.realtimephoneinfo.operatingcompany.address.postalcode:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_postalcode;
																				self.realtimephoneinfo.operatingcompany.address.statecityzip:= rt.summary_phones1_realtimephoneinfo_operatingcompany_address_statecityzip;
																				self.realtimephoneinfo.operatingcompany.phone.phonenpa   := rt.summary_phones1_realtimephoneinfo_operatingcompany_phone_phonenpa;
																				self.realtimephoneinfo.operatingcompany.phone.phonenxx   := rt.summary_phones1_realtimephoneinfo_operatingcompany_phone_phonenxx;
																				self.realtimephoneinfo.operatingcompany.phone.phoneline  := rt.summary_phones1_realtimephoneinfo_operatingcompany_phone_phoneline;
																				self.realtimephoneinfo.operatingcompany.phone.phoneext 	:= rt.summary_phones1_realtimephoneinfo_operatingcompany_phone_phoneext;
																				self.realtimephoneinfo.operatingcompany.phone.faxnpa 	:= rt.summary_phones1_realtimephoneinfo_operatingcompany_phone_faxnpa;
																				self.realtimephoneinfo.operatingcompany.phone.faxnxx     := rt.summary_phones1_realtimephoneinfo_operatingcompany_phone_faxnxx;
																				self.realtimephoneinfo.operatingcompany.phone.faxline    := rt.summary_phones1_realtimephoneinfo_operatingcompany_phone_faxline;
																				self.realtimephoneinfo.operatingcompany.contact.email  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_email;																					
																				self.realtimephoneinfo.operatingcompany.contact.name.full := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_name_full;
																				self.realtimephoneinfo.operatingcompany.contact.name.first := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_name_first;
																				self.realtimephoneinfo.operatingcompany.contact.name.middle := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_name_middle;
																				self.realtimephoneinfo.operatingcompany.contact.name.last := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_name_last;
																				self.realtimephoneinfo.operatingcompany.contact.name.suffix := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_name_suffix;
																				self.realtimephoneinfo.operatingcompany.contact.name.prefix := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_name_prefix;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetnumber  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetnumber ;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetpredirection  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetpredirection   ;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetname  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetname;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetsuffix  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetsuffix ;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetpostdirection  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetpostdirection ;
																				self.realtimephoneinfo.operatingcompany.contact.address.unitdesignation  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_unitdesignation ;
																				self.realtimephoneinfo.operatingcompany.contact.address.unitnumber  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_unitnumber ;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetaddress1  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetaddress1;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetaddress2  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetaddress2;
																				self.realtimephoneinfo.operatingcompany.contact.address.city  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_city ;
																				self.realtimephoneinfo.operatingcompany.contact.address.state  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_state ;
																				self.realtimephoneinfo.operatingcompany.contact.address.zip5  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_zip5;
																				self.realtimephoneinfo.operatingcompany.contact.address.zip4  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_zip4 ;
																				self.realtimephoneinfo.operatingcompany.contact.address.county  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_county ;
																				self.realtimephoneinfo.operatingcompany.contact.address.postalcode  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_postalcode ;
																				self.realtimephoneinfo.operatingcompany.contact.address.statecityzip  := rt.summary_phones1_realtimephoneinfo_operatingcompany_contact_address_statecityzip ;					
																				self.realtimephoneinfo.listingcreationdate.year:= rt.summary_phones1_realtimephoneinfo_listingcreationdate_year;
																				self.realtimephoneinfo.listingcreationdate.month:= rt.summary_phones1_realtimephoneinfo_listingcreationdate_month;
																				self.realtimephoneinfo.listingcreationdate.day:= rt.summary_phones1_realtimephoneinfo_listingcreationdate_day;
																				self.realtimephoneinfo.ListingTransactionDate.year:= rt.summary_phones1_realtimephoneinfo_ListingTransactionDate_year;
																				self.realtimephoneinfo.ListingTransactionDate.month:= rt.summary_phones1_realtimephoneinfo_ListingTransactionDate_month;
																				self.realtimephoneinfo.ListingTransactionDate.day:= rt.summary_phones1_realtimephoneinfo_ListingTransactionDate_day;
																			 self.realtimephoneinfo.statusflag.code:= rt.summary_phones1_realtimephoneinfo_statusflag_code ;
																				self.realtimephoneinfo.statusflag.description:= rt.summary_phones1_realtimephoneinfo_statusflag_description ;
																				self.realtimephoneinfo.privacyindicator:= rt.summary_phones1_realtimephoneinfo_privacyindicator ;
																				self.realtimephoneinfo.datasource:= rt.summary_phones1_realtimephoneinfo_datasource ;
																				self.realtimephoneinfo.latitude:= rt.summary_phones1_realtimephoneinfo_latitude ;
																				self.realtimephoneinfo.longitude:= rt.summary_phones1_realtimephoneinfo_longitude ;
																				self.realtimephoneinfo.fips:= rt.summary_phones1_realtimephoneinfo_fips ;
																				self.realtimephoneinfo.listingtype:= rt.summary_phones1_realtimephoneinfo_listingtype ;
																			 self.ssn:= rt.summary_phones1_ssn ;
																			 self.ssnmatch:= rt.summary_phones1_ssnmatch ;
																				self.dod.year:= rt.summary_phones1_dod_year ;
																				self.dod.month:= rt.summary_phones1_dod_month ;
																				self.dod.day:= rt.summary_phones1_dod_day ;
																			 self.deceased:= rt.summary_phones1_deceased ;
																			 self.yellowflag:= rt.summary_phones1_yellowflag ;
																				self.probablecurrentaddress:= rt.summary_phones1_probablecurrentaddress ;
																				
	hriaddress1 := project(rt, transform(iesp.dirassistwireless.t_DAWHighRiskIndicator,
																																							self.Code:= rt.summary_phones1_hriaddress1_Code;
																																							self.description := rt.summary_phones1_hriaddress1_description;																	
																	  ));								
																				
																				self.hriaddress  := hriaddress1;
																				
														
	hriphone1 := project(rt, transform(iesp.dirassistwireless.t_DAWHighRiskIndicator,
																						self.Code:= rt.summary_phones1_hriaddress1_Code;
																						self.description := rt.summary_phones1_hriaddress1_description;																	
																			));				
																				
																				
																				self.hriphone  := hriphone1;
																				
														
																				
	highriskindicators1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_RiskIndicator,
																																self.riskCode:= rt.summary_phones1_highriskindicators1_riskCode;
																																self.description := rt.summary_phones1_highriskindicators1_description;																	
																																));				
																				
																				
	highriskindicators2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_RiskIndicator,
																																self.riskCode:= rt.summary_phones1_highriskindicators2_riskCode;
																																self.description := rt.summary_phones1_highriskindicators2_description;
																																));				
																				
																			self.highriskindicators  := highriskindicators1 + highriskindicators2 ;
																				
																						));
	
	Phones2 := project(rt, transform(iesp.dirassistwireless.t_DirAssistWirelessSearchRecord,
																				self.AlsoFound := rt.summary_phones2_alsofound;
																				self.telcordiaonly:= rt.summary_phones2_telcordiaonly;
																				self.typeflag:= rt.summary_phones2_typeflag;
																				self.uniqueid:= rt.summary_phones2_uniqueid;
																				self.name.full:= rt.summary_phones2_name_full;
																				self.name.first:= rt.summary_phones2_name_first;
																				self.name.middle:= rt.summary_phones2_name_middle;
																				self.name.last:= rt.summary_phones2_name_last;
																				self.name.suffix:= rt.summary_phones2_name_suffix;
																				self.name.prefix:= rt.summary_phones2_name_prefix;
																				self.Address.streetnumber:= rt.summary_phones2_Address_streetnumber;
																				self.Address.streetpredirection:= rt.summary_phones2_Address_streetpredirection;
																				self.Address.streetname:= rt.summary_phones2_Address_streetname;
																				self.Address.streetsuffix:= rt.summary_phones2_Address_streetsuffix;
																				self.Address.streetpostdirection:= rt.summary_phones2_Address_streetpostdirection;
																				self.Address.unitdesignation:= rt.summary_phones2_Address_unitdesignation;
																				self.Address.unitnumber:= rt.summary_phones2_Address_unitnumber;
																				self.Address.streetaddress1:= rt.summary_phones2_Address_streetAddress1;
																				self.Address.streetAddress2:= rt.summary_phones2_Address_streetAddress2;
																				self.Address.city:= rt.summary_phones2_Address_city;
																				self.Address.state:= rt.summary_phones2_Address_state;
																				self.Address.zip5:= rt.summary_phones2_Address_zip5;
																				self.Address.zip4:= rt.summary_phones2_Address_zip4;
																				self.Address.county:= rt.summary_phones2_Address_county;
																				self.Address.postalcode:= rt.summary_phones2_Address_postalcode;
																				self.Address.statecityzip:= rt.summary_phones2_Address_statecityzip;
																				self.companyname:= rt.summary_phones2_companyname;
																				self.listedname:= rt.summary_phones2_listedname;
																				self.phone10:= rt.summary_phones2_phone10;
																				self.timezone:= rt.summary_phones2_timezone;
	listingtypes1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																										self.value := rt.summary_phones2_listingtypes1_value));
	listingtypes2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																										self.value :=rt.summary_phones2_listingtypes2_value));
																				self.listingtypes := listingtypes1 + listingtypes2;
																				self.captiontext:= rt.summary_phones2_captiontext;
																			 self.centralofficecode.code:= rt.summary_phones2_centralofficecode_code;
																				self.CentralOfficeCode := project(rt, transform(iesp.dirassistwireless.t_CentralOfficeCode,
																																																						self.Code:= rt.summary_phones2_centralofficecode_code;
	Descriptions1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																										self.value := rt.summary_phones2_centralofficecode_descriptions1_value));
	Descriptions2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																										self.value := rt.summary_phones2_centralofficecode_descriptions2_value));
																										self.Descriptions := Descriptions1 + Descriptions2;
																										));
																				
																				self.specialservicecode.code:= rt.summary_phones2_specialservicecode_code;
																				self.SpecialServiceCode := project(rt, transform(iesp.dirassistwireless.t_SpecialServiceCode,
																				self.Code:= rt.summary_phones2_SpecialServiceCode_code;
	descriptions1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																										self.value := rt.summary_phones2_SpecialServiceCode_descriptions1_value));
	descriptions2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_StringArrayItem,
																										self.value := rt.summary_phones2_SpecialServiceCode_descriptions2_value));
																										self.descriptions := descriptions1 + descriptions2;
																										));				

																				self.dialindicator:= rt.summary_phones2_dialindicator;
																				self.phoneregion.city :=rt.summary_phones2_phoneregion_city;
																				self.phoneregion.state := rt.summary_phones2_phoneregion_state;
																				self.carriername:= rt.summary_phones2_carriername;
																				self.isconfirmed:= rt.summary_phones2_isconfirmed;
																				self.listednameverified:= rt.summary_phones2_listednameverified;
																				self.newtype:= rt.summary_phones2_newtype;
																				self.vendorid:= rt.summary_phones2_vendorid;
																				self.datefirstseen.year:= rt.summary_phones2_datefirstseen_year;
																				self.datefirstseen.month:= rt.summary_phones2_datefirstseen_month;
																				self.datefirstseen.day:= rt.summary_phones2_datefirstseen_day;
																				self.datelastseen.year:= rt.summary_phones2_datelastseen_year;
																				self.datelastseen.month:= rt.summary_phones2_datelastseen_month;
																				self.datelastseen.day:= rt.summary_phones2_datelastseen_day;
																				self.phonefeedback.feedbackcount:= rt.summary_phones2_phonefeedback_feedbackcount;
																				self.phonefeedback.lastfeedbackresult:= rt.summary_phones2_phonefeedback_lastfeedbackresult;
																				self.phonefeedback.lastfeedbackresultprovided:= rt.summary_phones2_phonefeedback_lastfeedbackresultprovided;
																				self.addressfeedback.feedbackcount:= rt.summary_phones2_addressfeedback_feedbackcount;
																				self.addressfeedback.lastfeedbackresult:= rt.summary_phones2_addressfeedback_lastfeedbackresult;
																				self.addressfeedback.lastfeedbackresultprovided:= rt.summary_phones2_addressfeedback_lastfeedbackresultprovided;
																				self.realtimephoneinfo.callerid:= rt.summary_phones2_realtimephoneinfo_callerid;
																				self.realtimephoneinfo.status.code:= rt.summary_phones2_realtimephoneinfo_status_code;
																				self.realtimephoneinfo.status.description:= rt.summary_phones2_realtimephoneinfo_status_description;
																				self.realtimephoneinfo.porting.code:= rt.summary_phones2_realtimephoneinfo_porting_code;
																				self.realtimephoneinfo.porting.description:= rt.summary_phones2_realtimephoneinfo_porting_description;
																				self.realtimephoneinfo.operatingcompany.number :=rt.summary_phones2_realtimephoneinfo_operatingcompany_number;
																				self.realtimephoneinfo.operatingcompany.name := rt.summary_phones2_realtimephoneinfo_operatingcompany_name;
																				self.realtimephoneinfo.operatingcompany.affiliatedto := rt.summary_phones2_realtimephoneinfo_operatingcompany_affiliatedto;
																				self.realtimephoneinfo.operatingcompany.address.streetnumber := rt.summary_phones2_realtimephoneinfo_operatingcompany_address_streetnumber;
																				self.realtimephoneinfo.operatingcompany.address.streetpredirection:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_streetpredirection;
																				self.realtimephoneinfo.operatingcompany.address.streetname:=  rt.summary_phones2_realtimephoneinfo_operatingcompany_address_streetname ;
																				self.realtimephoneinfo.operatingcompany.address.streetsuffix:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_streetsuffix;
																				self.realtimephoneinfo.operatingcompany.address.streetpostdirection:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_streetpostdirection;
																				self.realtimephoneinfo.operatingcompany.address.unitdesignation:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_unitdesignation;
																				self.realtimephoneinfo.operatingcompany.address.unitnumber:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_unitnumber;
																				self.realtimephoneinfo.operatingcompany.address.streetaddress1:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_streetaddress1;
																				self.realtimephoneinfo.operatingcompany.address.streetaddress2:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_streetaddress2;
																				self.realtimephoneinfo.operatingcompany.address.city:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_city;
																				self.realtimephoneinfo.operatingcompany.address.state:=  rt.summary_phones2_realtimephoneinfo_operatingcompany_address_state ;
																				self.realtimephoneinfo.operatingcompany.address.zip5:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_zip5;
																				self.realtimephoneinfo.operatingcompany.address.zip4:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_zip4;
																				self.realtimephoneinfo.operatingcompany.address.county:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_county;
																				self.realtimephoneinfo.operatingcompany.address.postalcode:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_postalcode;
																				self.realtimephoneinfo.operatingcompany.address.statecityzip:= rt.summary_phones2_realtimephoneinfo_operatingcompany_address_statecityzip;
																				self.realtimephoneinfo.operatingcompany.phone.phonenpa   := rt.summary_phones2_realtimephoneinfo_operatingcompany_phone_phonenpa;
																				self.realtimephoneinfo.operatingcompany.phone.phonenxx   := rt.summary_phones2_realtimephoneinfo_operatingcompany_phone_phonenxx;
																				self.realtimephoneinfo.operatingcompany.phone.phoneline  := rt.summary_phones2_realtimephoneinfo_operatingcompany_phone_phoneline;
																				self.realtimephoneinfo.operatingcompany.phone.phoneext 	:= rt.summary_phones2_realtimephoneinfo_operatingcompany_phone_phoneext;
																				self.realtimephoneinfo.operatingcompany.phone.faxnpa 	:= rt.summary_phones2_realtimephoneinfo_operatingcompany_phone_faxnpa;
																				self.realtimephoneinfo.operatingcompany.phone.faxnxx     := rt.summary_phones2_realtimephoneinfo_operatingcompany_phone_faxnxx;
																				self.realtimephoneinfo.operatingcompany.phone.faxline    := rt.summary_phones2_realtimephoneinfo_operatingcompany_phone_faxline;
																				self.realtimephoneinfo.operatingcompany.contact.email  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_email;																
																				self.realtimephoneinfo.operatingcompany.contact.name.full := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_name_full;
																				self.realtimephoneinfo.operatingcompany.contact.name.first := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_name_first;
																				self.realtimephoneinfo.operatingcompany.contact.name.middle := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_name_middle;
																				self.realtimephoneinfo.operatingcompany.contact.name.last := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_name_last;
																				self.realtimephoneinfo.operatingcompany.contact.name.suffix := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_name_suffix;
																				self.realtimephoneinfo.operatingcompany.contact.name.prefix := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_name_prefix;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetnumber  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetnumber ;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetpredirection  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetpredirection   ;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetname  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetname;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetsuffix  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetsuffix ;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetpostdirection  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetpostdirection ;
																				self.realtimephoneinfo.operatingcompany.contact.address.unitdesignation  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_unitdesignation ;
																				self.realtimephoneinfo.operatingcompany.contact.address.unitnumber  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_unitnumber ;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetaddress1  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetaddress1;
																				self.realtimephoneinfo.operatingcompany.contact.address.streetaddress2  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetaddress2;
																				self.realtimephoneinfo.operatingcompany.contact.address.city  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_city ;
																				self.realtimephoneinfo.operatingcompany.contact.address.state  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_state ;
																				self.realtimephoneinfo.operatingcompany.contact.address.zip5  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_zip5;
																				self.realtimephoneinfo.operatingcompany.contact.address.zip4  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_zip4 ;
																				self.realtimephoneinfo.operatingcompany.contact.address.county  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_county ;
																				self.realtimephoneinfo.operatingcompany.contact.address.postalcode  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_postalcode ;
																				self.realtimephoneinfo.operatingcompany.contact.address.statecityzip  := rt.summary_phones2_realtimephoneinfo_operatingcompany_contact_address_statecityzip ;
																				self.realtimephoneinfo.listingcreationdate.year:= rt.summary_phones2_realtimephoneinfo_listingcreationdate_year ;
																				self.realtimephoneinfo.listingcreationdate.month:= rt.summary_phones2_realtimephoneinfo_listingcreationdate_month ;
																				self.realtimephoneinfo.listingcreationdate.day:= rt.summary_phones2_realtimephoneinfo_listingcreationdate_day ;
																				self.realtimephoneinfo.ListingTransactionDate.year:= rt.summary_phones2_realtimephoneinfo_ListingTransactionDate_year;
																				self.realtimephoneinfo.ListingTransactionDate.month:= rt.summary_phones2_realtimephoneinfo_ListingTransactionDate_month;
																				self.realtimephoneinfo.ListingTransactionDate.day:= rt.summary_phones2_realtimephoneinfo_ListingTransactionDate_day;
																				self.realtimephoneinfo.statusflag.code:= rt.summary_phones2_realtimephoneinfo_statusflag_code ;
																				self.realtimephoneinfo.statusflag.description:= rt.summary_phones2_realtimephoneinfo_statusflag_description ;
																				self.realtimephoneinfo.privacyindicator:= rt.summary_phones2_realtimephoneinfo_privacyindicator ;
																				self.realtimephoneinfo.datasource:= rt.summary_phones2_realtimephoneinfo_datasource ;
																				self.realtimephoneinfo.latitude:= rt.summary_phones2_realtimephoneinfo_latitude ;
																				self.realtimephoneinfo.longitude:= rt.summary_phones2_realtimephoneinfo_longitude ;
																				self.realtimephoneinfo.fips:= rt.summary_phones2_realtimephoneinfo_fips ;
																				self.realtimephoneinfo.listingtype:= rt.summary_phones2_realtimephoneinfo_listingtype ;
																				self.ssn:= rt.summary_phones2_ssn ;
																				self.ssnmatch:= rt.summary_phones2_ssnmatch ;
																				self.dod.year:= rt.summary_phones2_dod_year ;
																				self.dod.month:= rt.summary_phones2_dod_month ;
																				self.dod.day:= rt.summary_phones2_dod_day ;
																				self.deceased:= rt.summary_phones2_deceased ;
																				self.yellowflag:= rt.summary_phones2_yellowflag ;
																				self.probablecurrentaddress:= rt.summary_phones2_probablecurrentaddress ;
	hriaddress1 := project(rt, transform(iesp.dirassistwireless.t_DAWHighRiskIndicator,
																								self.Code:= rt.summary_phones2_hriaddress1_Code;
																								self. description := rt.summary_phones2_hriaddress1_description;																	
																						));				
																				
																				
																				self.hriaddress  := hriaddress1;

	hriphone1 := project(rt, transform(iesp.dirassistwireless.t_DAWHighRiskIndicator,
																							self.Code:= rt.summary_phones2_hriaddress1_Code;
																							self.description := rt.summary_phones2_hriaddress1_description;																	
																	  ));				
																				

																				self.hriphone  := hriphone1;

	highriskindicators1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_RiskIndicator,
																																self.riskCode:= rt.summary_phones2_highriskindicators1_riskCode;
																																self.description := rt.summary_phones2_highriskindicators1_description;																	
																	  ));				
																				
																				
	highriskindicators2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.share.t_RiskIndicator,
																																self.riskCode:= rt.summary_phones2_highriskindicators2_riskCode;
																																self.description := rt.summary_phones2_highriskindicators2_description;
																	  ));				
																				
																				self.highriskindicators  := highriskindicators1 + highriskindicators2 ;
																				
																			));
	
																				self.Report.summary.phones := Phones1 + Phones2;
	
																				self := le;
	END;
	
	VOOSummary := join(inrecs, Seed_Files.VerificationOfOccupancy_Report_keys.Summary,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		getSummary(left, right),
		LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost)
	);
	
	
	
	Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout getTargetSummary(Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout le, Seed_Files.VerificationOfOccupancy_Report_keys.TargetSummary rt) := TRANSFORM

		
	self.Report.TargetSummary.address.streetnumber:=  rt.TargetSummary_address_streetnumber  ;
	self.Report.TargetSummary.address.streetpredirection:=  rt.TargetSummary_address_streetpredirection  ;
	self.Report.TargetSummary.address.streetname:=  rt.TargetSummary_address_streetname  ;
	self.Report.TargetSummary.address.streetsuffix:=  rt.TargetSummary_address_streetsuffix  ;
	self.Report.TargetSummary.address.streetpostdirection:=  rt.TargetSummary_address_streetpostdirection  ;
	self.Report.TargetSummary.address.unitdesignation:=  rt.TargetSummary_address_unitdesignation  ;
	self.Report.TargetSummary.address.unitnumber:=  rt.TargetSummary_address_unitnumber;
	self.Report.TargetSummary.address.streetaddress1:=  rt.TargetSummary_address_streetaddress1  ;
	self.Report.TargetSummary.address.streetaddress2:=  rt.TargetSummary_address_streetaddress2  ;
	self.Report.TargetSummary.address.city:=  rt.TargetSummary_address_city  ;
	self.Report.TargetSummary.address.state:=  rt.TargetSummary_address_state  ;
	self.Report.TargetSummary.address.zip5:=  rt.TargetSummary_address_zip5; 
	self.Report.TargetSummary.address.zip4:=  rt.TargetSummary_address_zip4 ;
	self.Report.TargetSummary.address.county:=  rt.TargetSummary_address_county;
	self.Report.TargetSummary.address.postalcode:=  rt.TargetSummary_address_postalcode;
	self.Report.TargetSummary.address.statecityzip:=  rt.TargetSummary_address_statecityzip;

	self.Report.TargetSummary.residentialorbusiness:=  rt.TargetSummary_residentialorbusiness;
	self.Report.TargetSummary._type:=  rt.TargetSummary_type  ;
	self.Report.TargetSummary.mixeduse:=  rt.TargetSummary_mixeduse ;

	
			highriskindicators1 := project(rt, transform(iesp.share.t_RiskIndicator,
																																																self.riskCode:= rt.TargetSummary_highriskindicators_riskcode1;
																																																self.description := rt.TargetSummary_highriskindicators_description1;																	
																	  ));				
																				
																				
			highriskindicators2 := project(rt, transform(iesp.share.t_RiskIndicator,
																																																self.riskCode:= rt.TargetSummary_highriskindicators_riskcode2;
																																																self.description := rt.TargetSummary_highriskindicators_description2;
																	  ));				
																				
		self.Report.TargetSummary.highriskindicators  := highriskindicators1 + highriskindicators2 ;
																				
																					
	
	
	self.Report.TargetSummary.PropertyType:=  rt.TargetSummary_propertytype  ;
	self.Report.TargetSummary.propertycharacteristics:=  rt.TargetSummary_propertycharacteristics  ;
	
		self := le;
	END;
	
	
VOOAddressTarget := join(VOOSummary, Seed_Files.VerificationOfOccupancy_Report_keys.TargetSummary,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		getTargetSummary(left, right),
		LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost)
	);
	
	
	

	Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout getSources(Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout le, Seed_Files.VerificationOfOccupancy_Report_keys.Sources rt) := TRANSFORM
	
	
		
		source1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOConfirmingSource,
																																																self.Source := rt.source1;
																																																self.from.year:= rt.source1_from_year;
																																																self.from.month := rt.source1_from_month ;																						
																																																self.from.day := rt.source1_from_day;																	
																																																self.to.year := rt.source1_to_year;																	
																																																self.to.month := rt.source1_to_month;																	
																																																self.to.day := rt.source1_to_day;																	
																																																self.count := rt.source1_count;																	
																	  ));																						
	 source2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOConfirmingSource,
																																																self.source:= rt.source2;
																																																self.from.year:= rt.source2_from_year;
																																																self.from.month := rt.source2_from_month ;																	
																																																self.from.day := rt.source2_from_day;																	
																																																self.to.year := rt.source2_to_year;																	
																																																self.to.month := rt.source2_to_month;																	
																																																self.to.day := rt.source2_to_month;	
																																																self.count := rt.source2_count;	
																	  ));				
																				
											self.Report.sources  := source1 + source2 ;
																				

	
		
		self := le;
	
	END;
	
  VOOConfirmingSource := join(VOOAddressTarget, Seed_Files.VerificationOfOccupancy_Report_keys.Sources,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		getSources(left, right),
		LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost)
	);
	
	
	
	
		Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout getOwnedProperties(Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout le, Seed_Files.VerificationOfOccupancy_Report_keys.OwnedProperties rt) := TRANSFORM
 
 OwnedProperties1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOOtherOwnedProperty,
																									self.Address.streetnumber:=  rt.OwnedProperties1_Address_streetnumber  ;
																									self.Address.streetpredirection:=  rt.OwnedProperties1_Address_streetpredirection  ;
																									self.Address.streetname:=  rt.OwnedProperties1_Address_streetname  ;
																									self.Address.streetsuffix:=  rt.OwnedProperties1_Address_streetsuffix  ;
																									self.Address.streetpostdirection:=  rt.OwnedProperties1_Address_streetpostdirection ;
																									self.Address.unitdesignation:=  rt.OwnedProperties1_Address_unitdesignation  ;
																									self.Address.unitnumber:=  rt.OwnedProperties1_Address_unitnumber  ;
																									self.Address.streetAddress1:=  rt.OwnedProperties1_Address_streetAddress1  ;
																									self.Address.streetAddress2:=  rt.OwnedProperties1_Address_streetAddress2  ;
																									self.Address.city:=  rt.OwnedProperties1_Address_city  ;
																									self.Address.state:=  rt.OwnedProperties1_Address_state  ;
																									self.Address.zip5:=  rt.OwnedProperties1_Address_zip5  ;
																									self.Address.zip4:=  rt.OwnedProperties1_Address_zip4  ;
																									self.Address.county:=  rt.OwnedProperties1_Address_county  ;
																									self.Address.postalcode:=  rt.OwnedProperties1_Address_postalcode  ;
																									self.Address.statecityzip:=  rt.OwnedProperties1_Address_statecityzip  ;
																									self.status:=  rt.OwnedProperties1_status  ;
																									self.purchasedate.year:=  rt.OwnedProperties1_purchasedate_year  ;
																									self.purchasedate.month:=  rt.OwnedProperties1_purchasedate_month  ;
																									self.purchasedate.day:=  rt.OwnedProperties1_purchasedate_day  ;
																									self.proximity:=  rt.OwnedProperties1_proximity  ;
																					 ));	

 OwnedProperties2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOOtherOwnedProperty,
																					  self.Address.streetnumber:=  rt.OwnedProperties2_Address_streetnumber  ;
																							self.Address.streetpredirection:=  rt.OwnedProperties2_Address_streetpredirection  ;
																							self.Address.streetname:=  rt.OwnedProperties2_Address_streetname  ;
																							self.Address.streetsuffix:=  rt.OwnedProperties2_Address_streetsuffix  ;
																							self.Address.streetpostdirection:=  rt.OwnedProperties2_Address_streetpostdirection ;
																							self.Address.unitdesignation:=  rt.OwnedProperties2_Address_unitdesignation  ;
																							self.Address.unitnumber:=  rt.OwnedProperties2_Address_unitnumber  ;
																							self.Address.streetAddress1:=  rt.OwnedProperties2_Address_streetAddress1  ;
																							self.Address.streetAddress2:=  rt.OwnedProperties2_Address_streetAddress2  ;
																							self.Address.city:=  rt.OwnedProperties2_Address_city  ;
																							self.Address.state:=  rt.OwnedProperties2_Address_state  ;
																							self.Address.zip5:=  rt.OwnedProperties2_Address_zip5  ;
																							self.Address.zip4:=  rt.OwnedProperties2_Address_zip4  ;
																							self.Address.county:=  rt.OwnedProperties2_Address_county  ;
																							self.Address.postalcode:=  rt.OwnedProperties2_Address_postalcode  ;
																							self.Address.statecityzip:=  rt.OwnedProperties2_Address_statecityzip  ;
																							self.status:=  rt.OwnedProperties2_status  ;
																							self.purchasedate.year:=  rt.OwnedProperties2_purchasedate_year  ;
																							self.purchasedate.month:=  rt.OwnedProperties2_purchasedate_month  ;
																							self.purchasedate.day:=  rt.OwnedProperties2_purchasedate_day  ;
																							self.proximity:=  rt.OwnedProperties2_proximity  ;
																				
																				));	
					self.Report.OwnedProperties  := OwnedProperties1 + OwnedProperties2 ;
																				

	
		
		self := le;
	
	END;
	
	
	
VOOOwnedProperties := join(VOOConfirmingSource, Seed_Files.VerificationOfOccupancy_Report_keys.OwnedProperties,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		getOwnedProperties(left, right),
		LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost)
	);	
	
	
	
	Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout getOwnedPropertiesAsOf(Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout le, Seed_Files.VerificationOfOccupancy_Report_keys.OwnedPropertiesAsOf rt) := TRANSFORM
 
 OwnedPropertiesAsOf1 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOOtherOwnedProperty,
	
																												self.Address.streetnumber:=  rt.OwnedPropertiesAsOf1_Address_streetnumber  ;
																												self.Address.streetpredirection:=  rt.OwnedPropertiesAsOf1_Address_streetpredirection  ;
																												self.Address.streetname:=  rt.OwnedPropertiesAsOf1_Address_streetname  ;
																												self.Address.streetsuffix:=  rt.OwnedPropertiesAsOf1_Address_streetsuffix  ;
																												self.Address.streetpostdirection:=  rt.OwnedPropertiesAsOf1_Address_streetpostdirection  ;
																												self.Address.unitdesignation:=  rt.OwnedPropertiesAsOf1_Address_unitdesignation  ;
																												self.Address.unitnumber:=  rt.OwnedPropertiesAsOf1_Address_unitnumber  ;
																												self.Address.streetAddress1:=  rt.OwnedPropertiesAsOf1_Address_streetAddress1  ;
																												self.Address.streetAddress2:=  rt.OwnedPropertiesAsOf1_Address_streetAddress2  ;
																												self.Address.city:=  rt.OwnedPropertiesAsOf1_Address_city  ;
																												self.Address.state:=  rt.OwnedPropertiesAsOf1_Address_state  ;
																												self.Address.zip5:=  rt. OwnedPropertiesAsOf1_Address_zip5 ; 
																												self.Address.zip4:=  rt.OwnedPropertiesAsOf1_Address_zip4  ;
																												self.Address.county:=  rt.OwnedPropertiesAsOf1_Address_county  ; 
																												self.Address.postalcode:=  rt.OwnedPropertiesAsOf1_Address_postalcode  ;
																												self.Address.statecityzip:=  rt.OwnedPropertiesAsOf1_Address_statecityzip  ;
																												self.status:=  rt.OwnedPropertiesAsOf1_status  ;
																												self.purchasedate.year:=  rt.OwnedPropertiesAsOf1_purchasedate_year  ;
																												self.purchasedate.month:=  rt.OwnedPropertiesAsOf1_purchasedate_month  ;
																												self.purchasedate.day:=  rt.OwnedPropertiesAsOf1_purchasedate_day  ;
																												self.proximity:=  rt.OwnedPropertiesAsOf1_proximity  ;
	));
	OwnedPropertiesAsOf2 := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOOtherOwnedProperty,

																											 self.Address.streetnumber:=  rt.OwnedPropertiesAsOf2_Address_streetnumber  ;
																												self.Address.streetpredirection:=  rt.OwnedPropertiesAsOf2_Address_streetpredirection  ;
																												self.Address.streetname:=  rt.OwnedPropertiesAsOf2_Address_streetname  ;
																												self.Address.streetsuffix:=  rt.OwnedPropertiesAsOf2_Address_streetsuffix  ;
																												self.Address.streetpostdirection:=  rt.OwnedPropertiesAsOf2_Address_streetpostdirection  ;
																												self.Address.unitdesignation:=  rt.OwnedPropertiesAsOf2_Address_unitdesignation  ;
																												self.Address.unitnumber:=  rt.OwnedPropertiesAsOf2_Address_unitnumber  ;
																												self.Address.streetAddress1:=  rt.OwnedPropertiesAsOf2_Address_streetAddress1  ;
																												self.Address.streetAddress2:=  rt.OwnedPropertiesAsOf2_Address_streetAddress2  ;
																												self.Address.city:=  rt.OwnedPropertiesAsOf2_Address_city  ;
																												self.Address.state:=  rt.OwnedPropertiesAsOf2_Address_state  ;
																												self.Address.zip5:=  rt. OwnedPropertiesAsOf2_Address_zip5 ; 
																												self.Address.zip4:=  rt.OwnedPropertiesAsOf2_Address_zip4  ;
																												self.Address.county:=  rt.OwnedPropertiesAsOf2_Address_county  ; 
																												self.Address.postalcode:=  rt.OwnedPropertiesAsOf2_Address_postalcode  ;
																												self.Address.statecityzip:=  rt.OwnedPropertiesAsOf2_Address_statecityzip  ;
																												self.status:=  rt.OwnedPropertiesAsOf2_status  ;
																												self.purchasedate.year:=  rt.OwnedPropertiesAsOf2_purchasedate_year  ;
																												self.purchasedate.month:=  rt.OwnedPropertiesAsOf2_purchasedate_month  ;
																												self.purchasedate.day:=  rt.OwnedPropertiesAsOf2_purchasedate_day  ;
																												self.proximity:=  rt.OwnedPropertiesAsOf2_proximity ; 
	));
	
					self.Report.OwnedPropertiesAsOf  := OwnedPropertiesAsOf1 + OwnedPropertiesAsOf2 ;
	
	
	
		self := le;

	
	end;
	
	
	VOOOwnedPropertiesAsOf := join(VOOOwnedProperties, Seed_Files.VerificationOfOccupancy_Report_keys.OwnedPropertiesAsOf,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		getOwnedPropertiesAsOf(left, right),
		LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost)
	);	 
	
	
	
	
	
	
	Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout getPhoneAndUtility(Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout le, Seed_Files.VerificationOfOccupancy_Report_keys.PhoneAndUtility rt) := TRANSFORM
	
	

targetrecords1:= project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOTargetRecord,

		self.servicetype:=  rt.PhoneAndUtility_targetrecords1_servicetype  ;	
		self.name.full:=  rt.PhoneAndUtility_targetrecords1_name_full  ;
		self.name.first:=  rt.PhoneAndUtility_targetrecords1_name_first  ;
		self.name.middle:=  rt.PhoneAndUtility_targetrecords1_name_middle  ;
		self.name.last:=  rt.PhoneAndUtility_targetrecords1_name_last  ;
		self.name.suffix:=  rt.PhoneAndUtility_targetrecords1_name_suffix  ;
		self.name.prefix:=  rt.PhoneAndUtility_targetrecords1_name_prefix  ;
		self.from.year:=  rt.PhoneAndUtility_targetrecords1_from_year  ;
		self.from.month:=  rt.PhoneAndUtility_targetrecords1_from_month  ;
		self.from.day:=  rt.PhoneAndUtility_targetrecords1_from_day  ;
		self.to.year:=  rt.PhoneAndUtility_targetrecords1_to_year  ;
		self.to.month:=  rt.PhoneAndUtility_targetrecords1_to_month  ;
		self.to.day:=  rt.PhoneAndUtility_targetrecords1_to_day  ;
	 self.uniqueid:=  rt.PhoneAndUtility_targetrecords1_uniqueid  ;
	
		));
	

targetrecords2	:= project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOTargetRecord,
		self.servicetype:=  rt.PhoneAndUtility_targetrecords2_servicetype  ;	
		self.name.full:=  rt.PhoneAndUtility_targetrecords2_name_full  ;
		self.name.first:=  rt.PhoneAndUtility_targetrecords2_name_first  ;
		self.name.middle:=  rt.PhoneAndUtility_targetrecords2_name_middle  ;
		self.name.last:=  rt.PhoneAndUtility_targetrecords2_name_last  ;
		self.name.suffix:=  rt.PhoneAndUtility_targetrecords2_name_suffix  ;
		self.name.prefix:=  rt.PhoneAndUtility_targetrecords2_name_prefix  ;
		self.from.year:=  rt.PhoneAndUtility_targetrecords2_from_year  ;
		self.from.month:=  rt.PhoneAndUtility_targetrecords2_from_month  ;
		self.from.day:=  rt.PhoneAndUtility_targetrecords2_from_day  ;
		self.to.year:=  rt.PhoneAndUtility_targetrecords2_to_year  ;
		self.to.month:=  rt.PhoneAndUtility_targetrecords2_to_month  ;
		self.to.day:=  rt.PhoneAndUtility_targetrecords2_to_day  ;
  self.uniqueid:=  rt.PhoneAndUtility_targetrecords2_uniqueid  ;
	
	
		));
	
					self.Report.PhoneAndUtility.TargetRecords  := targetrecords1 + targetrecords2 ;
	
	
	
	
	
	

subjectrecords1:= project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOSubjectRecord,	
	
	
		self.servicetype := rt.PhoneAndUtility_subjectrecords1_servicetype  ;
		self.Address.streetnumber := rt.PhoneAndUtility_subjectrecords1_Address_streetnumber  ;
		self.Address.streetpredirection := rt.PhoneAndUtility_subjectrecords1_Address_streetpredirection  ;
		self.Address.streetname := rt.PhoneAndUtility_subjectrecords1_Address_streetname  ;
		self.Address.streetsuffix := rt.PhoneAndUtility_subjectrecords1_Address_streetsuffix  ;
		self.Address.streetpostdirection := rt.PhoneAndUtility_subjectrecords1_Address_streetpostdirection  ;
		self.Address.unitdesignation := rt.PhoneAndUtility_subjectrecords1_Address_unitdesignation  ;
		self.Address.unitnumber := rt.PhoneAndUtility_subjectrecords1_Address_unitnumber  ;
		self.Address.streetAddress1 := rt.PhoneAndUtility_subjectrecords1_Address_streetAddress1  ;
		self.Address.streetAddress2 := rt.PhoneAndUtility_subjectrecords1_Address_streetAddress2  ;
		self.Address.city := rt.PhoneAndUtility_subjectrecords1_Address_city  ;
		self.Address.state := rt.PhoneAndUtility_subjectrecords1_Address_state  ;
		self.Address.zip5 := rt.PhoneAndUtility_subjectrecords1_Address_zip5  ;
		self.Address.zip4 := rt.PhoneAndUtility_subjectrecords1_Address_zip4  ;
		self.Address.county := rt.PhoneAndUtility_subjectrecords1_Address_county  ;
		self.Address.postalcode := rt.PhoneAndUtility_subjectrecords1_Address_postalcode  ;
		self.Address.statecityzip := rt.PhoneAndUtility_subjectrecords1_Address_statecityzip  ;
		self.from.year := rt.PhoneAndUtility_subjectrecords1_from_year  ;
		self.from.month := rt.PhoneAndUtility_subjectrecords1_from_month  ;
		self.from.day := rt.PhoneAndUtility_subjectrecords1_from_day  ;
		self.to.year := rt.PhoneAndUtility_subjectrecords1_to_year  ;
		self.to.month := rt.PhoneAndUtility_subjectrecords1_to_month  ;
		self.to.day := rt.PhoneAndUtility_subjectrecords1_to_day  ;
	));
	subjectrecords2:= project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOSubjectRecord,	
	
	
		self.servicetype := rt.PhoneAndUtility_subjectrecords2_servicetype  ;
		self.Address.streetnumber := rt.PhoneAndUtility_subjectrecords2_Address_streetnumber  ;
		self.Address.streetpredirection := rt.PhoneAndUtility_subjectrecords2_Address_streetpredirection  ;
		self.Address.streetname := rt.PhoneAndUtility_subjectrecords2_Address_streetname  ;
		self.Address.streetsuffix := rt.PhoneAndUtility_subjectrecords2_Address_streetsuffix  ;
		self.Address.streetpostdirection := rt.PhoneAndUtility_subjectrecords2_Address_streetpostdirection  ;
		self.Address.unitdesignation := rt.PhoneAndUtility_subjectrecords2_Address_unitdesignation  ;
		self.Address.unitnumber := rt.PhoneAndUtility_subjectrecords2_Address_unitnumber  ;
		self.Address.streetAddress1 := rt.PhoneAndUtility_subjectrecords2_Address_streetAddress1  ;
		self.Address.streetAddress2 := rt.PhoneAndUtility_subjectrecords2_Address_streetAddress2  ;
		self.Address.city := rt.PhoneAndUtility_subjectrecords2_Address_city  ;
		self.Address.state := rt.PhoneAndUtility_subjectrecords2_Address_state  ;
		self.Address.zip5 := rt.PhoneAndUtility_subjectrecords2_Address_zip5  ;
		self.Address.zip4 := rt.PhoneAndUtility_subjectrecords2_Address_zip4  ;
		self.Address.county := rt.PhoneAndUtility_subjectrecords2_Address_county  ;
		self.Address.postalcode := rt.PhoneAndUtility_subjectrecords2_Address_postalcode  ;
		self.Address.statecityzip := rt.PhoneAndUtility_subjectrecords2_Address_statecityzip  ;
		self.from.year := rt.PhoneAndUtility_subjectrecords2_from_year  ;
		self.from.month := rt.PhoneAndUtility_subjectrecords2_from_month  ;
		self.from.day := rt.PhoneAndUtility_subjectrecords2_from_day  ;
		self.to.year := rt.PhoneAndUtility_subjectrecords2_to_year  ;
		self.to.month := rt.PhoneAndUtility_subjectrecords2_to_month  ;
		self.to.day := rt.PhoneAndUtility_subjectrecords2_to_day  ;	
		
			));
	self.Report.PhoneAndUtility.subjectrecords  := subjectrecords1 + subjectrecords2 ;	

	
	self := le;
	
	end;
	
	
	
	
	
	VOOPhoneAndUtility := join(VOOOwnedPropertiesAsOf, Seed_Files.VerificationOfOccupancy_Report_keys.PhoneAndUtility,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		getPhoneAndUtility(left, right),
		LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost)
	);	
	
	
	
	
	
	Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout getAssociatedIdentities(Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout le, Seed_Files.VerificationOfOccupancy_Report_keys.AssociatedIdentities rt) := TRANSFORM
	
	
	AssociatedIdentities1:= project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOIdentity,	 
	
	self.uniqueid:= rt.AssociatedIdentities1_uniqueid  ;
	self.name.full:= rt.AssociatedIdentities1_name_full  ;
	self.name.first:= rt.AssociatedIdentities1_name_first  ;
	self.name.middle := rt.AssociatedIdentities1_name_middle  ;
	self.name.last:= rt.AssociatedIdentities1_name_last  ;
	self.name.suffix:= rt.AssociatedIdentities1_name_suffix  ;
	self.name.prefix:= rt.AssociatedIdentities1_name_prefix  ;
	self.from.year:= rt.AssociatedIdentities1_from_year  ;
	self.from.month:= rt.AssociatedIdentities1_from_month  ;
	self.from.day:= rt.AssociatedIdentities1_from_day  ;
	self.to.year:= rt.AssociatedIdentities1_to_year  ;
	self.to.month:= rt. AssociatedIdentities1_to_month ;
	self.to.day := rt.AssociatedIdentities1_to_day  ;
 self.association:= rt.AssociatedIdentities1_association  ;
 
 		));
 
  AssociatedIdentities2:= project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.verificationofoccupancy.t_VOOIdentity,	 
	
	self.uniqueid:= rt.AssociatedIdentities2_uniqueid  ;
	self.name.full:= rt.AssociatedIdentities2_name_full  ;
	self.name.first:= rt.AssociatedIdentities2_name_first  ;
	self.name.middle := rt.AssociatedIdentities2_name_middle  ;
	self.name.last:= rt.AssociatedIdentities2_name_last  ;
	self.name.suffix:= rt.AssociatedIdentities2_name_suffix  ;
	self.name.prefix:= rt.AssociatedIdentities2_name_prefix  ;
	self.from.year:= rt.AssociatedIdentities2_from_year  ;
	self.from.month:= rt.AssociatedIdentities2_from_month  ;
	self.from.day:= rt.AssociatedIdentities2_from_day  ;
	self.to.year:= rt.AssociatedIdentities2_to_year  ;
	self.to.month:= rt. AssociatedIdentities2_to_month ;
	self.to.day := rt.AssociatedIdentities2_to_day  ;
 self.association:= rt.AssociatedIdentities2_association  ;
 
	
	
			));
	self.Report.AssociatedIdentities  := AssociatedIdentities1 + AssociatedIdentities2 ;	

	
	self := le;
	
	end;
	
	
	VOOAssociatedIdentities := join(VOOPhoneAndUtility, Seed_Files.VerificationOfOccupancy_Report_keys.AssociatedIdentities,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		getAssociatedIdentities(left, right),
		LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost)
	);	
	
	

	
	

	
	
return VOOAssociatedIdentities;
	END;
	