import Address, ut;

export Mod_TNT_C := Module

	shared layoutHistory 			:= CompId_Services.Layouts.Layout_History;
	shared layoutCompIdResult	:= CompId_Services.Layouts.Layout_CompId_Result;	

	export getResultFromHeader (grouped dataset(layoutHistory) inputs, STRING1 resType) := FUNCTION 

		SortedAddressForDates := sort(inputs, prim_range, addr, city, state, zip);

		layoutHistory GetBestValues(layoutHistory l, layoutHistory r) := transform
			self.dt_first_seen := if(l.dt_first_seen <= r.dt_first_seen, l.dt_first_seen, r.dt_first_seen);
			self.dt_last_seen  := if(l.dt_last_seen >= r.dt_last_seen, l.dt_last_seen, r.dt_last_seen );
			self               := if(l.zip4 = '', r, l);
		end;

		AHist2 := ROLLUP(SortedAddressForDates, getBestValues(left, right), seq, prim_range, addr, city, state, zip);

		layoutHistory SetMaxSeen(layoutHistory l) := transform
			self.dt_max_seen := if(l.dt_first_seen >= l.dt_last_seen, l.dt_first_seen, l.dt_last_seen);  
			self             := l;	
		end;

		MaxSeen := project(AHist2, SetMaxSeen(Left)); 
		AHist3 := sort(MaxSeen, -dt_max_seen);

		// Ignore Deceased Records
		Ahist4	:= Ahist3(~Address.isDeathRecord(addr));

		layoutHistory RemoveEmptyDobSsnGenderRecs (layoutHistory l, layoutHistory r) := transform
			SELF.dob 		:= IF (l.dob = 0, r.dob, l.dob); 
			SELF.ssn 		:= IF (l.ssn = '', r.ssn, l.ssn); 
			SELF.gender := IF (l.gender = '', r.gender, l.gender); 
			SELF := L;
		END;

		SortedNames := ROLLUP(AHist4, RemoveEmptyDobSsnGenderRecs(left, right), true);

		NameFormat := RECORD
			UNSIGNED6 did 				:= SortedNames.did;
			UNSIGNED6 seq 				:= SortedNames.seq;
			STRING20 fname 				:= SortedNames.fname;
			STRING20 mname 				:= SortedNames.mname;
			STRING20 lname 				:= SortedNames.lname;
			STRING5 name_suffix 	:= SortedNames.name_suffix;
			STRING9 ssn 					:= SortedNames.ssn;
			UNSIGNED4	dob 				:= ut.Date_MMDDYYYY_I2((STRING)SortedNames.dob);
			STRING1	gender 				:= SortedNames.gender;
			UNSIGNED3 dt_max_seen := SortedNames.dt_max_seen;	
			UNSIGNED3	score				:= SortedNames.score;
			UNSIGNED4	dod 				:= SortedNames.dod;
		END;

		ExplicitNames := TABLE (SortedNames, NameFormat); // Vertical Slice of Names only  

		// Time to create Vertical slices for addresses, licenses (not coded)
		AddressFormat := RECORD
			UNSIGNED6   did 					:= AHist4.did;
			STRING10		prim_range 		:= AHist4.prim_range;
			STRING36    addr 					:= AHist4.addr;
			STRING18    unit 					:= AHist4.sec_range;
			STRING25    city 					:= AHist4.city;
			STRING2     state 				:= AHist4.state;
			STRING5     zip 					:= AHist4.zip;
			STRING4     zip4 					:= AHist4.zip4;
			UNSIGNED3   dt_first_seen	:= AHist4.dt_first_seen;
			UNSIGNED3   dt_max_seen 	:= AHist4.dt_max_seen;	
		END;

		ExplicitAddresses := TABLE (AHist4, AddressFormat); // Vertical Slice of Addresses only  

		// Now time to prepare parent record using names and did
		layoutCompIdResult BuildParentUsingNames (ExplicitNames L) := TRANSFORM
				SELF.DID 					:= L.DID;
				SELF.seq 					:= l.seq;
				SELF.name_first 	:= l.fname;
				SELF.name_middle 	:= l.mname;
				SELF.name_last 		:= l.lname;
				SELF.name_suffix 	:= l.name_suffix;
				SELF.ssn 					:= l.ssn;
				SELF.gender 			:= l.gender;
				SELF.dob 					:= L.dob;
				SELF.DOD 					:= L.dod;
				SELF.score				:= L.score;
				SELF.resType			:= resType;
				SELF := [];
		END;

		ParentRecsUsingNames := PROJECT (ExplicitNames, BuildParentUsingNames(LEFT));

		layoutCompIdResult BuildChildrenUsingAddresses (layoutCompIdResult L, ExplicitAddresses R, INTEGER C) := TRANSFORM
				SELF.DID := L.DID;

				SELF.currentAddress.prim_range 		:= IF (C = 1, r.prim_range, l.currentAddress.prim_range);
				SELF.currentAddress.addr 					:= IF (C = 1, r.addr, l.currentAddress.addr);
				SELF.currentAddress.unit 					:= IF (C = 1, r.unit, l.currentAddress.unit);
				SELF.currentAddress.city 					:= IF (C = 1, r.city, l.currentAddress.city);
				SELF.currentAddress.state 				:= IF (C = 1, r.state, l.currentAddress.state);
				SELF.currentAddress.zip 					:= IF (C = 1, r.zip, l.currentAddress.zip);
				SELF.currentAddress.zip4 					:= IF (C = 1, r.zip4, l.currentAddress.zip4);
				SELF.currentAddress.dt_first_seen := IF (C = 1, r.dt_first_seen, l.currentAddress.dt_first_seen);
				SELF.currentAddress.dt_max_seen 	:= IF (C = 1, r.dt_max_seen, l.currentAddress.dt_max_seen);

				SELF.priorAddress1.prim_range 		:= IF (C = 2, r.prim_range, l.priorAddress1.prim_range);
				SELF.priorAddress1.addr 					:= IF (C = 2, r.addr, l.priorAddress1.addr);
				SELF.priorAddress1.unit 					:= IF (C = 2, r.unit, l.priorAddress1.unit);
				SELF.priorAddress1.city 					:= IF (C = 2, r.city, l.priorAddress1.city);
				SELF.priorAddress1.state 					:= IF (C = 2, r.state, l.priorAddress1.state);
				SELF.priorAddress1.zip						:= IF (C = 2, r.zip, l.priorAddress1.zip);
				SELF.priorAddress1.zip4 					:= IF (C = 2, r.zip4, l.priorAddress1.zip4);
				SELF.priorAddress1.dt_first_seen 	:= IF (C = 2, r.dt_first_seen, l.priorAddress1.dt_first_seen);
				SELF.priorAddress1.dt_max_seen 		:= IF (C = 2, r.dt_max_seen, l.priorAddress1.dt_max_seen);

				SELF.priorAddress2.prim_range 		:= IF (C = 3, r.prim_range, l.priorAddress2.prim_range);
				SELF.priorAddress2.addr 					:= IF (C = 3, r.addr, l.priorAddress2.addr);
				SELF.priorAddress2.unit 					:= IF (C = 3, r.unit, l.priorAddress2.unit);
				SELF.priorAddress2.city 					:= IF (C = 3, r.city, l.priorAddress2.city);
				SELF.priorAddress2.state 					:= IF (C = 3, r.state, l.priorAddress2.state);
				SELF.priorAddress2.zip 						:= IF (C = 3, r.zip, l.priorAddress2.zip);
				SELF.priorAddress2.zip4 					:= IF (C = 3, r.zip4, l.priorAddress2.zip4);
				SELF.priorAddress2.dt_first_seen 	:= IF (C = 3, r.dt_first_seen, l.priorAddress2.dt_first_seen);
				SELF.priorAddress2.dt_max_seen 		:= IF (C = 3, r.dt_max_seen, l.priorAddress2.dt_max_seen);

				SELF.priorAddress3.prim_range 		:= IF (C = 4, r.prim_range, l.priorAddress3.prim_range);
				SELF.priorAddress3.addr 					:= IF (C = 4, r.addr, l.priorAddress3.addr);
				SELF.priorAddress3.unit 					:= IF (C = 4, r.unit, l.priorAddress3.unit);
				SELF.priorAddress3.city 					:= IF (C = 4, r.city, l.priorAddress3.city);
				SELF.priorAddress3.state 					:= IF (C = 4, r.state, l.priorAddress3.state);
				SELF.priorAddress3.zip 						:= IF (C = 4, r.zip, l.priorAddress3.zip);
				SELF.priorAddress3.zip4 					:= IF (C = 4, r.zip4, l.priorAddress3.zip4);
				SELF.priorAddress3.dt_first_seen 	:= IF (C = 4, r.dt_first_seen, l.priorAddress3.dt_first_seen);
				SELF.priorAddress3.dt_max_seen 		:= IF (C = 4, r.dt_max_seen, l.priorAddress3.dt_max_seen);

				SELF := L;
		END;

		ChildRecsUsingAddresss := DENORMALIZE (ParentRecsUsingNames, ExplicitAddresses, 
																					 LEFT.DID = RIGHT.DID,
																					 BuildChildrenUsingAddresses(LEFT, RIGHT, COUNTER));

		// Let's build stats at end using last good best rec 
		layoutCompIdResult BuildStats (ChildRecsUsingAddresss L) := TRANSFORM
				SELF.remarks := (STRING)l.DID + ' SSNCount ' + COUNT(DEDUP(SORT(AHist4(SSN != ''), SSN), SSN)) + 
																		' DOBCount '+ COUNT(DEDUP(SORT(AHist4(DOB != 0), DOB), dob));
				SELF := L;
		END;
		
		FinalRec := PROJECT (ChildRecsUsingAddresss, BuildStats(LEFT));
		return FinalRec;
	end;
end;
