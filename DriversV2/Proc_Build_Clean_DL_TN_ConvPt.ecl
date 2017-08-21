#OPTION('multiplePersistInstances', FALSE);

EXPORT Proc_Build_Clean_DL_TN_ConvPt(STRING filedate) := FUNCTION

  Do_All :=	SEQUENTIAL( DriversV2.Cleaned_DL_TN_ConvPoints(filedate,filedate),
												DriversV2.Cleaned_DL_TN_Withdrawals(filedate,filedate),
												NOTIFY(('CLEAN TN CONV & WDL COMPLETE FOR ' + filedate),'*')
											);
																	
  RETURN Do_All;		
END;
