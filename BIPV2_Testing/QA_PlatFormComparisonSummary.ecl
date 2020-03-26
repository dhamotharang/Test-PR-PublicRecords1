//Please provide values for the following workunits before submitting the code!

import wk_ut;
shared string WU_BeforUpgrade	:='W20150730-111747'; 
shared string WU_AfterUpgrade	:='W20150730-142804';

shared string WU_LGID3_Before :='W20150726-185954';
shared string WU_LGID3_After  :='W20150730-144803';

shared string WU_EmpID_Before :='W20150727-140446';
shared string WU_EmpID_After  :='W20150730-140600';

shared string WU_EmpIdDown_Before :='W20150726-195314';
shared string WU_EmpIdDown_After  :='W20150730-132100';

shared string WU_PowIdDown_Before :='W20150728-131358';
shared string WU_PowIdDown_After  :='W20150728-135644';
 
shared string WU_Hrchy_Before :='W20150731-105516'; //W20150728-193219
shared string WU_Hrchy_After  :='W20150731-132432'; //W20150728-215024

shared string WU_DotID_Before :='W20150728-193327';
shared string WU_DotID_After  :='W20150729-132410';
 
shared string WU_Mj6Spec_Before :='W20150730-093801';
shared string WU_Mj6Spec_After  :='W20150730-101649'; 

shared string WU_ProxSpec_Before :='W20150730-131051';
shared string WU_ProxSpec_After  :='W20150730-140631'; 

shared string WU_POWID_Before :='W20150730-170208';
shared string WU_POWID_After  :='W20150731-095050';


//------------------------------------------------------------------------------ 
shared Summary_Rec :={string ResultName, Integer BeforeUpgrade, Integer AfterUpgrade, Integer Difference};
shared TotalRecordCount_rec :={integer RCount};
//-----POWID iteration part:
B_POWID_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_POWID_Before,'MatchSampleRecords');
A_POWID_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_POWID_After,'MatchSampleRecords');
B_POWID_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_POWID_Before,'SliceOutCandidates');//
A_POWID_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_POWID_After,'SliceOutCandidates');
B_POWID_Specificities	:=wk_ut.get_DS_Count(WU_POWID_Before,'Specificities');//
A_POWID_Specificities	:=wk_ut.get_DS_Count(WU_POWID_After,'Specificities');
B_POWID_SPCShift	:=wk_ut.get_DS_Count(WU_POWID_Before,'SPCShift');//
A_POWID_SPCShift	:=wk_ut.get_DS_Count(WU_POWID_After,'SPCShift');
B_POWID_PreClusters	:=wk_ut.get_DS_Count(WU_POWID_Before,'PreClusters');//
A_POWID_PreClusters	:=wk_ut.get_DS_Count(WU_POWID_After,'PreClusters');
B_POWID_PostClusters	:=wk_ut.get_DS_Count(WU_POWID_Before,'PostClusters');//
A_POWID_PostClusters	:=wk_ut.get_DS_Count(WU_POWID_After,'PostClusters');
B_POWID_PreClusterCount	:=wk_ut.get_DS_Count(WU_POWID_Before,'PreClusterCount');//
A_POWID_PreClusterCount	:=wk_ut.get_DS_Count(WU_POWID_After,'PreClusterCount');
B_POWID_PostClusterCount	:=wk_ut.get_DS_Count(WU_POWID_Before,'PostClusterCount');//
A_POWID_PostClusterCount	:=wk_ut.get_DS_Count(WU_POWID_After,'PostClusterCount');
B_POWID_RuleEfficacy	:=wk_ut.get_DS_Count(WU_POWID_Before,'RuleEfficacy');//
A_POWID_RuleEfficacy	:=wk_ut.get_DS_Count(WU_POWID_After,'RuleEfficacy');
B_POWID_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_POWID_Before,'ConfidenceLevels');//
A_POWID_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_POWID_After,'ConfidenceLevels');
B_POWID_PrePopStats	:=wk_ut.get_DS_Count(WU_POWID_Before,'PrePopStats');//
A_POWID_PrePopStats	:=wk_ut.get_DS_Count(WU_POWID_After,'PrePopStats');
B_POWID_PostPopStats	:=wk_ut.get_DS_Count(WU_POWID_Before,'PostPopStats');//
A_POWID_PostPopStats	:=wk_ut.get_DS_Count(WU_POWID_After,'PostPopStats');
B_POWID_ValidityStatistics	:=wk_ut.get_DS_Count(WU_POWID_Before,'ValidityStatistics');//
A_POWID_ValidityStatistics	:=wk_ut.get_DS_Count(WU_POWID_After,'ValidityStatistics');
B_POWID_IdConsistency0	:=wk_ut.get_DS_Count(WU_POWID_Before,'IdConsistency0');//
A_POWID_IdConsistency0	:=wk_ut.get_DS_Count(WU_POWID_After,'IdConsistency0');
B_POWID_Result20	:=wk_ut.get_DS_Count(WU_POWID_Before,'Result 20');
A_POWID_Result20	:=wk_ut.get_DS_Count(WU_POWID_After,'Result 20');
B_POWID_Result21	:=wk_ut.get_DS_Count(WU_POWID_Before,'Result 21');
A_POWID_Result21	:=wk_ut.get_DS_Count(WU_POWID_After,'Result 21');
B_POWID_Result22	:=wk_ut.get_DS_Count(WU_POWID_Before,'Result 22');
A_POWID_Result22	:=wk_ut.get_DS_Count(WU_POWID_After,'Result 22');
B_POWID_Result23	:=wk_ut.get_DS_Count(WU_POWID_Before,'Result 23');
A_POWID_Result23	:=wk_ut.get_DS_Count(WU_POWID_After,'Result 23');
B_POWID_Result24	:=wk_ut.get_DS_Count(WU_POWID_Before,'Result 24');
A_POWID_Result24	:=wk_ut.get_DS_Count(WU_POWID_After,'Result 24');
B_POWID_Result25	:=wk_ut.get_DS_Count(WU_POWID_Before,'Result 25');
A_POWID_Result25	:=wk_ut.get_DS_Count(WU_POWID_After,'Result 25');

B_POWID_Result26	:=wk_ut.get_DS_Count(WU_POWID_Before,'Result 26');
A_POWID_Result26	:=wk_ut.get_DS_Count(WU_POWID_After,'Result 26');
B_POWID_Result27	:=wk_ut.get_DS_Count(WU_POWID_Before,'Result 27');
A_POWID_Result27	:=wk_ut.get_DS_Count(WU_POWID_After,'Result 27');
B_POWID_Result28	:=wk_ut.get_DS_Count(WU_POWID_Before,'Result 28');
A_POWID_Result28	:=wk_ut.get_DS_Count(WU_POWID_After,'Result 28');

B_POWID_MatchesPerformed	:=Dataset(WorkUnit(WU_POWID_Before,'MatchesPerformed'),TotalRecordCount_rec);//
A_POWID_MatchesPerformed	:=Dataset(WorkUnit(WU_POWID_After,'MatchesPerformed'),TotalRecordCount_rec);
B_POWID_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_POWID_Before,'BasicMatchesPerformed'),TotalRecordCount_rec);//
A_POWID_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_POWID_After,'BasicMatchesPerformed'),TotalRecordCount_rec);
B_POWID_SlicesPerformed	:=Dataset(WorkUnit(WU_POWID_Before,'SlicesPerformed'),TotalRecordCount_rec);//
A_POWID_SlicesPerformed	:=Dataset(WorkUnit(WU_POWID_After,'SlicesPerformed'),TotalRecordCount_rec);
B_POWID_TotalMatchSamples	:=Dataset(WorkUnit(WU_POWID_Before,'TotalMatchSamples'),TotalRecordCount_rec);//
A_POWID_TotalMatchSamples	:=Dataset(WorkUnit(WU_POWID_After,'TotalMatchSamples'),TotalRecordCount_rec);
B_POWID_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_POWID_Before,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);//
A_POWID_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_POWID_After,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);
B_POWID_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_POWID_Before,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);//
A_POWID_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_POWID_After,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);

Shared POWID_ds :=dataset([
{'MatchSampleRecords', 		B_POWID_MatchSampleRecords, 	A_POWID_MatchSampleRecords, 	A_POWID_MatchSampleRecords- 	B_POWID_MatchSampleRecords},
{'SliceOutCandidates', 		B_POWID_SliceOutCandidates,   A_POWID_SliceOutCandidates,   A_POWID_SliceOutCandidates-   B_POWID_SliceOutCandidates},
{'Specificities',   			B_POWID_Specificities,   			A_POWID_Specificities,  	 		A_POWID_Specificities-   			B_POWID_Specificities},
{'SPCShift',   						B_POWID_SPCShift,   					A_POWID_SPCShift,   					A_POWID_SPCShift-   					B_POWID_SPCShift},
{'PreClusters',   				B_POWID_PreClusters,   				A_POWID_PreClusters,   				A_POWID_PreClusters-   				B_POWID_PreClusters},
{'PostClusters',   				B_POWID_PostClusters,   			A_POWID_PostClusters,   			A_POWID_PostClusters-   			B_POWID_PostClusters},
{'PreClusterCount',   		B_POWID_PreClusterCount,   		A_POWID_PreClusterCount,   		A_POWID_PreClusterCount-   		B_POWID_PreClusterCount},
{'PostClusterCount',   		B_POWID_PostClusterCount,   	A_POWID_PostClusterCount,   	A_POWID_PostClusterCount-   	B_POWID_PostClusterCount},
{'RuleEfficacy',   				B_POWID_RuleEfficacy,   			A_POWID_RuleEfficacy,   			A_POWID_RuleEfficacy-   			B_POWID_RuleEfficacy},
{'ConfidenceLevels',   		B_POWID_ConfidenceLevels,   	A_POWID_ConfidenceLevels,   	A_POWID_ConfidenceLevels-   	B_POWID_ConfidenceLevels},
{'PrePopStats',   				B_POWID_PrePopStats,   				A_POWID_PrePopStats,   				A_POWID_PrePopStats-   				B_POWID_PrePopStats},
{'PostPopStats',   				B_POWID_PostPopStats,   			A_POWID_PostPopStats,   			A_POWID_PostPopStats-   			B_POWID_PostPopStats},
{'ValidityStatistics',    B_POWID_ValidityStatistics,   A_POWID_ValidityStatistics,   A_POWID_ValidityStatistics-   B_POWID_ValidityStatistics},
{'IdConsistency0',   			B_POWID_IdConsistency0,   		A_POWID_IdConsistency0,   		A_POWID_IdConsistency0-   		B_POWID_IdConsistency0},
{'Result20',   						B_POWID_Result20,   					A_POWID_Result20,   					A_POWID_Result20-   					B_POWID_Result20},
{'Result21',   						B_POWID_Result21,   					A_POWID_Result21,   					A_POWID_Result21-   					B_POWID_Result21},
{'Result22',   						B_POWID_Result22,   					A_POWID_Result22,   					A_POWID_Result22-   					B_POWID_Result22},
{'Result23',   						B_POWID_Result23,   					A_POWID_Result23,   					A_POWID_Result23-   					B_POWID_Result23},
{'Result24',   						B_POWID_Result24,   					A_POWID_Result24,   					A_POWID_Result24-   					B_POWID_Result24},
{'Result25',   						B_POWID_Result25,   					A_POWID_Result25,   					A_POWID_Result25-   					B_POWID_Result25},
{'Result26',   						B_POWID_Result26,   					A_POWID_Result26,   					A_POWID_Result26-   					B_POWID_Result26},
{'Result27',   						B_POWID_Result27,   					A_POWID_Result27,   					A_POWID_Result27-   					B_POWID_Result27},
{'Result28',   						B_POWID_Result28,   					A_POWID_Result28,   					A_POWID_Result28-   					B_POWID_Result28},
   
{'MatchesPerformed',  			B_POWID_MatchesPerformed[1].RCount,  			A_POWID_MatchesPerformed[1].RCount,  			A_POWID_MatchesPerformed[1].RCount-  			B_POWID_MatchesPerformed[1].RCount},
{'BasicMatchesPerformed',  	B_POWID_BasicMatchesPerformed[1].RCount,  A_POWID_BasicMatchesPerformed[1].RCount,  A_POWID_BasicMatchesPerformed[1].RCount-  B_POWID_BasicMatchesPerformed[1].RCount},
{'SlicesPerformed',  				B_POWID_SlicesPerformed[1].RCount,  			A_POWID_SlicesPerformed[1].RCount,  			A_POWID_SlicesPerformed[1].RCount-  			B_POWID_SlicesPerformed[1].RCount},
{'TotalMatchSamples',  			B_POWID_TotalMatchSamples[1].RCount,  		A_POWID_TotalMatchSamples[1].RCount,  		A_POWID_TotalMatchSamples[1].RCount-  		B_POWID_TotalMatchSamples[1].RCount},
{'TotalMatchSamplesEqualToThreshold',  B_POWID_TotalMatchSamplesEqualToThreshold[1].RCount,  A_POWID_TotalMatchSamplesEqualToThreshold[1].RCount,  A_POWID_TotalMatchSamplesEqualToThreshold[1].RCount-  B_POWID_TotalMatchSamplesEqualToThreshold[1].RCount},
{'TotalMatchSamplesGreaterThanThreshold',  B_POWID_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_POWID_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_POWID_TotalMatchSamplesGreaterThanThreshold[1].RCount-  B_POWID_TotalMatchSamplesGreaterThanThreshold[1].RCount}
],Summary_Rec); 

//-----ProxSpec
B_ProxSpec_Result1	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 1');
A_ProxSpec_Result1	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 1');
B_ProxSpec_Result2	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 2');
A_ProxSpec_Result2	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 2');
B_ProxSpec_Result3	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 3');
A_ProxSpec_Result3	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 3');
B_ProxSpec_Result4	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 4');
A_ProxSpec_Result4	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 4');
B_ProxSpec_Result5	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 5');
A_ProxSpec_Result5	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 5');
B_ProxSpec_Result6	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 6');
A_ProxSpec_Result6	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 6');
B_ProxSpec_Result7	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 7');
A_ProxSpec_Result7	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 7');
B_ProxSpec_Result8	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 8');
A_ProxSpec_Result8	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 8');
B_ProxSpec_Result9	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 9');
A_ProxSpec_Result9	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 9');
B_ProxSpec_Result10	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 10');
A_ProxSpec_Result10	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 10');
B_ProxSpec_Result11	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 11');
A_ProxSpec_Result11	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 11');
B_ProxSpec_Result12	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 12');
A_ProxSpec_Result12	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 12');

B_ProxSpec_Result13	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 13');
A_ProxSpec_Result13	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 13');
B_ProxSpec_Result14	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 14');
A_ProxSpec_Result14	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 14');
B_ProxSpec_Result15	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 15');
A_ProxSpec_Result15	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 15');
B_ProxSpec_Result16	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 16');
A_ProxSpec_Result16	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 16');
B_ProxSpec_Result17	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 17');
A_ProxSpec_Result17	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 17');
B_ProxSpec_Result18	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 18');
A_ProxSpec_Result18	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 18');

B_ProxSpec_Result19	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 19');
A_ProxSpec_Result19	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 19');
B_ProxSpec_Result20	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 20');
A_ProxSpec_Result20	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 20');
B_ProxSpec_Result21	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 21');
A_ProxSpec_Result21	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 21');
B_ProxSpec_Result22	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 22');
A_ProxSpec_Result22	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 22');
B_ProxSpec_Result23	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 23');
A_ProxSpec_Result23	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 23');
B_ProxSpec_Result24	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 24');
A_ProxSpec_Result24	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 24');

B_ProxSpec_Result25	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 25');
A_ProxSpec_Result25	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 25');
B_ProxSpec_Result26	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 26');
A_ProxSpec_Result26	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 26');
B_ProxSpec_Result27	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 27');
A_ProxSpec_Result27	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 27');
B_ProxSpec_Result28	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Result 28');
A_ProxSpec_Result28	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Result 28');

B_ProxSpec_Specificities	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'Specificities');
A_ProxSpec_Specificities	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'Specificities');
B_ProxSpec_SpcShift	:=wk_ut.get_DS_Count(WU_ProxSpec_Before,'SpcShift');
A_ProxSpec_SpcShift	:=wk_ut.get_DS_Count(WU_ProxSpec_After,'SpcShift');

Shared ProxSpec_ds :=dataset([
{'Result1',   						B_ProxSpec_Result1,   					A_ProxSpec_Result1,   					A_ProxSpec_Result1-   					B_ProxSpec_Result1},
{'Result2',   						B_ProxSpec_Result2,   					A_ProxSpec_Result2,   					A_ProxSpec_Result2-   					B_ProxSpec_Result2},
{'Result3',   						B_ProxSpec_Result3,   					A_ProxSpec_Result3,   					A_ProxSpec_Result3-   					B_ProxSpec_Result3},
{'Result4',   						B_ProxSpec_Result4,   					A_ProxSpec_Result4,   					A_ProxSpec_Result4-   					B_ProxSpec_Result4},
{'Result5',   						B_ProxSpec_Result5,   					A_ProxSpec_Result5,   					A_ProxSpec_Result5-   					B_ProxSpec_Result5},
{'Result6',   						B_ProxSpec_Result6,   					A_ProxSpec_Result6,   					A_ProxSpec_Result6-   					B_ProxSpec_Result6},
{'Result7',   						B_ProxSpec_Result7,   					A_ProxSpec_Result7,   					A_ProxSpec_Result7-   					B_ProxSpec_Result7},
{'Result8',   						B_ProxSpec_Result8,   					A_ProxSpec_Result8,   					A_ProxSpec_Result8-   					B_ProxSpec_Result8},
{'Result9',   						B_ProxSpec_Result9,   					A_ProxSpec_Result9,   					A_ProxSpec_Result9-   					B_ProxSpec_Result9},
{'Result10',   						B_ProxSpec_Result10,   				A_ProxSpec_Result10,   				A_ProxSpec_Result10-   				B_ProxSpec_Result10},
{'Result11',   						B_ProxSpec_Result11,   				A_ProxSpec_Result11,   				A_ProxSpec_Result11-   				B_ProxSpec_Result11},
{'Result12',   						B_ProxSpec_Result12,   				A_ProxSpec_Result12,   				A_ProxSpec_Result12-   				B_ProxSpec_Result12},
{'Result13',   						B_ProxSpec_Result13,   				A_ProxSpec_Result13,   				A_ProxSpec_Result13-   				B_ProxSpec_Result13},
{'Result14',   						B_ProxSpec_Result14,   				A_ProxSpec_Result14,   				A_ProxSpec_Result14-   				B_ProxSpec_Result14},
{'Result15',   						B_ProxSpec_Result15,   				A_ProxSpec_Result15,   				A_ProxSpec_Result15-   				B_ProxSpec_Result15},
{'Result16',   						B_ProxSpec_Result16,   				A_ProxSpec_Result16,   				A_ProxSpec_Result16-   				B_ProxSpec_Result16},
{'Result17',   						B_ProxSpec_Result17,   				A_ProxSpec_Result17,   				A_ProxSpec_Result17-   				B_ProxSpec_Result17},
{'Result18',   						B_ProxSpec_Result18,   				A_ProxSpec_Result18,   				A_ProxSpec_Result18-   				B_ProxSpec_Result18},
{'Result19',   						B_ProxSpec_Result19,   				A_ProxSpec_Result19,   				A_ProxSpec_Result19-   				B_ProxSpec_Result19},
{'Result20',   						B_ProxSpec_Result20,   				A_ProxSpec_Result20,   				A_ProxSpec_Result20-   				B_ProxSpec_Result20},
{'Result21',   						B_ProxSpec_Result21,   				A_ProxSpec_Result21,   				A_ProxSpec_Result21-   				B_ProxSpec_Result21},
{'Result22',   						B_ProxSpec_Result22,   				A_ProxSpec_Result22,   				A_ProxSpec_Result22-   				B_ProxSpec_Result22},
{'Result23',   						B_ProxSpec_Result23,   				A_ProxSpec_Result23,   				A_ProxSpec_Result23-   				B_ProxSpec_Result23},
{'Result24',   						B_ProxSpec_Result24,   				A_ProxSpec_Result24,   				A_ProxSpec_Result24-   				B_ProxSpec_Result24},
{'Result25',   						B_ProxSpec_Result25,   				A_ProxSpec_Result25,   				A_ProxSpec_Result25-   				B_ProxSpec_Result25},
{'Result26',   						B_ProxSpec_Result26,   				A_ProxSpec_Result26,   				A_ProxSpec_Result26-   				B_ProxSpec_Result26},
{'Result27',   						B_ProxSpec_Result27,   				A_ProxSpec_Result27,   				A_ProxSpec_Result27-   				B_ProxSpec_Result27},
{'Result28',   						B_ProxSpec_Result28,   				A_ProxSpec_Result28,   				A_ProxSpec_Result28-   				B_ProxSpec_Result28},
{'SpcShift',   						B_ProxSpec_SpcShift,   			  A_ProxSpec_SpcShift,   			  A_ProxSpec_SpcShift-   		  	B_ProxSpec_SpcShift},
{'Specificities',   			B_ProxSpec_Specificities,   	  A_ProxSpec_Specificities,     	A_ProxSpec_Specificities-    	B_ProxSpec_Specificities}
],Summary_Rec);


//-----Mj6Spec 
B_Mj6Spec_Result1	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 1');
A_Mj6Spec_Result1	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 1');
B_Mj6Spec_Result2	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 2');
A_Mj6Spec_Result2	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 2');
B_Mj6Spec_Result3	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 3');
A_Mj6Spec_Result3	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 3');
B_Mj6Spec_Result4	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 4');
A_Mj6Spec_Result4	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 4');
B_Mj6Spec_Result5	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 5');
A_Mj6Spec_Result5	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 5');
B_Mj6Spec_Result6	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 6');
A_Mj6Spec_Result6	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 6');
B_Mj6Spec_Result7	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 7');
A_Mj6Spec_Result7	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 7');
B_Mj6Spec_Result8	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 8');
A_Mj6Spec_Result8	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 8');
B_Mj6Spec_Result9	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 9');
A_Mj6Spec_Result9	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 9');
B_Mj6Spec_Result10	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 10');
A_Mj6Spec_Result10	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 10');
B_Mj6Spec_Result11	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 11');
A_Mj6Spec_Result11	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 11');
B_Mj6Spec_Result12	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 12');
A_Mj6Spec_Result12	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 12');

B_Mj6Spec_Result13	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 13');
A_Mj6Spec_Result13	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 13');
B_Mj6Spec_Result14	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 14');
A_Mj6Spec_Result14	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 14');
B_Mj6Spec_Result15	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 15');
A_Mj6Spec_Result15	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 15');
B_Mj6Spec_Result16	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 16');
A_Mj6Spec_Result16	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 16');
B_Mj6Spec_Result17	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 17');
A_Mj6Spec_Result17	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 17');
B_Mj6Spec_Result18	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 18');
A_Mj6Spec_Result18	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 18');

B_Mj6Spec_Result19	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 19');
A_Mj6Spec_Result19	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 19');
B_Mj6Spec_Result20	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 20');
A_Mj6Spec_Result20	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 20');
B_Mj6Spec_Result21	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 21');
A_Mj6Spec_Result21	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 21');
B_Mj6Spec_Result22	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 22');
A_Mj6Spec_Result22	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 22');
B_Mj6Spec_Result23	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 23');
A_Mj6Spec_Result23	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 23');
B_Mj6Spec_Result24	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Result 24');
A_Mj6Spec_Result24	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Result 24');

B_Mj6Spec_Specificities	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'Specificities');
A_Mj6Spec_Specificities	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'Specificities');
B_Mj6Spec_SpcShift	:=wk_ut.get_DS_Count(WU_Mj6Spec_Before,'SpcShift');
A_Mj6Spec_SpcShift	:=wk_ut.get_DS_Count(WU_Mj6Spec_After,'SpcShift');

Shared Mj6Spec_ds :=dataset([
{'Result1',   						B_Mj6Spec_Result1,   					A_Mj6Spec_Result1,   					A_Mj6Spec_Result1-   					B_Mj6Spec_Result1},
{'Result2',   						B_Mj6Spec_Result2,   					A_Mj6Spec_Result2,   					A_Mj6Spec_Result2-   					B_Mj6Spec_Result2},
{'Result3',   						B_Mj6Spec_Result3,   					A_Mj6Spec_Result3,   					A_Mj6Spec_Result3-   					B_Mj6Spec_Result3},
{'Result4',   						B_Mj6Spec_Result4,   					A_Mj6Spec_Result4,   					A_Mj6Spec_Result4-   					B_Mj6Spec_Result4},
{'Result5',   						B_Mj6Spec_Result5,   					A_Mj6Spec_Result5,   					A_Mj6Spec_Result5-   					B_Mj6Spec_Result5},
{'Result6',   						B_Mj6Spec_Result6,   					A_Mj6Spec_Result6,   					A_Mj6Spec_Result6-   					B_Mj6Spec_Result6},
{'Result7',   						B_Mj6Spec_Result7,   					A_Mj6Spec_Result7,   					A_Mj6Spec_Result7-   					B_Mj6Spec_Result7},
{'Result8',   						B_Mj6Spec_Result8,   					A_Mj6Spec_Result8,   					A_Mj6Spec_Result8-   					B_Mj6Spec_Result8},
{'Result9',   						B_Mj6Spec_Result9,   					A_Mj6Spec_Result9,   					A_Mj6Spec_Result9-   					B_Mj6Spec_Result9},
{'Result10',   						B_Mj6Spec_Result10,   				A_Mj6Spec_Result10,   				A_Mj6Spec_Result10-   				B_Mj6Spec_Result10},
{'Result11',   						B_Mj6Spec_Result11,   				A_Mj6Spec_Result11,   				A_Mj6Spec_Result11-   				B_Mj6Spec_Result11},
{'Result12',   						B_Mj6Spec_Result12,   				A_Mj6Spec_Result12,   				A_Mj6Spec_Result12-   				B_Mj6Spec_Result12},
{'Result13',   						B_Mj6Spec_Result13,   				A_Mj6Spec_Result13,   				A_Mj6Spec_Result13-   				B_Mj6Spec_Result13},
{'Result14',   						B_Mj6Spec_Result14,   				A_Mj6Spec_Result14,   				A_Mj6Spec_Result14-   				B_Mj6Spec_Result14},
{'Result15',   						B_Mj6Spec_Result15,   				A_Mj6Spec_Result15,   				A_Mj6Spec_Result15-   				B_Mj6Spec_Result15},
{'Result16',   						B_Mj6Spec_Result16,   				A_Mj6Spec_Result16,   				A_Mj6Spec_Result16-   				B_Mj6Spec_Result16},
{'Result17',   						B_Mj6Spec_Result17,   				A_Mj6Spec_Result17,   				A_Mj6Spec_Result17-   				B_Mj6Spec_Result17},
{'Result18',   						B_Mj6Spec_Result18,   				A_Mj6Spec_Result18,   				A_Mj6Spec_Result18-   				B_Mj6Spec_Result18},
{'Result19',   						B_Mj6Spec_Result19,   				A_Mj6Spec_Result19,   				A_Mj6Spec_Result19-   				B_Mj6Spec_Result19},
{'Result20',   						B_Mj6Spec_Result20,   				A_Mj6Spec_Result20,   				A_Mj6Spec_Result20-   				B_Mj6Spec_Result20},
{'Result21',   						B_Mj6Spec_Result21,   				A_Mj6Spec_Result21,   				A_Mj6Spec_Result21-   				B_Mj6Spec_Result21},
{'Result22',   						B_Mj6Spec_Result22,   				A_Mj6Spec_Result22,   				A_Mj6Spec_Result22-   				B_Mj6Spec_Result22},
{'Result23',   						B_Mj6Spec_Result23,   				A_Mj6Spec_Result23,   				A_Mj6Spec_Result23-   				B_Mj6Spec_Result23},
{'Result24',   						B_Mj6Spec_Result24,   				A_Mj6Spec_Result24,   				A_Mj6Spec_Result24-   				B_Mj6Spec_Result24},
{'SpcShift',   						B_Mj6Spec_SpcShift,   			  A_Mj6Spec_SpcShift,   			  A_Mj6Spec_SpcShift-   		  	B_Mj6Spec_SpcShift},
{'Specificities',   			B_Mj6Spec_Specificities,   	  A_Mj6Spec_Specificities,     	A_Mj6Spec_Specificities-    	B_Mj6Spec_Specificities}
],Summary_Rec); 

//DotID iteration part:
B_DotID_PossibleCleaves	:=wk_ut.get_DS_Count(WU_DotID_Before,'PossibleCleaves');
A_DotID_PossibleCleaves	:=wk_ut.get_DS_Count(WU_DotID_After,'PossibleCleaves');
B_DotID_CandidateCleaves	:=wk_ut.get_DS_Count(WU_DotID_Before,'CandidateCleaves');
A_DotID_CandidateCleaves	:=wk_ut.get_DS_Count(WU_DotID_After,'CandidateCleaves');
B_DotID_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_DotID_Before,'MatchSampleRecords');
A_DotID_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_DotID_After,'MatchSampleRecords');
B_DotID_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_DotID_Before,'SliceOutCandidates');//
A_DotID_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_DotID_After,'SliceOutCandidates');
B_DotID_Specificities	:=wk_ut.get_DS_Count(WU_DotID_Before,'Specificities');//
A_DotID_Specificities	:=wk_ut.get_DS_Count(WU_DotID_After,'Specificities');
B_DotID_SPCShift	:=wk_ut.get_DS_Count(WU_DotID_Before,'SPCShift');//
A_DotID_SPCShift	:=wk_ut.get_DS_Count(WU_DotID_After,'SPCShift');
B_DotID_PreClusters	:=wk_ut.get_DS_Count(WU_DotID_Before,'PreClusters');//
A_DotID_PreClusters	:=wk_ut.get_DS_Count(WU_DotID_After,'PreClusters');
B_DotID_PostClusters	:=wk_ut.get_DS_Count(WU_DotID_Before,'PostClusters');//
A_DotID_PostClusters	:=wk_ut.get_DS_Count(WU_DotID_After,'PostClusters');
B_DotID_PreClusterCount	:=wk_ut.get_DS_Count(WU_DotID_Before,'PreClusterCount');//
A_DotID_PreClusterCount	:=wk_ut.get_DS_Count(WU_DotID_After,'PreClusterCount');
B_DotID_PostClusterCount	:=wk_ut.get_DS_Count(WU_DotID_Before,'PostClusterCount');//
A_DotID_PostClusterCount	:=wk_ut.get_DS_Count(WU_DotID_After,'PostClusterCount');
B_DotID_RuleEfficacy	:=wk_ut.get_DS_Count(WU_DotID_Before,'RuleEfficacy');//
A_DotID_RuleEfficacy	:=wk_ut.get_DS_Count(WU_DotID_After,'RuleEfficacy');
B_DotID_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_DotID_Before,'ConfidenceLevels');//
A_DotID_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_DotID_After,'ConfidenceLevels');
B_DotID_PrePopStats	:=wk_ut.get_DS_Count(WU_DotID_Before,'PrePopStats');//
A_DotID_PrePopStats	:=wk_ut.get_DS_Count(WU_DotID_After,'PrePopStats');
B_DotID_PostPopStats	:=wk_ut.get_DS_Count(WU_DotID_Before,'PostPopStats');//
A_DotID_PostPopStats	:=wk_ut.get_DS_Count(WU_DotID_After,'PostPopStats');
B_DotID_ValidityStatistics	:=wk_ut.get_DS_Count(WU_DotID_Before,'ValidityStatistics');//
A_DotID_ValidityStatistics	:=wk_ut.get_DS_Count(WU_DotID_After,'ValidityStatistics');
B_DotID_IdConsistency0	:=wk_ut.get_DS_Count(WU_DotID_Before,'IdConsistency0');//
A_DotID_IdConsistency0	:=wk_ut.get_DS_Count(WU_DotID_After,'IdConsistency0');
B_DotID_Result1	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 1');
A_DotID_Result1	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 1');
B_DotID_Result2	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 2');
A_DotID_Result2	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 2');
B_DotID_Result3	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 3');
A_DotID_Result3	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 3');
B_DotID_Result4	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 4');
A_DotID_Result4	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 4');
B_DotID_Result5	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 5');
A_DotID_Result5	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 5');
B_DotID_Result6	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 6');
A_DotID_Result6	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 6');
B_DotID_Result29	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 29');
A_DotID_Result29	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 29');
B_DotID_Result30	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 30');
A_DotID_Result30	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 30');
B_DotID_Result31	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 31');
A_DotID_Result31	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 31');
B_DotID_Result32	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 32');
A_DotID_Result32	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 32');
B_DotID_Result33	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 33');
A_DotID_Result33	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 33');
B_DotID_Result34	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 34');
A_DotID_Result34	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 34');
B_DotID_Result35	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 35');
A_DotID_Result35	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 35');
B_DotID_Result36	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 36');
A_DotID_Result36	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 36');
B_DotID_Result37	:=wk_ut.get_DS_Count(WU_DotID_Before,'Result 37');
A_DotID_Result37	:=wk_ut.get_DS_Count(WU_DotID_After,'Result 37');


B_DotID_DOTidsCreatedByCleave	:=Dataset(WorkUnit(WU_DotID_Before,'DOTidsCreatedByCleave'),TotalRecordCount_rec);//
A_DotID_DOTidsCreatedByCleave	:=Dataset(WorkUnit(WU_DotID_After,'DOTidsCreatedByCleave'),TotalRecordCount_rec);
B_DotID_MatchesPerformed	:=Dataset(WorkUnit(WU_DotID_Before,'MatchesPerformed'),TotalRecordCount_rec);//
A_DotID_MatchesPerformed	:=Dataset(WorkUnit(WU_DotID_After,'MatchesPerformed'),TotalRecordCount_rec);
B_DotID_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_DotID_Before,'BasicMatchesPerformed'),TotalRecordCount_rec);//
A_DotID_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_DotID_After,'BasicMatchesPerformed'),TotalRecordCount_rec);
B_DotID_SlicesPerformed	:=Dataset(WorkUnit(WU_DotID_Before,'SlicesPerformed'),TotalRecordCount_rec);//
A_DotID_SlicesPerformed	:=Dataset(WorkUnit(WU_DotID_After,'SlicesPerformed'),TotalRecordCount_rec);
B_DotID_TotalMatchSamples	:=Dataset(WorkUnit(WU_DotID_Before,'TotalMatchSamples'),TotalRecordCount_rec);//
A_DotID_TotalMatchSamples	:=Dataset(WorkUnit(WU_DotID_After,'TotalMatchSamples'),TotalRecordCount_rec);
B_DotID_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_DotID_Before,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);//
A_DotID_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_DotID_After,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);
B_DotID_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_DotID_Before,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);//
A_DotID_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_DotID_After,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);

Shared DotID_ds :=dataset([
{'PossibleCleaves',B_DotID_PossibleCleaves, A_DotID_PossibleCleaves, A_DotID_PossibleCleaves-B_DotID_PossibleCleaves},
{'CandidateCleaves',B_DotID_CandidateCleaves, A_DotID_CandidateCleaves, A_DotID_CandidateCleaves-B_DotID_CandidateCleaves},
{'MatchSampleRecords', 		B_DotID_MatchSampleRecords, 	A_DotID_MatchSampleRecords, 	A_DotID_MatchSampleRecords- 	B_DotID_MatchSampleRecords},
{'SliceOutCandidates', 		B_DotID_SliceOutCandidates,   A_DotID_SliceOutCandidates,   A_DotID_SliceOutCandidates-   B_DotID_SliceOutCandidates},
{'Specificities',   			B_DotID_Specificities,   			A_DotID_Specificities,  	 		A_DotID_Specificities-   			B_DotID_Specificities},//
{'SPCShift',   						B_DotID_SPCShift,   					A_DotID_SPCShift,   					A_DotID_SPCShift-   					B_DotID_SPCShift},
{'PreClusters',   				B_DotID_PreClusters,   				A_DotID_PreClusters,   				A_DotID_PreClusters-   				B_DotID_PreClusters},
{'PostClusters',   				B_DotID_PostClusters,   			A_DotID_PostClusters,   			A_DotID_PostClusters-   			B_DotID_PostClusters},
{'PreClusterCount',   		B_DotID_PreClusterCount,   		A_DotID_PreClusterCount,   		A_DotID_PreClusterCount-   		B_DotID_PreClusterCount},
{'PostClusterCount',   		B_DotID_PostClusterCount,   	A_DotID_PostClusterCount,   	A_DotID_PostClusterCount-   	B_DotID_PostClusterCount},
{'RuleEfficacy',   				B_DotID_RuleEfficacy,   			A_DotID_RuleEfficacy,   			A_DotID_RuleEfficacy-   			B_DotID_RuleEfficacy},
{'ConfidenceLevels',   		B_DotID_ConfidenceLevels,   	A_DotID_ConfidenceLevels,   	A_DotID_ConfidenceLevels-   	B_DotID_ConfidenceLevels},
{'PrePopStats',   				B_DotID_PrePopStats,   				A_DotID_PrePopStats,   				A_DotID_PrePopStats-   				B_DotID_PrePopStats},
{'PostPopStats',   				B_DotID_PostPopStats,   			A_DotID_PostPopStats,   			A_DotID_PostPopStats-   			B_DotID_PostPopStats},
{'ValidityStatistics',    B_DotID_ValidityStatistics,   A_DotID_ValidityStatistics,   A_DotID_ValidityStatistics-   B_DotID_ValidityStatistics},
{'IdConsistency0',   			B_DotID_IdConsistency0,   		A_DotID_IdConsistency0,   		A_DotID_IdConsistency0-   		B_DotID_IdConsistency0},
{'Result1',   						B_DotID_Result1,   					A_DotID_Result1,   					A_DotID_Result1-   					B_DotID_Result1},
{'Result2',   						B_DotID_Result2,   					A_DotID_Result2,   					A_DotID_Result2-   					B_DotID_Result2},
{'Result3',   						B_DotID_Result3,   					A_DotID_Result3,   					A_DotID_Result3-   					B_DotID_Result3},
{'Result4',   						B_DotID_Result4,   					A_DotID_Result4,   					A_DotID_Result4-   					B_DotID_Result4},
{'Result5',   						B_DotID_Result5,   					A_DotID_Result5,   					A_DotID_Result5-   					B_DotID_Result5},
{'Result6',   						B_DotID_Result6,   					A_DotID_Result6,   					A_DotID_Result6-   					B_DotID_Result6},
{'Result29',   						B_DotID_Result29,   					A_DotID_Result29,   					A_DotID_Result29-   					B_DotID_Result29},
{'Result30',   						B_DotID_Result30,   					A_DotID_Result30,   					A_DotID_Result30-   					B_DotID_Result30},
{'Result31',   						B_DotID_Result31,   					A_DotID_Result31,   					A_DotID_Result31-   					B_DotID_Result31},
{'Result32',   						B_DotID_Result32,   					A_DotID_Result32,   					A_DotID_Result32-   					B_DotID_Result32},
{'Result33',   						B_DotID_Result33,   					A_DotID_Result33,   					A_DotID_Result33-   					B_DotID_Result33},
{'Result34',   						B_DotID_Result34,   					A_DotID_Result34,   					A_DotID_Result34-   					B_DotID_Result34},
{'Result35',   						B_DotID_Result35,   					A_DotID_Result35,   					A_DotID_Result35-   					B_DotID_Result35},
{'Result36',   						B_DotID_Result36,   					A_DotID_Result36,   					A_DotID_Result36-   					B_DotID_Result36},
{'Result37',   						B_DotID_Result37,   					A_DotID_Result37,   					A_DotID_Result37-   					B_DotID_Result37},
   
{'DOTidsCreatedByCleave', B_DotID_DOTidsCreatedByCleave[1].RCount, A_DotID_DOTidsCreatedByCleave[1].RCount,  A_DotID_DOTidsCreatedByCleave[1].RCount-  			B_DotID_DOTidsCreatedByCleave[1].RCount},   
{'MatchesPerformed',  			B_DotID_MatchesPerformed[1].RCount,  			A_DotID_MatchesPerformed[1].RCount,  			A_DotID_MatchesPerformed[1].RCount-  			B_DotID_MatchesPerformed[1].RCount},
{'BasicMatchesPerformed',  	B_DotID_BasicMatchesPerformed[1].RCount,  A_DotID_BasicMatchesPerformed[1].RCount,  A_DotID_BasicMatchesPerformed[1].RCount-  B_DotID_BasicMatchesPerformed[1].RCount},
{'SlicesPerformed',  				B_DotID_SlicesPerformed[1].RCount,  			A_DotID_SlicesPerformed[1].RCount,  			A_DotID_SlicesPerformed[1].RCount-  			B_DotID_SlicesPerformed[1].RCount},
{'TotalMatchSamples',  			B_DotID_TotalMatchSamples[1].RCount,  		A_DotID_TotalMatchSamples[1].RCount,  		A_DotID_TotalMatchSamples[1].RCount-  		B_DotID_TotalMatchSamples[1].RCount},
{'TotalMatchSamplesEqualToThreshold',  B_DotID_TotalMatchSamplesEqualToThreshold[1].RCount,  A_DotID_TotalMatchSamplesEqualToThreshold[1].RCount,  A_DotID_TotalMatchSamplesEqualToThreshold[1].RCount-  B_DotID_TotalMatchSamplesEqualToThreshold[1].RCount},
{'TotalMatchSamplesGreaterThanThreshold',  B_DotID_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_DotID_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_DotID_TotalMatchSamplesGreaterThanThreshold[1].RCount-  B_DotID_TotalMatchSamplesGreaterThanThreshold[1].RCount}
],Summary_Rec); 

//Hrchy iteration Part:
B_Hrchy_Result1	:=wk_ut.get_DS_Count(WU_Hrchy_Before,'Result 1');
A_Hrchy_Result1	:=wk_ut.get_DS_Count(WU_Hrchy_After,'Result 1');
B_Hrchy_StatData_BIPV2_Hrchy_Infile_IDCheck	:=wk_ut.get_DS_Count(WU_Hrchy_Before,'StatData_BIPV2_Hrchy_Infile_IDCheck');
A_Hrchy_StatData_BIPV2_Hrchy_Infile_IDCheck	:=wk_ut.get_DS_Count(WU_Hrchy_After,'StatData_BIPV2_Hrchy_Infile_IDCheck');
B_Hrchy_SubmitStatError_BIPV2_Hrchy_Infile_IDCheck	:=wk_ut.get_DS_Count(WU_Hrchy_Before,'SubmitStatError_BIPV2_Hrchy_Infile_IDCheck');
A_Hrchy_SubmitStatError_BIPV2_Hrchy_Infile_IDCheck	:=wk_ut.get_DS_Count(WU_Hrchy_After,'SubmitStatError_BIPV2_Hrchy_Infile_IDCheck');
B_Hrchy_sample_hrchy_sele_proxid_disagree_with_is_sele	:=wk_ut.get_DS_Count(WU_Hrchy_Before,'sample_hrchy_sele_proxid_disagree_with_is_sele');
A_Hrchy_sample_hrchy_sele_proxid_disagree_with_is_sele	:=wk_ut.get_DS_Count(WU_Hrchy_After,'sample_hrchy_sele_proxid_disagree_with_is_sele');
//B_Hrchy_	:=wk_ut.get_DS_Count(WU_Hrchy_Before,'');
//A_Hrchy_	:=wk_ut.get_DS_Count(WU_Hrchy_After,'');

B_Hrchy_count_records_has_lgid	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_records_has_lgid'),TotalRecordCount_rec);//
A_Hrchy_count_records_has_lgid	:=Dataset(WorkUnit(WU_Hrchy_After,'count_records_has_lgid'),TotalRecordCount_rec);
B_Hrchy_count_proxids_has_lgid	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_proxids_has_lgid'),TotalRecordCount_rec);//
A_Hrchy_count_proxids_has_lgid	:=Dataset(WorkUnit(WU_Hrchy_After,'count_proxids_has_lgid'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_proxids_has_lgid	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_proxids_has_lgid'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_proxids_has_lgid	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_proxids_has_lgid'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_proxids_is_ult_level	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_proxids_is_ult_level'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_proxids_is_ult_level	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_proxids_is_ult_level'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_proxids_is_org_level	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_proxids_is_org_level'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_proxids_is_org_level	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_proxids_is_org_level'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_proxids_is_sele_level	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_proxids_is_sele_level'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_proxids_is_sele_level	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_proxids_is_sele_level'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_proxids_has_parent_proxid	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_proxids_has_parent_proxid'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_proxids_has_parent_proxid	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_proxids_has_parent_proxid'),TotalRecordCount_rec);
B_Hrchy_sum_hrchy_total_nodes	:=Dataset(WorkUnit(WU_Hrchy_Before,'sum_hrchy_total_nodes'),TotalRecordCount_rec);//
A_Hrchy_sum_hrchy_total_nodes	:=Dataset(WorkUnit(WU_Hrchy_After,'sum_hrchy_total_nodes'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_sele_proxid_disagree_with_is_sele	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_sele_proxid_disagree_with_is_sele'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_sele_proxid_disagree_with_is_sele	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_sele_proxid_disagree_with_is_sele'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_UltIDs	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_UltIDs'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_UltIDs	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_UltIDs'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_OrgIDs	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_OrgIDs'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_OrgIDs	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_OrgIDs'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_SELEIDs	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_SELEIDs'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_SELEIDs	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_SELEIDs'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_UltIDs_contain_matching_OrgID	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_UltIDs_contain_matching_OrgID'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_UltIDs_contain_matching_OrgID	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_UltIDs_contain_matching_OrgID'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_OrgIDs_contain_matching_SELEID	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_OrgIDs_contain_matching_SELEID'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_OrgIDs_contain_matching_SELEID	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_OrgIDs_contain_matching_SELEID'),TotalRecordCount_rec);
B_Hrchy_count_hrchy_SELEIDs_contain_matching_ProxID	:=Dataset(WorkUnit(WU_Hrchy_Before,'count_hrchy_SELEIDs_contain_matching_ProxID'),TotalRecordCount_rec);//
A_Hrchy_count_hrchy_SELEIDs_contain_matching_ProxID	:=Dataset(WorkUnit(WU_Hrchy_After,'count_hrchy_SELEIDs_contain_matching_ProxID'),TotalRecordCount_rec);
//B_Hrchy_	:=Dataset(WorkUnit(WU_Hrchy_Before,''),TotalRecordCount_rec);
//A_Hrchy_	:=Dataset(WorkUnit(WU_Hrchy_After,''),TotalRecordCount_rec);

Shared Hrchy_ds :=dataset([
{'StatData_BIPV2_Hrchy_Infile_IDCheck', 		B_Hrchy_StatData_BIPV2_Hrchy_Infile_IDCheck, 	A_Hrchy_StatData_BIPV2_Hrchy_Infile_IDCheck, 	A_Hrchy_StatData_BIPV2_Hrchy_Infile_IDCheck- 	B_Hrchy_StatData_BIPV2_Hrchy_Infile_IDCheck},
{'SubmitStatError_BIPV2_Hrchy_Infile_IDCheck', 		B_Hrchy_SubmitStatError_BIPV2_Hrchy_Infile_IDCheck, 	A_Hrchy_SubmitStatError_BIPV2_Hrchy_Infile_IDCheck, 	A_Hrchy_SubmitStatError_BIPV2_Hrchy_Infile_IDCheck- 	B_Hrchy_SubmitStatError_BIPV2_Hrchy_Infile_IDCheck},
{'sample_hrchy_sele_proxid_disagree_with_is_sele', 		B_Hrchy_sample_hrchy_sele_proxid_disagree_with_is_sele, 	A_Hrchy_sample_hrchy_sele_proxid_disagree_with_is_sele, 	A_Hrchy_sample_hrchy_sele_proxid_disagree_with_is_sele- 	B_Hrchy_sample_hrchy_sele_proxid_disagree_with_is_sele},
{'Result1',   						B_Hrchy_Result1,   					A_Hrchy_Result1,   					A_Hrchy_Result1-   					B_Hrchy_Result1},
   
{'count_records_has_lgid',  B_Hrchy_count_records_has_lgid[1].RCount,  		A_Hrchy_count_records_has_lgid[1].RCount,  		A_Hrchy_count_records_has_lgid[1].RCount-  		B_Hrchy_count_records_has_lgid[1].RCount},
{'count_proxids_has_lgid',  B_Hrchy_count_proxids_has_lgid[1].RCount,  		A_Hrchy_count_proxids_has_lgid[1].RCount,  		A_Hrchy_count_proxids_has_lgid[1].RCount-  		B_Hrchy_count_proxids_has_lgid[1].RCount},
{'count_hrchy_proxids_has_lgid',  			B_Hrchy_count_hrchy_proxids_has_lgid[1].RCount,  			A_Hrchy_count_hrchy_proxids_has_lgid[1].RCount,  			A_Hrchy_count_hrchy_proxids_has_lgid[1].RCount-  			B_Hrchy_count_hrchy_proxids_has_lgid[1].RCount},
{'count_hrchy_proxids_is_ult_level',  	B_Hrchy_count_hrchy_proxids_is_ult_level[1].RCount,  	A_Hrchy_count_hrchy_proxids_is_ult_level[1].RCount,  	A_Hrchy_count_hrchy_proxids_is_ult_level[1].RCount-  	B_Hrchy_count_hrchy_proxids_is_ult_level[1].RCount},
{'count_hrchy_proxids_is_org_level',  	B_Hrchy_count_hrchy_proxids_is_org_level[1].RCount,  	A_Hrchy_count_hrchy_proxids_is_org_level[1].RCount,  	A_Hrchy_count_hrchy_proxids_is_org_level[1].RCount-  	B_Hrchy_count_hrchy_proxids_is_org_level[1].RCount},
{'count_hrchy_proxids_is_sele_level',  	B_Hrchy_count_hrchy_proxids_is_sele_level[1].RCount,  A_Hrchy_count_hrchy_proxids_is_sele_level[1].RCount,  A_Hrchy_count_hrchy_proxids_is_sele_level[1].RCount-  B_Hrchy_count_hrchy_proxids_is_sele_level[1].RCount},
{'count_hrchy_proxids_has_parent_proxid',B_Hrchy_count_hrchy_proxids_has_parent_proxid[1].RCount,A_Hrchy_count_hrchy_proxids_has_parent_proxid[1].RCount,A_Hrchy_count_hrchy_proxids_has_parent_proxid[1].RCount-B_Hrchy_count_hrchy_proxids_has_parent_proxid[1].RCount},
{'sum_hrchy_total_nodes',  	B_Hrchy_sum_hrchy_total_nodes[1].RCount,  		A_Hrchy_sum_hrchy_total_nodes[1].RCount,  		A_Hrchy_sum_hrchy_total_nodes[1].RCount-  		B_Hrchy_sum_hrchy_total_nodes[1].RCount},
{'count_hrchy_sele_proxid_disagree_with_is_sele',  			B_Hrchy_count_hrchy_sele_proxid_disagree_with_is_sele[1].RCount,A_Hrchy_count_hrchy_sele_proxid_disagree_with_is_sele[1].RCount,A_Hrchy_count_hrchy_sele_proxid_disagree_with_is_sele[1].RCount-B_Hrchy_count_hrchy_sele_proxid_disagree_with_is_sele[1].RCount},
{'count_hrchy_UltIDs',  		B_Hrchy_count_hrchy_UltIDs[1].RCount,  			A_Hrchy_count_hrchy_UltIDs[1].RCount,  			A_Hrchy_count_hrchy_UltIDs[1].RCount-  			B_Hrchy_count_hrchy_UltIDs[1].RCount},
{'count_hrchy_OrgIDs',  		B_Hrchy_count_hrchy_OrgIDs[1].RCount,  			A_Hrchy_count_hrchy_OrgIDs[1].RCount,  			A_Hrchy_count_hrchy_OrgIDs[1].RCount-  			B_Hrchy_count_hrchy_OrgIDs[1].RCount},
{'count_hrchy_SELEIDs',  		B_Hrchy_count_hrchy_SELEIDs[1].RCount,  		A_Hrchy_count_hrchy_SELEIDs[1].RCount,  		A_Hrchy_count_hrchy_SELEIDs[1].RCount-  		B_Hrchy_count_hrchy_SELEIDs[1].RCount},
{'count_hrchy_UltIDs_contain_matching_OrgID',  			B_Hrchy_count_hrchy_UltIDs_contain_matching_OrgID[1].RCount,  	A_Hrchy_count_hrchy_UltIDs_contain_matching_OrgID[1].RCount, A_Hrchy_count_hrchy_UltIDs_contain_matching_OrgID[1].RCount- B_Hrchy_count_hrchy_UltIDs_contain_matching_OrgID[1].RCount},
{'count_hrchy_OrgIDs_contain_matching_SELEID',  		B_Hrchy_count_hrchy_OrgIDs_contain_matching_SELEID[1].RCount,  	A_Hrchy_count_hrchy_OrgIDs_contain_matching_SELEID[1].RCount,A_Hrchy_count_hrchy_OrgIDs_contain_matching_SELEID[1].RCount-B_Hrchy_count_hrchy_OrgIDs_contain_matching_SELEID[1].RCount},
{'B_Hrchy_count_hrchy_SELEIDs_contain_matching_ProxID',  			B_Hrchy_count_hrchy_SELEIDs_contain_matching_ProxID[1].RCount,A_Hrchy_count_hrchy_SELEIDs_contain_matching_ProxID[1].RCount, A_Hrchy_count_hrchy_SELEIDs_contain_matching_ProxID[1].RCount-  B_Hrchy_count_hrchy_SELEIDs_contain_matching_ProxID[1].RCount}
],Summary_Rec); 

//PowIdDown iteration Part:
B_PowIdDown_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'MatchSampleRecords');
A_PowIdDown_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'MatchSampleRecords');
B_PowIdDown_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'SliceOutCandidates');//
A_PowIdDown_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'SliceOutCandidates');
B_PowIdDown_Specificities	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'Specificities');//
A_PowIdDown_Specificities	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'Specificities');
B_PowIdDown_SPCShift	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'SPCShift');//
A_PowIdDown_SPCShift	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'SPCShift');
B_PowIdDown_PreClusters	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'PreClusters');//
A_PowIdDown_PreClusters	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'PreClusters');
B_PowIdDown_PostClusters	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'PostClusters');//
A_PowIdDown_PostClusters	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'PostClusters');
B_PowIdDown_PreClusterCount	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'PreClusterCount');//
A_PowIdDown_PreClusterCount	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'PreClusterCount');
B_PowIdDown_PostClusterCount	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'PostClusterCount');//
A_PowIdDown_PostClusterCount	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'PostClusterCount');
B_PowIdDown_RuleEfficacy	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'RuleEfficacy');//
A_PowIdDown_RuleEfficacy	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'RuleEfficacy');
B_PowIdDown_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'ConfidenceLevels');//
A_PowIdDown_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'ConfidenceLevels');
B_PowIdDown_PrePopStats	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'PrePopStats');//
A_PowIdDown_PrePopStats	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'PrePopStats');
B_PowIdDown_PostPopStats	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'PostPopStats');//
A_PowIdDown_PostPopStats	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'PostPopStats');
B_PowIdDown_ValidityStatistics	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'ValidityStatistics');//
A_PowIdDown_ValidityStatistics	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'ValidityStatistics');
B_PowIdDown_IdConsistency0	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'IdConsistency0');//
A_PowIdDown_IdConsistency0	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'IdConsistency0');
B_PowIdDown_Result20	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'Result 20');
A_PowIdDown_Result20	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'Result 20');
B_PowIdDown_Result21	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'Result 21');
A_PowIdDown_Result21	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'Result 21');
B_PowIdDown_Result22	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'Result 22');
A_PowIdDown_Result22	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'Result 22');
B_PowIdDown_Result23	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'Result 23');
A_PowIdDown_Result23	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'Result 23');
B_PowIdDown_Result24	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'Result 24');
A_PowIdDown_Result24	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'Result 24');
B_PowIdDown_Result25	:=wk_ut.get_DS_Count(WU_PowIdDown_Before,'Result 25');
A_PowIdDown_Result25	:=wk_ut.get_DS_Count(WU_PowIdDown_After,'Result 25');

B_PowIdDown_MatchesPerformed	:=Dataset(WorkUnit(WU_PowIdDown_Before,'MatchesPerformed'),TotalRecordCount_rec);//
A_PowIdDown_MatchesPerformed	:=Dataset(WorkUnit(WU_PowIdDown_After,'MatchesPerformed'),TotalRecordCount_rec);
B_PowIdDown_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_PowIdDown_Before,'BasicMatchesPerformed'),TotalRecordCount_rec);//
A_PowIdDown_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_PowIdDown_After,'BasicMatchesPerformed'),TotalRecordCount_rec);
//B_PowIdDown_SlicesPerformed	:=Dataset(WorkUnit(WU_PowIdDown_Before,'SlicesPerformed'),TotalRecordCount_rec);//
//A_PowIdDown_SlicesPerformed	:=Dataset(WorkUnit(WU_PowIdDown_After,'SlicesPerformed'),TotalRecordCount_rec);
B_PowIdDown_TotalMatchSamples	:=Dataset(WorkUnit(WU_PowIdDown_Before,'TotalMatchSamples'),TotalRecordCount_rec);//
A_PowIdDown_TotalMatchSamples	:=Dataset(WorkUnit(WU_PowIdDown_After,'TotalMatchSamples'),TotalRecordCount_rec);
B_PowIdDown_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_PowIdDown_Before,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);//
A_PowIdDown_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_PowIdDown_After,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);
B_PowIdDown_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_PowIdDown_Before,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);//
A_PowIdDown_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_PowIdDown_After,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);

Shared PowIdDown_ds :=dataset([
{'MatchSampleRecords', 		B_PowIdDown_MatchSampleRecords, 	A_PowIdDown_MatchSampleRecords, 	A_PowIdDown_MatchSampleRecords- 	B_PowIdDown_MatchSampleRecords},
{'SliceOutCandidates', 		B_PowIdDown_SliceOutCandidates,   A_PowIdDown_SliceOutCandidates,   A_PowIdDown_SliceOutCandidates-   B_PowIdDown_SliceOutCandidates},
{'Specificities',   			B_PowIdDown_Specificities,   			A_PowIdDown_Specificities,  	 		A_PowIdDown_Specificities-   			B_PowIdDown_Specificities},
{'SPCShift',   						B_PowIdDown_SPCShift,   					A_PowIdDown_SPCShift,   					A_PowIdDown_SPCShift-   					B_PowIdDown_SPCShift},
{'PreClusters',   				B_PowIdDown_PreClusters,   				A_PowIdDown_PreClusters,   				A_PowIdDown_PreClusters-   				B_PowIdDown_PreClusters},
{'PostClusters',   				B_PowIdDown_PostClusters,   			A_PowIdDown_PostClusters,   			A_PowIdDown_PostClusters-   			B_PowIdDown_PostClusters},
{'PreClusterCount',   		B_PowIdDown_PreClusterCount,   		A_PowIdDown_PreClusterCount,   		A_PowIdDown_PreClusterCount-   		B_PowIdDown_PreClusterCount},
{'PostClusterCount',   		B_PowIdDown_PostClusterCount,   	A_PowIdDown_PostClusterCount,   	A_PowIdDown_PostClusterCount-   	B_PowIdDown_PostClusterCount},
{'RuleEfficacy',   				B_PowIdDown_RuleEfficacy,   			A_PowIdDown_RuleEfficacy,   			A_PowIdDown_RuleEfficacy-   			B_PowIdDown_RuleEfficacy},
{'ConfidenceLevels',   		B_PowIdDown_ConfidenceLevels,   	A_PowIdDown_ConfidenceLevels,   	A_PowIdDown_ConfidenceLevels-   	B_PowIdDown_ConfidenceLevels},
{'PrePopStats',   				B_PowIdDown_PrePopStats,   				A_PowIdDown_PrePopStats,   				A_PowIdDown_PrePopStats-   				B_PowIdDown_PrePopStats},
{'PostPopStats',   				B_PowIdDown_PostPopStats,   			A_PowIdDown_PostPopStats,   			A_PowIdDown_PostPopStats-   			B_PowIdDown_PostPopStats},
{'ValidityStatistics',    B_PowIdDown_ValidityStatistics,   A_PowIdDown_ValidityStatistics,   A_PowIdDown_ValidityStatistics-   B_PowIdDown_ValidityStatistics},
{'IdConsistency0',   			B_PowIdDown_IdConsistency0,   		A_PowIdDown_IdConsistency0,   		A_PowIdDown_IdConsistency0-   		B_PowIdDown_IdConsistency0},
{'Result20',   						B_PowIdDown_Result20,   					A_PowIdDown_Result20,   					A_PowIdDown_Result20-   					B_PowIdDown_Result20},
{'Result21',   						B_PowIdDown_Result21,   					A_PowIdDown_Result21,   					A_PowIdDown_Result21-   					B_PowIdDown_Result21},
{'Result22',   						B_PowIdDown_Result22,   					A_PowIdDown_Result22,   					A_PowIdDown_Result22-   					B_PowIdDown_Result22},
{'Result23',   						B_PowIdDown_Result23,   					A_PowIdDown_Result23,   					A_PowIdDown_Result23-   					B_PowIdDown_Result23},
{'Result24',   						B_PowIdDown_Result24,   					A_PowIdDown_Result24,   					A_PowIdDown_Result24-   					B_PowIdDown_Result24},
{'Result25',   						B_PowIdDown_Result25,   					A_PowIdDown_Result25,   					A_PowIdDown_Result25-   					B_PowIdDown_Result25},

   
{'MatchesPerformed',  			B_PowIdDown_MatchesPerformed[1].RCount,  			A_PowIdDown_MatchesPerformed[1].RCount,  			A_PowIdDown_MatchesPerformed[1].RCount-  			B_PowIdDown_MatchesPerformed[1].RCount},
{'BasicMatchesPerformed',  	B_PowIdDown_BasicMatchesPerformed[1].RCount,  A_PowIdDown_BasicMatchesPerformed[1].RCount,  A_PowIdDown_BasicMatchesPerformed[1].RCount-  B_PowIdDown_BasicMatchesPerformed[1].RCount},
/*{'SlicesPerformed',  				B_PowIdDown_SlicesPerformed[1].RCount,  			A_PowIdDown_SlicesPerformed[1].RCount,  			A_PowIdDown_SlicesPerformed[1].RCount-  			B_PowIdDown_SlicesPerformed[1].RCount},*/
{'TotalMatchSamples',  			B_PowIdDown_TotalMatchSamples[1].RCount,  		A_PowIdDown_TotalMatchSamples[1].RCount,  		A_PowIdDown_TotalMatchSamples[1].RCount-  		B_PowIdDown_TotalMatchSamples[1].RCount},
{'TotalMatchSamplesEqualToThreshold',  B_PowIdDown_TotalMatchSamplesEqualToThreshold[1].RCount,  A_PowIdDown_TotalMatchSamplesEqualToThreshold[1].RCount,  A_PowIdDown_TotalMatchSamplesEqualToThreshold[1].RCount-  B_PowIdDown_TotalMatchSamplesEqualToThreshold[1].RCount},
{'TotalMatchSamplesGreaterThanThreshold',  B_PowIdDown_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_PowIdDown_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_PowIdDown_TotalMatchSamplesGreaterThanThreshold[1].RCount-  B_PowIdDown_TotalMatchSamplesGreaterThanThreshold[1].RCount}
],Summary_Rec); 


//EmpIdDown iteration Part:
B_EmpIdDown_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'MatchSampleRecords');
A_EmpIdDown_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'MatchSampleRecords');
B_EmpIdDown_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'SliceOutCandidates');//
A_EmpIdDown_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'SliceOutCandidates');
B_EmpIdDown_Specificities	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'Specificities');//
A_EmpIdDown_Specificities	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'Specificities');
B_EmpIdDown_SPCShift	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'SPCShift');//
A_EmpIdDown_SPCShift	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'SPCShift');
B_EmpIdDown_PreClusters	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'PreClusters');//
A_EmpIdDown_PreClusters	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'PreClusters');
B_EmpIdDown_PostClusters	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'PostClusters');//
A_EmpIdDown_PostClusters	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'PostClusters');
B_EmpIdDown_PreClusterCount	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'PreClusterCount');//
A_EmpIdDown_PreClusterCount	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'PreClusterCount');
B_EmpIdDown_PostClusterCount	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'PostClusterCount');//
A_EmpIdDown_PostClusterCount	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'PostClusterCount');
B_EmpIdDown_RuleEfficacy	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'RuleEfficacy');//
A_EmpIdDown_RuleEfficacy	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'RuleEfficacy');
B_EmpIdDown_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'ConfidenceLevels');//
A_EmpIdDown_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'ConfidenceLevels');
B_EmpIdDown_PrePopStats	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'PrePopStats');//
A_EmpIdDown_PrePopStats	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'PrePopStats');
B_EmpIdDown_PostPopStats	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'PostPopStats');//
A_EmpIdDown_PostPopStats	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'PostPopStats');
B_EmpIdDown_ValidityStatistics	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'ValidityStatistics');//
A_EmpIdDown_ValidityStatistics	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'ValidityStatistics');
B_EmpIdDown_IdConsistency0	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'IdConsistency0');//
A_EmpIdDown_IdConsistency0	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'IdConsistency0');
B_EmpIdDown_Result20	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'Result 20');
A_EmpIdDown_Result20	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'Result 20');
B_EmpIdDown_Result21	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'Result 21');
A_EmpIdDown_Result21	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'Result 21');
B_EmpIdDown_Result22	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'Result 22');
A_EmpIdDown_Result22	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'Result 22');
B_EmpIdDown_Result23	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'Result 23');
A_EmpIdDown_Result23	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'Result 23');
B_EmpIdDown_Result24	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'Result 24');
A_EmpIdDown_Result24	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'Result 24');
B_EmpIdDown_Result25	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'Result 25');
A_EmpIdDown_Result25	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'Result 25');
B_EmpIdDown_Result26	:=wk_ut.get_DS_Count(WU_EmpIdDown_Before,'Result 26');
A_EmpIdDown_Result26	:=wk_ut.get_DS_Count(WU_EmpIdDown_After,'Result 26');

B_EmpIdDown_MatchesPerformed	:=Dataset(WorkUnit(WU_EmpIdDown_Before,'MatchesPerformed'),TotalRecordCount_rec);//
A_EmpIdDown_MatchesPerformed	:=Dataset(WorkUnit(WU_EmpIdDown_After,'MatchesPerformed'),TotalRecordCount_rec);
B_EmpIdDown_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_EmpIdDown_Before,'BasicMatchesPerformed'),TotalRecordCount_rec);//
A_EmpIdDown_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_EmpIdDown_After,'BasicMatchesPerformed'),TotalRecordCount_rec);
B_EmpIdDown_SlicesPerformed	:=Dataset(WorkUnit(WU_EmpIdDown_Before,'SlicesPerformed'),TotalRecordCount_rec);//
A_EmpIdDown_SlicesPerformed	:=Dataset(WorkUnit(WU_EmpIdDown_After,'SlicesPerformed'),TotalRecordCount_rec);
B_EmpIdDown_TotalMatchSamples	:=Dataset(WorkUnit(WU_EmpIdDown_Before,'TotalMatchSamples'),TotalRecordCount_rec);//
A_EmpIdDown_TotalMatchSamples	:=Dataset(WorkUnit(WU_EmpIdDown_After,'TotalMatchSamples'),TotalRecordCount_rec);
B_EmpIdDown_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_EmpIdDown_Before,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);//
A_EmpIdDown_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_EmpIdDown_After,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);
B_EmpIdDown_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_EmpIdDown_Before,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);//
A_EmpIdDown_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_EmpIdDown_After,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);

Shared EmpIdDown_ds :=dataset([
{'MatchSampleRecords', 		B_EmpIdDown_MatchSampleRecords, 	A_EmpIdDown_MatchSampleRecords, 	A_EmpIdDown_MatchSampleRecords- 	B_EmpIdDown_MatchSampleRecords},
{'SliceOutCandidates', 		B_EmpIdDown_SliceOutCandidates,   A_EmpIdDown_SliceOutCandidates,   A_EmpIdDown_SliceOutCandidates-   B_EmpIdDown_SliceOutCandidates},
{'Specificities',   			B_EmpIdDown_Specificities,   			A_EmpIdDown_Specificities,  	 		A_EmpIdDown_Specificities-   			B_EmpIdDown_Specificities},
{'SPCShift',   						B_EmpIdDown_SPCShift,   					A_EmpIdDown_SPCShift,   					A_EmpIdDown_SPCShift-   					B_EmpIdDown_SPCShift},
{'PreClusters',   				B_EmpIdDown_PreClusters,   				A_EmpIdDown_PreClusters,   				A_EmpIdDown_PreClusters-   				B_EmpIdDown_PreClusters},
{'PostClusters',   				B_EmpIdDown_PostClusters,   			A_EmpIdDown_PostClusters,   			A_EmpIdDown_PostClusters-   			B_EmpIdDown_PostClusters},
{'PreClusterCount',   		B_EmpIdDown_PreClusterCount,   		A_EmpIdDown_PreClusterCount,   		A_EmpIdDown_PreClusterCount-   		B_EmpIdDown_PreClusterCount},
{'PostClusterCount',   		B_EmpIdDown_PostClusterCount,   	A_EmpIdDown_PostClusterCount,   	A_EmpIdDown_PostClusterCount-   	B_EmpIdDown_PostClusterCount},
{'RuleEfficacy',   				B_EmpIdDown_RuleEfficacy,   			A_EmpIdDown_RuleEfficacy,   			A_EmpIdDown_RuleEfficacy-   			B_EmpIdDown_RuleEfficacy},
{'ConfidenceLevels',   		B_EmpIdDown_ConfidenceLevels,   	A_EmpIdDown_ConfidenceLevels,   	A_EmpIdDown_ConfidenceLevels-   	B_EmpIdDown_ConfidenceLevels},
{'PrePopStats',   				B_EmpIdDown_PrePopStats,   				A_EmpIdDown_PrePopStats,   				A_EmpIdDown_PrePopStats-   				B_EmpIdDown_PrePopStats},
{'PostPopStats',   				B_EmpIdDown_PostPopStats,   			A_EmpIdDown_PostPopStats,   			A_EmpIdDown_PostPopStats-   			B_EmpIdDown_PostPopStats},
{'ValidityStatistics',    B_EmpIdDown_ValidityStatistics,   A_EmpIdDown_ValidityStatistics,   A_EmpIdDown_ValidityStatistics-   B_EmpIdDown_ValidityStatistics},
{'IdConsistency0',   			B_EmpIdDown_IdConsistency0,   		A_EmpIdDown_IdConsistency0,   		A_EmpIdDown_IdConsistency0-   		B_EmpIdDown_IdConsistency0},
{'Result20',   						B_EmpIdDown_Result20,   					A_EmpIdDown_Result20,   					A_EmpIdDown_Result20-   					B_EmpIdDown_Result20},
{'Result21',   						B_EmpIdDown_Result21,   					A_EmpIdDown_Result21,   					A_EmpIdDown_Result21-   					B_EmpIdDown_Result21},
{'Result22',   						B_EmpIdDown_Result22,   					A_EmpIdDown_Result22,   					A_EmpIdDown_Result22-   					B_EmpIdDown_Result22},
{'Result23',   						B_EmpIdDown_Result23,   					A_EmpIdDown_Result23,   					A_EmpIdDown_Result23-   					B_EmpIdDown_Result23},
{'Result24',   						B_EmpIdDown_Result24,   					A_EmpIdDown_Result24,   					A_EmpIdDown_Result24-   					B_EmpIdDown_Result24},
{'Result25',   						B_EmpIdDown_Result25,   					A_EmpIdDown_Result25,   					A_EmpIdDown_Result25-   					B_EmpIdDown_Result25},
{'Result26',   						B_EmpIdDown_Result26,   					A_EmpIdDown_Result26,   					A_EmpIdDown_Result26-   					B_EmpIdDown_Result26},

   
{'MatchesPerformed',  			B_EmpIdDown_MatchesPerformed[1].RCount,  			A_EmpIdDown_MatchesPerformed[1].RCount,  			A_EmpIdDown_MatchesPerformed[1].RCount-  			B_EmpIdDown_MatchesPerformed[1].RCount},
{'BasicMatchesPerformed',  	B_EmpIdDown_BasicMatchesPerformed[1].RCount,  A_EmpIdDown_BasicMatchesPerformed[1].RCount,  A_EmpIdDown_BasicMatchesPerformed[1].RCount-  B_EmpIdDown_BasicMatchesPerformed[1].RCount},
{'SlicesPerformed',  				B_EmpIdDown_SlicesPerformed[1].RCount,  			A_EmpIdDown_SlicesPerformed[1].RCount,  			A_EmpIdDown_SlicesPerformed[1].RCount-  			B_EmpIdDown_SlicesPerformed[1].RCount},
{'TotalMatchSamples',  			B_EmpIdDown_TotalMatchSamples[1].RCount,  		A_EmpIdDown_TotalMatchSamples[1].RCount,  		A_EmpIdDown_TotalMatchSamples[1].RCount-  		B_EmpIdDown_TotalMatchSamples[1].RCount},
{'TotalMatchSamplesEqualToThreshold',  B_EmpIdDown_TotalMatchSamplesEqualToThreshold[1].RCount,  A_EmpIdDown_TotalMatchSamplesEqualToThreshold[1].RCount,  A_EmpIdDown_TotalMatchSamplesEqualToThreshold[1].RCount-  B_EmpIdDown_TotalMatchSamplesEqualToThreshold[1].RCount},
{'TotalMatchSamplesGreaterThanThreshold',  B_EmpIdDown_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_EmpIdDown_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_EmpIdDown_TotalMatchSamplesGreaterThanThreshold[1].RCount-  B_EmpIdDown_TotalMatchSamplesGreaterThanThreshold[1].RCount}
],Summary_Rec); 

//EmpID iteration part: 
B_EmpID_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_EmpID_Before,'MatchSampleRecords');
A_EmpID_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_EmpID_After,'MatchSampleRecords');
B_EmpID_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_EmpID_Before,'SliceOutCandidates');//
A_EmpID_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_EmpID_After,'SliceOutCandidates');
B_EmpID_Specificities	:=wk_ut.get_DS_Count(WU_EmpID_Before,'Specificities');//
A_EmpID_Specificities	:=wk_ut.get_DS_Count(WU_EmpID_After,'Specificities');
B_EmpID_SPCShift	:=wk_ut.get_DS_Count(WU_EmpID_Before,'SPCShift');//
A_EmpID_SPCShift	:=wk_ut.get_DS_Count(WU_EmpID_After,'SPCShift');
B_EmpID_PreClusters	:=wk_ut.get_DS_Count(WU_EmpID_Before,'PreClusters');//
A_EmpID_PreClusters	:=wk_ut.get_DS_Count(WU_EmpID_After,'PreClusters');
B_EmpID_PostClusters	:=wk_ut.get_DS_Count(WU_EmpID_Before,'PostClusters');//
A_EmpID_PostClusters	:=wk_ut.get_DS_Count(WU_EmpID_After,'PostClusters');
B_EmpID_PreClusterCount	:=wk_ut.get_DS_Count(WU_EmpID_Before,'PreClusterCount');//
A_EmpID_PreClusterCount	:=wk_ut.get_DS_Count(WU_EmpID_After,'PreClusterCount');
B_EmpID_PostClusterCount	:=wk_ut.get_DS_Count(WU_EmpID_Before,'PostClusterCount');//
A_EmpID_PostClusterCount	:=wk_ut.get_DS_Count(WU_EmpID_After,'PostClusterCount');
B_EmpID_RuleEfficacy	:=wk_ut.get_DS_Count(WU_EmpID_Before,'RuleEfficacy');//
A_EmpID_RuleEfficacy	:=wk_ut.get_DS_Count(WU_EmpID_After,'RuleEfficacy');
B_EmpID_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_EmpID_Before,'ConfidenceLevels');//
A_EmpID_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_EmpID_After,'ConfidenceLevels');
B_EmpID_PrePopStats	:=wk_ut.get_DS_Count(WU_EmpID_Before,'PrePopStats');//
A_EmpID_PrePopStats	:=wk_ut.get_DS_Count(WU_EmpID_After,'PrePopStats');
B_EmpID_PostPopStats	:=wk_ut.get_DS_Count(WU_EmpID_Before,'PostPopStats');//
A_EmpID_PostPopStats	:=wk_ut.get_DS_Count(WU_EmpID_After,'PostPopStats');
B_EmpID_ValidityStatistics	:=wk_ut.get_DS_Count(WU_EmpID_Before,'ValidityStatistics');//
A_EmpID_ValidityStatistics	:=wk_ut.get_DS_Count(WU_EmpID_After,'ValidityStatistics');
B_EmpID_IdConsistency0	:=wk_ut.get_DS_Count(WU_EmpID_Before,'IdConsistency0');//
A_EmpID_IdConsistency0	:=wk_ut.get_DS_Count(WU_EmpID_After,'IdConsistency0');
B_EmpID_Result20	:=wk_ut.get_DS_Count(WU_EmpID_Before,'Result 20');
A_EmpID_Result20	:=wk_ut.get_DS_Count(WU_EmpID_After,'Result 20');
B_EmpID_Result21	:=wk_ut.get_DS_Count(WU_EmpID_Before,'Result 21');
A_EmpID_Result21	:=wk_ut.get_DS_Count(WU_EmpID_After,'Result 21');
B_EmpID_Result22	:=wk_ut.get_DS_Count(WU_EmpID_Before,'Result 22');
A_EmpID_Result22	:=wk_ut.get_DS_Count(WU_EmpID_After,'Result 22');
B_EmpID_Result23	:=wk_ut.get_DS_Count(WU_EmpID_Before,'Result 23');
A_EmpID_Result23	:=wk_ut.get_DS_Count(WU_EmpID_After,'Result 23');
B_EmpID_Result24	:=wk_ut.get_DS_Count(WU_EmpID_Before,'Result 24');
A_EmpID_Result24	:=wk_ut.get_DS_Count(WU_EmpID_After,'Result 24');
B_EmpID_Result25	:=wk_ut.get_DS_Count(WU_EmpID_Before,'Result 25');
A_EmpID_Result25	:=wk_ut.get_DS_Count(WU_EmpID_After,'Result 25');
B_EmpID_Result26	:=wk_ut.get_DS_Count(WU_EmpID_Before,'Result 26');
A_EmpID_Result26	:=wk_ut.get_DS_Count(WU_EmpID_After,'Result 26');

B_EmpID_MatchesPerformed	:=Dataset(WorkUnit(WU_EmpID_Before,'MatchesPerformed'),TotalRecordCount_rec);//
A_EmpID_MatchesPerformed	:=Dataset(WorkUnit(WU_EmpID_After,'MatchesPerformed'),TotalRecordCount_rec);
B_EmpID_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_EmpID_Before,'BasicMatchesPerformed'),TotalRecordCount_rec);//
A_EmpID_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_EmpID_After,'BasicMatchesPerformed'),TotalRecordCount_rec);
B_EmpID_SlicesPerformed	:=Dataset(WorkUnit(WU_EmpID_Before,'SlicesPerformed'),TotalRecordCount_rec);//
A_EmpID_SlicesPerformed	:=Dataset(WorkUnit(WU_EmpID_After,'SlicesPerformed'),TotalRecordCount_rec);
B_EmpID_TotalMatchSamples	:=Dataset(WorkUnit(WU_EmpID_Before,'TotalMatchSamples'),TotalRecordCount_rec);//
A_EmpID_TotalMatchSamples	:=Dataset(WorkUnit(WU_EmpID_After,'TotalMatchSamples'),TotalRecordCount_rec);
B_EmpID_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_EmpID_Before,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);//
A_EmpID_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_EmpID_After,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);
B_EmpID_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_EmpID_Before,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);//
A_EmpID_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_EmpID_After,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);

Shared EmpID_ds :=dataset([
{'MatchSampleRecords', 		B_EmpID_MatchSampleRecords, 	A_EmpID_MatchSampleRecords, 	A_EmpID_MatchSampleRecords- 	B_EmpID_MatchSampleRecords},
{'SliceOutCandidates', 		B_EmpID_SliceOutCandidates,   A_EmpID_SliceOutCandidates,   A_EmpID_SliceOutCandidates-   B_EmpID_SliceOutCandidates},
{'Specificities',   			B_EmpID_Specificities,   			A_EmpID_Specificities,  	 		A_EmpID_Specificities-   			B_EmpID_Specificities},
{'SPCShift',   						B_EmpID_SPCShift,   					A_EmpID_SPCShift,   					A_EmpID_SPCShift-   					B_EmpID_SPCShift},
{'PreClusters',   				B_EmpID_PreClusters,   				A_EmpID_PreClusters,   				A_EmpID_PreClusters-   				B_EmpID_PreClusters},
{'PostClusters',   				B_EmpID_PostClusters,   			A_EmpID_PostClusters,   			A_EmpID_PostClusters-   			B_EmpID_PostClusters},
{'PreClusterCount',   		B_EmpID_PreClusterCount,   		A_EmpID_PreClusterCount,   		A_EmpID_PreClusterCount-   		B_EmpID_PreClusterCount},
{'PostClusterCount',   		B_EmpID_PostClusterCount,   	A_EmpID_PostClusterCount,   	A_EmpID_PostClusterCount-   	B_EmpID_PostClusterCount},
{'RuleEfficacy',   				B_EmpID_RuleEfficacy,   			A_EmpID_RuleEfficacy,   			A_EmpID_RuleEfficacy-   			B_EmpID_RuleEfficacy},
{'ConfidenceLevels',   		B_EmpID_ConfidenceLevels,   	A_EmpID_ConfidenceLevels,   	A_EmpID_ConfidenceLevels-   	B_EmpID_ConfidenceLevels},
{'PrePopStats',   				B_EmpID_PrePopStats,   				A_EmpID_PrePopStats,   				A_EmpID_PrePopStats-   				B_EmpID_PrePopStats},
{'PostPopStats',   				B_EmpID_PostPopStats,   			A_EmpID_PostPopStats,   			A_EmpID_PostPopStats-   			B_EmpID_PostPopStats},
{'ValidityStatistics',    B_EmpID_ValidityStatistics,   A_EmpID_ValidityStatistics,   A_EmpID_ValidityStatistics-   B_EmpID_ValidityStatistics},
{'IdConsistency0',   			B_EmpID_IdConsistency0,   		A_EmpID_IdConsistency0,   		A_EmpID_IdConsistency0-   		B_EmpID_IdConsistency0},
{'Result20',   						B_EmpID_Result20,   					A_EmpID_Result20,   					A_EmpID_Result20-   					B_EmpID_Result20},
{'Result21',   						B_EmpID_Result21,   					A_EmpID_Result21,   					A_EmpID_Result21-   					B_EmpID_Result21},
{'Result22',   						B_EmpID_Result22,   					A_EmpID_Result22,   					A_EmpID_Result22-   					B_EmpID_Result22},
{'Result23',   						B_EmpID_Result23,   					A_EmpID_Result23,   					A_EmpID_Result23-   					B_EmpID_Result23},
{'Result24',   						B_EmpID_Result24,   					A_EmpID_Result24,   					A_EmpID_Result24-   					B_EmpID_Result24},
{'Result25',   						B_EmpID_Result25,   					A_EmpID_Result25,   					A_EmpID_Result25-   					B_EmpID_Result25},
{'Result26',   						B_EmpID_Result26,   					A_EmpID_Result26,   					A_EmpID_Result26-   					B_EmpID_Result26},

   
{'MatchesPerformed',  			B_EmpID_MatchesPerformed[1].RCount,  			A_EmpID_MatchesPerformed[1].RCount,  			A_EmpID_MatchesPerformed[1].RCount-  			B_EmpID_MatchesPerformed[1].RCount},
{'BasicMatchesPerformed',  	B_EmpID_BasicMatchesPerformed[1].RCount,  A_EmpID_BasicMatchesPerformed[1].RCount,  A_EmpID_BasicMatchesPerformed[1].RCount-  B_EmpID_BasicMatchesPerformed[1].RCount},
{'SlicesPerformed',  				B_EmpID_SlicesPerformed[1].RCount,  			A_EmpID_SlicesPerformed[1].RCount,  			A_EmpID_SlicesPerformed[1].RCount-  			B_EmpID_SlicesPerformed[1].RCount},
{'TotalMatchSamples',  			B_EmpID_TotalMatchSamples[1].RCount,  		A_EmpID_TotalMatchSamples[1].RCount,  		A_EmpID_TotalMatchSamples[1].RCount-  		B_EmpID_TotalMatchSamples[1].RCount},
{'TotalMatchSamplesEqualToThreshold',  B_EmpID_TotalMatchSamplesEqualToThreshold[1].RCount,  A_EmpID_TotalMatchSamplesEqualToThreshold[1].RCount,  A_EmpID_TotalMatchSamplesEqualToThreshold[1].RCount-  B_EmpID_TotalMatchSamplesEqualToThreshold[1].RCount},
{'TotalMatchSamplesGreaterThanThreshold',  B_EmpID_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_EmpID_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_EmpID_TotalMatchSamplesGreaterThanThreshold[1].RCount-  B_EmpID_TotalMatchSamplesGreaterThanThreshold[1].RCount}
],Summary_Rec); 

//LGID3 iteration Part:
B_LGID3_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_LGID3_Before,'MatchSampleRecords');
A_LGID3_MatchSampleRecords	:=wk_ut.get_DS_Count(WU_LGID3_After,'MatchSampleRecords');
B_LGID3_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_LGID3_Before,'SliceOutCandidates');//
A_LGID3_SliceOutCandidates	:=wk_ut.get_DS_Count(WU_LGID3_After,'SliceOutCandidates');
B_LGID3_Specificities	:=wk_ut.get_DS_Count(WU_LGID3_Before,'Specificities');//
A_LGID3_Specificities	:=wk_ut.get_DS_Count(WU_LGID3_After,'Specificities');
B_LGID3_SPCShift	:=wk_ut.get_DS_Count(WU_LGID3_Before,'SPCShift');//
A_LGID3_SPCShift	:=wk_ut.get_DS_Count(WU_LGID3_After,'SPCShift');
B_LGID3_PreClusters	:=wk_ut.get_DS_Count(WU_LGID3_Before,'PreClusters');//
A_LGID3_PreClusters	:=wk_ut.get_DS_Count(WU_LGID3_After,'PreClusters');
B_LGID3_PostClusters	:=wk_ut.get_DS_Count(WU_LGID3_Before,'PostClusters');//
A_LGID3_PostClusters	:=wk_ut.get_DS_Count(WU_LGID3_After,'PostClusters');
B_LGID3_PreClusterCount	:=wk_ut.get_DS_Count(WU_LGID3_Before,'PreClusterCount');//
A_LGID3_PreClusterCount	:=wk_ut.get_DS_Count(WU_LGID3_After,'PreClusterCount');
B_LGID3_PostClusterCount	:=wk_ut.get_DS_Count(WU_LGID3_Before,'PostClusterCount');//
A_LGID3_PostClusterCount	:=wk_ut.get_DS_Count(WU_LGID3_After,'PostClusterCount');
B_LGID3_RuleEfficacy	:=wk_ut.get_DS_Count(WU_LGID3_Before,'RuleEfficacy');//
A_LGID3_RuleEfficacy	:=wk_ut.get_DS_Count(WU_LGID3_After,'RuleEfficacy');
B_LGID3_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_LGID3_Before,'ConfidenceLevels');//
A_LGID3_ConfidenceLevels	:=wk_ut.get_DS_Count(WU_LGID3_After,'ConfidenceLevels');
B_LGID3_PrePopStats	:=wk_ut.get_DS_Count(WU_LGID3_Before,'PrePopStats');//
A_LGID3_PrePopStats	:=wk_ut.get_DS_Count(WU_LGID3_After,'PrePopStats');
B_LGID3_PostPopStats	:=wk_ut.get_DS_Count(WU_LGID3_Before,'PostPopStats');//
A_LGID3_PostPopStats	:=wk_ut.get_DS_Count(WU_LGID3_After,'PostPopStats');
B_LGID3_ValidityStatistics	:=wk_ut.get_DS_Count(WU_LGID3_Before,'ValidityStatistics');//
A_LGID3_ValidityStatistics	:=wk_ut.get_DS_Count(WU_LGID3_After,'ValidityStatistics');
B_LGID3_IdConsistency0	:=wk_ut.get_DS_Count(WU_LGID3_Before,'IdConsistency0');//
A_LGID3_IdConsistency0	:=wk_ut.get_DS_Count(WU_LGID3_After,'IdConsistency0');
B_LGID3_Result20	:=wk_ut.get_DS_Count(WU_LGID3_Before,'Result 20');
A_LGID3_Result20	:=wk_ut.get_DS_Count(WU_LGID3_After,'Result 20');
B_LGID3_Result21	:=wk_ut.get_DS_Count(WU_LGID3_Before,'Result 21');
A_LGID3_Result21	:=wk_ut.get_DS_Count(WU_LGID3_After,'Result 21');
B_LGID3_Result22	:=wk_ut.get_DS_Count(WU_LGID3_Before,'Result 22');
A_LGID3_Result22	:=wk_ut.get_DS_Count(WU_LGID3_After,'Result 22');
B_LGID3_Result23	:=wk_ut.get_DS_Count(WU_LGID3_Before,'Result 23');
A_LGID3_Result23	:=wk_ut.get_DS_Count(WU_LGID3_After,'Result 23');
B_LGID3_Result24	:=wk_ut.get_DS_Count(WU_LGID3_Before,'Result 24');
A_LGID3_Result24	:=wk_ut.get_DS_Count(WU_LGID3_After,'Result 24');
B_LGID3_Result25	:=wk_ut.get_DS_Count(WU_LGID3_Before,'Result 25');
A_LGID3_Result25	:=wk_ut.get_DS_Count(WU_LGID3_After,'Result 25');
B_LGID3_Result26	:=wk_ut.get_DS_Count(WU_LGID3_Before,'Result 26');
A_LGID3_Result26	:=wk_ut.get_DS_Count(WU_LGID3_After,'Result 26');
B_LGID3_Result27	:=wk_ut.get_DS_Count(WU_LGID3_Before,'Result 27');
A_LGID3_Result27	:=wk_ut.get_DS_Count(WU_LGID3_After,'Result 27');

B_LGID3_MatchesPerformed	:=Dataset(WorkUnit(WU_LGID3_Before,'MatchesPerformed'),TotalRecordCount_rec);//
A_LGID3_MatchesPerformed	:=Dataset(WorkUnit(WU_LGID3_After,'MatchesPerformed'),TotalRecordCount_rec);
B_LGID3_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_LGID3_Before,'BasicMatchesPerformed'),TotalRecordCount_rec);//
A_LGID3_BasicMatchesPerformed	:=Dataset(WorkUnit(WU_LGID3_After,'BasicMatchesPerformed'),TotalRecordCount_rec);
B_LGID3_SlicesPerformed	:=Dataset(WorkUnit(WU_LGID3_Before,'SlicesPerformed'),TotalRecordCount_rec);//
A_LGID3_SlicesPerformed	:=Dataset(WorkUnit(WU_LGID3_After,'SlicesPerformed'),TotalRecordCount_rec);
B_LGID3_TotalMatchSamples	:=Dataset(WorkUnit(WU_LGID3_Before,'TotalMatchSamples'),TotalRecordCount_rec);//
A_LGID3_TotalMatchSamples	:=Dataset(WorkUnit(WU_LGID3_After,'TotalMatchSamples'),TotalRecordCount_rec);
B_LGID3_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_LGID3_Before,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);//
A_LGID3_TotalMatchSamplesEqualToThreshold	:=Dataset(WorkUnit(WU_LGID3_After,'TotalMatchSamplesEqualToThreshold'),TotalRecordCount_rec);
B_LGID3_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_LGID3_Before,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);//
A_LGID3_TotalMatchSamplesGreaterThanThreshold	:=Dataset(WorkUnit(WU_LGID3_After,'TotalMatchSamplesGreaterThanThreshold'),TotalRecordCount_rec);

Shared LGID3_ds :=dataset([
{'MatchSampleRecords', 		B_LGID3_MatchSampleRecords, 	A_LGID3_MatchSampleRecords, 	A_LGID3_MatchSampleRecords- 	B_LGID3_MatchSampleRecords},
{'SliceOutCandidates', 		B_LGID3_SliceOutCandidates,   A_LGID3_SliceOutCandidates,   A_LGID3_SliceOutCandidates-   B_LGID3_SliceOutCandidates},
{'Specificities',   			B_LGID3_Specificities,   			A_LGID3_Specificities,  	 		A_LGID3_Specificities-   			B_LGID3_Specificities},
{'SPCShift',   						B_LGID3_SPCShift,   					A_LGID3_SPCShift,   					A_LGID3_SPCShift-   					B_LGID3_SPCShift},
{'PreClusters',   				B_LGID3_PreClusters,   				A_LGID3_PreClusters,   				A_LGID3_PreClusters-   				B_LGID3_PreClusters},
{'PostClusters',   				B_LGID3_PostClusters,   			A_LGID3_PostClusters,   			A_LGID3_PostClusters-   			B_LGID3_PostClusters},
{'PreClusterCount',   		B_LGID3_PreClusterCount,   		A_LGID3_PreClusterCount,   		A_LGID3_PreClusterCount-   		B_LGID3_PreClusterCount},
{'PostClusterCount',   		B_LGID3_PostClusterCount,   	A_LGID3_PostClusterCount,   	A_LGID3_PostClusterCount-   	B_LGID3_PostClusterCount},
{'RuleEfficacy',   				B_LGID3_RuleEfficacy,   			A_LGID3_RuleEfficacy,   			A_LGID3_RuleEfficacy-   			B_LGID3_RuleEfficacy},
{'ConfidenceLevels',   		B_LGID3_ConfidenceLevels,   	A_LGID3_ConfidenceLevels,   	A_LGID3_ConfidenceLevels-   	B_LGID3_ConfidenceLevels},
{'PrePopStats',   				B_LGID3_PrePopStats,   				A_LGID3_PrePopStats,   				A_LGID3_PrePopStats-   				B_LGID3_PrePopStats},
{'PostPopStats',   				B_LGID3_PostPopStats,   			A_LGID3_PostPopStats,   			A_LGID3_PostPopStats-   			B_LGID3_PostPopStats},
{'ValidityStatistics',    B_LGID3_ValidityStatistics,   A_LGID3_ValidityStatistics,   A_LGID3_ValidityStatistics-   B_LGID3_ValidityStatistics},
{'IdConsistency0',   			B_LGID3_IdConsistency0,   		A_LGID3_IdConsistency0,   		A_LGID3_IdConsistency0-   		B_LGID3_IdConsistency0},
{'Result20',   						B_LGID3_Result20,   					A_LGID3_Result20,   					A_LGID3_Result20-   					B_LGID3_Result20},
{'Result21',   						B_LGID3_Result21,   					A_LGID3_Result21,   					A_LGID3_Result21-   					B_LGID3_Result21},
{'Result22',   						B_LGID3_Result22,   					A_LGID3_Result22,   					A_LGID3_Result22-   					B_LGID3_Result22},
{'Result23',   						B_LGID3_Result23,   					A_LGID3_Result23,   					A_LGID3_Result23-   					B_LGID3_Result23},
{'Result24',   						B_LGID3_Result24,   					A_LGID3_Result24,   					A_LGID3_Result24-   					B_LGID3_Result24},
{'Result25',   						B_LGID3_Result25,   					A_LGID3_Result25,   					A_LGID3_Result25-   					B_LGID3_Result25},
{'Result26',   						B_LGID3_Result26,   					A_LGID3_Result26,   					A_LGID3_Result26-   					B_LGID3_Result26},
{'Result27',   						B_LGID3_Result27,   					A_LGID3_Result27,   					A_LGID3_Result27-   					B_LGID3_Result27},

   
{'MatchesPerformed',  			B_LGID3_MatchesPerformed[1].RCount,  			A_LGID3_MatchesPerformed[1].RCount,  			A_LGID3_MatchesPerformed[1].RCount-  			B_LGID3_MatchesPerformed[1].RCount},
{'BasicMatchesPerformed',  	B_LGID3_BasicMatchesPerformed[1].RCount,  A_LGID3_BasicMatchesPerformed[1].RCount,  A_LGID3_BasicMatchesPerformed[1].RCount-  B_LGID3_BasicMatchesPerformed[1].RCount},
{'SlicesPerformed',  				B_LGID3_SlicesPerformed[1].RCount,  			A_LGID3_SlicesPerformed[1].RCount,  			A_LGID3_SlicesPerformed[1].RCount-  			B_LGID3_SlicesPerformed[1].RCount},
{'TotalMatchSamples',  			B_LGID3_TotalMatchSamples[1].RCount,  		A_LGID3_TotalMatchSamples[1].RCount,  		A_LGID3_TotalMatchSamples[1].RCount-  		B_LGID3_TotalMatchSamples[1].RCount},
{'TotalMatchSamplesEqualToThreshold',  B_LGID3_TotalMatchSamplesEqualToThreshold[1].RCount,  A_LGID3_TotalMatchSamplesEqualToThreshold[1].RCount,  A_LGID3_TotalMatchSamplesEqualToThreshold[1].RCount-  B_LGID3_TotalMatchSamplesEqualToThreshold[1].RCount},
{'TotalMatchSamplesGreaterThanThreshold',  B_LGID3_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_LGID3_TotalMatchSamplesGreaterThanThreshold[1].RCount,  A_LGID3_TotalMatchSamplesGreaterThanThreshold[1].RCount-  B_LGID3_TotalMatchSamplesGreaterThanThreshold[1].RCount}
],Summary_Rec); 

//Integrity Test Part:
B_count_Infile	:=Dataset(WorkUnit(WU_BeforUpgrade,'count_Infile'),TotalRecordCount_rec); 
B_count_wDot		:=Dataset(WorkUnit(WU_BeforUpgrade,'count_wDot'),TotalRecordCount_rec);
B_count_wProx		:=Dataset(WorkUnit(WU_BeforUpgrade,'count_wProx'),TotalRecordCount_rec);
B_count_wHrchy	:=Dataset(WorkUnit(WU_BeforUpgrade,'count_wHrchy'),TotalRecordCount_rec);
B_count_wLGID3	:=Dataset(WorkUnit(WU_BeforUpgrade,'count_wLGID3'),TotalRecordCount_rec);
B_proxid_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_BeforUpgrade,'proxid_count_Infile1_no_reset'),TotalRecordCount_rec);
B_lgid3_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_BeforUpgrade,'lgid3_count_Infile1_no_reset'),TotalRecordCount_rec);
B_seleid_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_BeforUpgrade,'seleid_count_Infile1_no_reset'),TotalRecordCount_rec);
B_orgid_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_BeforUpgrade,'orgid_count_Infile1_no_reset'),TotalRecordCount_rec);
B_ultid_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_BeforUpgrade,'ultid_count_Infile1_no_reset'),TotalRecordCount_rec);
B_proxid_count_Dot1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'proxid_count_Dot1_no_reset'),TotalRecordCount_rec);
B_lgid3_count_Dot1_no_reset					:=Dataset(WorkUnit(WU_BeforUpgrade,'lgid3_count_Dot1_no_reset'),TotalRecordCount_rec);
B_seleid_count_Dot1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'seleid_count_Dot1_no_reset'),TotalRecordCount_rec);
B_orgid_count_Dot1_no_reset					:=Dataset(WorkUnit(WU_BeforUpgrade,'orgid_count_Dot1_no_reset'),TotalRecordCount_rec);
B_ultid_count_Dot1_no_reset					:=Dataset(WorkUnit(WU_BeforUpgrade,'ultid_count_Dot1_no_reset'),TotalRecordCount_rec);
B_proxid_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'proxid_count_Prox1_no_reset'),TotalRecordCount_rec);
B_lgid3_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'lgid3_count_Prox1_no_reset'),TotalRecordCount_rec);
B_seleid_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'seleid_count_Prox1_no_reset'),TotalRecordCount_rec);
B_orgid_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'orgid_count_Prox1_no_reset'),TotalRecordCount_rec);
B_ultid_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'ultid_count_Prox1_no_reset'),TotalRecordCount_rec);
B_proxid_count_Hrchy1_no_reset			:=Dataset(WorkUnit(WU_BeforUpgrade,'proxid_count_Hrchy1_no_reset'),TotalRecordCount_rec);
B_lgid3_count_Hrchy1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'lgid3_count_Hrchy1_no_reset'),TotalRecordCount_rec);
B_seleid_count_Hrchy1_no_reset			:=Dataset(WorkUnit(WU_BeforUpgrade,'seleid_count_Hrchy1_no_reset'),TotalRecordCount_rec);
B_orgid_count_Hrchy1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'orgid_count_Hrchy1_no_reset'),TotalRecordCount_rec);
B_ultid_count_Hrchy1_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'ultid_count_Hrchy1_no_reset'),TotalRecordCount_rec);
B_proxid_count_LGID31_no_reset			:=Dataset(WorkUnit(WU_BeforUpgrade,'proxid_count_LGID31_no_reset'),TotalRecordCount_rec);
B_lgid3_count_LGID31_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'lgid3_count_LGID31_no_reset'),TotalRecordCount_rec);
B_seleid_count_LGID31_no_reset			:=Dataset(WorkUnit(WU_BeforUpgrade,'seleid_count_LGID31_no_reset'),TotalRecordCount_rec);
B_orgid_count_LGID31_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'orgid_count_LGID31_no_reset'),TotalRecordCount_rec);
B_ultid_count_LGID31_no_reset				:=Dataset(WorkUnit(WU_BeforUpgrade,'ultid_count_LGID31_no_reset'),TotalRecordCount_rec);

//--------------------------------------------------------
A_count_Infile	:=Dataset(WorkUnit(WU_AfterUpgrade,'count_Infile'),TotalRecordCount_rec);
A_count_wDot		:=Dataset(WorkUnit(WU_AfterUpgrade,'count_wDot'),TotalRecordCount_rec);
A_count_wProx		:=Dataset(WorkUnit(WU_AfterUpgrade,'count_wProx'),TotalRecordCount_rec);
A_count_wHrchy	:=Dataset(WorkUnit(WU_AfterUpgrade,'count_wHrchy'),TotalRecordCount_rec);
A_count_wLGID3	:=Dataset(WorkUnit(WU_AfterUpgrade,'count_wLGID3'),TotalRecordCount_rec);
A_proxid_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_AfterUpgrade,'proxid_count_Infile1_no_reset'),TotalRecordCount_rec);
A_lgid3_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_AfterUpgrade,'lgid3_count_Infile1_no_reset'),TotalRecordCount_rec);
A_seleid_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_AfterUpgrade,'seleid_count_Infile1_no_reset'),TotalRecordCount_rec);
A_orgid_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_AfterUpgrade,'orgid_count_Infile1_no_reset'),TotalRecordCount_rec);
A_ultid_count_Infile1_no_reset			:=Dataset(WorkUnit(WU_AfterUpgrade,'ultid_count_Infile1_no_reset'),TotalRecordCount_rec);
A_proxid_count_Dot1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'proxid_count_Dot1_no_reset'),TotalRecordCount_rec);
A_lgid3_count_Dot1_no_reset					:=Dataset(WorkUnit(WU_AfterUpgrade,'lgid3_count_Dot1_no_reset'),TotalRecordCount_rec);
A_seleid_count_Dot1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'seleid_count_Dot1_no_reset'),TotalRecordCount_rec);
A_orgid_count_Dot1_no_reset					:=Dataset(WorkUnit(WU_AfterUpgrade,'orgid_count_Dot1_no_reset'),TotalRecordCount_rec);
A_ultid_count_Dot1_no_reset					:=Dataset(WorkUnit(WU_AfterUpgrade,'ultid_count_Dot1_no_reset'),TotalRecordCount_rec);
A_proxid_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'proxid_count_Prox1_no_reset'),TotalRecordCount_rec);
A_lgid3_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'lgid3_count_Prox1_no_reset'),TotalRecordCount_rec);
A_seleid_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'seleid_count_Prox1_no_reset'),TotalRecordCount_rec);
A_orgid_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'orgid_count_Prox1_no_reset'),TotalRecordCount_rec);
A_ultid_count_Prox1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'ultid_count_Prox1_no_reset'),TotalRecordCount_rec);
A_proxid_count_Hrchy1_no_reset			:=Dataset(WorkUnit(WU_AfterUpgrade,'proxid_count_Hrchy1_no_reset'),TotalRecordCount_rec);
A_lgid3_count_Hrchy1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'lgid3_count_Hrchy1_no_reset'),TotalRecordCount_rec);
A_seleid_count_Hrchy1_no_reset			:=Dataset(WorkUnit(WU_AfterUpgrade,'seleid_count_Hrchy1_no_reset'),TotalRecordCount_rec);
A_orgid_count_Hrchy1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'orgid_count_Hrchy1_no_reset'),TotalRecordCount_rec);
A_ultid_count_Hrchy1_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'ultid_count_Hrchy1_no_reset'),TotalRecordCount_rec);

A_proxid_count_LGID31_no_reset			:=Dataset(WorkUnit(WU_AfterUpgrade,'proxid_count_LGID31_no_reset'),TotalRecordCount_rec);
A_lgid3_count_LGID31_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'lgid3_count_LGID31_no_reset'),TotalRecordCount_rec);
A_seleid_count_LGID31_no_reset			:=Dataset(WorkUnit(WU_AfterUpgrade,'seleid_count_LGID31_no_reset'),TotalRecordCount_rec);
A_orgid_count_LGID31_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'orgid_count_LGID31_no_reset'),TotalRecordCount_rec);
A_ultid_count_LGID31_no_reset				:=Dataset(WorkUnit(WU_AfterUpgrade,'ultid_count_LGID31_no_reset'),TotalRecordCount_rec);


Shared Summary_ds :=dataset([
 {'count_Infile', B_count_Infile[1].RCount, A_count_Infile[1].RCount, A_count_Infile[1].RCount- B_count_Infile[1].RCount}, 
 {'count_wDot',   B_count_wDot[1].RCount,   A_count_wDot[1].RCount,   A_count_wDot[1].RCount-   B_count_wDot[1].RCount},
 {'count_wProx',  B_count_wProx[1].RCount,  A_count_wProx[1].RCount,  A_count_wProx[1].RCount-  B_count_wProx[1].RCount},
 {'count_wHrchy', B_count_wHrchy[1].RCount, A_count_wHrchy[1].RCount, A_count_wHrchy[1].RCount- B_count_wHrchy[1].RCount},
 {'count_wLGID3', B_count_wLGID3[1].RCount, A_count_wLGID3[1].RCount, A_count_wLGID3[1].RCount- B_count_wLGID3[1].RCount},


{'proxid_count_Infile1_no_reset', B_proxid_count_Infile1_no_reset[1].RCount, A_proxid_count_Infile1_no_reset[1].RCount, A_proxid_count_Infile1_no_reset[1].RCount- B_proxid_count_Infile1_no_reset[1].RCount},
{'lgid3_count_Infile1_no_reset',  B_lgid3_count_Infile1_no_reset[1].RCount,  A_lgid3_count_Infile1_no_reset[1].RCount,  A_lgid3_count_Infile1_no_reset[1].RCount-  B_lgid3_count_Infile1_no_reset[1].RCount},
{'seleid_count_Infile1_no_reset', B_seleid_count_Infile1_no_reset[1].RCount, A_seleid_count_Infile1_no_reset[1].RCount, A_seleid_count_Infile1_no_reset[1].RCount- B_seleid_count_Infile1_no_reset[1].RCount},
{'orgid_count_Infile1_no_reset',  B_orgid_count_Infile1_no_reset[1].RCount,  A_orgid_count_Infile1_no_reset[1].RCount,  A_orgid_count_Infile1_no_reset[1].RCount-  B_orgid_count_Infile1_no_reset[1].RCount},
{'ultid_count_Infile1_no_reset',  B_ultid_count_Infile1_no_reset[1].RCount,  A_ultid_count_Infile1_no_reset[1].RCount,  A_ultid_count_Infile1_no_reset[1].RCount-  B_ultid_count_Infile1_no_reset[1].RCount},

{'proxid_count_Dot1_no_reset',    B_proxid_count_Dot1_no_reset[1].RCount,    A_proxid_count_Dot1_no_reset[1].RCount,    A_proxid_count_Dot1_no_reset[1].RCount-    B_proxid_count_Dot1_no_reset[1].RCount},
{'lgid3_count_Dot1_no_reset',     B_lgid3_count_Dot1_no_reset[1].RCount,     A_lgid3_count_Dot1_no_reset[1].RCount,     A_lgid3_count_Dot1_no_reset[1].RCount-     B_lgid3_count_Dot1_no_reset[1].RCount},
{'seleid_count_Dot1_no_reset',    B_seleid_count_Dot1_no_reset[1].RCount,    A_seleid_count_Dot1_no_reset[1].RCount,    A_seleid_count_Dot1_no_reset[1].RCount-    B_seleid_count_Dot1_no_reset[1].RCount},
{'orgid_count_Dot1_no_reset',     B_orgid_count_Dot1_no_reset[1].RCount,     A_orgid_count_Dot1_no_reset[1].RCount,     A_orgid_count_Dot1_no_reset[1].RCount-     B_orgid_count_Dot1_no_reset[1].RCount},
{'ultid_count_Dot1_no_reset',     B_ultid_count_Dot1_no_reset[1].RCount,     A_ultid_count_Dot1_no_reset[1].RCount,     A_ultid_count_Dot1_no_reset[1].RCount-     B_ultid_count_Dot1_no_reset[1].RCount},

{'proxid_count_Prox1_no_reset',   B_proxid_count_Prox1_no_reset[1].RCount,   A_proxid_count_Prox1_no_reset[1].RCount,   A_proxid_count_Prox1_no_reset[1].RCount-   B_proxid_count_Prox1_no_reset[1].RCount},
{'lgid3_count_Prox1_no_reset',    B_lgid3_count_Prox1_no_reset[1].RCount,    A_lgid3_count_Prox1_no_reset[1].RCount,    A_lgid3_count_Prox1_no_reset[1].RCount-    B_lgid3_count_Prox1_no_reset[1].RCount},
{'seleid_count_Prox1_no_reset',   B_seleid_count_Prox1_no_reset[1].RCount,   A_seleid_count_Prox1_no_reset[1].RCount,   A_seleid_count_Prox1_no_reset[1].RCount-   B_seleid_count_Prox1_no_reset[1].RCount},
{'orgid_count_Prox1_no_reset',    B_orgid_count_Prox1_no_reset[1].RCount,    A_orgid_count_Prox1_no_reset[1].RCount,    A_orgid_count_Prox1_no_reset[1].RCount-    B_orgid_count_Prox1_no_reset[1].RCount},
{'ultid_count_Prox1_no_reset',    B_ultid_count_Prox1_no_reset[1].RCount,    A_ultid_count_Prox1_no_reset[1].RCount,    A_ultid_count_Prox1_no_reset[1].RCount-    B_ultid_count_Prox1_no_reset[1].RCount},

{'proxid_count_Hrchy1_no_reset',  B_proxid_count_Hrchy1_no_reset[1].RCount,  A_proxid_count_Hrchy1_no_reset[1].RCount,  A_proxid_count_Hrchy1_no_reset[1].RCount-  B_proxid_count_Hrchy1_no_reset[1].RCount},
{'lgid3_count_Hrchy1_no_reset',   B_lgid3_count_Hrchy1_no_reset[1].RCount,   A_lgid3_count_Hrchy1_no_reset[1].RCount,   A_lgid3_count_Hrchy1_no_reset[1].RCount-   B_lgid3_count_Hrchy1_no_reset[1].RCount},
{'seleid_count_Hrchy1_no_reset',  B_seleid_count_Hrchy1_no_reset[1].RCount,  A_seleid_count_Hrchy1_no_reset[1].RCount,  A_seleid_count_Hrchy1_no_reset[1].RCount-  B_seleid_count_Hrchy1_no_reset[1].RCount},
{'orgid_count_Hrchy1_no_reset',   B_orgid_count_Hrchy1_no_reset[1].RCount,   A_orgid_count_Hrchy1_no_reset[1].RCount,   A_orgid_count_Hrchy1_no_reset[1].RCount-   B_orgid_count_Hrchy1_no_reset[1].RCount},
{'ultid_count_Hrchy1_no_reset',   B_ultid_count_Hrchy1_no_reset[1].RCount,   A_ultid_count_Hrchy1_no_reset[1].RCount,   A_ultid_count_Hrchy1_no_reset[1].RCount-   B_ultid_count_Hrchy1_no_reset[1].RCount},

{'proxid_count_LGID31_no_reset',  B_proxid_count_LGID31_no_reset[1].RCount,  A_proxid_count_LGID31_no_reset[1].RCount,  A_proxid_count_LGID31_no_reset[1].RCount-  B_proxid_count_LGID31_no_reset[1].RCount},
{'lgid3_count_LGID31_no_reset',   B_lgid3_count_LGID31_no_reset[1].RCount,   A_lgid3_count_LGID31_no_reset[1].RCount,   A_lgid3_count_LGID31_no_reset[1].RCount-   B_lgid3_count_LGID31_no_reset[1].RCount},
{'seleid_count_LGID31_no_reset',  B_seleid_count_LGID31_no_reset[1].RCount,  A_seleid_count_LGID31_no_reset[1].RCount,  A_seleid_count_LGID31_no_reset[1].RCount-  B_seleid_count_LGID31_no_reset[1].RCount},
{'orgid_count_LGID31_no_reset',   B_orgid_count_LGID31_no_reset[1].RCount,   A_orgid_count_LGID31_no_reset[1].RCount,   A_orgid_count_LGID31_no_reset[1].RCount-   B_orgid_count_LGID31_no_reset[1].RCount},
{'ultid_count_LGID31_no_reset',   B_ultid_count_LGID31_no_reset[1].RCount,   A_ultid_count_LGID31_no_reset[1].RCount,   A_ultid_count_LGID31_no_reset[1].RCount-   B_ultid_count_LGID31_no_reset[1].RCount}
],Summary_Rec);
					
output(DotID_ds, named('DotID_comparison'));
output(ProxSpec_ds, named('ProxSpec_comparison'));
output(Mj6Spec_ds, named('Mj6Spec_comparison'));
output(Hrchy_ds, named('Hrchy_comparison'));					
output(LGID3_ds, named('LGID3_comparison'));	
output(PowIdDown_ds, named('PowIdDown_comparison'));
output(POWID_ds, named('PowId_comparison'));
output(EmpIdDown_ds, named('EmpIdDown_comparison'));
output(EmpID_ds, named('EmpID_comparison'));				
output(Summary_ds, named('IntegrityTest'));	
		
//wk_ut.get_WUInfo(WU_BeforUpgrade,wk_ut._constants.LocalEsp).totalthortime;
//wk_ut.get_WUInfo(WU_AfterUpgrade,wk_ut._constants.LocalEsp).totalthortime;		