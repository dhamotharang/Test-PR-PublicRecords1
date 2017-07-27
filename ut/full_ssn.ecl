nonzero(string1 s1) := function
 
 is_nonzero := s1<>'0';
 
 return is_nonzero;

end;

export full_ssn(string9 ssn) := function
 
 is_full_ssn := length(trim(ssn))=9 and ut.partial_ssn(ssn)=false and (nonzero(ssn[1]) or nonzero(ssn[2]) or nonzero(ssn[3]) or nonzero(ssn[4]) or nonzero(ssn[5]));
 
 return is_full_ssn;

end;