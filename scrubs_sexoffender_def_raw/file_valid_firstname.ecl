import IDL_header;

passing_firstnames := IDL_header.Name_Count_DS(pct_fname >= 0.75);

Layout_remame_name := RECORD
  string50	FirstName;
  IDL_header.Name_Count_DS;	
end;

Layout_remame_name tr_remame_name(passing_firstnames L) := TRANSFORM
 
 SELF.firstname := l.name; 
 SELF := L;
 END;
		
EXPORT file_valid_firstname :=  PROJECT(passing_firstnames,tr_remame_name(LEFT));




	
	
