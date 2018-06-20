import iesp, Royalty, RiskWiseFCRA, FFD;
EXPORT Layouts := MODULE
	
	export cp_out_layout := record
		iesp.fcraconsumerprofilereport.t_ConsumerProfileResult Result;
		dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements;
		iesp.share_fcra.t_FcraConsumer ConsumerInquiry;
		Royalty.Layouts.Royalty Royalty;
	end;
	//---------FFD----------	
	export working := RECORD(RiskWiseFCRA.layouts.working)
	  FFD.Layouts.CommonRawRecordElements;
	END;	

END;