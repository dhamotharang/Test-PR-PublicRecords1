IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE
   EXPORT all_hands := _control.MyInfo.EmailAddressNotify;
   EXPORT BuildSuccess  :=	all_hands;
   EXPORT BuildFailure	:=	all_hands;
END;