EXPORT Mac_Assign_UniqueId(infile,idfield,startat = 0) := FUNCTIONMACRO

		//unsigned8 seed := MAX(infile,idfield) + 1;
		unsigned8 seed := if(startat=0, MAX(infile,idfield), startat);
		//unsigned8	clusters := CLUSTERSIZE;
		typeof(infile) xform(infile lef, integer n) := transform
			//self.idfield := if(lef.idfield=0,clusters*(n-1) + thorlib.node() + seed,lef.idfield);
			self.idfield := seed + n;
			self := lef;
		end;

		//return infile(idfield<>0) & project(DISTRIBUTE(infile(idfield=0)),xform(LEFT,COUNTER), local);
		return infile(idfield<>0) & project(DISTRIBUTE(infile(idfield=0)),xform(LEFT,COUNTER));

ENDMACRO;
