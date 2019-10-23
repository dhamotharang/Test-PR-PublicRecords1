import autokey, doxie_build, header, gong, ut, Gong_Neustar;

//t := dataset('~thor_data400::Base::HeaderKey_Building',header.Layout_Header,flat);
//  Bug 12065, use blocked data filter on header instead of raw data
t := doxie_build.file_header_building; 

phone_rec := record
  t.phone;
  // string7 p7 := t.phone[4..10];
  // string3 p3 := t.phone[1..3];
  t.lname;
  t.fname;
  t.st;
  t.did;
  end;

header_phone_recs := table(t((integer)phone<>0),phone_rec);;

hhid := Header.File_HHID_Current(ver = 1);
gong_did := gong.File_Gong_Did(did != 0);
gong_hhid := Gong_Neustar.File_Gong_HHID(hhid != 0);

typeof(gong_did) get_did(hhid ri, gong_hhid le) :=
TRANSFORM
	SELF.did := ri.did;
	SELF := le;
END;
gong_hhid_did := JOIN(hhid, gong_hhid, LEFT.hhid = RIGHT.hhid, get_did(LEFT, RIGHT), HASH)(did<>0);

phone_rec to_phone_rec(gong_did le) :=
TRANSFORM
	SELF.phone := INTFORMAT((unsigned)le.phone10, 10, 1);
	SELF.lname := le.name_last;
	SELF.fname := le.name_first;
	SELF.st := le.st;
	SELF.did := le.did
END;
gong_phone_recs := PROJECT(gong_did+gong_hhid_did, to_phone_rec(LEFT));

all_phone_recs := header_phone_recs+gong_phone_recs;

autokey.MAC_Phone(all_phone_recs,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,city_name,zip,sec_range,
						states,
						lname1,lname2,lname3,
						city1,city2,city3,
						rel_fname1,rel_fname2,rel_fname3,
						lookups,
						did,
						ut.Data_Location.Person_header + 'thor_data400::key::header.phone',
						k)
						
export key_header_phone := k;