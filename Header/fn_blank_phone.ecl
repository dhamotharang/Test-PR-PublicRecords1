import header,ut;

export fn_blank_phone(dataset(header.Layout_Header) head0,boolean pFastHeader=false) :=
FUNCTION

set_phone_blank_sources := ['TS','CY','TN','EN','EL'];    // CY=certegy , TS => TUCS , TN => TU credit , EN => experian 
set_dob_blank_sources := ['TN'];
 
header.Layout_Header t_blank_phone(head0 l) := transform

 self.phone     := if((pFastHeader and l.src<>'QH') or l.src in set_phone_blank_sources or l.rid between /* max rid as of build 20111005 */ 187882167850 and 999999000000, '', l.phone); 
 self.dob       := if(l.src in set_dob_blank_sources , 0, l.dob); 
 
 self     := l;
end;

blank_phone := project(head0,t_blank_phone(left));

return blank_phone;

END;