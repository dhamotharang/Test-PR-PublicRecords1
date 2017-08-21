IMPORT Business_Credit;
IMPORT ADV;
IMPORT ut;

SourceName := 'SBFECVKeys_linkids';

ds := Business_Credit.Files().linkids;

// HistoricalResults := DATASET(ut.foreign_dataland + 'qc::adv::results::' + SourceName, ADV.Layouts.ResultsFile, thor);
// PreviousBuildVersion := SORT(HistoricalResults, -buildversion)[1].buildversion;

BuildVersion := ADV.CurrentBuildVersions.File(datasetname='SBFECVKeys' and envment='Q' and location = 'B' and cluster = 'N')[1].buildversion;;

NewData := ds(process_date[1..8] = BuildVersion[1..8]);// and process_date > PreviousBuildVersion);
// OldData := ds(process_date[1..8] < BuildVersion[1..8]);

NewSample := CHOOSEN(NewData, 40000);
OldSample := CHOOSEN(ds, 10000);

SampleFile := DISTRIBUTE(NewSample + OldSample);
ADV.Flatten(SampleFile, F_Sample);
Flat_Sample := F_Sample;

// OUTPUT(COUNT(ds), NAMED('Base_Count'));
// OUTPUT(Flat_Sample, NAMED('Flat_Sample'));
OUTPUT(Flat_Sample, ,'~adv::sample::sbfe::linkids::' + BuildVersion, THOR, COMPRESSED, OVERWRITE, EXPIRE(7));