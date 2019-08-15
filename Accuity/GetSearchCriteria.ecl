import STD;
PrepForXML(unicode s) := 
				STD.Uni.FindReplace(
					STD.Uni.FindReplace(s,'&','&amp;'),
				'\'', '&apos;');

SourceCriteria(DATASET(Accuity.Layouts.input.rEntity) infile) := FUNCTION	

	rSanctions := RECORD
		integer		code;
		string		source_code;
		string		source_name;
		string		file_type;
		string		ln_name;
	END;
		
	src := DISTRIBUTE($.Files.Input.gwl.srccode, hash32(list_id));
	s1 := DEDUP(SORT(src, list_id, source_code, local), list_id, source_code, local);
	acc := infile(type not in ['1','2']);

	u := TABLE(acc, {acc.list_id, acc.source, n := COUNT(GROUP)}, list_id, source, few);
	
	j := JOIN(u, s1, left.list_id=right.list_id, TRANSFORM(rSanctions,
					self.code := (integer)left.list_id;
					self.source_code := left.source;
					self.source_name := right.source_name;
					self.file_type := right.file_type;
					nm := TRIM(right.source_CODE)+(string)left.list_id;
					converted := $.Conversions.SourceCodeToName(nm);
					self.ln_name := IF(converted=nm, '', converted);
				), left outer);
	dsSantions := sort(j, code);

	return 	PROJECT(dsSantions, TRANSFORM(rCriteria,
									self.valueid := left.code;
									nm := IF(left.ln_name='', left.source_name, left.ln_name);
									self.name := PrepForXML(nm);));
	
END;


EXPORT GetSearchCriteria(DATASET($.Layouts.input.rEntity) infile) := 

		MakeGroupHeader(SourceCriteria(infile), 1, 'Sources')
;