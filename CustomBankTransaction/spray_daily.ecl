import CustomBankTransaction, lib_fileservices, _control;

EXPORT spray_daily (string		pFileDate,
										string		pCSVQuote		=	'\'',
										unsigned	pMaxRecordLength	=	8192,
										string		pGroupName	=	_control.TargetGroup.Thor400_92,/*'thor40_241',*/
										boolean		pOverwrite	=	false
									)	:=
function

	string	pSourceIP				:=	_control.IPAddress.edata12;
	string	pSourceDir			:=	'/data_999/chase_test/sample.csv';
	string  pCSVSeparator   :=  '\\,';
	string	pCSVTerminator	:=	'\\n,\\r\\n';
  string  pLogicalFileName := '~thor_data400::in::chase_full_' + pFileDate;


return	FileServices.SprayVariable(	pSourceIP,
																		pSourceDir,
																		pMaxRecordLength,
																		pCSVSeparator,
																		pCSVTerminator,
																		pCSVQuote,
																		pGroupName,
																		pLogicalFileName,
												            ,
																		,
																		,
																		pOverwrite,
																		false,
																		true
																	);



END;
