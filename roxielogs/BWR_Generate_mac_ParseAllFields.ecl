/*
TODO:
Handle the XML tags that have child tags


*/


up(string s) := stringlib.stringtouppercase(s);
// c := choosen(roxielogs.File_LogsTrim.records, 25);
c := enth(roxielogs.File_LogsTrim.records, 5000);
r := {string100 fieldname, integer8 size, boolean hasChildren := false, string100 debug := '', c.querytext, c.queryname};
p := 
project(
	c, 
	transform(
		r,
		self.fieldname := '',
		self.size := 0,
		self.querytext := up(left.querytext),
		self.queryname := up(left.queryname)
	)
);
 // output(p, named('p'));


 //find the starting pos of the closing tag
 spos(string s, integer c) := stringlib.stringfind(s,'</',c) + 2;
 
 //find the ending pos of the closing tag
 epos(string s, integer c) := stringlib.stringfind(s[spos(s,c)..],'>',1) - 2 + spos(s,c);

 //for pulling out the value of the tag 
 extractvalue(string s, integer c, string fn) := 
 FUNCTION
	srev := stringlib.stringreverse(s[1..spos(s,c)-3]);
	mylen := stringlib.stringfind(srev,stringlib.stringreverse(fn),1) - 2; 
	return stringlib.stringreverse(srev[1..mylen]);
 END;

 //find out how many characters within that tag 
 len(string s, integer c, string fn) := 
 length(trim(extractvalue(s,c,fn)));

 
 
 fdebug(string s, integer c, string fn) := 
	// stringlib.stringreverse(s[1..spos(s,c)-3]);
	extractvalue(s,c,fn);
 
 //find the first occurence of </
 //find the following occurence of >
 //slice that word out of the record
 
 r tra(r l, integer c) := 
 transform
		lfieldname := l.querytext[spos(l.querytext, c)..epos(l.querytext, c)];
		// lsize := len(l.querytext, c);
		lsize := len(l.querytext, c, lfieldname);
		
		self.fieldname := lfieldname;
		self.size := lsize;
		self.haschildren := extractvalue(l.querytext, c, lfieldname)[1] = '<';
		self.debug := fdebug(l.querytext, c, lfieldname);
		self.querytext := l.querytext;
		self := l;
 end; 
 
 n := 
 normalize(
	p, 
	100,
	tra(left, counter)
 )
 (
	fieldname not in ['',queryname] 
	and stringlib.stringfind(fieldname, 'UID=\'ESP', 1) = 0
	and stringlib.stringfind(fieldname, ' UID=', 1) = 0
 );                                            
 
 // output(n, named('n'));
 // output(n(fieldname in ['AGERANGE','BPSSEARCHREQUEST']), named('n_interesting'));
 
 r2 := {n.fieldname, n.size, n.haschildren};
 p2 := project(n, r2);
 s2 := sort(p2, fieldname, -haschildren,-size);
 d2 := dedup(s2, fieldname);

	// output(d2, named('d2'));
	
	// p3 := 
	// project(
		// d2,
		// transform(
			// {string500 ECL},
			// self.ECL := 
			// if(
				// left.hasChildren,
				// '// dataset(' + trim(left.fieldname) + ')' + ' // '+ trim((string)left.size),
				// 'string' + trim((string)left.size) + ' ' + left.fieldname
			// )
		// )
	// );
	
	// output(p3, named('record_definition'));
 
	s3 := sort(d2, hasChildren, fieldname);
 	p3 := 
	project(
		s3,
		transform(
			{string500 ECL},
			self.ECL := 
			if(
				left.hasChildren,
				'// dataset(' + trim(left.fieldname) + ')' + ' // '+ trim((string)left.size),
				// 'string' + trim((string)left.size) + ' ' + left.fieldname
				'roxielogs.mac_XML_Parser(r' 
				+ trim((string)(counter-1))
				+', r'
				+ trim((string)counter)
				+', '
				+ trim(left.fieldname)
				+', querytext,,,'
				+'string'
				+trim((string)left.size)
				+')'
			)
		)
	);
	
	output(p3, named('for_parsing'), all);
 
 
 
 
 
 
 
 