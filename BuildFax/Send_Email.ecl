IMPORT VersionControl;
EXPORT Send_Email (STRING emailTarget, STRING AdditionSub = '')	:= MODULE
	EXPORT BuildInProcess	:= fileservices.sendemail(emailTarget,
													'BuildFax Build In Process OR There are no sprayed file NOT PROCEEDING FURTHER For ' + AdditionSub,
													workunit + '\n',,,Constants().SENDER_EMAILID);
	EXPORT BuildError	:= fileservices.sendemail(emailTarget,
													'BuildFax Build Error ' + AdditionSub,
													workunit + '\n' + failmessage,,,Constants().SENDER_EMAILID);
	EXPORT BuildSuccess	:= fileservices.sendemail(emailTarget,
													'BuildFax Build Success ' + AdditionSub,
													workunit + '\n',,,Constants().SENDER_EMAILID);
END;