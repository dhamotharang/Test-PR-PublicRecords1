EXPORT Layouts_Baker := module

export document := module

  export raw :=  record
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
	
	export fixed := record
  string3 RecordFormatType_Class_UpdateAction;
  string6 CountyNumber;
  string13 InstrumentNumber;
  string5 UnmappedDocType;
  string33 DocTypeDescription;
  string128 LegalDescription;
  string25 BookType;
  string4 Book;
  string4 Page;
  string3 PageSuffix;
  string4 NumberPages;
  string10 FileDate;
  string10 FileTime;
  string12 CountyInfo;
  string4 field14;
  string1 lf;
  end;
	
	end;
	
	export prior := module
	
	export raw := 
	record
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
 
   export fixed := 
	 record
  string13 InstrumentNumber;
  string4 Book;
  string4 Page;
  string2 BookType;
  string3 UnmappedDocType;
  string12 PriorInstrumentNumber;
  string4 PriorBook;
  string4 PriorPage;
  string2 PriorBookType;
  string50 PriorUnmappedDocType;
  string1 lf;
   end;
	 
	 end;
	 
	 export party := module
	 
	  export raw := record
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
  string7 CountyNumber;
  string13 InstrumentNumber;
  string3 EntitySequence;
  string3 EntityTypeCode;
  string100 EntityNm;
  string2 field6;
  string1 lf;
  end;
	
	end;
	
	 export layout_common :=  record
  string3 RecordFormatType_Class_UpdateAction;
  string6 CountyNumber;
  string13 InstrumentNumber;
  string5 UnmappedDocType;
  string33 DocTypeDescription;
  string128 LegalDescription;
  string25 BookType;
  string4 Book;
  string4 Page;
  string3 PageSuffix;
  string4 NumberPages;
  string10 FileDate;
  string10 FileTime;
  string12 CountyInfo;
  string12 PriorInstrumentNumber;
  string4 PriorBook;
  string4 PriorPage;
  string2 PriorBookType;
  string50 PriorUnmappedDocType;
  string3 EntitySequence;
  string3 EntityTypeCode;
  string100 EntityNm;
end;


	
	end;
