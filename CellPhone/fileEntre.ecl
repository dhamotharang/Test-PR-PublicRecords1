export fileEntre := 
	dataset('~thor_dell400::in::cellphones::kroll::20051205::entrepreneuricell.txt',
	CellPhone.layoutEntre,csv(terminator('\n'), separator('\t'), quote('')));;