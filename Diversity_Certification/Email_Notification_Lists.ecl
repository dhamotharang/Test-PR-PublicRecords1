import _control,RoxieKeyBuild;

export Email_Notification_Lists := module
   
   export all_hands := 'saritha.myana@lexisnexis.com;' + _control.MyInfo.EmailAddressNotify;
                                 
   export BuildSuccess :=	if(_Flags.IsTesting
																,all_hands
																,'qualityassurance@seisint.com;' + all_hands
														);
   
   export BuildFailure	:=	all_hands;
end;