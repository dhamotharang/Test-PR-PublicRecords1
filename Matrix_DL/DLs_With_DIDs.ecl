import did_add;
//dl_file := DL_Joined;

lMatchSet := ['A','D','S'];

DID_Add.MAC_Match_Flex
	(DL_Joined, lMatchSet,						//see above
	 ssn, dob, fname, mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, zip5, st, JUNK,
	 DID,   			//if bool = false, then put junk in corresponding _field
	 Layout_Common,
	 false, DID_Score_field, //these should default to zero in definition
	 75,
	 res)

Matrix_DL.Layout_Common lFieldTransform(Matrix_DL.Layout_Common l)
 :=
  transform
	self.ssn_safe 	:= l.ssn;
	self 			:= l;
  end;

res_safe := PROJECT(res, lFieldTransform(left));

DID_Add.MAC_Add_SSN_By_DID(res_safe,did,ssn,With_SSN)

export DLs_With_DIDs := With_SSN : persist('Persist::Matrix_DLs_With_DIDs');
