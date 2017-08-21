
Layouts_Charlotte.document.fixed tr_docfixed(Files_raw.Charlotte.File_In_raw_document l) := transform
	self.InstrumentNumber                       := trim(l.CFN);
  self.RecordFormatType_Class_UpdateAction  := l.FACC_required;
  self.CountyNumber                         := l.Fips;
  self.UnmappedDocType                      := l.DocType;
  self.NumberPages                          := l.PageCount;
  self.FileDate                             := l.RecDate;
  self.FileTime                             := l.RecTime;
  self.CountyInfo                           := l.Consideration;
  self                                      := l;
  end;
  
  d_Fix2document := project(Files_raw.Charlotte.File_In_raw_document,tr_docfixed(LEFT));
  
 Layouts_Charlotte.prior.fixed tr_fixprior(Files_raw.Charlotte.File_In_raw_prior l) := transform
	self.InstrumentNumber                     := trim(l.CFN);
  self.lf                                   := '';
  self.UnmappedDocType                      := l.DocType;
  self.PriorInstrumentNumber                := l.LinkedCFN;
  self.PriorBook                            := l.LinkedBook;
  self.PriorPage                            := l.LinkedPage;
  self.PriorBookType                        := l.LinkedBookType;
  self.PriorUnmappedDocType                 := l.LinkedDocType;
  self                                      := l;
  end;
  
  d_Fix2prior := project(Files_raw.Charlotte.File_In_raw_prior  ,tr_fixprior(LEFT));
  
  
Layouts_Charlotte.party.fixed tr_fixparty(Files_raw.Charlotte.File_In_raw_party l):= transform
self.InstrumentNumber                         := trim(l.CFN);
  self.RecordFormatType_Class_UpdateAction    := l.FACC_required;
  self.CountyNumber                           := l.FIPS;
  self.EntitySequence                         := l.Sequence;
  self.EntityTypeCode                         := l.TypeCode;
  self.EntityNm                               := trim(l.EntityNm)[1..80];
  self                                        := l;
end;

d_Fix2party := project(Files_raw.Charlotte.File_In_raw_party,tr_fixparty(LEFT));


Layouts_Charlotte.layout_all tr_join_1(d_Fix2document l,d_Fix2prior r) := transform
  self                := l;
	self                := r;
  self.EntitySequence := '';
  self.EntityTypeCode := '';
  self.EntityNm := '';

end;

jdocprior     :=         join(distribute(d_Fix2document,hash(InstrumentNumber)),
                            distribute(d_Fix2prior,hash(InstrumentNumber)),
														LEFT.InstrumentNumber=RIGHT.InstrumentNumber,
														tr_join_1(LEFT,RIGHT),
														LEFT OUTER,local);

Layouts_Charlotte.layout_all tr_join_2(jdocprior l,d_Fix2party r) := transform
self.EntitySequence      := r.EntitySequence;
  self.EntityTypeCode    := r.EntityTypeCode;
  self.EntityNm          := r.EntityNm;
  self                   := l;
  end;
  
export File_In_FL_Charlotte := join(jdocprior,
                                    distribute(d_Fix2party,hash(InstrumentNumber)),
															      LEFT.InstrumentNumber=RIGHT.InstrumentNumber,
																		tr_join_2(LEFT,RIGHT),
																		LEFT OUTER,local) ( InstrumentNumber <> '' );
  

