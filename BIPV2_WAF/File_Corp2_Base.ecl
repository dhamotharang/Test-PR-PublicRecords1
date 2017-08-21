import Corp2, mdr;
#option('skipFileFormatCrcCheck', 1);

Corp_base := corp2.files().AID.corp.prod(trim(corp_legal_name) <> '' and trim(corp_key) <> '' and ultid <> 0);
Cont_base := corp2.files().base.cont.prod(trim(corp_key) <> '');


slim_Cont_layout := record
	Corp2.Layout_Corporate_Direct_Cont_Base.corp_key;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_fname;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_mname;
	Corp2.Layout_Corporate_Direct_Cont_Base.cont_lname;
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

EXPORT File_Corp2_Base := Corp_w_conts_base:persist('~thor_data400::persist::BIPV2_WAF::File_Corp2_Base');