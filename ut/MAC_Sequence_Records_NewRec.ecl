import lib_thorlib;

export MAC_Sequence_Records_NewRec(infile,outrec,idfield,outfile) := macro
#uniquename(zeroid)
outrec %zeroid%(infile l) := transform
	self.idfield := 0;
	self := l;
end;

#uniquename(infile_id)
%infile_id% := project(infile, %zeroid%(left));
//-- Transform that assigns id field
//	 Assigns idfield according to node.  
//	 Sequential records on a node will have id fields that differ by the total number of nodes.
#uniquename(tra)
outrec %tra%(%infile_id% lef,%infile_id% ref) := transform
  self.idfield := if(lef.idfield=0,thorlib.node()+1,lef.idfield+400); // more use nodes()
  self := ref;
  end;

//****** Push infile through transform above
outfile := iterate(%infile_id%,%tra%(left,right),local);
  endmacro;