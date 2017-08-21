
Layouts_Broward.CFN.fixed tr_brCFN(Files_raw.Broward.File_CFN l) := transform
  self.process_year             := '';
  self.Execution_Date           := '';
  self.Legal_1                  := l.Legal_1[1..60];
  self.Address_1                := '';
  self.Address_2                := '';
  self.City                     := '';
  self.State                    := '';
  self.Zip_Code                 := '';
	self.Document_Type_Code       := if ( length(trim(l.Document_Type_Code)) > 10 , regexreplace('EXEMPT',trim(l.Document_Type_Code),'EXM'), trim(l.Document_Type_Code));
  self.Record_Date              := l.Record_Date_YMD;
  self.Parcel_ID                := map ( StringLib.StringFind(trim(l.Parcel_ID),'FAIRWAYS',1) <> 0 =>  '',
                                            trim(l.Parcel_ID) <> '' => intformat((integer) trim(l.Parcel_ID),15,0) ,
                                                trim(l.Parcel_ID)
													              );
  self.Case_Number              :=  regexreplace(  '/SNOW|POLK COUNTY' ,trim(l.Case_Number), '');
                                       

  self := l;
  end;
  
  File_fixed_CFN := project(Files_raw.Broward.File_CFN (  length(Case_Number) < 25 ) ,tr_brCFN(LEFT));
  
Layouts_Broward.NME.fixed tr_NME(Files_raw.Broward.File_NME l) := transform
  self.process_year       := '';
  self.Party_Name         := l.Party_Name[1..60];
  self.Company_Individual := 'I';
  self.lf                 := '';
  self.Instrument_Number  := l.Instrument_Number[1..9];
  self                    := l;
 end;
  
  File_fixed_NME := project(Files_raw.Broward.File_NME,tr_NME(LEFT));
  
  
Layouts_Broward.Layout_CFN_NME tr_joinCFN(File_fixed_CFN l,File_fixed_NME r) := transform
  self.Instrument_Number  := l.Instrument_Number;
  self                   := l;
	self                   := r;
end;
  
join_CFN_NME :=join(
	                     distribute(File_fixed_CFN,hash(Instrument_Number)),
											    distribute(File_fixed_NME,hash(Instrument_Number)),
											      LEFT.Instrument_Number=RIGHT.Instrument_Number,
												      tr_joinCFN(LEFT,RIGHT),local
									 );
  
  
Layouts_Broward.LNK.fixed tr_LNK(Files_raw.Broward.File_LNK l) := transform
	self.process_year := '';
  self.lf := '';
	self.Prior_Document_Type_Code := trim(l.Prior_Document_Type_Code)[1..10];
  self := l;
end;
  
  File_fixed_LNK := project(Files_raw.Broward.File_LNK ( keypunch[1] = 'O'),tr_LNK(LEFT));
  
  
Layouts_Broward.Layout_all tr_join_LNK(join_CFN_NME l,File_fixed_LNK r) := transform
	self.Instrument_Number := l.Instrument_Number;
	self := l;
	self := r;
end;

export File_In_FL_Broward := join(
                                    distribute(join_CFN_NME,hash(Instrument_Number)),
																		distribute(File_fixed_LNK,hash(Instrument_Number)),
																		LEFT.Instrument_Number=RIGHT.Instrument_Number,
																		tr_join_LNK(LEFT,RIGHT),LEFT OUTER,local
																 );




