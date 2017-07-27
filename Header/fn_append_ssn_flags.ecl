import ut,ssnissue2;

/*
Knowing what serial's have been issued (the last 4 of the SSN) is not currently available
Partial SSNs and ITINs, while flagged, are not considered invalid
*/

r0 := record
 string9 ssn;
end;
																						
export fn_append_ssn_flags(dataset(recordof(r0)) in_hdr) := function

 has_ssn := in_hdr(ssn<>'');
 no_ssn  := in_hdr(ssn ='');

 r1 := record
  has_ssn;
  boolean   ssn_is_invalid  :=false;
  string10  ssn_flags       :='';
  unsigned8 ssn_flags_bitmap:=0;
 end;
 
 r1 x1(has_ssn le, ssnissue2.file_ssnissue2 ri) := transform
 
 boolean is_partial             := ut.partial_ssn(le.ssn);
 boolean is_itin                := le.ssn[1]='9' and le.ssn[4] in ['7','8'];
 boolean is_666                 := le.ssn[1..3]='666';
 boolean is_eae                 := le.ssn[1..3] between '729' and '733';
 boolean is_advertising         := le.ssn between '987654320' and '987654329';
 boolean is_woolworth           := le.ssn='078051120';
 boolean is_invalid_area        := le.ssn[1..3]= '000' and is_partial=false and is_itin=false;
 boolean is_invalid_group       := le.ssn[4..5]=  '00' and is_partial=false and is_itin=false;
 boolean is_invalid_serial      := le.ssn[6..9]='0000'                      and is_itin=false;
 boolean area_group_not_issued0 := if(le.ssn[1..5]=ri.ssn5,false,true);
 boolean area_group_not_issued  := if(area_group_not_issued0 and (is_partial or is_itin or is_invalid_area or is_invalid_group or is_666 or is_advertising),false,
                                   if(area_group_not_issued0,true,
								   false));
 
 string10 concat_flags := if(is_partial,           'P',' ')
                        + if(is_itin   ,           'I',' ')
				        + if(is_666    ,           '6',' ')
					    + if(is_eae    ,           'E',' ')
				        + if(is_advertising,       'V',' ')
				        + if(is_woolworth  ,       'W',' ')
				        + if(is_invalid_area,      'A',' ')
				        + if(is_invalid_group,     'G',' ')
				        + if(area_group_not_issued,'5',' ')
					    + if(is_invalid_serial,    'S',' ')
						;
 
 self.ssn_is_invalid := if(concat_flags<>'' and is_partial=false and is_itin=false and is_eae=false,true,
                        if(is_eae=true and (area_group_not_issued or is_invalid_serial),true,
                        false));
 
 self.ssn_flags      := concat_flags;
 
 self.ssn_flags_bitmap := if(is_partial,           header.constants.ssn_indicators.is_partial,0)
                         +if(is_itin,              header.constants.ssn_indicators.is_itin,0)
						 +if(is_666,               header.constants.ssn_indicators.is_666,0)
						 +if(is_eae,               header.constants.ssn_indicators.is_eae,0)
						 +if(is_advertising,       header.constants.ssn_indicators.is_advertising,0)
						 +if(is_woolworth,         header.constants.ssn_indicators.is_woolworth,0)
						 +if(is_invalid_area,      header.constants.ssn_indicators.is_invalid_area,0)
						 +if(is_invalid_group,     header.constants.ssn_indicators.is_invalid_group,0)
						 +if(area_group_not_issued,header.constants.ssn_indicators.area_group_not_issued,0)
						 +if(is_invalid_serial,    header.constants.ssn_indicators.is_invalid_serial,0)
						 ;
																																		
 self := le;
 
end;

j1 := join(has_ssn,ssnissue2.file_ssnissue2((integer5)ssn5>0),left.ssn[1..5]=right.ssn5,x1(left,right),left outer,lookup);

concat := j1+project(no_ssn,r1);

return concat;

end;