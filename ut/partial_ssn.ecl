export partial_ssn(string9 v_ssn) := function

 is_partial_ssn := regexfind('00000[0-9][0-9][0-9][0-9]',v_ssn)=true;
 
 return is_partial_ssn;

end;