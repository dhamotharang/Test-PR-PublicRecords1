
bad_license := ['n/a', 'N/A', 'NA', 'unk', 'unknown', 'none', 'None', 'Not Found', '0', ','];

bad(string s) := s='' or s in bad_license;

EXPORT AllIDs(DATASET($.Layout_Sanctions) infile) := FUNCTION

	{unsigned8 id, $.Layout_XG.layout_sp} xformIDs($.Layout_Sanctions infile, integer n) := TRANSFORM
				self.id := infile.key;
				self.type := 'Other';
				self.label := CASE(n,
							1 => IF(bad(infile.license_number), SKIP, 'License Number'),
							2 => IF(bad(infile.medicaid_number), SKIP, 'Medicaid Number'),
							3 => IF(bad(infile.npi_number), SKIP, 'NPI Number'),
							4 => IF(bad(infile.dea_number), SKIP, 'DEA Number'),
							SKIP);
				self.number := CASE(n,
							1 => IF(bad(infile.license_number), SKIP, TRIM(infile.license_number)),
							2 => IF(bad(infile.medicaid_number), SKIP, TRIM(infile.medicaid_number)),
							3 => IF(bad(infile.npi_number), SKIP, TRIM(infile.npi_number)),
							4 => IF(bad(infile.dea_number), SKIP, TRIM(infile.dea_number)),
							SKIP);
				self := [];
	END;
	
	ids := Distribute(
			NORMALIZE(infile(license_number<>'' OR medicaid_number<>'' OR npi_number<>'' OR dea_number<>'')
							, 4, xformIDs(left, COUNTER)),
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