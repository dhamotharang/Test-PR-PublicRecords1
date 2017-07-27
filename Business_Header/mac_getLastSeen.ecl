import doxie_cbrs;

export mac_getLastSeen(infile,  //must have dt_last_seen and one rec per bdid
	outfile) := 
MACRO

ut.MAC_Slim_Back(infile, doxie_Cbrs.layout_references, infile_slim)
br := business_header.getBaseRecs(infile_slim);
brs := sort(br, bdid, prim_range, prim_name, zip, -dt_last_seen, -dt_first_seen);
brd := dedup(brs, bdid, prim_range, prim_name, zip);
				
infile addls(infile l, brd r) := transform
	self.dt_last_seen := if(r.dt_last_seen > r.dt_first_seen, r.dt_last_seen, r.dt_first_seen);
	self := l;
end;
				
outfile := join(infile, brd, 
								left.bdid = right.bdid and
								left.prim_range = right.prim_range and
								left.prim_name = right.prim_name and
								(integer)left.zip = right.zip,
								addls(left, right));

ENDMACRO;