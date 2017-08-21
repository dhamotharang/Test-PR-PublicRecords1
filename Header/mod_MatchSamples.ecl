numper := 5;		//how many samples to each person
folks := ['Chad','Angela','Wendy','Danny','DWheelock','Dave','Manish']; //those who will review
numfolks := 7;	//i could just count here, but there are two other places in the code where i would need to update by hand if this changed

export mod_MatchSamples(
	dataset(header.Layout_Header) h,
	dataset(header.Layout_PairMatch) r,
	dataset(header.layout_DodgyDids) DD = dataset([], header.layout_DodgyDids),
	string	pass_sffx	=	''
) := 
MODULE


//***** GENERATE A SAMPLE FOR EACH PERSON AFTER GETTING RID OF ANY OVERLAP
numneeded := numper * numfolks;

 //clean up the rules first to make sure we get a good sample
rn1 := join(r, DD, left.old_rid = right.did, left only, hash);  //not in DD
rn2 := join(rn1, DD, left.new_rid = right.did, left only, hash);
rbigsamp := enth(rn2, numneeded*5);      
rd1 := dedup(rbigsamp, old_rid, all);	//dedup
rd2 := dedup(rd1, new_rid, all);
rc1 := rd2(old_rid not in set(rd2, new_rid));	//not transitive
rc2 := rc1(new_rid not in set(rc1, old_rid));
rc3	:= dedup(join(h, rc2, left.did = right.old_rid, transform(header.Layout_PairMatch, self := right), lookup), all);
rc4 := dedup(join(h, rc3, left.did = right.new_rid, transform(header.Layout_PairMatch, self := right), lookup), all);  //and actually appears in the header in case of weird dodgy situation (maybe the only rule we need up here)

re := enth(rc4, numneeded);
rseq := project(re, transform({re, unsigned2 seq}, self.seq := counter, self := left));

rec := {unsigned2 GroupID, header.Layout_Header};

rec tra(h l, rseq r) := transform
	self.GroupID := r.seq;
	self := l;
end;

j1 := join(h, rseq, left.did = right.new_rid, tra(left, right), lookup);
j2 := join(h, rseq, left.did = right.old_rid, tra(left, right), lookup);

j := sort(j1 + j2, groupID, did);

f(unsigned2 i) := function
	start := (i-1)*numper;
	stop := i*numper;
	return output(j(GroupID > start and GroupID <= stop), named('HeaderMatchSamples'+pass_sffx+folks[i]),all);
	// return output(dedup(j(GroupID > start and GroupID <= stop), did, all), named('HeaderMatchSamples'+folks[i]), all);

end;


//***** ALSO LOOK FOR SOME MATCHES THAT WE KNOW TO BE BAD
bads := 
	join(
		r,
		Header.dsBadADLCollapses.records,		//this needs to be updated with bad matches that we have so far avoided
		left.new_rid = right.did2 and
		left.old_rid = right.did1,
		transform(
			Header.dsBadADLCollapses.layout,
			self := right
		),
		lookup
	);

export samples := 
	parallel(
		output(choosen(bads, 500), named('HeaderMatchSamplesBAD'+pass_sffx)),
		output(r,,'cemtemp::HeaderMatchSamplesRules'+pass_sffx,overwrite),
		f(1),
		f(2),
		f(3),
		f(4),
		f(5),
		f(6),
		f(7)
	);


//***** WHEN THE SAMPLES ARE READY, UPDATE ISIT
sendto 	:= 
// 'rt@isit.br.seisint.com';
'cmorton@seisint.com';
subject := '[isit.seisint.com #114917]';
body		:= 
folks[1] + ', ' + 
folks[2] + ', ' +
folks[3] + ', ' +
folks[4] + ', ' +
folks[5] + ', ' +
folks[6] + ', ' +
folks[7] + ', ' + 'here is a new set of ADL matches for you to review: \nhttp://prod_esp.br.seisint.com:8010/WsWorkunits/WUInfo?Wuid=' + thorlib.wuid();

export email := FileServices.SendEmail( sendto, subject, body);


//***** DO BOTH SAMPLES AND EMAIL


export DoALL := 
	sequential(
		samples,
		email
	);

END;