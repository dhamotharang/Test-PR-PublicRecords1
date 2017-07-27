import Data_Services;
all_images := File_Images_KeyBuilding(did != 0, imglength != 0);

LayoutNoPhoto :=
RECORD
 	all_images.did;
	all_images.state;
	all_images.rtype;
	all_images.booking_sid;
	all_images.seq;
	all_images.num;
	all_images.date;
	all_images.imgLength;
	all_images.__filepos;
END;

dist := DISTRIBUTE(all_images, HASH(booking_sid,image_link));

// Sort by (basically) unique ID and newest date first
sortInfo := sort(dist, booking_sid,image_link , LOCAL);

sortInfo addSequence(sortInfo L, sortInfo R, unsigned c) := TRANSFORM
	SELF.seq := MAP(R.image_link[1..1] = 'F' => 0,1);
	SELF := R;
END;

sortInfo copySequence(sortInfo L, sortInfo R, unsigned c) := TRANSFORM
	SELF.num := c;
	SELF := R;
END;

// Group by (basically) unique ID
groupInfo := group(sortInfo,booking_sid, LOCAL);
// Add sequence numbers such that the front image gets 0 and profile image gets 1
sequenceAdded := iterate(groupInfo, addSequence(LEFT, RIGHT, counter));
// Add num - the number of records per unique ID
numbered := iterate(sequenceAdded, copySequence(LEFT, RIGHT, COUNTER))(did != 0);

LayoutNoPhoto removephoto(numbered L) :=
TRANSFORM
	SELF := L;
END;
noPhoto := PROJECT(numbered, removephoto(LEFT));

i := INDEX(noPhoto,,  Data_Services.Data_location.Prefix('Appriss') + 'Appriss_images::key::Matrix_Images_did'+thorlib.wuid());

export key_prep_did := i;