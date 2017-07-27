export fCleanDoubleQuotes(STRING pTextString) := FUNCTION

STRING CleanBeginning (STRING pStr) :=
       MAP( //A special case such as "A+" Consulting
			      //or "SAY CHEESE !" PHOTOGRAPHY STUDIO, LLC                                                              
			      //needs to stay the same
			      regexfind('^["][^"]*["] [^"]*',pStr) => pStr,
						//A special case such as Michael "Mike" Lando
						regexfind(' ["][^" ]*["] ',pStr)  =>
						regexreplace('^["]',pStr,'',NOCASE),
				    //A general case such as "Michael
						regexfind ('^["][^"]*',pStr) =>
						regexreplace('"',pStr,'',NOCASE),
						regexreplace('"',pStr,'',NOCASE)
 			      );
			 

IntermResult1 := IF (//A special case such as 
                     //120	GRANDE NATURALS "L.L.C."                                                                                                                                                                                                                                                                                                                                      
                     regexfind(' ["][^"]*["]$',pTextString),
                     pTextString, 
                     regexreplace('["]$',pTextString,'',NOCASE));
CleanResult := IF(regexfind('^["]',IntermResult1),
                    CleanBeginning (IntermResult1),
										IntermResult1);


RETURN CleanResult;
END;
