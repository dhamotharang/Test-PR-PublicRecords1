import ut;

EXPORT CreateStats(
										dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempFull)	MktFile,
										string	JobID
									 )	:= module;
									 
/*---------------------------------------------------------------------------------------------------------------------
| For the Business stats, we want to dedup the file by seleid/proxid. Counts will be based on this deduped file.
|----------------------------------------------------------------------------------------------------------------------*/										 
BusinessUnique	:=	dedup(sort(MktFile,seleid,proxid,local),seleid,proxid,local);
StatLayout			:=	Marketing_Suite_List_Gen.Layouts.Layout_stats_temp;

/*---------------------------------------------------------------------------------------------------------------------
| Generate Business type stats (business name, phone, state, county, city & zipcode)
|----------------------------------------------------------------------------------------------------------------------*/		
BusinessStatRec	:=	record
		unsigned8 CountGroup					:= count(group);
    NameCountNonZero              := sum(group,if(ut.CleanSpacesAndUpper(BusinessUnique.business_name)<>'',1,0));
    NameAverageNonZero            := ave(group,if(ut.CleanSpacesAndUpper(BusinessUnique.business_name)<>'',100,0));
    PhoneCountNonZero             := sum(group,if(ut.CleanSpacesAndUpper(BusinessUnique.phone)<>'',1,0));
    PhoneAverageNonZero           := ave(group,if(ut.CleanSpacesAndUpper(BusinessUnique.phone)<>'',100,0));
	  StateCountNonZero             := sum(group,if(ut.CleanSpacesAndUpper(BusinessUnique.state)<>'',1,0));
    StateAverageNonZero           := ave(group,if(ut.CleanSpacesAndUpper(BusinessUnique.state)<>'',100,0));
    CountyCountNonZero            := sum(group,if(ut.CleanSpacesAndUpper(BusinessUnique.county)<>'',1,0));
    CountyAverageNonZero          := ave(group,if(ut.CleanSpacesAndUpper(BusinessUnique.county)<>'',100,0));
    CityCountNonZero            	:= sum(group,if(ut.CleanSpacesAndUpper(BusinessUnique.City)<>'',1,0));
    CityAverageNonZero          	:= ave(group,if(ut.CleanSpacesAndUpper(BusinessUnique.City)<>'',100,0));	
    ZipcodeCountNonZero          	:= sum(group,if(ut.CleanSpacesAndUpper(BusinessUnique.Zip_code)<>'',1,0));
    ZipcodeAverageNonZero        	:= ave(group,if(ut.CleanSpacesAndUpper(BusinessUnique.Zip_code)<>'',100,0));	
		BusinessEmailsCountNonZero		:= sum(group,if(ut.CleanSpacesAndUpper(BusinessUnique.email)<>'',1,0));
    BusinessEmailsAverageNonZero	:= ave(group,if(ut.CleanSpacesAndUpper(BusinessUnique.email)<>'',100,0));	
    SICCodeCountNonZero   		   	:= sum(group,if(ut.CleanSpacesAndUpper(BusinessUnique.sic_primary)<>'',1,0));
    SICCodeAverageNonZero					:= ave(group,if(ut.CleanSpacesAndUpper(BusinessUnique.sic_primary)<>'',100,0));			
		NAICSCountNonZero							:= sum(group,if(ut.CleanSpacesAndUpper(BusinessUnique.naics_primary)<>'',1,0));
    NAICSAverageNonZero						:= ave(group,if(ut.CleanSpacesAndUpper(BusinessUnique.naics_primary)<>'',100,0));	
end;

pBusinessStat := table(BusinessUnique, BusinessStatRec, few);

/*---------------------------------------------------------------------------------------------------------------------
| Project this table into a stat file. We set unique_id to 1 in all these transforms so that we can roll all these 
| up together. 
|----------------------------------------------------------------------------------------------------------------------*/	
BusinessStatFile	:=	project(pBusinessStat,
															transform(StatLayout,
															self.unique_id									:=	1;
															self.Cnt_Companies_Returned			:=	left.NameCountNonZero;
															self.Per_Companies_Returned			:=	left.NameAverageNonZero;
															self.Cnt_Phones_Returned				:=	left.PhoneCountNonZero;
															self.Per_Phones_Returned				:=	left.PhoneAverageNonZero;		
															self.Cnt_States_Returned				:=	left.StateCountNonZero;
															self.Per_States_Returned				:=	left.StateAverageNonZero;
															self.Cnt_Counties_Returned			:=	left.CountyCountNonZero;
															self.Per_Counties_Returned			:=	left.COuntyAverageNonZero;
															self.Cnt_Cities_Returned				:=	left.CityCountNonZero;
															self.Per_Cities_Returned				:=	left.CityAverageNonZero;		
															self.Cnt_Zip_Codes_Returned			:=	left.ZipCodeCountNonZero;
															self.Per_Zip_Codes_Returned			:=	left.ZipCodeAverageNonZero;
															self.Cnt_Bus_Emails_Returned		:=	left.BusinessEmailsCountNonZero;
															self.Per_Bus_Emails_returned		:=	left.BusinessEmailsAverageNonZero;
															self.Cnt_Total_SIC							:=	left.SICCodeCountNonZero;
															self.Per_Total_SIC							:=	left.SICCodeAverageNonZero;
															self.Cnt_Total_NAICS						:=	left.NAICSCountNonZero;
															self.Per_Total_NAICS						:=	left.NAICSAverageNonZero;
															self.Cnt_Unique_Business_Recs		:=	left.CountGroup;	
															self														:=	[];
															)
															);

/*---------------------------------------------------------------------------------------------------------------------
| Generate Revenue stats. These stats are grouped into buckets. 
|----------------------------------------------------------------------------------------------------------------------*/	
RevenueStatRec	:=	record
		unsigned8 CountGroup							:= count(group);
    RevenueUnder150000            		:= sum(group,if(BusinessUnique.annual_revenue<150000,1,0));
    RevenueUnder150000_Average    		:= ave(group,if(BusinessUnique.annual_revenue<150000,100,0)); 
    Revenue150000_249999          		:= sum(group,if(BusinessUnique.annual_revenue>=150000 and 
																											BusinessUnique.annual_revenue<=249999,1,0));
    Revenue150000_249999_Average  		:= ave(group,if(BusinessUnique.annual_revenue>=150000 and 
																											BusinessUnique.annual_revenue<=249999,100,0)); 
    Revenue250000_499999          		:= sum(group,if(BusinessUnique.annual_revenue>=250000 and 
																											BusinessUnique.annual_revenue<=499999,1,0));
    Revenue250000_499999_Average  		:= ave(group,if(BusinessUnique.annual_revenue>=250000 and 
																											BusinessUnique.annual_revenue<=499999,100,0)); 
    Revenue500000_999999          		:= sum(group,if(BusinessUnique.annual_revenue>=500000 and 
																											BusinessUnique.annual_revenue<=999999,1,0));
    Revenue500000_999999_Average  		:= ave(group,if(BusinessUnique.annual_revenue>=500000 and 
																											BusinessUnique.annual_revenue<=999999,100,0)); 
    Revenue1000000_2499999        		:= sum(group,if(BusinessUnique.annual_revenue>=1000000 and 
																											BusinessUnique.annual_revenue<=2499999,1,0));
    Revenue1000000_2499999_Average		:= ave(group,if(BusinessUnique.annual_revenue>=1000000 and 
																											BusinessUnique.annual_revenue<=2499999,100,0)); 
    Revenue2500000_4999999          	:= sum(group,if(BusinessUnique.annual_revenue>=2500000 and 
																											BusinessUnique.annual_revenue<=4999999,1,0));
    Revenue2500000_4999999_Average  	:= ave(group,if(BusinessUnique.annual_revenue>=2500000 and 
																											BusinessUnique.annual_revenue<=4999999,100,0)); 		
    Revenue5000000_9999999          	:= sum(group,if(BusinessUnique.annual_revenue>=5000000 and 
																											BusinessUnique.annual_revenue<=9999999,1,0));
    Revenue5000000_9999999_Average  	:= ave(group,if(BusinessUnique.annual_revenue>=5000000 and 
																											BusinessUnique.annual_revenue<=9999999,100,0)); 	
    Revenue10000000_and_Above       	:= sum(group,if(BusinessUnique.annual_revenue>=10000000,1,0));
    Revenue10000000_and_Above_Average	:= ave(group,if(BusinessUnique.annual_revenue>=10000000,100,0)); 
end;

pRevenueStat := table(BusinessUnique, RevenueStatRec, few);

RevenueStatFile	:=	project(pRevenueStat,
														transform(Marketing_Suite_List_Gen.Layouts.Layout_stats_temp,
														self.unique_id											:=	1;
														self.Cnt_Revenue_Less_150000				:=	left.RevenueUnder150000;
														self.Per_Revenue_Less_150000				:=	left.RevenueUnder150000_Average;
														self.Cnt_Revenue_150000_249999	  	:=	left.Revenue150000_249999;
														self.Per_Revenue_150000_249999			:=	left.Revenue150000_249999_Average;
														self.Cnt_Revenue_250000_499999	  	:=	left.Revenue250000_499999;
														self.Per_Revenue_250000_499999 			:=	left.Revenue250000_499999_Average;
														self.Cnt_Revenue_500000_999999	  	:=	left.Revenue500000_999999;
														self.Per_Revenue_500000_999999			:=	left.Revenue500000_999999_Average;
														self.Cnt_Revenue_1000000_2499999  	:=	left.Revenue1000000_2499999;
														self.Per_Revenue_1000000_2499999		:=	left.Revenue1000000_2499999_Average;
														self.Cnt_Revenue_2500000_4999999 		:=	left.Revenue2500000_4999999;
														self.Per_Revenue_2500000_4999999		:=	left.Revenue2500000_4999999_Average;
														self.Cnt_Revenue_5000000_9999999		:=	left.Revenue5000000_9999999;
														self.Per_Revenue_5000000_9999999 		:=	left.Revenue5000000_9999999_Average;	
														self.Cnt_Revenue_10000000_and_Above :=	left.Revenue10000000_and_Above;
														self.Per_Revenue_10000000_and_Above :=	left.Revenue10000000_and_Above_Average;																					
														self																:=	[];
														)
														);												

/*---------------------------------------------------------------------------------------------------------------------
| Generate Number of Employee stats. These stats are grouped into buckets.
|----------------------------------------------------------------------------------------------------------------------*/															
EmployeeStatRec	:=	record
		unsigned8 CountGroup							:= count(group);
    Employees1				            		:= sum(group,if(BusinessUnique.num_employees=1,1,0));
    Employees1_Average    						:= ave(group,if(BusinessUnique.num_employees=1,100,0)); 
    Employees2_4					          	:= sum(group,if(BusinessUnique.num_employees>=2 and 
																											BusinessUnique.num_employees<=4,1,0));
    Employees2_4_Average				  		:= ave(group,if(BusinessUnique.num_employees>=2 and 
																											BusinessUnique.num_employees<=4,100,0)); 
    Employees5_9				          		:= sum(group,if(BusinessUnique.num_employees>=5 and 
																											BusinessUnique.num_employees<=9,1,0));
    Employees5_9_Average  						:= ave(group,if(BusinessUnique.num_employees>=5 and 
																											BusinessUnique.num_employees<=9,100,0)); 
    Employees10_19			          		:= sum(group,if(BusinessUnique.num_employees>=10 and 
																											BusinessUnique.num_employees<=19,1,0));
    Employees10_19_Average  					:= ave(group,if(BusinessUnique.num_employees>=10 and 
																											BusinessUnique.num_employees<=19,100,0)); 
    Employees20_49				        		:= sum(group,if(BusinessUnique.num_employees>=20 and 
																											BusinessUnique.num_employees<=49,1,0));
    Employees20_49_Average						:= ave(group,if(BusinessUnique.num_employees>=20 and 
																											BusinessUnique.num_employees<=49,100,0)); 
    Employees50_59				          	:= sum(group,if(BusinessUnique.num_employees>=50 and 
																											BusinessUnique.num_employees<=59,1,0));
    Employees50_59_Average  					:= ave(group,if(BusinessUnique.num_employees>=50 and 
																											BusinessUnique.num_employees<=59,100,0)); 		
    Employees100_249			          	:= sum(group,if(BusinessUnique.num_employees>=100 and 
																											BusinessUnique.num_employees<=249,1,0));
    Employees100_249_Average  				:= ave(group,if(BusinessUnique.num_employees>=100 and 
																											BusinessUnique.num_employees<=249,100,0)); 
    Employees250_499			          	:= sum(group,if(BusinessUnique.num_employees>=250 and 
																											BusinessUnique.num_employees<=499,1,0));
    Employees250_499_Average  				:= ave(group,if(BusinessUnique.num_employees>=250 and 
																											BusinessUnique.num_employees<=499,100,0));
    Employees500_749			          	:= sum(group,if(BusinessUnique.num_employees>=500 and 
																											BusinessUnique.num_employees<=749,1,0));
    Employees500_749_Average  				:= ave(group,if(BusinessUnique.num_employees>=500 and 
																											BusinessUnique.num_employees<=749,100,0));
    Employees750_999			          	:= sum(group,if(BusinessUnique.num_employees>=750 and 
																											BusinessUnique.num_employees<=999,1,0));
    Employees750_999_Average  				:= ave(group,if(BusinessUnique.num_employees>=750 and 
																											BusinessUnique.num_employees<=999,100,0));
    Employees1000_1249			         	:= sum(group,if(BusinessUnique.num_employees>=1000 and 
																											BusinessUnique.num_employees<=1249,1,0));
    Employees1000_1249_Average  			:= ave(group,if(BusinessUnique.num_employees>=1000 and 
																											BusinessUnique.num_employees<=1249,100,0));
    Employees1250_1499		          	:= sum(group,if(BusinessUnique.num_employees>=1250 and 
																											BusinessUnique.num_employees<=1499,1,0));
    Employees1250_1499_Average  			:= ave(group,if(BusinessUnique.num_employees>=1250 and 
																											BusinessUnique.num_employees<=1499,100,0));																											
    Employees1500_and_Above       		:= sum(group,if(BusinessUnique.num_employees>=1500,1,0));
    Employees1500_and_Above_Average		:= ave(group,if(BusinessUnique.num_employees>=1500,100,0)); 
end;

pEmployeeStat := table(BusinessUnique, EmployeeStatRec, few);

EmployeeStatFile	:=	project(pEmployeeStat,
															transform(Marketing_Suite_List_Gen.Layouts.Layout_stats_temp,
															self.unique_id										:=	1;
															self.Cnt_1_Employee 							:=	left.Employees1;
															self.Per_1_Employee 							:= 	left.Employees1_Average;
															self.Cnt_2_4_Employees 						:= 	left.Employees2_4;
															self.Per_2_4_Employees 						:= 	left.Employees2_4_Average;
															self.Cnt_5_9_Employees 						:= 	left.Employees5_9;
															self.Per_5_9_Employees 						:= 	left.Employees5_9_Average;
															self.Cnt_10_19_Employees 					:= 	left.Employees10_19;
															self.Per_10_19_Employees 					:= 	left.Employees10_19_Average;
															self.Cnt_20_49_Employees 					:= 	left.Employees20_49;
															self.Per_20_49_Employees 					:= 	left.Employees20_49_Average;
															self.Cnt_50_99_Employees 					:= 	left.Employees50_59;
															self.Per_50_99_Employees 					:= 	left.Employees50_59_Average;
															self.Cnt_100_249_Employees 				:= 	left.Employees100_249;
															self.Per_100_249_Employees 				:= 	left.Employees100_249_Average;
															self.Cnt_250_499_Employees 				:= 	left.Employees250_499;
															self.Per_250_499_Employees 				:= 	left.Employees250_499_Average;
															self.Cnt_500_749_Employees 				:= 	left.Employees500_749;
															self.Per_500_749_Employees 				:= 	left.Employees500_749_Average;
															self.Cnt_750_999_Employees 				:= 	left.Employees750_999;
															self.Per_750_999_Employees 				:= 	left.Employees750_999_Average;
															self.Cnt_1000_1249_Employees 			:= 	left.Employees1000_1249;
															self.Per_1000_1249_Employees 			:= 	left.Employees1000_1249_Average;
															self.Cnt_1250_1499_Employees 			:= 	left.Employees1250_1499;
															self.Per_1250_1499_Employees 			:= 	left.Employees1250_1499_Average;
															self.Cnt_1500_and_Above_Employees	:= 	left.Employees1500_and_Above;
															self.Per_1500_and_Above_Employees	:= 	left.Employees1500_and_Above_Average;
															self																	:=	[];
															)
															);	
															
/*---------------------------------------------------------------------------------------------------------------------
| Generate Years in Business stats. These stats are grouped into buckets.
|----------------------------------------------------------------------------------------------------------------------*/															
YearsStatRec	:=	record
		unsigned8 CountGroup					:= count(group);
    YearsLessThan2            		:= sum(group,if((integer)BusinessUnique.age<2,1,0));
    YearsLessThan2_Average 				:= ave(group,if((integer)BusinessUnique.age<2,100,0)); 
    Years2_5					          	:= sum(group,if((integer)BusinessUnique.age>=2 and 
																									(integer)BusinessUnique.age<=5,1,0));
    Years2_5_Average				  		:= ave(group,if((integer)BusinessUnique.age>=2 and 
																									(integer)BusinessUnique.age<=5,100,0)); 
    Years6_10				          		:= sum(group,if((integer)BusinessUnique.age>=6 and 
																									(integer)BusinessUnique.age<=10,1,0));
    Years6_10_Average  						:= ave(group,if((integer)BusinessUnique.age>=6 and 
																									(integer)BusinessUnique.age<=10,100,0)); 
    YearsGreaterThan10         		:= sum(group,if((integer)BusinessUnique.age>10,1,0));
    YearsGreaterThan10_Average  	:= ave(group,if((integer)BusinessUnique.age>10,100,0)); 
end;

pYearstat := table(BusinessUnique, YearsStatRec, few);

YearstatFile	:=	project(pYearstat,
													transform(Marketing_Suite_List_Gen.Layouts.Layout_stats_temp,
													self.unique_id										:=	1;
													self.Cnt_Less_Than_2_Years 				:=	left.YearsLessThan2;
													self.Per_Less_Than_2_Years 				:= 	left.YearsLessThan2_Average;
													self.Cnt_2_5_Years 								:= 	left.Years2_5;
													self.Per_2_5_Years 								:= 	left.Years2_5_Average;
													self.Cnt_6_10_Years 							:= 	left.Years6_10;
													self.Per_6_10_Years 							:= 	left.Years6_10_Average;
													self.Cnt_More_Than_10_Years 			:= 	left.YearsGreaterThan10;
													self.Per_More_Than_10_Years 			:= 	left.YearsGreaterThan10_Average;
													self															:=	[];
													)
													);															

/*---------------------------------------------------------------------------------------------------------------------
| Generate SIC code stats. The SIC stats are grouped into buckets however the buckets will be based on description
| groupigs and not number groupings. We are also only generating stats on the PRIMARY field.
|----------------------------------------------------------------------------------------------------------------------*/															
SIC1_Set	:=	[	'01','02','03','04','05','06','07','08','09'];
SIC2_Set	:=	[	'10','11','12','13','14'];
SIC3_Set	:=	[	'15','16','17'];
SIC4_Set	:=	[	'20','21','22','23','24','25','26','27','28','29',
								'30','31','32','33','34','35','36','37','38','39'];
SIC5_Set	:=	[	'40','41','42','43','44','45','46','47','48','49'];
SIC6_Set	:=	[	'50','51'];
SIC7_Set	:=	[	'52','53','54','55','56','57','58','59'];
SIC8_Set	:=	[	'60','61','62','63','64','65','66','67'];
SIC9_Set	:=	[	'70','71','72','73','74','75','76','77','78',
								'79','80','81','82','83','84','85','86','87',
								'88','89'];
SIC10_Set	:=	[	'90','91','92','93','94','95','96','97','98','99'];

FindTopSICRec	:=	record
		unsigned8 CountGroup	:= 	count(group);
    SIC_01_09					    := 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC1_set,1,0));
		SIC_01_09_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC1_set,100,0));
    SIC_10_14							:= 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC2_set,1,0)); 
		SIC_10_14_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC2_set,100,0));		
    SIC_15_17						  := 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC3_set,1,0));
		SIC_15_17_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC3_set,100,0));		
    SIC_20_39						  := 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC4_set,1,0));
		SIC_20_39_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC4_set,100,0));		
    SIC_40_49							:= 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC5_set,1,0)); 
		SIC_40_49_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC5_set,100,0));		
    SIC_50_51							:= 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC6_set,1,0)); 
		SIC_50_51_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC6_set,100,0));		
    SIC_52_59							:= 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC7_set,1,0)); 
		SIC_52_59_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC7_set,100,0));		
    SIC_60_67							:= 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC8_set,1,0));
		SIC_60_67_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC8_set,100,0));		
    SIC_70_89							:= 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC9_set,1,0)); 
		SIC_70_89_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC9_set,100,0));		
    SIC_90_99			        := 	sum(group,if(BusinessUnique.sic_primary[1..2] in SIC10_set,1,0));
		SIC_90_99_Percentage	:=	ave(group,if(BusinessUnique.sic_primary[1..2] in SIC10_set,100,0));	
end;

pTopSICStat := table(BusinessUnique, FindTopSICRec, few);

SicStatFile	:=	project(pTopSICStat,
												transform(Marketing_Suite_List_Gen.Layouts.Layout_stats_temp,
												self.unique_id																		:=	1;
												self.Cnt_SIC_Agriculture_Forestry_And_Fishing 		:= 	left.SIC_01_09;
												self.Per_SIC_Agriculture_Forestry_And_Fishing 		:= 	left.SIC_01_09_Percentage;
												self.Cnt_SIC_Mining 															:= 	left.SIC_10_14;
												self.Per_SIC_Mining 															:= 	left.SIC_10_14_Percentage;
												self.Cnt_SIC_Construction 												:= 	left.SIC_15_17;
												self.Per_SIC_Construction 												:= 	left.SIC_15_17_Percentage;
												self.Cnt_SIC_Manufacturing 												:=	left.SIC_20_39;
												self.Per_SIC_Manufacturing 												:=	left.SIC_20_39_Percentage;
												self.Cnt_SIC_Transportation_and_Public_Utilities	:= 	left.SIC_40_49;
												self.Per_SIC_Transportation_and_Public_Utilities	:= 	left.SIC_40_49_Percentage;
												self.Cnt_SIC_Wholesale_Trade 											:= 	left.SIC_50_51;
												self.Per_SIC_Wholesale_Trade 											:= 	left.SIC_50_51_Percentage;
												self.Cnt_SIC_Retail_Trade 												:= 	left.SIC_52_59;
												self.Per_SIC_Retail_Trade 												:= 	left.SIC_52_59_Percentage;
												self.Cnt_SIC_Finance_Insurance_and_Real_Estate 		:= 	left.SIC_60_67;
												self.Per_SIC_Finance_Insurance_and_Real_Estate 		:= 	left.SIC_60_67_Percentage;
												self.Cnt_SIC_Services 														:= 	left.SIC_70_89;
												self.Per_SIC_Services 														:= 	left.SIC_70_89_Percentage;
												self.Cnt_SIC_Public_Administration 								:= 	left.SIC_90_99;
												self.Per_SIC_Public_Administration 								:= 	left.SIC_90_99_Percentage;
												self																							:=	[];
												)
												);
												
/*---------------------------------------------------------------------------------------------------------------------
| Generate NAICS code stats. The NAICS stats are grouped into buckets however the buckets will be based on description
| groupings and not number groupings. We are also only generating stats on the PRIMARY field. Additionally, we are 
| only providing stats on the top 10 NAICS codes (based on counts)
|----------------------------------------------------------------------------------------------------------------------*/
FindTopNAICSRec	:=	record
		unsigned8		CountGroup	:= 	count(group);
    unsigned8		NAICS1_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '11',1,0));
    decimal8_2	NAICS1_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '11',100,0));
		
    unsigned8		NAICS2_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '21',1,0)); 
    decimal8_2	NAICS2_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '21',100,0)); 
		
    unsigned8		NAICS3_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '22',1,0));
    decimal8_2	NAICS3_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '22',100,0));
		
    unsigned8		NAICS4_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '23',1,0));
    decimal8_2	NAICS4_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '23',100,0));
		
    unsigned8		NAICS5_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '31' or
																							BusinessUnique.naics_primary[1..2] = '32' or 
																							BusinessUnique.naics_primary[1..2] = '33',1,0)); 
    decimal8_2	NAICS5_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '31' or
																							BusinessUnique.naics_primary[1..2] = '32' or 
																							BusinessUnique.naics_primary[1..2] = '33',100,0));
																						
    unsigned8		NAICS6_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '41',1,0)); 
    decimal8_2	NAICS6_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '41',100,0)); 
		
    unsigned8		NAICS7_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '44' or
																							BusinessUnique.naics_primary[1..2] = '45',1,0)); 
    decimal8_2	NAICS7_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '44' or
																							BusinessUnique.naics_primary[1..2] = '45',100,0));
																						
    unsigned8		NAICS8_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '48' or
																							BusinessUnique.naics_primary[1..2] = '49',1,0)); 
    decimal8_2	NAICS8_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '48' or
																							BusinessUnique.naics_primary[1..2] = '49',100,0));
																						
    unsigned8		NAICS9_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '51',1,0));
    decimal8_2	NAICS9_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '51',100,0));
		
    unsigned8		NAICS10_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '52',1,0)); 
    decimal8_2	NAICS10_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '52',100,0)); 
		
    unsigned8		NAICS11_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '53',1,0));
		decimal8_2	NAICS11_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '53',100,0));

    unsigned8		NAICS12_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '54',1,0));
    decimal8_2	NAICS12_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '54',100,0));
		
    unsigned8		NAICS13_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '55',1,0));
    decimal8_2	NAICS13_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '55',100,0));
		
    unsigned8		NAICS14_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '56',1,0));
    decimal8_2	NAICS14_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '56',100,0));
		
    unsigned8		NAICS15_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '61',1,0));
    decimal8_2	NAICS15_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '61',100,0));
		
    unsigned8		NAICS16_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '62',1,0));
    decimal8_2	NAICS16_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '62',100,0));
		
    unsigned8		NAICS17_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '71',1,0));
    decimal8_2	NAICS17_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '71',100,0));
		
    unsigned8		NAICS18_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '72',1,0));
    decimal8_2	NAICS18_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '72',100,0));
		
    unsigned8		NAICS19_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '81',1,0));
    decimal8_2	NAICS19_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '81',100,0));
		
    unsigned8		NAICS20_cnt	:= 	sum(group,if(	BusinessUnique.naics_primary[1..2] = '92',1,0));
    decimal8_2	NAICS20_per	:= 	ave(group,if(	BusinessUnique.naics_primary[1..2] = '92',100,0));
		
end;

pTopNAICSStat := table(BusinessUnique, FindTopNAICSRec, few);

TempLayout	:=	record
	unsigned1		Key;
	unsigned4 	NaicsType;
	unsigned8		NaicsCnt;
	decimal8_2	NaicsPer;
end;

TempLayout NormalizeNaics(FindTopNAICSRec l, unsigned4 c) := transform
		self.Key					:=	1;
		self.NaicsType		:=	c;
		self.NaicsCnt			:= 	choose(c,	l.NAICS1_cnt,		l.NAICS2_cnt,		l.NAICS3_cnt,		l.NAICS4_cnt,		l.NAICS5_cnt,
																		l.NAICS6_cnt,		l.NAICS7_cnt,		l.NAICS8_cnt,		l.NAICS9_cnt,		l.NAICS10_cnt,
																		l.NAICS11_cnt,	l.NAICS12_cnt,	l.NAICS13_cnt,	l.NAICS14_cnt,	l.NAICS15_cnt,
																		l.NAICS16_cnt,	l.NAICS17_cnt,	l.NAICS18_cnt,	l.NAICS19_cnt,	l.NAICS20_cnt);
		self.NaicsPer			:= 	choose(c,	l.NAICS1_Per,		l.NAICS2_Per,		l.NAICS3_Per,		l.NAICS4_Per,		l.NAICS5_Per,
																		l.NAICS6_Per,		l.NAICS7_Per,		l.NAICS8_Per,		l.NAICS9_Per,		l.NAICS10_Per,
																		l.NAICS11_Per,	l.NAICS12_Per,	l.NAICS13_Per,	l.NAICS14_Per,	l.NAICS15_Per,
																		l.NAICS16_Per,	l.NAICS17_Per,	l.NAICS18_Per,	l.NAICS19_Per,	l.NAICS20_Per);																		
end;
	
NormalizeNAICSFields 	:= 	normalize(pTopNAICSStat,20,NormalizeNaics(left, counter));
FindTop10							:=	dedup(sort(NormalizeNAICSFields,key,-naicsCnt),key,keep 10);

NaicsStatFile					:=	project(FindTop10,
											transform(Marketing_Suite_List_Gen.Layouts.Layout_stats_temp,
											self.unique_id																							:=	1;
											self.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting			:= 	if (left.NaicsType = 1,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting			:= 	if (left.NaicsType = 1,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction	:= 	if (left.NaicsType = 2,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction	:= 	if (left.NaicsType = 2,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Utilities																		:= 	if (left.NaicsType = 3,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Utilities																		:= 	if (left.NaicsType = 3,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Construction																	:= 	if (left.NaicsType = 4,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Construction																	:= 	if (left.NaicsType = 4,
																																													left.NaicsPer,
																																													0);	
											self.Cnt_NAICS_Manufacturing																:= 	if (left.NaicsType = 5,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Manufacturing																:= 	if (left.NaicsType = 5,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Wholesale_Trade															:= 	if (left.NaicsType = 6,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Wholesale_Trade															:= 	if (left.NaicsType = 6,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Retail_Trade																	:= 	if (left.NaicsType = 7,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Retail_Trade																	:= 	if (left.NaicsType = 7,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Transportation_and_Warehousing								:= 	if (left.NaicsType = 8,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Transportation_and_Warehousing								:= 	if (left.NaicsType = 8,
																																													left.NaicsPer,
																																													0);	
											self.Cnt_NAICS_Information																	:= 	if (left.NaicsType = 9,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Information																	:= 	if (left.NaicsType = 9,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Finance_and_Insurance												:= 	if (left.NaicsType = 10,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Finance_and_Insurance												:= 	if (left.NaicsType = 10,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Real_Estate_Rental_and_Leasing								:= 	if (left.NaicsType = 11,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Real_Estate_Rental_and_Leasing								:= 	if (left.NaicsType = 11,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Professional_Scientific_Technical_Services		:= 	if (left.NaicsType = 12,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Professional_Scientific_Technical_Services		:= 	if (left.NaicsType = 12,
																																													left.NaicsPer,
																																													0);	
											self.Cnt_NAICS_Management_of_Companies_and_Enterprises			:= 	if (left.NaicsType = 13,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Management_of_Companies_and_Enterprises			:= 	if (left.NaicsType = 13,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices	:= 	if (left.NaicsType = 14,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices	:= 	if (left.NaicsType = 14,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Educational_Services													:= 	if (left.NaicsType = 15,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Educational_Services													:= 	if (left.NaicsType = 15,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_HealthCare_and_SocialAssistance							:= 	if (left.NaicsType = 16,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_HealthCare_and_SocialAssistance							:= 	if (left.NaicsType = 16,
																																													left.NaicsPer,
																																													0);	
											self.Cnt_NAICS_Arts_Entertainment_and_Recreation						:= 	if (left.NaicsType = 17,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Arts_Entertainment_and_Recreation						:= 	if (left.NaicsType = 17,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Accommodation_and_Food_Services							:= 	if (left.NaicsType = 18,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Accommodation_and_Food_Services							:= 	if (left.NaicsType = 18,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Other_Services_except_Public_Administration	:= 	if (left.NaicsType = 19,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Other_Services_except_Public_Administration	:= 	if (left.NaicsType = 19,
																																													left.NaicsPer,
																																													0);
											self.Cnt_NAICS_Public_Administration												:= 	if (left.NaicsType = 20,
																																													left.NaicsCnt,
																																													0);
											self.Per_NAICS_Public_Administration												:= 	if (left.NaicsType = 20,
																																													left.NaicsPer,
																																													0);																																														
											self																												:=	[];
											)
											);
														
SrtNaicsStatFile	:=	Sort(NaicsStatFile,unique_id);

/*---------------------------------------------------------------------------------------------------------------------
| Since we are only generating stats on the top 10, we need to rollup the NAICS stat file.
|----------------------------------------------------------------------------------------------------------------------*/
Marketing_Suite_List_Gen.Layouts.Layout_stats_temp RollupNaics(Marketing_Suite_List_Gen.Layouts.Layout_stats_temp l, Marketing_Suite_List_Gen.Layouts.Layout_stats_temp r) := transform
	self.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting			:= 	if (l.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting > r.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting, 
																																			l.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting, 
																																			r.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting);
	self.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting			:= 	if (l.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting > r.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting, 
																																			l.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting, 
																																			r.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting);
	self.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction	:= 	if (l.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction > r.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction, 
																																			l.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction, 
																																			r.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction);
	self.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction	:= 	if (l.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction > r.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction, 
																																			l.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction, 
																																			r.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction);
	self.Cnt_NAICS_Utilities																		:= 	if (l.Cnt_NAICS_Utilities > r.Cnt_NAICS_Utilities, 
																																			l.Cnt_NAICS_Utilities, 
																																			r.Cnt_NAICS_Utilities);
	self.Per_NAICS_Utilities																		:= 	if (l.Per_NAICS_Utilities > r.Per_NAICS_Utilities, 
																																			l.Per_NAICS_Utilities, 
																																			r.Per_NAICS_Utilities);
	self.Cnt_NAICS_Construction																	:= 	if (l.Cnt_NAICS_Construction > r.Cnt_NAICS_Construction, 
																																			l.Cnt_NAICS_Construction, 
																																			r.Cnt_NAICS_Construction);
	self.Per_NAICS_Construction																	:= 	if (l.Per_NAICS_Construction > r.Per_NAICS_Construction, 
																																			l.Per_NAICS_Construction, 
																																			r.Per_NAICS_Construction);
	self.Cnt_NAICS_Manufacturing																:= 	if (l.Cnt_NAICS_Manufacturing > r.Cnt_NAICS_Manufacturing, 
																																			l.Cnt_NAICS_Manufacturing, 
																																			r.Cnt_NAICS_Manufacturing);
	self.Per_NAICS_Manufacturing																:= 	if (l.Per_NAICS_Manufacturing > r.Per_NAICS_Manufacturing, 
																																			l.Per_NAICS_Manufacturing, 
																																			r.Per_NAICS_Manufacturing);
	self.Cnt_NAICS_Wholesale_Trade															:= 	if (l.Cnt_NAICS_Wholesale_Trade > r.Cnt_NAICS_Wholesale_Trade, 
																																			l.Cnt_NAICS_Wholesale_Trade, 
																																			r.Cnt_NAICS_Wholesale_Trade);
	self.Per_NAICS_Wholesale_Trade															:= 	if (l.Per_NAICS_Wholesale_Trade > r.Per_NAICS_Wholesale_Trade, 
																																			l.Per_NAICS_Wholesale_Trade, 
																																			r.Per_NAICS_Wholesale_Trade);
	self.Cnt_NAICS_Retail_Trade																	:= 	if (l.Cnt_NAICS_Retail_Trade > r.Cnt_NAICS_Retail_Trade, 
																																			l.Cnt_NAICS_Retail_Trade, 
																																			r.Cnt_NAICS_Retail_Trade);
	self.Per_NAICS_Retail_Trade																	:= 	if (l.Per_NAICS_Retail_Trade > r.Per_NAICS_Retail_Trade, 
																																			l.Per_NAICS_Retail_Trade, 
																																			r.Per_NAICS_Retail_Trade);
	self.Cnt_NAICS_Transportation_and_Warehousing								:= 	if (l.Cnt_NAICS_Transportation_and_Warehousing > r.Cnt_NAICS_Transportation_and_Warehousing, 
																																			l.Cnt_NAICS_Transportation_and_Warehousing, 
																																			r.Cnt_NAICS_Transportation_and_Warehousing);
	self.Per_NAICS_Transportation_and_Warehousing								:= 	if (l.Per_NAICS_Transportation_and_Warehousing > r.Per_NAICS_Transportation_and_Warehousing, 
																																			l.Per_NAICS_Transportation_and_Warehousing, 
																																			r.Per_NAICS_Transportation_and_Warehousing);
	self.Cnt_NAICS_Information																	:= 	if (l.Cnt_NAICS_Information > r.Cnt_NAICS_Information, 
																																			l.Cnt_NAICS_Information, 
																																			r.Cnt_NAICS_Information);
	self.Per_NAICS_Information																	:= 	if (l.Per_NAICS_Information > r.Per_NAICS_Information, 
																																			l.Per_NAICS_Information, 
																																			r.Per_NAICS_Information);
	self.Cnt_NAICS_Finance_and_Insurance												:= 	if (l.Cnt_NAICS_Finance_and_Insurance > r.Cnt_NAICS_Finance_and_Insurance, 
																																			l.Cnt_NAICS_Finance_and_Insurance, 
																																			r.Cnt_NAICS_Finance_and_Insurance);
	self.Per_NAICS_Finance_and_Insurance												:= 	if (l.Per_NAICS_Finance_and_Insurance > r.Per_NAICS_Finance_and_Insurance, 
																																			l.Per_NAICS_Finance_and_Insurance, 
																																			r.Per_NAICS_Finance_and_Insurance);
	self.Cnt_NAICS_Real_Estate_Rental_and_Leasing								:= 	if (l.Cnt_NAICS_Real_Estate_Rental_and_Leasing > r.Cnt_NAICS_Real_Estate_Rental_and_Leasing, 
																																			l.Cnt_NAICS_Real_Estate_Rental_and_Leasing, 
																																			r.Cnt_NAICS_Real_Estate_Rental_and_Leasing);
	self.Per_NAICS_Real_Estate_Rental_and_Leasing								:= 	if (l.Per_NAICS_Real_Estate_Rental_and_Leasing > r.Per_NAICS_Real_Estate_Rental_and_Leasing, 
																																			l.Per_NAICS_Real_Estate_Rental_and_Leasing, 
																																			r.Per_NAICS_Real_Estate_Rental_and_Leasing);
	self.Cnt_NAICS_Professional_Scientific_Technical_Services		:= 	if (l.Cnt_NAICS_Professional_Scientific_Technical_Services > r.Cnt_NAICS_Professional_Scientific_Technical_Services, 
																																			l.Cnt_NAICS_Professional_Scientific_Technical_Services, 
																																			r.Cnt_NAICS_Professional_Scientific_Technical_Services);
	self.Per_NAICS_Professional_Scientific_Technical_Services		:= 	if (l.Per_NAICS_Professional_Scientific_Technical_Services > r.Per_NAICS_Professional_Scientific_Technical_Services, 
																																			l.Per_NAICS_Professional_Scientific_Technical_Services, 
																																			r.Per_NAICS_Professional_Scientific_Technical_Services);
	self.Cnt_NAICS_Management_of_Companies_and_Enterprises			:= 	if (l.Cnt_NAICS_Management_of_Companies_and_Enterprises > r.Cnt_NAICS_Management_of_Companies_and_Enterprises, 
																																			l.Cnt_NAICS_Management_of_Companies_and_Enterprises, 
																																			r.Cnt_NAICS_Management_of_Companies_and_Enterprises);
	self.Per_NAICS_Management_of_Companies_and_Enterprises			:= 	if (l.Per_NAICS_Management_of_Companies_and_Enterprises > r.Per_NAICS_Management_of_Companies_and_Enterprises, 
																																			l.Per_NAICS_Management_of_Companies_and_Enterprises, 
																																			r.Per_NAICS_Management_of_Companies_and_Enterprises);
	self.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices	:= 	if (l.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices > r.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices, 
																																			l.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices, 
																																			r.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices);
	self.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices	:= 	if (l.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices > r.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices, 
																																			l.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices, 
																																			r.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices);
	self.Cnt_NAICS_Educational_Services													:= 	if (l.Cnt_NAICS_Educational_Services > r.Cnt_NAICS_Educational_Services, 
																																			l.Cnt_NAICS_Educational_Services, 
																																			r.Cnt_NAICS_Educational_Services);
	self.Per_NAICS_Educational_Services													:= 	if (l.Per_NAICS_Educational_Services > r.Per_NAICS_Educational_Services, 
																																			l.Per_NAICS_Educational_Services, 
																																			r.Per_NAICS_Educational_Services);
	self.Cnt_NAICS_HealthCare_and_SocialAssistance							:= 	if (l.Cnt_NAICS_HealthCare_and_SocialAssistance > r.Cnt_NAICS_HealthCare_and_SocialAssistance, 
																																			l.Cnt_NAICS_HealthCare_and_SocialAssistance, 
																																			r.Cnt_NAICS_HealthCare_and_SocialAssistance);
	self.Per_NAICS_HealthCare_and_SocialAssistance							:= 	if (l.Per_NAICS_HealthCare_and_SocialAssistance > r.Per_NAICS_HealthCare_and_SocialAssistance, 
																																			l.Per_NAICS_HealthCare_and_SocialAssistance, 
																																			r.Per_NAICS_HealthCare_and_SocialAssistance);
	self.Cnt_NAICS_Arts_Entertainment_and_Recreation						:= 	if (l.Cnt_NAICS_Arts_Entertainment_and_Recreation > r.Cnt_NAICS_Arts_Entertainment_and_Recreation, 
																																			l.Cnt_NAICS_Arts_Entertainment_and_Recreation, 
																																			r.Cnt_NAICS_Arts_Entertainment_and_Recreation);
	self.Per_NAICS_Arts_Entertainment_and_Recreation						:= 	if (l.Per_NAICS_Arts_Entertainment_and_Recreation > r.Per_NAICS_Arts_Entertainment_and_Recreation, 
																																			l.Per_NAICS_Arts_Entertainment_and_Recreation, 
																																			r.Per_NAICS_Arts_Entertainment_and_Recreation);
	self.Cnt_NAICS_Accommodation_and_Food_Services							:= 	if (l.Cnt_NAICS_Accommodation_and_Food_Services > r.Cnt_NAICS_Accommodation_and_Food_Services, 
																																			l.Cnt_NAICS_Accommodation_and_Food_Services, 
																																			r.Cnt_NAICS_Accommodation_and_Food_Services);
	self.Per_NAICS_Accommodation_and_Food_Services							:= 	if (l.Per_NAICS_Accommodation_and_Food_Services > r.Per_NAICS_Accommodation_and_Food_Services, 
																																			l.Per_NAICS_Accommodation_and_Food_Services, 
																																			r.Per_NAICS_Accommodation_and_Food_Services);
	self.Cnt_NAICS_Other_Services_except_Public_Administration	:= 	if (l.Cnt_NAICS_Other_Services_except_Public_Administration > r.Cnt_NAICS_Other_Services_except_Public_Administration, 
																																			l.Cnt_NAICS_Other_Services_except_Public_Administration, 
																																			r.Cnt_NAICS_Other_Services_except_Public_Administration);
	self.Per_NAICS_Other_Services_except_Public_Administration	:= 	if (l.Per_NAICS_Other_Services_except_Public_Administration > r.Per_NAICS_Other_Services_except_Public_Administration, 
																																			l.Per_NAICS_Other_Services_except_Public_Administration, 
																																			r.Per_NAICS_Other_Services_except_Public_Administration);
	self.Cnt_NAICS_Public_Administration												:= 	if (l.Cnt_NAICS_Public_Administration > r.Cnt_NAICS_Public_Administration, 
																																			l.Cnt_NAICS_Public_Administration, 
																																			r.Cnt_NAICS_Public_Administration);
	self.Per_NAICS_Public_Administration												:= 	if (l.Per_NAICS_Public_Administration > r.Per_NAICS_Public_Administration, 
																																			l.Per_NAICS_Public_Administration, 
																																			r.Per_NAICS_Public_Administration);

	self := l;
end;

NaicsRollup := rollup(	SrtNaicsStatFile, RollupNaics(left, right), unique_id);
												
/*---------------------------------------------------------------------------------------------------------------------
| Now generate stats on the contact fields.
|----------------------------------------------------------------------------------------------------------------------*/	

// Get a set of Exective titles.											
ExecTitleSet	:=	Marketing_Suite_List_Gen.fnGetExecTitles;

ContactStatRec	:=	record
		unsigned8 CountGroup				:= count(group);
    Contact_Address							:= sum(group,if(ut.CleanSpacesAndUpper(	MktFile.contact_address) 				<>'' and 
																								ut.CleanSpacesAndUpper(	MktFile.contact_city) 					<>'' and  
																								ut.CleanSpacesAndUpper(	MktFile.contact_state) 					<>'' and
																								ut.CleanSpacesAndUpper(	MktFile.contact_zip5)						<>'',1,0));
    Contact_Address_Average			:= ave(group,if(ut.CleanSpacesAndUpper(	MktFile.contact_address)			 	<>'' and 
																								ut.CleanSpacesAndUpper(	MktFile.contact_city) 					<>'' and  
																								ut.CleanSpacesAndUpper(	MktFile.contact_state) 					<>'' and
																								ut.CleanSpacesAndUpper(	MktFile.contact_zip5)						<>'',100,0)); 
    Contact_email								:= sum(group,if(ut.CleanSpacesAndUpper(	MktFile.contact_email_address)	<>'',1,0));
    Contact_email_Average				:= ave(group,if(ut.CleanSpacesAndUpper(	MktFile.contact_email_address)	<>'',100,0)); 
    Contact_title								:= sum(group,if(ut.CleanSpacesAndUpper(	MktFile.title) 									in ExecTitleSet or
																								ut.CleanSpacesAndUpper(	MktFile.title2) 								in ExecTitleSet or
																								ut.CleanSpacesAndUpper(	MktFile.title3) 								in ExecTitleSet or
																								ut.CleanSpacesAndUpper(	MktFile.title4) 								in ExecTitleSet or
																								ut.CleanSpacesAndUpper(	MktFile.title5) 								in ExecTitleSet,1,0));
    Contact_title_Average				:= ave(group,if(ut.CleanSpacesAndUpper(	MktFile.title) 									in ExecTitleSet or
																								ut.CleanSpacesAndUpper(	MktFile.title2)									in ExecTitleSet or
																								ut.CleanSpacesAndUpper(	MktFile.title3)									in ExecTitleSet or
																								ut.CleanSpacesAndUpper(	MktFile.title4)									in ExecTitleSet or
																								ut.CleanSpacesAndUpper(	MktFile.title5)									in ExecTitleSet,100,0)); 
		Contact_lexid					     	:= sum(group,if(MktFile.lexid																						<>0,1,0));
    Contact_lexid_Average				:= ave(group,if(MktFile.lexid																						<>0,100,0));
end;

pContactStat 		:= 	table(MktFile, ContactStatRec, few);

ContactStatFile	:=	project(pContactStat,
															transform(Marketing_Suite_List_Gen.Layouts.Layout_stats_temp,
															self.unique_id										:=	1;
															self.Cnt_Contact_Address					:=	left.Contact_Address;
															self.Per_Contact_Address 					:= 	left.Contact_Address_Average;
															self.Cnt_Contact_Email 						:= 	left.Contact_email;
															self.Per_Contact_Email 						:= 	left.Contact_email_Average;
															self.Cnt_Contact_Title 						:= 	left.Contact_title;
															self.Per_Contact_Title 						:= 	left.Contact_title_Average;
															self.Cnt_Contact_Lexid						:=	left.Contact_lexid;
															self.Per_Contact_Lexid	 					:= 	left.Contact_lexid_Average;
															self.Cnt_Unique_Contact_Recs			:=	left.CountGroup;
															self															:=	[];
															)
															);
															
/*---------------------------------------------------------------------------------------------------------------------
| Combine all stats and then rollup based on the unique id. 
|----------------------------------------------------------------------------------------------------------------------*/
AllFiles		:=	BusinessStatFile + RevenueStatFile + EmployeeStatFile + YearstatFile + SicStatFile + NaicsRollup + ContactStatFile;

SrtAllFile	:=	Sort(AllFiles,unique_id);

StatLayout RollupAll(StatLayout l, StatLayout r) := transform
	self.Cnt_Companies_Returned																	:=	if (l.Cnt_Companies_Returned > r.Cnt_Companies_Returned, 
																																			l.Cnt_Companies_Returned, 
																																			r.Cnt_Companies_Returned);
	self.Per_Companies_Returned																	:=	if (l.Per_Companies_Returned > r.Per_Companies_Returned, 
																																			l.Per_Companies_Returned, 
																																			r.Per_Companies_Returned);
	self.Cnt_Phones_Returned																		:=	if (l.Cnt_Phones_Returned > r.Cnt_Phones_Returned, 
																																			l.Cnt_Phones_Returned, 
																																			r.Cnt_Phones_Returned);
	self.Per_Phones_Returned																		:=	if (l.Per_Phones_Returned > r.Per_Phones_Returned, 
																																			l.Per_Phones_Returned, 
																																			r.Per_Phones_Returned);		
	self.Cnt_States_Returned																		:=	if (l.Cnt_States_Returned > r.Cnt_States_Returned, 
																																			l.Cnt_States_Returned, 
																																			r.Cnt_States_Returned);
	self.Per_States_Returned																		:=	if (l.Per_States_Returned > r.Per_States_Returned, 
																																			l.Per_States_Returned, 
																																			r.Per_States_Returned);
	self.Cnt_Counties_Returned																	:=	if (l.Cnt_Counties_Returned > r.Cnt_Counties_Returned, 
																																			l.Cnt_Counties_Returned, 
																																			r.Cnt_Counties_Returned);
	self.Per_Counties_Returned																	:=	if (l.Per_Counties_Returned > r.Per_Counties_Returned, 
																																			l.Per_Counties_Returned, 
																																			r.Per_Counties_Returned);
	self.Cnt_Cities_Returned																		:=	if (l.Cnt_Cities_Returned > r.Cnt_Cities_Returned, 
																																			l.Cnt_Cities_Returned, 
																																			r.Cnt_Cities_Returned);
	self.Per_Cities_Returned																		:=	if (l.Per_Cities_Returned > r.Per_Cities_Returned, 
																																			l.Per_Cities_Returned, 
																																			r.Per_Cities_Returned);		
	self.Cnt_Zip_Codes_Returned																	:=	if (l.Cnt_Zip_Codes_Returned > r.Cnt_Zip_Codes_Returned, 
																																			l.Cnt_Zip_Codes_Returned, 
																																			r.Cnt_Zip_Codes_Returned);
	self.Per_Zip_Codes_Returned																	:=	if (l.Per_Zip_Codes_Returned > r.Per_Zip_Codes_Returned, 
																																			l.Per_Zip_Codes_Returned, 
																																			r.Per_Zip_Codes_Returned);
	self.Cnt_Unique_Business_Recs																:=	if (l.Cnt_Unique_Business_Recs > r.Cnt_Unique_Business_Recs, 
																																			l.Cnt_Unique_Business_Recs, 
																																			r.Cnt_Unique_Business_Recs);																																	
	self.Cnt_Revenue_Less_150000																:=	if (l.Cnt_Revenue_Less_150000 > r.Cnt_Revenue_Less_150000, 
																																			l.Cnt_Revenue_Less_150000, 
																																			r.Cnt_Revenue_Less_150000);
	self.Per_Revenue_Less_150000																:=	if (l.Per_Revenue_Less_150000 > r.Per_Revenue_Less_150000, 
																																			l.Per_Revenue_Less_150000, 
																																			r.Per_Revenue_Less_150000);
	self.Cnt_Revenue_150000_249999															:=	if (l.Cnt_Revenue_150000_249999 > r.Cnt_Revenue_150000_249999, 
																																			l.Cnt_Revenue_150000_249999, 
																																			r.Cnt_Revenue_150000_249999);
	self.Per_Revenue_150000_249999															:=	if (l.Per_Revenue_150000_249999 > r.Per_Revenue_150000_249999, 
																																			l.Per_Revenue_150000_249999, 
																																			r.Per_Revenue_150000_249999);
	self.Cnt_Revenue_250000_499999															:=	if (l.Cnt_Revenue_250000_499999 > r.Cnt_Revenue_250000_499999, 
																																			l.Cnt_Revenue_250000_499999, 
																																			r.Cnt_Revenue_250000_499999);
	self.Per_Revenue_250000_499999															:=	if (l.Per_Revenue_250000_499999 > r.Per_Revenue_250000_499999, 
																																			l.Per_Revenue_250000_499999, 
																																			r.Per_Revenue_250000_499999);
	self.Cnt_Revenue_500000_999999															:=	if (l.Cnt_Revenue_500000_999999 > r.Cnt_Revenue_500000_999999, 
																																			l.Cnt_Revenue_500000_999999, 
																																			r.Cnt_Revenue_500000_999999);
	self.Per_Revenue_500000_999999															:=	if (l.Per_Revenue_500000_999999 > r.Per_Revenue_500000_999999, 
																																			l.Per_Revenue_500000_999999, 
																																			r.Per_Revenue_500000_999999);
	self.Cnt_Revenue_1000000_2499999														:=	if (l.Cnt_Revenue_1000000_2499999 > r.Cnt_Revenue_1000000_2499999, 
																																			l.Cnt_Revenue_1000000_2499999, 
																																			r.Cnt_Revenue_1000000_2499999);
	self.Per_Revenue_1000000_2499999														:=	if (l.Per_Revenue_1000000_2499999 > r.Per_Revenue_1000000_2499999, 
																																			l.Per_Revenue_1000000_2499999, 
																																			r.Per_Revenue_1000000_2499999);		
	self.Cnt_Revenue_2500000_4999999														:=	if (l.Cnt_Revenue_2500000_4999999 > r.Cnt_Revenue_2500000_4999999, 
																																			l.Cnt_Revenue_2500000_4999999, 
																																			r.Cnt_Revenue_2500000_4999999);
	self.Per_Revenue_2500000_4999999														:=	if (l.Per_Revenue_2500000_4999999 > r.Per_Revenue_2500000_4999999, 
																																			l.Per_Revenue_2500000_4999999, 
																																			r.Per_Revenue_2500000_4999999);	
	self.Cnt_Revenue_5000000_9999999														:=	if (l.Cnt_Revenue_5000000_9999999 > r.Cnt_Revenue_5000000_9999999, 
																																			l.Cnt_Revenue_5000000_9999999, 
																																			r.Cnt_Revenue_5000000_9999999);
	self.Per_Revenue_5000000_9999999														:=	if (l.Per_Revenue_5000000_9999999 > r.Per_Revenue_5000000_9999999, 
																																			l.Per_Revenue_5000000_9999999, 
																																			r.Per_Revenue_5000000_9999999);		
	self.Cnt_Revenue_10000000_and_Above													:=	if (l.Cnt_Revenue_10000000_and_Above > r.Cnt_Revenue_10000000_and_Above, 
																																			l.Cnt_Revenue_10000000_and_Above, 
																																			r.Cnt_Revenue_10000000_and_Above);
	self.Per_Revenue_10000000_and_Above													:=	if (l.Per_Revenue_10000000_and_Above > r.Per_Revenue_10000000_and_Above, 
																																			l.Per_Revenue_10000000_and_Above, 
																																			r.Per_Revenue_10000000_and_Above);	
	self.Cnt_1_Employee																					:=	if (l.Cnt_1_Employee > r.Cnt_1_Employee, 
																																			l.Cnt_1_Employee, 
																																			r.Cnt_1_Employee);
	self.Per_1_Employee																					:=	if (l.Per_1_Employee > r.Per_1_Employee, 
																																			l.Per_1_Employee, 
																																			r.Per_1_Employee);		
	self.Cnt_2_4_Employees																			:=	if (l.Cnt_2_4_Employees > r.Cnt_2_4_Employees, 
																																			l.Cnt_2_4_Employees, 
																																			r.Cnt_2_4_Employees);
	self.Per_2_4_Employees																			:=	if (l.Per_2_4_Employees > r.Per_2_4_Employees, 
																																			l.Per_2_4_Employees, 
																																			r.Per_2_4_Employees);
	self.Cnt_5_9_Employees																			:=	if (l.Cnt_5_9_Employees > r.Cnt_5_9_Employees, 
																																			l.Cnt_5_9_Employees, 
																																			r.Cnt_5_9_Employees);
	self.Per_5_9_Employees																			:=	if (l.Per_5_9_Employees > r.Per_5_9_Employees, 
																																			l.Per_5_9_Employees, 
																																			r.Per_5_9_Employees);
	self.Cnt_10_19_Employees																		:=	if (l.Cnt_10_19_Employees > r.Cnt_10_19_Employees, 
																																			l.Cnt_10_19_Employees, 
																																			r.Cnt_10_19_Employees);
	self.Per_10_19_Employees																		:=	if (l.Per_10_19_Employees > r.Per_10_19_Employees, 
																																			l.Per_10_19_Employees, 
																																			r.Per_10_19_Employees);
	self.Cnt_20_49_Employees																		:=	if (l.Cnt_20_49_Employees > r.Cnt_20_49_Employees, 
																																			l.Cnt_20_49_Employees, 
																																			r.Cnt_20_49_Employees);
	self.Per_20_49_Employees																		:=	if (l.Per_20_49_Employees > r.Per_20_49_Employees, 
																																			l.Per_20_49_Employees, 
																																			r.Per_20_49_Employees);
	self.Cnt_50_99_Employees																		:=	if (l.Cnt_50_99_Employees > r.Cnt_50_99_Employees, 
																																			l.Cnt_50_99_Employees, 
																																			r.Cnt_50_99_Employees);
	self.Per_50_99_Employees																		:=	if (l.Per_50_99_Employees > r.Per_50_99_Employees, 
																																			l.Per_50_99_Employees, 
																																			r.Per_50_99_Employees);
	self.Cnt_100_249_Employees																	:=	if (l.Cnt_100_249_Employees > r.Cnt_100_249_Employees, 
																																			l.Cnt_100_249_Employees, 
																																			r.Cnt_100_249_Employees);
	self.Per_100_249_Employees																	:=	if (l.Per_100_249_Employees > r.Per_100_249_Employees, 
																																			l.Per_100_249_Employees, 
																																			r.Per_100_249_Employees);
	self.Cnt_250_499_Employees																	:=	if (l.Cnt_250_499_Employees > r.Cnt_250_499_Employees, 
																																			l.Cnt_250_499_Employees, 
																																			r.Cnt_250_499_Employees);
	self.Per_250_499_Employees																	:=	if (l.Per_250_499_Employees > r.Per_250_499_Employees, 
																																			l.Per_250_499_Employees, 
																																			r.Per_250_499_Employees);
	self.Cnt_500_749_Employees																	:=	if (l.Cnt_500_749_Employees > r.Cnt_500_749_Employees, 
																																			l.Cnt_500_749_Employees, 
																																			r.Cnt_500_749_Employees);
	self.Per_500_749_Employees																	:=	if (l.Per_500_749_Employees > r.Per_500_749_Employees, 
																																			l.Per_500_749_Employees, 
																																			r.Per_500_749_Employees);
	self.Cnt_750_999_Employees																	:=	if (l.Cnt_750_999_Employees > r.Cnt_750_999_Employees, 
																																			l.Cnt_750_999_Employees, 
																																			r.Cnt_750_999_Employees);
	self.Per_750_999_Employees																	:= 	if (l.Per_750_999_Employees > r.Per_750_999_Employees, 
																																			l.Per_750_999_Employees, 
																																			r.Per_750_999_Employees);
	self.Cnt_1000_1249_Employees																:= 	if (l.Cnt_1000_1249_Employees > r.Cnt_1000_1249_Employees, 
																																			l.Cnt_1000_1249_Employees, 
																																			r.Cnt_1000_1249_Employees);
	self.Per_1000_1249_Employees																:= 	if (l.Per_1000_1249_Employees > r.Per_1000_1249_Employees, 
																																			l.Per_1000_1249_Employees, 
																																			r.Per_1000_1249_Employees);
	self.Cnt_1250_1499_Employees																:= 	if (l.Cnt_1250_1499_Employees > r.Cnt_1250_1499_Employees, 
																																			l.Cnt_1250_1499_Employees, 
																																			r.Cnt_1250_1499_Employees);
	self.Per_1250_1499_Employees																:=	if (l.Per_1250_1499_Employees > r.Per_1250_1499_Employees, 
																																			l.Per_1250_1499_Employees, 
																																			r.Per_1250_1499_Employees);
	self.Cnt_1500_and_Above_Employees														:=	if (l.Cnt_1500_and_Above_Employees > r.Cnt_1500_and_Above_Employees, 
																																			l.Cnt_1500_and_Above_Employees, 
																																			r.Cnt_1500_and_Above_Employees);
	self.Per_1500_and_Above_Employees														:=	if (l.Per_1500_and_Above_Employees > r.Per_1500_and_Above_Employees, 
																																			l.Per_1500_and_Above_Employees, 
																																			r.Per_1500_and_Above_Employees);
	self.Cnt_SIC_Agriculture_Forestry_And_Fishing								:=	if (l.Cnt_SIC_Agriculture_Forestry_And_Fishing > r.Cnt_SIC_Agriculture_Forestry_And_Fishing, 
																																			l.Cnt_SIC_Agriculture_Forestry_And_Fishing, 
																																			r.Cnt_SIC_Agriculture_Forestry_And_Fishing);
	self.Per_SIC_Agriculture_Forestry_And_Fishing								:=	if (l.Per_SIC_Agriculture_Forestry_And_Fishing > r.Per_SIC_Agriculture_Forestry_And_Fishing, 
																																			l.Per_SIC_Agriculture_Forestry_And_Fishing, 
																																			r.Per_SIC_Agriculture_Forestry_And_Fishing);	
	self.Cnt_SIC_Mining																					:=	if (l.Cnt_SIC_Mining > r.Cnt_SIC_Mining, 
																																			l.Cnt_SIC_Mining, 
																																			r.Cnt_SIC_Mining);
	self.Per_SIC_Mining																					:=	if (l.Per_SIC_Mining > r.Per_SIC_Mining, 
																																			l.Per_SIC_Mining, 
																																			r.Per_SIC_Mining);	
	self.Cnt_SIC_Construction																		:=	if (l.Cnt_SIC_Construction > r.Cnt_SIC_Construction, 
																																			l.Cnt_SIC_Construction, 
																																			r.Cnt_SIC_Construction);
	self.Per_SIC_Construction																		:=	if (l.Per_SIC_Construction > r.Per_SIC_Construction, 
																																			l.Per_SIC_Construction, 
																																			r.Per_SIC_Construction);
	self.Cnt_SIC_Manufacturing																	:=	if (l.Cnt_SIC_Manufacturing > r.Cnt_SIC_Manufacturing, 
																																			l.Cnt_SIC_Manufacturing, 
																																			r.Cnt_SIC_Manufacturing);
	self.Per_SIC_Manufacturing																	:=	if (l.Per_SIC_Manufacturing > r.Per_SIC_Manufacturing, 
																																			l.Per_SIC_Manufacturing, 
																																			r.Per_SIC_Manufacturing);
	self.Cnt_SIC_Transportation_and_Public_Utilities						:=	if (l.Cnt_SIC_Transportation_and_Public_Utilities > r.Cnt_SIC_Transportation_and_Public_Utilities, 
																																			l.Cnt_SIC_Transportation_and_Public_Utilities, 
																																			r.Cnt_SIC_Transportation_and_Public_Utilities);
	self.Per_SIC_Transportation_and_Public_Utilities						:=	if (l.Per_SIC_Transportation_and_Public_Utilities > r.Per_SIC_Transportation_and_Public_Utilities, 
																																			l.Per_SIC_Transportation_and_Public_Utilities, 
																																			r.Per_SIC_Transportation_and_Public_Utilities);
	self.Cnt_SIC_Wholesale_Trade																:= 	if (l.Cnt_SIC_Wholesale_Trade > r.Cnt_SIC_Wholesale_Trade, 
																																			l.Cnt_SIC_Wholesale_Trade, 
																																			r.Cnt_SIC_Wholesale_Trade);
	self.Per_SIC_Wholesale_Trade																:= 	if (l.Per_SIC_Wholesale_Trade > r.Per_SIC_Wholesale_Trade, 
																																			l.Per_SIC_Wholesale_Trade, 
																																			r.Per_SIC_Wholesale_Trade);
	self.Cnt_SIC_Retail_Trade																		:=	if (l.Cnt_SIC_Retail_Trade > r.Cnt_SIC_Retail_Trade, 
																																			l.Cnt_SIC_Retail_Trade, 
																																			r.Cnt_SIC_Retail_Trade);
	self.Per_SIC_Retail_Trade																		:= 	if (l.Per_SIC_Retail_Trade > r.Per_SIC_Retail_Trade, 
																																			l.Per_SIC_Retail_Trade, 
																																			r.Per_SIC_Retail_Trade);
	self.Cnt_SIC_Finance_Insurance_and_Real_Estate							:=	if (l.Cnt_SIC_Finance_Insurance_and_Real_Estate > r.Cnt_SIC_Finance_Insurance_and_Real_Estate, 
																																			l.Cnt_SIC_Finance_Insurance_and_Real_Estate, 
																																			r.Cnt_SIC_Finance_Insurance_and_Real_Estate);
	self.Per_SIC_Finance_Insurance_and_Real_Estate							:=	if (l.Per_SIC_Finance_Insurance_and_Real_Estate > r.Per_SIC_Finance_Insurance_and_Real_Estate, 
																																			l.Per_SIC_Finance_Insurance_and_Real_Estate, 
																																			r.Per_SIC_Finance_Insurance_and_Real_Estate);
	self.Cnt_SIC_Services																				:= 	if (l.Cnt_SIC_Services > r.Cnt_SIC_Services, 
																																			l.Cnt_SIC_Services, 
																																			r.Cnt_SIC_Services);
	self.Per_SIC_Services																				:=	if (l.Per_SIC_Services > r.Per_SIC_Services, 
																																			l.Per_SIC_Services, 
																																			r.Per_SIC_Services);
	self.Cnt_SIC_Public_Administration													:= 	if (l.Cnt_SIC_Public_Administration > r.Cnt_SIC_Public_Administration, 
																																			l.Cnt_SIC_Public_Administration, 
																																			r.Cnt_SIC_Public_Administration);
	self.Per_SIC_Public_Administration													:= 	if (l.Per_SIC_Public_Administration > r.Per_SIC_Public_Administration, 
																																			l.Per_SIC_Public_Administration, 
																																			r.Per_SIC_Public_Administration);
	self.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting			:= 	if (l.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting > r.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting, 
																																			l.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting, 
																																			r.Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting);
	self.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting			:= 	if (l.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting > r.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting, 
																																			l.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting, 
																																			r.Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting);
	self.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction	:= 	if (l.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction > r.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction, 
																																			l.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction, 
																																			r.Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction);
	self.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction	:= 	if (l.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction > r.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction, 
																																			l.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction, 
																																			r.Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction);
	self.Cnt_NAICS_Utilities																		:= 	if (l.Cnt_NAICS_Utilities > r.Cnt_NAICS_Utilities, 
																																			l.Cnt_NAICS_Utilities, 
																																			r.Cnt_NAICS_Utilities);
	self.Per_NAICS_Utilities																		:= 	if (l.Per_NAICS_Utilities > r.Per_NAICS_Utilities, 
																																			l.Per_NAICS_Utilities, 
																																			r.Per_NAICS_Utilities);
	self.Cnt_NAICS_Construction																	:= 	if (l.Cnt_NAICS_Construction > r.Cnt_NAICS_Construction, 
																																			l.Cnt_NAICS_Construction, 
																																			r.Cnt_NAICS_Construction);
	self.Per_NAICS_Construction																	:= 	if (l.Per_NAICS_Construction > r.Per_NAICS_Construction, 
																																			l.Per_NAICS_Construction, 
																																			r.Per_NAICS_Construction);
	self.Cnt_NAICS_Manufacturing																:= 	if (l.Cnt_NAICS_Manufacturing > r.Cnt_NAICS_Manufacturing, 
																																			l.Cnt_NAICS_Manufacturing, 
																																			r.Cnt_NAICS_Manufacturing);
	self.Per_NAICS_Manufacturing																:= 	if (l.Per_NAICS_Manufacturing > r.Per_NAICS_Manufacturing, 
																																			l.Per_NAICS_Manufacturing, 
																																			r.Per_NAICS_Manufacturing);
	self.Cnt_NAICS_Wholesale_Trade															:= 	if (l.Cnt_NAICS_Wholesale_Trade > r.Cnt_NAICS_Wholesale_Trade, 
																																			l.Cnt_NAICS_Wholesale_Trade, 
																																			r.Cnt_NAICS_Wholesale_Trade);
	self.Per_NAICS_Wholesale_Trade															:= 	if (l.Per_NAICS_Wholesale_Trade > r.Per_NAICS_Wholesale_Trade, 
																																			l.Per_NAICS_Wholesale_Trade, 
																																			r.Per_NAICS_Wholesale_Trade);
	self.Cnt_NAICS_Retail_Trade																	:= 	if (l.Cnt_NAICS_Retail_Trade > r.Cnt_NAICS_Retail_Trade, 
																																			l.Cnt_NAICS_Retail_Trade, 
																																			r.Cnt_NAICS_Retail_Trade);
	self.Per_NAICS_Retail_Trade																	:= 	if (l.Per_NAICS_Retail_Trade > r.Per_NAICS_Retail_Trade, 
																																			l.Per_NAICS_Retail_Trade, 
																																			r.Per_NAICS_Retail_Trade);
	self.Cnt_NAICS_Transportation_and_Warehousing								:= 	if (l.Cnt_NAICS_Transportation_and_Warehousing > r.Cnt_NAICS_Transportation_and_Warehousing, 
																																			l.Cnt_NAICS_Transportation_and_Warehousing, 
																																			r.Cnt_NAICS_Transportation_and_Warehousing);
	self.Per_NAICS_Transportation_and_Warehousing								:= 	if (l.Per_NAICS_Transportation_and_Warehousing > r.Per_NAICS_Transportation_and_Warehousing, 
																																			l.Per_NAICS_Transportation_and_Warehousing, 
																																			r.Per_NAICS_Transportation_and_Warehousing);
	self.Cnt_NAICS_Information																	:= 	if (l.Cnt_NAICS_Information > r.Cnt_NAICS_Information, 
																																			l.Cnt_NAICS_Information, 
																																			r.Cnt_NAICS_Information);
	self.Per_NAICS_Information																	:= 	if (l.Per_NAICS_Information > r.Per_NAICS_Information, 
																																			l.Per_NAICS_Information, 
																																			r.Per_NAICS_Information);
	self.Cnt_NAICS_Finance_and_Insurance												:= 	if (l.Cnt_NAICS_Finance_and_Insurance > r.Cnt_NAICS_Finance_and_Insurance, 
																																			l.Cnt_NAICS_Finance_and_Insurance, 
																																			r.Cnt_NAICS_Finance_and_Insurance);
	self.Per_NAICS_Finance_and_Insurance												:= 	if (l.Per_NAICS_Finance_and_Insurance > r.Per_NAICS_Finance_and_Insurance, 
																																			l.Per_NAICS_Finance_and_Insurance, 
																																			r.Per_NAICS_Finance_and_Insurance);
	self.Cnt_NAICS_Real_Estate_Rental_and_Leasing								:= 	if (l.Cnt_NAICS_Real_Estate_Rental_and_Leasing > r.Cnt_NAICS_Real_Estate_Rental_and_Leasing, 
																																			l.Cnt_NAICS_Real_Estate_Rental_and_Leasing, 
																																			r.Cnt_NAICS_Real_Estate_Rental_and_Leasing);
	self.Per_NAICS_Real_Estate_Rental_and_Leasing								:= 	if (l.Per_NAICS_Real_Estate_Rental_and_Leasing > r.Per_NAICS_Real_Estate_Rental_and_Leasing, 
																																			l.Per_NAICS_Real_Estate_Rental_and_Leasing, 
																																			r.Per_NAICS_Real_Estate_Rental_and_Leasing);
	self.Cnt_NAICS_Professional_Scientific_Technical_Services		:= 	if (l.Cnt_NAICS_Professional_Scientific_Technical_Services > r.Cnt_NAICS_Professional_Scientific_Technical_Services, 
																																			l.Cnt_NAICS_Professional_Scientific_Technical_Services, 
																																			r.Cnt_NAICS_Professional_Scientific_Technical_Services);
	self.Per_NAICS_Professional_Scientific_Technical_Services		:= 	if (l.Per_NAICS_Professional_Scientific_Technical_Services > r.Per_NAICS_Professional_Scientific_Technical_Services, 
																																			l.Per_NAICS_Professional_Scientific_Technical_Services, 
																																			r.Per_NAICS_Professional_Scientific_Technical_Services);
	self.Cnt_NAICS_Management_of_Companies_and_Enterprises			:= 	if (l.Cnt_NAICS_Management_of_Companies_and_Enterprises > r.Cnt_NAICS_Management_of_Companies_and_Enterprises, 
																																			l.Cnt_NAICS_Management_of_Companies_and_Enterprises, 
																																			r.Cnt_NAICS_Management_of_Companies_and_Enterprises);
	self.Per_NAICS_Management_of_Companies_and_Enterprises			:= 	if (l.Per_NAICS_Management_of_Companies_and_Enterprises > r.Per_NAICS_Management_of_Companies_and_Enterprises, 
																																			l.Per_NAICS_Management_of_Companies_and_Enterprises, 
																																			r.Per_NAICS_Management_of_Companies_and_Enterprises);
	self.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices	:= 	if (l.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices > r.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices, 
																																			l.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices, 
																																			r.Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices);
	self.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices	:= 	if (l.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices > r.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices, 
																																			l.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices, 
																																			r.Per_NAICS_Admin_Support_WasteMgmt_RemediationServices);
	self.Cnt_NAICS_Educational_Services													:= 	if (l.Cnt_NAICS_Educational_Services > r.Cnt_NAICS_Educational_Services, 
																																			l.Cnt_NAICS_Educational_Services, 
																																			r.Cnt_NAICS_Educational_Services);
	self.Per_NAICS_Educational_Services													:= 	if (l.Per_NAICS_Educational_Services > r.Per_NAICS_Educational_Services, 
																																			l.Per_NAICS_Educational_Services, 
																																			r.Per_NAICS_Educational_Services);
	self.Cnt_NAICS_HealthCare_and_SocialAssistance							:= 	if (l.Cnt_NAICS_HealthCare_and_SocialAssistance > r.Cnt_NAICS_HealthCare_and_SocialAssistance, 
																																			l.Cnt_NAICS_HealthCare_and_SocialAssistance, 
																																			r.Cnt_NAICS_HealthCare_and_SocialAssistance);
	self.Per_NAICS_HealthCare_and_SocialAssistance							:= 	if (l.Per_NAICS_HealthCare_and_SocialAssistance > r.Per_NAICS_HealthCare_and_SocialAssistance, 
																																			l.Per_NAICS_HealthCare_and_SocialAssistance, 
																																			r.Per_NAICS_HealthCare_and_SocialAssistance);
	self.Cnt_NAICS_Arts_Entertainment_and_Recreation						:= 	if (l.Cnt_NAICS_Arts_Entertainment_and_Recreation > r.Cnt_NAICS_Arts_Entertainment_and_Recreation, 
																																			l.Cnt_NAICS_Arts_Entertainment_and_Recreation, 
																																			r.Cnt_NAICS_Arts_Entertainment_and_Recreation);
	self.Per_NAICS_Arts_Entertainment_and_Recreation						:= 	if (l.Per_NAICS_Arts_Entertainment_and_Recreation > r.Per_NAICS_Arts_Entertainment_and_Recreation, 
																																			l.Per_NAICS_Arts_Entertainment_and_Recreation, 
																																			r.Per_NAICS_Arts_Entertainment_and_Recreation);
	self.Cnt_NAICS_Accommodation_and_Food_Services							:= 	if (l.Cnt_NAICS_Accommodation_and_Food_Services > r.Cnt_NAICS_Accommodation_and_Food_Services, 
																																			l.Cnt_NAICS_Accommodation_and_Food_Services, 
																																			r.Cnt_NAICS_Accommodation_and_Food_Services);
	self.Per_NAICS_Accommodation_and_Food_Services							:= 	if (l.Per_NAICS_Accommodation_and_Food_Services > r.Per_NAICS_Accommodation_and_Food_Services, 
																																			l.Per_NAICS_Accommodation_and_Food_Services, 
																																			r.Per_NAICS_Accommodation_and_Food_Services);
	self.Cnt_NAICS_Other_Services_except_Public_Administration	:= 	if (l.Cnt_NAICS_Other_Services_except_Public_Administration > r.Cnt_NAICS_Other_Services_except_Public_Administration, 
																																			l.Cnt_NAICS_Other_Services_except_Public_Administration, 
																																			r.Cnt_NAICS_Other_Services_except_Public_Administration);
	self.Per_NAICS_Other_Services_except_Public_Administration	:= 	if (l.Per_NAICS_Other_Services_except_Public_Administration > r.Per_NAICS_Other_Services_except_Public_Administration, 
																																			l.Per_NAICS_Other_Services_except_Public_Administration, 
																																			r.Per_NAICS_Other_Services_except_Public_Administration);
	self.Cnt_NAICS_Public_Administration												:= 	if (l.Cnt_NAICS_Public_Administration > r.Cnt_NAICS_Public_Administration, 
																																			l.Cnt_NAICS_Public_Administration, 
																																			r.Cnt_NAICS_Public_Administration);
	self.Per_NAICS_Public_Administration												:= 	if (l.Per_NAICS_Public_Administration > r.Per_NAICS_Public_Administration, 
																																			l.Per_NAICS_Public_Administration, 
																																			r.Per_NAICS_Public_Administration);

	self.Cnt_Contact_Address																		:= 	if (l.Cnt_Contact_Address > r.Cnt_Contact_Address, 
																																			l.Cnt_Contact_Address, 
																																			r.Cnt_Contact_Address);
	self.Per_Contact_Address																		:= 	if (l.Per_Contact_Address > r.Per_Contact_Address, 
																																			l.Per_Contact_Address, 
																																			r.Per_Contact_Address);																																			
	self.Cnt_Contact_Email																			:= 	if (l.Cnt_Contact_Email > r.Cnt_Contact_Email, 
																																			l.Cnt_Contact_Email, 
																																			r.Cnt_Contact_Email);
	self.Per_Contact_Email																			:= 	if (l.Per_Contact_Email > r.Per_Contact_Email, 
																																			l.Per_Contact_Email, 
																																			r.Per_Contact_Email);	
	self.Cnt_Contact_Title																			:= 	if (l.Cnt_Contact_Title > r.Cnt_Contact_Title, 
																																			l.Cnt_Contact_Title, 
																																			r.Cnt_Contact_Title);
	self.Per_Contact_Title																			:= 	if (l.Per_Contact_Title > r.Per_Contact_Title, 
																																			l.Per_Contact_Title, 
																																			r.Per_Contact_Title);			
	self.Cnt_Contact_Lexid																			:= 	if (l.Cnt_Contact_Lexid > r.Cnt_Contact_Lexid, 
																																			l.Cnt_Contact_Lexid, 
																																			r.Cnt_Contact_Lexid);
	self.Per_Contact_Lexid																			:= 	if (l.Per_Contact_Lexid > r.Per_Contact_Lexid, 
																																			l.Per_Contact_Lexid, 
																																			r.Per_Contact_Lexid);		
	self.Cnt_Unique_Contact_Recs																:= 	if (l.Cnt_Unique_Contact_Recs > r.Cnt_Unique_Contact_Recs, 
																																			l.Cnt_Unique_Contact_Recs, 
																																			r.Cnt_Unique_Contact_Recs);
	self.Cnt_Bus_Emails_Returned																:=	if (l.Cnt_Bus_Emails_Returned > r.Cnt_Bus_Emails_Returned, 
																																			l.Cnt_Bus_Emails_Returned, 
																																			r.Cnt_Bus_Emails_Returned);
	self.Per_Bus_Emails_Returned																:=	if (l.Per_Bus_Emails_Returned > r.Per_Bus_Emails_Returned, 
																																			l.Per_Bus_Emails_Returned, 
																																			r.Per_Bus_Emails_Returned);
	self.Cnt_Less_Than_2_Years																	:=	if (l.Cnt_Less_Than_2_Years > r.Cnt_Less_Than_2_Years, 
																																			l.Cnt_Less_Than_2_Years, 
																																			r.Cnt_Less_Than_2_Years);
	self.Per_Less_Than_2_Years																	:=	if (l.Per_Less_Than_2_Years > r.Per_Less_Than_2_Years, 
																																			l.Per_Less_Than_2_Years, 
																																			r.Per_Less_Than_2_Years);
	self.Cnt_2_5_Years																					:=	if (l.Cnt_2_5_Years > r.Cnt_2_5_Years, 
																																			l.Cnt_2_5_Years, 
																																			r.Cnt_2_5_Years);
	self.Per_2_5_Years																					:=	if (l.Per_2_5_Years > r.Per_2_5_Years, 
																																			l.Per_2_5_Years, 
																																			r.Per_2_5_Years);	
	self.Cnt_6_10_Years																					:=	if (l.Cnt_6_10_Years > r.Cnt_6_10_Years, 
																																			l.Cnt_6_10_Years, 
																																			r.Cnt_6_10_Years);
	self.Per_6_10_Years																					:=	if (l.Per_6_10_Years > r.Per_6_10_Years, 
																																			l.Per_6_10_Years, 
																																			r.Per_6_10_Years);
	self.Cnt_More_Than_10_Years																	:=	if (l.Cnt_More_Than_10_Years > r.Cnt_More_Than_10_Years, 
																																			l.Cnt_More_Than_10_Years, 
																																			r.Cnt_More_Than_10_Years);
	self.Per_More_Than_10_Years																	:=	if (l.Per_More_Than_10_Years > r.Per_More_Than_10_Years, 
																																			l.Per_More_Than_10_Years, 
																																			r.Per_More_Than_10_Years);
	self.Cnt_Total_SIC																					:=	if (l.Cnt_Total_SIC > r.Cnt_Total_SIC, 
																																			l.Cnt_Total_SIC, 
																																			r.Cnt_Total_SIC);
	self.Per_Total_SIC																					:=	if (l.Per_Total_SIC > r.Per_Total_SIC, 
																																			l.Per_Total_SIC, 
																																			r.Per_Total_SIC);																																			
	self.Cnt_Total_NAICS																				:=	if (l.Cnt_Total_NAICS > r.Cnt_Total_NAICS, 
																																			l.Cnt_Total_NAICS, 
																																			r.Cnt_Total_NAICS);
	self.Per_Total_NAICS																				:=	if (l.Per_Total_NAICS > r.Per_Total_NAICS, 
																																			l.Per_Total_NAICS, 
																																			r.Per_Total_NAICS);																																			
	self := l;
end;

AllFileRollup := rollup(SrtAllFile, RollupAll(left, right), unique_id);
												
AllFileStats	:=	project(AllFileRollup,TRANSFORM(Marketing_Suite_List_Gen.Layouts.Layout_Stats,SELF := LEFT;));

StatHeading		:=	'Cnt_Unique_Business_Recs|Cnt_Companies_Returned|Per_Companies_Returned|Cnt_Phones_Returned|' +
									'Per_Phones_Returned|Cnt_States_Returned|Per_States_Returned|Cnt_Counties_Returned|' +
									'Per_Counties_Returned|Cnt_Cities_Returned|Per_Cities_Returned|Cnt_Zip_Codes_Returned|' +
									'Per_Zip_Codes_Returned|Cnt_Bus_Emails_Returned|Per_Bus_Emails_Returned|' +
									'Cnt_Revenue_Less_150000|Per_Revenue_Less_150000|Cnt_Revenue_150000_249999|' +
									'Per_Revenue_150000_249999|Cnt_Revenue_250000_499999|Per_Revenue_250000_499999|' +
									'Cnt_Revenue_500000_999999|Per_Revenue_500000_999999|Cnt_Revenue_1000000_2499999|' +
									'Per_Revenue_1000000_2499999|Cnt_Revenue_2500000_4999999|Per_Revenue_2500000_4999999|' +
									'Cnt_Revenue_5000000_9999999|Per_Revenue_5000000_9999999|Cnt_Revenue_10000000_and_Above|' +
									'Per_Revenue_10000000_and_Above|Cnt_1_Employee|Per_1_Employee|Cnt_2_4_Employees|' + 
									'Per_2_4_Employees|Cnt_5_9_Employees|Per_5_9_Employees|Cnt_10_19_Employees|Per_10_19_Employees|' +
									'Cnt_20_49_Employees|Per_20_49_Employees|Cnt_50_99_Employees|Per_50_99_Employees|' + 
									'Cnt_100_249_Employees|Per_100_249_Employees|Cnt_250_499_Employees|Per_250_499_Employees|' +
									'Cnt_500_749_Employees|Per_500_749_Employees|Cnt_750_999_Employees|Per_750_999_Employees|' +
									'Cnt_1000_1249_Employees|Per_1000_1249_Employees|Cnt_1250_1499_Employees|Per_1250_1499_Employees|' +
									'Cnt_1500_and_Above_Employees|Per_1500_and_Above_Employees|Cnt_Less_Than_2_Years|Per_Less_Than_2_Years|' +		
									'Cnt_2_5_Years|Per_2_5_Years|Cnt_6_10_Years|Per_6_10_Years|Cnt_More_Than_10_Years|Per_More_Than_10_Years|' +
									'Cnt_Total_SIC|Per_Total_SIC|Cnt_Total_NAICS|Per_Total_NAICS|Cnt_SIC_Agriculture_Forestry_And_Fishing|' +
									'Per_SIC_Agriculture_Forestry_And_Fishing|Cnt_SIC_Mining|Per_SIC_Mining|Cnt_SIC_Construction|' +
									'Per_SIC_Construction|Cnt_SIC_Manufacturing|Per_SIC_Manufacturing|' + 
									'Cnt_SIC_Transportation_and_Public_Utilities|Per_SIC_Transportation_and_Public_Utilities|' +
									'Cnt_SIC_Wholesale_Trade|Per_SIC_Wholesale_Trade|Cnt_SIC_Retail_Trade|Per_SIC_Retail_Trade|' +
									'Cnt_SIC_Finance_Insurance_and_Real_Estate|Per_SIC_Finance_Insurance_and_Real_Estate|' +
									'Cnt_SIC_Services|Per_SIC_Services|Cnt_SIC_Public_Administration|' +
									'Per_SIC_Public_Administration|Cnt_NAICS_Agriculture_Forestry_Fishing_And_Hunting|' +
									'Per_NAICS_Agriculture_Forestry_Fishing_And_Hunting|' + 
									'Cnt_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction|' + 
									'Per_NAICS_Mining_Quarrying_and_Oil_and_Gas_Extraction|Cnt_NAICS_Utilities|Per_NAICS_Utilities|' +
									'Cnt_NAICS_Construction|Per_NAICS_Construction|Cnt_NAICS_Manufacturing|Per_NAICS_Manufacturing|' +
									'Cnt_NAICS_Wholesale_Trade|Per_NAICS_Wholesale_Trade|Cnt_NAICS_Retail_Trade|Per_NAICS_Retail_Trade|' +
									'Cnt_NAICS_Transportation_and_Warehousing|Per_NAICS_Transportation_and_Warehousing|' +
									'Cnt_NAICS_Information|Per_NAICS_Information|Cnt_NAICS_Finance_and_Insurance|' +
									'Per_NAICS_Finance_and_Insurance|Cnt_NAICS_Real_Estate_Rental_and_Leasing|' +
									'Per_NAICS_Real_Estate_Rental_and_Leasing|Cnt_NAICS_Professional_Scientific_Technical_Services|' +
									'Per_NAICS_Professional_Scientific_Technical_Services|' + 
									'Cnt_NAICS_Management_of_Companies_and_Enterprises|Per_NAICS_Management_of_Companies_and_Enterprises|' +
									'Cnt_NAICS_Admin_Support_WasteMgmt_RemediationServices|' +
									'Per_NAICS_Admin_Support_WasteMgmt_RemediationServices|Cnt_NAICS_Educational_Services|' +
									'Per_NAICS_Educational_Services|Cnt_NAICS_HealthCare_and_SocialAssistance|' +
									'Per_NAICS_HealthCare_and_SocialAssistance|Cnt_NAICS_Arts_Entertainment_and_Recreation|' +
									'Per_NAICS_Arts_Entertainment_and_Recreation|Cnt_NAICS_Accommodation_and_Food_Services|' +
									'Per_NAICS_Accommodation_and_Food_Services|Cnt_NAICS_Other_Services_except_Public_Administration|' +
									'Per_NAICS_Other_Services_except_Public_Administration|Cnt_NAICS_Public_Administration|' +
									'Per_NAICS_Public_Administration|Cnt_Unique_Contact_Recs|Cnt_Contact_Address|Per_Contact_Address|' +
									'Cnt_Contact_Email|Per_Contact_Email|Cnt_Contact_Title|Per_Contact_Title|Cnt_Contact_Lexid|' +
									'Per_Contact_Lexid' + '\r\n';											
												
WriteStats		:=	output(AllFileStats,,'~thor_data400::marketing_suite_list_gen::stats::'+jobID,CSV(HEADING(StatHeading,SINGLE),SEPARATOR('|'),TERMINATOR(['\r\n', '\n'])),OVERWRITE, expire (20));	
												
export All 		:=  WriteStats; 
						
end;