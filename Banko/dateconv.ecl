EXPORT dateconv := module;

export dates := record
string8 EnteredDate;
string8 Pacer_EnteredDate;
end;
										
										
export cnvdatefmt := project(Banko.File_Banko_FixedJoinRec()  ,transform(dates,self.Pacer_EnteredDate := LEFT.Pacer_EnteredDate[1..8],SELF.EnteredDate := LEFT.EnteredDate[1..8]));
end;