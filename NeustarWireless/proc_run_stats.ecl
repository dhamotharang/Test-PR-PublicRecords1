IMPORT NeustarWireless,SALT311,STD, ut;
EXPORT proc_run_stats := FUNCTION


	getSuperOrBlank(returnDataset, superFileName, layout) := MACRO
				 returnDataset := if(count(nothor(FileServices.SuperFileContents(superFileName)))=0,
				 dataset([],layout),
				 dataset(superFileName,layout,flat));
	ENDMACRO;

	getSuperOrBlank(mynewfile, NeustarWireless.Files.Names.Main, NeustarWireless.Layouts.Base.Main);
	getSuperOrBlank(myprevfile, NeustarWireless.Files.Names.Main + '_father', NeustarWireless.Layouts.Base.Main);

	// New and previous versions of data
	dsNew :=  DISTRIBUTE(mynewfile, hash(phone));
	dsPrev :=  DISTRIBUTE(myprevfile,  hash(phone));
	
	current_file_version :=  if(max(dsNew, dsNew.date_vendor_last_reported) = 0, 'current file empty',(string) max(dsNew, dsNew.date_vendor_last_reported));
	prior_file_version := if(max(dsPrev, dsPrev.date_vendor_last_reported) = 0, 'father file empty',(string) max(dsPrev, dsPrev.date_vendor_last_reported));
	
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
		self.pct_change_recs := IF(prior.numberofrecords<>0, (((curr.numberofrecords-prior.numberofrecords)/prior.numberofrecords)*100.00),IF(curr.numberofrecords=0,0,100));
		self.current_populated_pcnt := curr.populated_pcnt;
		self.prior_populated_pcnt := prior.populated_pcnt;
		self.pct_change_pop := IF(prior.populated_pcnt<>0, (((curr.populated_pcnt-prior.populated_pcnt)/prior.populated_pcnt)*100.00),IF(curr.populated_pcnt=0,0,100));
		self.current_maxlength := curr.maxlength;
		self.prior_maxlength := prior.maxlength;
		self.pct_change_maxlength := IF(prior.maxlength<>0, (((curr.maxlength-prior.maxlength)/prior.maxlength)*100.00),IF(curr.maxlength=0,0,100));
		self.current_avelength := curr.avelength;
		self.prior_avelength := prior.avelength;
		self.pct_avelength := IF(prior.avelength<>0, (((curr.avelength-prior.avelength)/prior.avelength)*100.00),IF(curr.avelength=0,0,100));
		self := curr;
	end;

	joinedSummary := JOIN(hygieneInvSumNew, hygieneInvSumPrev,LEFT.fldno=RIGHT.fldno, doJoin2(LEFT,RIGHT));

	layout_combined := RECORD
		string file_version;
		NeustarWireless.Layout_MAIN;
	END;

	dsCurrentCombined := project(dsNew(current_rec=true), transform(layout_combined, self.file_version := current_file_version, self:=left))
											 + project(dsPrev(current_rec=true), transform(layout_combined, self.file_version := prior_file_version, self:=left));

	examples := 100;
	RETURN SEQUENTIAL (
											OUTPUT(hNew.Summary('SummaryReport'),ALL,NAMED('Summary_New')),

											OUTPUT(joinedSummary, named('Inverted_Summary_Comparison')),
											OUTPUT(joinedSummary(trim(fieldname) <> 'current_rec' and abs(pct_change_pop) > 10), named('Pct_Pop_Change_Over_10')),

											// ****** Cross Tabs *******
											OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,verified,examples),NAMED('current_recs_verified')),	
											OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,activity_status,examples),NAMED('current_recs_activity_status')),
											OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,prepaid,examples),NAMED('current_recs_prepaid')),
											OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,cord_cutter,examples),NAMED('current_recs_cord_cutter')),
											OUTPUT(SALT311.MAC_CrossTab(dsCurrentCombined,file_version,state,examples),NAMED('current_recs_state')),	
										);
END;