export zip1_isCorrect(string state_zip) := FUNCTION
zip1_state_rec := RECORD
   string zip1;
   string state;
END;

zip1_state_ds := 
 DATASET([
          {'0', 'CT'},
          {'0', 'MA'},
          {'0', 'ME'},
          {'0', 'NH'},
          {'0', 'NJ'},
          {'0', 'PR'},
          {'0', 'RI'},
          {'0', 'VT'},
          {'0', 'VI'},
          {'0', 'AE'},
          {'0', 'AE'},
          {'1', 'DE'},
          {'1', 'NY'},
          {'1', 'PA'},
          {'2', 'DC'},
          {'2', 'MD'},
          {'2', 'NC'},
          {'2', 'SC'},
          {'2', 'VA'},
          {'2', 'WV'},
          {'3', 'AL'},
          {'3', 'FL'},
          {'3', 'GA'},
          {'3', 'MS'},
          {'3', 'TN'},
          {'3', 'AA'},
          {'3', 'AA'},
          {'4', 'IN'},
          {'4', 'KY'},
          {'4', 'MI'},
          {'4', 'OH'},
          {'5', 'IA'},
          {'5', 'MN'},
          {'5', 'MT'},
          {'5', 'ND'},
          {'5', 'SD'},
          {'5', 'WI'},
          {'6', 'IL'},
          {'6', 'KS'},
          {'6', 'MO'},
          {'6', 'NE'},
          {'7', 'AR'},
          {'7', 'LA'},
          {'7', 'OK'},
          {'7', 'TX'},
          {'8', 'AZ'},
          {'8', 'CO'},
          {'8', 'ID'},
          {'8', 'NM'},
          {'8', 'NV'},
          {'8', 'UT'},
          {'8', 'WY'},
          {'9', 'AK'},
          {'9', 'AS'},
          {'9', 'CA'},
          {'9', 'GU'},
          {'9', 'HI'},
          {'9', 'MH'},
          {'9', 'FM'},
          {'9', 'MP'},
          {'9', 'OR'},
          {'9', 'PW'},
          {'9', 'WA'},
          {'9', 'AP'},
          {'9', 'AP'}
         ]
         , zip1_state_rec
        );
        
  string st := REGEXREPLACE('^.*([A-Z][A-Z]) \\d{5}$', state_zip, '$1');
  string z1 := REGEXREPLACE('^.*[A-Z][A-Z] (\\d)\\d{4}$', state_zip, '$1');
	return IF(COUNT(zip1_state_ds((zip1=z1) and (state=st)))>0, true, false);
END;
