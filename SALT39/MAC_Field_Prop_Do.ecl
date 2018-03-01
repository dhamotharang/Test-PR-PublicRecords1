EXPORT MAC_Field_Prop_Do(infile,infield,pivot) := FUNCTIONMACRO
  SALT39.Mac_Prop_Field(infile(infield<>(typeof(infield))''),infield,pivot,o1);
	J1 := JOIN(infile(infield=(typeof(infield))''),o1,LEFT.pivot=RIGHT.pivot,TRANSFORM(RECORDOF(infile),SELF.infield:=RIGHT.infield,SELF := LEFT),LEFT OUTER,LOCAL);
	RETURN infile(infield<>(typeof(infield))'')+J1;
  ENDMACRO;
