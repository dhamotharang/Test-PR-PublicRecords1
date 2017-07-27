EXPORT MAC_FieldRange_To_UberStream(fld_lo, fld_hi, fieldno, k, os):= MACRO
#uniquename(kr)
%kr% := k(word=(SALT33.StrType)fld_lo)[1];
#uniquename(d)
%d% := dataset([{%kr%.id,fieldno,(unsigned)(%kr%.field_specificity*100)}],SALT33.layout_uber_record);
os := if ( fld_lo = (typeof(fld_lo))'' OR fld_lo <> fld_hi,dataset([],SALT33.layout_uber_record),%d% );
ENDMACRO;
