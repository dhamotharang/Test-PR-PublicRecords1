EXPORT dsSources(DATASET($.Layouts.input.rEntity) infile) := FUNCTION	

	rSources := RECORD
		integer		code;
		string		source_code;
		string		name;
		string		source_name;
		string		file_type;
		string		ln_name;
	END;
		
	src1 := DISTRIBUTE($.Files.Input.gwl.srccode, hash32(list_id));
	src := src1(LIST_ID NOT IN ['1072','0']) 
										+ DATASET([{'1072','OFAC','OFAC','','',''},
																{'0','US Treasury SDN List (OFAC)','UST','','',''}],
											$.Layouts.input.rSrccode);
	s1 := DEDUP(SORT(src, list_id, source_code, local), list_id, source_code, local);
						
	acc := infile(type not in ['1','2']);

	u1 := TABLE(acc, {acc.list_id, acc.source, n := COUNT(GROUP)}, list_id, source, few);
	u := u1(LIST_ID NOT IN ['1072','0']) 
												+ DATASET([{'1072','OFAC',1}, {'0','UST',1}],
											recordof(u1));
	
	j := JOIN(u, s1, left.list_id=right.list_id and left.source=right.source_code, TRANSFORM(rSources,
					self.code := (integer)left.list_id;
					self.source_code := left.source;
					self.source_name := TRIM(right.source_name);
					self.file_type := right.file_type;
					nm := TRIM(right.source_CODE)+(string)left.list_id;
					converted := $.Conversions.SourceCodeToName(nm);
					self.ln_name := TRIM(IF(converted=nm, '', converted));
					self.name := TRIM(IF(self.ln_name='', self.source_name, self.ln_name));
				), left outer);
				
	return sort(j, code);

END;