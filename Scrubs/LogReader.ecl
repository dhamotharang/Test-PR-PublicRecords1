import std;
EXPORT LogReader(string select_dataset='') := function

//Scrubs.Layouts.LogRecord
Loadfile:=dataset('~thor_data400::ScrubsPlus::Log',Scrubs.Layouts.LogRecord,thor);

SortedList	:=	sort(Loadfile,Datasetidentifier,Profile,version,WU);

ReducedList	:=	if(select_dataset='',SortedList,SortedList(STD.Str.ToUpperCase(Datasetidentifier)=STD.Str.ToUpperCase(select_dataset)));

FinalReport:=if(select_dataset='',
								output(ReducedList,,'LogReport::ALL::'+((String)Std.Date.Today()),all,OVERWRITE),
								output(ReducedList,,'LogReport::'+select_dataset+'::'+((String)Std.Date.Today()),all,OVERWRITE));

return FinalReport;

end;