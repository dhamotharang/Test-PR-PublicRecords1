import _control, prte_csv;

export Email_Notification_Lists(

	 boolean	pIsTesting						= prte_csv._Flags().IsTesting

) := module
   
   export all_hands := 'jennifer.stewart@lexisnexis.com'+';'+'aaron.neidert@lexisnexis.com'+';'+'sandy.butler@lexisnexis.com;';

																 
   export BuildSuccess :=	if(PRTE_CSV._Flags().IsTesting
																,'sandy.butler@lexisnexis.com;'
																, all_hands
														);
   
   export BuildFailure	:=	if(PRTE_CSV._Flags().IsTesting
																,'sandy.butler@lexisnexis.com;'
																, all_hands
														);
end;