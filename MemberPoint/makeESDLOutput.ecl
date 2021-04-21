 import iesp, Suppress,std,lib_date;

EXPORT iesp.keepcontactreport.t_KeepContactReportResponse makeESDLOutput(dataset(MemberPoint.Layouts.BatchOut) BatchOut,
																																							iesp.keepcontactreport.t_KeepContactReportBy report_by, 
																																							string input_ssn_mask_value,string includedob,
																																							unsigned1 input_dob_mask_value) := function


			iesp.keepcontactreport.t_KeepContactEmail normXformEMAILS(MemberPoint.Layouts.BatchOut L,integer c) := transform
			
				self.EmailAddress := map(
																	c = 1 => l.EMAIL1,
																	c = 2 => l.EMAIL2,
																	c = 3 => l.EMAIL3,
																	c = 4 => l.EMAIL4,
																	c = 5 => l.EMAIL5,
																	c = 6 => l.EMAIL6,
																	c = 7 => l.EMAIL7,
																	c = 8 => l.EMAIL8,
																	c = 9 => l.EMAIL9,
																	c = 10=> l.EMAIL10,
																	''
																	) ;
				self.DateFirstSeen := map(
															c = 1 =>iesp.ECL2ESP.toDatestring8(L.email1_date_first_seen),
															c = 2 =>iesp.ECL2ESP.toDatestring8(L.email2_date_first_seen),
															c = 3 =>iesp.ECL2ESP.toDatestring8(L.email3_date_first_seen),
															c = 4 =>iesp.ECL2ESP.toDatestring8(L.email4_date_first_seen),
															c = 5 =>iesp.ECL2ESP.toDatestring8(L.email5_date_first_seen),
															c = 6 =>iesp.ECL2ESP.toDatestring8(L.email6_date_first_seen),
															c = 7 =>iesp.ECL2ESP.toDatestring8(L.email7_date_first_seen),
															c = 8 =>iesp.ECL2ESP.toDatestring8(L.email8_date_first_seen),
															c = 9 =>iesp.ECL2ESP.toDatestring8(L.email9_date_first_seen),
															c = 10=>iesp.ECL2ESP.toDatestring8(L.email10_date_first_seen)	,
															        iesp.ECL2ESP.toDatestring8('')															
														 ) ;
				self.DateLastSeen := map(
																	c = 1 =>iesp.ECL2ESP.toDatestring8(L.email1_date_LAST_seen),
															   c = 2 => iesp.ECL2ESP.toDatestring8(L.email2_date_LAST_seen),
															   c = 3 => iesp.ECL2ESP.toDatestring8(L.email3_date_LAST_seen),
															   c = 4 => iesp.ECL2ESP.toDatestring8(L.email4_date_LAST_seen),
															   c = 5 => iesp.ECL2ESP.toDatestring8(L.email5_date_LAST_seen),
															   c = 6 => iesp.ECL2ESP.toDatestring8(L.email6_date_LAST_seen),
															   c = 7 => iesp.ECL2ESP.toDatestring8(L.email7_date_LAST_seen),
															   c = 8 => iesp.ECL2ESP.toDatestring8(L.email8_date_LAST_seen),
															   c = 9 => iesp.ECL2ESP.toDatestring8(L.email9_date_LAST_seen),
																 c = 10 =>iesp.ECL2ESP.toDatestring8(L.email10_date_LAST_seen),
															            iesp.ECL2ESP.toDatestring8('')
																	) ;
															
				self.status := map(
																	c = 1 => l.EMAIL1_EMAIL_STATUS,
																	c = 2 => l.EMAIL2_EMAIL_STATUS,
																	c = 3 => l.EMAIL3_EMAIL_STATUS,
																	c = 4 => l.EMAIL4_EMAIL_STATUS,
																	c = 5 => l.EMAIL5_EMAIL_STATUS,
																	c = 6 => l.EMAIL6_EMAIL_STATUS,
																	c = 7 => l.EMAIL7_EMAIL_STATUS,
																	c = 8 => l.EMAIL8_EMAIL_STATUS,
																	c = 9 => l.EMAIL9_EMAIL_STATUS,
																	c = 10 =>l.EMAIL10_EMAIL_STATUS,
																	''
																	) ;
				self.StatusReason := map(
																	 c = 1 => L.EMAIL1_EMAIL_status_reason,
																	 c = 2 => L.EMAIL2_EMAIL_status_reason,
																	 c = 3 => L.EMAIL3_EMAIL_status_reason,
																	 c = 4 => L.EMAIL4_EMAIL_status_reason,
																	 c = 5 => L.EMAIL5_EMAIL_status_reason,
																	 c = 6 => L.EMAIL6_EMAIL_status_reason,
																	 c = 7 => L.EMAIL7_EMAIL_status_reason,
																	 c = 8 => L.EMAIL8_EMAIL_status_reason,
																	 c = 9 => L.EMAIL9_EMAIL_status_reason,
																	 c = 10 =>L.EMAIL10_EMAIL_status_reason,
																	 ''
																	 ) ;
															
				self.additionalstatusinfo := map(
																	c = 1 =>  L.EMAIL1_additional_status_info,
																	c = 2 =>  L.EMAIL2_additional_status_info,
																	c = 3 =>  L.EMAIL3_additional_status_info,
																	c = 4 =>  L.EMAIL4_additional_status_info,
																	c = 5 =>  L.EMAIL5_additional_status_info,
																	c = 6 =>  L.EMAIL6_additional_status_info,
																	c = 7 =>  L.EMAIL7_additional_status_info,
																	c = 8 =>  L.EMAIL8_additional_status_info,
																	c = 9 =>  L.EMAIL9_additional_status_info,
																	c = 10 => L.EMAIL10_additional_status_info,
																	''
																	);
				
			end;
			
			iesp.keepcontactreport.t_KeepContactPhoneInfo normXformPhones(MemberPoint.Layouts.BatchOut L,integer c) := transform
			
				self.MatchCode := map(
																	c = 1 => l.Phone1_Match_Codes,
																	c = 2 => l.Phone2_Match_Codes,
																					 l.Phone3_Match_Codes
																	) ;
				self.Phone := map(
															c = 1 => l.Phone1_Number,
															c = 2 => l.Phone2_Number,
																			 l.Phone3_Number
														 ) ;
				self.ListingName.full := map(
																	c = 1 => 	l.Phone1_Number_Listing_Name,
																	c = 2 => 	l.Phone2_Number_Listing_Name,
																						l.Phone3_Number_Listing_Name
																	) ;
				self.ListingName := [];													
				self.PossibleRelation := map(
																	c = 1 => l.Phone1_Possible_Relation,
																	c = 2 => l.Phone2_Possible_Relation,
																					 l.Phone3_Possible_Relation
																	) ;
				self.DateFirstSeen := map(
																	c = 1 => iesp.ECL2ESP.toDatestring8(L.Phone1_First_Seen_Date),
																	c = 2 => iesp.ECL2ESP.toDatestring8(L.Phone2_First_Seen_Date),
																					 iesp.ECL2ESP.toDatestring8(L.Phone3_First_Seen_Date)
																	) ;
				self.DateLastSeen := map(
																	c = 1 =>  iesp.ECL2ESP.toDatestring8(L.Phone1_Last_Seen_Date),
																	c = 2 =>  iesp.ECL2ESP.toDatestring8(L.Phone2_Last_Seen_Date),
																						iesp.ECL2ESP.toDatestring8(L.Phone3_Last_Seen_Date)
																	) ;
				self.PhoneType := map(
																	c = 1 => l.Phone1_Type,
																	c = 2 => l.Phone2_Type,
																					 l.Phone3_Type
																	) ;
				self.LineType := map(
																	c = 1 =>	l.Phone1_Line_Type,
																	c = 2 => 	l.Phone2_Line_Type,
																						l.Phone3_Line_Type
																	) ;
				// Removed the below field as it was deprecated per latest iesp interface/layout
/* 				self.Confidence := map(
																	c = 1 => l.Phone1_Score_confidence,
																	c = 2 => l.Phone2_Score_confidence,
																					 l.Phone3_Score_confidence
																	) ; */
				
/* 				self.Score :=  map(
   																	c = 1 => l.Phone1_Score,
   																	c = 2 => l.Phone2_Score,
   																					 l.Phone3_Score
   																	) ;
*/
					SELF.ConfidenceScore := MAP(c = 1 => l.Phone1_Score_confidence_star,
																			c = 2 => l.Phone2_Score_confidence_star,
																			l.Phone3_Score_confidence_star) ;
					SELF.Carrier := MAP(c = 1 => l.Phone1_Carrier,
															c = 2 => l.Phone2_Carrier,
															l.Phone3_Carrier) ;
					SELF.CarrierCity := MAP(c = 1 => l.Phone1_Carrier_City,
																	c = 2 => l.Phone2_Carrier_City,
																	l.Phone3_Carrier_City) ;
					SELF.CarrierState:= MAP(c = 1 => l.Phone1_Carrier_State,
																	c = 2 => l.Phone2_Carrier_State,
																	l.Phone3_Carrier_State) ;
					
					SELF.Status:= MAP(c = 1 => l.Phone1_Phone_Status,
														c = 2 => l.Phone2_Phone_Status,
														l.Phone3_Phone_Status);
			end;


		  iesp.share.t_StringArrayItem normXformAddressDescriptionCodes(MemberPoint.Layouts.BatchOut l,integer c) := transform
				self.value:= CHOOSE(c, l.addressdescriptioncode1, l.addressdescriptioncode2, l.addressdescriptioncode3, l.addressdescriptioncode4, l.addressdescriptioncode5,l.addressdescriptioncode6, l.addressdescriptioncode7, l.addressdescriptioncode8, l.addressdescriptioncode9, l.addressdescriptioncode10, '');
			end;
      
			PhonesChild := normalize(BatchOut,3,normXformPhones(left,counter));
			EmailChild := normalize(BatchOut,10,normXformEmails(left,counter));
			AddressDescriptionCodes:=normalize(BatchOut,10,normXformAddressDescriptionCodes(left,counter));
			header_row 	 :=  iesp.ECL2ESP.GetHeaderRow();

			 iesp.keepcontactreport.t_KeepContactReportResponse xformESDL(BatchOut l) := transform
			 
			  self._Header :=  project(header_row, transform(iesp.share.t_ResponseHeader,
													self.status :=  left.status,
													self := left));
				self.InputEcho	:= report_by;
				self.Member.SearchName.Full := l.LN_search_name;
				self.Member.SearchName := [];
				self.Member.SearchNameType := l.LN_search_name_type;
				self.Member.UniqueId := (string) l.did;
				self.Member.UniqueIdConfidenceScore := (string) l.did_score ;
				self.Member.Gender := l.gender;
				self.Member.BestInfo.Name.full  := l.name;
				self.Member.BestInfo.SSN  := Suppress.ssn_mask(l.ssn,input_ssn_mask_value);
				DOB_Pre										:= iesp.ECL2ESP.toMaskableDatestring8(L.DOB);
				self.Member.BestInfo.DOB  := iesp.ECL2ESP.ApplyDateStringMask (DOB_Pre ,input_dob_mask_value,true);
				//self.Member.BestInfo.DOB  :=  iesp.ECL2ESP.toDatestring8(L.DOB);
				self.Member.BestInfo.AddressMatchCodes  :=  l.address_match_codes  ;
				self.Member.BestInfo.Address.StreetNumber := '';
				self.Member.BestInfo.Address.StreetPreDirection  := '';
				self.Member.BestInfo.Address.StreetName  := '';
				self.Member.BestInfo.Address.StreetSuffix  := '';
				self.Member.BestInfo.Address.StreetPostDirection  := '';
				self.Member.BestInfo.Address.UnitDesignation  := '';
				self.Member.BestInfo.Address.UnitNumber  := '';
				self.Member.BestInfo.Address.StreetAddress1 :=  l.address;
				self.Member.BestInfo.Address.StreetAddress2  := '';
				self.Member.BestInfo.Address.City := l.city;
				self.Member.BestInfo.Address.State := l.st;
				self.Member.BestInfo.Address.Zip5 := l.z5;
				self.Member.BestInfo.Address.Zip4 := l.zip4;
				self.Member.BestInfo.Address.County := l.county_name;
				self.Member.BestInfo.Address.PostalCode := '';
				self.Member.BestInfo.Address.StateCityZip := '';
				self.Member.BestInfo.Address.Latitude := l.Latitude;
				self.Member.BestInfo.Address.Longitude := l.Longitude;
				self.Member.BestInfo.AddressOlderThan90Days :=  l.addr_older_than_90_days;
				self.Member.BestInfo.DateFirstSeen :=  iesp.ECL2ESP.toDatestring8(L.addr_dt_first_seen);
				self.Member.BestInfo.DateLastSeen :=  iesp.ECL2ESP.toDatestring8(L.addr_dt_last_seen);
				// Removed the below field as it was deprecated per latest iesp interface/layout
				// self.Member.BestInfo.AddressConfidence :=  l.addr_confidence;
				self.Member.BestInfo.NameScore := l.name_score;
				self.Member.BestInfo.SSNScore := l.ssn_score;
				self.Member.BestInfo.DOBScore := l.dob_score;
				self.Member.BestInfo := [];
				self.Member.PossibleNewAddress.Address.StreetNumber := '' ;
				self.Member.PossibleNewAddress.Address.StreetPreDirection := '' ;
				self.Member.PossibleNewAddress.Address.StreetName := '' ;
				self.Member.PossibleNewAddress.Address.StreetSuffix := '' ;
				self.Member.PossibleNewAddress.Address.StreetPostDirection := '' ;
				self.Member.PossibleNewAddress.Address.UnitDesignation := '' ;
				self.Member.PossibleNewAddress.Address.UnitNumber := '' ;
				self.Member.PossibleNewAddress.Address.StreetAddress1 := l.address_new;
				self.Member.PossibleNewAddress.Address.StreetAddress2 := '' ;
				self.Member.PossibleNewAddress.Address.City := l.city_new;
				self.Member.PossibleNewAddress.Address.State := l.st_new;
				self.Member.PossibleNewAddress.Address.Zip5 := l.z5_new;
				self.Member.PossibleNewAddress.Address.Zip4 := l.zip4_new;
				self.Member.PossibleNewAddress.Address.County := l.county_name_new ;
				self.Member.PossibleNewAddress.Address.PostalCode := '' ;
				self.Member.PossibleNewAddress.Address.StateCityZip := '' ;
				self.Member.PossibleNewAddress.Address.Latitude := l.Latitude_new ;
				self.Member.PossibleNewAddress.Address.Longitude := l.Longitude_new ;				
				self.Member.PossibleNewAddress.AddressMatchCodes :=  l.address_new_match_codes  ;
				// Removed the below field as it was deprecated per latest iesp interface/layout
				// self.Member.PossibleNewAddress.AddressConfidence :=  l.addr_confidence_new ;
				self.Member.PossibleNewAddress.DateFirstSeen := iesp.ECL2ESP.toDatestring8(L.addr_dt_first_seen_new);
				self.Member.PossibleNewAddress.DateLastSeen  := iesp.ECL2ESP.toDatestring8(L.addr_dt_last_seen_new);
				self.Member.Phones :=  PhonesChild;
        		self.member.CalculatedAge:=if(includedob='1' and STD.Date.IsValidDate((integer)l.dob, 1900 , 2099),(string)lib_date.getage(l.dob),'');				self.Member.DOD := if(l.LN_search_name_type='M',iesp.ECL2ESP.toDatestring8(''),iesp.ECL2ESP.toDatestring8(L.Date_of_death));
				self.Member.DeceasedMatchCodes := if(l.LN_search_name_type='M','',l.dcd_match_code);
				self.Member.VerifiedorProofCode := l.Verified_or_Proof_Code;
    			self.Member.DeceasedSource := l.Deceased_Source;
				self.member.AddressDescriptionCodes:=AddressDescriptionCodes;
				self.Member.Emails := EmailChild;
				self.Member.InputEmailValidation :=  project(l, transform(iesp.keepcontactreport.t_KeepContactInputEmailValidation,
													self.Status :=  left.input_email_invalid,
													self.StatusReason :=  left.input_email_invalid_reason,
													self := left));
				end;

			ESDLOutput := project(BatchOut,xformESDL(left));
return ESDLOutput; 
end;