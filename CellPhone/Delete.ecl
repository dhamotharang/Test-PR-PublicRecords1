export filePhoneClean := 
	dataset('~thor_dell400::in::cellphones::kroll::20060630::062806_phoneclean.csv',
	CellPhone.layoutPhoneClean,csv(terminator('\r\n'), separator('","')));

