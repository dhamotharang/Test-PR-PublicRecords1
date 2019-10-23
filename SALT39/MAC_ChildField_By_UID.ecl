EXPORT MAC_ChildField_By_UID(infile,ufield,listfield,infield) := FUNCTIONMACRO
  R := RECORD
	  SALT39.UIDType ufield;
		TYPEOF(infile.listfield.infield) infield;
	END;
	
  R T(infile le, UNSIGNED c) := TRANSFORM
	  SELF.ufield := le.ufield;
		SELF.infield := le.listfield[c].infield;
	END;
	
	n := NORMALIZE(infile,COUNT(LEFT.listfield), T(LEFT,COUNTER));
	
  RETURN TABLE(n,{infield,ufield,Cnt := COUNT(GROUP)},ufield,infield,local);
ENDMACRO;
