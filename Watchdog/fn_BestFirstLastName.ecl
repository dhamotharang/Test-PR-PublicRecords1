import header;

EXPORT fn_BestFirstLastName(dataset(recordof(header.layout_header)) in_hdr)
	:=
	FUNCTION

	/*Find the Best First and Last Name
	Group by DID and fname, then count the occurrences.
	If the second most frequent is the 'preferredfirst' of the most frequent, pick it.
	If not, pick the most frequent only if it is 1.5x as frequent as the next.
	If not, don't pick any -- we don't have a 'best' fname*/

	f0:=in_hdr;

	rfields := record
		f0.did;
		f0.fname;
		integer4     fname_count := 0;
		f0.lname;
		integer4     lname_count := 0;
		f0.dt_last_seen;
		integer4     dls_count := 0;
	end;

	f:=distribute(table(f0(fname<>'' or lname<>''),rfields),hash(did));

	rfields slim(f le) := transform
		self.fname := trim(le.fname);
		self.lname := trim(le.lname);
		self := le;
	end;

	slim_h := project(f(fname<>''),slim(left),local);
	slim_h2 := project(f(lname<>''),slim(left),local);

	//Sort by DID and fname
	srt_h := sort(slim_h(fname <> ''),did,fname,dt_last_seen,local);
	srt_h2 := sort(slim_h2(lname <> ''),did,lname,dt_last_seen,local);

	//Group by DID and fname
	grp := group(srt_h,did,fname,local);
	grp2 := group(srt_h2,did,lname,local);
	grp3 := group(srt_h2,did,lname,dt_last_seen,local);

	//Count the occurrances of each DID and fname combination
	rfields cnt_fname(rfields le, rfields rt) := transform
		self.fname_count := le.fname_count + 1;
		self := rt;
	end;
	rfields cnt_lname(rfields le, rfields rt) := transform
		self.lname_count := le.lname_count + 1;
		self := rt;
	end;
	rfields cnt_dls(rfields le, rfields rt) := transform
		self.dls_count := le.dls_count + 1;
		self := rt;
	end;

	fname_did_cnt := iterate(grp,cnt_fname(left,right));
	lname_did_cnt := distribute(iterate(grp2,cnt_lname(left,right)),hash(did));
	dls_did_cnt	  := distribute(iterate(grp3,cnt_dls(left,right)),hash(did));

	rfields lname_dls_join(rfields l, rfields r) := transform
		self.lname			:=	l.lname;
		self.lname_count	:=	l.lname_count;
		self.dt_last_seen	:=	r.dt_last_seen;
		self.dls_count		:=	r.dls_count;
		self				:=	l;
	end;

	lname_dls_did_cnt:=join(lname_did_cnt, dls_did_cnt
						,	left.did=right.did
						and	left.lname=right.lname
						,lname_dls_join(left,right)
						,right outer
						,local);

	//Sort and dedup by fname to give one record per DID/fname with the highest count
	cnt_dedup	:= dedup(sort(fname_did_cnt,-fname_count,-dt_last_seen),fname);
	cnt_dedup2	:= dedup(sort(lname_dls_did_cnt,-lname_count,-dls_count,local),lname,dt_last_seen,local);

	//Ungroup and resort
	group_sort	:= sort(group(cnt_dedup),did,-fname_count,-dt_last_seen,local);
	group_sort2	:= sort(group(cnt_dedup2),did,-lname_count,-dt_last_seen,local);

	//Dedup by DID keeping the top two most frequent
	two_DID		:= dedup(group_sort,did,keep 2,local);
	two_DID2	:= dedup(group_sort2,did,keep 2,local);

	//If fname count is 1.5x greater than the next, it is 'best'
	rfields fname_join(rfields le, rfields rt) := transform
		fname := MAP(length(trim(le.fname)) = 1 and le.fname[1] = rt.fname[1] => rt.fname,
						  length(trim(rt.fname)) = 1 and le.fname[1] = rt.fname[1] => le.fname,
						  datalib.preferredfirst(le.fname) = rt.fname => rt.fname,
						  datalib.preferredfirst(rt.fname) = le.fname => le.fname,
						  le.fname_count < 1.5*rt.fname_count => '',le.fname);

		self.fname := if(fname=''
						,MAP(	
								length(trim(le.fname))	> length(trim(rt.fname))	=> le.fname

								,length(trim(rt.fname))	> length(trim(le.fname))	=> rt.fname

								,		length(trim(le.fname))	= length(trim(rt.fname))
								and		le.fname_count			> rt.fname_count	=> le.fname

								,		length(trim(le.fname))	= length(trim(rt.fname))
								and		rt.fname_count			> le.fname_count	=> rt.fname

								,		length(trim(le.fname))	= length(trim(rt.fname))
								and		le.fname_count			= rt.fname_count
								and		le.dt_last_seen			> rt.dt_last_seen	=> le.fname

								,rt.fname
							)
						,fname);
		self := le;
	end;

	join_cnt := join(two_DID,two_DID
						,	left.did=right.did
						and	left.fname <> right.fname
						,fname_join(left,right)
						,left outer
						,local);		


	//If lname count is 1.5x greater than the next, it is 'best'
	rfields lname_join(rfields le, rfields rt) := transform
		lname := MAP(length(trim(le.lname)) = 1 and le.lname[1] = rt.lname[1] => rt.lname,
						  length(trim(rt.lname)) = 1 and le.lname[1] = rt.lname[1] => le.lname,
						  datalib.preferredfirst(le.lname) = rt.lname => rt.lname,
						  datalib.preferredfirst(rt.lname) = le.lname => le.lname,
						  le.lname_count < 1.5*rt.lname_count => '',le.lname);

		self.lname := if(lname=''
						,MAP(	
										le.lname_count			> rt.lname_count
								and		le.dls_count			> rt.dls_count
								and		le.dt_last_seen			> rt.dt_last_seen			=> le.lname

								,		le.lname_count			< rt.lname_count
								and		le.dls_count			< rt.dls_count
								and		le.dt_last_seen			< rt.dt_last_seen			=> rt.lname

								,		le.lname_count			> rt.lname_count
								and		le.dls_count			> rt.dls_count				=> le.lname

								,		le.lname_count			< rt.lname_count
								and		le.dls_count			< rt.dls_count				=> rt.lname

								,		le.lname_count			> rt.lname_count
								and		le.dt_last_seen			> rt.dt_last_seen			=> le.lname

								,		le.lname_count			< rt.lname_count
								and		le.dt_last_seen			< rt.dt_last_seen			=> rt.lname

								,		le.dls_count			> rt.dls_count
								and		le.dt_last_seen			> rt.dt_last_seen			=> le.lname

								,		le.dls_count			< rt.dls_count
								and		le.dt_last_seen			< rt.dt_last_seen			=> rt.lname

								,		le.dls_count			> rt.dls_count				=> le.lname

								,		le.dls_count			< rt.dls_count				=> rt.lname

								,		le.lname_count			> rt.lname_count			=> le.lname

								,		le.lname_count			< rt.lname_count			=> rt.lname

								,		le.dt_last_seen			> rt.dt_last_seen			=> le.lname

								,		le.dt_last_seen			< rt.dt_last_seen			=> rt.lname

								,		length(trim(le.lname))	> length(trim(rt.lname))	=> le.lname

								,		length(trim(le.lname))	< length(trim(rt.lname))	=> rt.lname

								,le.lname
							)
						,lname);
		self := le;
	end;

	join_cnt2 := join(two_DID2,two_DID2
						,	left.did=right.did
						and	left.lname <> right.lname
						,lname_join(left,right)
						,left outer
						,local);


	//sort and dedup by did
	sorted_duped0 := dedup(sort(join_cnt,did,-fname_count,-fname,-dt_last_seen,local),did,local);		
	sorted_duped2 := dedup(sort(join_cnt2,did,-lname_count,-lname,-dt_last_seen,local),did,local);		

	rfields tr_comb(rfields l, rfields r) := transform
		self.fname			:=	l.fname;
		self.fname_count	:=	l.fname_count;
		self.lname			:=	r.lname;
		self.lname_count	:=	r.lname_count;
		self				:=	l;
	end;
	sorted_duped:=join(sorted_duped0, sorted_duped2
				,left.did=right.did
				,tr_comb(left,right)
				,left outer
				,local);

	//output only the 'best' fname records (at most one per DID)

    //looks like it's already distributed
	bestFirstLast	:=	distribute(sorted_duped,hash(did));

	return bestFirstLast;
end;