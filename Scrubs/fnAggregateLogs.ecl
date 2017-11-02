import data_services, dops, std, ut, _control;

MoveToUsed:=STD.File.PromoteSuperFileList(['~thor_data400::ScrubsPlus::log','~thor_data400::ScrubsPlus::log::using']);

oldrecs:=dataset('~thor_data400::ScrubsPlus::log::full',Scrubs.Layouts.LogRecord,thor,opt);

newrecs:=dataset('~thor_data400::ScrubsPlus::log::using',Scrubs.Layouts.LogRecord,thor,opt);

CreateNewfile:=output(oldrecs+newrecs,,'~thor_data400::ScrubsPlus::log::full::'+workunit,thor);

ClearFiles:=nothor(global(sequential(
										STD.File.StartSuperFileTransaction(),
										STD.File.ClearSuperFile('~thor_data400::ScrubsPlus::log::full',true),
										STD.File.ClearSuperFile('~thor_data400::ScrubsPlus::log::using',true),
										STD.File.FinishSuperFileTransaction())));

EXPORT fnAggregateLogs := 
										sequential(
										MoveToUsed,
										CreateNewfile,
										ClearFiles,
										nothor(global(sequential(
										STD.File.StartSuperFileTransaction(),
										STD.File.AddSuperFile('~thor_data400::ScrubsPlus::log::full','~thor_data400::ScrubsPlus::log::full::'+workunit),
										STD.File.FinishSuperFileTransaction()))));

