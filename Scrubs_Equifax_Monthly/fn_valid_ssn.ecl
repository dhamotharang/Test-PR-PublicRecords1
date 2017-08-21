import ut,doxie;
EXPORT fn_valid_ssn(string ssn) := function

		known_bad(string sn) := (integer)sn in doxie.bad_ssn_list;
		popular_bad(string sn) := sn in
		
			['11111'    ,'111111'   ,'1010011'  ,'1010101'  ,'1111111'  ,'9999999'  ,'078051120','111111234','111112222',
			 '111221313','111222222','112223333','123111111','123451111','123454567','123456780','123456987','123457890',
			 '123459999','123654789','123984567','219099999','222330000','229229229','321654987','444556666','789456123'];
			
			
		  bad_format(string sn) :=	 (sn[4..5] = '00'  ) OR  // Group number is 01 or more
																 (sn[6..9] = '0000') OR  // sequence number starts at 0001
																 (sn[1]    = '9'   ) OR  // used for ITIN
																 (sn[1..3] = '666' ) OR  // used for ITIN
																 (sn[1..3] = '000' );    // never used
			
			is_valid :=    (   (trim(ssn)<>'')      )  AND
			               (NOT(known_bad(  ssn ))  )  AND
			               (NOT(popular_bad(ssn ))  )  AND
										 (NOT(bad_format( ssn ))  ) ;
									
			return is_valid;
			
end;