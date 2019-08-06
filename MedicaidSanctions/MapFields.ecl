import Std;

AllAddresses(DATASET($.Layout_Sanctions) infile) := 

	Distribute(
		PROJECT(infile, TRANSFORM({unsigned8 id, $.Layout_XG.layout_addresses},
				self.id := left.key;
				self.type := 'Unknown';
				self.street_1 := TRIM(left.street_1);
				self.street_2 := TRIM(left.street_2);
				self.city := TRIM(left.city);
				self.state := TRIM(left.state);
				self.postal_code := TRIM(left.zip);
				self.country := TRIM(left.country);
				self.comments := '';
				)),
		id);

AllPhones(DATASET($.Layout_Sanctions) infile) := 

	Distribute(
		PROJECT(infile(phone<>''), TRANSFORM({unsigned8 id, $.Layout_XG.layout_phones},
				self.id := left.key;
				self.type := TRIM(left.phone_type);
				self.number := TRIM(left.phone);
				self.address_id := '';
				self.comments := '';
				)),
		id);

AllIDs(DATASET($.Layout_Sanctions) infile) := FUNCTION

	{unsigned8 id, $.Layout_XG.layout_sp} xformIDs($.Layout_Sanctions infile, integer n) := TRANSFORM
				self.id := infile.key;
				self.type := 'Other';
				self.label := CASE(n,
							1 => IF(infile.license_number='', SKIP, 'License Number'),
							2 => IF(infile.medicaid_number='', SKIP, 'Medicaid Number'),
							3 => IF(infile.npi_number='', SKIP, 'NPI Number'),
							4 => IF(infile.dea_number='', SKIP, 'DEA Number'),
							SKIP);
				self.number := CASE(n,
							1 => IF(infile.license_number='', SKIP, TRIM(infile.license_number)),
							2 => IF(infile.medicaid_number='', SKIP, TRIM(infile.medicaid_number)),
							3 => IF(infile.npi_number='', SKIP, TRIM(infile.npi_number)),
							4 => IF(infile.dea_number='', SKIP, TRIM(infile.dea_number)),
							SKIP);
				self := [];
	END;
	
	ids := Distribute(
			NORMALIZE(infile, 4, xformIDs(left, COUNTER)),
		id);
		
	pID := 
			project(ids, transform({unsigned8 id, $.Layout_XG.id_rollup},
					self.id := left.id;
					self.identification := row(left, $.Layout_XG.layout_sp);
					)
				);
														
	pID rollRecs(pID L, pID R) := transform
		self.id  := L.id;
		self.identification:= L.identification + row({R.identification[1].type,
												R.identification[1].label,
												R.identification[1].number,
												R.identification[1].issued_by,
												R.identification[1].date_issued,
												R.identification[1].date_expires,
												R.identification[1].comments
		}, $.Layout_XG.layout_sp);
	end;
	
	return
		rollup(sort(distribute(pId, id),id,local), id, rollRecs(left, right),local);

		
END;
		
$.Layout_XG.routp xForm($.Layout_Sanctions infile) := TRANSFORM
						self.id := infile.key;
						self.type := TRIM(CASE(infile.type_id,
													'I' => 'Individual',
													'O' => 'Business',
													''));
						self.Entity_Unique_ID := 'MS'+IntFormat(infile.key,20,1);
						self.Reference_id := (string)infile.key;
						self.title := '';
						self.first_name := infile.first;
						self.middle_name := infile.middle;
						self.last_name := IF(infile.type_id='O', '', infile.last);
						self.generation := infile.suffix;
						self.full_name := IF(infile.type_id='O',
													Std.Str.CleanSpaces(infile.last),
													Std.Str.CleanSpaces(infile.name));
						self.gender := '';
						self.Reason_Listed := 'Medicaid Sanction';
						self.Listed_Date := Std.Date.ConvertDateFormat(infile.offense_date,'%Y%m%d', '%Y/%m/%d');
						self.modified_date := Std.Date.ConvertDateFormat(infile.offense_date,'%Y%m%d', '%Y/%m/%d');
						self := [];
END;

EXPORT MapFields(DATASET($.Layout_Sanctions) infile) := FUNCTION
	basis := PROJECT(DISTRIBUTE(infile,key), xForm(LEFT));
	
	withAddr := JOIN(basis, AllAddresses(infile), LEFT.id=Right.id,
					TRANSFORM
					($.Layout_XG.routp,
						self.address_list.address := row(RIGHT, $.Layout_XG.layout_addresses);
						self := LEFT;
					), LEFT OUTER, LOCAL);

	withPhones := JOIN(withAddr, AllPhones(infile), LEFT.id=Right.id,
					TRANSFORM
					($.Layout_XG.routp,
						self.phone_number_list.phones := row(RIGHT, $.Layout_XG.Layout_Phones);
						self := LEFT;
					), LEFT OUTER, LOCAL);
					
	withIDs := JOIN(withPhones, AllIDs(infile), LEFT.id=Right.id,
					TRANSFORM
					($.Layout_XG.routp,
						self.identification_list.identification := RIGHT.identification;
						self := LEFT;
					), LEFT OUTER, LOCAL);

	withInfo := JOIN(withIDs, $.AllInfo(infile), LEFT.id=Right.id,
					TRANSFORM
					($.Layout_XG.routp,
						self.additional_info_list.additionalinfo := RIGHT.additionalinfo;
						self := LEFT;
					), LEFT OUTER, LOCAL);
					
	withCmts := JOIN(withInfo, distribute(AllComments(infile),id), LEFT.id=Right.id,
					TRANSFORM($.Layout_XG.routp,
						self.comments := RIGHT.cmts;
						self := LEFT;
					), LEFT OUTER, LOCAL);

									
	return withCmts;
END;