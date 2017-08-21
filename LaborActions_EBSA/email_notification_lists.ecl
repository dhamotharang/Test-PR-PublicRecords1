import _control,RoxieKeyBuild;

export Email_Notification_Lists := module
   
   export all_hands := _control.MyInfo.EmailAddressNotify;
                                 
   export BuildSuccess :=	if(_Flags.IsTesting
																,'sandy.butler@lexisnexis.com;'
																, all_hands
														);
   
   export BuildFailure	:=	all_hands;
end;