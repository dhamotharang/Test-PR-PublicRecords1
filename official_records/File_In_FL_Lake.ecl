import lib_stringlib;


Layouts_Lake.document.fixed tr_lakedoc(Files_raw.Lake.File_in_raw_document l) := transform
	self.process_date             := '';
  self.DOC_FILE_NUMBER          := trim(lib_stringlib.stringlib.stringfilterout(l.DOC_FILE_NUMBER,'\"'));
  self.DOC_BOOK                 := trim(lib_stringlib.stringlib.stringfilterout(l.DOC_BOOK,'-'));
  self.DOC_PAGE                 := trim(l.DOC_PAGE);
  self.DOC_TYPE                 := trim(lib_stringlib.stringlib.stringfilterout(l.DOC_TYPE,'\"'));
  self.NUMBER_OF_PAGES          := trim(l.NUMBER_OF_PAGES);
  self.RECORD_DATE              := trim(l.RECORD_DATE);
  self.RECORD_TIME              := trim(lib_stringlib.stringlib.stringfilterout(l.RECORD_TIME,'\"'));
  self.RECEIVED_FROM_NAME       := trim(lib_stringlib.stringlib.stringfilterout(l.RECEIVED_FROM_NAME,'\"'));
  self.ADDRESS_1                := trim(lib_stringlib.stringlib.stringfilterout(regexreplace('  ',l.ADDRESS_1,''),'\"'));
  self.ADDRESS_2                := trim(lib_stringlib.stringlib.stringfilterout(l.ADDRESS_2,'\"'));
  self.CITY                     := trim(lib_stringlib.stringlib.stringfilterout(l.CITY,'\"'));
  self.STATE                    := trim(lib_stringlib.stringlib.stringfilterout(l.STATE,'\"'));
  self.ZIP                      := trim(lib_stringlib.stringlib.stringfilterout(l.ZIP,'\"'));
  self.DEED_DOC_TAX             := trim(l.DEED_DOC_TAX);
  self.INTANGIBLE_TAX           := trim(l.INTANGIBLE_TAX);
  self.DOC_STAMP_TAX            := trim(l.DOC_STAMP_TAX);
  self.CONSIDERATION            := trim(lib_stringlib.stringlib.stringfilterout(trim(l.CONSIDERATION),'$'));
  self.PARTY_LEGAL_1            := trim(lib_stringlib.stringlib.stringfilterout(l.PARTY_LEGAL_1,'\"'));
  self.PARTY_LEGAL_2            := trim(lib_stringlib.stringlib.stringfilterout(l.PARTY_LEGAL_2,'\"'));
  self.lf                       := '';
end;

dWithFixed := project(Files_raw.Lake.File_in_raw_document,tr_lakedoc(LEFT));

dUniquedoc := dedup(sort(dWithFixed,record),all);

dUniquedoc_dist := distribute(dUniquedoc,HASH32(DOC_FILE_NUMBER,DOC_BOOK,DOC_PAGE));


Layouts_Lake.party.fixed tr_ptyfix(Files_raw.Lake.File_in_raw_party l) := transform
	self.process_date               := '';
  self.CORRECTION_FLAG            := '';
  self.lf                         := '';
  self.DOC_FILE_NUMBER            := trim(lib_stringlib.StringLib.stringfilterout(l.DOC_FILE_NUMBER,'\"'));
  self.DOC_BOOK                   := trim(lib_stringlib.StringLib.stringfilterout(l.DOC_BOOK,'-'));
  self.DOC_PAGE                   := trim(l.DOC_PAGE);
  self.PARTY_CODE                 := trim(lib_stringlib.StringLib.stringfilterout(l.PARTY_CODE,'\"'));
  self.PARTY_NAME                 := trim(lib_stringlib.StringLib.stringfilterout(l.PARTY_NAME,'\"'))[1..70];
end;

pWithFixed := project(Files_raw.Lake.File_in_raw_party,tr_ptyfix(LEFT));

dUniquepty := dedup(sort(pWithFixed,record),all);
dUniquepty_dist := distribute(dUniquepty,HASH32(DOC_FILE_NUMBER,DOC_BOOK,DOC_PAGE));


Layouts_Lake.Layout_common tjoin(dUniquedoc_dist l,dUniquepty_dist r) := transform
  self.DOC_FILE_NUMBER               := l.DOC_FILE_NUMBER;
  self.DOC_BOOK                    := l.DOC_BOOK;
  self.DOC_PAGE                    := l.DOC_PAGE;
  self.DOC_TYPE                    := l.DOC_TYPE;
  self.NUMBER_OF_PAGES             := l.NUMBER_OF_PAGES;
  self.RECORD_DATE                 := l.RECORD_DATE;
  self.RECORD_TIME                 := l.RECORD_TIME;
  self.RECEIVED_FROM_NAME          := l.RECEIVED_FROM_NAME;
  self.ADDRESS_1                   := trim(l.ADDRESS_1,left,right);
  self.ADDRESS_2                   := trim(l.ADDRESS_2,left,right);
  self.CITY                        := l.CITY;
  self.STATE                       := l.STATE;
  self.ZIP                         := l.ZIP;
  self.DEED_DOC_TAX                := l.DEED_DOC_TAX;
  self.INTANGIBLE_TAX              := l.INTANGIBLE_TAX;
  self.DOC_STAMP_TAX               := l.DOC_STAMP_TAX;
  self.CONSIDERATION               := l.CONSIDERATION;
  self.PARTY_LEGAL_1               := l.PARTY_LEGAL_1;
  self.PARTY_LEGAL_2               := l.PARTY_LEGAL_2;
  self.PARTY_CODE                  := r.PARTY_CODE;
  self.PARTY_NAME                  := r.PARTY_NAME;
  self.CORRECTION_FLAG             := r.CORRECTION_FLAG;
end;

dpcmbd := join(dUniquedoc_dist,
                    dUniquepty_dist,
										LEFT.DOC_FILE_NUMBER=RIGHT.DOC_FILE_NUMBER AND 
										LEFT.DOC_BOOK=RIGHT.DOC_BOOK AND LEFT.DOC_PAGE=RIGHT.DOC_PAGE,
										tjoin(LEFT,RIGHT),local);


Layouts_Lake.relative_document.fixed relfixed(Files_raw.Lake.File_in_relative_doc l) := transform
  self.process_date           := '';
  self.lf                     := '';
  self.DOC_FILE_NUMBER        := trim(lib_stringlib.StringLib.stringfilterout(l.DOC_FILE_NUMBER,'\"'));
  self.DOC_BOOK               := trim(l.DOC_BOOK);
  self.DOC_PAGE               :=  trim(l.DOC_PAGE);
  self.RELATED_DOC_FILE_NO    := trim(lib_stringlib.StringLib.stringfilterout(l.RELATED_DOC_FILE_NO,'\"'));
  self.RELATED_DOC_BOOK       :=  trim(l.RELATED_DOC_BOOK);
  self.RELATED_DOC_PAGE       :=  trim(l.RELATED_DOC_PAGE);
  self.RELATED_DOC_TYPE       := trim(lib_stringlib.StringLib.stringfilterout(l.RELATED_DOC_TYPE,'\"\r'));
end;

dRelFixed := project(Files_raw.Lake.File_in_relative_doc,relfixed(LEFT));


dRelUnique := dedup(sort(dRelFixed,record),all);
dRelUnique_dist := distribute(dRelUnique,HASH32(DOC_FILE_NUMBER,DOC_BOOK,DOC_PAGE));



Layouts_Lake.layout_final finaljoin(dpcmbd l,dRelUnique_dist r) := transform
 self      := l;
 self      := r;
end;
  
export File_In_FL_Lake  := join(dpcmbd,
                                 dRelUnique_dist,
																 LEFT.DOC_FILE_NUMBER=RIGHT.DOC_FILE_NUMBER AND 
																 LEFT.DOC_BOOK=RIGHT.DOC_BOOK AND 
																 LEFT.DOC_PAGE=RIGHT.DOC_PAGE,
																 finaljoin(LEFT,RIGHT),LEFT OUTER,local);



