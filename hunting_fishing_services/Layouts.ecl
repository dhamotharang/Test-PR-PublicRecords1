import eMerges,iesp,FFD;
	
export Layouts := MODULE

	export search := record
		unsigned6 rid;
		boolean isDeepDive := false;
	end;
	
	export search_did := record
		unsigned6 did;
		boolean isDeepDive := false;
	end;

	export raw_rec := record
		recordof(eMerges.Key_HuntFish_Rid);
		string18 mail_county_name := '';
		boolean isDeepDive := false;
		unsigned2 penalt := 0;
		dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
		boolean isDisputed := false;
	end;

	export t_HuntFishRecordWithPenalty := record (iesp.huntingfishing_fcra.t_FcraHuntFishRecord)
	end;

end;
