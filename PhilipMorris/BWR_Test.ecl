import PhilipMorris;

#stored('DPPAPurpose', 3);
#stored('GLBPurpose', 1);
#stored('TransactionNumber', '123');
#stored('CCN', '000');
#stored('ContactID', 'ABC');
#stored('ChannelIdentifier', 'ONLINE');

//releavant to batch only
#stored('SkipRestrictionsCall', FALSE);
#stored('AllowProbationSources', TRUE);
#stored('RunFailureReport', FALSE);

//relevant to online single trans only
//should be set to false for online/paver; true for bar nights
#stored('RunInBatchMode', FALSE);
	

//my record
#stored('NameFirst', '');
#stored('NameMiddle', ');
#stored('NameLast', '');
#stored('NameSuffix', '');
#stored('SSN', '');
#stored('DOB_YYYYMMDD', '');
#stored('GIIDAddressLine1', 'T' );
#stored('GIIDAddressLine2', '');
#stored('GIIDCity', '');
#stored('GIIDState', '');
#stored('GIIDZipCode', '');
#stored('CurrentAddressLine1', '');
#stored('CurrentAddressLine2', '');
#stored('CurrentCity', '');
#stored('CurrentState', ');
#stored('CurrentZipCode', '');
#stored('PreviousAddressLine1', '');
#stored('PreviousAddressLine2', '');
#stored('PreviousCity', '');
#stored('PreviousState', '');
#stored('PreviousZipCode', '');

//PhilipMorris.PM_SSNExpansionService();
//PhilipMorris.PM_AgeVerificationService();
PhilipMorris.PM_AgeVerification_BatchService(true);


