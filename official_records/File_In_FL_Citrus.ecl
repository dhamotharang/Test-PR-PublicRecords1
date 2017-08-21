import lib_stringlib;

Layouts_Citrus.master.fixed tmasterfix(Files_raw.Citrus.File_In_master l) := transform
	self.process_date   := '';
  self.Page_Suffix    := '';
  self.County_Info    := '';
  self                := l;
  end;
  
  File_fixed_master := project(Files_raw.Citrus.File_In_master,tmasterfix(LEFT));
  
  
Layouts_Citrus.party.fixed tpartyfix(Files_raw.Citrus.File_In_raw_party l) := transform
	self.process_date  := '';
  self.Name          :=  trim(lib_stringlib.StringLib.StringFilterout(l.Name,'|\"'));
  self.lf            := '';
  self               := l;
  end;
  
 File_party_fixed := project(Files_raw.Citrus.File_In_raw_party,tpartyfix(LEFT));
  
  
Layouts_Citrus.Layout_all Combine_all(File_fixed_master l,File_party_fixed r) := transform
	self          := l;
	self          := r;
  end;
  
export File_In_FL_Citrus := join(distribute(File_fixed_master,hash(Instrument_Number)),
                                 distribute(File_party_fixed,hash(Instrument_Number)),
																 LEFT.Instrument_Number=RIGHT.Instrument_Number,
																 Combine_all(LEFT,RIGHT),local);
  

