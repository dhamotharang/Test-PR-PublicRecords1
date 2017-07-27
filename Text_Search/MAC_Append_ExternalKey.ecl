// This macro appends the text_search external key to dataset

export MAC_Append_ExternalKey(infile,outfile,assignment) := MACRO

  #uniquename(apprec)
  %apprec% := RECORD (infile),
     Text_Search.Layout_ExternalKey;
  END;

	#uniquename(apptran)
	%apprec% %apptran%(infile l) := TRANSFORM
	  self.ExternalKey := assignment;
		self := l;
  END;

	outfile := PROJECT(infile, %apptran%(left));

ENDMACRO;


