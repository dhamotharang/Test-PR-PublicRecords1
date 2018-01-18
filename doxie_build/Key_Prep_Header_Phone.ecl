import header,gong, data_services;

t := header.Prepped_For_Keys;

phone_rec := record
  string7 p7 := t.phone[4..10];
  string3 p3 := t.phone[1..3];
  t.dph_lname;
  t.pfname;
  t.st;
  t.did;
  end;

header_phone_recs := table(t((integer)phone<>0),phone_rec);;

hhid := Header.File_HHID_Current(ver = 1);
gong_did := gong.File_Gong_Did(did != 0);
gong_hhid := Gong.Gong_HHID(hhid != 0);

typeof(gong_did) get_did(hhid ri, gong_hhid le) :=
TRANSFORM
	SELF.did := ri.did;
	SELF := le;
END;
gong_hhid_did := JOIN(hhid, gong_hhid, LEFT.hhid = RIGHT.hhid, get_did(LEFT, RIGHT), HASH)(did<>0);

phone_rec to_phone_rec(gong_did le) :=
TRANSFORM
	phone := INTFORMAT((unsigned)le.phone10, 10, 1);
	SELF.p7 := phone[4..10];
	SELF.p3 := phone[1..3];
	SELF.dph_lname := metaphonelib.DMetaPhone1(le.name_last);
	SELF.pfname := datalib.preferredfirst(le.name_first);
	SELF.st := le.st;
	SELF.did := le.did
END;
gong_phone_recs := PROJECT(gong_did+gong_hhid_did, to_phone_rec(LEFT));

phone_recs := DEDUP(SORT((header_phone_recs+gong_phone_recs)((integer)p7<>0),record),record);

export Key_Prep_Header_Phone := INDEX(phone_recs, 
                                      {phone_recs}, 
                                      data_services.data_location.prefix() + 'thor_data400::key::header.phone' + thorlib.wuid());