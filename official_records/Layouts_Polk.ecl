EXPORT Layouts_Polk := module

export raw := record
  string doc_instrument_or_clerk_filing_num;
  string book_type_cd;
  string book_num;
  string page_num;
  string doc_type_cd;
  string doc_filed_dt;
  string entity_1_type_cd;
  string entity_1_nm;
  string legal_desc_1;
  string correction_flag;
  string lf;
end;


export Layout_common:=  record
  string25 doc_instrument_or_clerk_filing_num;
  string5 book_type_cd;
  string10 book_num;
  string10 page_num;
  string10 doc_type_cd;
  string10 doc_filed_dt;
  string15 entity_1_type_cd;
  string80 entity_1_nm;
  string60 legal_desc_1;
  string1 correction_flag;
end;

end;