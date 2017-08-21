import header, did_add;
EXPORT proc_link(dataset(layout_Base2) basein) := FUNCTION

matchset := ['A','Z','D','S'];

did_add.MAC_Match_Flex
	(basein , matchset,
	 clean_ssn,clean_dob, fname, mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, zip, st,'',
	 DID, NAC_V2.layout_Base2, true, did_score,
	 0, ds_did);

did_add.MAC_Add_SSN_By_DID(ds_did,did,best_ssn,out1);
did_add.MAC_Add_DOB_By_DID(out1,did,best_dob,out);


linked := project(out
								,transform(NAC_V2.layout_Base2
									,self.did      :=map(
																			left.did_score < 75 => 0
																			,left.age > 17       => left.did
																			,left.clean_dob > 0 and left.best_dob > 0
																				and header.sig_near_dob(left.clean_dob,left.best_dob)
																													 => left.did
																			,0
																			)
									,self.did_score:=if(self.did=0,0,left.did_score)
									,self:=left
									))
									;


RETURN linked;


END;