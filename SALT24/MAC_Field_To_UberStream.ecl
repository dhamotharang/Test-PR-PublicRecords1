export Mac_Field_To_UberStream(fld,fieldno,k,os) := MACRO
#uniquename(kr)
%kr% := k(word=(SALT24.StrType)fld)[1];
#uniquename(d)
%d% := dataset([{%kr%.id,fieldno,(unsigned)(%kr%.field_specificity*100)}],SALT24.layout_uber_record);
os := if ( fld = (typeof(fld))'',dataset([],SALT24.layout_uber_record),%d% );
   ENDMACRO;
