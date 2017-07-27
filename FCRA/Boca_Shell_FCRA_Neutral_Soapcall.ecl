import doxie, risk_indicators, riskwisefcra, gateway;

export Boca_Shell_FCRA_Neutral_Soapcall(DATASET(risk_indicators.layout_input) iid,
								DATASET(Gateway.Layouts.Config) gateways,
								UNSIGNED1	IN_DPPAPurpose,
								UNSIGNED1	IN_GLBPurpose,
								BOOLEAN	isutil = FALSE,
								BOOLEAN	IN_LNBranded = FALSE,
								BOOLEAN	includerel = FALSE,
								BOOLEAN	IN_Require2 = FALSE,
								BOOLEAN	IN_OFAC_Only = TRUE,
								BOOLEAN	IN_SuppressNearDups = FALSE,
								BOOLEAN	IN_From_BIID = FALSE,
								BOOLEAN	IN_ExcludeWatchLists = FALSE,
								BOOLEAN	IN_From_IT1O = FALSE,
								UNSIGNED1	IN_OFAC_Version = 1,
								BOOLEAN	IN_Include_OFAC = FALSE,
								BOOLEAN	IN_Include_additional_watchlists = FALSE,
								REAL		IN_Global_watchlist_threshold = 0.84,
								UNSIGNED1	IN_BSversion = 1, 
								boolean nugen=false,
								boolean ADL_Based_Shell=false,
								string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
								unsigned1 append_best=0) :=
FUNCTION

inrec := record, maxlength(500000)	// do I need to change the maxlength?
	dataset(risk_indicators.layout_input) batch_in;
	dataset(Gateway.Layouts.Config) gateways;
	unsigned1	DPPAPurpose;
	unsigned1	GLBPurpose;
	boolean	IsUtility;
	boolean	IncludeRelativeInfo;
	boolean	Require2;
	BOOLEAN	OFAC_Only;
	BOOLEAN	SuppressNearDups;
	BOOLEAN	From_BIID;
	BOOLEAN	ExcludeWatchLists;
	BOOLEAN   From_IT1O;
	UNSIGNED1 OFAC_Version;
	BOOLEAN	Include_OFAC;
	BOOLEAN	Include_additional_watchlists;
	REAL		Global_watchlist_threshold;	
	UNSIGNED1	BSversion;
	BOOLEAN nugen;
	boolean ADL_Based_Shell;
	string50 DataRestrictionMask;
	unsigned1 append_best;
	boolean _Blind := false;
end;


					
foo := dataset([{iid, gateways, IN_DPPAPurpose, IN_GLBPurpose, isUtil, IncludeRel,
			IN_Require2, IN_OFAC_Only, IN_SuppressNearDups, IN_From_BIID, IN_ExcludeWatchLists, IN_From_IT1O,
			IN_OFAC_Version, IN_Include_OFAC, IN_Include_additional_watchlists, IN_Global_watchlist_threshold, 
			IN_BSversion, nugen, ADL_Based_Shell, DataRestriction, append_best , Gateway.Configuration.GetBlindOption(gateways)}], inrec);

risk_indicators.Layout_BocaShell_Neutral errX(foo L) := transform
	self.errmsg := ERROR (FAILCODE, 'BS Neutral Service: ' + FAILMESSAGE);
	SELF.seq := L.batch_in[1].seq; //don't really need it?
	self := [];
end;

gateway_check := gateways(servicename IN riskwisefcra.Neutral_Service_Name)[1].url;
gateway_url := IF(gateway_check='',ERROR(301,doxie.ErrorCodes(301)),gateway_check);


outf := soapcall(foo, gateway_url, 'FCRA.Boca_Shell_FCRA_Neutral_Service',
		 		 inrec, transform(inrec, self := left), 
			 	 dataset(risk_indicators.Layout_BocaShell_Neutral),
			 	 parallel(3), merge(33), // pass multiple records at 1 time
				 onFail(errX(LEFT)),
				 timeout(600));	// changed the timeout



// Add PCR
layout_pcr := RECORD
	unsigned4 seq;
	unsigned6 date_created;
	risk_indicators.Layout_BocaShell_Neutral.ConsumerFlags ConsumerFlags;
END;

layout_pcr 
		add_flags_by_did(risk_indicators.Layout_BocaShell_Neutral le,
										 fcra.Key_Override_PCR_DID ri) :=
TRANSFORM
	SELF.ConsumerFlags.corrected_flag := true;
	SELF.ConsumerFlags.consumer_statement_flag := (ri.consumer_statement_flag='1');
	SELF.ConsumerFlags.dispute_flag := (ri.dispute_flag='1');
	SELF.ConsumerFlags.security_freeze := (ri.security_freeze='1');
	SELF.ConsumerFlags.security_alert := (ri.security_alert='1');
	SELF.ConsumerFlags.negative_alert := (ri.negative_alert='1');
	SELF.ConsumerFlags.id_theft_flag := (ri.id_theft_flag='1');
	SELF.date_created := (unsigned)ri.date_created;
	SELF := le;
END;
j1 := JOIN (outf, fcra.Key_Override_PCR_DID, 
            keyed(LEFT.did=RIGHT.s_did),
            add_flags_by_did(LEFT,RIGHT),
            LIMIT(10,SKIP), KEEP(1));

layout_pcr 
		add_flags_by_ssn(risk_indicators.Layout_BocaShell_Neutral le,
										 fcra.Key_Override_PCR_SSN ri) :=
TRANSFORM
	SELF.ConsumerFlags.corrected_flag := true;
	SELF.ConsumerFlags.consumer_statement_flag := (ri.consumer_statement_flag='1');
	SELF.ConsumerFlags.dispute_flag := (ri.dispute_flag='1');
	SELF.ConsumerFlags.security_freeze := (ri.security_freeze='1');
	SELF.ConsumerFlags.security_alert := (ri.security_alert='1');
	SELF.ConsumerFlags.negative_alert := (ri.negative_alert='1');
	SELF.ConsumerFlags.id_theft_flag := (ri.id_theft_flag='1');
	SELF.date_created := (unsigned)ri.date_created;
	SELF := le;
END;

j2 := JOIN (outf, fcra.Key_Override_PCR_SSN, 
            keyed(LEFT.Shell_Input.ssn=RIGHT.ssn) AND 
            datalib.NameMatch(LEFT.Shell_Input.fname,LEFT.Shell_Input.mname, LEFT.Shell_Input.lname,
                              RIGHT.fname, RIGHT.mname, RIGHT.lname)<3,
            add_flags_by_ssn(LEFT,RIGHT),
            LIMIT(10,SKIP), KEEP(1));

j3 := DEDUP(SORT(GROUP(j1)+GROUP(j2),seq,-(unsigned)date_created),seq);

risk_indicators.Layout_BocaShell_Neutral
	add_flags(risk_indicators.Layout_BocaShell_Neutral le, j3 ri) :=
TRANSFORM
	SELF.ConsumerFlags.corrected_flag := le.ConsumerFlags.corrected_flag OR ri.ConsumerFlags.corrected_flag;
	self.seq := le.seq;
	SELF := ri;
	SELF := le;
END;
with_flags := JOIN(outf, j3, LEFT.seq=RIGHT.seq, add_flags(LEFT,RIGHT), LOOKUP, LEFT OUTER);

return with_flags;

end;

