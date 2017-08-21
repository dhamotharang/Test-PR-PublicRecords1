import _control;

export Email_Notification_Lists := module
   
   export all_hands 		:= 'sandy.butler@lexisnexis.com;'+'jennifer.stewart@lexisnexis.com'+';'+'aaron.neidert@lexisnexis.com' + '; kent.wolf@lexisnexis.com;';
	 export testing_email := _control.MyInfo.EmailAddressNotify; 
																 
   export BuildSuccess :=	if(_Flags().IsTesting
																, testing_email
																, all_hands
														);
   
   export BuildFailure	:= if(_Flags().IsTesting
																, testing_email
																, all_hands
														 );
	
end;