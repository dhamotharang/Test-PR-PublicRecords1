IMPORT dx_PhoneFinderReportDelta;

//DF-23251: Add 'dx_' Prefix to Index Definitions
//dtype: 'identities', 'otherphones', 'riskindicators', or 'transactions'

EXPORT Empty_PhoneFinderReport(string version, string etype):= FUNCTION
	
	root			:= '~thor_data400::in::phonefinderreportdelta::';
	suffix		:= etype;
	outFile		:= if(etype = 'identities',
																output(dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Identities_History),, root + suffix + '_' + version, __compressed__),
													if(etype = 'otherphones',
																output(dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_History),, root + suffix + '_' + version, __compressed__),
													if(etype = 'riskindicators',
																output(dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_History),, root + suffix + '_' + version, __compressed__),
													if(etype = 'transaction',
																output(dataset([], dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_History),, root + suffix + '_' + version, __compressed__),
																output('error')))));
	
	addFile 	:= sequential(FileServices.StartSuperFileTransaction(),
																								FileServices.RemoveOwnedSubFiles(root + suffix +'_daily', true),
																								Fileservices.AddSuperfile(root + suffix +'_daily', root + suffix + '_' + version),
																								FileServices.FinishSuperFileTransaction();
																								);

	RETURN SEQUENTIAL(outFile,
										addFile);

END;