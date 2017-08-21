IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT Amendments						:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Amendments.QA)))     		  > 0;
		EXPORT Inactive_Amendments	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Inactive_Amendments.QA)))  > 0;
		EXPORT Entities							:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Entities.QA))) 	  		  	> 0;
		EXPORT Inactive_Entities		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Inactive_Entities.QA))) 		> 0;
		EXPORT Names								:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Names.QA))) 		    > 0;
		EXPORT Inactive_Names 			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Inactive_Names .QA))) 		 	> 0;
		EXPORT mergers							:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.mergers.QA))) 					    > 0;
		EXPORT Inactive_Mergers			:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Inactive_Mergers.QA))) 		> 0;
		EXPORT Officers							:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Officers.QA))) 		 				> 0;
		EXPORT Inactive_Officers		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Inactive_Officers.QA))) 		> 0;
		EXPORT Stocks								:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Stocks.QA))) 		 				  > 0;
		EXPORT Inactive_Stocks 		  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_RI.Filenames().Base.Inactive_Stocks.QA))) 		  > 0;
	
	end;
	
end;