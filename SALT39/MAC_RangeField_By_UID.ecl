EXPORT MAC_RangeField_By_UID(infile,ufield,infield,low_infield,high_infield,null_field,outfile) := MACRO
// see also YYYMM version
#uniquename(idata)
// Presently we do not handle open ended ranges (well)
%idata% := TABLE(infile,{ufield,xx_low := (INTEGER)low_infield,xx_high := (INTEGER)high_infield})(xx_low<=xx_high,xx_low<>null_field,xx_high<>null_field);
#uniquename(r)
%r% := RECORD
  SALT39.UIDType ufield;
	INTEGER infield;
  END;
#uniquename(tr)
%r% %tr%(%idata% le,INTEGER c) := TRANSFORM
  SELF.ufield := le.ufield;
	SELF.infield := c;
  END;
#uniquename(n)
%n% := NORMALIZE(%idata%,LEFT.xx_high-LEFT.xx_low+1,%tr%(LEFT,COUNTER+LEFT.xx_low-1));
outfile := TABLE( %n%,{ufield,infield,Cnt := COUNT(GROUP)},ufield,infield,LOCAL);
  ENDMACRO;
