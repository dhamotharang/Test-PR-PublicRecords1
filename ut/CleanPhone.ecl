// This function takes in a raw phone field, and will return a cleaned phone
// only works for U.S. phones right now
export CleanPhone(string pPhone) :=
function

	alpha		:= '[[:alpha:]]+';
	whitespace	:= '[[:space:]]*';
	sepchar		:= '[-./]?';
	separator1	:= whitespace + sepchar + whitespace;
	frontdigit	:= '[01]?' + separator1;  // front digit
	OpenParen 	:= '[[({<]?';
	CloseParen	:= '[])}>]?';
	areacode 	:= frontdigit + OpenParen + '([[:digit:]]{3})' + CloseParen;
	 

	exchange	:= '([[:digit:]]{3})';
	lastfour	:= '([[:digit:]]{4})';
	seven		:= exchange + separator1 + lastfour;

	extension	:= '(' + whitespace + alpha + sepchar + whitespace + '[[:digit:]]+' + ')?';

	phonenumber_regex := '(' + areacode + ')?' +  separator1 + seven + extension + whitespace;

	phone_number := regexreplace(phonenumber_regex, pPhone, '$2$3$4');
	find_phone_number := regexfind(phonenumber_regex, pPhone);
	clean_phone_length := length(trim(phone_number));
	
	clean_phone := if(find_phone_number,
						map(clean_phone_length = 7 => '000' + phone_number,
						clean_phone_length < 7 or clean_phone_length > 10 => '',
						phone_number)
						,'');

	return clean_phone;

END;