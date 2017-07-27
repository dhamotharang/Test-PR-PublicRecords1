export Strings
 :=
  module
	export	string	Alpha_Upper	:=	'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	export	string	Alpha_Lower	:=	'abcdefghijklmnopqrstuvwxyz';
	export	string	Digit		:=	'0123456789';
	export	string	Numeric		:=	Digit + '.-';
	export	string	Whitespace	:=	' \n\r\t' + transfer(0xA0,string1);
	export	string	Alpha_Any	:=	Alpha_Upper + Alpha_Lower;
  end
 ;