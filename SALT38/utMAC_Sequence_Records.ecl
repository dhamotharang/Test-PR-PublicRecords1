EXPORT utMAC_Sequence_Records(infile,idfield,outfile) := MACRO
	IMPORT lib_thorlib;
	//-- Transform that assigns id field
	//	 Assigns idfield according to node.  
	//	 Sequential records on a node will have id fields that differ by the total number of nodes.
	#UNIQUENAME(tra)
	TYPEOF(infile) %tra%(infile lef,infile ref) := TRANSFORM
		// NOTE - SALT uses the property that these records allow DISTRIBUTE((idfield-1)%thorlib.nodes()) to get back home
		SELF.idfield := IF(lef.idfield=0,thorlib.node()+1,lef.idfield+thorlib.nodes());
		SELF := ref;
	END;
	//****** Push infile through transform above
	outfile := ITERATE(infile,%tra%(LEFT,RIGHT),LOCAL);
ENDMACRO;
