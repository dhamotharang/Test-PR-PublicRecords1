//  I AM NOT SURE THAT THIS EVER WORKED PROPERLY
//	GAVE OUT VERY HI NUMBERS I BELIEVE

export MAC_Sequence_Records_Seeded(infile,idfield,seed,outfile) := macro

//-- Transform that assigns id field
//	 Assigns idfield according to node.  
//	 Sequential records on a node will have id fields that differ by the total number of nodes.
#uniquename(tra)
typeof(infile) %tra%(infile lef,infile ref) := transform
  self.idfield := if(lef.idfield=0,thorlib.node() + 1 + seed,lef.idfield + thorlib.nodes()); // more use nodes()
  self := ref;
  end;

//****** Push infile through transform above
outfile := iterate(infile,%tra%(left,right),local);
  endmacro;