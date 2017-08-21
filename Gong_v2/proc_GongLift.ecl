
import ut,header,gong,header_quick,watchdog;

hdr := sort(distribute(
		project(header_quick.file_header_quick(did<>0 and prim_name<>''),header.layout_header_strings),
		hash32(zip,prim_name,prim_range)), zip,prim_name,prim_range,local) : PERSIST('persist::gong::hdr');


export Macro_GongLift(inFile, outFile) := MACRO

#UNIQUENAME(rid)
%rid% := RECORD
	integer4	recordid;
	inFile;
	//Gong.File_History;
END;

#UNIQUENAME(t_AddId)
%rid% %t_AddId%(recordof(inFile) L, integer n) := TRANSFORM
	SELF.recordid := n;
	SELF := L;
END;

#UNIQUENAME(filegong)
%filegong% := SORT(PROJECT(
			DISTRIBUTE(inFile(did=0,listing_type_bus <> 'B',
					TRIM(z5) <> '', TRIM(prim_range) <> '',TRIM(prim_name) <> '',
					trim(name_first) <> '', TRIM(name_last)<>''),
			HASH32(z5,prim_name,prim_range)),%t_AddId%(LEFT, COUNTER)),
			z5,prim_name,prim_range,local);

//OUTPUT(filegong, named('gong'));
//OUTPUT(count(filegong),named('nodid'));

#UNIQUENAME(layout)
%layout% := RECORD
 did_hdr:=hdr.did;
 integer2 closeness;
 string10  h_prim_range;
 string28  h_prim_name;
 string4   h_suffix;
 string20  h_fname;
 string20  h_lname;
 %filegong%;
end;

#UNIQUENAME(t_get_did)
%layout% %t_get_did%(%filegong% le, hdr ri) := TRANSFORM
self.did_hdr:=IF(ri.did=0,SKIP,ri.did);
self.closeness := ut.NameMatch(le.name_first,le.name_middle,le.name_last,ri.fname,ri.mname,ri.lname);
self.h_prim_range := ri.prim_range;
self.h_prim_name := ri.prim_name;
self.h_suffix := ri.suffix;
self.h_fname := ri.fname;
self.h_lname := ri.lname;
self:=le;
end;


#UNIQUENAME(jnr)
%jnr% := join(%filegong%,hdr,
						  left.z5=right.zip and
						  left.prim_range=right.prim_range and
						  left.prim_name=right.prim_name and						  
						  //ut.NNEQ(left.suffix,right.suffix) and 
						  ut.NNEQ(left.sec_range,right.sec_range) and 
						  ut.NameMatch(left.name_first,left.name_middle,left.name_last,right.fname,right.mname,right.lname)<= 3
						  ,%t_get_did%(left,right),inner, /*keep(1),*/ NOSORT, local);						  

#UNIQUENAME(flt_jnr)
%flt_jnr% := SORT(%jnr%(did_hdr<>0),recordid,closeness,LOCAL);

#UNIQUENAME(d_jnr)
%d_jnr% := DEDUP(%flt_jnr%, recordid, LEFT, LOCAL);

#UNIQUENAME(close_enough)
%close_enough% := %d_jnr%(closeness <= 3);

outFile := PROJECT(%close_enough%, TRANSFORM(recordof(inFile), SELF := LEFT));
ENDMACRO;
/*
Macro_GongLift(Gong.File_History, GongLiftFromHistory, 'persist::gong::history::nodid');
Macro_GongLift(Watchdog.file_Gong_Did, GongLiftFromBase, 'persist::gong::base::nodid');

export proc_GongLift := PARALLEL(
	OUTPUT(GongLiftFromHistory),
	OUTPUT(GongLiftFromBase)
	);
*/