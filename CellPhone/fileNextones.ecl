export fileNextones := 
	dataset('~thor_dell400::in::cellphones::kroll::20051205::nextones_final.csv',
	CellPhone.layoutNextones,csv(terminator('\r\n'), separator(','), quote('')));
