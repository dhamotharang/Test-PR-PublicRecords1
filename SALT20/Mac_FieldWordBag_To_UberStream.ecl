// A cross between fn_string_to_wordstream and MAC_FieldSet_To_UberStream
export Mac_FieldWordBag_To_UberStream(si,fieldno,k,os) := MACRO
import ut;
#uniquename(rd)
%rd% := record
  string30 s; // Length 30 presently burnt into salt too
	end;
	
#uniquename(d)
%d% := dataset([{si}],%rd%); // Parameter into dataset to allow normalize
#uniquename(split)
%rd% %split%(%d% le,unsigned2 c) := transform
  self.s := ut.Word(le.s,c);
  end;
#uniquename(n0)
%n0% := set( normalize(%d%,ut.NoWords(left.s)/2,%split%(left,counter*2)), s);
#uniquename(n1)
%n1% := set( normalize(%d%,ut.NoWords(left.s),%split%(left,counter)), s);
// Allow for numeric expanded and 'normal' wordbag input
#uniquename(n)
%n% := IF ( length(trim(si))=0 OR (unsigned)ut.Word(si,1)>0, %n0%, %n1% );
SALT20.mac_fieldset_to_uberstream(%n%,fieldno,k,os)
   ENDMACRO;
