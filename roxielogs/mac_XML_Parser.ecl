// This macro looks for <newfield> within xmlfield of infile and places the value into a new field within outfile, called newfield.

// options:
// stripNewFieldValueFromXMLField = false, if TRUE, the value within <newfield> will be stripped from xmlfield
// replaceStrippedValueWith = 'REMOVED', if stripNewFieldValueFromXMLField, this parameter should contain the string, if any, you'd like in place of the stripped value


export mac_XML_Parser(infile, outfile, newfield, xmlfield = 'rest', stripNewFieldValueFromXMLField = false, replaceStrippedValueWith = 'REMOVED', fieldsize = 'string200') := macro

 #uniquename(up)	
 #uniquename(spos)	
 #uniquename(epos)	
 //make it upper case
 %up%(string s) := stringlib.stringtouppercase(s);
 //find the starting pos
 %spos%(string f, string s) := stringlib.stringfind(%up%(s),'<' + %up%(f) + '>' ,1) + length(trim(f)) + 2;
 //find the ending pos
 %epos%(string f, string s) := stringlib.stringfind(%up%(s),'</' + %up%(f) + '>' ,1) + - 1;
	
	outfile := 
	project(
		infile,
		transform(
			{fieldsize newfield, infile},
			self.newfield := left.xmlfield[%spos%(#TEXT(newfield),left.xmlfield)..%epos%(#TEXT(newfield),left.xmlfield)],
			self.xmlField :=
			if(
				stripNewFieldValueFromXMLField									//we want to strip
				and %spos%(#TEXT(newfield),left.xmlfield) > 0		//and we have a valid starting pos
				and %epos%(#TEXT(newfield),left.xmlfield) > 0,	//and we have a valid ending pos
				left.xmlField[1..(%spos%(#TEXT(newfield),left.xmlfield)) - 1]
				+#TEXT(replaceStrippedValueWith)
				+left.xmlField[(%epos%(#TEXT(newfield),left.xmlfield)) + 1..],
				left.xmlField
			),
			self := left
		)
	);

endmacro;
