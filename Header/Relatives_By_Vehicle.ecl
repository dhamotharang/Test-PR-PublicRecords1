/*					Relatives_By_Vehicle
==============================================================	
PURPOSE: Generate did pairs on the same vehicle registration or ownership 
	by normalization.
	
NOTES:	Does not do ut.MAC_Remove_Withdups, since they should qualify 
	for associate.
*/

import VehLic;

//Slim down.
RecVehSlim := RECORD
	VehLic.File_Vehicles.own_1_did;
	VehLic.File_Vehicles.own_1_lname;
	VehLic.File_Vehicles.reg_1_did;
	VehLic.File_Vehicles.reg_1_lname;
	VehLic.File_Vehicles.own_2_did;
	VehLic.File_Vehicles.own_2_lname;
	VehLic.File_Vehicles.reg_2_did;
	VehLic.File_Vehicles.reg_2_lname;
END;

TbVehSlim:=table(VehLic.File_Vehicles, RecVehSlim);

/*Normalize: split one vehicle record to 6 did pairs.
	c			1				2				3				4				5				5
	did1	own_1 	own_1		own_1		own_2		own_2		reg_1
	did2	own_2		reg_1		reg_2		reg_1		reg_2		reg_2
*/
RecNorm := RECORD
	unsigned6 did1 := 0;
	qstring20 lname1 := '';
	unsigned6 did2 := 0;
	qstring20 lname2 := '';
END;

RecNorm normFunc(RecVehSlim fileL, integer c) := TRANSFORM
	self.did1 := (unsigned6)choose(c, 
			fileL.own_1_did, fileL.own_1_did, fileL.own_1_did,
			fileL.own_2_did, fileL.own_2_did, fileL.reg_1_did);
	self.lname1 := choose(c, 
			fileL.own_1_lname, fileL.own_1_lname, fileL.own_1_lname,
			fileL.own_2_lname, fileL.own_2_lname, fileL.reg_1_lname);
	self.did2 := (unsigned6) choose(c,
			fileL.own_2_did, fileL.reg_1_did, fileL.reg_2_did,
			fileL.reg_1_did, fileL.reg_2_did, fileL.reg_2_did);
	self.lname2 := choose(c, 
			fileL.own_2_lname, fileL.reg_1_lname, fileL.reg_2_lname,
			fileL.reg_1_lname, fileL.reg_2_lname, fileL.reg_2_lname);
END;

DidPair := normalize(
	TbVehSlim,
	6,
	normFunc(left, counter));

//Filter, only keep records with 2 distinct did.
DidPair10 := DidPair(
	did1 != 0, did2 != 0,
	did1 != did2);

//Make did1 the larger did
largerDid(unsigned6 did1, unsigned6 did2) := 
	if(did1 > did2, did1, did2);
smallerDid(unsigned6 did1, unsigned6 did2) := 
	if(did1 < did2, did1, did2);
Layout_Relatives projectFunc(DidPair10 fileL) := TRANSFORM
	self.person1 := largerDid(fileL.did1, fileL.did2);
  self.person2 := smallerDid(fileL.did1, fileL.did2);
  self.prim_range := -6; //marker for vehicle. For roll-up in Relatives.
  self.zip := -6;
  self.same_lname := fileL.lname1 = fileL.lname2;
  self.recent_cohabit := 0;
  self.number_cohabits := 3;
END;

relVeh := project(
	DidPair10,
	projectFunc(left));

//Dedup. Prefer the record with non-zero same_lname. 
relVehD := distribute(relVeh, hash(person1));
relVehS := sort(relVehD, person1, person2, -((integer1)same_lname), local);
export Relatives_By_Vehicle := dedup(
	relVehS, person1, person2, local)
	: PERSIST('PERSIST::Relatives_Vehicle');
