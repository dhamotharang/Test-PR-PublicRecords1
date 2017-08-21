export fileMarigold := 
	dataset('~thor_dell400::in::cellphones::kroll::20060310::marigold_wirelesscellphonesubscribers_700000.txt',
	CellPhone.layoutMarigold,csv(terminator('\n'), separator('\t'), quote('')));;