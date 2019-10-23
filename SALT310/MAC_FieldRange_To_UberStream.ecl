EXPORT MAC_FieldRange_To_UberStream(fld_lo, fld_hi, fieldno, k, os):= MACRO
#uniquename(kr)
%kr% := k(word=(SALT310.StrType)fld_lo)[1];
#uniquename(d)
%d% := DATASET([{%kr%.id,fieldno,(UNSIGNED)(%kr%.field_specificity*100)}],SALT310.layout_uber_record0);
os := IF ( fld_lo = (TYPEOF(fld_lo))'' OR fld_lo <> fld_hi,DATASET([],SALT310.layout_uber_record0),%d% );
ENDMACRO;
