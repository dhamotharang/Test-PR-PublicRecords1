BOOLEAN isSSNChanged(Layout_Delta x) := x.SSN != '';

BOOLEAN isNameChanged(Layout_Delta x) := (x.title != '' or
										  x.lname != '' or 
										  x.fname != '' or
										  x.mname != '' or
										  x.name_suffix != '');

BOOLEAN isAddressChanged(Layout_Delta x) := (x.prim_range != '' or
											 x.predir != '' or
											 x.prim_name != '' or
											 x.suffix != '' or
											 x.postdir != '' or
											 x.unit_desig != '' or
											 x.sec_range != '' or
											 x.city_name != '' or
											 x.st != '' or
											 x.zip != '' or
											 x.zip4 != '');

BOOLEAN isPhoneChanged(Layout_Delta x) := x.phone != '';

BOOLEAN isDeathStatChanged (Layout_Delta x) := x.DOD != '';

fdelta := distribute(file_delta,hash(did));

DistSampleWid := distribute(SampleWid,hash(DID));

ResultsFileFmt JoinX(fdelta Lft,SampleWid Rght) := TRANSFORM
	SELF.FTD := Rght.FirstTrackDate;
	Self.MRTD := Rght.MostRcntTrackDate;
	SELF.TUD := Rght.TrackUptoDate;
	SELF := Lft;
	SELF := Rght;
	
END;

interfile1 := JOIN(fdelta,DistSampleWid,
						(LEFT.did = RIGHT.did 
						  and
						(INTEGER)Right.FirstTrackDate <= LEFT.Run_Date and
						(INTEGER)RIGHT.TrackUptoDate >= LEFT.Run_Date ) 
						  and
						(((RIGHT.changeName or RIGHT.newName or 
						 RIGHT.FIrstNameOnly) and isNameChanged(LEFT)) 
						  or
						 ((RIGHT.changeAddress or RIGHT.newAddress or
							RIGHT.FirstAddressOnly) and isAddressChanged(LEFT))
						  or
						 ((RIGHT.changeSSN or RIGHT.newSSN or RIGHT.FirstSSNOnly)
							and isSSNChanged(LEFT))
						  or
						 ((RIGHT.changePhone or RIGHT.newPhone or 
							RIGHT.FirstPhoneOnly) and isPhoneChanged(LEFT))
						  or
						 (RIGHT.DeathStatus and isDeathStatChanged(LEFT))),
						JoinX(LEFT,RIGHT),local);

// assigned did is not relevant (anymore?)
/*fdelta2 := distribute(file_delta(assigned_did!=0, assigned_did!=1),hash(assigned_did));

interfile2 := JOIN(fdelta2,DistSampleWid,
					(RIGHT.did = LEFT.assigned_did and
					(INTEGER)Right.FirstTrackDate <= LEFT.Run_Date and
					(INTEGER)RIGHT.TrackUptoDate >= LEFT.Run_Date )and
					(((RIGHT.changeName or RIGHT.newName or 
						 RIGHT.FIrstNameOnly) and isNameChanged(LEFT)) 
						  or
						 ((RIGHT.changeAddress or RIGHT.newAddress or
							RIGHT.FirstAddressOnly) and isAddressChanged(LEFT))
						  or
						 ((RIGHT.changeSSN or RIGHT.newSSN or RIGHT.FirstSSNOnly)
							and isSSNChanged(LEFT))
						  or
						 ((RIGHT.changePhone or RIGHT.newPhone or 
							RIGHT.FirstPhoneOnly) and isPhoneChanged(LEFT))
						  or
						 (RIGHT.DeathStatus and isDeathStatChanged(LEFT))),
					JoinX(LEFT,RIGHT),local);

*/

export getDIDfromDelta := interfile1; // + interfile2;