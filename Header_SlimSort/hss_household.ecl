IMPORT header, address, UT, mdr,prte2_header;

h := header.file_headers(lname != '' and ~mdr.sourceTools.SourceIsTransUnion(src)); //propagated_matchrecs(lname != '');

hh_f := distribute(header.HHID_Table_Final, hash(did));
hh := dedup(sort(hh_f, did, -last_current, local), did, local);

header.MAC_Best_Address(h, did, 1, ba)

layout_lname := RECORD
	h.did;
	h.lname;
	h.prim_range;
	h.prim_name;
	h.sec_range;
	h.zip;
	h.st;
	hh.addr_id;
//	hh.hhid_indiv;
	hh.hhid_relat;
	UNSIGNED1 addr_id_match := 1;
END;

layout_lname TakeLname(h l) := TRANSFORM
	SELF.prim_name := '';
	SELF.prim_range := '';
	SELF.sec_range := '';
	SELF.zip := '';
	SELF.st := '';
	SELF.addr_id := (DATA10) '';
	SELF.hhid_relat := 0;
	SELF := l;
END;

h_l := DISTRIBUTE(
	PROJECT(DEDUP(h, did, lname, ALL), TakeLname(LEFT)), HASH(did));

// Join to hhid.
layout_lname TakeHHid(h_l l, hh r) := TRANSFORM
	SELF := r;
	SELF := l;
END;

h_l_hh := JOIN(h_l, hh,
	LEFT.did = RIGHT.did,
	TakeHHid(LEFT, RIGHT), LOCAL);
	
// Join to best address.
layout_lname TakeAddress(h_l_hh l, ba r) := TRANSFORM
	SELF.lname := l.lname;
	SELF.addr_id_match := IF(l.addr_id = header.AddressID_fromparts(
		r.prim_range, r.predir, r.prim_name, r.suffix, r.postdir,
		r.sec_range, r.zip, r.st), 0, 1);		
	SELF := r;
	SELF := l;
END;

h_l_hh_a := JOIN(h_l_hh, ba(st != ''),
	LEFT.did = RIGHT.did,
	TakeAddress(LEFT, RIGHT), LOCAL);

// Take the address on which the hhid was defined.
hhid_lname_addr1 := DEDUP(
			SORT(
				DISTRIBUTE(h_l_hh_a, HASH(lname)),
				lname, hhid_relat, addr_id_match, LOCAL), 
			lname, hhid_relat, LOCAL);

hhid_lname_addr := hhid_lname_addr1(addr_id_match = 0);

layout_hhid_ct := RECORD
	hhid_lname_addr.lname;
	hhid_lname_addr.prim_range;
	hhid_lname_addr.prim_name;
	hhid_lname_addr.sec_range;
	hhid_lname_addr.zip;
	hhid_lname_addr.st;
	UNSIGNED4 hhid_ct := COUNT(GROUP);
END;

lname_addr_ct := TABLE(hhid_lname_addr, layout_hhid_ct, 
	lname, prim_range, prim_name, sec_range, zip, st, LOCAL);
	
layout_hhid_nosec_ct := RECORD
	lname_addr_ct.lname;
	lname_addr_ct.prim_range;
	lname_addr_ct.prim_name;
	lname_addr_ct.zip;
	lname_addr_ct.st;
	UNSIGNED4 hhid_nosec_ct := SUM(GROUP, lname_addr_ct.hhid_ct);
END;

lname_addr_nosec_ct := TABLE(lname_addr_ct, layout_hhid_nosec_ct, 
	lname, prim_range, prim_name, zip, st, LOCAL);

Header_SlimSort.Layout_household JoinSec(hhid_lname_addr l, lname_addr_ct r) := TRANSFORM
	SELF.hhid_cnt := r.hhid_ct;
	SELF := l;
END;

j1 := JOIN(hhid_lname_addr, lname_addr_ct,
	LEFT.lname = RIGHT.lname AND
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.sec_range = RIGHT.sec_range AND
	LEFT.zip = RIGHT.zip AND
	LEFT.st = RIGHT.st,
	JoinSec(LEFT, RIGHT), LOCAL);

Header_SlimSort.Layout_household JoinNoSec(j1 l, lname_addr_nosec_ct r) := TRANSFORM
	SELF.hhid_nosec_cnt := r.hhid_nosec_ct;
	SELF := l;
END;

j2 := JOIN(j1, lname_addr_nosec_ct,
	LEFT.lname = RIGHT.lname AND
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.zip = RIGHT.zip AND
	LEFT.st = RIGHT.st,
	JoinNoSec(LEFT, RIGHT), LOCAL);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
EXPORT hss_household := j2;
#ELSE
EXPORT hss_household := j2 : PERSIST('headerbuild_hss_hhid');
#END