export MakeIPList(ip_set, ip_out) :=
MACRO

#uniquename(tods)
#uniquename(tovar)
#uniquename(proj)
#uniquename(combinestring)
#uniquename(s)

%tods% := dataset(ip_set, {string256 %s%});
{string %s%} %tovar%(%tods% L) :=
TRANSFORM
	SELF := L;
END;
%proj% := PROJECT(%tods%, %tovar%(LEFT));

{string %s%} %combinestring%(%proj% le, %proj% ri) :=
TRANSFORM
	SELF.%s% := trim(le.%s%) + '|' + trim(ri.%s%);
END;
ip_out := rollup(%proj%, true, %combinestring%(left, right))[1].%s%

ENDMACRO;