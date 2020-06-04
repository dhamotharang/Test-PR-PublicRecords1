// changed 10-4-19

import ut,doxie,header,mdr, header_services,PRTE2_Header, suppress;

export fn_ADLSegmentation_v2(dataset(header.Layout_Header) hdr_in, boolean filter_utility_z_recs=false)  := module

	hdr_adl_in := header.regulatory.apply_ADL_Segment(hdr_in); 
		
	hdr_full := distribute(hdr_adl_in, hash(did)); 
 
  f_ := if(filter_utility_z_recs,hdr_full(src not in [mdr.sourceTools.src_ZUtilities,mdr.sourceTools.src_ZUtil_Work_Phone]),hdr_full);

	slimr := record
		f_.did;
		f_.dt_first_seen;
		f_.dt_last_seen;
		f_.prim_range;
		f_.prim_name;
		f_.sec_range;
		f_.zip;
		boolean  is_ambig                         := false;
		boolean  has_an_ssn                       := false;
		boolean  owns_an_ssn                      := false;
		boolean  ssns_dont_belong_to_someone_else := false;//testing with Z's, R's could also be discussed
		boolean  is_dead                          := false;
		unsigned rec_cnt                          := 1;
		unsigned src_cnt                          := 1;
		string   ind                              := '';
		string2  src;
	end;
	
    #IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
	df := dataset([],{header.file_did_death_masterv2});
    #ELSE
	df := dedup(sort(distribute(header.file_did_death_masterv2,hash((unsigned6)did)),did,local),did,local);
	#END;
  slimr x0(slimr le, slimr ri) := transform
	 self.ssns_dont_belong_to_someone_else := le.ssns_dont_belong_to_someone_else or ri.ssns_dont_belong_to_someone_else;
	 self := le;
	end;
	
	ssn_recs             := project(f_(ssn<>''),transform({slimr},self.ssns_dont_belong_to_someone_else:=left.valid_ssn<>'Z',self:=left));
	ssn_recs_dupd        := dedup(sort(ssn_recs,did,ssns_dont_belong_to_someone_else,local),did,ssns_dont_belong_to_someone_else,local);
	roll_ssn_recs_by_did := rollup(ssn_recs_dupd,left.did=right.did,x0(left,right),local);
	
	slimr x1(f_ le, df ri) := transform
	 self.is_ambig    := le.jflag2<>'';
	 //self.has_an_ssn  := ut.full_ssn(le.ssn);
	 self.has_an_ssn  := le.ssn<>'';
	 self.owns_an_ssn := self.has_an_ssn and le.valid_ssn='G';
	 self.is_dead     := /*le.src=mdr.sourceTools.src_Death_Master or*/ (unsigned6)ri.did > 0;	
	 self.src         := if(le.src in [mdr.sourceTools.src_ZUtilities,mdr.sourceTools.src_ZUtil_Work_Phone],mdr.sourceTools.src_Equifax,le.src);
	 self             := le;
	end;

	f := join(distributed(f_,hash(did)),df,left.did=(unsigned6)right.did,x1(left,right),left outer,local);
		
	//Just get all DIDs
	slimr roller(slimr le,slimr ri) := transform	
		SELF.dt_last_seen  := max    (le.dt_last_seen,ri.dt_last_seen);
		SELF.dt_first_seen := ut.min2(le.dt_first_seen,ri.dt_first_seen);
        self.is_ambig      := le.is_ambig    or ri.is_ambig;
		self.has_an_ssn    := le.has_an_ssn  or ri.has_an_ssn;
		self.owns_an_ssn   := le.owns_an_ssn or ri.owns_an_ssn;
		self.is_dead       := le.is_dead     or ri.is_dead;
		self.rec_cnt       := le.rec_cnt + ri.rec_cnt;
		self.src           := ri.src;
		self.src_cnt       := if(le.src<>ri.src,le.src_cnt+1,le.src_cnt);
		self               := le;
	END;
	
	rollem0 := rollup(sort(f,did,src,local),left.did=right.did,roller(left,right),local);
  rollem  := join(rollem0,roll_ssn_recs_by_did,left.did=right.did,transform({slimr},self.ssns_dont_belong_to_someone_else:=right.ssns_dont_belong_to_someone_else,self:=left),left outer,local);
	
	latest_dt_rec := RECORD
		rollem.dt_last_seen;
		cnt := count(group);
	END;
	
	//latest_date_table := table(sort(distribute(rollem,hash(dt_last_seen)),dt_last_seen,local),latest_dt_rec,dt_last_seen,local);
	latest_date_table := table(rollem,latest_dt_rec,dt_last_seen,few);
	latest_date       := ((string6)max(latest_date_table(cnt>1000),dt_last_seen))+'01';
	
  // Bad Data
	h1 := DEDUP(SORT(f(ind=''),did,prim_name,-dt_last_seen,local),did,prim_name,local);

	r :=
	RECORD
		f.prim_name;
		max_date := max(GROUP,h1.dt_last_seen);
	END;
		// Get every street name and the last time we saw it
	t := TABLE(h1,r,prim_name,few);
		// Take the list of old street names - we'll take thse as "bad"
	old_addr := distribute(t(ut.DaysApart(((STRING6)max_date)+'01',latest_date)>18*30),hash(prim_name));
		// Get the list of header records that have good street names
	j := JOIN(distribute(f(prim_name<>''),hash(prim_name)),old_addr,LEFT.prim_name=RIGHT.prim_name,LEFT ONLY, local);
	dj := DEDUP(SORT(DISTRIBUTE(j,HASH(did)),did,LOCAL),did,LOCAL);
	
	
  dead_check     := project(rollem,        transform({slimr},self.ind:=if(left.ind='' and left.is_dead,'DEAD',left.ind),self:=left));	
	noise_check    := join(dead_check,dj,left.did=right.did,transform({slimr},self.ind:=if(left.ind='' and right.did=0,'NOISE',left.ind),self:=left),left outer,local);
  //note the exclusion of ambiguous people from suspect
	suspect_check  := project(noise_check,   transform({slimr},self.ind:=if(left.ind='' and ~left.is_ambig and left.has_an_ssn and ~left.ssns_dont_belong_to_someone_else,'SUSPECT',left.ind),self:=left));
	hmerge_check   := project(suspect_check, transform({slimr},self.ind:=if(left.ind='' and ut.DaysApart(latest_date,left.dt_last_seen+'01')>24*30 and left.src_cnt=1,'H_MERGE',left.ind),self:=left));
	cmerge_check   := project(hmerge_check,  transform({slimr},self.ind:=if(left.ind='' and left.src_cnt=1,'C_MERGE',left.ind),self:=left));	
	inactive_check := project(cmerge_check,  transform({slimr},self.ind:=IF(left.ind='' and (ut.DaysApart(latest_date,left.dt_last_seen+'01') > 24*30),'INACTIVE',left.ind),self:=left));	
	amb_check      := project(inactive_check,transform({slimr},self.ind:=IF(left.ind='' and left.is_ambig,'AMBIG',left.ind),self:=left));
  ssn_check      := project(amb_check,     transform({slimr},self.ind:=IF(left.ind='' and ~left.has_an_ssn, 'NO_SSN', left.ind),self:=left));
	core1_check    := project(ssn_check,     transform({slimr},self.ind:=IF(left.ind='' and left.owns_an_ssn and left.src_cnt>1,'CORE',left.ind),self:=left));
  core2_check    := project(core1_check,    transform({slimr},self.ind:=IF(left.ind='','CORENOVSSN',left.ind),self:=left));
 
 export  core_check     := core2_check;
 export  core_check_pst := core_check : persist('persist::adl_segmentation_v2');

cross := record
	core_check_pst.ind;
	cnt := count(group);
end;

export tab := table(core_check_pst,cross,ind,few);
//output(sort(tab,ind),named('AdlSegmentation_Table'));

end;