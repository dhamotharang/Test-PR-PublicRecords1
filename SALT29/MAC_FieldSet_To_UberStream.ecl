export Mac_FieldSet_To_UberStream(fldset,fieldno,k,os) := MACRO
#uniquename(pr)
SALT29.layout_uber_record %pr%(k le) := transform
  self.word_id := le.id;
	self.field := fieldno;
	self.uid := (unsigned)le.field_specificity*100;
  end;
os := project( k(word IN fldset),%pr%(left) );
   ENDMACRO;
