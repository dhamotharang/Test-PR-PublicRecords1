EXPORT Layouts_Charlotte := module

export document := module

export raw := record
  string FACC_required;
  string Fips;
  string CFN;
  string DocType;
  string DocTypeDescription;
  string LegalDescription;
  string BookType;
  string Book;
  string Page;
  string Filler;
  string PageCount;
  string RecDate;
  string RecTime;
  string Consideration;
  string lf;
end;

export fixed := record
   string3 RecordFormatType_Class_UpdateAction;
   string2 CountyNumber;
   string13 InstrumentNumber;
   string4 UnmappedDocType;
   string60 DocTypeDescription;
   string83 LegalDescription;
   string3 BookType;
   string4 Book;
   string4 Page;
   string4 NumberPages;
   string10 FileDate;
   string6 FileTime;
   string11 CountyInfo;
   string1 lf;
end;

end;

export prior := module

export raw := record
  string CFN;
  string Book;
  string Page;
  string BookType;
  string DocType;
  string LinkedCFN;
  string LinkedBook;
  string LinkedPage;
  string LinkedBookType;
  string LinkedDocType;
end; 

export fixed := record
   string13 InstrumentNumber;
   string4 Book;
   string4 Page;
   string2 BookType;
   string3 UnmappedDocType;
   string25 PriorInstrumentNumber;
   string4 PriorBook;
   string4 PriorPage;
   string2 PriorBookType;
   string22 PriorUnmappedDocType;
   string1 lf;
end;

end;
 
export party := module

export raw := 
record
  string FACC_required;
  string FIPS;
  string CFN;
  string Sequence;
  string TypeCode;
  string EntityNm;
  string lf;
end;

export fixed := record
   string3 RecordFormatType_Class_UpdateAction;
   string2 CountyNumber;
   string13 InstrumentNumber;
   string5 EntitySequence;
   string3 EntityTypeCode;
   string80 EntityNm;
   string1 lf;
end;

end;

export Layout_all := record
  string3 RecordFormatType_Class_UpdateAction;
  string6 CountyNumber;
  string13 InstrumentNumber;
  string5 UnmappedDocType;
  string60 DocTypeDescription;
  string128 LegalDescription;
  string25 BookType;
  string4 Book;
  string4 Page;
  string4 NumberPages;
  string10 FileDate;
  string10 FileTime;
  string11 CountyInfo;
  string25 PriorInstrumentNumber;
  string4 PriorBook;
  string4 PriorPage;
  string2 PriorBookType;
  string22 PriorUnmappedDocType;
  string5 EntitySequence;
  string3 EntityTypeCode;
  string80 EntityNm;
end;

end;

