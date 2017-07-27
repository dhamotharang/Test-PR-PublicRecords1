import ut;

_all_images :=  Images.Images_CT_dc +
			 Images.Images_FL_dc + 
			 Images.Images_FL_dl + 
			 Images.Images_GA    + 
			 Images.Images_MI_dc +
			 Images.Images_PA_dc +
			 Images.Images_ARdc_In +
			 Images.Images_IL_dc +
			 Images.Images_KS_dc +
			 Images.Images_KY_dc +
			 Images.Images_MNdc_In +
			 Images.Images_NJ_dc +
			 Images.Images_OKdc_In;

// Make sure the id's are left justified
Images.Layout_Common trimmer(Images.Layout_Common L) :=
TRANSFORM
	SELF.id := TRIM(L.id, ALL);
	SELF := L;
END;
trimmed := PROJECT(_all_images, trimmer(LEFT));

a := output(trimmed,,'base::Matrix_Images'+Images.version, overwrite);

withfilepos :=
RECORD, MAXLENGTH(50000)
	Images.Layout_Common;
	unsigned8 __filepos {virtual(fileposition)};
END;

all_images := dataset('base::Matrix_Images'+Images.version, withfilepos, flat);

LayoutNoPhoto :=
RECORD
// 	all_images.did;
	all_images.state;
	all_images.rtype;
	all_images.id;
	all_images.seq;
	all_images.num;
	all_images.date;
	all_images.imgLength;
	all_images.__filepos;
END;

LayoutNoPhoto removephoto(all_images L) :=
TRANSFORM
	SELF := L;
END;
noPhoto := PROJECT(all_images, removephoto(LEFT));

dist := DISTRIBUTE(noPhoto, HASH(state, rtype, id));

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
numbered := iterate(sort(sequenceAdded, date), copySequence(LEFT, RIGHT, COUNTER));

i := index(numbered, {state, rtype, id, seq, num, date, imgLength, __filepos}, 'key::Matrix_Images'+Images.version);
b := buildindex(i, overwrite);

SEQUENTIAL(a, b);