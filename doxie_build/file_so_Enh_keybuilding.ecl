import watchdog, didville, doxie, sexoffender, mdr, header, utilfile, drivers, codes, ut,relationship;

export file_so_Enh_keybuilding := function

/*

This function builds the dataset needed for the enhanced sex offender search keys

*/


RawFile     := file_so_main_keybuilding;

RawFileDids := RawFile(did != 0);

header_in_util := header.file_headers(zip4!='') + utilfile.DID_into_header(did>0 and zip4!='');

//  Output layout **********
AltLayout := record
	unsigned6 alt_did;
	sexoffender.layout_out_main;
	sexoffender.layout_in_alt;
end;

//  GLB Transform for Best Join
best_address_glb_1 := watchdog.File_Best;

best_layout := record
 watchdog.Layout_Best;
 unsigned3 dt_first_seen;
 end;

best_layout getDate(watchdog.Layout_Best L, header.Layout_Header R) := transform
 self.dt_first_seen := if(r.did=0,0,r.dt_first_seen); 
 self := l;
 end;
 
best_address_glb_2 := join(best_address_glb_1,header_in_util,left.did=right.did and 
							left.prim_range=right.prim_range and left.prim_name=right.prim_name and
							left.zip=right.zip and ut.NNEQ(left.sec_range,right.sec_range),getDate(left,right),
							local,left outer);
							
best_layout rollDates(best_layout L, best_layout r) := transform
 self.dt_first_seen := ut.Min2(l.dt_first_seen,r.dt_first_seen);
 self := l;
 end;
 
best_address_glb := rollup(sort(best_address_glb_2,did,local),did,rollDates(left,right),local) : persist('~thor_data400::persist::sex_offender_best_glb');


//Join to Header by DID and Address to find earliest dt_first_seen

AltLayout AddAltDetailsGLB(RawFile le, best_address_glb ri) := transform
  self.alt_did               := ri.did;
  self.alt_type              := 'B';
	self.alt_prim_range        := ri.prim_range;
	self.alt_predir            := ri.predir;
	self.alt_prim_name         := ri.prim_name;
	self.alt_suffix            := ri.suffix;
  self.alt_postdir           := ri.postdir;
	self.alt_unit_desig        := ri.unit_desig;
	self.alt_sec_range         := ri.sec_range;
	self.alt_city_name         := ri.city_name;
	self.alt_st                := ri.st;
	self.alt_zip               := ri.zip;
	self.alt_zip4              := ri.zip4;
	self.alt_addr_dt_first_seen := ri.dt_first_seen;
	self.alt_addr_dt_last_seen := ri.addr_dt_last_seen;
	self.alt_GLB               := 1;
	self.alt_dppa              := 1;	// GLB implies DPPA in Watchdog
	self                       := le;
	self.src									 := '';
end;

//  Non GLB Transform for Best Join
best_address_nonglb_1 := watchdog.File_Best_nonglb;

//Join to header by DID and Address to find earliest date first seen


best_address_nonglb_2 := join(best_address_nonglb_1,header_in_util,left.did=right.did and 
							left.prim_range=right.prim_range and left.prim_name=right.prim_name and
							left.zip=right.zip and ut.NNEQ(left.sec_range,right.sec_range),getDate(left,right),
							local,left outer);
							
best_address_nonglb := rollup(sort(best_address_nonglb_2,did,local),did,rollDates(left,right),local) : persist('~thor_data400::persist::sex_offender_best_nonglb');


AltLayout AddAltDetailsNonGLB(RawFile le, best_address_nonglb ri) := transform 
  self.alt_did               := ri.did;
  self.alt_type              := 'B';
	self.alt_prim_range        := ri.prim_range;
	self.alt_predir            := ri.predir;
	self.alt_prim_name         := ri.prim_name;
	self.alt_suffix            := ri.suffix;
  self.alt_postdir           := ri.postdir;
	self.alt_unit_desig        := ri.unit_desig;
	self.alt_sec_range         := ri.sec_range;
	self.alt_city_name         := ri.city_name;
	self.alt_st                := ri.st;
	self.alt_zip               := ri.zip;
	self.alt_zip4              := ri.zip4;
	self.alt_addr_dt_first_seen := ri.dt_first_seen;
	self.alt_addr_dt_last_seen := ri.addr_dt_last_seen;
	self.alt_GLB               := 0;
	self.alt_dppa              := 0;  // N/A
	self                       := le;
	SELF.src									 := '';
end;

GLBFile      := join(RawFileDids, best_address_glb,  left.did = right.did, AddAltDetailsGLB(left,right), hash);
NonGLBFile   := join(RawFileDids, best_address_nonglb, left.did = right.did, AddAltDetailsNonGLB(left,right), hash);
BestResults  := GLBFile + NonGLBFile;

loadfile:=pull(Relationship.key_relatives_v3)(type in ['PERSONAL','TRANS CLOSURE'] and confidence in ['MEDIUM','HIGH']);
// Create relatives table **********
//  Add relatives linking table
SORelativesLinkTable := join(distribute(RawFileDids,hash(did)), distribute(loadfile,hash(did1)), left.did = right.did1,local);


//  Get relatives best address
// Tidy up into new layout
AltLayout AddRelativeBestGLB(SORelativesLinkTable le, best_address_glb ri) := transform
  self.alt_did               := ri.did;
  self.alt_type              := 'R';
	self.alt_prim_range        := ri.prim_range;
	self.alt_predir            := ri.predir;
	self.alt_prim_name         := ri.prim_name;
	self.alt_suffix            := ri.suffix;
  self.alt_postdir           := ri.postdir;
	self.alt_unit_desig        := ri.unit_desig;
	self.alt_sec_range         := ri.sec_range;
	self.alt_city_name         := ri.city_name;
	self.alt_st                := ri.st;
	self.alt_zip               := ri.zip;
	self.alt_zip4              := ri.zip4;
	self.alt_addr_dt_first_seen := ri.dt_first_seen;
	self.alt_addr_dt_last_seen := ri.addr_dt_last_seen;
	self.alt_GLB               := 1;
	self.alt_dppa              := 0;  // N/A
	self                       := le;	
	SELF.src									 := '';
end;

AltLayout AddRelativeBestNonGLB(SORelativesLinkTable le, best_address_nonglb ri) := transform
  self.alt_did               := ri.did;
  self.alt_type              := 'R';
	self.alt_prim_range        := ri.prim_range;
	self.alt_predir            := ri.predir;
	self.alt_prim_name         := ri.prim_name;
	self.alt_suffix            := ri.suffix;
  self.alt_postdir           := ri.postdir;
	self.alt_unit_desig        := ri.unit_desig;
	self.alt_sec_range         := ri.sec_range;
	self.alt_city_name         := ri.city_name;
	self.alt_st                := ri.st;
	self.alt_zip               := ri.zip;
	self.alt_zip4              := ri.zip4;
	self.alt_addr_dt_first_seen := ri.dt_first_seen;
	self.alt_addr_dt_last_seen := ri.addr_dt_last_seen;
	self.alt_GLB               := 0;
	self.alt_dppa              := 0;
	self                       := le;	
	SELF.src									 := '';
end;		

SORelativesAddedGLB    := join(distribute(SORelativesLinkTable,hash(did2)), distribute(best_address_glb,hash(did)), left.did2 = right.did, AddRelativeBestGLB(left, right),local);
SORelativesAddedNonGLB := join(distribute(SORelativesLinkTable,hash(did2)), distribute(best_address_nonglb,hash(did)), left.did2 = right.did, AddRelativeBestNonGLB(left, right),local);
SORelativesAdded       := SORelativesAddedGLB + SORelativesAddedNonGLB; //if(pGLB != 0, SORelativesAddedGLB, SORelativesAddedNonGLB);

// Get historical records
AltLayout GetHistoricalRecords(RawFile le, doxie.Key_Header ri) := transform
  self.alt_did               := ri.s_did;
  self.alt_type              := if(ri.tnt = 'R', 'L', ri.tnt);  //  Use L for living with, R already used  
	self.alt_prim_range        := ri.prim_range;
	self.alt_predir            := ri.predir;
	self.alt_prim_name         := ri.prim_name;
	self.alt_suffix            := ri.suffix;
  self.alt_postdir           := ri.postdir;
	self.alt_unit_desig        := ri.unit_desig;
	self.alt_sec_range         := ri.sec_range;
	self.alt_city_name         := ri.city_name;
	self.alt_st                := ri.st;
	self.alt_zip               := ri.zip;
	self.alt_zip4              := ri.zip4;
	self.alt_addr_dt_first_seen := ri.dt_first_seen;
	self.alt_addr_dt_last_seen := ri.dt_last_seen;
	self.alt_GLB               := (INTEGER)(~header.isPreGLB(ri));
	self.alt_dppa              := (integer)mdr.source_is_DPPA(ri.src); 
	self.src									 := ri.src;
	self                       := le;
end;

HistoricalRecords1 := join(RawFileDids, doxie.Key_Header, 
													left.did = right.s_did AND
													// no ln-branding
													~(mdr.source_is_DPPA(RIGHT.src) AND RIGHT.src[2] IN ['E','X']), GetHistoricalRecords(left, right)); 

HistoricalRecords2 := sort(distribute(HistoricalRecords1,  hash(seisint_primary_key)), seisint_primary_key, alt_prim_range, alt_prim_name, alt_city_name, alt_st, alt_zip, alt_dppa, local);
HistoricalRecords  := dedup(HistoricalRecords2, seisint_primary_key, alt_prim_range, alt_prim_name, alt_city_name, alt_st, alt_zip, alt_dppa);

AltLayout CleanSORecs(RawFile ri) := transform
  self.alt_did               := ri.did;
  self.alt_type              := 'S';
	self.alt_prim_range        := ri.prim_range;
	self.alt_predir            := ri.predir;
	self.alt_prim_name         := ri.prim_name;
	self.alt_suffix            := '';
  self.alt_postdir           := ri.postdir;
	self.alt_unit_desig        := ri.unit_desig;
	self.alt_sec_range         := ri.sec_range;
	self.alt_city_name         := ri.v_city_name;
	self.alt_st                := ri.st;
	self.alt_zip               := ri.zip5;
	self.alt_zip4              := ri.zip4;
	self.alt_addr_dt_first_seen := 0;
	self.alt_addr_dt_last_seen := (unsigned3)ri.addr_dt_last_seen;
	self.alt_GLB               := 0;  // sex offenders are non-glb
	self.alt_dppa              := 0;  // sex offenders are non-dppa
	self                       := ri;
	self.src									 := '';
end;


//  Grab ALL original records, includes did = 0
SORecords  := project(RawFile,  CleanSORecs(left));


AltLayout roller(AltLayout le, AltLayout ri) :=
TRANSFORM
	// hierarchy here is important
	test(STRING1 s) := le.alt_type=s OR ri.alt_type=s;
	
	SELF.alt_type := MAP(test('S')	=> 'S',
											 test('B')	=> 'B',
											 test('V')	=> 'V',
											 test('C')	=> 'C',
											 test('P')	=> 'P',
											 test('P')	=> 'P',
											 test('R')	=> 'R',
											 // just to keep it deterministic
											 IF(le.alt_type<ri.alt_type,le.alt_type,ri.alt_type));
	SELF.alt_glb := IF(le.alt_glb+ri.alt_glb=2,1,0);
	SELF.alt_dppa := IF(le.alt_dppa+ri.alt_dppa=2,1,0);
	SELF.src	:= IF(le.src<ri.src,le.src,ri.src);	// again, just to keep deterministic
	SELF := le;
END;
//  Dedup - note that including lname would allow AKAs into the results
allResults := SORecords + BestResults + SORelativesAdded + HistoricalRecords;

allResults_dst := distribute(allResults, hash(seisint_primary_key, alt_prim_range, alt_prim_name, lname, alt_zip));
allSorted  := sort(allResults_dst, seisint_primary_key, alt_prim_range, alt_prim_name, alt_city_name, lname, fname, alt_st, alt_zip, -alt_addr_dt_last_seen, local);
allDedup   := ROLLUP(allSorted, roller(LEFT,RIGHT), seisint_primary_key, alt_prim_range, alt_prim_name, alt_city_name, lname, fname, alt_st, alt_zip, local) : persist('persist::SexOffender_Temp');

return allDedup;

END;

