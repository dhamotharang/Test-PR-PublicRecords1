IMPORT PublicRecords_KEL, Suppress;

EXPORT Fn_getpullid(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) indata,
										PublicRecords_KEL.Interface_Options Options) := FUNCTION
										

	
	appType := Suppress.Constants.ApplicationTypes.DEFAULT;

	Suppress.MAC_Suppress(indata, out_didbySSN_suppress ,appType, Suppress.Constants.LinkTypes.ssn,P_InpClnSSN);//search by ssn 

	Suppress.MAC_Suppress(out_didbySSN_suppress, out_suppress, appType, Suppress.Constants.LinkTypes.DID,P_lexid);//seach by did

	
	
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII CheckDIDorSSN(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII le, PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII ri) := TRANSFORM
		SELF.P_lexid := ri.P_lexid;
		SELF.PullIDFlag := if(ri.P_lexid = 0 and le.P_lexid != 0, TRUE, FALSE);
		SELF := le;
	END;
	got_DIDbySSN := join(indata, out_suppress, 
													left.G_ProcUID = right.G_ProcUID and left.P_lexid=right.P_lexid, 		
													CheckDIDorSSN(LEFT, RIGHT), LEFT OUTER, keep(1));	

RETURN got_DIDbySSN;

END;					