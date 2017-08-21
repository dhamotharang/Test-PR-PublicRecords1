import doxie;

base := Txbus.File_Txbus_Base_For_BID_Keys(trim(Taxpayer_Number, left, right) <> '');				   

export Key_Txbus_Taxpayer_Nbr_BID := index(base,
							           {Taxpayer_Number},
							           {base},
							           '~thor_data400::key::txbus::'+doxie.Version_SuperKey+'::bid::Taxpayer_Nbr');
