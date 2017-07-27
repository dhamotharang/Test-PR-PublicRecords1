import codes;
export make_ReportDetail(dataset(uccd.Layout_Doxie_Records) old) := 
FUNCTION
/*
INCOMING FILE MUST SHARE A UCC_KEY
*/

just1 := choosen(sort(old, if(event_key = ucc_key, 0, 1)),1);

//**** layouts 
debtor_Rec := uccd.layout_jfk_debtor;

secured_rec := uccd.layout_jfk_secured;

filing_Rec := record
	string50  ucc_key;
	unsigned6 did;
	unsigned6	bdid;
	DATASET(uccd.Layout_Collateral_ChildDS) collateral_children;
	uccd.layout_jfk_summary;
	string40 filing_state_decode := '';
	string32 document_num := '';
	string8 orig_filing_date := '';
end;

event_rec := record	
	uccd.layout_jfk_event;
	dataset(debtor_Rec) debtor_children;
	dataset(secured_rec) secured_children;
end;

report_rec := record
	filing_rec;
	dataset(event_rec) event_children;
end;

//**** preperation
mac_makeit(ds,rec,ds_out) := macro
	#uniquename(tra)
	rec %tra%(ds l) := transform
		self := l;
		self := [];
	end;
	ds_out := dedup(project(ds, %tra%(left)), all);
endmacro;

//mac_makeit(just1,report_rec,thefiling)
mac_makeit(old,debtor_rec,debtors)
mac_makeit(old,secured_rec,secureds)
mac_makeit(old,event_rec,events)

//**** rearrange

event_rec addsecureds(events l, secureds r) := transform
	self.secured_children := l.secured_children + r;
	self := l;
end;

wsecureds := denormalize(events, secureds, left.event_key = right.secured_event_key,
											   addsecureds(left, right));
												 
//output(wsecureds);

event_rec adddebtors(wsecureds l, debtors r) := transform
	self.debtor_children := l.debtor_children + r;
	self := l;
end;

wdebtors := denormalize(wsecureds, debtors, left.event_key = right.debtor_event_key,
											  adddebtors(left, right));
												
//output(wdebtors);

report_rec addevents(just1 l) := transform
	self.event_children := global(sort(wdebtors,-filing_date));
	self.filing_state_decode := codes.GENERAL.STATE_LONG(l.filing_state);
	self.document_num := l.event_document_num;
	self.orig_filing_date := l.orig_filing_date;
	self := l;
end;

wevents := project(just1, addevents(left));

return wevents;

END;