	import ut,corp2;
	
	//********************************************************************
			//This function will remove ASCII special characters and NUll characters from a string  with replacing  blank
	//********************************************************************
	Export fRemoveSpecialChars(string str):= function 

				List          := ['SAME','SAME AS ABOVE','ON FILE','NONE','UNKNOWN','TO REPORT'];				
				PatternSPC1 	:= '(\\x27)*|(\\.)*|(\\,)*|(\\x5c)*|(\\*)*|(\\x60)*|(\\&)*|(\\\\)*|(\\x21)*|(\\x3D)*|(\\x7B)*|(\\x7C)';
				PatternSPC2 	:= '(\\x22)*|(\\x28)*|(\\x29)*|(\\x23)*|(\\x2A)*|(\\x27)*|(\\x2F)*|(\\x3A)*|(\\x3D)*|(\\x7D)*|(\\x7E)';
				PatternSPC3 	:= '(\\x25)*|(\\x3B)*|(\\x3C)*|(\\x24)*|(\\x3E)*|(\\x26)*|(\\x3F)*|(\\x40)*|(\\x5B)*|(\\x5D)*|(\\x2B)';
				PatternSPChar := PatternSPC1 + PatternSPC2 + PatternSPC3 ;
				s1						:= if( str not in list ,regexreplace(PatternSPChar,str,''),'');
				s2						:= ut.fn_RemoveSpecialChars(s1); //for 'î€ˆJN HILL'
				s3						:= corp2.t2u(regexreplace('[\\x00|.]',s2,' ')) ;//for Nulls
				
				return s3;
	end;