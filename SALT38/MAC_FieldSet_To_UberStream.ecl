EXPORT Mac_FieldSet_To_UberStream(fldset,fieldno,k,os) := MACRO
#uniquename(pr)
SALT38.layout_uber_record0 %pr%(k le) := TRANSFORM
  SELF.word_id := le.id;
	SELF.field := fieldno;
	SELF.uid := (UNSIGNED)le.field_specificity*100;
  END;
os := PROJECT( LIMIT(k(word IN (SET OF SALT38.StrType)fldset),SALT38._Config.Constants.JoinLimit),%pr%(LEFT) );
ENDMACRO;
