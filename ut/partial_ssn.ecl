export partial_ssn(string9 v_ssn) := function

 is_partial_ssn := regexfind('00000[0-9][0-9][0-9][0-9]',v_ssn)=true and v_ssn[6..9]<>'0000';
 
 return is_partial_ssn;

end;