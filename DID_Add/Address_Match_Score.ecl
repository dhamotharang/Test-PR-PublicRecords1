import ut,address;

// added blank suffix to addressquality calls.....temp fix....david is working
// on the code to score addresses.
/*
 parameters zip14 and zip24 represent the zip4 for both addresses to be compared.
 they were added as part of RQ-14343.  They are at end of the parameter list to not 
 disrupt all the other attributes that already uses this fucntion.
*/
export Address_Match_Score(string prim_range1,string prim_name1, string sec_range1,string zip1,
							string prim_range2,string prim_name2,string sec_range2,string zip2, string zip14 ='', string zip24 ='') := 
MAP(address.AddressQuality(prim_range1,prim_name1,'',sec_range1,'',zip1, zip14)<>0 or
	 address.addressquality(prim_range2,prim_name2,'',sec_range2,'',zip2, zip24)<>0=>255,
	  ut.StringSimilar(zip1,zip2)!=0 or 
	  ut.StringSimilar(prim_name1,prim_name2)!=0 or 
	  ut.StringSimilar(prim_range1,prim_range2)!=0 => 
        (30-3*ut.StringSimilar(zip1,zip2))+
        (40-4*ut.StringSimilar(prim_name1,prim_name2))+
        (20-2*ut.StringSimilar(prim_range1,prim_range2)),
	  ut.stringsimilar(sec_range1,sec_range2)=0 => 100,
	  ut.NNEQ(sec_range1,sec_range2) => 80,
	  sec_range1 != sec_range2=>50,0);
