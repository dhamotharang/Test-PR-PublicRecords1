import lib_stringlib;

ds_doc := distribute(Files_raw.Hillsborough.File_in_raw_document( Instrument_Number <> '' ),HASH32(Instrument_Number,County_Number));

ds_party := distribute(Files_raw.Hillsborough.File_in_raw_party( Instrument_Number <> '' ),HASH32(Instrument_Number,County_Number));

Layouts_Hillsborough.layout_common Mapdoc2pty(ds_doc l,ds_party r) := transform
	self.Party_Code             := r.Party_Type;
  self.Legal_Description_1    := l.Legal_Description_1[1..60];
  self.Entity_Sequence        := '';
  self.Legal_Description_2    := '';
  self.Cross_Reference_Name   := '';
  self.Correction_Flag        := '';
  self.Party_Name             := r.Party_Name[1..60];
  self.Record_Date            := l.Record_Date;
  self.Instrument_Number      := l.Instrument_Number;
  self.Book_Type              := l.Book_Type;
  self.Book_Number            := l.Book_Number;
  self.Page_Number            := l.Page_Number;
  self.Document_Page_Count    := l.Document_Page_Count;
  self.Document_Description   := l.Document_Description;
  end;
  
export File_In_FL_Hillsborough := join(ds_doc,
                                       ds_party,
																			 LEFT.Instrument_Number=RIGHT.Instrument_Number AND 
																			 LEFT.County_Number=RIGHT.County_Number,
																			 Mapdoc2pty(LEFT,RIGHT),local);
  

