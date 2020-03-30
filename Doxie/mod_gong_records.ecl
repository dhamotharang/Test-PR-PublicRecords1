import doxie, dx_header, dx_Gong, Suppress, ut;

export mod_gong_records(
	dataset(doxie.layout_references) dids,
  doxie.IDataAccess mod_access):=
FUNCTION

layout_res := RECORD
	dx_Gong.layout_prepped_for_keys;
	unsigned6 did := 0;
END;

layout_res_supp := RECORD
  layout_res;
  UNSIGNED4 global_sid := 0;
  UNSIGNED8 record_sid := 0;
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
kghh := dx_Gong.key_hhid();

layout_res TakeGongByHHID(kghh r) :=
TRANSFORM
	SELF := r;
	self := [];
END;
reshhid := JOIN(hhids, kghh, keyed(LEFT.hhid_relat = RIGHT.s_hhid), TakeGongByHHID(RIGHT), keep(ikeep));

kgdid := dx_Gong.key_did();

layout_res_supp TakeGongByDID(dids l, kgdid r) :=
TRANSFORM
	self.did := l.did;
  self.global_sid := r.global_sid;
  self.record_sid := r.record_sid;
	SELF := r;
	self := [];
END;

_resdid := JOIN(dids, kgdid, keyed(LEFT.did = RIGHT.l_did), TakeGongByDID(left, RIGHT), keep(ikeep));
resdid_suppressed := Suppress.MAC_SuppressSource(_resdid, mod_access);
resdid := PROJECT(resdid_suppressed, layout_res);

return resdid;

END;
