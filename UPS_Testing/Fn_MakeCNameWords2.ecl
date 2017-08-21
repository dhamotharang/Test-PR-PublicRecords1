import text,ut,Business_Header_SS,lib_metaphone,LN_PropertyV2;

rec := record(Business_Header_SS.layout_MakeCNameWords)
	string6 zip;
end;

export Fn_MakeCNameWords2() :=
MODULE

	export inrec := rec;

	export records(
		dataset(rec) infile
		) :=
	FUNCTION
	
	//**** MAP & TO AND
	infile_mapped :=
	project(
		infile,
		transform(
			rec,
			self.company_name := stringlib.StringFindReplace(left.company_name,'&','AND'), //see bug 22195
			self := left
		)
	);

	//***** POPULATE THE SEQUENCE FIELD THAT IS EXPECTED BY BUSINESS_HEADER_SS.FN_MAKECNAMEWORDS
	ut.MAC_Sequence_Records(infile_mapped, __filepos, infile_wrid)
	

	//***** CALL OLD VERSION OF FN, BUSINESS_HEADER_SS.FN_MAKECNAMEWORDS
	wrds_unfiltered := business_header_ss.Fn_MakeCNameWords(project(infile_wrid, Business_Header_SS.layout_MakeCNameWords));
					
	
	//**** FILTER OUT USELESS ENTRIES
	set_FurnitureWords := LN_PropertyV2.furniture_words + ['CENTER'];
	wrds := wrds_unfiltered(word not in set_FurnitureWords);
	
	
	//**** ADD METAPHONE AND ZIP FIELDS AND DROP FILEPOS FIELDS
	outrec := record
		string15 metaphone;
		wrds.word;
		wrds.state;
		wrds.seq;
		wrds.bdid;
		wrds.lookups;
		inrec.zip;
	end;
	
	
	//**** POPULATE ZIP
	j := 
	join(
		wrds,
		infile_wrid,
		left.bh_filepos = right.__filepos,
		transform(
			outrec,
			// self.metaphone := lib_metaphone.MetaphoneLib.DMetaphone1(left.word),
			self.zip := right.zip,
			self := left
		),
		hash
	)(metaphone <> '');
	

	return j;
	END;

end;