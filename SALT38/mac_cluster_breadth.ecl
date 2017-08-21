EXPORT mac_cluster_breadth(infile,r1,r2,d1,o) := MACRO
	#uniquename(rl)
	%rl% := RECORD
		infile.d1;
		infile.r1;
		UNSIGNED Links := 1;
		INTEGER2 Closest := (INTEGER)infile.Conf-(INTEGER)infile.Conf_prop;
		INTEGER2 Furthest := (INTEGER)infile.Conf-(INTEGER)infile.Conf_prop;
		INTEGER2 Mean := (INTEGER)infile.Conf-(INTEGER)infile.Conf_prop;
	end;
	#uniquename(t1)
	%t1% := TABLE(infile,%rl%);
	//%t1% := TABLE(infile,%rl%,d1,r1);
	#uniquename(roll1)
	%rl%  %roll1%(%t1% le,%t1% ri) := TRANSFORM
		SELF.Links := le.Links + ri.Links;
		SELF.Closest := MAX(le.Closest,ri.Closest);
		SELF.Furthest := MIN(le.Furthest,ri.Furthest);
		SELF.Mean := (le.mean*le.links+ri.mean*ri.links) / SELF.links;
		SELF := le;
	END;
	
	#uniquename(rlocal)
	%rlocal% := ROLLUP(%t1%,LEFT.d1=RIGHT.d1 AND LEFT.r1=RIGHT.r1,%roll1%(LEFT,RIGHT),LOCAL);
	o := ROLLUP( SORT( %rlocal%, d1, r1, LOCAL ), LEFT.d1=RIGHT.d1 AND LEFT.r1=RIGHT.r1,%roll1%(LEFT,RIGHT),LOCAL);
	
  ENDMACRO;
