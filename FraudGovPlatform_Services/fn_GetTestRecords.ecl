IMPORT iesp;

export fn_GetTestRecords := MODULE

    shared testName1 := ROW({'','Robert','S','Smith','',''},iesp.share.t_Name);
    shared testName2 := ROW({'','Anthony','C','Ruiz','Mr','Jr'},iesp.share.t_Name);
    shared testName3 := ROW({'Thomas Baker','Thomas','','Baker','',''},iesp.share.t_Name);

    shared testAddr1 := ROW({'999','','Brickell','Ave','','','','','','Miami','FL','33031', '','Miami-Dade','',''},iesp.share.t_Address);
    shared testAddr2 := ROW({'1481','','Collins','Ave','','Apt','22','','','Miami','FL','33033', '','Miami-Dade','',''},iesp.share.t_Address);
    shared testAddr3 := ROW({'236','S','Military','Tr','','','','','','Coral Gables','FL','33035', '','Miami-Dade','',''},iesp.share.t_Address);
    shared testAddr4 := ROW({'','','','','','','','51 Broken Sound Blvd','STE 214','Hollywood','FL','33322', '','Broward','',''},iesp.share.t_Address);

    shared testPhones1 := DATASET([{'Cell','2395369865',''},{'Home','5619987632',''}],iesp.fraudgovreport.t_FraudGovPhoneInfo);
    shared testPhones2 := DATASET([{'Home','9545349345',''},{'Work','4076987153',''}],iesp.fraudgovreport.t_FraudGovPhoneInfo);
    shared testPhones3 := DATASET([{'Work','2397786865',''},{'Cell','3055887623',''}],iesp.fraudgovreport.t_FraudGovPhoneInfo);

    shared emptyNvP := DATASET([{'',''}],iesp.share.t_NameValuePair);

    shared emptyBusinessLinkIDs := ROW({'','','','','','',''},iesp.share.t_BusinessIdentity);

    export GetTestClusters() := FUNCTION
        
        clusters := DATASET([{'_09978304','CLUSTER','PHYSICAL_ADDRESS','8320 JARBOE ST',78,3,'8320 JARBOE ST',emptyNvP},
                             {'_01764823283','CLUSTER','LEXID','01764823283',92,4,'Don Jon',emptyNvP},
                             {'_01881366669','CLUSTER','LEXID','01881366669',68,2,'Bill Brown',emptyNvP}], 
                             iesp.fraudgovreport.t_FraudGovClusterCardDetails);
        return clusters;
    END;

    export GetTestScoreBreakdowns() := FUNCTION
        scoreBreakdowns := DATASET([{'C1001','SSN Validation','MediumRisk','RiskScore',62},
                                    {'C1001','SSN Validation','AvgRisk','AvgScore',55},
                                    {'C1002','Known Risk','HighRisk','RiskScore',88},
                                    {'C1002','Known Risk','AvgRisk','AvgScore',61},
                                    {'C1003','Velocity','LowRisk','RiskScore',24},
                                    {'C1003','Velocity','AvgRisk','AvgScore',45}],iesp.fraudgovreport.t_FraudGovScoreBreakdown);

        return scoreBreakdowns;
    END;

    export GetTestIndicatorAttributes() := FUNCTION
        indicatorAttributes := DATASET([{'C1001','SSN Validation','','MediumRisk','D2015','','The input SSN is associated with a different name and address',2017,5,1},
                                        {'C1002','Known Risk','','LowRisk','D2263','','Potential address discrepancy - the Input address may be previous address',2018,3,25},
                                        {'C1003','Velocity','','HighRisk','D2452','','SSN used for Check Cashing Fraud',2018,1,22},
                                       //{'C1004','Top Flagged','','HighRisk','D2444','','SSN used for Applied Benefits',2017,12,14},
                                        {'C1005','Cluster','','MediumRisk','D2452','','This identity has no record of being in the input state.',2018,3,31}],iesp.fraudgovreport.t_FraudGovIndicatorAttribute);
        
        return indicatorAttributes;
    END;

    export GetTestAssociatedAddresses() := FUNCTION
        associatedAddresses := DATASET([{'MailingAddress',testAddr1,'25.7617','-80.1918'},
                                        {'PhysicalAddress',testAddr2,'25.7618','-80.1919'},
                                        {'MailingAddress',testAddr3,'25.7716','-80.1918'}],iesp.fraudgovreport.t_FraudGovAssociatedAddress);

        return associatedAddresses;
    END;

    export GetTestAssociatedIdentities := FUNCTION
        testBestInfo1 := ROW({'0253698557',testName1,'859038536',1963,12,1,testAddr4,'3058636955'},iesp.fraudgovplatform.t_FraudGovBestInfo);
        testBestInfo2 := ROW({'1268593645',testName2,'158013524',1982,1,18,testAddr3,'5619822545'},iesp.fraudgovplatform.t_FraudGovBestInfo);

        associatedIdentities := DATASET([{'IDENTITY','LEXID','0253698557',78,testBestInfo1,'',emptyNvP},
                                         {'IDENTITY','LEXID','1268593645',82,testBestInfo2,'',emptyNvP}],iesp.fraudgovreport.t_FraudGovIdentityCardDetails);

        return associatedIdentities;
    END;

    export GetTestTimelineDetails() := FUNCTION
        timelineDetails := DATASET([
            {False,3,87621,'441246700122','','','',2,2018,4,3,8,10,0,'',2018,4,3,2018,4,3,'','','','','SNAP','SSN used for Applied Benefits',
                2018,4,3,2018,4,3,'',testName1,'859038536',1963,12,1,'Home',testAddr4,testAddr2,'',testPhones1,'','FL','',
                '','','','','Other','','','','192.10.0.1','','','','C1001','','','','','','','','','','',''},
            {False,2,87621,'441246700125','','','',2,2018,1,23,9,50,0,'',2018,1,23,2018,1,24,'','','','','SNAP','SSN used for Check Cashing Fraud',
                2018,4,3,2018,4,3,'',testName2,'158013524',1982,1,18,'Home',testAddr3,testAddr1,'',testPhones2,'','FL','',
                '','','','','Other','','','','10.0.1.14','','','','C1003','','','','','','','','','','',''},
            {True,3,87621,'441246700124','','','',2,2018,1,23,11,31,0,'',2018,1,23,2018,1,24,'','','','','SNAP','SSN used for Benefit Renewal',
                2018,4,3,2018,4,3,'',testName2,'158013525',1982,1,18,'Home',testAddr3,testAddr1,'',testPhones3,'','FL','',
                '','','','','Other','','','','97.101.11.231','','','','C1005','','','','','','','','','','',''}
        ],iesp.fraudgovreport.t_FraudGovTimeLineDetails);

        return timelineDetails;
    END;
		
    export GetDummyGovBestInfo(dataset(iesp.fraudgovreport.t_FraudGovIdentityCardDetails) ds_in) := FUNCTION
				
				ds_dummybestinfo := PROJECT(ds_in, TRANSFORM(iesp.fraudgovplatform.t_FraudGovBestInfo,
																							SELF.UniqueId := LEFT.ContributedBest.UniqueId,
																							SELF.Name := LEFT.ContributedBest.Name,
																							SELF.SSN := '222334444',
																							SELF.DOB := iesp.ECL2ESP.toDatestring8('19700101'),
																							SELF.Address := iesp.ECL2ESP.SetAddress('Main St',
																																											'1212',
																																											'' , '', '', '', '',
																																											'New York',
																																											'NY',
																																											'12345',
																																											'', '', '', 
																																											'1212 Main St'),
																																											
																							SELF.Phone10 := '9541231234',
																							SELF := [],
																		));
				return ds_dummybestinfo;
    END;		

END;
