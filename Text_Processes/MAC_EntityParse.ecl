import Text, ut, lib_word;

export MAC_EntityParse (inData, inDocNumField, inParseField,
						outRec, outParsedField, outMatchPosField, 
								outMatchLenField, outDocNumField, outData) := MACRO

#uniquename(IndiPattern)
#uniquename(front)
#uniquename(back)
#uniquename(FullName)
PATTERN %IndiPattern% := ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday',
					      'January', 'February', 'March', 'April', 'May', 'June', 
					      'July', 'August', 'September', 'October', 'November', 'December'];

PATTERN %front%		:= ANY NOT IN PATTERN('^[a-zA-Z0-9]') | FIRST;
PATTERN %back% 		:= ANY NOT IN PATTERN('^[a-zA-Z0-9]') | LAST;

PATTERN %FullName% := ((((Text.name penalty(1)) | 
					   (Text.last_name penalty(2)) | 
					   (%IndiPattern%)) LENGTH(1..150)) AFTER %FRONT%) BEFORE %BACK%;

#uniquename(Matches)
#uniquename(found)
#uniquename(matchScore)
#uniquename(properCheck)
#uniquename(tempParsed)
#uniquename(tempPos)
#uniquename(tempLen)
#uniquename(tempDocID)
%Matches% := 
	record
		STRING150 	%tempParsed%	:= MATCHTEXT(%FullName%);
		UNSIGNED  	%tempPos% 		:= MATCHPOSITION(%FullName%);
        UNSIGNED  	%tempLen%		:= MATCHLENGTH(%FullName%);
		INTEGER   	%tempDocID%		:= inData.inDocNumField;
		UNSIGNED1	%matchScore%	:= 0;
		REAL4		%properCheck%	:= 0;
	end;

%found% := PARSE(inData, inParseField, %FullName%, %Matches%, BEST, MANY, MAX);

#uniquename(remBadDocs)
%Matches% %remBadDocs%(%Matches% L) :=
TRANSFORM
	SELF := L;
END;

// TODO: Dup Docs Removal, inUrl?

// Remove Docs that will break system
#uniquename(thresh)
#uniquename(threshRecord)
#uniquename(threshTable)
#uniquename(overThresh)
#uniquename(underThresh)
%thresh% := 1.5 * COUNT(%found%) / COUNT(inData);
%threshRecord% :=
RECORD
	%found%.%tempDocID%;
	cnt := COUNT(GROUP);
END;
%threshTable% := TABLE(%found%, %threshRecord%, %tempDocID%, LOCAL);
%overThresh% := DEDUP(SORT(%threshTable%, -cnt), LEFT.cnt > RIGHT.cnt * 2 AND LEFT.cnt > %thresh%, RIGHT);
%underThresh% := JOIN(%found%, %overThresh%, LEFT.%tempDocID% = RIGHT.%tempDocID%, %remBadDocs%(LEFT), LOOKUP);

// re-format parsed
#uniquename(capitalize)
#uniquename(corrected)
%Matches% %capitalize%(%Matches% L) :=
TRANSFORM
	SELF.%tempParsed% := StringLib.StringToUpperCase(
								StringLib.StringFilterOut(L.%tempParsed%, '.,\r\n\t'));
	SELF := L;
END;
%corrected% := PROJECT(%underThresh%, %capitalize%(LEFT));
																	
// proper noun and > 2 chars 
// TODO: ProperNoun
#uniquename(noFakes)
%noFakes% := %corrected%(%properCheck% < 1, LENGTH(TRIM(%tempParsed%)) > 2);

// Discover Back references from last names to full names
#uniquename(noFakesDist)
#uniquename(PartialOnly)
#uniquename(FullOnly)
%noFakesDist% := DISTRIBUTE(%noFakes%, HASH(%tempDocID%));
%PartialOnly% := %noFakesDist%(lib_word.Word(%tempParsed%, 2) = ''); // do two or three words?
%FullOnly% := %noFakesDist%(lib_word.Word(%tempParsed%, 2) != '');

#uniquename(testBackReference)
%testBackReference%(%Matches% L, %Matches% R) := ut.StringSimilar(L.%tempParsed%, R.%tempParsed%);

#uniquename(CreateFull)
#uniquename(FilledList)
%Matches% %CreateFull%(%Matches% L, %Matches% R) := 
	TRANSFORM
		SELF.%tempParsed% := IF(R.%tempParsed% != '', R.%tempParsed%, L.%tempParsed%);
		SELF.%tempPos% := L.%tempPos%;	
        SELF.%tempLen% := L.%tempLen%;	
        SELF.%tempDocID% := L.%tempDocID%;
		SELF.%matchScore% := %testBackReference%(L, R);
		SELF := L;
	END;

%FilledList% := JOIN(%PartialOnly%, %FullOnly%, 
					LEFT.%tempDocID% = RIGHT.%tempDocID% AND
					LEFT.%tempPos% > RIGHT.%tempPos% AND
				    %testBackReference%(LEFT, RIGHT) <= 5,
				    %CreateFull%(LEFT, RIGHT), LEFT OUTER, LOCAL);

#uniquename(sortd)
#uniquename(ddpd)
// Remove Dups due to join, taking the name with best match and name score
%sortd% := SORT(%FilledList%, %tempDocID%, %tempPos%, %matchScore%, -LENGTH((STRING)%tempParsed%), LOCAL);
%ddpd% := DEDUP(%sortd%, LEFT.%tempDocID% = RIGHT.%tempDocID% AND LEFT.%tempPos% = RIGHT.%tempPos%, LOCAL);

// Combine back with FullMatches
#uniquename(toOutLayout)
outRec %toOutLayout%(%Matches% L) :=
TRANSFORM
	SELF.outParsedField := L.%tempParsed%;
	SELF.outMatchPosField := L.%tempPos%;
	SELF.outMatchLenField := L.%tempLen%;
	SELF.outDocNumField := L.%tempDocID%;
	SELF := L;
END;

outData := PROJECT(%ddpd% + %FullOnly%, %toOutLayout%(LEFT));

ENDMACRO;