EXPORT mac_slimheader(infile, outf, fastHeader = 'true') := macro

#uniquename(trans_temp_SSN)
	Suspicious_Fraud_LN.layouts.temp_SSN %trans_temp_SSN%(infile le) := TRANSFORM
	
	self.ssn := (string9)le.ssn;
  self.prim_range := (string10)le.prim_range; 
  self.prim_name := (string28)le.prim_name;
	self.zip :=(string5)le.zip;
	self.src := IF(le.src in ['QH', 'WH'] and fastHeader, MDR.sourceTools.src_Equifax, le.src);
	dt_lastTemp := MAP(le.dt_last_seen <> 0 																																					=> le.dt_last_seen,
										le.dt_vendor_last_reported <> 0 AND le.src != MDR.SourceTools.src_TU_CreditHeader AND ~fastHeader	=> le.dt_vendor_last_reported, // Don't trust vendor dates from TransUnion credit header or any FAST Header source
										le.dt_first_seen <> 0 																																						=> le.dt_first_seen,
										le.src != MDR.SourceTools.src_TU_CreditHeader AND ~fastHeader 																		=> le.dt_vendor_first_reported, // Don't trust vendor dates from TransUnion credit header or any FAST Header source
																																																												 0);
		dt_last := IF(dt_lastTemp >= (unsigned3)sysdate[1..6], (unsigned3)sysdate[1..6], dt_lastTemp);
		dt_first := MAP(le.src IN [MDR.SourceTools.src_Equifax_Quick, MDR.SourceTools.src_Equifax_Weekly]	=> le.dt_first_seen, // If Quick or Weekly header then use that first seen
										le.dt_first_seen <> 0																															=> le.dt_first_seen,
										dt_last <= le.dt_vendor_first_reported																						=> dt_last, // make sure the dt_first is <= dt_last
										le.src != MDR.SourceTools.src_TU_CreditHeader																			=> le.dt_vendor_first_reported, // Don't trust vendor dates from TransUnion Credit Header
																																																				 0);
		SELF.Dt_First_Seen := dt_first;
		SELF.Dt_Last_Seen  :=   dt_last;
		SELF := le;
		self := [];

	END;
	
	outf := project(infile, %trans_temp_SSN%(left));
	ENDMACRO;
	
