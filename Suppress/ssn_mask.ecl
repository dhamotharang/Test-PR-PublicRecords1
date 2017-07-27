EXPORT ssn_mask(STRING i, STRING mask_type) := 
  FUNCTION
    cleanMask := StringLIb.StringToUpperCase( mask_type );
    original	:= stringlib.stringfilter(i,'0123456789xX');
    pad_len		:= 9 - LENGTH(original);
    complete	:= '000000000'[1..pad_len] + original;
    
    masked := CASE( cleanMask,
                    'ALL'			=>	'xxxxxxxxx',
                    'LAST4'		=>	complete[1..5] + 'xxxx',
                    'FIRST5'	=>	'xxxxx' + complete[6..9],
                    complete
                  );
	
	RETURN masked[(pad_len+1)..9];
	
END;