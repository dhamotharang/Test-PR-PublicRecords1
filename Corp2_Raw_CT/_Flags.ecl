IMPORT _Control, tools;

EXPORT _Flags := MODULE
	EXPORT Base := MODULE
		EXPORT BusMaster	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.BusMaster.QA))) > 0;
		EXPORT BusFiling	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.BusFiling.QA))) > 0;
		EXPORT BusMerger	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.BusMerger.QA))) > 0;
		EXPORT BusOther	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.BusOther.QA))) > 0;
		EXPORT BusReserve	:= COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.BusReserve.QA))) > 0;
		EXPORT Corps	    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.Corps.QA))) > 0;
		EXPORT DLMTPart	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.DLMTPart.QA))) > 0;
		EXPORT FLMTPart	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.FLMTPart.QA)))	> 0;
		EXPORT DLMTCorp	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.DLMTCorp.QA))) > 0;
		EXPORT FLMTCorp	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.FLMTCorp.QA))) > 0;
		EXPORT NameChg	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.NameChg.QA))) > 0;
		EXPORT FilmIndx	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.FilmIndx.QA))) > 0;
		EXPORT Stock	    := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.Stock.QA))) > 0;
		EXPORT Prncipal	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.Prncipal.QA))) > 0;
		EXPORT DLMLPart	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.DLMLPart.QA))) > 0;
		EXPORT FLMLPart	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.FLMLPart.QA))) > 0;
		EXPORT General	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.General.QA))) > 0;
		EXPORT ForStat	  := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_CT.Filenames().Base.ForStat.QA))) > 0;
	end;
end;