//Wyoming Division of Banking 


export files_WYS0690 := MODULE
		export mtg_lnd :=  dataset('~thor_data400::in::proflic_mari::wys0690::using::mtg_license',Prof_License_Mari.layout_WYS0690.Common,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
	// export mtg_lnd := dataset('~thor_data400::in::prolic::WYS0690::mtg_lnd_bkr_list.txt',Prof_License_Mari.layout_WYS0690.rBroker,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));
	// export supv_lnd := dataset('~thor_data400::in::prolic::WYS0690::supv_lnd_list.txt',Prof_License_Mari.layout_WYS0690.rLender,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));

END;