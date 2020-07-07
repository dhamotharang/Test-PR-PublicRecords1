import iesp, Suppress;

EXPORT iesp.keepcontactreport.t_KeepContactReportResponse makeESDLOutput(dataset(MemberPoint.Layouts.BatchOut) BatchOut,
																																							iesp.keepcontactreport.t_KeepContactReportBy report_by, 
																																							string input_ssn_mask_value,
																																							unsigned1 input_dob_mask_value) := function


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

			iesp.share.t_StringArrayItem normXformEmails(MemberPoint.Layouts.BatchOut l,integer c) := transform
				self.value:= CHOOSE(c, l.email1, l.email2, l.email3, l.email4, l.email5,l.email6, l.email7, l.email8, l.email9, l.email10, '');
			end;

			PhonesChild := normalize(BatchOut,3,normXformPhones(left,counter));
			EmailChild := normalize(BatchOut,10,normXformEmails(left,counter));
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
				self.Member.DOD := iesp.ECL2ESP.toDatestring8(L.Date_of_death);
				self.Member.DeceasedMatchCodes := l.dcd_match_code;
				self.Member.Emails := EmailChild;
			end;

			ESDLOutput := project(BatchOut,xformESDL(left));

return ESDLOutput; 
end;