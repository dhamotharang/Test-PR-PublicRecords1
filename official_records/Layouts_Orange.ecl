EXPORT Layouts_Orange := module

export raw := record
  string document_number ;
  string recording_date ;
  string page ;
  string document_type;
  string bookpage;
  string blank;
   string grantor;
  string grantee;
  string blank2;
  string legal_1;
  string consideration;
  string deeddoctax;
  string mortgageamt;
  string mortgagedoctax;
  string intangibletax;
  string case_number;
  string related_doc_number;
end;

export rmblank := record
  string document_number ;
  string recording_date ;
  string page ;
  string document_type;
  string bookpage;
   string grantor;
  string grantee;
  string legal_1;
  string consideration;
  string deeddoctax;
  string mortgageamt;
  string mortgagedoctax;
  string intangibletax;
  string case_number;
  string related_doc_number;
end;

export Layout_common := record
  string process_date;
  string book;
  string page;
  string instrument_or_clerk_file_no;
  string recording_date;
  string document_type;
  string party_name;
  string party_code;
  string legal_1;
  string court_case_number;
  string consideration;
  string deeddoctax;
  string mortgageamt;
  string mortgagedoctax;
  string intangibletax;

  string lf;
end;

end;