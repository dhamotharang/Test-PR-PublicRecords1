import header,ut;

export fn_blank_bogus_ssn(dataset(header.Layout_Header) head0) :=
FUNCTION

header.Layout_Header t_blank_ssn(head0 l) := transform

 self.ssn  := if(l.ssn in ut.set_badssn , '', l.ssn); 
 
 self     := l;
end;

blank_ssn := project(head0,t_blank_ssn(left));

return blank_ssn;

END;