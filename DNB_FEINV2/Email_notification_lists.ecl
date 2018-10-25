IMPORT STD, _control, RoxieKeyBuild;

EXPORT Email_Notification_Lists(STRING pAddresses, BOOLEAN pIsTesting = _Constants().IsTesting) := MODULE
	SHARED addresses    := STD.Str.SplitWords(pAddresses, ',');
	
	SHARED myInfo       := IF( _Control.MyInfo.EmailAddressNotify = addresses[1], addresses[1],  _Control.MyInfo.EmailAddressNotify + ';' + addresses[1]);
	SHARED all_hands    := myInfo + ';' + addresses[2] + ';'+ addresses[3];
	
	EXPORT BuildSuccess := IF(pIsTesting, myInfo, all_hands);
	EXPORT BuildFailure := BuildSuccess; 
	EXPORT Roxie        := BuildSuccess;
	EXPORT ScrubsPlus   := BuildSuccess;

END; 
