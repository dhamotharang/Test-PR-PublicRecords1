export Standardize_Phone(
	 pDataset									// Input Dataset
	,pPhoneField							// Field with Dirty Date
	,pOutputDataset						// Output Dataset
	,pOutPhoneField		= 'clean_phone'
	,pOutPhoneType		= 'string10'
	,pExistsInLayout	= 'false'
) :=
macro

	#uniquename(alpha							)
	#uniquename(whitespace				)
	#uniquename(sepchar						)
	#uniquename(separator1				)
	#uniquename(frontdigit				)
	#uniquename(OpenParen					)
	#uniquename(CloseParen				)
	#uniquename(areacode					)
	#uniquename(areacode_f				)
	#uniquename(exchange					)
	#uniquename(lastfour					)
	#uniquename(seven							)
	#uniquename(extension					)
	#uniquename(phonenumber_regex	)
	#uniquename(phone_match				)
	#uniquename(tgetmatch					)
	
	pattern %alpha%				:= pattern('[[:alpha:]]+');
	pattern %whitespace%	:= pattern('[[:space:]]*');
	pattern %sepchar%			:= pattern('[-./]?');
	pattern %separator1%	:= %whitespace% %sepchar% %whitespace%;
	pattern %frontdigit%	:= pattern('[01]?') %separator1%;  // front digit
	pattern %OpenParen% 	:= pattern('[[({<]?');
	pattern %CloseParen%	:= pattern('[\\])}>]?');
	pattern	%areacode%		:= pattern('([[:digit:]]{3})');
	pattern %areacode_f%	:= %frontdigit% %OpenParen% %areacode% %CloseParen%;

	pattern %exchange%		:= pattern('([[:digit:]]{3})');
	pattern %lastfour%		:= pattern('([[:digit:]]{4})');
	pattern %seven%				:= %exchange% %separator1% %lastfour%;

	pattern %extension%		:= opt(%whitespace% %alpha% %sepchar% %whitespace% pattern('[[:digit:]]+'));

	pattern %phonenumber_regex% := opt(%areacode_f%) %separator1% %seven% %extension% %whitespace%;
	
#IF(pExistsInLayout = false)
%phone_match% :=
record
	recordof(pDataset);
	pOutPhoneType pOutPhoneField;
end;
#ELSE
%phone_match% := recordof(pDataset);
#END

%phone_match% %tgetmatch%(pDataset l) :=
transform
#if(#TEXT(pOutPhoneType)[1..6] = 'string')			
	self.pOutPhoneField := if(not l.pPhoneField[1] = '+' 
														and matched(%phonenumber_regex%/%areacode%)
														and matched(%phonenumber_regex%/%exchange%)
														and matched(%phonenumber_regex%/%lastfour%)
												,intformat((integer)(matchtext(%phonenumber_regex%/%areacode%) + matchtext(%phonenumber_regex%/%exchange%) + matchtext(%phonenumber_regex%/%lastfour%)),10,1)
												,''
#ELSE
	self.pOutPhoneField := if(not l.pPhoneField[1] = '+' 
														and matched(%phonenumber_regex%/%areacode%)
														and matched(%phonenumber_regex%/%exchange%)
														and matched(%phonenumber_regex%/%lastfour%)
												,(integer)(matchtext(%phonenumber_regex%/%areacode%) + matchtext(%phonenumber_regex%/%exchange%) + matchtext(%phonenumber_regex%/%lastfour%))
												,0
#END
	);
	self := l;
//	self.area_code 	:= if(matched(phonenumber_regex/areacode)	and not l.pPhoneField[1] = '+',intformat((integer)matchtext(phonenumber_regex/areacode),3,1)	,'');
//	self.exchange 	:= if(matched(phonenumber_regex/areacode) and matched(phonenumber_regex/exchange)	and not l.pPhoneField[1] = '+',intformat((integer)matchtext(phonenumber_regex/exchange),3,1)	,'');
//	self.lastfour 	:= if(matched(phonenumber_regex/areacode) and matched(phonenumber_regex/lastfour)	and not l.pPhoneField[1] = '+',intformat((integer)matchtext(phonenumber_regex/lastfour),4,1)	,'');
end;
pOutputDataset := parse( pDataset				//dataset
										,pPhoneField				//field to parse out
										,%phonenumber_regex%	//pattern used to parse it
										,%tgetmatch%(left)		//transform to add cleaned phone fields
										,first
										,not matched
										,best
										,nocase
									);
ENDmacro;
