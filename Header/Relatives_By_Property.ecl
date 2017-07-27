/*					Relatives_By_Property
==============================================================	
PURPOSE:	Generate did pairs on the same property fares_id.
		Use self join of Property.File_Fares_DID_Out.
*/

import Property;

RecPropDidSlim := RECORD
	unsigned6 did := (unsigned6)Property.File_Fares_DID_Out.did;
	Property.File_Fares_DID_Out.fares_id;
  Property.File_Fares_DID_Out.lname;
  Property.File_Fares_DID_Out.source_code; //Later only join 2 people of same source_code.
END;

myDs := Property.File_Fares_DID_Out;
slim10 := table(myDs, RecPropDidSlim);

//Some processing:fileter and dedup.
slim11 := distribute(slim10(did!=0),hash(fares_id));
slim12 := sort(slim11, fares_id, did, lname, local);
slim := Dedup(slim12, fares_id, did, lname, local);

//Join to find pairs of people on same fares.
Layout_Relatives joinFunc(slim fileL, slim fileR) := TRANSFORM
	self.person1 := fileL.did;
  self.person2 := fileR.did;
  self.prim_range := -5; //Seems a marker for source of relative.
  self.zip := -5;
  self.same_lname := fileL.lname = fileR.lname;
  self.recent_cohabit := 0;
  self.number_cohabits := 3;
END;

//source_code field: XY -> X is Owner/Seller. Y -> Owner..Buyer / Seller Address
//source_code equal: both are buyers, or both are sellers. See Property.Layout_Fares_Search.
dsSlim21 := join(slim, slim,
	(left.fares_id = right.fares_id) 
		and (left.source_code[1] = right.source_code[1])
		and (left.did > right.did), //Romove redundant pairs of self join.
	joinFunc(left, right), local);

//Dedup. Prefer the record with non-zero same_lname. 
RelPropD := distribute(dsSlim21, hash(person1));
RelPropS := sort(RelPropD, person1, person2, -((integer1)same_lname), local);

export Relatives_By_Property := dedup(RelPropS,
		person1, person2, local)
	: PERSIST('PERSIST::Relatives_Property');
