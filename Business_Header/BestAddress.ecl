IMPORT header, address;

export BestAddress(

	dataset(business_header.Layout_Business_Header_Base) bh = Files().Base.Business_Headers.Built,
	BOOLEAN best_poss_non_DandB = FALSE

) := FUNCTION

// Ignore addresses from whois.
bh_d_bdid := DISTRIBUTE(bh, HASH(bdid));

// Project to person header-like format
layout_bh_header := RECORD
	bh_d_bdid.bdid;
	UNSIGNED6 rid;
	STRING2 source;
	bh_d_bdid.dt_first_seen;
	bh_d_bdid.dt_last_seen;
	bh_d_bdid.dt_vendor_last_reported;
	bh_d_bdid.dt_vendor_first_reported;
	INTEGER4 dt_nonglb_last_seen;
	STRING1 rec_type;
	bh_d_bdid.prim_range;
	bh_d_bdid.predir;
	bh_d_bdid.prim_name;
	STRING4 suffix;
	bh_d_bdid.postdir;
	bh_d_bdid.unit_desig; // truncated from QSTRING10 to QSTRING5
	bh_d_bdid.sec_range;
	QSTRING25 city_name;
	STRING2 st;
	QSTRING5 zip;
	QSTRING4 zip4;
END;

layout_bh_header Proj(bh_d_bdid l) := TRANSFORM
	SELF.rid := l.rcid;
	SELF.dt_nonglb_last_seen := l.dt_last_seen;
	SELF.rec_type := TRANSFER(64 + 
			Business_Header.Map_Source_Hierarchy(L.source), STRING1);
	SELF.suffix := L.addr_suffix;
	SELF.city_name := l.city;
	SELF.st := l.state;
	SELF.zip := (QSTRING5) IF(l.zip <> 0, INTFORMAT(l.zip, 5, 1), '');
	SELF.zip4 := (QSTRING4) IF(l.zip4 <> 0, INTFORMAT(l.zip4, 4, 1), '');
	SELF := l;
END;

bh_p := PROJECT(bh_d_bdid, Proj(LEFT));

header.MAC_Best_Address(bh_p, bdid, 1, bh_address_sort, TRUE,, best_poss_non_DandB)
															
layout_bh_bestaddress := RECORD
	bh_address_sort.bdid;
	bh_address_sort.prim_range;
	bh_address_sort.predir;
	bh_address_sort.prim_name;
	QSTRING4 addr_suffix;
	bh_address_sort.postdir;
	QSTRING5 unit_desig;
	bh_address_sort.sec_range;
	QSTRING25 city;
	STRING2 state;
	UNSIGNED3 zip;
	UNSIGNED2 zip4;
	unsigned4 dt_last_seen;
	STRING2 addr_source;
END;

layout_bh_bestaddress SlimBack(bh_address_sort l) := TRANSFORM
	SELF.addr_suffix := l.suffix;
	SELF.unit_desig := l.unit_desig;
	SELF.city := l.city_name;
	SELF.state := l.st;
	SELF.zip := (UNSIGNED3) l.zip;
	SELF.zip4 := (UNSIGNED2) l.zip4;
	SELF.addr_source := l.source;
	SELF := l;
END;

bh_bestaddress := PROJECT(GROUP(bh_address_sort), SlimBack(LEFT));

return bh_bestaddress;
end;