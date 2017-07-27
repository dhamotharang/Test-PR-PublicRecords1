export MAC_Sequence_Records(infile,idfield,outfile) := macro
import lib_thorlib;
//-- Transform that assigns id field
//	 Assigns idfield according to node.  
//	 Sequential records on a node will have id fields that differ by the total number of nodes.
#uniquename(tra)
typeof(infile) %tra%(infile lef,infile ref) := transform
// NOTE - SALT uses the property that these records allow DISTRIBUTE((idfield-1)%thorlib.nodes()) to get back home
  self.idfield := if(lef.idfield=0,thorlib.node()+1,lef.idfield+thorlib.nodes());
  self := ref;
  end;

//****** Push infile through transform above
outfile := iterate(infile,%tra%(left,right),local);
  endmacro;