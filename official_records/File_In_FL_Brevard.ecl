import lib_stringlib;

File_In_document_valid := dedup(sort(Files_raw.Brevard.File_In_raw_document,record),all);



Layouts_Brevard.document.fixed tr_fdocument(File_In_document_valid l) := transform
  self.InstrumentNumber                    := trim(l.CFN);
  self.RecordFormatType_Class_UpdateAction := if(lib_StringLib.StringLib.StringFind(l.FACC_required, ':',1) = 0 , l.FACC_required ,
	                                                                                                                l.FACC_required[lib_StringLib.StringLib.StringFind(l.FACC_required, ':',1)+1..10]);
  self.CountyNumber                         := l.Fips;
  self.UnmappedDocType                      := l.DocType[1..5];
  self.NumberPages                          := l.PageCount;
  self.FileDate                             := l.RecDate;
  self.FileTime                             := l.RecTime;
  self.CountyInfo                           := l.Consideration;
  self.LegalDescription                     := l.LegalDescription[1..60];
  self := l;
end;
  
File_In_document_fixed := project(File_In_document_valid,tr_fdocument(LEFT));
  
File_In_prior := dedup(sort(Files_raw.Brevard.File_In_raw_prior,record),all);

Layouts_Brevard.prior.fixed tr_brevardpr(File_In_prior l) := transform
	self.InstrumentNumber        := if(lib_StringLib.StringLib.StringFind(l.CFN, ':',1) = 0 , l.CFN ,
	                                                                                   l.CFN[lib_StringLib.StringLib.StringFind(l.CFN, ':',1)+1..10]);
  self.lf                      := '';
  self.UnmappedDocType         := l.DocType;
  self.PriorInstrumentNumber   := l.LinkedCFN;
  self.PriorBook               := l.LinkedBook;
  self.PriorPage               := l.LinkedPage;
  self.PriorBookType           := l.LinkedBookType;
  self.PriorUnmappedDocType    := l.LinkedDocType;
  self                         := l;
  end;
  
File_fixed_prior := project(File_In_prior( LinkedCFN <> ''),tr_brevardpr(LEFT));
  
File_In_party_valid := dedup(sort(Files_raw.Brevard.File_In_raw_party,record),all);

Layouts_Brevard.party.fixed tr_brevparty(File_In_party_valid l) := transform
  self.InstrumentNumber                    := trim(l.CFN);
  self.RecordFormatType_Class_UpdateAction := if(lib_StringLib.StringLib.StringFind(l.FACC_required, ':',1) = 0 , l.FACC_required ,
	                                                                                                                l.FACC_required[lib_StringLib.StringLib.StringFind(l.FACC_required, ':',1)+1..10]);
  self.CountyNumber                        := l.FIPS;
  self.EntitySequence                      := l.Sequence;
  self.EntityTypeCode                      := l.TypeCode;
  self.EntityNm                            := trim(l.EntityNm)[1..80];
  self := l;
  end;
  
Fixed_Party_File := project(File_In_party_valid,tr_brevparty(LEFT));
  
Layouts_Brevard.layout_common tr_join(File_In_document_fixed l,File_fixed_prior r) := transform
	self.RecordFormatType_Class_UpdateAction           := l.RecordFormatType_Class_UpdateAction;
  self.CountyNumber                                  := l.CountyNumber;
  self.InstrumentNumber                              := l.InstrumentNumber;
  self.UnmappedDocType                               := l.UnmappedDocType;
  self.DocTypeDescription                            := l.DocTypeDescription;
  self.LegalDescription                              := l.LegalDescription;
  self.BookType                                      := l.BookType;
  self.Book                                          := l.Book;
  self.Page                                          := l.Page;
  self.NumberPages                                   := l.NumberPages;
  self.FileDate                                      := l.FileDate;
  self.FileTime                                      := l.FileTime;
  self.CountyInfo                                    := l.CountyInfo;
  self.PriorInstrumentNumber                         := r.PriorInstrumentNumber;
  self.PriorBook                                     := r.PriorBook;
  self.PriorPage                                     := r.PriorPage;
  self.PriorBookType                                 := r.PriorBookType;
  self.PriorUnmappedDocType                          := r.PriorUnmappedDocType;
  self.EntitySequence                                := '';
  self.EntityTypeCode                                := '';
  self.EntityNm                                      := '';
  self                                               := l;
end;

join_doc_prior := join(distribute(File_In_document_fixed,hash(InstrumentNumber)),
                       distribute(File_fixed_prior,hash(InstrumentNumber)),
											 LEFT.InstrumentNumber=RIGHT.InstrumentNumber,
											 tr_join(LEFT,RIGHT),
											 LEFT OUTER,
											 local);

Layouts_Brevard.layout_common tr_join_final(join_doc_prior l,Fixed_Party_File r) := transform
self.EntitySequence               := r.EntitySequence;
  self.EntityTypeCode             := r.EntityTypeCode;
  self.EntityNm                   := r.EntityNm;
  self                            := l;
  end;
  
export File_In_FL_Brevard := join(join_doc_prior,
                                  distribute(Fixed_Party_File,hash(InstrumentNumber)),
																	LEFT.InstrumentNumber=RIGHT.InstrumentNumber,
																	tr_join_final(LEFT,RIGHT),
																	local);
  
 



