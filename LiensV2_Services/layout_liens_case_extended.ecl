IMPORT liensv2, BatchShare;

export layout_liens_case_extended := RECORD
  string8 filing_date;
	liensv2.Layout_liens_main_module .layout_liens_main.filing_number;
	string20 filing_type_desc;
	liensv2_services.layout_lien_case;
	typeof(BatchShare.Layouts.ShareAcct.acctno) acctno := '';
	string agency_state :='';   // bug 34534 -- needed for additional jurisdictional filtering
	Boolean bcbflag := false;
end;
