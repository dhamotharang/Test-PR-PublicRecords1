export MAC_Link_PCNSR_To_Input(l,r,m) := MACRO
		SELF.matchCode := if(r.phone_number<>'',m,l.matchCode);
		SELF.outdata := if(r.phone_number<>'',PROJECT(r,TRANSFORM(DayBatchPCNSR.Layout_PCNSR,SELF := LEFT, self := [])),
																					l.outdata);
		SELF.indata := l.indata;
ENDMACRO;