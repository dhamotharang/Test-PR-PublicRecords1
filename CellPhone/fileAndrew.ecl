export fileAndrew := 
	dataset('~thor_dell400::in::cellphones::traffix::20060306::andrew.csv',
	CellPhone.layoutAndrew,csv(terminator('\r\n'), separator(','), quote('')));
