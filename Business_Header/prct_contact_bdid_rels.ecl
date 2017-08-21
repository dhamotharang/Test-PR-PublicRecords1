/*
  copied from doxie_cbrs.key_BDID_relsByContact, so if that changes, this will need to change
*/
EXPORT prct_contact_bdid_rels(

  dataset(Layout_Business_Contact_Full_new) pDataset = business_header.Files().Base.Business_Contacts.built

) :=
function

set_notname := ['DOMAIN','REGISTERED','AGENT','ADMINISTRATOR'];
c := pDataset
	(bdid > 0, did > 0, from_hdr = 'N', 
	fname not in set_notname,
	lname not in set_notname);
	
//slim it	
srec := record
	c.bdid;
	unsigned6 bdid2 := 0;
	unsigned1 score := 1;
	c.did;
end;


ct := table(c, srec);
cd := dedup(ct, all);

//find the businesses that share a contact
srec jt(cd l, cd r) := transform
	self.bdid := l.bdid;
	self.bdid2 := r.bdid;
	self := l;
end;

j := join(cd, cd, left.did = right.did and left.bdid <> right.bdid, jt(left, right), hash);
jd := distribute(j, hash(bdid,bdid2));

//get a score and add it on
scorerec := record
	j.bdid;
	j.bdid2;
	score := count(group);
end;

scores := table(jd, scorerec, bdid, bdid2, local);

srec addscores(srec l, scorerec r) := transform
	self.score := r.score;
	self := l;
end;

j2 := join(jd,scores,left.bdid = right.bdid and left.bdid2 = right.bdid2, addscores(left,right), local);

return j2;

end;
