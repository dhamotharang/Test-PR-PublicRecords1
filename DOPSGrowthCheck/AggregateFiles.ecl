import data_services, dops, std, ut, _control,DopsGrowthCheck;

ProdList:=dops.GetDeployedDatasets('P','B','F');

oldrecsPlus:=dataset('~thor_data400::DeltaStats::IndividualFileStats::full',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);

UpdatePassed:=project(oldrecsPlus,transform(recordof(oldrecsPlus),Self.Passed:=if(Exists(ProdList(datasetname=Left.Packagename and buildversion=Left.CurrVersion)) and Left.Passed='N','Y',Left.Passed);Self:=Left;));

newrecsPlus:=dataset('~thor_data400::DeltaStats::IndividualFileStats::using',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);


DeltaoldrecsPlus:=dataset('~thor_data400::DeltaStats::FullDeltaStats::full',DOPSGrowthCheck.layouts.Full_Delta_Stat_Layout,thor,__compressed__,opt);

DeltaUpdatePassed:=project(DeltaoldrecsPlus,transform(recordof(DeltaoldrecsPlus),Self.Passed:=if(Exists(ProdList(datasetname=Left.Packagename and buildversion=Left.CurrVersion)) and Left.Passed='N','Y',Left.Passed);Self:=Left;));

DeltanewrecsPlus:=dataset('~thor_data400::DeltaStats::FullDeltaStats::using',DOPSGrowthCheck.layouts.Full_Delta_Stat_Layout,thor,__compressed__,opt);

FieldoldrecsPlus:=dataset('~thor_data400::DeltaStats::ChangesByField::full',DOPSGrowthCheck.layouts.FieldChangeLayout,thor,__compressed__,opt);

FieldUpdatePassed:=project(FieldoldrecsPlus,transform(recordof(FieldoldrecsPlus),Self.Passed:=if(Exists(ProdList(datasetname=Left.Packagename and buildversion=Left.CurrVersion)) and Left.Passed='N','Y',Left.Passed);Self:=Left;));

FieldnewrecsPlus:=dataset('~thor_data400::DeltaStats::ChangesByField::using',DOPSGrowthCheck.layouts.FieldChangeLayout,thor,__compressed__,opt);

PersistoldrecsPlus:=dataset('~thor_data400::DeltaStats::PersistenceCheck::full',DOPSGrowthCheck.layouts.PersistLayout,thor,__compressed__,opt);

PersistUpdatePassed:=project(PersistoldrecsPlus,transform(recordof(PersistoldrecsPlus),Self.Passed:=if(Exists(ProdList(datasetname=Left.Packagename and buildversion=Left.CurrVersion)) and Left.Passed='N','Y',Left.Passed);Self:=Left;));

PersistnewrecsPlus:=dataset('~thor_data400::DeltaStats::PersistenceCheck::using',DOPSGrowthCheck.layouts.PersistLayout,thor,__compressed__,opt);


CreateNewfile:=sequential(
output(UpdatePassed+newrecsPlus,,'~thor_data400::DeltaStats::IndividualFileStats::full::'+workunit,thor,compressed),
output(DeltaUpdatePassed+DeltanewrecsPlus,,'~thor_data400::DeltaStats::FullDeltaStats::full::'+workunit,thor,compressed),
output(FieldUpdatePassed+FieldnewrecsPlus,,'~thor_data400::DeltaStats::ChangesByField::full::'+workunit,thor,compressed),
output(PersistUpdatePassed+PersistnewrecsPlus,,'~thor_data400::DeltaStats::PersistenceCheck::full::'+workunit,thor,compressed),
);

ClearFiles:=nothor(global(sequential(STD.File.StartSuperFileTransaction(),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::IndividualFileStats::full',false),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::IndividualFileStats::using',true),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::FullDeltaStats::full',false),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::FullDeltaStats::using',true),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::ChangesByField::full',false),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::ChangesByField::using',true),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::PersistenceCheck::full',false),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::PersistenceCheck::using',true),
										STD.File.FinishSuperFileTransaction())));

EXPORT AggregateFiles := sequential(
													CreateNewfile,
													ClearFiles,
													nothor(global(sequential(
													STD.File.StartSuperFileTransaction(),
													STD.File.AddSuperFile('~thor_data400::DeltaStats::IndividualFileStats::full','~thor_data400::DeltaStats::IndividualFileStats::full::'+workunit),
													STD.File.AddSuperFile('~thor_data400::DeltaStats::FullDeltaStats::full','~thor_data400::DeltaStats::FullDeltaStats::full::'+workunit),
													STD.File.AddSuperFile('~thor_data400::DeltaStats::ChangesByField::full','~thor_data400::DeltaStats::ChangesByField::full::'+workunit),
													STD.File.AddSuperFile('~thor_data400::DeltaStats::PersistenceCheck::full','~thor_data400::DeltaStats::PersistenceCheck::full::'+workunit),
													STD.File.FinishSuperFileTransaction()))));

													
										