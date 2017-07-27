export Sets
 :=
  module
	export	set of string1	Alpha_Upper	:=	['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
	export	set of string1	Alpha_Lower	:=	['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
	export	set of string1	Digit		:=	['0','1','2','3','4','5','6','7','8','9'];
	export	set of string1	Numeric		:=	Digit + ['.','-'];
	export	set of string1	Whitespace	:=	[' ','\n','\r','\t',transfer(0xA0,string1)];
	export	set of string1	Alpha_Any	:=	Alpha_Upper + Alpha_Lower;
  end
 ;