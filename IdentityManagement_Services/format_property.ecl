/***
 ** Function to take a doxie formatted property dataset and filter/project/transform into desired format.
 ** Defenestrate records without "full" addresses. Filter deeds with a deed_type in a certain set.
 ** Want at least the oldest and newest Deeds per address. Assessments should be ordered newest first.
 ***/
 
import LN_PropertyV2_Services, iesp, Address;

out_rec := iesp.identitymanagementreport.t_IdmPropertyRecord;

assessment_rec := record
	string ApnaOrPinNumber;
	iesp.share.t_Address PropertyAddress;
	string1 RecordType;
	iesp.identitymanagementreport.t_IdmPropertyAssess Assessment;
	dataset(iesp.identitymanagementreport.t_IdmPropertyParty) Parties;
	iesp.identitymanagementreport.t_IdmPropertyMatchedParty MatchedParty;
end;

child_rec := record
	string ApnaOrPinNumber;
	iesp.share.t_Address PropertyAddress;
	iesp.identitymanagementreport.t_IdmPropertyRecordDetails Details;
end;

// define a few cute short names for record layouts with ugly long names
prop_rec := LN_propertyV2_Services.layouts.combined.narrow;
prop_filtered_rec := Record(prop_rec)
	Boolean Filtered;
End;

pparty_rec := LN_propertyV2_Services.layouts.parties.pparty;
entity_rec := LN_propertyV2_Services.layouts.parties.entity;

export out_rec format_property(dataset(prop_rec) d_property) := FUNCTION
			
			pparty_rec removeNoDidEntities(pparty_rec L) := Transform
				Self.Entity := L.Entity(cname <> '' OR did <> ''); 	// remove Entities that have No DID (unless they're a Company name is not blank)
				SELF := L;	// copy about 30 other fields
			End;

			// PO BOX will be in prim_name with empty prim_range, and don't count as "non-full"
			// PO BOX addresses are removed in the RNA portion for relatives and associates, but
			// they have to stay here as Owners often use that as their Legal Address.

		isInvaidAssessment(prop_rec L) := stringlib.stringtouppercase(L.fid_type) = 'A' // ASSESSMENT
									AND 
									(
										 EXISTS(
															PROJECT(
																				L.parties(
																										stringlib.stringtouppercase(party_type) = 'P' AND 
																										prim_range = '' AND 
																										prim_name[1..6] <> 'PO BOX' AND 
																										prim_name = '' AND 
																										zip = ''
																									), 
																				removeNoDidEntities(Left)
																			)
													  )
										OR
										 EXISTS(L.details(standardized_land_use_code IN 
										                    IdentityManagement_Services.Constants.ExcludedStandardizedLandUseCodes))
									);
									
									
			prop_filtered_rec filter_properties(prop_rec L) := Transform,
				// exclude Assessments with addresses that aren't "full"
			     SKIP(
									isInvaidAssessment(L)
                )
				// filter Deeds that are not in the list of desired deed types
				Self.filtered := stringlib.stringtouppercase(L.fid_type) = 'D' // DEED
                AND NOT EXISTS(L.deeds(document_type_code IN IdentityManagement_Services.Constants.IncludedDeedTypes))
								AND EXISTS(L.details(standardized_land_use_code IN IdentityManagement_Services.Constants.ExcludedStandardizedLandUseCodes));
     		SELF := L; // copy at least 30 other fields
			End;

			// project the input property dataset into a filtered version
			d_property_filtered := PROJECT(d_property, filter_properties(LEFT));

			iesp.share.t_Address getPropertyAddress(dataset(LN_PropertyV2_Services.layouts.parties.pparty) Parties) := function
					//Get Property record from Parties Dataset
					L := Parties(party_type_name = 'Property')[1]; //should only be one record left anyway
					return iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.suffix,
															l.unit_desig,l.sec_range, l.p_city_name, l.st, l.zip, l.zip4,l.County_name, '',
															Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range),
															'',
															Address.Addr2FromComponents(l.p_city_name, l.st, l.zip));
			end;
			
			iesp.identitymanagementreport.t_IdmEntity toEntities (LN_PropertyV2_Services.layouts.parties.entity L) := transform
				string full_name := StringLib.StringCleanSpaces (L.cname + ' ' + L.fname + ' ' + L.mname + ' ' + L.lname);
				Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title, full_name);
				self.UniqueId := L.did;
			end;

			iesp.identitymanagementreport.t_IdmPropertyParty toParties (LN_PropertyV2_Services.layouts.parties.pparty L) := transform
				self.PartyType := L.party_type;
				self.PartyTypeName := L.party_type_name;
				self.Address := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.suffix,
															l.unit_desig,l.sec_range, l.p_city_name, l.st, l.zip, l.zip4,l.County_name, '',
															Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range),
															'',
															Address.Addr2FromComponents(l.p_city_name, l.st, l.zip));
				self.Entities := choosen(project(L.Entity, toEntities(left)), iesp.Constants.IDM.MaxPropertyEntities);
				self.LinkingWeight := L.xadl2_weight;
			end;

			//The incoming layout is composed of a dataset of Assessments, but the dataset of Assessments and Details has a maxcount of 1
			assessment_rec toAssessment(prop_filtered_rec L) := transform
					self.ApnaOrPinNumber := L.Assessments[1].Apna_or_pin_number;
					self.RecordType := L.Fid_type;
					//The first record in Parties is the Property Record
					self.PropertyAddress := getPropertyAddress(L.Parties);
					self.Assessment.DataSource := L.vendor_source_flag;
					self.Assessment.CountyName := L.Assessments[1].County_Name;
					Self.Assessment.SaleDate := iesp.ECL2ESP.toDate ((integer)L.Assessments[1].sale_date);
					self.Assessment.SalesPrice := L.Assessments[1].Sales_price;
					self.Assessment.taxYear :=  L.Assessments[1].tax_year;
					self.Assessment.taxAmount := L.Details[1].tax_amount;
					self.Assessment.recordingDate := iesp.ECL2ESP.toDate ((integer)L.Assessments[1].recording_date);
					self.Assessment.PropertyInfo.Subdivision := L.Details[1].Legal_subdivision_name;
					self.Assessment.PropertyInfo.LivingSquareFeet := L.Details[1].fares_living_square_feet;
					Self.Assessment.PropertyInfo.BuildingAreaMain := L.Details[1].building_area;
					Self.Assessment.PropertyInfo.BuildingAreaMainDesc := L.Details[1].building_area_desc;
					Self.Assessment.PropertyInfo.BuildingArea1 := L.Details[1].building_area1;
					Self.Assessment.PropertyInfo.BuildingArea1Desc := L.Details[1].building_area1_desc;
					Self.Assessment.PropertyInfo.BuildingArea2 := L.Details[1].building_area2;
					Self.Assessment.PropertyInfo.BuildingArea2Desc := L.Details[1].building_area2_desc;
					Self.Assessment.PropertyInfo.BuildingArea3 := L.Details[1].building_area3;
					Self.Assessment.PropertyInfo.BuildingArea3Desc := L.Details[1].building_area3_desc;
					Self.Assessment.PropertyInfo.BuildingArea4 := L.Details[1].building_area4;
					Self.Assessment.PropertyInfo.BuildingArea4Desc := L.Details[1].building_area4_desc;
					Self.Assessment.PropertyInfo.BuildingArea5 := L.Details[1].building_area5;
					Self.Assessment.PropertyInfo.BuildingArea5Desc := L.Details[1].building_area5_desc;
					Self.Assessment.PropertyInfo.BuildingArea6 := L.Details[1].building_area6;
					Self.Assessment.PropertyInfo.BuildingArea6Desc := L.Details[1].building_area6_desc;
					Self.Assessment.PropertyInfo.BuildingArea7 := L.Details[1].building_area7;
					Self.Assessment.PropertyInfo.BuildingArea7Desc := L.Details[1].building_area7_desc;
					Self.Assessment.PropertyInfo.YearBuilt := L.Details[1].Year_Built;
					Self.Assessment.PropertyInfo.AirConditioning := L.Details[1].Air_conditioning_desc;
					self.Assessment.PropertyInfo.NumberOfBedrooms := L.Details[1].no_of_bedrooms;
					// partial bathrooms count the same as full bathrooms for our purposes
					self.Assessment.PropertyInfo.NumberOfBathrooms := (String)RoundUp((real)L.Details[1].no_of_baths+(real)L.Details[1].no_of_partial_baths);
					self.Assessment.PropertyInfo.NumberOfStories := L.Details[1].no_of_stories;
					Self.matchedParty.PartyType := L.Matched_party.party_type;
					self.MatchedParty.PartyTypeName := L.Matched_party.party_type_name;
					Self.MatchedParty.UniqueId := L.Matched_Party.Entity.did;
					Self.MatchedParty.LinkingWeight := L.Matched_Party.xadl2_weight;
					self.Parties := choosen(project(L.Parties, toParties(left)), iesp.Constants.IDM.MaxPropertyParties);
				end;

				//The incoming layout is composed of a dataset of Deeds, but the dataset of Deeds and Details has a maxcount of 1
				child_rec toDeeds(prop_filtered_rec L) := transform
					self.ApnaOrPinNumber := L.deeds[1].Apnt_or_pin_number;
					self.PropertyAddress := getPropertyAddress(L.Parties);
					self.Details.Deed.DataSource := L.vendor_source_flag;
					self.Details.RecordType := L.fid_type;
					self.Details.Deed.State := L.deeds[1].state;
					self.Details.Deed.CountyName := L.deeds[1].county_name;
					self.Details.Deed.SalesPrice := L.deeds[1].sales_price;
					self.Details.Deed.DocumentTypeCode := L.Deeds[1].document_type_code;
					self.Details.Deed.DocumentTypeDescription := L.Deeds[1].document_type_desc;
					self.details.Deed.recordingDate := iesp.ECL2ESP.toDate ((integer)L.Deeds[1].recording_date);
					self.Details.Deed.MortgageInfo.LenderName := L.Details[1].lender_name;
					Self.Details.Deed.MortgageInfo.MortgageAmount := L.Deeds[1].first_td_loan_amount;
					self.Details.Deed.MortgageInfo.MortgageLenderName := L.Details[1].mortgage_lender_name;
					self.Details.Deed.MortgageInfo.MortgageLoanType := L.Details[1].first_td_loan_type_desc;
					Self.Details.Deed.MortgageInfo.MortgageDueDate := iesp.ECL2ESP.toDate((integer)L.Details[1].first_td_due_date);
					self.Details.Deed.ContractDate := iesp.ECL2ESP.toDate ((integer)L.Deeds[1].contract_date);
					self.Details.Deed.Filtered := L.Filtered;
					Self.Details.matchedParty.PartyType := L.Matched_party.party_type;
					self.Details.MatchedParty.PartyTypeName := L.Matched_party.party_type_name;
					Self.Details.MatchedParty.UniqueId := L.Matched_Party.Entity.did;
					Self.Details.MatchedParty.LinkingWeight := L.Matched_Party.xadl2_weight;		
					self.Details.Parties := choosen(project(L.Parties, toParties(left)), iesp.Constants.IDM.MaxPropertyParties);
					self.Details.Deed.TransactionTypeCode := L.Details[1].fares_transaction_type;
					self.Details.Deed.TransactionType := L.Details[1].fares_transaction_type_desc;
					self.Details.Deed.LandSize := L.Details[1].land_square_footage;
					SELF := []; // clear at least 30 other fields
				end;

				assessments := project(d_property_filtered(stringlib.stringtouppercase(fid_type) = 'A'), toAssessment(left));

				//Use the property address to do all the linking and organizing since apn number is differently formatted from one vendor to another
				// tax year is primary sort field as per new reqs
				newest_assessments := sort(assessments,
																		PropertyAddress.StreetAddress1, 
																		PropertyAddress.StreetAddress2, 
																		PropertyAddress.StateCityZip,
																		Assessment.DataSource,
																		-Assessment.TaxYear
																		);
				oldest_assessments := sort(assessments, 
																		PropertyAddress.StreetAddress1, 
																		PropertyAddress.StreetAddress2, 
																		PropertyAddress.StateCityZip,
																		Assessment.DataSource,
																		if(assessment.TaxYear <> '', 1, 2), // sort empty years last
																		Assessment.TaxYear																		
																		);

				assessment_rec toAssessmentOut(assessment_rec L, assessment_rec R) := transform
					SELF := L; // copy at least 40 other fields
				end;

				//Get newest assessment
				rolled_Newest_assessment := project(rollup(newest_assessments, left.PropertyAddress.StreetAddress1 = right.PropertyAddress.StreetAddress1 and
																						left.PropertyAddress.StreetAddress2 = right.PropertyAddress.StreetAddress2 and
																						left.PropertyAddress.StateCityZip = right.PropertyAddress.StateCityZip
																						and left.Assessment.DataSource = right.Assessment.DataSource,
																						toAssessmentOut(left, right)),
																						transform(child_rec, 
																										//	self.ApnaOrPinNumber := left.ApnaOrPinNumber,
																											self.Details := left,
																											SELF := LEFT, // copy a whole heap of fields to SELF, and clear at least 20 fields
																											SELF := []));

				//Get oldest Assessment
				rolled_oldest_assessment := project(rollup(oldest_assessments, left.PropertyAddress.StreetAddress1 = right.PropertyAddress.StreetAddress1 and
																						left.PropertyAddress.StreetAddress2 = right.PropertyAddress.StreetAddress2 and
																						left.PropertyAddress.StateCityZip = right.PropertyAddress.StateCityZip
																						and left.Assessment.DataSource = right.Assessment.DataSource,
																						toAssessmentOut(left, right)),
																						transform(child_rec, 
																											self.Details := left,
																											SELF := LEFT, // copy a whole heap of fields, and clear at least 20 fields
																											SELF := []));

				// roll them together, newest first
				rolled_assessment := rolled_newest_assessment + rolled_oldest_assessment;
																	
				//Project and sort deeds based on property address (first record in Parties)
				//and Apna number in case some records do not have ApnaNumbers:
				deeds := project(sort(d_property_filtered(fid_type IN ['D','d']), sortby_date), toDeeds(left));

				// sort oldest first
				sorted_deeds := sort(deeds, PropertyAddress.StreetAddress1,
				                            PropertyAddress.StreetAddress2,
				                            PropertyAddress.StateCityZip,
				                            Details.Deed.RecordingDate.Year);

				// remove address-based duplicates
				sorted_deeds_dedup := dedup(sorted_deeds, PropertyAddress.StreetAddress1,
				                                     PropertyAddress.StreetAddress2,
				                                     PropertyAddress.StateCityZip,
																						 Details.Deed.RecordingDate.Year);

				// create child records that combine assessments and deeds
				child_recs := sort(rolled_assessment + sorted_deeds_dedup, PropertyAddress.StreetAddress1, 
																											PropertyAddress.StreetAddress2, 
																											PropertyAddress.StateCityZip,
																											Details.RecordType, 
																											Details.Assessment.DataSource,
																											Details.Deed.DataSource,
																											-Details.Assessment.TaxYear, 
																											-Details.Deed.RecordingDate.Year);

				//All the linking is done using property address (apn # not reliable).
				//Only keep one property address
				parent_recs := dedup(sort(project(d_property_filtered, transform(out_rec,
																											self.apnaOrPinNumber := if(left.assessments[1].apna_or_pin_number <> '', 
																																								Left.assessments[1].apna_or_pin_number,
																																								Left.deeds[1].apnt_or_pin_number),
																											self.PropertyAddress := getPropertyAddress(left.Parties),
																											self.PropertyRecords := [])),
																					PropertyAddress.StreetAddress1, PropertyAddress.StreetAddress2, PropertyAddress.StateCityZip),
																					PropertyAddress.StreetAddress1, PropertyAddress.StreetAddress2, PropertyAddress.StateCityZip);

				out_rec DeNorm(out_rec L, child_rec R) := transform
					self.ApnaOrPinNumber := L.ApnaOrPinNumber;
					self.PropertyRecords := choosen(L.PropertyRecords + R.Details, iesp.Constants.IDM.MaxPropertyRecords);
					self := L; // copy about 30 other fields
				end;

				//Denormalize records to create a child dataset of the property records based on the property address 
				//Property address defines a property
				propertyV2 := denormalize(parent_recs, child_recs, 
																	left.PropertyAddress.StreetAddress1 = right.PropertyAddress.StreetAddress1 and
																	left.PropertyAddress.StreetAddress2 = right.PropertyAddress.StreetAddress2 and
																	left.PropertyAddress.StateCityZip = right.PropertyAddress.StateCityZip,
																	DeNorm(left, right));

/*******
	OUTPUT(d_property(fid_type = 'A'), NAMED('Input_Assessments'));
	OUTPUT(d_property(fid_type = 'D'), NAMED('Input_Deeds'));
	OUTPUT(d_property(fid_type NOT IN ['A', 'D']), NAMED('Weird')); // not supposed to happen
	OUTPUT(d_property, NAMED('d_property'));
	OUTPUT(d_property_filtered, NAMED('d_property_filtered'));
	OUTPUT(newest_assessments, NAMED('newest_assessments'));
	OUTPUT(deeds, NAMED('deeds'));
	OUTPUT(sorted_deeds_dedup, NAMED('sorted_deeds_dedup'));
	OUTPUT(parent_recs, NAMED('Property_Parent_Recs'));
	OUTPUT(child_recs, NAMED('Property_Child_Recs'));
 // *******/
 
	RETURN propertyV2;

END;