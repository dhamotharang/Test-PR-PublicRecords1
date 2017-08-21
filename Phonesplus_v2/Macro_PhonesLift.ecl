import ut,header,Phonesplus_v2,header_quick,watchdog;
// #79225  CJS 2011-07-12
export Macro_PhonesLift(inFile, outFile, useCurrAddress=true, useCurrPhone=true) := MACRO
#UNIQUENAME(hdr)

// prep the quick header for a local join
%hdr% := sort(distribute(
		project(header_quick.file_header_quick(did<>0 and prim_name<>''
#IF(useCurrAddress=true)
					,rec_type='1'
#END
		),header.layout_header_strings),
		hash32(zip,prim_name,prim_range)), zip,prim_name,prim_range,local);

#UNIQUENAME(rid)
%rid% := RECORD
	integer4	recordid;
	inFile;
	//Gong.File_History;
END;

#UNIQUENAME(t_AddId)
// we add a record id, so we can dedup later on
%rid% %t_AddId%(recordof(inFile) L, integer n) := TRANSFORM
	SELF.recordid := n;
	SELF := L;
END;

#UNIQUENAME(filephp)
// find all phones+ records that are good possibilities for the lift
%filephp% := SORT(PROJECT(
			DISTRIBUTE(inFile(did=0,
					zip5 <> '', prim_range <> '',prim_name <> '',
					fname <> '', lname<>''
#IF(useCurrPhone=true)
					,in_flag = true
#END			
			),
			HASH32(zip5,prim_name,prim_range)),%t_AddId%(LEFT, COUNTER)),
			zip5,prim_name,prim_range,local);
			
#UNIQUENAME(non_candidates)
// save the non-possibilities so we can get them back 
%non_candidates% := 
			inFile(did != 0 OR 
					zip5 = '' OR prim_range = '' OR prim_name = '' OR
					fname = ''  OR lname = ''
#IF(useCurrPhone=true)
					OR ~in_flag
#END
					);

#UNIQUENAME(layout)
%layout% := RECORD
 did_hdr:= %hdr%.did;
 integer2 closeness;
// string10  h_prim_range;	// these fields are for debugging
// string28  h_prim_name;
// string4   h_suffix;
// string20  h_fname;
// string20  h_lname;
 %filephp%;
end;

#UNIQUENAME(t_get_did)
%layout% %t_get_did%(%filephp% le, %hdr% ri) := TRANSFORM
self.did_hdr:=	ri.did;	//	
self.did :=	ri.did;	//
self.closeness := IF(ri.did=0,10000,ut.NameMatch(le.fname,le.mname,le.lname,ri.fname,ri.mname,ri.lname));
//self.h_prim_range := ri.prim_range;
//self.h_prim_name := ri.prim_name;
//self.h_suffix := ri.suffix;
//self.h_fname := ri.fname;
//self.h_lname := ri.lname;
self:=le;
end;


#UNIQUENAME(jnr)
// join the possibilities to the quick header, looking for close name matches
%jnr% := join(%filephp%,%hdr%,
						  left.zip5=right.zip and
						  left.prim_range=right.prim_range and
						  left.prim_name=right.prim_name and						  
						  //ut.NNEQ(left.suffix,right.suffix) and 
						  ut.NNEQ(left.sec_range,right.sec_range) and 
						  ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)<= 3
						  ,%t_get_did%(left,right), left outer, /*keep(1),*/ NOSORT, local);
OUTPUT(COUNT(%jnr%),named('n_jnr'));
						  

#UNIQUENAME(flt_jnr)
%flt_jnr% := SORT(%jnr%,recordid,closeness,LOCAL);	

#UNIQUENAME(d_jnr)
%d_jnr% := DEDUP(%flt_jnr%, recordid, LEFT, LOCAL);

#UNIQUENAME(close_enough)
// these are the ones we want
%close_enough% := %d_jnr%(closeness <= 3);

#UNIQUENAME(not_close_enough)
%not_close_enough% := %d_jnr%(closeness > 3);

#UNIQUENAME(candidates)
// these are the original possibilites reformatted to match original record layour
%candidates% := PROJECT(%close_enough%, TRANSFORM(recordof(inFile), SELF := LEFT)) + 
				PROJECT(%not_close_enough%, TRANSFORM(recordof(inFile), SELF := LEFT));

// return file
outFile := %candidates% + %non_candidates%;

ENDMACRO;