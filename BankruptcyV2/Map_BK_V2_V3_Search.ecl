searchNonTrustee	:=	sort(distribute(BankruptcyV2.file_bankruptcy_search(trim(name_type,left,right)<>'T1'),hash(tmsid)),tmsid,local);

main				:=	sort(distribute(BankruptcyV2.file_bankruptcy_main,hash(tmsid)),tmsid,local);

NewSearchLayout		:=	record
	BankruptcyV2.layout_bankruptcy_search;
	string8		date_filed;
	string3		chapter;
	string10	orig_filing_type;
	string1		corp_flag;
	string8		disposed_date;
	string35	disposition;
	string3		pro_se_ind;
	string128	record_type;
	string8		converted_date;
end;
	
BankruptcyV2.layout_bankruptcy_search_v3	joinForNewSearch(BankruptcyV2.layout_bankruptcy_search l, bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing r)	:=	transform
	self.filing_type	:=	r.orig_filing_type;
	self.discharged		:=	r.disposed_date;
	self				:=	l;
	self				:=	r;
	self				:=	[];
end;

export Map_BK_V2_V3_Search	:=	sort(distribute(join(searchNonTrustee,main, trim(left.TMSID,left,right) = trim(right.TMSID,left,right), joinForNewSearch(left, right),left outer, local),hash(tmsid)),tmsid,local);