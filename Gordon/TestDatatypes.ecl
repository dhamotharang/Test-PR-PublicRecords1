r := 
	record
		boolean b := true;
		integer i1 := 1;
		integer8 i2 := 1;
		unsigned integer8 i3 := 1;
		big_endian unsigned integer8 i4 := 1;
		integer4 i5 := 1;
		unsigned integer4 i6 := 1;
		big_endian unsigned integer4 i7 := 1;
		real r1 := 1;
		real4 r4 := 1;
		real8 r8 := 1;
		decimal1 d1 := 1;
		decimal1_1 d2 := 1;
		unsigned decimal10_5 d3 := 123.12;
		udecimal1 ud1 := 1;
		udecimal10_5 ud2 := 123.12;
		string s1 := 's';
		string128 s2 := 's';
		ebcdic string128 s3 := 's';
		ascii string128 s4 := 's';
		varstring vs1 := 'abc';
		qstring qs1 := '1';
		qstring22 qs2 := '1';
		unicode us1 := u's';
		unicode22 us2 := u's';
		varunicode us3 := u's';
		data dat1 := x'00fec0ff';
		data22 dat2 := x'00fec0ff';
		unsigned8 u1 := 1;
		big_endian unsigned8 u2 := 1;
	end;
	
export TestDataTypes := dataset([{true}], r);
