IMPORT nid, address, std, header;
EXPORT fn_CleanNames(Dataset(header.Layout_Header_v2) file) := FUNCTION
			cln := Nid.fn_CleanParsedNames(file, useV2 := true, includeInRepository := true);

			result := PROJECT(cln, TRANSFORM(header.Layout_Header_v2,
							self.title := IF(left.cln_title='', left.title, left.cln_title);
							self.fname := IF(left.cln_fname='', left.fname, left.cln_fname);
							self.mname := IF(left.cln_mname='', left.mname, left.cln_mname);
							self.lname := IF(left.cln_lname='', left.lname, left.cln_lname);
							self.name_suffix := IF(left.cln_suffix='', left.name_suffix, left.cln_suffix);
							self := left;
							));
							
			return result;
END;