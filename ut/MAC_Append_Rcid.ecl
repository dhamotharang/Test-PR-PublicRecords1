export MAC_Append_Rcid(infile,idfield,outfile) := macro

//*** Check the file for greatest rcid value to start the counter.
#uniquename(MaxRcid)
%MaxRcid% := max(infile,idfield);

#uniquename(file1)
%file1% := infile(idfield <> 0);
#uniquename(file2)
%file2% := infile(idfield = 0);

//-- Transform that assigns id field
//	 Assigns idfield according to node.  
//	 Sequential records on a node will have id fields that differ by the total number of nodes.
#uniquename(tra)
//typeof(infile) %tra%(infile l, unsigned8 c) := transform
typeof(infile) %tra%(infile l, infile r) := transform
	// NOTE - SALT uses the property that these records allow DISTRIBUTE((idfield-1)%thorlib.nodes()) to get back home
  //self.idfield := if(l.idfield=0,%MaxRcid%+c, l.idfield);
	self.idfield := if(l.idfield=0,%MaxRcid%+1+thorlib.node(),l.idfield+thorlib.nodes());
  //self 				 := l;
	self				 := r;
end;

//****** Push infile through transform above
//outfile := %file1% + project(%file2%,%tra%(left, counter));
outfile := %file1% + iterate(%file2%,%tra%(left,right),local);

endmacro;