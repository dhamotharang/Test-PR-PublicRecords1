import Header;
export MAC_Link_Header_Input(l,r,m) := MACRO
		SELF.matchCode := if(r.did<>0,m,l.matchCode);
		SELF.outdata := if(r.did<>0,PROJECT(r,TRANSFORM(Header.Layout_Header,SELF := LEFT,SELF := [])),
																					l.outdata);
		SELF.indata := l.indata;
		SELF.seq := l.seq;
ENDMACRO;