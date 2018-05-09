import data_services, dops, std, ut, _control,DopsGrowthCheck;

oldrecsPlus:=dataset('~thor_data400::DeltaStats::IndividualFileStats::full',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);

newrecsPlus:=dataset('~thor_data400::DeltaStats::IndividualFileStats::using',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);

CreateNewfile:=output(oldrecsPlus+newrecsPlus,,'~thor_data400::DeltaStats::IndividualFileStats::full::'+workunit,thor,compressed);

ClearFiles:=nothor(global(sequential(STD.File.StartSuperFileTransaction(),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::IndividualFileStats::full',true),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::IndividualFileStats::using',true),
										STD.File.FinishSuperFileTransaction())));

EXPORT AggregateFiles := sequential(
													CreateNewfile,
													ClearFiles,
													nothor(global(sequential(
													STD.File.StartSuperFileTransaction(),
													STD.File.AddSuperFile('~thor_data400::DeltaStats::IndividualFileStats::full','~thor_data400::DeltaStats::IndividualFileStats::full::'+workunit),
													STD.File.FinishSuperFileTransaction()))));

													
										