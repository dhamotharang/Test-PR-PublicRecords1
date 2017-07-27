import	Address,AID;

export	Layout_Property_AutoKey	:=
record
	unsigned6				property_rid;
	unsigned1				zero	:=	0;
	unsigned6				zero1	:=	0;
	string1					blank	:=	'';
	AID.Common.xAID	Property_RawAID;
	Address.Layout_Clean182;
end;