export Mac_Hash_InputFile(C) := macro 

map(
    C = 1 and l.prim_name != '' => header_slimsort.MAC_Hash_Slimsort(L.fname,L.mname,L.lname,L.name_suffix,L.prim_range,L.prim_name,L.sec_range,L.z5,' ',' '),
    C = 2 and l.prim_name != '' => header_slimsort.MAC_Hash_Slimsort(datalib.preferredfirstNew(L.fname,Header_Slimsort.Constants.UsePFNew),datalib.preferredfirstNew(L.mname,Header_Slimsort.Constants.UsePFNew),metaphonelib.dmetaphone1(L.lname),L.name_suffix,L.prim_range,L.prim_name,L.z5,' ',' ',' '),
    C = 3 and l.prim_name != '' => header_slimsort.MAC_Hash_Slimsort(datalib.preferredfirstNew(L.fname,Header_Slimsort.Constants.UsePFNew),metaphonelib.dmetaphone1(L.lname),L.prim_range,L.prim_name,L.sec_range,L.z5,' ',' ',' ',' '),
    C = 4 and l.prim_name != '' => header_slimsort.MAC_Hash_Slimsort(L.fname,L.lname,L.prim_Range,L.prim_name,L.z5,' ',' ',' ',' ',' '),
    C = 5 and l.prim_name != '' => header_slimsort.MAC_Hash_Slimsort(L.fname,L.lname,L.prim_range,L.prim_name,L.sec_range,L.st,' ',' ',' ',' '),
    C = 6 and l.prim_name != '' => header_slimsort.MAC_Hash_Slimsort(L.fname,L.lname,L.prim_name,L.z5,' ',' ',' ',' ',' ',' '),
    C = 7 and l.ssn<>'' => Header_slimsort.MAC_Hash_Slimsort(L.ssn,datalib.preferredfirstNew(L.fname,Header_Slimsort.Constants.UsePFNew),L.mname,metaphonelib.dmetaphone1(L.lname),L.suffix,' ',' ',' ',' ',' '),	
    C = 8 and l.ssn<>'' => Header_slimsort.mac_hash_slimsort(L.ssn,L.fname,L.suffix,' ',' ',' ',' ',' ',' ',' '),
    C = 9 and l.ssn<>'' => header_slimsort.mac_hash_slimsort(L.ssn,datalib.preferredfirstNew(L.fname,Header_Slimsort.Constants.UsePFNew),' ',' ',' ',' ',' ',' ',' ',' '),
    C = 10 and l.ssn<>'' => header_slimsort.MAC_Hash_Slimsort(L.ssn,' ',' ',' ',' ',' ',' ',' ',' ',' '),
    C = 11 and l.mob<>0 => header_slimsort.MAC_Hash_Slimsort(L.mob,L.dayob,datalib.preferredfirstNew(L.fname,Header_Slimsort.Constants.UsePFNew),L.lname,' ',' ',' ',' ',' ',' '),
    C = 12 and l.mob<>0 => header_slimsort.MAC_Hash_Slimsort(L.mob,L.fname,L.lname,L.z5,' ',' ',' ',' ',' ',' '),
    C = 13 and l.mob<>0 => header_slimsort.MAC_Hash_Slimsort(l.mob,datalib.preferredfirstNew(L.fname,Header_Slimsort.Constants.UsePFNew),L.mname,L.lname,' ',' ',' ',' ',' ',' '),
    C = 14 and l.mob<>0 => header_slimsort.MAC_Hash_Slimsort(L.mob,L.fname,L.lname,' ',' ',' ',' ',' ',' ',' '),
    C = 15 and (unsigned)l.phone10<>0 => Header_slimsort.MAC_Hash_Slimsort(L.phone10,L.fname,L.mname,L.lname,L.suffix,' ',' ',' ',' ',' '),
    C = 16 and (unsigned)l.phone10<>0 => Header_slimsort.mac_hash_slimsort(L.phone10,L.fname,L.suffix,' ',' ',' ',' ',' ',' ',' '),
    C = 17 and (unsigned)l.phone10<>0 => header_slimsort.mac_hash_slimsort(L.phone10,L.fname,' ',' ',' ',' ',' ',' ',' ',' '),
    0)	

endmacro;