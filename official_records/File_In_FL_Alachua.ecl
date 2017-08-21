//Lines 1-16 Alachua county document preprocessing


Layouts_Alachua.document.fixed Convert2fixeddoc(Files_raw.Alachua.File_In_raw_document l) := transform
self.process_date := '';
self.lf1 := '';
self.Instrument_Num := trim(l.Instrument_Num);
self.Instrument_Type := trim(l.Instrument_Type);
self.Legal_Description := trim(l.Legal_Description);
self.Book := trim(l.Book);
self.Page := trim(l.Page);
self.Date_or_Time_Rec := trim(l.Date_or_Time_Rec);
end;

Fixed_Index_File := project(Files_raw.Alachua.File_In_raw_document,Convert2fixeddoc(LEFT));

//Lines 20-35 Alachua county party preprocessing




Layouts_Alachua.party.fixed Convert2fixedpty(Files_raw.Alachua.File_In_raw_party l) := transform
self.process_date := '';
self.lf2 := '';
self.Instrument_Num := trim(l.Instrument_Num);
self.Last_Name := trim(l.Last_Name);
self.First_Name := trim(l.First_Name);
self.Relator := trim(l.Relator);
self.Name_Type := trim(l.Name_Type);
self.Sequence_Num := trim(l.Sequence_Num);
end;

Fixed_Party_File := project(Files_raw.Alachua.File_In_raw_party,Convert2fixedpty(LEFT));
//Lines 38-51 Alachua combined party and document into one file for later prepping  into official records fl alachua party and document files

dist_Index_File := distribute(Fixed_Index_File,HASH(Instrument_Num));
dist_Party_File := distribute(Fixed_Party_File,HASH(Instrument_Num));



Layouts_Alachua.premap toappend(dist_Index_File l,dist_Party_File r) := transform
self.Instrument_Num := l.Instrument_Num;
self := l;
self := r;
end;



export File_In_FL_Alachua := Join(dist_Index_File,dist_Party_File,LEFT.Instrument_Num =RIGHT.Instrument_Num,toappend(LEFT,RIGHT),local);




