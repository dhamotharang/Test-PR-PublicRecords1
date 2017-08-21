EXPORT Layouts_Lake := module

export document := module


export raw := 
record
  string DOC_FILE_NUMBER;
  string DOC_BOOK;
  string DOC_PAGE;
  string DOC_TYPE;
  string NUMBER_OF_PAGES;
  string RECORD_DATE;
  string RECORD_TIME;
  string RECEIVED_FROM_NAME;
  string ADDRESS_1;
  string ADDRESS_2;
  string CITY;
  string STATE;
  string ZIP;
  string DEED_DOC_TAX;
  string INTANGIBLE_TAX;
  string DOC_STAMP_TAX;
  string CONSIDERATION;
  string PARTY_LEGAL_1;
  string PARTY_LEGAL_2;
end;

export fixed := 
record
   string8 process_date;
   string15 DOC_FILE_NUMBER;
   string5 DOC_BOOK;
   string5 DOC_PAGE;
   string10 DOC_TYPE;
   string5 NUMBER_OF_PAGES;
   string12 RECORD_DATE;
   string10 RECORD_TIME;
   string60 RECEIVED_FROM_NAME;
   string60 ADDRESS_1;
   string60 ADDRESS_2;
   string35 CITY;
   string18 STATE;
   string15 ZIP;
   string16 DEED_DOC_TAX;
   string16 INTANGIBLE_TAX;
   string16 DOC_STAMP_TAX;
   string20 CONSIDERATION;
   string75 PARTY_LEGAL_1;
   string65 PARTY_LEGAL_2;
   string1 lf;
end;

end;

export party := module

export raw := record
  string DOC_FILE_NUMBER;
  string DOC_BOOK;
  string DOC_PAGE;
  string PARTY_CODE;
  string PARTY_NAME;
  string Filler;
end;

export fixed := record
   string8 process_date;
   string15 DOC_FILE_NUMBER;
   string5 DOC_BOOK;
   string5 DOC_PAGE;
   string3 PARTY_CODE;
   string70 PARTY_NAME;
   string3 CORRECTION_FLAG;
   string1 lf;
end;
end;

export Layout_common := record
  string15 DOC_FILE_NUMBER;
  string5 DOC_BOOK;
  string5 DOC_PAGE;
  string10 DOC_TYPE;
  string5 NUMBER_OF_PAGES;
  string12 RECORD_DATE;
  string10 RECORD_TIME;
  string60 RECEIVED_FROM_NAME;
  string60 ADDRESS_1;
  string60 ADDRESS_2;
  string35 CITY;
  string18 STATE;
  string15 ZIP;
  string16 DEED_DOC_TAX;
  string16 INTANGIBLE_TAX;
  string16 DOC_STAMP_TAX;
  string20 CONSIDERATION;
  string75 PARTY_LEGAL_1;
  string65 PARTY_LEGAL_2;
  string3 PARTY_CODE;
  string70 PARTY_NAME;
  string3 CORRECTION_FLAG;
end;

export relative_document := module

export raw := record
  string DOC_FILE_NUMBER;
  string DOC_BOOK;
  string DOC_PAGE;
  string RELATED_DOC_FILE_NO;
  string RELATED_DOC_BOOK;
  string RELATED_DOC_PAGE;
  string RELATED_DOC_TYPE;
end;

export fixed := record
   string8 process_date;
   string15 DOC_FILE_NUMBER;
   string5 DOC_BOOK;
   string5 DOC_PAGE;
   string15 RELATED_DOC_FILE_NO;
   string5 RELATED_DOC_BOOK;
   string5 RELATED_DOC_PAGE;
   string5 RELATED_DOC_TYPE;
   string1 lf;
end;
end;
export Layout_final := record
  string15 DOC_FILE_NUMBER;
  string5 DOC_BOOK;
  string5 DOC_PAGE;
  string10 DOC_TYPE;
  string5 NUMBER_OF_PAGES;
  string12 RECORD_DATE;
  string10 RECORD_TIME;
  string60 RECEIVED_FROM_NAME;
  string60 ADDRESS_1;
  string60 ADDRESS_2;
  string35 CITY;
  string18 STATE;
  string15 ZIP;
  string16 DEED_DOC_TAX;
  string16 INTANGIBLE_TAX;
  string16 DOC_STAMP_TAX;
  string20 CONSIDERATION;
  string75 PARTY_LEGAL_1;
  string65 PARTY_LEGAL_2;
  string3 PARTY_CODE;
  string70 PARTY_NAME;
  string3 CORRECTION_FLAG;
  string15 RELATED_DOC_FILE_NO;
  string5 RELATED_DOC_BOOK;
  string5 RELATED_DOC_PAGE;
  string5 RELATED_DOC_TYPE;
end;
end;