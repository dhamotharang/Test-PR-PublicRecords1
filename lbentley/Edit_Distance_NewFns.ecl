EXPORT Edit_Distance_NewFns :=
module

	export fRemove1Character(string pString,const unsigned1 pindex) :=
	function
		lindex := dataset([{pindex}],{unsigned1 aindex})[1].aindex;	// to prevent the random from recalcing each time it is referenced
//		lindex := pindex;	
		mylength := length(pString);
		return trim(map( 
				 lindex  = 1				=> pString[2..]
				,lindex >= mylength	=> pString[1..(mylength - 1)]
				,											 pString[1..(lindex - 1)] + pString[(lindex + 1)..]
		));
	end;

	export fGeneric(string name,unsigned1 pnRemoveChars) :=
	function
		lname 					:= trim(name,left,right);
		mylength				:= length(lname);
		lrandomnumber		:= random();
		lrandomnumber1 	:= random();
		lrandomnumber2 	:= random();
		lrandomnumber3 	:= random();
		lrandomnumber4 	:= random();
		lrandomnumber5 	:= random();
		percentage1			:= (real8)lrandomnumber1/4294967296.0; // divide it by 2^32(the max random number)
		percentage2			:= (real8)lrandomnumber2/4294967296.0; // divide it by 2^32(the max random number)
		percentage3			:= (real8)lrandomnumber3/4294967296.0; // divide it by 2^32(the max random number)
		percentage4			:= (real8)lrandomnumber4/4294967296.0; // divide it by 2^32(the max random number)
		percentage5			:= (real8)lrandomnumber5/4294967296.0; // divide it by 2^32(the max random number)
		charindex1 			:= (unsigned1)(percentage1 * mylength) + 1;
//		charindex2 			:= (unsigned1)(percentage2 * (mylength - 1)) + 1;
//		charindex3 			:= (unsigned1)(percentage3 * (mylength - 2)) + 1;
//		charindex4 			:= (unsigned1)(percentage4 * (mylength - 3)) + 1;
		
		removefirstcharacter 	:= fRemove1Character(lname								,charindex1);
		charindex2 			:= (unsigned1)(percentage2 * (length(removefirstcharacter	) - 1)) + 1;
		removesecondcharacter := fRemove1Character(removefirstcharacter	,charindex2);
		charindex3 			:= (unsigned1)(percentage3 * (length(removesecondcharacter) - 2)) + 1;
		removethirdcharacter 	:= fRemove1Character(removesecondcharacter,charindex3);
		charindex4 			:= (unsigned1)(percentage4 * (length(removethirdcharacter	) - 3)) + 1;
		removefourthcharacter := fRemove1Character(removethirdcharacter	,charindex4);
		charindex5 			:= (unsigned1)(percentage5 * (length(removefourthcharacter	) - 3)) + 1;
		removefifthcharacter 	:= fRemove1Character(removefourthcharacter	,charindex5);
		
		returnstring	:= map(pnRemoveChars  = 5 and mylength >= 6 => removefifthcharacter
												,pnRemoveChars >= 4 and mylength >= 5 => removefourthcharacter
												,pnRemoveChars >= 3 and mylength >= 4 => removethirdcharacter
												,pnRemoveChars >= 2 and mylength >= 3 => removesecondcharacter
												,pnRemoveChars >= 1 and mylength >= 2 => removefirstcharacter
												,																					lname
										);
		
		return returnstring;
	end;

	export fEdit1(string name) := fGeneric(name,1);
	export fEdit2(string name) := fGeneric(name,2);
	export fEdit3(string name) := fGeneric(name,3);
	export fEdit4(string name) := fGeneric(name,4);
	export fEdit5(string name) := fGeneric(name,5);
	
	
	///////////////////////////////////////////////////////////
export STRING3 FuzzyLength(qstring120 str) :=
      FUNCTION
            // Length of 1-5  = 'short'
            // Length of 6-10 = 'medium'
            // Length of 11+  = 'long'
            
            len_str := LENGTH(TRIM(str,LEFT,RIGHT));
            lbound  := len_str - 2;
            ubound  := len_str + 2;
            
            short_length  := IF( lbound <= 5 OR ubound <= 5, '1', '0' );
            medium_length := IF( (lbound > 5 AND lbound <= 10) OR (ubound > 5 AND ubound <= 10), '1', '0' );
            long_length   := IF( lbound > 10 OR ubound > 10, '1', '0' );
            
            RETURN short_length + medium_length + long_length;
      END;

export F1(qstring120 s) := 
   IF( length(trim(s))>=13
       , s[1..5]+s[7..12]+'#'+s[14..]
       , s[1..5] + s[7..]
     );
export F2(qstring120 s) := s[1..6] + s[8..]; // Leave out positions 7
export F3(qstring120 s) := s[1..7] + s[9..]; // Leave out position 8

export F4(qstring120 s) := // Omitting 1 and 3.
   IF( length(trim(s))>=13
       , s[2]+s[4..12] +'#' + s[14..]
       , s[2]+s[4..]
     );

export F5(qstring120 s) :=  // Leave out positions 1 & 4
    IF(length(trim(s))>=2
       , '#' + s[3] + s[5..]
       , s[2..3] + s[5..]
      );


export F6(qstring120 s) :=  // Leave out positions 3 & 4
    IF(length(trim(s))=2, ''
       ,IF(length(trim(s))=3, s[1]+s[4..]
           ,IF((length(trim(s))=10), s[1..7]
               ,IF((length(trim(s))=11), s[1..7]+s[9]
                   ,IF( (length(trim(s))=12), s[1..9]
                        ,IF((length(trim(s))=15), s[1..7]+s[9..13]
                            ,IF((length(trim(s))=16), s[1..13]
                                ,IF( (length(trim(s))=20), s[1..17]
                                    ,IF(length(trim(s))=19, s[1..5]+'#'+s[7..9]+'##' + s[12..]
                                        ,IF(length(trim(s))>=17, s[1..4]+'#'+s[6..8]+s[11..]
                                            ,IF(length(trim(s))>=5 
                                                , s[1..2] + '#'+ s[6..]
                                                , FuzzyLength(s)+s[1..2] + s[5..]
                                              )
                                           )
                                       )
                                   )
                               )
                           )
                      )
                  )
              )
          )
      );
////////
// tony's stuff
export Ft1(STRING30 pString)	:=	pString[2..];
export Ft2(STRING30 pString)	:=	pString[1] + pString[3..];
export Ft3(STRING30 pString)	:=	
FUNCTION
	STRING30	lString		:=	REGEXREPLACE('([A-Z])[^A-Z0-9]+([A-Z])', pString, '\\1\\2');
	RETURN		lString[1..(LENGTH(TRIM(lString)) DIV 2)] + lString[((LENGTH(TRIM(lString)) DIV 2) + 2)..];
END;	 
export Ft4(STRING30 pString)	:=	pString[1..2] + '_' + pString[4..(LENGTH(TRIM(pString)) - 4)] + '__' + pString[LENGTH(TRIM(pString))-1..LENGTH(TRIM(pString))];
export Ft5(STRING30 pString)	:=	'_' + pString[2..((LENGTH(TRIM(pString)) DIV 2) - 1)] + '_' + pString[((LENGTH(TRIM(pString)) DIV 2) + 1)..(LENGTH(TRIM(pString)) - (LENGTH(TRIM(pString)) % 2))];
export Ft6(STRING30 pString)	:=	pString[1..3] + '_' + pString[5..(LENGTH(TRIM(pString)) - 2)] + '__';
export Ft7(STRING30 pString)	:=	pString[1..(length(pstring)-1)];
export Ft8(STRING30 pString)	:=	pString[1..(length(pstring)-2)];
export Ft9(STRING30 pString)	:=	pString[3..];


end;