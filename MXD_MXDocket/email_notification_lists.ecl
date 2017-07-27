IMPORT _control,RoxieKeyBuild,VersionControl;

EXPORT Email_Notification_Lists := MODULE

	 export isTesting 				:= 'uma.pamarthy@lexisnexis.com;' + _control.MyInfo.EmailAddressNotify;
   export BldAllHands 			:= 'qualityassurance@seisint.com;' + isTesting;
	 
   export BuildSuccess 			:=	if(VersionControl._Flags.IsDataland
																			,isTesting
																			,BldAllHands
																	 );
   
   export BuildFailure			:=	BuildSuccess;
END;