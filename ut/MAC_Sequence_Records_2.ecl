export MAC_Sequence_Records_2(infile,idfield,idfield2,outfile) := macro

//-- Transform that assigns id fields
//	 Assigns idfield according to node.  
//	 Sequential records on a node will have id fields that differ by the total number of nodes.
#uniquename(tra)
typeof(infile) %tra%(infile l,infile r) := transform
  self.idfield := if(l.idfield=0,thorlib.node()+1,l.idfield+400); // more use nodes()
  self.idfield2 := if(l.idfield2=0,thorlib.node()+1,l.idfield2+400); // more use nodes()
  self := r;
  end;

//****** Push infile through transform above
outfile := iterate(infile,%tra%(left,right),local);
  endmacro; 
