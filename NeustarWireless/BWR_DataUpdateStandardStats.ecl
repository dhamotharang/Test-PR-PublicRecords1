//This is the code to execute in a builder window
//Compares the current neustar wireless main base file to the previous one
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','NeustarWireless.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT NeustarWireless,SALT311,STD;
mynewfile := NeustarWireless.Files.Names.Main; // THOR file containing new data
myprevfile := NeustarWireless.Files.Names.Main + '_father'; // THOR file containing previous data (can be empty)

//get dates from the logical files that are in the supers above
current_file_name := NOTHOR(STD.File.SuperFileContents(mynewfile))[1].name;
prior_file_name := NOTHOR(STD.File.SuperFileContents(myprevfile))[1].name;
current_file_version := current_file_name[length(trim(current_file_name))-7..length(trim(current_file_name))];
prior_file_version := prior_file_name[length(trim(prior_file_name))-7..length(trim(prior_file_name))];
 
mystatsfile := NeustarWireless.Files.Names.Main + '_stats_' + current_file_version + '_vs_' + prior_file_version ; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, NeustarWireless.Layout_MAIN, THOR);
dsPrev := DATASET(myprevfile, NeustarWireless.Layout_MAIN, THOR);
 
hygieneStatsNew := NeustarWireless.hygiene(dsNew).StandardStats();
hygieneStatsPrev := NeustarWireless.hygiene(dsPrev).StandardStats();

layout_compare := record
	unsigned8 datetimestamp;
	string wuid;
	string current_file_name;
	string prior_file_name;
	string statcategory;
	string measuretype;
	string field;
	string statdesc;
	real current_statvalue;
	real prior_statvalue;
	real difference;
end;

layout_compare doJoin(recordof(hygieneStatsNew) curr, recordof(hygieneStatsPrev) prior) := TRANSFORM
	self.current_file_name := current_file_name;
	self.prior_file_name := prior_file_name;
	self.current_statvalue := curr.statvalue;
	self.prior_statvalue := prior.statvalue;
	self.difference := self.current_statvalue - self.prior_statvalue;
	self := curr;
end;

joinedStats := JOIN(hygieneStatsNew, hygieneStatsPrev,LEFT.statdesc=RIGHT.statdesc, doJoin(LEFT,RIGHT));

OUTPUT(sort(joinedStats, -difference),, mystatsfile, overwrite);
