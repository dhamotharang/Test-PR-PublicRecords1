export MAC_Append_CreditHdrSrc(infile,appended,data_restriction_mask='') := MACRO
	import doxie,ut,Header,DayBatchUtils,mdr;
	#UNIQUENAME(k)
	%k% := doxie.Key_Header;

	#UNIQUENAME(Layout_out)
	%Layout_out% := RECORD
		infile;
		boolean isCreditHeader;
	END;
	
	#UNIQUENAME(appendFlag)
	%Layout_out% %appendFlag%(infile le,%k% ri) := TRANSFORM
			SELF.isCreditHeader := IF(ri.did <> 0,true,false);
			SELF := le;
	END;
	
	
	appended := JOIN(infile,%k%,
									 KEYED(LEFT.did = RIGHT.s_did) AND
									 LEFT.fname = RIGHT.fname AND
									 LEFT.lname = RIGHT.lname AND
									 LEFT.prim_range = RIGHT.prim_range AND
									 LEFT.prim_name = RIGHT.prim_name AND
									 LEFT.zip = RIGHT.zip AND
									 LEFT.ssn = RIGHT.ssn AND 
									 DayBatchHeader.isCreditHeaderSrc(RIGHT.src) AND
									 ~Doxie.DataRestriction.isHeaderSourceRestricted(right.src, data_restriction_mask),
									 %appendFlag%(LEFT,RIGHT),LEFT OUTER,
									 ATMOST(KEYED(LEFT.did = RIGHT.s_did),7500),
									 KEEP(1)
									); 

ENDMACRO;