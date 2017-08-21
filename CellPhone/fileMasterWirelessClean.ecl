export fileMasterWirelessClean :=  
	   dataset('~thor_dell400::in::cellphones::Kroll::20060906::090606_MasterWirelessClean.csv',CellPhone.layoutMasterWirelessClean,csv(terminator('\r\n'), separator('|'), quote('')));
	