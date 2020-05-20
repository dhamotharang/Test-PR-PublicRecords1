import lib_fileservices, ut, header_services, doxie,_Control,data_services,header,PRTE2_Header,PRTE2_Watchdog;

EXPORT Key_Prep_Watchdog_GLB(boolean exclude_util = false)  := FUNCTION

string_rec := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

wdog1 := dataset(data_services.Data_Location.Watchdog_Best + 'thor_data400::BASE::Watchdog_best',string_rec,flat);
wdog2 := project(Watchdog.File_Best_nonutility ,transform(string_rec,self.__filepos := 0, SELF:=LEFT));

wdog0 := if(~exclude_util, wdog1,wdog2);

wdog := watchdog.prep_build.prep(wdog0);

candidates := distribute(wdog(trim(fname)='' or trim(lname)=''),hash(did));
not_candidates := wdog(~(trim(fname)='' or trim(lname)=''));
_nonutil := if(exclude_util,'_nonutil','');
glb_pst        := distribute(dataset('~thor400_84::out::watchdog_filtered_header'+_nonutil,header.layout_header,flat),hash(did));;

header.layout_header t1(glb_pst le, candidates ri) := transform
 self := le;
end;

j1 := join(glb_pst,candidates
			,left.did=right.did
			,t1(left,right)
			,local);

//only fix those that need fixing
bestFirstLast	:=	watchdog.fn_BestFirstLastName(j1);

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
//temporary hack to fix IRS test case
// Bug: 88535 - Mark Marsupial No Longer retuns in BPSReport
_fb := project(concat1,transform(watchdog.layout_key,self.total_records:=if(left.did=166287520519,0,left.total_records),self:=left));
#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
fb := project(PRTE2_Watchdog.files.file_best,transform({_fb},SELF.__filepos:=0,SELF:=LEFT));
#ELSE
ut.mac_suppress_by_phonetype(_fb,phone,st,fb,true,did);
#END
RETURN INDEX(fb,{fb},data_services.Data_location.prefix('watchdog')+'thor_data400::key::watchdog_best'+_nonutil+'.did_'+doxie.Version_SuperKey);

END;