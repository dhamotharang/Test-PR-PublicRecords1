import ssnissue2;
/*
1st position returns Y if the SSN is invalid, followed by reason codes
Knowing what serial's have been issued (the last 4 of the SSN) is not currently available
Partial SSNs and ITINs, while flagged, are not considered invalid
*/

export fn_ssn_is_invalid(string9 in_ssn) := function
 
 boolean is_partial            := ut.partial_ssn(in_ssn);
 boolean is_itin               := in_ssn[1]='9' and in_ssn[4] in ['7','8'];
 boolean is_666                := in_ssn[1..3]='666';
 boolean is_advertising        := in_ssn between '987654320' and '987654329';
 boolean is_woolworth          := in_ssn='078051120';
 boolean is_invalid_area       := in_ssn[1..3]  = '000' and is_partial=false and is_itin=false;
 boolean is_invalid_group      := in_ssn[4..5]  =  '00' and is_partial=false and is_itin=false;
 boolean is_invalid_serial     := in_ssn[6..9]  ='0000'                      and is_itin=false;
 boolean area_group_not_issued := if(in_ssn[1..5] in set(ssnissue2.file_ssnissue2,ssn5),false,true);
 
 string9 concat_flags := if(is_partial,       'P',' ')
                       + if(is_itin   ,       'I',' ')
				       + if(is_666    ,       '6',' ')
				       + if(is_advertising,   'V',' ')
				       + if(is_woolworth  ,   'W',' ')
				       + if(is_invalid_area,  'A',' ')
				       + if(is_invalid_group, 'G',' ')
				       + if(is_invalid_serial,'S',' ')
				       + if(area_group_not_issued and (is_partial or is_itin or is_invalid_area or is_invalid_group or is_666 or is_advertising),' ',
				          if(area_group_not_issued,'5',
				         ' '));
 
 ssn_flags := if(concat_flags<>'' and is_partial=false and is_itin=false,'Y'+concat_flags,'N'+concat_flags);
  
 return ssn_flags;
end;