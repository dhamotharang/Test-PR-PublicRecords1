EXPORT Constants := MODULE

//	Build Types
EXPORT	buildType :=	ENUM(
													UNSIGNED1,
													Daily,			// DAILY build only processes and links the records from today
													FullBuild);		// FULLBUILD processes and links all records (Used when reDID)

												
END;