import Std;

AllAddresses(DATASET($.Layout_Sanctions) infile) := 

	Distribute(
			PROJECT(infile(country<>'' OR state<>'' OR city<>''), 
				TRANSFORM({unsigned8 id, $.Layout_XG.layout_addresses},
					self.id := left.key;
					self.type := '';
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


		
$.Layout_XG.routp xForm($.Layout_Sanctions infile) := TRANSFORM
						self.id := infile.key;
						rectype := MAP(
								infile.type_id = 'O' OR (infile.last='' AND infile.name<>'') => 'O',
								'I'
							);
						self.type := (CASE(rectype,
													'I' => 'Individual',
													'O' => 'Business',
													''));
						self.Entity_Unique_ID := 'MS'+ (string)infile.key; //     IntFormat(infile.key,20,1);
						self.Reference_id := (string)infile.key;
						self.title := '';
						self.first_name := infile.first;
						self.middle_name := infile.middle;
						self.last_name := IF(rectype = 'O', '', infile.last);
						self.generation := infile.suffix;
						/*self.full_name := IF(rectype='O',
													Std.Str.CleanSpaces(IF(infile.last='', infile.name, infile.last)),
													Std.Str.CleanSpaces(infile.name));*/
						self.full_name := MAP(
									rectype='O' => Std.Str.CleanSpaces(IF(infile.last='', infile.name, infile.last)),
									infile.name <> '' => Std.Str.CleanSpaces(infile.name),
									Std.Str.CleanSpaces(infile.first + ' ' + infile.middle + ' ' + infile.last + ' ' + infile.suffix)
									);
						self.gender := '';
						self.Reason_Listed := 'Medicaid Exclusion';
						self.Listed_Date := Std.Date.ConvertDateFormat(infile.Entity_Date,'%Y%m%d', '%Y/%m/%d');
						self.modified_date := Std.Date.ConvertDateFormat(infile.offense_date,'%Y%m%d', '%Y/%m/%d');
						self.aka_list.aka := DATASET([], $.Layout_XG.layout_aliases);
						self := [];
END;

EXPORT MapFields(DATASET($.Layout_Sanctions) infile) := FUNCTION
	basis := PROJECT(DISTRIBUTE(infile,key), xForm(LEFT));
	
	withAddr := 
				JOIN(basis, AllAddresses(infile), LEFT.id=Right.id,
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
					
	withIDs := JOIN(withPhones, $.AllIDs(infile), LEFT.id=Right.id,
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