import Header;

export Fn_Append_Flags(GROUPED DATASET(DayBatchHeader.Layout_LinkHeader) infile) := FUNCTION
	
	Layout_temp := RECORD
		STRING20 acctno;
		Header.Layout_Header;
	END;

	Layout_CrdtAppended := RECORD
		Header.Layout_Header;
		boolean isCreditHeader := false;
	END;
	
	Layout_out := RECORD
		DayBatchHeader.Layout_clean_in indata;
		Layout_CrdtAppended outdata;
		infile.matchCode;
	END;
	
	tempRecs := PROJECT(infile,TRANSFORM(Layout_temp,SELF.acctno := LEFT.indata.acctno,SELF := LEFT.outdata));
	
	MAC_Updt_AddrDtFirstSeen(tempRecs,acctno,tempDtUpdt,doxie.DataRestriction.fixed_DRM)
	
	MAC_Append_CreditHdrSrc(tempDtUpdt,outTemp,doxie.DataRestriction.fixed_DRM)

	Layout_out formatOut(infile le,outTemp ri) := TRANSFORM
		SELF.indata := le.indata;
		SELF.matchCode := le.matchCode;
		SELF.outdata := ri;
	END;
	
	outRecs := JOIN(infile,outTemp,
									LEFT.indata.acctno = RIGHT.acctno AND
									LEFT.outdata.did = RIGHT.did,
									formatOut(LEFT,RIGHT)
									);
	
//	output(outTemp,Named('OUT_TEMP'));
//	output(tempRecs,Named('IN_TEMP'));
	
	RETURN outRecs;
END;

