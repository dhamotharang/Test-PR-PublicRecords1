export fileKroll_AdvtgMobile := 
	dataset('~thor_dell400::in::cellphones::kroll::20070827::advantage_mobil_cellphone_users.txt',
	CellPhone.layoutKroll_AdvtgMobile,csv(terminator('\n'), separator(','), quote('')));