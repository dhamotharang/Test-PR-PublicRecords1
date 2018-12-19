//This is the code to execute in a builder window
//Compares the current neustar wireless main base file to the previous one
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','NeustarWireless.BWR_Stats');
IMPORT NeustarWireless,SALT311,STD, ut;

mynewfile := NeustarWireless.Files.Names.Main; // THOR file containing new data
myprevfile := NeustarWireless.Files.Names.Main + '_father'; // THOR file containing previous data 

//get dates from the logical files that are in the supers above
current_file_name := NOTHOR(STD.File.SuperFileContents(mynewfile))[1].name;
prior_file_name := NOTHOR(STD.File.SuperFileContents(myprevfile))[1].name;
current_file_version := current_file_name[length(trim(current_file_name))-7..length(trim(current_file_name))];
prior_file_version := prior_file_name[length(trim(prior_file_name))-7..length(trim(prior_file_name))];
 
// New and previous versions of data
dsNew :=  DISTRIBUTE(DATASET(mynewfile, NeustarWireless.Layout_MAIN, THOR), SKEW(0.1));
dsPrev :=  DISTRIBUTE(DATASET(myprevfile, NeustarWireless.Layout_MAIN, THOR), SKEW(0.1));

hNew := NeustarWireless.hygiene(dsNew);
hPrev := NeustarWireless.hygiene(dsPrev);
 
hygieneStatsNew := hNew.StandardStats();
hygieneStatsPrev := hPrev.StandardStats();

layout_compare_ss := record
	unsigned8 datetimestamp;
	string wuid;
	string current_file_version;
	string prior_file_version;
	string statcategory;
	string measuretype;
	string field;
	string statdesc;
	real current_statvalue;
	real prior_statvalue;
	real difference;
	real pct_difference;
end;

layout_compare_ss doJoin(recordof(hygieneStatsNew) curr, recordof(hygieneStatsPrev) prior) := TRANSFORM
	self.current_file_version := current_file_version;
	self.prior_file_version := prior_file_version;
	self.current_statvalue := curr.statvalue;
	self.prior_statvalue := prior.statvalue;
	self.difference := self.current_statvalue - self.prior_statvalue;
	self.pct_difference := IF(self.prior_statvalue<>0, ((self.difference/self.prior_statvalue)*100.00),IF(self.current_statvalue=0,0,1));
	self := curr;
end;

joinedStats := JOIN(hygieneStatsNew, hygieneStatsPrev,LEFT.statdesc=RIGHT.statdesc, doJoin(LEFT,RIGHT));

hygieneInvSumNew := hNew.invSummary;
hygieneInvSumPrev := hPrev.invSummary;

layout_compare_summary := record
	string current_file_version;
	string prior_file_version;	
	unsigned8 current_num_recs;
	unsigned8 prior_num_recs;
	real pct_change_recs;
	unsigned4 fldno;
	string fieldname;
	real current_populated_pcnt;
	real prior_populated_pcnt;
	real pct_change_pop;	
	unsigned8 current_maxlength;
	unsigned8 prior_maxlength;
	real pct_change_maxlength;
	real current_avelength;
	real prior_avelength;
	real pct_avelength;
end;

layout_compare_summary doJoin2(recordof(hygieneInvSumNew) curr, recordof(hygieneInvSumPrev) prior) := TRANSFORM
	self.current_file_version := current_file_version;
	self.prior_file_version := prior_file_version;
	self.current_num_recs := curr.numberofrecords;
	self.prior_num_recs := prior.numberofrecords;
	self.pct_change_recs := IF(prior.numberofrecords<>0, (((curr.numberofrecords-prior.numberofrecords)/prior.numberofrecords)*100.00),IF(curr.numberofrecords=0,0,1));
	self.current_populated_pcnt := curr.populated_pcnt;
	self.prior_populated_pcnt := prior.populated_pcnt;
	self.pct_change_pop := IF(prior.populated_pcnt<>0, (((curr.populated_pcnt-prior.populated_pcnt)/prior.populated_pcnt)*100.00),IF(curr.populated_pcnt=0,0,1));
	self.current_maxlength := curr.maxlength;
	self.prior_maxlength := prior.maxlength;
	self.pct_change_maxlength := IF(prior.maxlength<>0, (((curr.maxlength-prior.maxlength)/prior.maxlength)*100.00),IF(curr.maxlength=0,0,1));
	self.current_avelength := curr.avelength;
	self.prior_avelength := prior.avelength;
	self.pct_avelength := IF(prior.avelength<>0, (((curr.avelength-prior.avelength)/prior.avelength)*100.00),IF(curr.avelength=0,0,1));
	self := curr;
end;

joinedSummary := JOIN(hygieneInvSumNew, hygieneInvSumPrev,LEFT.fldno=RIGHT.fldno, doJoin2(LEFT,RIGHT));

layout_combined := RECORD
	string file_version;
	NeustarWireless.Layout_MAIN;
END;

dsCurrentCombined := project(dsNew(current_rec=true), transform(layout_combined, self.file_version := current_file_version, self:=left))
										 + project(dsPrev(current_rec=true), transform(layout_combined, self.file_version := prior_file_version, self:=left));


OUTPUT(hNew.Summary('SummaryReport'),ALL,NAMED('Summary_New'));

OUTPUT(joinedSummary, named('Inverted_Summary_Comparison'));
OUTPUT(joinedSummary(trim(fieldname) <> 'current_rec' and abs(pct_change_pop) > 3), named('Pct_Pop_Change_Over_3'));

// ****** Cross Tabs *******
// It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
examples := 100;
OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,verified,examples),NAMED('current_recs_verified'));	
OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,activity_status,examples),NAMED('current_recs_activity_status'));
OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,prepaid,examples),NAMED('current_recs_prepaid'));
OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,cord_cutter,examples),NAMED('current_recs_cord_cutter'));
OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,state,examples),NAMED('current_recs_state'));	

//*****other options for further investigation of issues			
//p := hNew.AllProfiles;
//OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
//OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Layout_MAIN'),NAMED('OptimizedLayout'));// File layout suggested by data
// Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
//OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
//OUTPUT(hNew.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
// OUTPUT(joinedStats, named('Standard_Stats_Comparison'));
// OUTPUT(hygieneStatsNew, named('Standard_Stats_New'));
// OUTPUT(hygieneStatsPrev, named('Standard_Stats_Prev'));
// OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined(file_version=current_file_version),state,city,examples),NAMED('records_by_state_city_new'));	
// OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined(file_version=prior_file_version),state,city,examples),NAMED('records_by_state_city_prior'));	

  