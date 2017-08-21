
Layouts_Polk.Layout_common csv2fixed(Files_raw.Polk.File_in_raw l) := transform
  self.doc_instrument_or_clerk_filing_num := trim(l.doc_instrument_or_clerk_filing_num);
  self.book_type_cd                       := trim(l.book_type_cd);
  self.book_num                           := trim(l.book_num);
  self.page_num                           := trim(l.page_num);
  self.doc_type_cd                        := trim(l.doc_type_cd);
  self.doc_filed_dt                       := trim(l.doc_filed_dt);
  self.entity_1_type_cd                   := trim(l.entity_1_type_cd);
  self.entity_1_nm                        := trim(l.entity_1_nm);
  self.legal_desc_1                       := trim(l.legal_desc_1);
  self.correction_flag                    := trim(l.correction_flag);

  end;
  
export File_In_FL_Polk := project(Files_raw.Polk.File_in_raw,csv2fixed(LEFT));

