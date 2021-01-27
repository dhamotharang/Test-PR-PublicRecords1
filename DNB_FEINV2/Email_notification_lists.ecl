IMPORT STD, RoxieKeyBuild;

EXPORT Email_Notification_Lists(
	STRING pAddresses,
	BOOLEAN pIsTesting = _Constants().IsTesting
) := MODULE
	SHARED addresses    := STD.Str.SplitWords(pAddresses, ',');
	
	SHARED myInfo       := addresses[1];
	SHARED all_hands    := STD.Str.FindReplace(pAddresses, ',', ';');
	
	EXPORT BuildSuccess := IF(pIsTesting, myInfo, all_hands);
	EXPORT BuildFailure := BuildSuccess; 
	EXPORT Roxie        := BuildSuccess;
	EXPORT ScrubsPlus   := BuildSuccess;
END; 
