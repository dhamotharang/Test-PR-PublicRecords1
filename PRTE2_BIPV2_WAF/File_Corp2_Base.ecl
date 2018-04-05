import PRTE2_Corp, mdr;
#option('skipFileFormatCrcCheck', 1);

Corp_base := PRTE2_Corp.files.corp2_corp_Base(trim(corp_legal_name) <> '' and trim(corp_key) <> '' and ultid <> 0);
Cont_base := PRTE2_Corp.files.corp2_cont_Base(trim(corp_key) <> '');


slim_Cont_layout := record
	PRTE2_Corp.Layouts.Cont_Base_Layout.corp_key;
	PRTE2_Corp.Layouts.Cont_Base_Layout.cont_fname;
	PRTE2_Corp.Layouts.Cont_Base_Layout.cont_mname;
	PRTE2_Corp.Layouts.Cont_Base_Layout.cont_lname;
end;

slim_cont_base := project(Cont_base, transform(slim_Cont_layout,self := left));

slim_cont_base_ded := dedup(sort(distributed(slim_cont_base, hash(corp_key)),record,local),record,local);

Corp_base_dis := distribute(Corp_base, hash(corp_key));

Layout_Corp_w_contact_names := record
		Corp_base;
		slim_Cont_layout - corp_key;
		string2 source := '';
end;

Corp_w_conts_base := join(Corp_base_dis, slim_cont_base_ded,
													left.corp_key = right.corp_key,													
													transform(Layout_Corp_w_contact_names,																		
																		self.cont_fname := right.cont_fname,
																		self.cont_lname := right.cont_lname,
																		self.cont_mname := right.cont_mname,
																		self.source			:= mdr.sourceTools.fCorpV2(left.corp_key, left.corp_state_origin),
																		self 						:= left), left outer, local);

EXPORT File_Corp2_Base := Corp_w_conts_base:persist('~prte::persist::PRTE2_BIPV2_WAF::File_Corp2_Base');