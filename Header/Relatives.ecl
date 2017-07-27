/*					Relatives
==============================================================	
Generate did pairs based on same address, ssn, business	associate, 
	property, and vehicle, and being relative of the same 3rd person. 
Split the original address logic to Header.Relatives_By_Address, to avoid 
	repeating the big self join upon changes of other relative conditions.
*/

import business_header;

j := Relatives_By_Address + 
	   Relatives_By_SSN + 											//prim_range:=-1
		 Relatives_By_Relatives + 								//prim_range:=-2
		 business_header.Business_Associates		//prim_range:=-4
		 + Relatives_By_Property	//prim_range is -5.
		 + Relatives_By_Vehicle		//prim_range is -6.
		 ;

dj := distribute(j(number_cohabits>0),hash(person1,person2));

gj := group(dj,person1,person2,all);

sg := sort(gj,prim_range,IF(same_lname,0,1),-number_cohabits,zip);

ds := dedup(sg,prim_range);

rolls := rollup(ds,true, header.tra_roll_relatives(left,right));

export Relatives := rolls(same_lname OR number_cohabits>=6) :persist('relatives_temp');