IMPORT business_header,doxie, data_services;

set_notname := ['DOMAIN','REGISTERED','AGENT','ADMINISTRATOR'];
c := business_header.File_Business_Contacts
  (bdid > 0, did > 0, from_hdr = 'N',
  fname NOT IN set_notname,
  lname NOT IN set_notname);
  
//slim it
srec := RECORD
  c.bdid;
  UNSIGNED6 bdid2 := 0;
  UNSIGNED1 score := 1;
  c.did;
END;


ct := table(c, srec);
cd := DEDUP(ct, ALL);

//find the businesses that share a contact
srec jt(cd l, cd r) := TRANSFORM
  SELF.bdid := l.bdid;
  SELF.bdid2 := r.bdid;
  SELF := l;
END;

j := JOIN(cd, cd, LEFT.did = RIGHT.did AND LEFT.bdid <> RIGHT.bdid, jt(LEFT, RIGHT), hash);
jd := DISTRIBUTE(j, hash(bdid,bdid2));

//get a score and add it on
scorerec := RECORD
  j.bdid;
  j.bdid2;
  score := COUNT(GROUP);
END;

scores := table(jd, scorerec, bdid, bdid2, local);

srec addscores(srec l, scorerec r) := TRANSFORM
  SELF.score := r.score;
  SELF := l;
END;

j2 := JOIN(jd,scores,LEFT.bdid = RIGHT.bdid AND LEFT.bdid2 = RIGHT.bdid2, addscores(LEFT,RIGHT), local);

EXPORT key_BDID_relsByContact := index(j2,
{bdid, score},
{did, bdid2},
data_services.data_location.prefix() + 'thor_data400::key::cbrs.bdid_relsByContact_' + doxie.Version_SuperKey);
