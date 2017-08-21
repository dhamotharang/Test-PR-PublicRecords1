export Mod_Octets := MODULE

SHARED dot := '\\.';
SHARED star := '\\*';
SHARED octet := '[1-2]?[0-9]{1,2}';
SHARED first_octet := '(' + star + '|' + octet + ')' + dot;
SHARED second_octet := '(' + star + '|' + octet + ')' + dot;
SHARED third_octet := '(' + star + '|' + octet + ')' + dot;
SHARED fourth_octet := '(' + star + '|' + octet + ')';
EXPORT starPattern := '^'+first_octet+second_octet+third_octet+fourth_octet+'$';
EXPORT validPattern := '^'+octet+dot+octet+dot+octet+dot+octet+'\\s*$';

export UNSIGNED2 F_Octet(QSTRING IP, UNSIGNED1 x) := FUNCTION
//	output(IP);
	o := IF(x BETWEEN 1 AND 4, REGEXFIND(starPattern, TRIM(IP), x), '');
//	IF(x BETWEEN 1 AND 4, output(o));
	RETURN IF( o <> '*' AND o <> '', (UNSIGNED1)o, 256);
END;

export STRING F_UnConvert(UNSIGNED4 ip) := FUNCTION
	s4 := (ip & 255);
	n3 := ip DIV 256;
	s3 := (n3 & 255);
	n2 := n3 DIV 256;
	s2 := (n2 & 255);
	n1 := n2 DIV 256;
	s1 := (n1 & 255);
	return (s1 + '.' + s2 + '.' + s3 + '.' + s4);
END;

// This was added since it can be called from methods that ran their data through validPattern
//
EXPORT UNSIGNED4 F_ConvertForCleanData(QSTRING IP_padded) := FUNCTION
	IP := TRIM(IP_padded, LEFT,RIGHT);
	n1 := (UNSIGNED2) REGEXFIND(starPattern, IP, 1);
	n2 := (UNSIGNED2) REGEXFIND(starPattern, IP, 2);
	n3 := (UNSIGNED2) REGEXFIND(starPattern, IP, 3);
	n4 := (UNSIGNED2) REGEXFIND(starPattern, IP, 4);
	RETURN (((n1*256+n2)*256)+n3)*256+n4;
END;


EXPORT UNSIGNED4 F_Convert(STRING IP_padded) := FUNCTION
	IP := TRIM(IP_padded);
	o1 := REGEXFIND(starPattern, IP, 1);
	o2 := REGEXFIND(starPattern, IP, 2);
	o3 := REGEXFIND(starPattern, IP, 3);
	o4 := REGEXFIND(starPattern, IP, 4);
	n1 := IF(o1 <> '*' AND o1 <> '', (UNSIGNED2)o1, 256);
	n2 := IF(o2 <> '*' AND o2 <> '', (UNSIGNED2)o2, 256);
	n3 := IF(o3 <> '*' AND o3 <> '', (UNSIGNED2)o3, 256);
	n4 := IF(o4 <> '*' AND o4 <> '', (UNSIGNED2)o4, 256);
	RETURN IF( n1 < 256 AND n2 < 256 AND n3 < 256 AND n4 < 256,
		(((n1*256+n2)*256)+n3)*256+n4,
		0);
END;

EXPORT UNSIGNED4 F_C_Blanks(STRING IP_padded) := FUNCTION
	IP := TRIM(IP_padded);
	o1 := REGEXFIND(starPattern, IP, 1);
	o2 := REGEXFIND(starPattern, IP, 2);
	o3 := REGEXFIND(starPattern, IP, 3);
	o4 := REGEXFIND(starPattern, IP, 4);
	n1 := IF(o1 <> '*' AND o1 <> '', (UNSIGNED2)o1, 256);
	n2 := IF(o2 <> '*' AND o2 <> '', (UNSIGNED2)o2, 256);
	n3 := IF(o3 <> '*' AND o3 <> '', (UNSIGNED2)o3, 256);
	n4 := IF(o4 <> '*' AND o4 <> '', (UNSIGNED2)o4, 256);
	r1 := IF(n1 < 256, n1, 0);
	r2 := r1*256 + IF(n2 < 256, n2, 0);
	r3 := r2*256 + IF(n3 < 256, n3, 0);
	r4 := r3*256 + IF(n4 < 256, n4, 0);
	RETURN r4;
END;


EXPORT UNSIGNED4 F_C_Mask(STRING IP_padded) := FUNCTION
	IP := TRIM(IP_padded);
	o1 := REGEXFIND(starPattern, IP, 1);
	o2 := REGEXFIND(starPattern, IP, 2);
	o3 := REGEXFIND(starPattern, IP, 3);
	o4 := REGEXFIND(starPattern, IP, 4);
	n1 := IF(o1 <> '*' AND o1 <> '', (UNSIGNED2)o1, 256);
	n2 := IF(o2 <> '*' AND o2 <> '', (UNSIGNED2)o2, 256);
	n3 := IF(o3 <> '*' AND o3 <> '', (UNSIGNED2)o3, 256);
	n4 := IF(o4 <> '*' AND o4 <> '', (UNSIGNED2)o4, 256);
	r1 := IF(n1 < 256, 255, 0);
	r2 := r1*256 + IF(n2 < 256, 255, 0);
	r3 := r2*256 + IF(n3 < 256, 255, 0);
	r4 := r3*256 + IF(n4 < 256, 255, 0);
	RETURN r4;
END;

EXPORT BOOLEAN need_wildcard(STRING ip) :=
	F_Octet(ip, 1) > 255 OR F_Octet(ip, 2) > 255 OR F_Octet(ip, 3) > 255 OR F_Octet(ip, 4) > 255;

EXPORT BOOLEAN skip_filter(STRING ip) := FUNCTION
	RETURN F_Octet(ip, 1) > 255 AND F_Octet(ip, 2) > 255 AND F_Octet(ip, 3) > 255 AND F_Octet(ip, 4) > 255;
END;


SHARED sider_values := [
		0x80000000, 0xC0000000, 0xE0000000, 0xF0000000,
		0xF8000000, 0xFC000000, 0xFE000000, 0xFF000000,
		0xFF800000, 0xFFC00000, 0xFFE00000, 0xFFF00000,
		0xFFF80000, 0xFFFC0000, 0xFFFE0000, 0xFFFF0000,
		0xFFFF8000, 0xFFFFC000, 0xFFFFE000, 0xFFFFF000,
		0xFFFFF800, 0xFFFFFC00, 0xFFFFFE00, 0xFFFFFF00,
		0xFFFFFF80, 0xFFFFFFC0, 0xFFFFFFE0, 0xFFFFFFF0,
		0xFFFFFFF8, 0xFFFFFFFC, 0xFFFFFFFE, 0xFFFFFFFF
		];
EXPORT UNSIGNED4 get_sider_value(UNSIGNED1 sider) := sider_values[sider];

EXPORT UNSIGNED4 MASK0 := 0;
EXPORT UNSIGNED4 MASKALL := sider_values[32];



END;