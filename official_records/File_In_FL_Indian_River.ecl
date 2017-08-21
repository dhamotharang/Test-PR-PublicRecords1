import lib_stringlib;

                              
Layouts_IndianRiver.document.fixed convert2fixeddoc(Files_raw.IndianRiver.File_in_raw_document l) := transform
  self.process_date                 := '';
  self.Legal_Description          := l.Legal_Description_1;               
	self.Update_Record_Type          := trim(l.Update_Record_Type);        
	self.County_Number               := trim(l.County_Number);                  
	self.Instrument_Number           := trim(l.Instrument_Number);          
	self.Unmapped_doctype            := trim(l.Unmapped_doctype);            
	self.Document_Description        := trim(l.Document_Description);    
	self.Book_Type                   := trim(l.Book_Type);  
	self                              := l;
                                                               
end;

dFixeddoc := project(Files_raw.IndianRiver.File_in_raw_document,convert2fixeddoc(LEFT));


Layouts_IndianRiver.party.fixed convert2fixedpty(Files_raw.IndianRiver.File_in_raw_party l) := transform
	 self.process_date            := '';                     
   self.Update_RecordType       := trim(l.Update_RecordType);  
   self.County_Number           := trim(l.County_Number);          
   self.Instrument_Number       := trim(l.Instrument_Number);  
   self.Party_ID                := trim(l.Party_ID);                    
   self.Party_Type              := trim(l.Party_Type);                
   self.Party_Name              := trim(l.Party_Name);                
   self.lf                      := '';    
	 
	 end;
	 
	 dFixedPty := project(Files_raw.IndianRiver.File_in_raw_party,convert2fixedpty(LEFT));
	 
dFixeddoc_dist := distribute(dFixeddoc,HASH(Instrument_Number,County_Number));
dFixedPty_dist := distribute(dFixedPty,HASH(Instrument_Number,County_Number));


Layouts_IndianRiver.Layout_common tJoinIR(dFixeddoc_dist l,dFixedPty_dist r) := transform
	self.Instrument_Number := l.Instrument_Number;
	self.County_Number     := l.County_Number;
	self                   := l;
	self                   := r;
end;



export File_In_FL_Indian_River := Join(dFixeddoc_dist,
                                       dFixedPty_dist,
																			 LEFT.Instrument_Number =RIGHT.Instrument_Number and 
                                       LEFT.County_Number=RIGHT.County_Number,
																			 tJoinIR(LEFT,RIGHT),local);



                                                       