import business_header;
//this attribute is to find the best people at work records

paw_in_file := business_header.file_business_contacts_stats(did<>0,
                                                            bdid<>0,
												from_hdr='N',
												combined_score>=50);
											 
paw_slim_rec := record
	unsigned6 did;
	unsigned6 bdid;  
	unsigned4 dt_last_seen;
	unsigned4 dt_first_seen;
	unsigned1 combined_score;
end;											 

paw_slim_rec slim_paw(paw_in_file l) := transform
	self := l;
end;

paw_slim_in := project(paw_in_file, slim_paw(left));

paw_slim_dist := distribute(paw_slim_in, hash(did));
paw_slim_sort := sort(paw_slim_dist,did,-dt_last_seen,-combined_score,-dt_first_seen,bdid,local);
paw_slim_dedup := dedup(paw_slim_sort,did,local);

paw_out_rec := record
	unsigned6 did;
	unsigned6 bdid;  
end;											 

paw_out_rec get_out(paw_slim_dedup l) := transform
	self := l;
end; 

paw_best_out := project(paw_slim_dedup, get_out(left), local);

export BestPeopleAtWork := paw_best_out : persist('persist::best_people_at_work');