import ut,header,gong,header_quick,watchdog;
// #55136  CJS 2011-04-22
EXPORT fn_GongLift(DATASET(Layout_gongMaster) inFile) := FUNCTION

// prep the quick header for a local join
		hdr := sort(distribute(
			project(header_quick.file_header_quick(did<>0,prim_name<>'',rec_type='1'),
					header.layout_header_strings),
			hash64(zip,prim_name,prim_range)), zip,prim_name,prim_range, local);

		rid := RECORD
			integer4	__recordid;
			inFile;
		END;


// we add a record id, so we can dedup later on
	rid t_AddId(recordof(inFile) L, integer n) := TRANSFORM
		SELF.__recordid := n;
		SELF := L;
	END;
	
	// find all gong records that are good possibilities for the lift
	filegong := SORT(PROJECT(
			DISTRIBUTE(inFile(did=0,listing_type_bus <> 'B',
					TRIM(z5) <> '', TRIM(prim_range) <> '',TRIM(prim_name) <> '',
					TRIM(name_first) <> '', TRIM(name_last)<>''
					,current_record_flag='Y'
					),
			hash64(z5,prim_name,prim_range)),t_AddId(LEFT, COUNTER)),
			z5,prim_name,prim_range,local);

// save the non-possibilities so we can get them back 
	non_candidates := 
			inFile(did != 0 OR listing_type_bus = 'B' OR
					TRIM(z5) = '' OR TRIM(prim_range) = '' OR TRIM(prim_name) = '' OR
					TRIM(name_first) = ''  OR TRIM(name_last) = ''
					OR current_record_flag<>'Y'
					);

	layout := RECORD
		did_hdr:= hdr.did;
		integer2 closeness;
		filegong;
	end;

	layout t_get_did(filegong le, hdr ri) := TRANSFORM
		self.did_hdr:=	ri.did;	//	
		self.did :=	ri.did;	//		
		self.closeness := IF(ri.did=0,10000,ut.NameMatch(le.name_first,le.name_middle,le.name_last,ri.fname,ri.mname,ri.lname));
		self:=le;
	end;

// join the possibilities to the quick header, looking for close name matches
	jnr := join(filegong,hdr,
						  left.z5=right.zip and
						  left.prim_range=right.prim_range and
						  left.prim_name=right.prim_name and						  
						  //ut.NNEQ(left.suffix,right.suffix) and 
						  ut.NNEQ(left.sec_range,right.sec_range) and 
						  ut.NameMatch(left.name_first,left.name_middle,left.name_last,right.fname,right.mname,right.lname)<= 3
						  ,t_get_did(left,right), left outer, /*inner, /*keep(1),*/ NOSORT, local);
						  
	flt_jnr := SORT(jnr,__recordid,closeness,LOCAL);	
	d_jnr := DEDUP(flt_jnr, __recordid, LEFT, LOCAL);
							
	close_enough := d_jnr(closeness <= 3);
	not_close_enough := d_jnr(closeness > 3);

// these are the original possibilites reformatted to match original record layour
	candidates := PROJECT(close_enough, TRANSFORM(recordof(inFile), SELF := LEFT)) + 
				PROJECT(not_close_enough, TRANSFORM(recordof(inFile), SELF := LEFT));

// return file
	return candidates + non_candidates;

END;