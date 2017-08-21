export proc_build_base_search_supp(dataset(recordof(BankruptcyV2.layout_bankruptcy_search_v3_supp)) infile) := function
import BankruptcyV2;
cmbdTbl_supp := BankruptcyV2.proc_build_v3_supplemental;	//supplemental table of missing fields not included in original common layout

//Add additional fields and populate



BankruptcyV2.layout_bankruptcy_search_v3_supp patchBase(infile L, cmbdTbl_supp R) := transform
//self.orig_email    := if(l.tmsid=r.tmsid,R.debtor1AttorneyEmail,'');
//self.method_dismiss := if(l.tmsid=r.tmsid,R.methodDismiss,'');/
//self.case_status    := if(l.tmsid=r.tmsid,R.caseStatus,'');
//self.debtor1AttorneyEmail := if(l.tmsid=r.tmsid,R.debtor1AttorneyEmail,'');
//self.TrusteeEmail:= if(l.tmsid=r.tmsid,R.TrusteeEmail,'');
//self.PlanConfDate := if(l.tmsid=r.tmsid,R.PlanConfDate,'');
//self.ConfHearDate := if(l.tmsid=r.tmsid,R.ConfHearDate,'');
self.Screen:= map(l.tmsid=r.tmsid and L.screen != '' => R.debtor1Screen,L.screen);
//self.datePOC := if(l.tmsid=r.tmsid,R.datePOC,'');
//self.meeting_date:= if(l.tmsid=r.tmsid,R.date341,'');
//self.meeting_time:= if(l.tmsid=r.tmsid,R.time341,'');
//self.address_341 := if(l.tmsid=r.tmsid,R.location341,'');
self := L;
end;



outfile:= distribute(join(distribute(infile,hash(tmsid)), distribute(cmbdTbl_supp,hash(tmsid)),
		left.tmsid = right.tmsid,
		patchBase(left,right),left outer,local),hash(tmsid));
	
return
outfile;
end;