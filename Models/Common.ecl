import ut, risk_indicators,Std, riskview;

export Common := MODULE
	EXPORT NULL := -999999999;
	
	export boolean contains( string haystack, string needle ) := (StringLib.StringFind(haystack, needle, 1) > 0);
	
	export readDate( string indate1 ) := FUNCTION
		indate     := trim(indate1,all);
		
		yr := indate[1..4];
		mo := intformat( min(12,max(1,(integer1)indate[5..6])), 2, 1 );
		dy := intformat( min( max(1,(integer1)indate[7..8]), ut.Month_Days( (unsigned)yr*100+(unsigned)mo ) ), 2, 1 );
		
		string8 ret := map(
			length(indate)=8 and indate[1..2] in ['19','20'] => yr+mo+dy,
			length(indate)=6 and indate[1..2] in ['19','20'] => yr+mo+'01',
			length(indate)=4 and indate[1..2] in ['19','20'] => yr+'0101',
			''
		);
		return ret;
	END;

	export readDate1800s( string indate1 ) := FUNCTION
		indate     := trim(indate1,all);
		
		yr := indate[1..4];
		mo := intformat( min(12,max(1,(integer1)indate[5..6])), 2, 1 );
		dy := intformat( min( max(1,(integer1)indate[7..8]), ut.Month_Days( (unsigned)yr*100+(unsigned)mo ) ), 2, 1 );
		
		string8 ret := map(
			length(indate)=8 and indate[1..2] in ['18','19','20'] => yr+mo+dy,
			length(indate)=6 and indate[1..2] in ['18','19','20'] => yr+mo+'01',
			length(indate)=4 and indate[1..2] in ['18','19','20'] => yr+'0101',
			''
		);
		return ret;
	END;
	
		export integer4 sas_date1800s( string indate ) := FUNCTION
		/* indate not assumed to be valid. run it through readDate first */
		cleaned := readDate1800s( indate );
		ret := if( cleaned in ['','0'],
			NULL,
			ut.DaysSince1900( cleaned[1..4], cleaned[5..6], cleaned[7..8] ) - ut.DaysSince1900( '1960', '01', '01')
		);
		return ret;
	END;

	export integer4 sas_date( string indate ) := FUNCTION
		/* indate not assumed to be valid. run it through readDate first */
		cleaned := readDate( indate );
		ret := if( cleaned in ['','0'],
			NULL,
			ut.DaysSince1900( cleaned[1..4], cleaned[5..6], cleaned[7..8] ) - ut.DaysSince1900( '1960', '01', '01')
		);
		return ret;
	END;
	
	/** Takes a SAS date and returns it in YYYYMMDD format **/
	/* indate should be a valid SAS date at this point - Anything before 19020101 can't be reliably calculated, return blank */
	EXPORT STRING8 sas2ecl_date(INTEGER4 indate) := IF(indate < -21549, '', ut.DateFrom_DaysSince1900(indate + ut.DaysSince1900('1960', '01', '01')));
		
	// example: round (0.108654192, .000001) returns 0.108654
	export real round( real val, real precision=1 ) := round(val/precision)*precision;
	
	
	/*
	return_type is one of:
		pos -- return the position of needle in haystack according to StringLib.StringFind
		bool -- true/false, indicating found/not found
		int  -- 1/0, indicating found/not found
		
	This macro is as close to the real SAS findw as possible. See the official documentation here:
		http://support.sas.com/documentation/cdl/en/lrdict/62618/HTML/default/a002978282.htm
	*/
	export findw( haystack, needle, delimiters, modifier, result, return_type = '\'pos\'' ) := MACRO
		#uniquename(uc_modifier)
		%uc_modifier% := StringLib.StringToUpperCase(modifier);
		
		#uniquename(m_ignorecase)
		%m_ignorecase% := StringLib.StringFind( %uc_modifier%, 'I', 1 ) > 0;
		#uniquename(right_to_left)
		%right_to_left% := StringLib.StringFind( %uc_modifier%, 'B', 1 ) > 0;


		#uniquename(srch_delimiters)
		%srch_delimiters% := delimiters
			+ if( StringLib.StringFind( %uc_modifier%, 'D', 1 ) > 0, '0123456789', '' )
			+ if( StringLib.StringFind( %uc_modifier%, 'A', 1 ) > 0, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', '' )
			+ if( StringLib.StringFind( %uc_modifier%, 'H', 1 ) > 0, '\t', '' )
			+ if( StringLib.StringFind( %uc_modifier%, 'W', 1 ) > 0, '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~', '' ) // not sure if this list is correct
			+ if( StringLib.StringFind( %uc_modifier%, 'X', 1 ) > 0, '0123456789abcdefABCDEF', '' )
			+ if( StringLib.StringFind( %uc_modifier%, 'S', 1 ) > 0, ' \t\n\v\f\r', '' )
		;
		
		#uniquename(srch_haystack)
		%srch_haystack% := if(%m_ignorecase%, StringLib.StringToLowerCase(haystack), haystack);
		#uniquename(srch_needle)
		%srch_needle% := if(%m_ignorecase%, StringLib.StringToLowerCase(needle), needle);
		
		#declare(i)
		#set(i,1)
		
		#if(return_type = 'int')
			result := (integer)(%srch_needle%=%srch_haystack%
		#elseif(return_type = 'bool')
			result := (%srch_needle%=%srch_haystack%
		#else
			#uniquename(nan)
			%nan% := if( %right_to_left%, -999999999, 999999999 );
			
			#uniquename(locs)
			%locs% := [ if(%srch_needle%=%srch_haystack%, 1, %nan% )
		#end
		
		
		#declare(delim_pre)
		#declare(delim_post)
		#loop
			#if(%i% > length(%srch_delimiters%)*length(%srch_delimiters%))
				#break
			#else
				#set(delim_pre,  %srch_delimiters%[ 1 + (%i% % length(%srch_delimiters%)) ])
				#set(delim_post, %srch_delimiters%[ (integer)(1 + %i% / length(%srch_delimiters%)) ])
				
				#if(return_type = 'pos')
					, map(
						StringLib.StringFind(%srch_haystack%, %srch_needle% + %'delim_pre'%, 1)=1 => 1, // string starts with needle and is followed by this delimiter
						StringLib.StringFind(%srch_haystack%, %'delim_pre'% + %srch_needle% + %'delim_post'%, 1) > 0 =>
							StringLib.StringFind(%srch_haystack%, %'delim_pre'% + %srch_needle% + %'delim_post'%, 1) + length(%'delim_pre'%), // string contains this string with a delimiter on either side
						%srch_haystack%[ length(%srch_haystack%)-length(%'delim_pre'% + %srch_needle%) + 1 .. ] = %'delim_pre'% + %srch_needle% => length(%srch_haystack%)-length(%'delim_pre'% + %srch_needle%) + 1, // string ends with a delimiter followed by the needle
						%nan%
					)
				#else
					#if( %i% <= length(%srch_delimiters%) )
/* 						or StringLib.StringFind(%srch_haystack%, %srch_needle% + %srch_delimiters%[%i%], 1)>0 */
						or %srch_haystack%[ length(%srch_haystack%)-length(%'delim_pre'% + %srch_needle%) + 1 .. ] = %'delim_pre'% + %srch_needle% // string ends with a delimiter followed by the needle

						// since we're iterating from 1 to n^2 (where n is the number of possible delimeters), there's no need to use this line more than n times
						or StringLib.StringFind(%srch_haystack%, %srch_needle% + %srch_delimiters%[%i%], 1)=1 // string starts with needle and is followed by this delimiter
					#end
					or StringLib.StringFind(%srch_haystack%, %'delim_pre'% + %srch_needle% + %'delim_post'%, 1)>0
				#end
				
				#set(i,%i%+1)
			#end
		#end


		#if( return_type = 'pos' )
			];
			#if(%right_to_left%)
				result := if(%nan%=max(%locs%), 0, max(%locs%));
			#else
				result := if(%nan%=min(%locs%), 0, min(%locs%));
			#end
		#else
			);
		#end
		
	ENDMACRO;

	export integer4 countw( string input, string delimiters=' !$%&()*+,-./;<^|', string modifiers = '' ) := FUNCTION 
    
    Replacedelim := STD.str.SubstituteIncluded(input, delimiters,' ');    
    RETURN Std.Str.CountWords(Replacedelim , ' ');     
    END; 
	
export integer4 findw_cpp( string haystack, string needle, varstring delimiters=' ,', varstring modifiers='' ) := BEGINC++
#include <stdio.h>
#body
        if (lenNeedle > lenHaystack || (lenNeedle == 0))
            return 0;
            
		bool caseInsensitive = strchr( modifiers, 'i' ) != NULL || strchr( modifiers, 'I' ) != NULL;
		bool wordWise = strchr( modifiers, 'e' ) != NULL || strchr( modifiers, 'E' ) != NULL; // return the 'word' position of needle rather than the character position?
		
		char * haystack_case = (char*)haystack;
		char * needle_case = (char*)needle;
		if( caseInsensitive )
		{
			haystack_case = (char*)rtlMalloc( lenHaystack );
			for( unsigned i = 0; i < lenHaystack; i++ )
				haystack_case[i] = haystack[i] >= 'A' && haystack[i] <= 'Z' ? haystack[i] + 32 : haystack[i];
				
			needle_case = (char*)rtlMalloc( lenNeedle );
			for( unsigned i = 0; i < lenNeedle; i++ )
				needle_case[i] = needle[i] >= 'A' && needle[i] <= 'Z' ? needle[i] + 32 : needle[i];
		}
		
		unsigned searchMax = (lenHaystack - lenNeedle);
		unsigned pos;
		bool gotonextpos = false;
        for (pos=0; pos <= searchMax; pos++)
        {
						gotonextpos = false;
            //Use a loop instead of memcmp because it is likely to be more efficient (since matches
            for (unsigned i=0; i < lenNeedle; i++)
            {
                if (haystack_case[pos+i] != needle_case[i])
                    gotonextpos = true;
            }
					if(gotonextpos == false)
					{
						// found needle_case; is it surrounded by word boundaries?
						bool prevBoundary = (pos==0) // needle_case at the start of haystack_case
							|| ( NULL != strchr(delimiters, haystack_case[pos-1]) ) // the previous character is a delimiter
						;

						// next is a boundary if it's at the end of haystack_case or if the next is a delimiter
						bool nextBoundary = (pos == searchMax) // needle_case is at the end of haystack_case
							|| ( NULL != strchr(delimiters, haystack_case[pos+lenNeedle]) ) // the next character is a delimiter
						;
			
						if( prevBoundary && nextBoundary )
								break;
					}
		}

		int ret = 0;
		if( pos <= searchMax )
		{
			if( wordWise )
			{
				// pos is the character position of needle_case in haystack_case, but we want to know the word position.
				int wordCount = 1;
				bool prevDelimiter = true;
				for( unsigned i = 0; i < pos; i++ )
				{
					bool isDelim = (NULL != strchr( delimiters, haystack_case[i] )); // is the current character a delimiter?
					
					if( !prevDelimiter && isDelim )
						wordCount++;
					
					prevDelimiter = isDelim;
				}
				
				ret = wordCount;
			}
			else
			{
				ret = pos+1;
			}
		}

		if( caseInsensitive )
		{
			rtlFree( haystack_case );
			rtlFree( needle_case );
		}
		
		return ret;
	ENDC++;

EXPORT STRING getw(STRING input, UNSIGNED1 wordnum, STRING delimiters = ', ') := FUNCTION
  ReplaceDelim := STD.str.SubstituteIncluded(input,delimiters,' ');
	RETURN Std.Str.GetNthWord(ReplaceDelim, wordNum);
END;
	export options := ENUM(Inner=0, LeftOuter=1, RightOuter=2, LeftOnly=3, RightOnly=4, FullOuter=5, FullOnly=6);

	
	// zip2 takes two strings consisting of delimited "words" (eg, "EQ,V ,TU" and "20060501,20091211,20070101")
	// and returns a dataset consisting of paired values (eg, {EQ,20060501}, {V ,20091211}, {TU,20070101})
	// this presumes (but does not require) str1 and str2 have the same number of words.
	// mismatches in the number of words within the strings can be handled by the option desired. default is
	// similar to Python's zip function (takes the minimum count), but we can take either or the min/max of the
	// two counts.
	export zip2( string str1, string str2, string delim=' ,', options opts=options.Inner ) := function
		layout := record
			string str1;
			string str2;
		end;

		blank := dataset( [{'',''}], layout );

		// figure out how many words there are
		n_str1 := countw( str1, delim );
		n_str2 := countw( str2, delim );
		wordcount := case( opts,
			options.leftouter  => n_str1,
			options.rightouter => n_str2,
			options.fullouter  => max( n_str1, n_str2 ),
			min( n_str1, n_str2 ) // options.inner
		);


		layout norm( layout le, integer1 wordnum ) := TRANSFORM
			self.str1 := getw( str1, wordnum );
			self.str2 := getw( str2, wordnum );
		end;

		return normalize( blank, wordcount, norm(left,counter) );
	END;

	export boolean isRV3Unscorable( risk_indicators.Layout_Boca_Shell le ) := FUNCTION

    unscorable := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);
		return unscorable;
	END;
	
	SHARED RC34_set (UNSIGNED num_reasons) := CHOOSEN(DATASET([{'34',risk_indicators.getHRIDesc('34')}],risk_indicators.Layout_Desc) &
											DATASET([{'00',''}],risk_indicators.Layout_Desc) &
											DATASET([{'00',''}],risk_indicators.Layout_Desc) &
											DATASET([{'00',''}],risk_indicators.Layout_Desc) &
											DATASET([{'00',''}],risk_indicators.Layout_Desc) &
											DATASET([{'00',''}],risk_indicators.Layout_Desc),
											num_reasons);

	EXPORT checkFraudPointRC34 (UNSIGNED score, DATASET(Risk_Indicators.Layout_Desc) RI, UNSIGNED num_reasons) := IF(score < 800 AND RI[1].hri in ['00', ''], RC34_set (num_reasons), RI);
	
	EXPORT checkFraudPoint3RC34 (UNSIGNED score, DATASET(Risk_Indicators.Layout_Desc) RI, UNSIGNED num_reasons) := IF(score < 925 AND RI[1].hri in ['00', ''], RC34_set (num_reasons), RI);

END;