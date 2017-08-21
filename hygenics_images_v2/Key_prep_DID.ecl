import Data_Services;

all_images := hygenics_images_v2.File_Images_KeyBuilding(did != 0, imglength != 0);

	LayoutNoPhoto := RECORD
		all_images.did;
		all_images.state;
		all_images.rtype;
		all_images.id;
		all_images.seq;
		all_images.num;
		all_images.date;
		all_images.imgLength;
		all_images.__filepos;
	END;

	LayoutNoPhoto removephoto(all_images L) := TRANSFORM
		SELF := L;
	END;
	
	noPh 	:= PROJECT(all_images, removephoto(LEFT));
    noPhoto	:= dedup(sort(noPh, state, -rtype, did), did);
	
	dist 	:= DISTRIBUTE(noPhoto, HASH(state, rtype, id));

	// Sort by (basically) unique ID and newest date first
	sortInfo := sort(dist, state, rtype, id, -date, LOCAL);

	LayoutNoPhoto addSequence(LayoutNoPhoto L, LayoutNoPhoto R, unsigned c) := TRANSFORM
		SELF.seq := c-1;
		SELF := R;
	END;

	LayoutNoPhoto copySequence(LayoutNoPhoto L, LayoutNoPhoto R, unsigned c) := TRANSFORM
		SELF.num := IF (c=1, R.seq+1, L.num);
		SELF := R;
	END;

	// Group by (basically) unique ID
	groupInfo := group(sortInfo, state, rtype, id, LOCAL);

	// Add sequence numbers such that the newest date gets lowest sequence number of 0
	sequenceAdded := iterate(groupInfo, addSequence(LEFT, RIGHT, counter));

	// Add num - the number of records per unique ID
	numbered := iterate(sort(sequenceAdded, date), copySequence(LEFT, RIGHT, COUNTER))(did != 0);

i := INDEX(numbered,,Data_Services.Data_location.Prefix('Provider') + 'criminal_images_v2::key::Matrix_Images_did'+thorlib.wuid());

export Key_Prep_DID := i;