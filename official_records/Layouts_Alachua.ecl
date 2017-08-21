EXPORT Layouts_Alachua := module

 export document := module

  export raw := record
  string Instrument_Num;
  string Instrument_Type;
  string Legal_Description;
  string Book;
  string Page;
  string Date_or_Time_Rec;
  end;
	
	export fixed :=  record
   string8 process_date;
   string10 Instrument_Num;
   string12 Instrument_Type;
   string180 Legal_Description;
   string10 Book;
   string10 Page;
   string25 Date_or_Time_Rec;
   string1 lf1;
	 end;

  end;
	
	export party := module
	
	 export raw := record
  string Instrument_Num;
  string Last_Name;
  string First_Name;
  string Relator;
  string Name_Type;
  string Sequence_Num;
   end;
	 
	 export fixed :=  record
   string8 process_date;
   string10 Instrument_Num;
   string125 Last_Name;
   string70 First_Name;
   string15 Relator;
   string3 Name_Type;
   string8 Sequence_Num;
   string1 lf2;
   end;
	 
	 end;
	 
export premap :=  
  record
  string10 Instrument_Num;
  string12 Instrument_Type;
  string180 Legal_Description;
  string10 Book;
  string10 Page;
  string25 Date_or_Time_Rec;
  string125 Last_Name;
  string70 First_Name;
  string15 Relator;
  string3 Name_Type;
  string8 Sequence_Num;
end;

end;
	