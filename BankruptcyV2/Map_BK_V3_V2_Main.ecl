dsMain		:=	distribute(BankruptcyV2.file_bankruptcy_main_v3,hash(tmsid));

dsSearch	:=	dedup(sort(distribute(BankruptcyV2.file_bankruptcy_search_v3(trim(debtor_type,left,right)='P'),hash(tmsid)),tmsid, -process_date,local),tmsid,local);

tempSearchStatus	:=	record
	bankruptcyV2.Layout_bankruptcy_search_v3;
	string8     status_date;
	string30    status_type;
end;
	
tempSearchStatus tnormalize(dsSearch L, integer cnt) := transform
	self.status_date := choose(Cnt, l.converted_date,
									l.dateVacated,
									l.dateTransferred,
									l.discharged);
	self.status_type := choose(cnt,	if(l.converted_date <> '', 'CONVERTED' , ''),
									if(l.dateVacated<>'','VACATED',''),
									if(l.dateTransferred <>'', 'TRANSFERRED',''),
									if(L.discharged<>'',stringlib.StringToUpperCase(L.disposition),''));									
	self := L;
end;

search_norm := normalize(dsSearch, 4, tnormalize(left, counter),local);

SearchStatus := record, maxlength(10000)
	string8     status_date := '';
	string30    status_type := '';
end;

fatLayout	:=	RECORD
	bankruptcyV2.Layout_bankruptcy_search_v3;
	dataset(SearchStatus)   status;
end;

fatLayout tmakefatrecord(tempSearchStatus L) := transform
  self.status   := DATASET([{ l.status_date, l.status_type }], bankruptcyV2.Layout_bankruptcy_main_v3.layout_status);
  self := L;
end;

file_flat := project(search_norm, tmakefatrecord(left));

fatLayout tmakechildren(fatLayout l, fatLayout r) := transform
	self.status				:=	L.status + row({r.status[1].status_date, r.status[1].status_Type},BankruptcyV2.layout_bankruptcy_main.layout_status);
	self					:=	L;
end;

rolledSearch := rollup(file_flat,TMSID,tmakechildren(left, right),local);

BankruptcyV2.layout_bankruptcy_main.layout_bankruptcy_main_filing trfMain(BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp l, fatLayout r) := transform
	self.disposed_Date		:= 	r.discharged;
	self.orig_filing_type	:=	r.filing_type;
	self.status				:=	(r.status + l.status)(status_date !='');
	self.comments			:=	l.comments(filing_date !='');
	self					:=	l;
	self					:=	r;
end;

export Map_BK_V3_V2_Main 	:= sort(join(dsMain, rolledSearch,  trim(left.TMSID,left,right) = trim(right.TMSID,left,right), trfMain(left, right), left outer, local) ,tmsid, local);// :  persist('persist::bkv2::main');