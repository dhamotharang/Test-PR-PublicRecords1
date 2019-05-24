﻿import data_services, dops, std, ut, _control,DopsGrowthCheck;

oldrecsPlus:=dataset('~thor_data400::DeltaStats::IndividualFileStats::full',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);

newrecsPlus:=dataset('~thor_data400::DeltaStats::IndividualFileStats::using',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);


DeltaoldrecsPlus:=dataset('~thor_data400::DeltaStats::FullDeltaStats::full',DOPSGrowthCheck.layouts.Full_Delta_Stat_Layout,thor,__compressed__,opt);

DeltanewrecsPlus:=dataset('~thor_data400::DeltaStats::FullDeltaStats::using',DOPSGrowthCheck.layouts.Full_Delta_Stat_Layout,thor,__compressed__,opt);

FieldoldrecsPlus:=dataset('~thor_data400::DeltaStats::ChangesByField::full',DOPSGrowthCheck.layouts.FieldChangeLayout,thor,__compressed__,opt);

FieldnewrecsPlus:=dataset('~thor_data400::DeltaStats::ChangesByField::using',DOPSGrowthCheck.layouts.FieldChangeLayout,thor,__compressed__,opt);

PersistoldrecsPlus:=dataset('~thor_data400::DeltaStats::PersistenceCheck::full',DOPSGrowthCheck.layouts.PersistLayout,thor,__compressed__,opt);

PersistnewrecsPlus:=dataset('~thor_data400::DeltaStats::PersistenceCheck::using',DOPSGrowthCheck.layouts.PersistLayout,thor,__compressed__,opt);

#if(_Control.ThisEnvironment.Name='Prod_Thor')
ProdList:=dops.GetDeployedDatasets('P','B','F');
UpdatePassed:=project(oldrecsPlus,transform(recordof(oldrecsPlus),Self.Passed:=if(Exists(ProdList(datasetname=Left.Packagename and buildversion=Left.CurrVersion)) and Left.Passed='N','Y',Left.Passed);Self:=Left;));
DeltaUpdatePassed:=project(DeltaoldrecsPlus,transform(recordof(DeltaoldrecsPlus),Self.Passed:=if(Exists(ProdList(datasetname=Left.Packagename and buildversion=Left.CurrVersion)) and Left.Passed='N','Y',Left.Passed);Self:=Left;));
FieldUpdatePassed:=project(FieldoldrecsPlus,transform(recordof(FieldoldrecsPlus),Self.Passed:=if(Exists(ProdList(datasetname=Left.Packagename and buildversion=Left.CurrVersion)) and Left.Passed='N','Y',Left.Passed);Self:=Left;));
PersistUpdatePassed:=project(PersistoldrecsPlus,transform(recordof(PersistoldrecsPlus),Self.Passed:=if(Exists(ProdList(datasetname=Left.Packagename and buildversion=Left.CurrVersion)) and Left.Passed='N','Y',Left.Passed);Self:=Left;));
#else
UpdatePassed:=project(oldrecsPlus,transform(recordof(oldrecsPlus),Self.Passed:='Y';Self:=Left;));
DeltaUpdatePassed:=project(DeltaoldrecsPlus,transform(recordof(DeltaoldrecsPlus),Self.Passed:='Y';Self:=Left;));
FieldUpdatePassed:=project(FieldoldrecsPlus,transform(recordof(FieldoldrecsPlus),Self.Passed:='Y';Self:=Left;));
PersistUpdatePassed:=project(PersistoldrecsPlus,transform(recordof(PersistoldrecsPlus),Self.Passed:='Y';Self:=Left;));
#end;



CalculateStatsAlertsOld:=dataset('~thor_data400::DeltaStats::CalculateStatsAlerts::full',DOPSGrowthCheck.layouts.CalculateStatAlerts,thor,__compressed__,opt);

CalculateStatsAlertsNew:=dataset('~thor_data400::DeltaStats::CalculateStatsAlerts::using',DOPSGrowthCheck.layouts.CalculateStatAlerts,thor,__compressed__,opt);

DeltaStatssAlertsOld:=dataset('~thor_data400::DeltaStats::DeltaStatsAlerts::full',DOPSGrowthCheck.layouts.DeltaStatAlerts,thor,__compressed__,opt);

DeltaStatsAlertsNew:=dataset('~thor_data400::DeltaStats::DeltaStatsAlerts::using',DOPSGrowthCheck.layouts.DeltaStatAlerts,thor,__compressed__,opt);

PersistenceStatsAlertsOld:=dataset('~thor_data400::DeltaStats::PersistenceStatsAlerts::full',DOPSGrowthCheck.layouts.PersistStatAlerts,thor,__compressed__,opt);

PersistenceStatsAlertsNew:=dataset('~thor_data400::DeltaStats::PersistenceStatsAlerts::using',DOPSGrowthCheck.layouts.PersistStatAlerts,thor,__compressed__,opt);


CreateNewfile:=sequential(
output(UpdatePassed+newrecsPlus,,'~thor_data400::DeltaStats::IndividualFileStats::full::'+workunit,thor,compressed),
output(DeltaUpdatePassed+DeltanewrecsPlus,,'~thor_data400::DeltaStats::FullDeltaStats::full::'+workunit,thor,compressed),
output(FieldUpdatePassed+FieldnewrecsPlus,,'~thor_data400::DeltaStats::ChangesByField::full::'+workunit,thor,compressed),
output(PersistUpdatePassed+PersistnewrecsPlus,,'~thor_data400::DeltaStats::PersistenceCheck::full::'+workunit,thor,compressed),
output(CalculateStatsAlertsOld+CalculateStatsAlertsNew,,'~thor_data400::DeltaStats::CalculateStatsAlerts::full::'+workunit,thor,compressed),
output(DeltaStatssAlertsOld+DeltaStatsAlertsNew,,'~thor_data400::DeltaStats::DeltaStatsAlerts::full::'+workunit,thor,compressed),
output(PersistenceStatsAlertsOld+PersistenceStatsAlertsNew,,'~thor_data400::DeltaStats::PersistenceStatsAlerts::full::'+workunit,thor,compressed),
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
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::CalculateStatsAlerts::full',false),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::CalculateStatsAlerts::using',true),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::DeltaStatsAlerts::full',false),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::DeltaStatsAlerts::using',true),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::PersistenceStatsAlerts::full',false),
										STD.File.ClearSuperFile('~thor_data400::DeltaStats::PersistenceStatsAlerts::using',true),										
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
													STD.File.AddSuperFile('~thor_data400::DeltaStats::CalculateStatsAlerts::full','~thor_data400::DeltaStats::CalculateStatsAlerts::full::'+workunit),
													STD.File.AddSuperFile('~thor_data400::DeltaStats::DeltaStatsAlerts::full','~thor_data400::DeltaStats::DeltaStatsAlerts::full::'+workunit),
													STD.File.AddSuperFile('~thor_data400::DeltaStats::PersistenceStatsAlerts::full','~thor_data400::DeltaStats::PersistenceStatsAlerts::full::'+workunit),
													STD.File.FinishSuperFileTransaction()))));

													
										