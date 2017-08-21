import ucc;


df := ucc.file_ucc_filing_summary;

rec := uccd.Layout_WithExpFilingSummary;

rec into_withExp1(df L) := transform
	self.isDirect := false;
	//self.record_type := 'C';
	self.ucc_vendor := '';
	self.ucc_process_date := '';
	self.processing_rule := '';
	self.ucc_key := uccd.constructUCCkey(l.file_state, l.orig_filing_num);
	self.ucc_filing_type_cd := '';
	self.ucc_filing_type_desc := '';
	self.ucc_exp_date := '';
	self.ucc_term_date := '';
	self.ucc_life := '';
	self.ucc_life_units_desc := '';
	self.ucc_status_desc := '';
	self := L;
end;

o1 := project(df(file_state not in uccd.set_DirectStates),into_withExp1(LEFT));

df2 := uccd.Summary;

rec into_withExp2(df2 L) := transform
	self.isDirect := true;
	//self.record_type := L.record_type;	
	self.file_state := L.ucc_state_origin;
	self.orig_filing_num := L.ucc_filing_num;
	self.filing_count := L.filing_count;
	self.document_count := L.document_count;
	self.debtor_count := L.debtor_count;
	self.secured_count := L.secured_count;
	self := L;
end;

o2 := project(df2,into_withExp2(LEFT));

export WithExpFilingSummary := o1 + o2;