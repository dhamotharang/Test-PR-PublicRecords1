import doxie, dx_header, gong, ut;

export mod_gong_records(
	dataset(doxie.layout_references) dids):=
FUNCTION

layout_res := RECORD
	gong.Layout_bscurrent_raw;
	unsigned6 did := 0;
END;

iKeep := ut.limits.default;

// DID and HHID lookups
kh := dx_header.key_did_hhid();

layout_hid := RECORD
	UNSIGNED8 hhid_relat;
END;

layout_hid TakeHHID(kh l) := TRANSFORM
	SELF := l;
END;
hhids := DEDUP(JOIN(dids, kh, keyed(LEFT.did = RIGHT.did), TakeHHID(RIGHT), keep(ikeep)), hhid_relat, ALL);

// Find gong records by did or hhid
kghh := gong.Key_HHID;

layout_res TakeGongByHHID(kghh r) := 
TRANSFORM
	SELF := r;
	self := [];
END;
reshhid := JOIN(hhids, kghh, keyed(LEFT.hhid_relat = RIGHT.s_hhid), TakeGongByHHID(RIGHT), keep(ikeep));



kgdid := gong.Key_DID;

layout_res TakeGongByDID(dids l,kgdid r) :=
TRANSFORM
	self.did := l.did;
	SELF := r;
	self := [];
END;
resdid := JOIN(dids, kgdid, keyed(LEFT.did = RIGHT.l_did), TakeGongByDID(left, RIGHT), keep(ikeep));

return resdid;

END;