/*2014-03-26T01:36:57Z (speriasamy)
C:\Users\periassx\AppData\Roaming\HPCC Systems\eclide\speriasamy\Alpharetta_DEV\HealthCareFacility\FacilityNameCleaner_Config\2014-03-26T01_36_57Z.ecl
*/
/********************************************************************************************************** 
	Name: 			BusinessNameCleaner_Config
	Created On: 06/10/2013
	By: 				ssivasubramanian
	Desc: 			BusinessNameCleaner uses the configuration set in this file. 	
***********************************************************************************************************/

EXPORT FacilityNameCleaner_Config := MODULE
	
	// This should be set to false by default. Setting this flag to true will give the clean up done by each function 
	// at the info section of the work unit. Use it only for debugging!!!
	EXPORT bDEBUG																		:= FALSE;

	// If after cleaning the string comes back as empty, do you want return the empty string or the input string?		
	EXPORT bIsOkayToReturnEmptyString								:= TRUE;
	
  // The first character is the starting and the second ending. If you give just one char, it is taken as starting and ending.	
	EXPORT lWrappingCharSet 												:= ['"','\'','()'];
	
	// This will go ahead and remove the starting or the ending wrapping quotes if the other end does not have it (error in data)
	EXPORT bRemoveUnpairedWrappingQuotes						:= TRUE;
	
	EXPORT bCleanForAcceptableSetOfChars 						:= TRUE;
	EXPORT sAcceptableSetOfChars 										:= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789. -\'@#$%&*()+="\\/';
		
	EXPORT bRemoveNoiseWords												:= TRUE; // Will be replaced with space. Dumb find and replace. Regex won't work or not cost effective
	
	// Give every possible combinations. It's a find and replace.
	EXPORT lNoiseWordsSet 													:= ['.is ','\'s.',			'.but ','.or ','.An ','.The ','.&/OR ','.AND/OR ','.&\\OR ','.AND\\OR ','.OF ',
																											'.is.',				      '.but.','.or.','.An.','.The.','.&/OR.','.AND/OR.','.&\\OR.','.AND\\OR.','.OF.',
																											' is.',						  ' but.',' or.',' An.',' The.',' &/OR.',' AND/OR.',' &\\OR.',' AND\\OR.','OF.',
																											' is ',	'DR.',' DR ',' but ',' or ',' An ',' The ',' &/OR ',' AND/OR ',' &\\OR ',' AND\\OR ',
																											// ' is ','\'s ',			' but ',' or ',' An ',' The ',' &/OR ',' AND/OR ',' &\\OR ',' AND\\OR ',' OF ',																											
																											'DBA ','D/B/A ','(DBA)','( DBA )','D.B.A ','D B A ','(D B A)','C\\O ','C/O ','C O ','C.O ',
																											'.DBA ','.D/B/A ','.D.B.A ','.D B A ','.C\\O ','.C/O ','.C O ','.C.O ',
																											' DBA.',' D/B/A.',' D.B.A.',' D B A.',' C\\O.',' C/O.',' C O.',' C.O.',
																											'.DBA.','.D/B/A.','.D.B.A.','.D B A.','.C\\O.','.C/O.','.C O.','.C.O.',
																											'D.D.S ','M.D. ','MD ',' MS ','DR\'S','DR.\'S','P.C.','PA ', 'DMD ', ' PC ', 'FACS ', ' OD ', 'DDS ', 'M.S.',' D D S ',
																											'D.O. ',' P.A. ',' (MD) ', ' (MS) ', ' DC ',' M.S.D ', ' LCSW ', ' P.S.C ', ' APMC ', ' PH.D ', ' ATR-BC ', ' D.D.S ',
																											'P.S.C ', ' (DO) ', ' (PA-C) ', 'M.D ', ' T/A ', ' O.D. ', '(APRN,FNP-BC)', 'ATT:', 'D.P.M ', 'MD. ', 'M>D> ', 'M.M.M ',
																											' MRS ', ' PHD '
																											]; 

	// If the flag is set to true and last character is not on the list, it will be removed. Uses REGEX. Please make sure the acceptable set is REGEX friendly
	EXPORT bValidateLastChar						 						:= TRUE;
	EXPORT sAcceptableSetOfLastChars								:= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 #$+"\')';
	EXPORT bRemoveInvalidLastCharRecursively				:= TRUE;
	
	// Will not truncate if it starts with this term. It will just remove the term. It's not a regex word replace.. Its an exact replace. So the list has prepended and appended spaces
	EXPORT bTruncateAfterTerm 											:= TRUE; 	
	EXPORT lTruncateAfterTerms											:= [];
	
	// If the flag is set to true and first character is not on the list, it will be removed. Uses REGEX. Please make sure the acceptable set is REGEX friendly
	EXPORT bValidateFirstChar												:= TRUE;
	EXPORT sAcceptableSetOfFirstChars								:= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 #$+"\'(';
	EXPORT bRemoveInvalidFirstCharRecursively 			:= TRUE;
		
	// Will not truncate if it ends with this term. It will just remove the term.
	EXPORT bTruncateBeforeTerm 											:= FALSE; 	
	EXPORT lTruncateBeforeTerms											:= [];

	// Update the flag and the list if you want to remove any special characters after all the above processing is done. 
	// This will usually not be necessary except for fine tuning. 
	EXPORT bRemoveSpecialCharPostProcessing 				:= FALSE;
	EXPORT sRemoveSpecialCharPostProcessing 				:= '"\'-/!\\@#%&*()+=';
	
	// This will replace the special character with space
	EXPORT bReplaceSpecialCharWithSpacePostProcessing := TRUE;
	EXPORT sReplaceSpecialCharPostProcessing				:= '.\"';
	
END;
	
	
	