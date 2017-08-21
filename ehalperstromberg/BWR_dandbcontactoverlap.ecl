slim :=record
	Business_Header.File_Business_Contacts_Base.dt_last_seen;
	Business_Header.File_Business_Contacts_Base.did;
	Business_Header.File_Business_Contacts_Base.bdid;
	Business_Header.File_Business_Contacts_Base.source;
	Business_Header.File_Business_Contacts_Base.fname;
	Business_Header.File_Business_Contacts_Base.lname;
	Business_Header.File_Business_Contacts_Base.mname;
	Business_Header.File_Business_Contacts_Base.name_suffix;
	string30 preferred_first :='';
	string30 description :='';
	boolean active :=false;
	boolean DNB :=False;
	boolean overlap :=false;
END;

slim_best :=record
	Business_header.File_Business_Header_best.bdid
END;



b_head := table(Business_Header.File_Business_Contacts_base(prim_name <>'' and zip <> 0 and bdid <> 0 and from_hdr='N'),slim);
b_best := table(business_header.File_Business_Header_best,slim_best);

dis_head :=distribute(b_head,hash(bdid));
dis_best :=distribute(b_best,hash(bdid));

slim trans(b_head l,b_best r) :=transform
self.dt_last_seen :=l.dt_last_seen;
self.bdid :=l.bdid;
self.did :=l.did;
self.source :=l.source;
self.fname :=l.fname;
self.lname :=l.lname;
self.mname := l.mname;
self.name_suffix := l.name_suffix;
self :=l;
end;


slimb := join(dis_head,dis_best,left.bdid=right.bdid,trans(left,right),local);

slim add_pref(slim l):=transform
	self.preferred_first :=datalib.preferredfirst(l.fname);
	self :=l;
end;


slimb2 :=project(slimb,add_pref(left));


dupslimb := dedup(sort(slimb2(did<>0),bdid,source,did,-dt_last_seen,local),bdid,source,did,local);



dupslimb2:= dedup(sort(dupslimb+slimb2(did=0),bdid,source,preferred_first,fname,lname,name_suffix,-dt_last_seen,local),left.bdid=right.bdid and left.source=right.source and
(left.did=0 or right.did=0) and left.preferred_first = right.preferred_first[1..length(trim(datalib.preferredfirst(left.fname)))] and left.lname=right.lname and (left.name_suffix=right.name_suffix or left.name_suffix='' or right.name_suffix='') ,local);


out :=join(dupslimb2,dupslimb2(did=0),left.bdid=right.bdid,keep(1),local);
output(sort(out,bdid,local));

slim overlap(slim l,slim  r):=transform
	self.overlap :=r.bdid <> 0;
	self := l;
END;


with_overlap_dnb :=join(dupslimb2(source='D'),dupslimb2(source <>'D'),left.bdid=right.bdid and ((left.did=right.did and right.did<>0) or (right.did=0 and (left.name_suffix=right.name_suffix or right.name_suffix='')
and ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)<3)), overlap(left,right),keep(1),left outer,local);

with_overlap_nondnb :=join(dupslimb2(source <>'D'),dupslimb2(source='D'),left.bdid=right.bdid and ((left.did=right.did and right.did<>0) or (right.did=0 and (left.name_suffix=right.name_suffix or right.name_suffix='')
and ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)<3)),overlap(left,right),keep(1),left outer,local);
overlaps := sort(with_overlap_dnb + with_overlap_nondnb,bdid,did,preferred_first,fname,lname,mname, local);

//overlapout :=join(overlaps,overlaps(did=0),left.bdid=right.bdid,keep(1),local);

//output(overlapout,named('checknames'));

output(overlaps,named('overlaps')); // :persist('overlaps');

output(choosen(overlaps(overlap=TRUE),1000),named('overlaps_overlaptrue'));



layout_description := Business_Header.Source_Tools.layout_description_old;


slim trans2(dupslimb l,layout_description r):=transform
self.DNB :=L.source ='D';
self.active :=if(l.dt_last_seen >20051100 or (l.source='U2' and (integer)(((string)l.dt_last_seen)[1..6]) >= 200511),TRUE,FALSE);
self.description :=r.description;
self :=l;
end;

dis_overlaps :=distribute(overlaps,hash(source));

bcodes := business_header.Source_Codes;


pre_with_desc :=join(dis_overlaps,bcodes,left.source=right.code, trans2(left,right),left outer,lookup);

output(pre_with_desc,named('pre_with_desc'));



slim2 :=record
	with_desc.source;
	with_desc.description;
	integer total_from_source :=count(group);
	integer total_active :=count(group,with_desc.active=TRUE);
	integer total_DNB_overlap :=count(group,with_desc.overlap=TRUE);
	integer total_DNB_active_overlap :=count(group,with_desc.overlap=TRUE and with_desc.active=TRUE);
	integer total_active_nonDNB_overlap :=count(group,with_desc.active=TRUE and with_desc.overlap=FALSE);
END;



tab1 :=table(with_desc,slim2,source,description,local);


output(choosen(tab1,300),named('crosstab'));

output(with_desc(source='D' and overlap=TRUE and active=FALSE),named('checktable'));
output(count(with_desc(source='D',overlap=TRUE,active=FALSE)));