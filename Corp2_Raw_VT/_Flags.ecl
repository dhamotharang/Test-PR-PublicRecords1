IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT DomLLCBus		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.DomLLCBus.QA))) 		> 0;
		EXPORT DomLLCPrn		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.DomLLCPrn.QA))) 		> 0;
		EXPORT DomMBEBus		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.DomMBEBus.QA))) 		> 0;
		EXPORT DomMBEPrn		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.DomMBEPrn.QA))) 		> 0;
		EXPORT DomNPCBus		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.DomNPCBus.QA))) 		> 0;
		EXPORT DomNPCPrn		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.DomNPCPrn.QA))) 		> 0;
		EXPORT DomProfBus		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.DomProfBus.QA))) 	> 0;
		EXPORT DomProfPrn		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.DomProfPrn.QA))) 	> 0;
		EXPORT ForLLCBus		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.ForLLCBus.QA))) 		> 0;
		EXPORT ForLLCPrn		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.ForLLCPrn.QA))) 		> 0;
		EXPORT ForNPCBus		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.ForNPCBus.QA))) 		> 0;
		EXPORT ForNPCPrn		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.ForNPCPrn.QA))) 		> 0;
		EXPORT ForProfBus		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.ForProfBus.QA))) 	> 0;
		EXPORT ForProfPrn		:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.ForProfPrn.QA))) 	> 0;
		EXPORT PshipsBus	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.PshipsBus.QA)))    > 0;
		EXPORT PshipsPrn	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.PshipsPrn.QA)))    > 0;
		EXPORT TrdNamesBus	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.TrdNamesBus.QA))) 	> 0;
		EXPORT TrdNamesPrn	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.TrdNamesPrn.QA))) 	> 0;
		EXPORT TrdNamesOwn	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_VT.Filenames().Base.TrdNamesOwn.QA))) 	> 0;
	END;
END;