
import IDL_header;

passing_lastname := IDL_header.Name_Count_DS(pct_lname >= 0.75);

Layout_remame_name := RECORD
  string50	LastName;
  IDL_header.Name_Count_DS;	
end;

Layout_remame_name tr_remame_name(passing_lastname L) := TRANSFORM
 
 SELF.lastname := l.name; 
 SELF := L;
 END;
		
EXPORT file_valid_lastname :=  PROJECT(passing_lastname,tr_remame_name(LEFT));



