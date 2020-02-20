IMPORT iesp;

export fn_GetTestRecords := MODULE

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
