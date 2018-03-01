EXPORT MAC_RangeFieldYYYYMMDD_By_UID(infile,ufield,infield,low_infield,high_infield,null_field,outfile) := MACRO
// see also YYYMM version
#uniquename(idata)
// Presently we do not handle open ended ranges (well)
%idata% := TABLE(infile((UNSIGNED6)low_infield<>null_field,(UNSIGNED6)high_infield<>null_field),{ufield,UNSIGNED4 xx_low := SALT39.fn_YYYYMMDD_to_Int((UNSIGNED6)low_infield),UNSIGNED4 xx_high := SALT39.fn_YYYYMMDD_to_Int((UNSIGNED6)high_infield)})(xx_low<=xx_high);
#uniquename(r)
%r% := RECORD
  SALT39.UIDType ufield;
	UNSIGNED3 infield;
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
