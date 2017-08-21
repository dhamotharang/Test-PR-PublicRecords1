//Raw professional license files from the AZS0639
EXPORT files_AZS0639 := MODULE

	SHARED code 						:= 'AZS0639';

	SHARED dirname 					:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';

	EXPORT mtg_banker 			:= dataset(dirname + 'using' + '::' + 'bk', 
																		 Prof_License_Mari.layout_AZS0639.Mtg_Broker,
																		 csv(SEPARATOR(','),heading(1),quote('"')));

	EXPORT com_banker 			:= dataset(dirname + 'using' + '::' + 'cbk', 
																		 Prof_License_Mari.layout_AZS0639.Mtg_Broker,
																		 csv(SEPARATOR(','),heading(1),quote('"')));
		
	EXPORT escrow_agt 			:= dataset(dirname + 'using' + '::' + 'ea', 
																		 Prof_License_Mari.layout_AZS0639.Com_Agent,
																		 csv(SEPARATOR(','),heading(1),quote('"')));
		
	EXPORT mtg_broker 			:= dataset(dirname + 'using' + '::' + 'mb', 
																		 Prof_License_Mari.layout_AZS0639.Mtg_Broker,
																		 csv(SEPARATOR(','),heading(1),quote('"')));
		
END;
/* export files_AZS0639 := MODULE
   
   export mtg_banker := dataset('~thor_data400::in::prolic::AZS0639::az_bk.txt',Prof_License_Mari.layout_AZS0639.Mtg_Broker,csv(SEPARATOR(','),heading(1)));
   export com_banker := dataset('~thor_data400::in::prolic::AZS0639::az_cb.txt',Prof_License_Mari.layout_AZS0639.Com_Agent,csv(SEPARATOR(','),heading(1)));
   export escrow_agt := dataset('~thor_data400::in::prolic::AZS0639::az_ea.txt',Prof_License_Mari.layout_AZS0639.Com_Agent,csv(SEPARATOR(','),heading(1)));
   export mtg_broker := dataset('~thor_data400::in::prolic::AZS0639::az_mb.txt',Prof_License_Mari.layout_AZS0639.Mtg_Broker,csv(SEPARATOR(','),heading(1)));
   
   END;
*/