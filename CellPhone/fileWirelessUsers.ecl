export fileWirelessUsers := 
				dataset('~thor_dell400::in::cellphones::kroll::20060120::wireless_cell_phone_users_1thru500000.txt',CellPhone.layoutMarigold,csv(terminator('\n'), separator('\t'), quote('')))
			  + dataset('~thor_dell400::in::cellphones::kroll::20060120::wireless_cell_phone_users_501000thru1million.txt',CellPhone.layoutMarigold,csv(terminator('\n'), separator('\t'), quote('')));
;