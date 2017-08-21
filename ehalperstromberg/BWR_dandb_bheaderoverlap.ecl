slim :=record
	Business_header.File_Business_Header.dt_last_seen;
	Business_header.File_Business_Header.bdid;
	Business_header.File_Business_Header.source;
	string30 description :='';
	boolean active :=false;
	boolean DNB :=False;
	boolean overlap :=false;
END;

slim_best :=record
	Business_header.File_Business_Header_best.bdid
END;



b_head := table(Business_header.File_Business_Header(prim_name <>'' and zip <> 0 and ~(source='D' and fein <>0)),slim);
b_best := table(business_header.File_Business_Header_best(~(source='D' and fein <>0)),slim_best);

dis_head :=distribute(b_head,hash(bdid));
dis_best :=distribute(b_best,hash(bdid));

slim trans(b_best l,b_head r) :=transform
self.dt_last_seen :=r.dt_last_seen;
self.bdid :=r.bdid;
self.source :=r.source;
self :=r;
end;


slimb := join(dis_best,dis_head,left.bdid=right.bdid,trans(left,right),local);

//output(slimb,named('slimb'));

dupslimb := dedup(sort(slimb,bdid,source,-dt_last_seen,local),bdid,source,local);


slim overlap(slim l,slim  r):=transform
	self.overlap :=r.bdid <> 0;
	self := l;
END;


with_overlap_dnb :=join(dupslimb(source='D'),dupslimb(source <>'D'),left.bdid=right.bdid, overlap(left,right),keep(1),left outer,local);

with_overlap_nondnb :=join(dupslimb(source <>'D'),dupslimb(source='D'),left.bdid=right.bdid,overlap(left,right),keep(1),left outer,local);

overlaps := sort(with_overlap_dnb + with_overlap_nondnb,bdid,local);

output(overlaps,named('overlaps')); //:persist('business_overlaps');

output(overlaps(overlap=TRUE),named('overlaps_overlaptrue'));



layout_description := Business_Header.Source_Tools.layout_description_old;


slim trans2(dupslimb l,layout_description r):=transform
self.DNB :=L.source ='D';
self.active :=if(l.dt_last_seen >20051100 or (l.source='U2' and (integer)(((string)l.dt_last_seen)[1..6]) >= 200511),TRUE,FALSE);
self.description :=r.description;
self :=l;
end;

pre_with_desc :=join(overlaps,business_header.source_codes,left.source=right.code, trans2(left,right),left outer);

output(pre_with_desc,named('pre_with_desc'));

with_desc :=distribute(pre_with_desc,hash(source));

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


output(tab1,named('crosstab'));

output(with_desc(source='D' and active=FALSE),named('checktable'));



/*
rec :=record
Business_header.File_Business_Header_Best.bdid;
end;

rec2 :=record
Business_header.File_Business_Header.bdid;
end;

business_best :=distribute(table(business_header.File_Business_Header_Best,rec),hash(bdid));

business_head :=dedup(sort(distribute(table(business_header.File_Business_Header(bdid<>0),rec2),hash(bdid)),bdid,local),bdid,local);

excluded_from_best :=join(business_best,business_head,left.bdid=right.bdid,right only,local);

output(excluded_from_best(bdid<>0));

*/