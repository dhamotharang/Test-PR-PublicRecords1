import data_services, dops, std, ut, _control, PromoteSupers;

MoveToUsedPlus:=STD.File.PromoteSuperFileList(['~thor_data400::ScrubsPlus::log','~thor_data400::ScrubsPlus::log::using']);
MoveToUsedStandard:=STD.File.PromoteSuperFileList(['~thor_data400::Scrubs::OrbitReports','~thor_data400::Scrubs::OrbitReports::using']);

oldrecsPlus:=dataset('~thor_data400::ScrubsPlus::log::fullFile',Scrubs.Layouts.LogRecord,thor,opt);

newrecsPlus:=dataset('~thor_data400::ScrubsPlus::log::using',Scrubs.Layouts.LogRecord,thor,opt);

oldrecsStandard:=dataset('~thor_data400::Scrubs::OrbitReports::fullFile',Scrubs.Layouts.OrbitLogLayout,thor,opt);

newrecsStandard:=dataset('~thor_data400::Scrubs::OrbitReports::using',Scrubs.Layouts.OrbitLogLayout,thor,opt);

// CreateNewfile:=ordered(
// output(oldrecsPlus+newrecsPlus,,'~thor_data400::ScrubsPlus::log::full::'+workunit,thor),
// output(oldrecsStandard+newrecsStandard,,'~thor_data400::Scrubs::OrbitReports::full::'+workunit,thor));


PromoteSupers.Mac_SF_BuildProcess(oldrecsPlus+newrecsPlus,'~thor_data400::ScrubsPlus::log::fullFile',build_basePlus,,,TRUE);
PromoteSupers.Mac_SF_BuildProcess(oldrecsStandard+newrecsStandard,'~thor_data400::Scrubs::OrbitReports::fullFile',build_baseOrbit,,,TRUE);

// ClearFiles:=nothor(global(sequential(
										// STD.File.StartSuperFileTransaction(),
										// STD.File.ClearSuperFile('~thor_data400::ScrubsPlus::log::full',true),
										// STD.File.ClearSuperFile('~thor_data400::ScrubsPlus::log::using',true),
										// STD.File.ClearSuperFile('~thor_data400::Scrubs::OrbitReports::full',true),
										// STD.File.ClearSuperFile('~thor_data400::Scrubs::OrbitReports::using',true),
										// STD.File.FinishSuperFileTransaction())));

EXPORT fnAggregateLogs := 
										sequential(
										MoveToUsedPlus,
										MoveToUsedStandard,
										build_basePlus,
										build_baseOrbit);

