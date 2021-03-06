EXPORT Mac_Assign_UniqueId(infile,idfield) := FUNCTIONMACRO

		unsigned8 seed := MAX(infile,idfield) + 1;
		unsigned8	clusters := CLUSTERSIZE;
		typeof(infile) xform(infile lef, integer n) := transform
			self.idfield := if(lef.idfield=0,clusters*(n-1) + thorlib.node() + seed,lef.idfield);
			self := lef;
		end;

		return project(infile,xform(LEFT,COUNTER), local);

ENDMACRO;