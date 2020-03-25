import ut,doxie,watchdog,header,mdr,header_services,_Control, Data_Services;

string_rec := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

wdog0 := dataset( '~thor_data400::BASE::Watchdog_best_nonen',string_rec,flat);

wdog := watchdog.prep_build.prep(wdog0);

candidates := distribute(wdog(trim(fname)='' or trim(lname)=''),hash(did));
not_candidates := wdog(~(trim(fname)='' or trim(lname)=''));
glb_pst        := distribute(dataset('~thor400_84::out::watchdog_filtered_header_nonen',header.layout_header,flat),hash(did));;

header.layout_header t1(glb_pst le, candidates ri) := transform
 self := le;
end;

j1 := join(glb_pst,candidates
			,left.did=right.did
			,t1(left,right)
			,local);

//only fix those that need fixing
bestFirstLast	:=	fn_BestFirstLastName(j1);

string_rec tr(candidates l,bestFirstLast r) := transform
	self.fname	:=	if(l.fname='',r.fname,l.fname);
	self.lname	:=	if(l.lname='',r.lname,l.lname);
	self        := l;
end;

fb0:=join(candidates,bestFirstLast
			,left.did=right.did
			,tr(left,right)
			,left outer
			,local);

concat := fb0+not_candidates;

candidates1 := distribute(concat(trim(ssn)=''),hash(did));
not_candidates1 := concat(~(trim(ssn)=''));

j2 := join(glb_pst,candidates1
			,left.did=right.did
			,t1(left,right)
			,local);

_bestSSN	:=	watchdog.fn_best_ssn(j2).concat_them;

string_rec tr0(candidates1 l,_bestSSN r) := transform
	self.ssn	:=	if(l.ssn='',r.ssn,l.ssn);
	self        :=	l;
end;

fb00:=join(candidates1,_bestSSN
			,left.did=right.did
			,tr0(left,right)
			,left outer
			,local);

concat1 := fb00+not_candidates1;

_fb := project(concat1,watchdog.layout_key);
ut.mac_suppress_by_phonetype(_fb,phone,st,fb,true,did);

export Key_Watchdog_GLB_nonExperian_nonblank_old := INDEX(fb,{fb},
 Data_Services.Data_location.Prefix('Watchdog_Best')+'thor_data400::key::watchdog_best_nonen.did_nonblank_'+doxie.Version_SuperKey);