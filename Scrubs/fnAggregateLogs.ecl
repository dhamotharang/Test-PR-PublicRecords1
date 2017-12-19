import data_services, dops, std, ut, _control;

MoveToUsedPlus:=STD.File.PromoteSuperFileList(['~thor_data400::ScrubsPlus::log','~thor_data400::ScrubsPlus::log::using']);
MoveToUsedStandard:=STD.File.PromoteSuperFileList(['~thor_data400::Scrubs::OrbitReports','~thor_data400::Scrubs::OrbitReports::using']);

oldrecsPlus:=dataset('~thor_data400::ScrubsPlus::log::full',Scrubs.Layouts.LogRecord,thor,opt);

newrecsPlus:=dataset('~thor_data400::ScrubsPlus::log::using',Scrubs.Layouts.LogRecord,thor,opt);

oldrecsStandard:=dataset('~thor_data400::Scrubs::OrbitReports::full',Scrubs.Layouts.OrbitLogLayout,thor,opt);

newrecsStandard:=dataset('~thor_data400::Scrubs::OrbitReports::using',Scrubs.Layouts.OrbitLogLayout,thor,opt);

CreateNewfile:=ordered(
output(oldrecsPlus+newrecsPlus,,'~thor_data400::ScrubsPlus::log::full::'+workunit,thor),
output(oldrecsStandard+newrecsStandard,,'~thor_data400::Scrubs::OrbitReports::full::'+workunit,thor));

ClearFiles:=nothor(global(sequential(
										STD.File.StartSuperFileTransaction(),
										STD.File.ClearSuperFile('~thor_data400::ScrubsPlus::log::full',true),
										STD.File.ClearSuperFile('~thor_data400::ScrubsPlus::log::using',true),
										STD.File.ClearSuperFile('~thor_data400::Scrubs::OrbitReports::full',true),
										STD.File.ClearSuperFile('~thor_data400::Scrubs::OrbitReports::using',true),
										STD.File.FinishSuperFileTransaction())));

EXPORT fnAggregateLogs := 
										sequential(
										MoveToUsedPlus,
										MoveToUsedStandard,
										CreateNewfile,
										ClearFiles,
										nothor(global(sequential(
										STD.File.StartSuperFileTransaction(),
										STD.File.AddSuperFile('~thor_data400::ScrubsPlus::log::full','~thor_data400::ScrubsPlus::log::full::'+workunit),
										STD.File.AddSuperFile('~thor_data400::Scrubs::OrbitReports::full','~thor_data400::Scrubs::OrbitReports::full::'+workunit),
										STD.File.FinishSuperFileTransaction()))));

