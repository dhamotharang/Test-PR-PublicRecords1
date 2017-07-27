import FLAccidents,iesp;
	
export Layouts := MODULE

	export report := record
		unsigned6 accident_nbr;
	end;

	export search := record
		string9 accident_nbr;
		boolean isDeepDive := false;
	end;

	export search_did := record
		unsigned6 did;
		boolean isDeepDive := false;
	end;

	export search_bdid := record
		unsigned6 bdid;
		boolean isDeepDive := false;
	end;
	
	export search_dlnbr := record
		string15 dlnbr;
		boolean isDeepDive := false;
	end;
	
	export search_tagnbr := record
		string8 tagnbr;
		boolean isDeepDive := false;
	end;
	
	export search_vin := record
		string22 vin;
		boolean isDeepDive := false;
	end;

	export raw_rec := record
	  recordof(FLAccidents.Key_FLCrash_AccNbr);
		boolean isDeepDive := false;
		unsigned2 penalt := 0;
		string70 pdf_image_hash := '';
		string70 tif_image_hash := '';
	end;

	export t_AccidentSearchRecordWithPenalty := record
		iesp.accident.t_AccidentSearchRecord;
	end;

end;
