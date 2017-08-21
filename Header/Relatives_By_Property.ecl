/*					Relatives_By_Property
==============================================================	
PURPOSE:	Generate did pairs on the same property fares_id.
		Use self join of Property.File_Fares_DID_Out.
*/

import Property,ln_property,ut,ln_propertyv2;

prop_srch := ln_propertyv2.File_Search_DID;
//prop_srch := dataset(ut.foreign_prod+ln_property.fileNames.qaPropertyDID, ln_property.Layout_DID_Out,flat);

RecPropDidSlim := RECORD
 unsigned6 did := (unsigned6)prop_srch.did;
 prop_srch.ln_fares_id;
 prop_srch.lname;
 prop_srch.source_code; //Later only join 2 people of same source_code.
END;

myDs := prop_srch;
slim10 := table(myDs, RecPropDidSlim);

//Some processing:fileter and dedup.
slim11 := distribute(slim10(did!=0),hash(ln_fares_id));
slim12 := sort(slim11, ln_fares_id, did, lname, local);
slim := Dedup(slim12, ln_fares_id, did, lname, local);

//Join to find pairs of people on same fares.
header.layout_relatives_v2.temp joinFunc(slim fileL, slim fileR) := TRANSFORM
	self.person1 := fileL.did;
  self.person2 := fileR.did;
  self.prim_range := -5; //Seems a marker for source of relative.
  self.zip := -5;
  self.same_lname := fileL.lname = fileR.lname;
  self.recent_cohabit := 0;
  self.number_cohabits := 3;
  self.ln_fares_id := fileL.ln_fares_id;
END;

//source_code field: XY -> X is Owner/Seller. Y -> Owner..Buyer / Seller Address
//source_code equal: both are buyers, or both are sellers. See Property.Layout_Fares_Search.
dsSlim21 := join(slim, slim,
	(left.ln_fares_id = right.ln_fares_id) 
		and (left.source_code[1] = right.source_code[1])
		and (left.did > right.did), //Romove redundant pairs of self join.
	joinFunc(left, right), local);

//Dedup. Prefer the record with non-zero same_lname. 
RelPropD := distribute(dsSlim21, hash(person1));
RelPropS := dedup(sort(RelPropD, person1, person2, -((integer1)same_lname), local),person1, person2,ln_fares_id,local);

export Relatives_By_Property := dedup(RelPropS,
		person1, person2, keep 5,local)
	: PERSIST('PERSIST::Relatives_Property');
