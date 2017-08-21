IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT Addresses			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WV.Filenames().Base.addresses.QA)))     		> 0;
		EXPORT amendments			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WV.Filenames().Base.amendments.QA))) 		  > 0;
		EXPORT annualreports	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WV.Filenames().Base.annualreports.QA))) 	  > 0;
		EXPORT corporations		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WV.Filenames().Base.corporations.QA))) 		> 0;
		EXPORT Dissolutions		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WV.Filenames().Base.dissolutions.QA))) 		> 0;
		EXPORT dbas						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WV.Filenames().Base.dbas.QA))) 		 				> 0;
		EXPORT mergers				:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WV.Filenames().Base.mergers.QA))) 					> 0;
		EXPORT namechanges		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WV.Filenames().Base.namechanges.QA))) 		 	> 0;
		EXPORT subsidiaries		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_WV.Filenames().Base.subsidiaries.QA))) 		> 0;
	end;
	
end;