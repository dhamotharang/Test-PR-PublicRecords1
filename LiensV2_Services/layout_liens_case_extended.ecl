IMPORT liensv2, BatchShare;

EXPORT layout_liens_case_extended := RECORD
  STRING8 filing_date;
  liensv2.Layout_liens_main_module .layout_liens_main.filing_number;
  STRING20 filing_type_desc;
  liensv2_services.layout_lien_case;
  TYPEOF(BatchShare.Layouts.ShareAcct.acctno) acctno := '';
  STRING agency_state :=''; // bug 34534 -- needed for additional jurisdictional filtering
  BOOLEAN bcbflag := FALSE;
  STRING case_link_id := '';
  UNSIGNED case_link_priority := 0;
END;
