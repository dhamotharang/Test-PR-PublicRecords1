IMPORT dnb,iesp,doxie_files, BIPV2;
export Layouts := MODULE;
	export Layout_dnb_out :=record 
		DNB.Layout_DNB_Base;
		BIPV2.IDlayouts.l_xlink_ids;
	end;

	export dnbNumberPlus := record
		   string15 duns_number;
		   unsigned6 bdid;
		   boolean isDeepDive := false;
	end;	
	export rawrec := record
		   Layout_dnb_out;
		   boolean isDeepDive := false;
		   unsigned2 penalt := 0;
	end;	
	export t_dnbRecordWithPenalty := record
		   iesp.dunandbradstreet.t_DunAndBradstreetRecord;
		   boolean isDeepDive := false;
		   unsigned2 penalt := 0;
	end;	

END;