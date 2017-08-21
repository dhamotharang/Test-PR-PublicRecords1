import _control,RoxieKeyBuild,versionControl;

export Email_Notification_Lists := module
   
	 export isTesting 				:= 'julianne.franzer@lexisnexis.com;' + _control.MyInfo.EmailAddressNotify;
   export BldAllHands 			:= 'qualityassurance@seisint.com;' + isTesting;
	 export CopyAllHands			:= 'qualityassurance@seisint.com; datareceiving@lexisnexis.com; patrick.bell@lexisnexis.com; ' + isTesting;
                                 
   export BuildSuccess 			:=	if(VersionControl._Flags.IsDataland
																			,isTesting
																			,BldAllHands
																	 );
   
   export BuildFailure			:=	BuildSuccess;
	 
   export CopyFilingSuccess	:=	if(VersionControl._Flags.IsDataland
																			,isTesting
																			,CopyAllHands
																	 );
   
   export CopyFilingFailure	:=	CopyFilingSuccess;	 
	 
   export CopyNameSuccess		:=	if(VersionControl._Flags.IsDataland
																			,isTesting
																			,CopyAllHands
																	 );
   
   export CopyNameFailure		:=	CopyNameSuccess;		 
  
end;