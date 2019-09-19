IMPORT nid, address, std, header;

boolean JustLastName(string name) := Address.Persons.IsLastNameOnly(Address.PrecleanName(name));


EXPORT fn_CleanNames(Dataset(header.Layout_Header_v2) file) := FUNCTION
			cln := Nid.fn_CleanParsedNames(file, useV2 := true, includeInRepository := false, normalizeDualNames:=false)
											: persist('~thor::watchdog_best::cln_names');

			result := PROJECT(cln, TRANSFORM(header.Layout_Header_v2,
							self.title := IF(left.cln_title='', left.title, left.cln_title);
							self.fname := MAP(
																left.nametype in ['P','D'] => left.cln_fname,
																left.nametype = 'T' AND left.cln_fname <> '' => left.cln_fname,
																left.nametype = 'I' AND JustLastName(left.fullname) => '',
																left.fname);

							self.mname := MAP(
																left.nametype in ['P','D'] => left.cln_mname,
																left.nametype = 'T' AND left.cln_mname <> '' => left.cln_mname,
																left.nametype = 'I' AND JustLastName(left.fullname) => '',
																left.mname);

							self.lname := MAP(
																left.nametype in ['P','D'] => left.cln_lname,
																left.nametype = 'T' AND left.cln_lname <> '' => left.cln_lname,
																left.nametype = 'I' AND JustLastName(left.fullname) => Address.PrecleanName(left.fullname),
																left.lname);

							self.name_suffix := IF(left.cln_suffix='', left.name_suffix, left.cln_suffix);
							self.name_ind := left.name_ind;
							
							self := left;
							));
							
			return result;
END;