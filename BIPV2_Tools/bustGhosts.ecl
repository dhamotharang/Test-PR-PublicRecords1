//
// This routine is responsible for purging "ghost" records that have accumulated
// within the header.  Ghosts are records that we received from the data team at
// some moment in time, but which we are no longer receiving (in a form recognized
// by Ingest) due to code fixes on their end.  They are designated by Ingest as
// "Old" records.
//
// Ghost records belong to one of three mutually-exclusive categories:
// * Singletons -- records whose DOT and Prox clusters consist of just one record (themselves)
// * Non-roots -- records with a dotid or proxid less than their rcid
// * Roots -- records (excluding singletons) with a dotid or proxid equal to their rcid
//
// Purging singletons and non-roots is very straightforward -- just delete them.  Purging
// root records is a little more complicated, because deleting them breaks the id integrity
// of their clusters.  So, if we choose to delete root-level ghosts, we have to repair the
// id integrity.
//
// NOTE: This code assumes that DOT and Prox are the only levels of the ID Hierarchy being
// preserved.  We'll have to revisit this when the time comes for us to preserve everything.
//
// NOTE: This code assumes id integrity is good on the way in.  In particular, DidNoRid0
// errors will throw us off a little on detecting and repairing root-record changes.
//
// NOTE: This code could create partition integrity issues if we delete all the "A"
// records from a cluster and leave "B" records from >1 partitioned source.  I'm not
// sure I care too much about that... still thinking about it.
//

EXPORT bustGhosts(ds_in, ds_typ, bustSingletons, bustNonRoots, bustRoots, allSources=true, in_bustSources='') := FUNCTIONMACRO

	set of string2 bustSources := #if(allSources)
		[];
	#else
		in_bustSources;
	#end;

	// first, gather cluster stats at prox level (the highest cluster id we're preserving)
	ds_dist := distribute(ds_in, hash32(proxid));
	ds_cnt := table(ds_dist, {proxid, unsigned cnt_rcid_per_proxid:=count(group)}, proxid, local);

	// assimilate cluster stats into thin layout we'll work with until the end
	l_thin := record
		ds_in.source;
		ds_in.rcid;
		ds_in.dotid;
		ds_in.proxid;
		boolean isSingleton;
		boolean isRoot;
		string9 rec_type;
	end;
	ds_sgl := join(
		ds_dist, ds_cnt,
		left.proxid=right.proxid,
		transform(l_thin, self:=left, self.isSingleton:=(right.cnt_rcid_per_proxid=1), self.isRoot:=(left.rcid=left.dotid and not self.isSingleton), self:=[]),
		local);

	// assimilate rec_type from last Ingest
	ds_thin := join(ds_sgl, ds_typ, left.rcid=right.rcid, transform(l_thin, self:=right, self:=left), hash);

	// make decisions about what to keep and what to clobber
	isSource := allSources or (ds_thin.source in bustSources);
	isBustable := map(
		ds_thin.rec_type<>'Old'	=> false,
		ds_thin.isSingleton			=> bustSingletons,
		ds_thin.isRoot					=> bustRoots,
		bustNonRoots);
	shouldBust := isSource and isBustable;
	bust := ds_thin(shouldBust);
	retain := ds_thin(not shouldBust);
	
	// generate samples
	numSamples := 100;
	thin_sgl := enth(bust(isSingleton),numSamples);
	thin_root := enth(bust(isRoot),numSamples);
	thin_nonroot := enth(bust(not isSingleton and not isRoot),numSamples);
	thin_all := thin_sgl + thin_root + thin_nonroot;
	samp_all := join(thin_all,ds_in,left.rcid=right.rcid,hash);
	samp_sgl := samp_all(isSingleton);
	samp_root := samp_all(isRoot);
	samp_nonroot := samp_all(not isSingleton and not isRoot);
	
	// fix missing roots if necessary
	patch_dot := table(retain,{dotid, unsigned6 newroot:=min(group,rcid)},dotid,merge)(dotid<>newroot);
	patch_prox := table(retain,{proxid, unsigned6 newroot:=min(group,rcid)},proxid,merge)(proxid<>newroot);
	reroot1 := join(retain,patch_dot,left.dotid=right.dotid,transform(l_thin,self.dotid:=right.newroot,self:=left),left outer,hash,keep(1));
	reroot := join(reroot1,patch_prox,left.proxid=right.proxid,transform(l_thin,self.proxid:=right.newroot,self:=left),left outer,hash,keep(1));

	// apply to input file
	busted := join(ds_in, if(bustRoots, reroot, retain), left.rcid=right.rcid, transform(recordof(ds_in), self:=right, self:=left), hash);

	// debugging outputs
	output(table(ds_thin, {rec_type, isSingleton, isRoot, cnt:=count(group)}, rec_type, isSingleton, isRoot, merge), named('xtab_before'));
	output(table(retain, {rec_type, isSingleton, isRoot, cnt:=count(group)}, rec_type, isSingleton, isRoot, merge), named('xtab_after'));
	output(samp_sgl, named('samp_sgl'),all);
	output(samp_root, named('samp_root'),all);
	output(samp_nonroot, named('samp_nonroot'),all);
	output(count(table(ds_dist,{proxid},proxid,local)), named('cnt_proxid_before'));
	output(count(table(busted,{proxid},proxid,merge)), named('cnt_proxid_after'));
	output(count(table(ds_in,{dotid},dotid,merge)), named('cnt_dotid_before'));
	output(count(table(busted,{dotid},dotid,merge)), named('cnt_dotid_after'));
	if(bustRoots, output(enth(patch_prox,500), named('patch_prox')));
	if(bustRoots, output(enth(patch_dot,500), named('patch_dot')));
	if(bustRoots, output(count(patch_prox), named('cnt_patch_prox')));
	if(bustRoots, output(count(patch_dot), named('cnt_patch_dot')));
	if(bustRoots, output(table(reroot, {rec_type, isSingleton, isRoot, cnt:=count(group)}, rec_type, isSingleton, isRoot, merge), named('xtab_reroot')));
	
	RETURN busted;

ENDMACRO;
