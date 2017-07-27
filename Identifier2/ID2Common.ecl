import ut, iesp, risk_indicators, models, nid;

export ID2Common := MODULE

	export unsigned4 fromESDLDate( iesp.share.t_date dt ) := dt.year*10000 + dt.month*100 + dt.day;

	// export didset( Identifier2.layout_Identifier2 le ) := case( le.didcount,
		// 1 => [le.did],
		// 2 => [le.did, le.did2],
		// 3 => [le.did, le.did2, le.did3],
		// [le.did]
	// );
	export didset( Identifier2.layout_Identifier2 le ) :=
		  if( le.did  != 0, [le.did],  [] )
		+ if( le.did2 != 0, [le.did2], [] )
		+ if( le.did3 != 0, [le.did3], [] )
	;
	
	export boolean isFirstMatch( string input_fname, string onFile_fname ) :=
		   stringlib.stringtouppercase(onfile_fname) = stringlib.stringtouppercase(input_fname)
		or stringlib.stringtouppercase(onfile_fname) = NID.PreferredFirstNew( stringlib.stringtouppercase(input_fname) );
	
	export boolean EstateMatch( string firstname, string lastname, string estatename ) := FUNCTION
		layout := record
			boolean isFirstMatch;
			boolean isLastMatch;
		end;
		blank := dataset( [{false,false}], layout );

		// figure out how many words there are
		wordcount := Models.Common.countw( estatename, ' ,' );

		layout norm( layout le, integer1 wordnum ) := TRANSFORM
			word := stringlib.stringtouppercase(models.common.getw( estatename, wordnum ));
			self.isFirstMatch := isFirstMatch( firstname, word );
			self.isLastMatch := stringlib.stringtouppercase(lastname) = word;
		end;
		scored := normalize( blank, wordcount, norm(left,counter) );
		return exists( scored(isFirstMatch) )
			and exists( scored(isLastMatch) )
		;
	END;
END;