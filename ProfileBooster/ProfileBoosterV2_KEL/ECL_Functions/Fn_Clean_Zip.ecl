/*Cleans input zip
  If the zip is less than 5, pad 0's on the left side until it's a length of 5
  If the zip is more than 5 and less than 9, pad 0's on the left side until it's a length of 9
  If the zip is 5 zeros then blank out the zip
  If the zip is 9 zeros then blank out the zip
*/

EXPORT Fn_Clean_Zip (STRING zip) := FUNCTION
  zippy := TRIM(zip, RIGHT, LEFT);
  zipLen := LENGTH(zippy);

  zip5Diff := IF(zipLen < 5, 5 - zipLen, 0); //if less than 5, get # of fields we have to pad
  zip9Diff := IF(zipLen >= 6 AND zipLen < 9, 9 - zipLen, 0);//if less than 9, get # of fields we have to pad

  Five0s := stringlib.StringRepeat('0', 5); 
  Nine0s := stringlib.StringRepeat('0', 9);

  zip0ed := MAP(zippy = '' => '',
                zippy = Five0s => '', //if 5 0's then blank out
                zippy = Nine0s => '', //if 9 0's then blank out
                zip5Diff > 0 => INTFORMAT((INTEGER) zippy, 5, 1),//pad on left
                zip9Diff > 0 => INTFORMAT((INTEGER) zippy, 9, 1),//pad on left
                zipLen >= 9 => zippy[1..9], //if > 9, then truncate, we shouldn't hit this
                zippy);
  // output(zip0ed, named('zip0ed'));
  // output(zippy, named('zippy'));
  
	RETURN zip0ed;
END;