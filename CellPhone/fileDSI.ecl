export fileDSI := 
	dataset('~thor_dell400::in::cellphones::kroll::20051205::data_7837.txt',
	CellPhone.layoutDSI,csv(terminator('\n'), separator('\t'), quote('')));;