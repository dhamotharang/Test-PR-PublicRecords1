import text_search, bankruptcyv2,codes;

export Convert_BK_Func := function
	
	// dmain := bankruptcyv2.file_bankruptcy_main;
	// dparty := bankruptcyv2.file_bankruptcy_search;
	//VC DF-23528
	dmain1    := bankruptcyv2.file_bankruptcy_main;	
  dist_id 	:= distribute(dmain1, hash(TMSID));
	sort_id 	:= sort(dist_id, TMSID, -process_Date, local);
	dmain    	:= dedup(sort_id, TMSID,local);
	//VC DF-23528
	dparty1       := bankruptcyv2.file_bankruptcy_search;	
	Partydist_id 	:= distribute(dparty1, hash(TMSID));
	Partysort_id 	:= sort(Partydist_id, TMSID, -process_Date, local);
	dparty  	    := dedup(Partysort_id, TMSID,local);	
	
  Partysort_id joinLatest(Partysort_id l, dparty r)	:=	transform
		self	:= l;
	end;
	
	joinedForLatest	:=	join(Partysort_id, dparty,
	                         left.TMSID=right.TMSID and
								           left.process_Date=right.process_Date,
								           joinLatest(left,right),local	);
                           
	// Document Record Layout which has child dataset (The content is a child dataset)
	text_bk_record := record(Text_Search.Layout_Document)
		string50 tmsid;
	end;

	// Document record in flat format (The content is a record)	
	text_bk_Flat := record(Text_Search.Layout_DocSeg)
		string50 tmsid;
	end;
	
	my_main_rec := record
	string8    process_date;
    string50   TMSID ;
    string1	   source;
    string12   id;
    string10   seq_number;
    string8    date_created;
    string8    date_modified;
    string5    court_code;
    string50   court_name;
    string40   court_location;
    string7    case_number;
    string25   orig_case_number;
    string3    chapter;
    string8    date_filed;
    string10   orig_filing_type;
    string12   filing_status;
    string3    orig_chapter;
    string8    orig_filing_date;
    string5    assets_no_asset_indicator;
    string1	   filer_type;
    string1    corp_flag;
    string8    meeting_date;
    string8    meeting_time;
    string90   address_341;
    string8    claims_deadline;
    string8    complaint_deadline;
    string8    disposed_date;
    string35   disposition;
    string3    pro_se_ind;
    string35   judge_name;
    string5    judges_identification;
    string128  record_type;
    string2    filing_jurisdiction ;
    string20   assets ;
    string20   liabilities;
    string1    CaseType;
    string1    AssocCode;
	/*string25 SplitCase;	
    string25   FiledInError;*/
	string8    date_last_seen ; 
    string8    date_first_seen ;
	string8    date_vendor_first_reported := '';
    string8    date_vendor_last_reported := '';

    string8    converted_date;
    string8	   reopen_date;
    string8    case_closing_date;
	
	
	end;
	
	my_main_rec proj_rec(dmain l) := transform
		self := l;
	end;
	
	dparent_proj := project(dmain,proj_rec(left));
	
	stat_rec := record
		string50 tmsid;
		bankruptcyv2.layout_bankruptcy_main.layout_status;
	end;
	
	stat_rec norm1(dmain l,bankruptcyv2.layout_bankruptcy_main.layout_status r) := transform
		self.status_date := r.status_date;
		self.status_type := r.status_type;
		self := l;
	end;
	
	dnorm1 := normalize(dmain,left.status,norm1(left,right));
	
	desc_rec := record
		string50 tmsid;
		bankruptcyv2.layout_bankruptcy_main.layout_comments;
	end;
	
	desc_rec norm2(dmain l,bankruptcyv2.layout_bankruptcy_main.layout_comments r) := transform
		self.description := r.description;
		self.filing_date := r.filing_date;
		self := l;
	end;
	
	dnorm2 := normalize(dmain,left.comments,norm2(left,right));
	
	// filtering out blank child records
	//fullnorm1 := dnorm1(status_date <> '' and status_type <> '') + dnorm2(description <> ''  and filing_date <> '');
	
	text_bk_record convt_main(dparent_proj l) := transform
		self.tmsid := l.tmsid;
		self.docref.src := (unsigned6)l.tmsid[1..3];
		self.docref.doc := 0;
		self.segs := dataset([
		{4,0, l.casetype + ';' + codes.BANKRUPTCIES.FILING_TYPE(l.orig_filing_type)},
		{11,0,l.filing_jurisdiction},
		{13,0,l.orig_case_number + ';' + l.case_number + ';'},
		{14,0,l.orig_chapter + ';' + l.chapter},
		{15,0,l.orig_filing_date + ';' + l.date_filed},
		{19,0,l.court_name},
		{20,0,l.court_location},
		{21,0,l.judge_name + ' ' + l.judges_identification},
		{22,0,l.meeting_date},
		{23,0,l.meeting_time},
		{24,0,l.address_341},
		{25,0,l.assets},
		{26,0,l.liabilities},
		{27,0,l.claims_deadline},
		{28,0,l.complaint_deadline}
	
		], Text_Search.Layout_Segment);
	end;
	
	main_proj := project(dparent_proj,convt_main(left));
	
	text_bk_record convt_stat(dnorm1 l) := transform
		self.tmsid := l.tmsid;
		self.docref.src := (unsigned6)l.tmsid[1..3];
		self.docref.doc := 0;
		self.segs := dataset([
		{29,0,l.status_type},
		{30,0,l.status_date}
		], Text_Search.Layout_Segment);
	end;
	
	dchild1 := project(dnorm1(status_date <> '' or status_type <> ''),convt_stat(left));
	
	
	text_bk_record convt_comment(dnorm2 l) := transform
		self.tmsid := l.tmsid;
		self.docref.src := (unsigned6)l.tmsid[1..3];
		self.docref.doc := 0;
		self.segs := dataset([
		{31,0,l.description}
		], Text_Search.Layout_Segment);
	end;
	
	dchild2 := project(dnorm2(description <> ''),convt_comment(left));
	
	text_bk_record convt_part(joinedForLatest l) := transform
		self.tmsid := l.tmsid;
		self.docref.src := (unsigned6)l.tmsid[1..3];
		self.docref.doc := 0;
		self.segs := dataset([
		{1,0,if(l.name_type[1] = 'D',l.orig_name + ';' + l.orig_company,'')},
		{2,0,l.ssn + ';' + l.app_ssn},
		{3,0,l.tax_id + ';' + l.app_tax_id},
		{5,0,if(l.name_type[1] = 'D',l.orig_addr1 + ' ' + l.orig_addr2 + ' ' + l.orig_city + ' ' + l.orig_st
					+ ' ' + l.orig_zip5 + '-' + l.orig_zip4,'')},
		{10,0,if(l.name_type[1] = 'D',l.phone,'')},
		{32,0,if(l.name_type[1] = 'A',';' + l.orig_name + ';' + l.orig_company,'')},
		{33,0,if(l.name_type[1] = 'A',';' + l.phone,'')},
		{34,0,if(l.name_type[1] = 'A',';' + l.orig_addr1 + ';' + l.orig_addr2 + ' ' + l.orig_city + ' ' + l.orig_st
					+ ' ' + l.orig_zip5 + '-' + l.orig_zip4 ,'')},
		//{35,0,if(l.name_type[1] = 'A',l.orig_addr1 + ';' + l.orig_city,'')},
		//{36,0,if(l.name_type[1] = 'A',l.orig_addr1 + ';' + l.orig_st,'')},
		//{37,0,if(l.name_type[1] = 'A',l.orig_addr1 + ';' + l.orig_zip5 + '-' + l.orig_zip4,'')},
		{38,0,if(l.name_type[1] = 'T',';' + l.orig_name + ';' + l.orig_company,'')},
		{39,0,if(l.name_type[1] = 'T',';' + l.phone,'')},
		{40,0,if(l.name_type[1] = 'T',';' + l.orig_addr1 + ';' + l.orig_addr2 + ' ' + l.orig_city + ' ' + l.orig_st
					+ ' ' + l.orig_zip5 + '-' + l.orig_zip4,'')},
		{249,0,l.process_date}
		//{41,0,if(l.name_type[1] = 'T',l.orig_addr1 + ';' + l.orig_city,'')},
		//{42,0,if(l.name_type[1] = 'T',l.orig_addr1 + ';' + l.orig_st,'')},
		//{43,0,if(l.name_type[1] = 'T',l.orig_addr1 + ';' + l.orig_zip5 + '-' + l.orig_zip4,'')}
		],text_search.Layout_Segment);
	end;
	
	party_proj := project(joinedForLatest,convt_part(left));
	
	dist_full := distribute(main_proj + party_proj + dchild1 + dchild2,hash(tmsid));
	
	//flatten the segs field
	
	text_bk_Flat flatten_bk(text_bk_record l, text_search.layout_segment r) := transform
		self.docref := l.docref;
		self.tmsid := l.tmsid;
		self := r;
	end;
	
	norm_full := normalize(dist_full,left.segs,flatten_bk(left,right));
	
	sort_full := sort(norm_full,tmsid,segment,record,local);
	
	text_bk_flat iterate_bk(text_bk_flat l,text_bk_flat r) := transform
		self.docref.doc := if(l.tmsid = r.tmsid,l.docref.doc,
								if(l.docref.doc = 0,thorlib.node() +1,l.docref.doc + thorlib.nodes()+1));
		self.docref.src := r.docref.src;
		self.sect := if(l.tmsid <> r.tmsid or l.segment <> r.segment,0,l.sect+1);
		self := r;
	end;
	
	itr_full := iterate(sort_full,iterate_bk(left,right),local);
	
	// External key
	
	text_bk_Flat MakeKeySegs( itr_full l, unsigned2 segno ) := TRANSFORM
		self.tmsid := l.tmsid;
        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := l.tmsid;
        self.sect := 1;
    END;

    segkeys := PROJECT(itr_full,MakeKeySegs(LEFT,250));

	full_ret := segkeys + itr_full;
	
	return full_ret;
	
	
end;