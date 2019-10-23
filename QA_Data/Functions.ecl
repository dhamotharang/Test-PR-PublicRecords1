IMPORT qa_data, ut;

EXPORT Functions := Module
		
		EXPORT GetCleanCompany(string s)  := function
		  SpecialChars 	     := ut.CleanSpacesAndUpper(stringlib.stringfilterout(s,'`'));
			InvalidPhrases     := '^NONE$|^DEFAULT NAME$|^!$|~~~~~~-|^N/A$|^NA$|^NO$|^-$|LEAVE AT FRONT DOOR|^N A$|^---$|PLEASE KNOCK OR RING BELL|LEAVE AT BACK DOOR|OK TO LEAVE|LEAVE WITH DOORMAN|~~PLEASE SELECT~~';
			FilteredName	     := if(regexfind(InvalidPhrases,SpecialChars,0)<>'','',SpecialChars);
			
			RETURN if(ut.CleanSpacesAndUpper(stringlib.stringfilterout(FilteredName,'. '))='','',FilteredName);
    END;
		
		
		EXPORT GetCleanPhone(string s)  := function
			RETURN if(length(ut.CleanPhone(s)) in [7,10] and
								ut.CleanPhone(s) not in ['0000000','0000000000','1111111','1111111111',
																				 '2222222','2222222222','3333333','3333333333',
																				 '4444444','4444444444','5555555','5555555555',
																				 '6666666','6666666666','7777777','7777777777',
																				 '8888888','8888888888','9999999','9999999999']
								,ut.CleanPhone(s) ,'');
		END;
		
END;




