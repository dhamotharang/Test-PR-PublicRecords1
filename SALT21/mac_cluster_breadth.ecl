export mac_cluster_breadth(infile,r1,r2,d1,o) := macro
	#uniquename(rl)
	%rl% := record
		infile.d1;
		infile.r1;
		unsigned Links := count(group);
		integer2 Closest := max(group,(integer)infile.Conf-(integer)infile.Conf_prop);
		integer2 Furthest := min(group,(integer)infile.Conf-(integer)infile.Conf_prop);
		integer2 Mean := ave(group,(integer)infile.Conf-(integer)infile.Conf_prop);
	end;
	#uniquename(o1)
	o := table(infile,%rl%,d1,r1,local);
  endmacro;
