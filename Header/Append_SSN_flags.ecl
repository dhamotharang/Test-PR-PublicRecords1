/*
Knowing what serial's have been issued (the last 4 of the SSN) is not currently available
Partial SSNs and ITINs, while flagged, are not considered invalid
//
from http://www.ssa.gov/employer/randomizationfaqs.html

When will SSN randomization take effect?
	The SSA plans to implement the new assignment methodology on June 25, 2011. 

What changes will result from randomization?
	The SSA will eliminate the geographical significance of the first three digits of the SSN,
	currently referred to as the area number, by no longer allocating the area numbers for assignment
	to individuals in specific states. The significance of the highest group number (the fourth
	and fifth digits of the SSN) for validation purposes will be eliminated. Randomization will also
	introduce previously unassigned area numbers for assignment excluding area numbers 000, 666 and 900-999.

Will SSN randomization assign group number (the fourth and fifth digits of the SSN)
	00 or serial number (the last four digits of the SSN) 0000?
	SSN randomization will not assign group number 00 or serial number 0000. SSNs containing
	group number 00 or serial number 0000 will continue to be invalid. 

Will the High Group List still be available for validation?
	Currently, there are no plans to update the High Group List once randomization is implemented.
	The High Group List will be frozen in time and can be used for validation of SSNs issued prior
	to the randomization implementation date.


from http://www.socialsecurity.gov/employer/ssnweb.htm
	Within each area, the group number (middle two (2) digits) range from 01 to 99 but are not assigned in consecutive order.
	For administrative reasons, group numbers issued first consist of the ODD numbers from 01 through 09
	and then EVEN numbers from 10 through 98, within each area number allocated to a State. After all numbers in group 98
	of a particular area have been issued, the EVEN Groups 02 through 08 are used, followed by ODD Groups 11 through 99. 

from http://www.socialsecurity.gov/employer/stateweb.htm (as of 6/8)
Alabama	416-424	
Alaska	574	
American Samoa	586	
Arizona	526-527	
Arizona	600-601	
Arizona	764-765	
Arkansas	429-432	
Arkansas	676-679	
California	545-573	
California	602-626	
Colorado	521-524	
Colorado	650-653	
Connecticut	040-049	
Delaware	221-222	
District of Columbia	577-579	
Enumeration at Entry	729-733	
Florida	261-267	
Florida	589-595	
Florida	766-772	
Georgia	252-260	
Georgia	667-675	
Guam	586	
Hawaii	575-576	
Hawaii	750-751	
Idaho	518-519	
Illinois	318-361	
Indiana	303-317	
Iowa	478-485	
Kansas	509-515	
Kentucky	400-407	
Louisiana	433-439	
Louisiana	659-665	
Maine	004-007
Maryland	212-220
Massachusetts	010-034
Michigan	362-386
Minnesota	468-477
Mississippi	425-428
Mississippi	587-588
Mississippi	752-755
Missouri	486-500
Montana	516-517
Nebraska	505-508
Nevada	530,680
New Hampshire	001-003
New Jersey	135-158
New Mexico	525,585
New Mexico	648-649
New York	050-134	
North Carolina	232	
North Carolina	237-246	
North Carolina	681-690	
North Dakota	501-502	
Ohio	268-302	
Oklahoma	440-448	
Oregon	540-544	
Pennsylvania	159-211	
Philippine Islands	586	
Puerto Rico	580-584	
Puerto Rico	596-599	
Railroad Board**	700-728	discontinued July 1, 1963
Rhode Island	035-039	
South Carolina	247-251	
South Carolina	654-658	
South Dakota	503-504
Tennessee	408-415
Tennessee	756-763
Texas	449-467
Texas	627-645
Utah	528-529
Utah	646-647
Vermont	008-009
Virgin Islands	580
Virginia	223-231
Virginia	691-699
Washington	531-539
West Virginia	232-236
Wisconsin	387-399
Wyoming	520
*/
h:=header.file_headers;
r:=record
h.did;
h.ssn;
boolean legacy;
end;
export Append_SSN_flags(dataset(r) in_hdr) := Module

import ut,ssnissue2;

shared has_ssn := in_hdr(ssn<>'');
shared no_ssn  := in_hdr(ssn ='');

shared r1 := record
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

export Legacy_SSN := concat;


//////////////////////////////////////////////////////////////////
 r1 x1(has_ssn le) := transform
 
 boolean is_partial             := ut.partial_ssn(le.ssn);
 boolean is_itin                := le.ssn[1]='9' and le.ssn[4] in ['7','8'];
 boolean is_666                 := le.ssn[1..3]='666';
 boolean is_eae                 := le.ssn[1..3] between '729' and '733';
 boolean is_advertising         := le.ssn between '987654320' and '987654329';
 boolean is_woolworth           := le.ssn='078051120';
 boolean is_invalid_area        := le.ssn[1..3]= '000' and is_partial=false and is_itin=false;
 boolean is_invalid_group       := le.ssn[4..5]=  '00' and is_partial=false and is_itin=false;
 boolean is_invalid_serial      := le.ssn[6..9]='0000'                      and is_itin=false;
 
 string10 concat_flags := if(is_partial,           'P',' ')
                        + if(is_itin   ,           'I',' ')
				        + if(is_666    ,           '6',' ')
					    + if(is_eae    ,           'E',' ')
				        + if(is_advertising,       'V',' ')
				        + if(is_woolworth  ,       'W',' ')
				        + if(is_invalid_area,      'A',' ')
				        + if(is_invalid_group,     'G',' ')
				        + ' '
					    + if(is_invalid_serial,    'S',' ')
						;
 
 self.ssn_is_invalid := if(concat_flags<>'' and is_partial=false and is_itin=false and is_eae=false,true,
                        if(is_eae=true and is_invalid_serial,true,
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
						 +0
						 +if(is_invalid_serial,    header.constants.ssn_indicators.is_invalid_serial,0)
						 ;
																																		
 self := le;
 
end;

j1 := project(has_ssn,x1(left));

concat := j1+project(no_ssn,r1);

export Randomized_SSN := concat;

end;