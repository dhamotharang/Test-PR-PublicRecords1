IMPORT SexOffender, PRTE2_SexOffender, Doxie, Header, PRTE2_Header, Watchdog, PRTE2_Watchdog, MDR, ut, autokey, Address;

	//This function builds the dataset needed for the enhanced sex offender search keys
EXPORT file_ENH_key := FUNCTION

  	RawFileDids := Files.SexOffender_base(did != 0);
		header_in := prte2_header.files.file_headers_base(zip4!='');

	//  GLB Transform for Best Join
		best_address_glb_1 := PRTE2_Watchdog.Files.file_best;

		best_layout := RECORD
			watchdog.Layout_Best;
			UNSIGNED3 dt_first_seen;
		END;

		best_layout getDate(watchdog.Layout_Best L, header.Layout_Header R) := TRANSFORM
			self.dt_first_seen := if(r.did=0,0,r.dt_first_seen); 
			self := l;
		END;
 
		best_address_glb_2 := join(best_address_glb_1,header_in,left.did=right.did and 
															left.prim_range=right.prim_range and left.prim_name=right.prim_name and
															left.zip=right.zip and ut.NNEQ(left.sec_range,right.sec_range),getDate(left,right),
															left outer);
							
		best_layout rollDates(best_layout L, best_layout r) := TRANSFORM
			self.dt_first_seen := ut.Min2(l.dt_first_seen,r.dt_first_seen);
			self := l;
		END;
 
		best_address_glb := rollup(sort(best_address_glb_2,did,local),did,rollDates(left,right),local);

	//Join to Header by DID and Address to find earliest dt_first_seen
		Layouts.AltLayout AddAltDetailsGLB(Files.SexOffender_base le, best_address_glb ri) := TRANSFORM
			self.ssn									 := IF(trim(le.ssn) = '',le.ssn_appended, le.ssn);
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
			self.alt_dppa              := 1;
			self                       := le;
			self.src									 := '';
		END;

		BestResults      := join(RawFileDids, best_address_glb,  left.did = right.did, AddAltDetailsGLB(left,right), hash);

	//Add relatives linking table - Do not have a relatives file(doxie.Key_Relatives) for PRTE so using exisiting index file to join to main file
		SORelativesLinkTable :=  PROJECT(PRTE2_SexOffender.Files.ENHPublic_hist(alt_type = 'R'), TRANSFORM(PRTE2_SexOffender.Layouts.AltLayout, SELF := LEFT; SELF := []));

	//  Get relatives best address - using existing address information in current ENH index file
		PRTE2_SexOffender.Layouts.AltLayout GetRelativeRecords(RawFileDids le, SORelativesLinkTable ri) := TRANSFORM
			self.ssn									 := le.ssn_appended;
			self.record_type					 := ri.alt_type;
			self.alt_did               := le.did;
			self.alt_type              := ri.alt_type;
			self.alt_prim_range        := ri.alt_prim_range;
			self.alt_predir            := ri.alt_predir;
			self.alt_prim_name         := ri.alt_prim_name;
			self.alt_suffix            := ri.alt_suffix;
			self.alt_postdir           := ri.alt_postdir;
			self.alt_unit_desig        := ri.alt_unit_desig;
			self.alt_sec_range         := ri.alt_sec_range;
			self.alt_city_name         := ri.alt_city_name;
			self.alt_st                := ri.alt_st;
			self.alt_zip               := ri.alt_zip;
			self.alt_zip4              := ri.alt_zip4;
			self.alt_addr_dt_first_seen := ri.alt_addr_dt_first_seen;
			self.alt_addr_dt_last_seen := ri.alt_addr_dt_last_seen;
			self.alt_GLB               := ri.alt_GLB;
			self.alt_dppa              := ri.alt_dppa; 
			self.src									 := ri.src;
			self                       := le;
		end;
		
		SORelativesAdded   := join(sort(RawFileDids,seisint_primary_key),
															sort(SORelativesLinkTable,seisint_primary_key),  
															left.seisint_primary_key = right.seisint_primary_key
															,GetRelativeRecords(left, right));
	
	//Get historical records - Do not have PRCT historical file(doxie.Key_Header) so using exisiting EHN index file to join to main file
		pENHPublic_hist	:= PROJECT(PRTE2_SexOffender.Files.ENHPublic_hist(alt_type = 'H'), TRANSFORM(PRTE2_SexOffender.Layouts.AltLayout, SELF := LEFT; SELF := []));
		
		PRTE2_SexOffender.Layouts.AltLayout GetHistoricalRecords(RawFileDids le, pENHPublic_hist ri) := transform
			self.ssn									 := le.ssn_appended;
			self.alt_did               := le.did;
			self.alt_type              := 'H';
			self.alt_prim_range        := ri.alt_prim_range;
			self.alt_predir            := ri.alt_predir;
			self.alt_prim_name         := ri.alt_prim_name;
			self.alt_suffix            := ri.alt_suffix;
			self.alt_postdir           := ri.alt_postdir;
			self.alt_unit_desig        := ri.alt_unit_desig;
			self.alt_sec_range         := ri.alt_sec_range;
			self.alt_city_name         := ri.alt_city_name;
			self.alt_st                := ri.alt_st;
			self.alt_zip               := ri.alt_zip;
			self.alt_zip4              := ri.alt_zip4;
			self.alt_addr_dt_first_seen := ri.alt_addr_dt_first_seen;
			self.alt_addr_dt_last_seen := ri.alt_addr_dt_last_seen;
			self.alt_GLB               := ri.alt_GLB;
			self.alt_dppa              := ri.alt_dppa; 
			self.src									 := ri.src;
			self                       := le;
		end;

	HistoricalRecords1 := join(sort(RawFileDids,seisint_primary_key),
														 sort(pENHPublic_hist,seisint_primary_key),  
														left.seisint_primary_key = right.seisint_primary_key
														,GetHistoricalRecords(left, right));
														
	 PRTE2_SexOffender.Layouts.AltLayout CleanSORecs(PRTE2_SexOffender.Files.SexOffender_base ri) := TRANSFORM
			self.ssn									 := IF(trim(ri.ssn) = '',ri.ssn_appended, ri.ssn);
			self.alt_did               := ri.did;
			self.alt_type              := 'S';
			self.alt_prim_range        := ri.prim_range;
			self.alt_predir            := ri.predir;
			self.alt_prim_name         := ri.prim_name;
			self.alt_suffix            := ri.addr_suffix;
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
		END;

	//  Grab ALL original records, includes did = 0
		SORecords  := project(PRTE2_SexOffender.Files.SexOffender_base,  CleanSORecs(left));
		
		PRTE2_SexOffender.Layouts.AltLayout roller(PRTE2_SexOffender.Layouts.AltLayout le, PRTE2_SexOffender.Layouts.AltLayout ri) := TRANSFORM
			test(STRING1 s) := le.alt_type=s OR ri.alt_type=s;
			SELF.alt_type := MAP(test('S')	=> 'S',
													test('B')	=> 'B',
													test('V')	=> 'V',
													test('C')	=> 'C',
													test('P')	=> 'P',
													test('R')	=> 'R',
											 // just to keep it deterministic
											 IF(le.alt_type<>'',le.alt_type,ri.alt_type));
			SELF.record_type := SELF.alt_type;
			SELF.alt_glb := IF(le.alt_glb+ri.alt_glb=2,1,0);
			SELF.alt_dppa := IF(le.alt_dppa+ri.alt_dppa=2,1,0);
			SELF.src	:= IF(le.src<ri.src,le.src,ri.src);
			SELF := le;
		END;

		allResults := SORecords + BestResults + SORelativesAdded + HistoricalRecords1;
		allSorted  := sort(allResults, seisint_primary_key, alt_prim_range, alt_prim_name, alt_city_name, lname, fname, alt_st, alt_zip, -alt_addr_dt_last_seen);
		allDedup   := ROLLUP(allSorted, roller(LEFT,RIGHT), seisint_primary_key, alt_prim_range, alt_prim_name, alt_city_name, lname, fname, alt_st, alt_zip);

RETURN allDedup;

END;
	
