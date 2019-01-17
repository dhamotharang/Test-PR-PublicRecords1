export MAC_Get_BestPerRecord(infile,rid1,did1,rid2,did2,outfile) := MACRO
  #uniquename(ot)
	typeof(infile) %ot%(infile le) := transform
	  self.rid1 := le.rid2;
		self.did1 := le.did2;
		self.did2 := le.did1;
		self.rid2 := le.rid1;
	  self := le;
	end;
	// A rid could have been rid1 or rid2 - it will now have at least one case where rid1
	#uniquename(bothways)
	%bothways% := distribute(infile + project(infile,%ot%(left)),hash(rid1));
	outfile := dedup( sort( %bothways%, rid1, Conf_Prop-Conf, local ), rid1, local );
	
  ENDMACRO;
