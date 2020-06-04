/*
1) You can submit the QA_Run_... jobs concurrently before the platform upgrade and write down the workunits.
   After platform upgrade, you submit all these jobs concurrently again and write down the workunits.

2) Submit the QA_PlatformComparisonSummary with the inputs as the workunits mentioned in 1). Then analyze the result.
   The difference field in each result set should be zero or very small. If you see something seems wrong, you can 
   present the result to our BIP team for further analysis. A sample result can be seen from dataland2 W20150731-135739
   The comparison of Result24 in both LGID3 and EmpID can be ignored.

3) All the "ResultXXX" in the result set of QA_PlatformComparisonSummary corresponding to files (for example, Result20 might be
   "~thor_data400::bipv2_powid::salt_iter::20150618a::it1", and you can go to ECL Watch to find what is the real file).
   When doing the test for the same item (say, DOTID iteration) before and after plateform upgrade, the files will be overwritten.
   So, only the number of records are compared.

4) For EmpIdDown iteration (QA_Run_Platform_EmpIdDown), you'd better to run it on thor50_dev. It was found that
   if running in thor400_dev, it is very slow.

The following tests indicated that the whole tests should be able to finish in two days even you run them one aftre another.

IntegrityTest:   			W20150730-111747 [Process 	50:07 Total cluster time 	48:47] 
											W20150730-142804 [Process 	1:16:44 Total cluster time 	44:54]
DotID iteration: 			W20150728-193327 [Process 	3:05:35 Total cluster time 	3:05:23] 	
											W20150729-132410 [Process 	9:05:13 Total cluster time 	9:05:02]
ProxSpec calculation:	W20150730-140631 [Process 	8:23 Total cluster time 	8:05]
											W20150730-131051 [Process 	48:42 Total cluster time 	48:13]
Mj6Spec calculation:	W20150730-093801 [Process 	24:59 Total cluster time 	24:28]			
											W20150730-101649 [Process 	10:55 Total cluster time 	10:40]
HRCHY iteration: 			W20150728-193219 [Process 	18:07 Total cluster time 	17:59]
											W20150728-215024 [Process 	18:14 Total cluster time 	18:05]
LGID3 iteration: 			W20150726-185954 [Process 	46:00 Total cluster time 	45:54]
											W20150730-144803 [Process 	38:17 Total cluster time 	38:09]
POWIDDown iteration: 	W20150728-131358 [Process 	39:02 Total cluster time 	38:18] 
											W20150728-135644 [Process 	29:28 Total cluster time 	29:15]
POWID iteration:			W20150730-170208 [Process 	29:47 Total cluster time 	29:40]
											W20150731-095050 [Process 	24:27 Total cluster time 	24:22]
EmpIdDown iteration (better run it on thor50_dev):	W20150726-195314 [Process 	50:14 Total cluster time 	50:07] 
											W20150730-132100 [Process 	27:30 Total cluster time 	27:21]
EmpID iteration: 			W20150727-140446 [Process 	38:23 Total cluster time 	38:18]
											W20150730-140600 [Process 	38:53 Total cluster time 	38:47]

*/