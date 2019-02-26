﻿IMPORT SALT311;

// This function uses OKC student list ingest file and scrubs summary report generated by Build_Ingest_File and
// filters out records with college IDs of the colleges that
//	1. have too many scrubs rule violations
//	2. have to little DIDs populated with cleaned names and addresses (will not be used for now 7/19/2017)
// and returns records that pass quarantine test.
EXPORT Quarantine_Test(string pversion='') := FUNCTION

	exclude_colleges_layout := RECORD
		STRING10 	collegeid;
		STRING	 	college:='';
		STRING1	 	exclusion_flag:='';					//Y: the college will be excluded; N: the college will be included in the OKC student list
		STRING5	 	filter_type;								//Identify the reason for the college exclusion, it can be ORBIT, DID.
		unsigned8 recordstotal;
		unsigned8 rulecnt:=0;
		unsigned1 rulepcnt:=0;
		string 		ruledesc:='';
		string 		errormessage:='';
		unsigned8 didcnt:=0;
		unsigned1 didpcnt:=0;
	END;

	orbit_threshold_min 			:= 1;						//ignore any records whose rulepcnt is equal or less than this
	orbit_threshold_missing 	:= 100;					//reject schools that have rulepcnt greater than this

	//New ingested file
	dsOKCStudentFileIngest 	:= OKC_Student_List.File_OKC_Ingest_File;
	
	//Latest scrubs report
	OrbitReportSummary			:= DATASET(Filenames().ScrubsReport, SALT311.ScrubsOrbitLayout AND NOT [rejectwarning, rawcodemissing, rawcodemissingcnt], THOR);

	//Filter out records that have less errors than defined threshold
	orbit_summary_rulepcnt_gt_threshold := OrbitReportSummary(rulepcnt>orbit_threshold_min);	
	//Select records that have invalid values (ALLOW and ENUM)
	orbit_summary_not_allowed := orbit_summary_rulepcnt_gt_threshold(regexfind(':ALLOW|:ENUM|:CUSTOM',ruledesc));	
	output(orbit_summary_not_allowed,,named('Orbit_Summary_Not_Allowed_'+pversion));
	//Select records that have significant % rulepcnt
	orbit_summary_missing 	:= orbit_summary_rulepcnt_gt_threshold(rulepcnt>=orbit_threshold_missing and STD.Str.find(left.name,':POP',1)=0);
	output(orbit_summary_missing,,named('Orbit_Summary_Length_'+pversion));
	orbit_exclusion_list 		:= PROJECT(orbit_summary_not_allowed+orbit_summary_missing, 
																		 TRANSFORM(exclude_colleges_layout,
																							 SELF.collegeid:=LEFT.sourcecode,SELF.filter_type:='ORBIT',SELF:=LEFT));
		
	//Get college DID population stats
	// college_did 						:= 	fnGetCollegesLexidPopulation(dsOKCStudentFileIngest);
	college_all 						:= TABLE(DISTRIBUTE(dsOKCStudentFileIngest,HASH(collegeid)),{collegeid,college,UNSIGNED recordstotal:=COUNT(GROUP)},collegeid,college);
	college_with_did 				:= TABLE(DISTRIBUTE(dsOKCStudentFileIngest(did>0),HASH(collegeid)),{collegeid,UNSIGNED didcnt:=COUNT(GROUP)},collegeid);
	//Calculate DID present % for each school
	college_did 						:= JOIN(college_all, college_with_did,
																  LEFT.collegeid=RIGHT.collegeid,
																  TRANSFORM(exclude_colleges_layout,SELF.filter_type:='DID',SELF.didcnt:=RIGHT.didcnt,
																	 				  SELF.didpcnt:=RIGHT.didcnt/LEFT.recordstotal*100,SELF:=LEFT),
																  LEFT OUTER, KEEP(1),ALL);
													 
	output(SORT(college_did,college),,named('College_Lexid_summary_'+pversion));
	
	//Populate DID stats for orbit exclusion schools
	orbit_exclusion_list_did:= JOIN(orbit_exclusion_list, college_did, LEFT.collegeid=RIGHT.collegeid,
	                               TRANSFORM(exclude_colleges_layout,SELF.college:=RIGHT.college;SELF.didcnt:=RIGHT.didcnt;SELF.didpcnt:=RIGHT.didpcnt;SELF:=LEFT),
																 INNER, LOOKUP);


	//If rule type is LENGTH, rule percent count is 100, but DID percent count > 0, we will remove the college from exclusion list
	exclude_colleges_layout fnSetExclusionFlag(orbit_exclusion_list_did L) := TRANSFORM
		SELF.exclusion_flag := IF(L.rulepcnt=100 AND REGEXFIND('LENGTH$',TRIM(L.ruledesc)) AND L.didpcnt>0,'N','Y');
		SELF := L;
	END;
	orbit_exclusion_list_did_flag := PROJECT(orbit_exclusion_list_did, fnSetExclusionFlag(LEFT));
	
	//Combine the Scrubs and DID lists for reporting purpose
	// college_exclusion_list := SORT(orbit_exclusion_list +did_exclusion_list, collegeid);  //Will not use DID population to filter out colleges
	output(SORT(orbit_exclusion_list_did_flag,college),,named('Orbit_Summary_Lexid_'+pversion));
	college_exclusion_list_final	:= TABLE(orbit_exclusion_list_did_flag(exclusion_flag='Y'), {collegeid,college},collegeid,college);
	output(SORT(orbit_exclusion_list_did_flag(exclusion_flag='Y'),college),,named('Quarantine_College_List_'+pversion));
	
	//Filter out records with collegeid in the college_exclusion_list
	OkcStudentListGood		:= JOIN(dsOKCStudentFileIngest,
																college_exclusion_list_final,
																LEFT.collegeid=RIGHT.collegeid,
																LEFT ONLY, LOOKUP);
	OkcStudentListBad			:= JOIN(dsOKCStudentFileIngest,
																college_exclusion_list_final,
																LEFT.collegeid=RIGHT.collegeid,
																INNER, LOOKUP);

	OUTPUT(OkcStudentListBad,,OKC_Student_List.Filenames(pversion).QuarantineRecs,OVERWRITE,COMPRESSED,EXPIRE(30));		//Keep the quarantined records for 30 days

	RETURN OkcStudentListGood;
	
END;
