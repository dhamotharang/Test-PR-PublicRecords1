export mac_XML_field_Parser(string xmlstr, string xmlfield) := function

to_upper(string s) := stringlib.stringtouppercase(s);

//find the starting pos
spos(string f, string s) := stringlib.stringfind(to_upper(s),'<' + to_upper(f) + '>' ,1) + length(trim(f)) + 2;
 //find the ending pos
epos(string f, string s) := stringlib.stringfind(to_upper(s),'</' + to_upper(f) + '>' ,1) + - 1;
		
return xmlstr[spos(xmlfield,xmlstr)..epos(xmlfield,xmlstr)];	

end;			