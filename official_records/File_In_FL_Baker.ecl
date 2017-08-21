

Layouts_Baker.document.fixed tr_fdocument(Files_raw.Baker.File_In_raw_document l) := transform
  self.InstrumentNumber := trim(l.InstrumentNumber);
  self.field14 := '';
  self.PageSuffix := '';
  self := l;
end;
  
File_fixed_doc := project(Files_raw.Baker.File_In_raw_document,tr_fdocument(LEFT));
  

Layouts_Baker.prior.fixed tr_bakerpr(Files_raw.Baker.File_In_raw_prior l) := transform
	self.InstrumentNumber := trim(l.InstrumentNumber);
  self.lf := '';
  self.PriorUnmappedDocType := regexreplace( '\r',l.PriorUnmappedDocType,  '');
  self := l;
 end;
  
File_fixed_prior := project(Files_raw.Baker.File_In_raw_prior,tr_bakerpr(LEFT));
  

Layouts_Baker.party.fixed tr_bparty(Files_raw.Baker.File_In_raw_party l) := transform
 self.InstrumentNumber := trim(l.InstrumentNumber);
 self.field6 := '';
  self := l;
end;
  
Fixed_Party_File := project(Files_raw.Baker.File_In_raw_party,tr_bparty(LEFT));
  
File_dis_doc := distribute(File_fixed_doc,HASH(InstrumentNumber));
File_dis_prior := distribute(File_fixed_prior,HASH(InstrumentNumber));
File_dis_party := distribute(Fixed_Party_File,HASH(InstrumentNumber));

Layouts_Baker.layout_common tr_join(File_dis_doc l,File_dis_prior r) := transform
	self.RecordFormatType_Class_UpdateAction := l.RecordFormatType_Class_UpdateAction;
  self.CountyNumber                        := l.CountyNumber;
  self.InstrumentNumber                    := l.InstrumentNumber;
  self.UnmappedDocType                     := l.UnmappedDocType;
  self.DocTypeDescription                  := l.DocTypeDescription;
  self.LegalDescription                    := l.LegalDescription;
  self.BookType                            := l.BookType;
  self.Book                                := l.Book;
  self.Page                                := l.Page;
  self.PageSuffix                          := l.PageSuffix;
  self.NumberPages                         := l.NumberPages;
  self.FileDate                            := l.FileDate;
  self.FileTime                            := l.FileTime;
  self.CountyInfo                          := l.CountyInfo;
  self.PriorInstrumentNumber               := r.PriorInstrumentNumber;
  self.PriorBook                           := r.PriorBook;
  self.PriorPage                           := r.PriorPage;
  self.PriorBookType                       := r.PriorBookType;
  self.PriorUnmappedDocType                := r.PriorUnmappedDocType;
  self.EntitySequence                      := '';
  self.EntityTypeCode                      := '';
  self.EntityNm                            := '';
  self                                     := l;
end;

join_doc_prior := join( File_dis_doc,
                        File_dis_prior,
												LEFT.InstrumentNumber=RIGHT.InstrumentNumber,
												tr_join(LEFT,RIGHT),
												LEFT OUTER,
												local);

Layouts_Baker.layout_common tr_join_final(join_doc_prior l,File_dis_party r) := transform
	self.EntitySequence := r.EntitySequence;
  self.EntityTypeCode := r.EntityTypeCode;
  self.EntityNm := r.EntityNm;
  self := l;
end;
  
 export  File_In_FL_Baker := join(join_doc_prior,
                                  File_dis_party,
																	LEFT.InstrumentNumber=RIGHT.InstrumentNumber,
																	tr_join_final(LEFT,RIGHT),
																	LEFT OUTER,
																	local);
  


