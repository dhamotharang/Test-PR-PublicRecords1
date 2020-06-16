IMPORT Std, dx_ip_metadata;

EXPORT _Functions := MODULE

	EXPORT IPv4toInt(STRING IP_Address) := FUNCTION
      octets := Std.Str.SplitWords(IP_Address,'.');
      octet3 := INTFORMAT((UNSIGNED)octets[3],3,1);
      octet4 := INTFORMAT((UNSIGNED)octets[4],3,1);
      RETURN (UNSIGNED)(octet3+octet4);
	END;
	
	//pull alpha only
	EXPORT clAlph(string a):= FUNCTION
		return stringlib.stringfilter(stringlib.stringtouppercase(a), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ/-\'_#, ');
	END;

	//pull string numbers only
	EXPORT clNum(string b) := FUNCTION
		return stringlib.stringfilter(b, '0123456789/-.');
	END;
	
	//pull string alpha/numbers only
	EXPORT clAlphNum(string c) := FUNCTION
		fRec 		:= stringlib.stringfilter(stringlib.stringtouppercase(c), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-.\'_#, ');	
		return fRec;
	END;

	//Format Hex string with all caps and leading zeroes
	EXPORT FormatHexAddress(string address) := FUNCTION
		hextets := Std.Str.SplitWords(address, ':');
		full_address := dx_ip_metadata.functions.hex4format(hextets[1]) + ':' + dx_ip_metadata.functions.hex4format(hextets[2]) + ':' +  dx_ip_metadata.functions.hex4format(hextets[3]) 
						+ ':' + dx_ip_metadata.functions.hex4format(hextets[4]) + ':' +  dx_ip_metadata.functions.hex4format(hextets[5]) + ':' +  dx_ip_metadata.functions.hex4format(hextets[6]) + ':'
						+ dx_ip_metadata.functions.hex4format(hextets[7]) + ':' +  dx_ip_metadata.functions.hex4format(hextets[8]);
		return full_address;
	END;
	
	//expand ranges
	EXPORT expandRanges(DATASET(IP_Metadata.Layout_IP_Metadata.Base) ipRecs, UNSIGNED octet) := FUNCTION

		workRec	:=RECORD
			unsigned  rowCnt;
			unsigned1 beg_octet_1;
			unsigned1 beg_octet_2;
			unsigned1 beg_octet_3;
			unsigned1 beg_octet_4;
			unsigned1 end_octet_1;
			unsigned1 end_octet_2;
			unsigned1 end_octet_3;
			unsigned1 end_octet_4;
			IP_Metadata.Layout_IP_Metadata.Base;
		END;

		parentChild:=RECORD
			workRec;
			DATASET(workRec) expand;
		END;

		workRecs:=PROJECT(ipRecs,TRANSFORM(workRec,
			SELF.rowCnt				:=0;
			beg_octets 				:= Std.Str.SplitWords(LEFT.IP_Rng_Beg,'.');
			SELF.beg_octet_1 	:= (UNSIGNED)beg_octets[1];
			SELF.beg_octet_2 	:= (UNSIGNED)beg_octets[2];
			SELF.beg_octet_3 	:= (UNSIGNED)beg_octets[3];
			SELF.beg_octet_4 	:= (UNSIGNED)beg_octets[4];
			end_octets 				:= Std.Str.SplitWords(LEFT.IP_Rng_End,'.');
			SELF.end_octet_1 	:= (UNSIGNED)end_octets[1];
			SELF.end_octet_2 	:= (UNSIGNED)end_octets[2];
			SELF.end_octet_3 	:= (UNSIGNED)end_octets[3];
			SELF.end_octet_4 	:= (UNSIGNED)end_octets[4];
			SELF							:= LEFT;
		));

		// OCTET 1 EXPANSION
		workRec expandOctet1(workRec L,workRec R,UNSIGNED C) := TRANSFORM
			end_octet_1				:=IF(C=1,R.beg_octet_1,L.end_octet_1+1);
			end_octet_2				:=IF(C!=R.rowCnt,255,R.end_octet_2);
			end_octet_3				:=IF(C!=R.rowCnt,255,R.end_octet_3);
			end_octet_4				:=IF(C!=R.rowCnt,255,R.end_octet_4);
			beg_octet_1				:=IF(C=1,R.beg_octet_1,L.beg_octet_1+1);
			beg_octet_2				:=IF(C>1,0,R.beg_octet_2);
			beg_octet_3				:=IF(C>1,0,R.beg_octet_3);
			beg_octet_4				:=IF(C>1,0,R.beg_octet_4);
			SELF.end_octet_1	:=end_octet_1;
			SELF.end_octet_2	:=end_octet_2;
			SELF.end_octet_3	:=end_octet_3;
			SELF.end_octet_4	:=end_octet_4;
			SELF.beg_octet_1	:=beg_octet_1;
			SELF.beg_octet_2	:=beg_octet_2;
			SELF.beg_octet_3	:=beg_octet_3;
			SELF.beg_octet_4	:=beg_octet_4;
			SELF.ip_rng_beg		:=(STRING)beg_octet_1+'.'+(STRING)beg_octet_2+'.'+(STRING)beg_octet_3+'.'+(STRING)beg_octet_4;
			SELF.ip_rng_end		:=(STRING)end_octet_1+'.'+(STRING)end_octet_2+'.'+(STRING)end_octet_3+'.'+(STRING)end_octet_4;
			SELF							:=R;
		END;

		parentChild deNormOctet1(workRec L,DATASET(workRec) R) := TRANSFORM
			loopCnt						:=(L.end_octet_1-L.beg_octet_1);
			loopTemp					:=LOOP(R,loopCnt,ROWS(LEFT)+R);
			loopRows					:=PROJECT(loopTemp,TRANSFORM(workRec,SELF.rowCnt:=COUNT(loopTemp),SELF:=LEFT));
			iterateRows				:=ITERATE(loopRows,expandOctet1(LEFT,RIGHT,COUNTER));
			SELF.expand				:=PROJECT(iterateRows,TRANSFORM(workRec,SELF:=LEFT));
			SELF							:=L;
		END;

		workRecs1		:=workRecs(beg_octet1!=end_octet1);

		deNormRecs1	:=DENORMALIZE(workRecs1,workRecs1,
															LEFT.beg_octet_1=RIGHT.beg_octet_1,
															GROUP,
															deNormOctet1(LEFT,ROWS(RIGHT)));

		normRecs1		:=NORMALIZE(deNormRecs1,
															LEFT.expand,
															TRANSFORM(workRec,
															SELF:=RIGHT));

		// OCTET 2 EXPANSION
		workRec expandOctet2(workRec L,workRec R,UNSIGNED C) := TRANSFORM
			end_octet_1					:=R.beg_octet_1;
			end_octet_2					:=IF(C=1,R.beg_octet_2,L.end_octet_2+1);
			end_octet_3					:=IF(C!=R.rowCnt,255,R.end_octet_3);
			end_octet_4					:=IF(C!=R.rowCnt,255,R.end_octet_4);
			beg_octet_1					:=R.beg_octet_1;
			beg_octet_2					:=IF(C=1,R.beg_octet_2,L.beg_octet_2+1);
			beg_octet_3					:=IF(C>1,0,R.beg_octet_3);
			beg_octet_4					:=IF(C>1,0,R.beg_octet_4);
			SELF.end_octet_1		:=end_octet_1;
			SELF.end_octet_2		:=end_octet_2;
			SELF.end_octet_3		:=end_octet_3;
			SELF.end_octet_4		:=end_octet_4;
			SELF.beg_octet_1		:=beg_octet_1;
			SELF.beg_octet_2		:=beg_octet_2;
			SELF.beg_octet_3		:=beg_octet_3;
			SELF.beg_octet_4		:=beg_octet_4;
			SELF.ip_rng_beg			:=(STRING)beg_octet_1+'.'+(STRING)beg_octet_2+'.'+(STRING)beg_octet_3+'.'+(STRING)beg_octet_4;
			SELF.ip_rng_end			:=(STRING)end_octet_1+'.'+(STRING)end_octet_2+'.'+(STRING)end_octet_3+'.'+(STRING)end_octet_4;
			SELF								:=R;
		END;

		parentChild deNormOctet2(workRec L,DATASET(workRec) R) := TRANSFORM
			loopCnt							:=(L.end_octet_2-L.beg_octet_2);
			loopTemp						:=LOOP(R,loopCnt,ROWS(LEFT)+R);
			loopRows						:=PROJECT(loopTemp,TRANSFORM(workRec,SELF.rowCnt:=COUNT(loopTemp),SELF:=LEFT));
			iterateRows					:=ITERATE(loopRows,expandOctet2(LEFT,RIGHT,COUNTER));
			SELF.expand					:=PROJECT(iterateRows,TRANSFORM(workRec,SELF:=LEFT));
			SELF								:=L;
		END;

		workRecs2			:=workRecs(beg_octet1=end_octet1,beg_octet2!=end_octet2);

		denormRecs2		:=DENORMALIZE(workRecs2,workRecs2,
																LEFT.beg_octet_1=RIGHT.beg_octet_1 AND 
																LEFT.beg_octet_2=RIGHT.beg_octet_2,
																GROUP,
																deNormOctet2(LEFT,ROWS(RIGHT)));

		normRecs2			:=NORMALIZE(denormRecs2,
															LEFT.expand,
															TRANSFORM(workRec,SELF:=RIGHT));

		normRecs			:=IF(octet=1,normRecs1,normRecs2);

		outRecs				:=PROJECT(normRecs,
														TRANSFORM(IP_Metadata.Layout_IP_Metadata.Base,
																			beg_octets 					:= Std.Str.SplitWords(LEFT.IP_Rng_Beg,'.');
																			SELF.beg_octet1 		:= (UNSIGNED)beg_octets[1];
																			SELF.beg_octet2 		:= (UNSIGNED)beg_octets[2];
																			SELF.beg_octets34 	:= IPv4toInt(LEFT.IP_Rng_Beg);
																			end_octets 					:= Std.Str.SplitWords(LEFT.IP_Rng_End,'.');
																			SELF.end_octet1 		:= (UNSIGNED)end_octets[1];
																			SELF.end_octet2 		:= (UNSIGNED)end_octets[2];
																			SELF.end_octets34 	:= IPv4toInt(LEFT.IP_Rng_End);
																			SELF.generated_rec	:= TRUE;
																			SELF								:= LEFT;
		));

		RETURN outRecs;
	END;
	EXPORT expandRangesHex(DATASET(IP_Metadata.Layout_IP_Metadata.base_ipv6) ipRecs, UNSIGNED octet) := FUNCTION
		workRec:=RECORD
			UNSIGNED  rowCnt;
			UNSIGNED2 beg_hextet_1;
			UNSIGNED2 end_hextet_1;
			IP_Metadata.Layout_IP_Metadata.base_ipv6;
		END;

		workRecs:=PROJECT(ipRecs,TRANSFORM(workRec,
			SELF.rowCnt       := 0;
			//beg_hextets       := Std.Str.SplitWords(LEFT.ip_rng_beg,':');
			SELF.beg_hextet_1 := dx_ip_metadata.functions.hex4char2int(LEFT.beg_hextet1);
			//end_hextets       := Std.Str.SplitWords(LEFT.ip_rng_end,':');
			SELF.end_hextet_1 := dx_ip_metadata.functions.hex4char2int(LEFT.end_hextet1);
			SELF              := LEFT;
		));

		// HEXTET 1 EXPANSION
		workRec expandHextet1(workRec L,workRec R,UNSIGNED C) := TRANSFORM
			end_hextet_1 := IF(C=1,R.beg_hextet_1,L.end_hextet_1+1);
			beg_hextet_1 := IF(C=1,R.beg_hextet_1,L.beg_hextet_1+1);

			SELF.end_hextet_1 := end_hextet_1;
			SELF.beg_hextet_1 := beg_hextet_1;
			self.beg_hextet1 := dx_ip_metadata.functions.int2hex4char(beg_hextet_1);
			self.end_hextet1 := dx_ip_metadata.functions.int2hex4char(end_hextet_1);
			beg_hextets       := Std.Str.SplitWords(R.ip_rng_beg,':');
			end_hextets       := Std.Str.SplitWords(R.ip_rng_end,':');

			SELF.ip_rng_beg_full := IF(C>1,
								self.beg_hextet1+':0000:0000:0000:0000:0000:0000:0000' ,
								formathexaddress(self.beg_hextet1+':'+beg_hextets[2]+':'+beg_hextets[3]+':'+beg_hextets[4]+':'+
								beg_hextets[5]+':'+beg_hextets[6]+':'+beg_hextets[7]+':'+beg_hextets[8]));
			SELF.ip_rng_end_full := IF(C!=R.rowCnt,
									self.end_hextet1+':FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF',
									formathexaddress(self.end_hextet1+':'+end_hextets[2]+':'+end_hextets[3]+':'+end_hextets[4]+':'+
									end_hextets[5]+':'+end_hextets[6]+':'+end_hextets[7]+':'+end_hextets[8]));
			self.ip_rng_beg_full6_39					:= SELF.ip_rng_beg_full[6..39];
			self.ip_rng_end_full6_39					:= SELF.ip_rng_end_full[6..39];
			SELF            := R;
		END;

		parentChild:=RECORD
			workRec;
			DATASET(workRec) expand;
		END;

		parentChild deNormhextet1(workRec L,DATASET(workRec) R) := TRANSFORM
			loopCnt     :=(L.end_hextet_1-L.beg_hextet_1);
			loopTemp    :=LOOP(R,loopCnt,ROWS(LEFT)+R);
			loopRows    :=PROJECT(loopTemp,TRANSFORM(workRec,SELF.rowCnt:=COUNT(loopTemp),SELF:=LEFT));
			iterateRows :=ITERATE(loopRows,expandhextet1(LEFT,RIGHT,COUNTER));
			SELF.expand :=PROJECT(iterateRows,TRANSFORM(workRec,SELF:=LEFT));
			SELF        :=L;
		END;

		targetRecs  :=workRecs(beg_hextet_1!=end_hextet_1);

		deNormRecs  :=DENORMALIZE(targetRecs,targetRecs,
								LEFT.beg_hextet_1=RIGHT.beg_hextet_1,
								GROUP,
								deNormhextet1(LEFT,ROWS(RIGHT)));

		normRecs    :=NORMALIZE(deNormRecs,
								LEFT.expand,
								TRANSFORM(workRec, 
								self.generated_rec := true;
								SELF:=RIGHT));
		expandedRecs:=PROJECT(normRecs, $.Layout_IP_Metadata.base_ipv6);

	//	OUTPUT(ipRecs);
	//	OUTPUT(targetRecs);
	//	OUTPUT(deNormRecs);
	//	OUTPUT(normRecs);
	//	OUTPUT(expandedRecs);
		return expandedRecs; 
	END;
	

END;