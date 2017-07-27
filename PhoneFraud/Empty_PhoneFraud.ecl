//dtype: 'otp' or 'spoofing'

EXPORT Empty_PhoneFraud (string version, string etype):= FUNCTION
	
	root				:= '~thor_data400::in::phonefraud_';
	suffix			:= etype;
	outFile			:= if(etype = 'otp',
										output(dataset([], PhoneFraud.Layout_OTP.Raw),, root + suffix + '_' + version, __compressed__),
								 if(etype = 'spoofing',
										output(dataset([], PhoneFraud.Layout_Spoofing.Raw),, root + suffix + '_' + version, __compressed__),
										output('error')));
	
	addLR 			:= sequential(	FileServices.StartSuperFileTransaction(),
															FileServices.RemoveOwnedSubFiles('~thor_data400::in::phonefraud_'+ suffix +'_daily', true),
															Fileservices.AddSuperfile('~thor_data400::in::phonefraud_'+ suffix +'_daily', root + suffix + '_' + version),
															FileServices.FinishSuperFileTransaction();
															);

	RETURN SEQUENTIAL(outFile,
										addLr);

END;