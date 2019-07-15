import doxie, data_services;


EXPORT Keys := MODULE

//Building DID Keys
 noPhoto	:= dedup(sort(files.keyfile_did, state, -rtype, did), did);
	dist 	:= DISTRIBUTE(noPhoto, HASH(state, rtype, id));

	// Sort by (basically) unique ID and newest date first
	sortInfo := sort(dist, state, rtype, id, -date, LOCAL);

	layouts.key_did 	addSequenceDID(layouts.key_did L,	layouts.key_did R, unsigned c) := TRANSFORM
		SELF.seq := c-1;
		SELF := R;
	END;

	layouts.key_did copySequenceDID(layouts.key_did L, layouts.key_did R, unsigned c) := TRANSFORM
		SELF.num := IF (c=1, R.seq+1, L.num);
		SELF := R;
	END;

	// Group by (basically) unique ID
	groupInfo := group(sortInfo, state, rtype, id, LOCAL);

	// Add sequence numbers such that the newest date gets lowest sequence number of 0
	sequenceAdded := iterate(groupInfo, addSequenceDID(LEFT, RIGHT, counter));

	// Add num - the number of records per unique ID
	shared numbered := iterate(sort(sequenceAdded, date), copySequenceDID(LEFT, RIGHT, COUNTER))(did != 0);
	
export DID	:= INDEX(numbered,,Data_Services.Data_location.Prefix('') + Constants.keyname + doxie.Version_SuperKey+ '::Matrix_Images_did');


//
	distPhotoID := DISTRIBUTE(files.keyfile_id, HASH(state, rtype, id));

	// Sort by (basically) unique ID and newest date first
	srtPhotoID := sort(distPhotoID, state, rtype, id, -date, LOCAL);

 // Group by (basically) unique ID
	grpPhotoID := group(srtPhotoID, state, rtype, id, LOCAL);
	
	Layouts.Key_id addSequence(Layouts.Key_id L, Layouts.Key_id R, unsigned c) := TRANSFORM
		SELF.seq := c-1;
		SELF := R;
	END;

	Layouts.Key_id copySequence(Layouts.Key_id L, Layouts.Key_id R, unsigned c) := TRANSFORM
		SELF.num := IF (c=1, R.seq+1, L.num);
		SELF := R;
	END;
	
		// Add sequence numbers such that the newest date gets lowest sequence number of 0
	sequenceAdded_ID := iterate(grpPhotoID, addSequence(LEFT, RIGHT, counter));
	
	// Add num - the number of records per unique ID
	numberedID := iterate(sort(sequenceAdded_ID, date), copySequence(LEFT, RIGHT, COUNTER));

export images := INDEX(numberedID,, Data_Services.Data_location.Prefix('')+ Constants.keyname+ doxie.Version_SuperKey+ '::Matrix_Images');



//Building CriminalImage V2 Keys
// DID Key
 noPhoto	:= dedup(sort(files.keyfile_did_v2, state, -rtype, did), did);
	
	distPhone_v2 	:= DISTRIBUTE(noPhoto, HASH(state, rtype, id));

	// Sort by (basically) unique ID and newest date first
	srtPhone_v2 := sort(distPhone_v2, state, rtype, id, -date, LOCAL);

	layouts.key_did_v2 	addSequenceDID_v2(layouts.key_did L,	layouts.key_did R, unsigned c) := TRANSFORM
		SELF.seq := c-1;
		SELF := R;
	END;

	layouts.key_did_v2 copySequenceDID_v2(layouts.key_did L, layouts.key_did R, unsigned c) := TRANSFORM
		SELF.num := IF (c=1, R.seq+1, L.num);
		SELF := R;
	END;

	// Group by (basically) unique ID
	grpPhoneInfo := group(srtPhone_v2, state, rtype, id, LOCAL);

	// Add sequence numbers such that the newest date gets lowest sequence number of 0
	seqPhoneAdded_v2 := iterate(grpPhoneInfo, addSequenceDID_v2(LEFT, RIGHT, counter));

	// Add num - the number of records per unique ID
	PhoneNumbered_v2 := iterate(sort(seqPhoneAdded_v2, date), copySequenceDID_v2(LEFT, RIGHT, COUNTER))(did != 0);
	export DID_v2 := INDEX(PhoneNumbered_v2,,Data_Services.Data_location.Prefix('') + Constants.keyname_v2 + doxie.Version_SuperKey+ '::Matrix_Images_did');



//Building ID Key
		distPhotoID_v2 := DISTRIBUTE(files.keyfile_id_v2, HASH(state, rtype, id));

	// Sort by (basically) unique ID and newest date first
	srtPhotoID_v2 := sort(distPhotoID_v2, state, rtype, id, -date, LOCAL);

	Layouts.Key_id_v2 addSequenceV2(Layouts.Key_id L, Layouts.Key_id R, unsigned c) := TRANSFORM
		SELF.seq := c-1;
		SELF := R;
	END;

	Layouts.Key_id_v2 copySequenceV2(Layouts.Key_id L, Layouts.Key_id R, unsigned c) := TRANSFORM
		SELF.num := IF (c=1, R.seq+1, L.num);
		SELF := R;
	END;

	// Group by (basically) unique ID
	grpPhotoID_V2 := group(srtPhotoID_v2, state, rtype, id, LOCAL);
	
	// Add sequence numbers such that the newest date gets lowest sequence number of 0
	seqPhotoAddedID_v2 := iterate(grpPhotoID_V2, addSequenceV2(LEFT, RIGHT, counter));
	
	// Add num - the number of records per unique ID
	PhotoNumberedID_V2 := iterate(sort(seqPhotoAddedID_v2, date), copySequenceV2(LEFT, RIGHT, COUNTER));

export Images_v2 := INDEX(PhotoNumberedID_V2,, Data_Services.Data_location.Prefix('')+ Constants.keyname_v2+doxie.Version_SuperKey+ '::Matrix_Images');


end;
