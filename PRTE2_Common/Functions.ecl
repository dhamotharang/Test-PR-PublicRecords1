/* *******************************************************************************************************************************
PRTE2_Common.Functions
******************************************************************************************************************************* */
IMPORT STD;

EXPORT Functions := MODULE

		EXPORT Pick1(STRING s1,STRING s2) := IF(TRIM(s1,left,right)='',TRIM(s2),TRIM(s1));
		EXPORT Pick1Int(INTEGER s1,INTEGER s2) := IF(s1=0,s2,s1);
		EXPORT Pick1Unsign(UNSIGNED s1,UNSIGNED s2) := IF(s1=0,s2,s1);
		EXPORT appendIFDot2(STRING s1,STRING s2) := IF(TRIM(s1)<>'' AND TRIM(S2)<>'', TRIM(s1)+'.'+TRIM(s2),Pick1(s1,s2));
		EXPORT appendIFDot4(STRING s1,STRING s2,STRING s3,STRING s4) := appendIFDot2(appendIFDot2(s1,s2),appendIFDot2(s3,s4));

		// appendIf functions are for taking 2-5 strings, and if they are not blank, appending them with a space.
		// EG: To create address line1 from clean data you would:
		//     appendIf5(right.prim_range,right.predir,right.prim_name,right.suffix,right.postdir)
		EXPORT appendIf(STRING s1, STRING s2, STRING sep=' ') := TRIM(IF(s1='', s2, TRIM(s1)+sep+TRIM(s2) ));
		EXPORT appendIf3(STRING s1, STRING s2, STRING s3) := appendIf(appendIf(s1,s2),s3);
		EXPORT appendIfCSZ(STRING s1, STRING s2, STRING s3) := appendIf(appendIf(s1,s2,','),s3);
		EXPORT appendIf4(STRING s1, STRING s2, STRING s3, STRING s4) := appendIf(appendIf3(s1,s2,s3),s4);
		EXPORT appendIf5(STRING s1, STRING s2, STRING s3, STRING s4, STRING s5) := appendIf(appendIf4(s1,s2,s3,s4),s5);

		EXPORT UPPER(STRING S1) := STD.Str.ToUpperCase(S1);
		
END;