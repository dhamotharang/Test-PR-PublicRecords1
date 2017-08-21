EXPORT Layouts_Flagler := module

export document := module

export raw := 
record
  string RecordFormatType_Class_UpdateAction;
  string CountyNumber;
  string InstrumentNumber;
  string UnmappedDocType;
  string DocTypeDescription;
  string LegalDescription;
  string BookType;
  string Book;
  string Page;
  string filler;
  string NumberPages;
  string FileDate;
  string FileTime;
  string CountyInfo;
  string lf;
end;

export fixed := 
 record
   string3 RecordFormatType_Class_UpdateAction;
   string2 CountyNumber;
   string10 InstrumentNumber;
   string5 UnmappedDocType;
   string60 DocTypeDescription;
   string83 LegalDescription;
   string3 BookType;
   string4 Book;
   string4 Page;
   string4 NumberPages;
   string10 FileDate;
   string6 FileTime;
   string30 CountyInfo;
   string1 lf;

end;

end;
export prior := module 

export raw :=record
  string InstrumentNumber;
  string Book;
  string Page;
  string BookType;
  string UnmappedDocType;
  string PriorInstrumentNumber;
  string PriorBook;
  string PriorPage;
  string PriorBookType;
  string PriorUnmappedDocType;
end;

export fixed := record
   
   string10 InstrumentNumber;
   string4 Book;
   string4 Page;
   string2 BookType;
   string3 UnmappedDocType;
   string10 PriorInstrumentNumber;
   string4 PriorBook;
   string4 PriorPage;
   string2 PriorBookType;
   string22 PriorUnmappedDocType;
   string1 lf;
end;

end;

export party := module

export raw :=  record
  string RecordFormatType_Class_UpdateAction;
  string CountyNumber;
  string InstrumentNumber;
  string EntitySequence;
  string EntityTypeCode;
  string EntityNm;
  string lf;
end;

export fixed := record
   string3 RecordFormatType_Class_UpdateAction;
   string2 CountyNumber;
   string10 InstrumentNumber;
   string5 EntitySequence;
   string3 EntityTypeCode;
   string74 EntityNm;
   string1 lf;
end;

end;

export Layout_common := record
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
  string30 CountyInfo;
  string12 PriorInstrumentNumber;
  string4 PriorBook;
  string4 PriorPage;
  string2 PriorBookType;
  string22 PriorUnmappedDocType;
  string5 EntitySequence;
  string3 EntityTypeCode;
  string80 EntityNm;
end;
end;