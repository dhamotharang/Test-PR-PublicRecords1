/***
 ** Function to transform/project/filter the dataset from Vehicle Services to desired format.
***/

import VehicleV2_Services, iesp, Address;

out_rec := iesp.identitymanagementreport.t_IdmMVehicleRecord;

child_rec := record
	string vin;
	iesp.identitymanagementreport.t_IdmMVehicleDetail Details;
end;

LienHoldersToExclude := IdentityManagement_Services.Constants.LienHoldersToExclude; // shortcut to official list of excludable lienholders

export out_rec format_vehicles (dataset(VehicleV2_Services.Layout_Report) d_vehi) := FUNCTION

			vehicle_rec := VehicleV2_Services.Layout_Report; // defenestrate lienholders in the list (e.g., "Unknown Lienholder", etc.)
			
			vehicle_rec d_vehi_t(vehicle_rec L) := TRANSFORM
				SELF.lienholders := PROJECT(L.lienholders,
																		TRANSFORM(RECORDOF(L.lienholders),
																					SELF.Append_Clean_Cname :=
																								IF(StringLib.StringToUpperCase(LEFT.Append_Clean_Cname) NOT IN LienHoldersToExclude,
																										LEFT.Append_Clean_Cname, ''),
																					SELF.Std_Lienholder_Name :=
																								IF(StringLib.StringToUpperCase(LEFT.Std_Lienholder_Name) NOT IN LienHoldersToExclude,
																										LEFT.Std_Lienholder_Name, ''),
																					SELF := LEFT));
				SELF := L; // copy at least 30 other fields
			END;

			d_vehi_1 := PROJECT(d_vehi, d_vehi_t(LEFT)); // don't remove records, just clear the Name field of unwanted lienholders

			// we could combine these two short lines, but then we couldn't Output intermediate results for debugging
			sorted_vehicles := sort(d_vehi_1, vin); // sort the vehicles after defenestrating lienholders
			
			out_rec toParent(VehicleV2_Services.Layout_Report L) := transform
				self.vin := L.vin;
				self.VehicleDetails := [];
			end;
			
			parent_rec := dedup(project(sorted_vehicles, toParent(left)), vin);
												 
			iesp.identitymanagementreport.t_IdmMVehicleRegistrationInfo SetRegistrationAddresses (VehicleV2_Services.assorted_layouts.Layout_registrant L) := TRANSFORM
					self.Address := iesp.ECL2ESP.SetAddress (
														L.prim_name, L.prim_range, L.predir, L.postdir, L.addr_suffix, L.unit_desig, L.sec_range,
														L.v_city_name, L.st, L.zip5, L.zip4, L.county_name, '',
														Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range),
														'',
														Address.Addr2FromComponents(l.v_city_name, l.st, l.zip5));
					firstDate := if(L.reg_first_date <> '', L.reg_first_Date, L.reg_earliest_effective_date);
					self.FirstDate := iesp.ECL2ESP.toDate((unsigned4) firstDate);
					self.ExpirationDate := iesp.ECL2ESP.toDate((unsigned4) L.reg_latest_expiration_date);
					Self.LicensePlateTypeCode := L.Reg_License_Plate_Type_Code;
					Self.LicensePlateTypeDesc := L.Reg_License_Plate_Type_Desc;
					Self.RegLicensePlate := L.Reg_License_Plate;
					Self.RegLicenseState := L.Reg_License_State;
			END;

			child_rec toFilter(VehicleV2_Services.Layout_Report L) := Transform
					self.vin := L.vin;
					this_own := choosen (L.owners, 1)[1];
					Self.Details.ModelYear := (integer4) L.model_year;
					Self.Details.Make := L.make_desc;
					Self.Details.Model := L.model_desc;
					Self.Details.VehicleSpecification := PROJECT (L, transform (iesp.identitymanagementreport.t_IdmMVehicleSpecification,
							Self.MajorColor := Left.major_color_desc;
							self.BodyType := left.vehicle_type_desc;
						));
					Self.Details.TitleIssueDate := iesp.ECL2ESP.toDate ((unsigned4) this_own.Ttl_Latest_Issue_Date);
					Self.Details.Registrations := dedup(sort(project(choosen (L.registrants, iesp.Constants.MV.MaxCountRegistrants), SetRegistrationAddresses (Left)),
																			Address.StreetAddress1,
																			address.StreetAddress2,
																			address.StateCityZip),
																			Address.StreetAddress1,
																			address.StreetAddress2,
																			address.StateCityZip);
			end;

			child_recs := project(sorted_vehicles, toFilter(left));
			
			child_rec RollThem(child_rec L, child_rec R) := transform
				self.details.titleIssueDate := if(L.details.titleIssueDate.year <> 0, L.details.titleIssueDate, R.details.TitleIssueDate);
				self := L; // copy about 15 other fields
			end;
			
			final_child_recs := rollup(child_recs, left.vin = right.vin, RollThem(left, right));
																							
			out_rec DeNorm(out_rec L, child_rec R) := transform
				self.vin := L.vin;
				self.VehicleDetails := choosen(L.VehicleDetails + R.Details, iesp.Constants.IDM.MaxVehicleDetails);
			end;

			//Denormalize records to create a child dataset of the vehicles records based on the vin
			esp_vehicles := denormalize(parent_rec, final_child_recs, left.vin = right.vin,
																							DeNorm(left, right));

/*******
	// DEBUG
	OUTPUT(d_vehi,           NAMED('d_vehi'));
	OUTPUT(d_vehi_1,         NAMED('d_vehi_1'));
	OUTPUT(sorted_vehicles,  NAMED('sorted_vehicles'));
	OUTPUT(parent_rec,       NAMED('Vehicle_parent_rec'));
	OUTPUT(child_recs,       NAMED('Vehicle_child_recs'));
	OUTPUT(final_child_recs, NAMED('final_child_recs'));
	OUTPUT(esp_vehicles,     NAMED('esp_vehicles'));
/*******/
	
	RETURN esp_vehicles;
		
END;