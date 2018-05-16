﻿IMPORT ut, Scrubs;

EXPORT Functions := MODULE

  EXPORT fn_check_dl_number(STRING dlnum) := FUNCTION
    dlnum_clean 	:= ut.CleanSpacesAndUpper(dlnum);
		isValidNumber := IF(Stringlib.StringFilterOut(dlnum_clean, '0123456789') = '', TRUE, FALSE);    
    RETURN IF(dlnum_clean = '' OR isValidNumber, 1, 0);
  END;

	//****************************************************************************
	// fn_valid_lname: returns true only for names with alpha characters AND 
	// some names can have few allowed [-'., space] special characters !!
	// returns false for blank names Or only* allowed special [-'.,] characters in names,nothing else!
	//****************************************************************************
	EXPORT fn_valid_lname(STRING l) := FUNCTION 

		PatternValidChar		:= '[A-Z]|\\x2D|\\x27|\\x2E|\\x2C|\\x20';//alpha or with [-'.,space] these characters allowed
		name								:= ut.CleanSpacesAndUpper(l);	
		RETURN IF(regexreplace(PatternValidChar, name, '')!='' or regexreplace('\\x2D|\\x27|\\x2E|\\x2C', name, '')='', 0, 1);

	END;

	//****************************************************************************
	//fn_valid_past_date:  returns true or false based upon whether or not there
	//                     is a valid past date.
	//****************************************************************************
	EXPORT fn_valid_past_date(string ppdate) := function                
		RETURN Scrubs.fn_valid_pastDate(ppdate);
	END;
	
	EXPORT fn_action_code(STRING code) := FUNCTION
	  a_code 						 := ut.CleanSpacesAndUpper(code);
		isValid_ActionCode := CASE( a_code,
																'006'  => TRUE, 
																'016'  => TRUE, 
																'029'  => TRUE, 
																'035'  => TRUE, 
																'055'  => TRUE, 
																'057'  => TRUE, 
																'101'  => TRUE, 
																'103'  => TRUE, 
																'127'  => TRUE, 
																'128'  => TRUE, 
																'134'  => TRUE,  
																'139'  => TRUE, 
																'140'  => TRUE, 
																'143'  => TRUE, 
																'148'  => TRUE, 
																'152'  => TRUE, 
																'157'  => TRUE, 
																'159'  => TRUE, 
																'161'  => TRUE, 
																'163'  => TRUE, 
																'179'  => TRUE, 
																'376'  => TRUE, 
																'424'  => TRUE, 
																'534'  => TRUE, 
																'743'  => TRUE, 
																'999'  => TRUE, 
																'A04'  => TRUE, 
																'A08'  => TRUE, 
																'A10'  => TRUE, 
																'A11'  => TRUE, 
																'A12'  => TRUE, 
																'A20'  => TRUE, 
																'A21'  => TRUE, 
																'A22'  => TRUE, 
																'A23'  => TRUE, 
																'A24'  => TRUE, 
																'A25'  => TRUE, 
																'A26'  => TRUE, 
																'A31'  => TRUE, 
																'A33'  => TRUE, 
																'A35'  => TRUE, 
																'A41'  => TRUE, 
																'A50'  => TRUE, 
																'A60'  => TRUE, 
																'A61'  => TRUE, 
																'A90'  => TRUE, 
																'A91'  => TRUE, 
																'A94'  => TRUE, 
																'A98'  => TRUE, 
																'B01'  => TRUE, 
																'B02'  => TRUE, 
																'B03'  => TRUE, 
																'B04'  => TRUE, 
																'B05'  => TRUE, 
																'B06'  => TRUE, 
																'B07'  => TRUE, 
																'B08'  => TRUE, 
																'B14'  => TRUE, 
																'B19'  => TRUE, 
																'B20'  => TRUE, 
																'B21'  => TRUE, 
																'B22'  => TRUE, 
																'B23'  => TRUE, 
																'B24'  => TRUE, 
																'B25'  => TRUE, 
																'B26'  => TRUE, 
																'B27'  => TRUE, 
																'B41'  => TRUE, 
																'B51'  => TRUE, 
																'B56'  => TRUE, 
																'B57'  => TRUE, 
																'B61'  => TRUE, 
																'B63'  => TRUE, 
																'B64'  => TRUE, 
																'B65'  => TRUE, 
																'B74'  => TRUE, 
																'B78'  => TRUE, 
																'B91'  => TRUE, 
																'D02'  => TRUE, 
																'D06'  => TRUE, 
																'D07'  => TRUE, 
																'D10'  => TRUE, 
																'D16'  => TRUE, 
																'D27'  => TRUE, 
																'D29'  => TRUE, 
																'D30'  => TRUE, 
																'D31'  => TRUE, 
																'D35'  => TRUE, 
																'D36'  => TRUE, 
																'D37'  => TRUE, 
																'D38'  => TRUE, 
																'D39'  => TRUE, 
																'D45'  => TRUE, 
																'D51'  => TRUE, 
																'D53'  => TRUE, 
																'D56'  => TRUE, 
																'D70'  => TRUE, 
																'D72'  => TRUE, 
																'D74'  => TRUE, 
																'D75'  => TRUE, 
																'D78'  => TRUE, 
																'E01'  => TRUE, 
																'E02'  => TRUE, 
																'E03'  => TRUE, 
																'E04'  => TRUE, 
																'E05'  => TRUE, 
																'E06'  => TRUE, 
																'E23'  => TRUE, 
																'E31'  => TRUE, 
																'E33'  => TRUE, 
																'E34'  => TRUE, 
																'E36'  => TRUE, 
																'E37'  => TRUE, 
																'E50'  => TRUE, 
																'E51'  => TRUE, 
																'E53'  => TRUE, 
																'E54'  => TRUE, 
																'E55'  => TRUE, 
																'E56'  => TRUE, 
																'E57'  => TRUE, 
																'E70'  => TRUE, 
																'E71'  => TRUE, 
																'F02'  => TRUE, 
																'F03'  => TRUE, 
																'F04'  => TRUE, 
																'F05'  => TRUE, 
																'F06'  => TRUE, 
																'F34'  => TRUE, 
																'F66'  => TRUE, 
																'M02'  => TRUE, 
																'M03'  => TRUE, 
																'M04'  => TRUE, 
																'M05'  => TRUE, 
																'M08'  => TRUE, 
																'M09'  => TRUE, 
																'M10'  => TRUE, 
																'M11'  => TRUE, 
																'M12'  => TRUE, 
																'M13'  => TRUE, 
																'M14'  => TRUE, 
																'M15'  => TRUE, 
																'M16'  => TRUE, 
																'M17'  => TRUE, 
																'M18'  => TRUE, 
																'M19'  => TRUE, 
																'M20'  => TRUE, 
																'M21'  => TRUE, 
																'M22'  => TRUE, 
																'M23'  => TRUE, 
																'M24'  => TRUE, 
																'M25'  => TRUE, 
																'M30'  => TRUE, 
																'M31'  => TRUE, 
																'M32'  => TRUE, 
																'M33'  => TRUE, 
																'M34'  => TRUE, 
																'M40'  => TRUE, 
																'M41'  => TRUE, 
																'M42'  => TRUE, 
																'M43'  => TRUE, 
																'M44'  => TRUE, 
																'M45'  => TRUE, 
																'M46'  => TRUE, 
																'M47'  => TRUE, 
																'M48'  => TRUE, 
																'M49'  => TRUE, 
																'M50'  => TRUE, 
																'M51'  => TRUE, 
																'M55'  => TRUE, 
																'M56'  => TRUE, 
																'M57'  => TRUE, 
																'M58'  => TRUE, 
																'M60'  => TRUE, 
																'M61'  => TRUE, 
																'M62'  => TRUE, 
																'M70'  => TRUE, 
																'M71'  => TRUE, 
																'M72'  => TRUE, 
																'M73'  => TRUE, 
																'M74'  => TRUE, 
																'M75'  => TRUE, 
																'M76'  => TRUE, 
																'M77'  => TRUE, 
																'M80'  => TRUE, 
																'M81'  => TRUE, 
																'M82'  => TRUE, 
																'M83'  => TRUE, 
																'M84'  => TRUE, 
																'M85'  => TRUE, 
																'M86'  => TRUE, 
																'N01'  => TRUE, 
																'N02'  => TRUE, 
																'N03'  => TRUE, 
																'N04'  => TRUE, 
																'N05'  => TRUE, 
																'N06'  => TRUE, 
																'N07'  => TRUE, 
																'N08'  => TRUE, 
																'N09'  => TRUE, 
																'N20'  => TRUE, 
																'N21'  => TRUE, 
																'N22'  => TRUE, 
																'N23'  => TRUE, 
																'N24'  => TRUE, 
																'N25'  => TRUE, 
																'N26'  => TRUE, 
																'N30'  => TRUE, 
																'N31'  => TRUE, 
																'N40'  => TRUE, 
																'N41'  => TRUE, 
																'N42'  => TRUE, 
																'N43'  => TRUE, 
																'N44'  => TRUE, 
																'N50'  => TRUE, 
																'N51'  => TRUE, 
																'N52'  => TRUE, 
																'N53'  => TRUE, 
																'N54'  => TRUE, 
																'N55'  => TRUE, 
																'N56'  => TRUE, 
																'N60'  => TRUE, 
																'N61'  => TRUE, 
																'N62'  => TRUE, 
																'N63'  => TRUE, 
																'N70'  => TRUE, 
																'N71'  => TRUE, 
																'N72'  => TRUE, 
																'N80'  => TRUE, 
																'N82'  => TRUE, 
																'N83'  => TRUE, 
																'N84'  => TRUE, 
																'S01'  => TRUE, 
																'S06'  => TRUE, 
																'S14'  => TRUE, 
																'S15'  => TRUE, 
																'S16'  => TRUE, 
																'S21'  => TRUE, 
																'S26'  => TRUE, 
																'S31'  => TRUE, 
																'S36'  => TRUE, 
																'S41'  => TRUE, 
																'S51'  => TRUE, 
																'S71'  => TRUE, 
																'S81'  => TRUE, 
																'S91'  => TRUE, 
																'S92'  => TRUE, 
																'S93'  => TRUE, 
																'S94'  => TRUE, 
																'S95'  => TRUE, 
																'S96'  => TRUE, 
																'S97'  => TRUE, 
																'S98'  => TRUE, 
																'U01'  => TRUE, 
																'U02'  => TRUE, 
																'U03'  => TRUE, 
																'U04'  => TRUE, 
																'U05'  => TRUE, 
																'U06'  => TRUE, 
																'U07'  => TRUE, 
																'U08'  => TRUE, 
																'U09'  => TRUE, 
																'U10'  => TRUE, 
																'U21'  => TRUE, 
																'U27'  => TRUE, 
																'U28'  => TRUE, 
																'U31'  => TRUE, 
																'W09'  => TRUE, 
																'W13'  => TRUE, 
																'W14'  => TRUE, 
																'W15'  => TRUE, 
																'W20'  => TRUE, 
																'W70'  => TRUE, 
																''   	 => TRUE,
															  FALSE);
	RETURN IF(isValid_ActionCode,1,0);
	END;
	
	EXPORT fn_county_code(STRING code) := FUNCTION
	c_code 						 := trim(code,all);
	isValid_CountyCode := CASE( c_code,
															'00'  => TRUE, 
														  '01'  => TRUE,  
															'1'   => TRUE, 
															'02'  => TRUE, 
															'2'   => TRUE, 
															'03'  => TRUE,   
															'3'   => TRUE, 
															'04'  => TRUE,   
															'4'   => TRUE, 
															'05'  => TRUE,   
															'5'   => TRUE, 
															'06'  => TRUE,   
															'6'   => TRUE, 
															'07'  => TRUE,   
															'7'   => TRUE, 
															'08'  => TRUE,   
															'8'   => TRUE, 
															'09'  => TRUE,  
															'9'   => TRUE,   
															'10'  => TRUE,  
															'11'  => TRUE,  
															'12'  => TRUE,  
															'13'  => TRUE,  
															'14'  => TRUE,  
															'15'  => TRUE,  
															'16'  => TRUE,  
															'17'  => TRUE,  
															'18'  => TRUE,  
															'19'  => TRUE,  
															'20'  => TRUE,  
															'21'  => TRUE,  
															'22'  => TRUE,  
															'23'  => TRUE,  
															'24'  => TRUE,  
															'25'  => TRUE,  
															'26'  => TRUE,  
															'27'  => TRUE,  
															'28'  => TRUE,  
															'29'  => TRUE,  
															'30'  => TRUE,  
															'31'  => TRUE,  
															'32'  => TRUE,  
															'33'  => TRUE,  
															'34'  => TRUE,  
															'35'  => TRUE,  
															'36'  => TRUE,  
															'37'  => TRUE,  
															'38'  => TRUE,  
															'39'  => TRUE,  
															'40'  => TRUE,  
															'41'  => TRUE,  
															'42'  => TRUE,  
															'43'  => TRUE,  
															'44'  => TRUE,  
															'45'  => TRUE,  
															'46'  => TRUE,  
															'47'  => TRUE,  
															'48'  => TRUE,  
															'49'  => TRUE,  
															'50'  => TRUE,  
															'51'  => TRUE,  
															'52'  => TRUE,  
															'53'  => TRUE,  
															'54'  => TRUE,  
															'55'  => TRUE,  
															'56'  => TRUE,  
															'57'  => TRUE,  
															'58'  => TRUE,  
															'59'  => TRUE,  
															'60'  => TRUE,  
															'61'  => TRUE,  
															'62'  => TRUE,  
															'63'  => TRUE,  
															'64'  => TRUE,  
															'65'  => TRUE,  
															'66'  => TRUE,  
															'67'  => TRUE,  
															'68'  => TRUE,  
															'69'  => TRUE,  
															'70'  => TRUE,  
															'71'  => TRUE,  
															'72'  => TRUE,  
															'73'  => TRUE,  
															'74'  => TRUE,  
															'75'  => TRUE,  
															'76'  => TRUE,  
															'77'  => TRUE,  
															'78'  => TRUE,  
															'79'  => TRUE,  
															'80'  => TRUE,  
															'81'  => TRUE,  
															'82'  => TRUE,  
															'83'  => TRUE,  
															'84'  => TRUE,  
															'85'  => TRUE,  
															'86'  => TRUE,  
															'87'  => TRUE,  
															'88'  => TRUE,  
															'89'  => TRUE,  
															'90'  => TRUE,  
															'91'  => TRUE,  
															'92'  => TRUE,  
															'93'  => TRUE,  
															'94'  => TRUE,  
															'95'  => TRUE,
															''    => TRUE,
															FALSE);
	RETURN IF(isValid_CountyCode,1,0);
	END;

END; 