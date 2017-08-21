

EXPORT Functions := MODULE

		// appendIf functions are for taking 2-5 strings, and if they are not blank, appending them with a space.
		// EG: To create address line1 from clean data you would:
		//     appendIf5(right.prim_range,right.predir,right.prim_name,right.suffix,right.postdir)
		EXPORT appendIf(STRING s1, STRING s2) := TRIM(IF(s1='', s2, TRIM(s1)+' '+TRIM(s2) ));
		EXPORT appendIf3(STRING s1, STRING s2, STRING s3) := appendIf(appendIf(s1,s2),s3);
		EXPORT appendIf4(STRING s1, STRING s2, STRING s3, STRING s4) := appendIf(appendIf3(s1,s2,s3),s4);
		EXPORT appendIf5(STRING s1, STRING s2, STRING s3, STRING s4, STRING s5) := appendIf(appendIf4(s1,s2,s3,s4),s5);

END;