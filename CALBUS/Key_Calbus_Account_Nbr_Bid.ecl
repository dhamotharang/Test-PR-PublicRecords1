import doxie;

base := CALBUS.File_Calbus_Base_For_BID_Keys(trim(Account_Number,left,right) <> '');

export Key_Calbus_Account_Nbr_Bid := index(base,
																					 {Account_Number},
																					 {base},
																					 '~thor_data400::key::calbus::'+doxie.Version_SuperKey+'::Bid::Account_Nbr');