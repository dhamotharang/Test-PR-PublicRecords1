EXPORT buildDaily(string current, string version = '') := FUNCTION
		mstr := DISTRIBUTE(Gong_Neustar.File_Master,hash(record_id));
		daily := Gong_Neustar.GetDaily(current);
		
		m := Gong_Neustar.ProcessDailyFile(mstr, daily, current);
		h := Gong_Neustar.CreateHistoryFile(m, File_History, current);
		b := Gong_Neustar.proc_build_basefile(m, current);
		build_it_all := SEQUENTIAL(
			BuildScrubsReport(daily(action_code in ['A','I']), current),
		  OUTPUT(m,,gong_Neustar.Constants.lfnMaster + current,COMPRESSED,OVERWRITE),
		  OUTPUT(h,,gong_Neustar.Constants.lfnHistory + current,COMPRESSED,OVERWRITE),
		  OUTPUT(b,,gong_Neustar.Constants.lfnBase + current,COMPRESSED,OVERWRITE),
		  gong_Neustar.Promotions.Master(gong_Neustar.Constants.lfnMaster + current),
		  gong_Neustar.Promotions.History(gong_Neustar.Constants.lfnHistory + current),
		  gong_Neustar.Promotions.Base(gong_Neustar.Constants.lfnBase + current),
			proc_build_history_keys(current+version),
			proc_build_full_keys(current+version),
			UpdateDops(current+version),
			UpdateOrbit(current+version),
			proc_reports(current),
			UpdateHeaderVersion
		) :
			SUCCESS(FileServices.SendEmail(SuccessEmail, 'GONG - Daily Build Complete', WORKUNIT + ' Version: ' + current+version)),
      Failure(FileServices.SendEmail(FailureEmail, 'GONG - Daily Build Failure',WORKUNIT + '\n' + FAILMESSAGE))
		;
		return build_it_all;
END;