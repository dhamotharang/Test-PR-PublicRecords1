////////////////////////////////////////////////////////////////////////////////////////
//Macro: Append Prep Address Fields
////////////////////////////////////////////////////////////////////////////////////////
export aid_mAppdFields(infile,inStreet,incity,inState,inZip,outfile) := macro
#uniquename(tlayout)
#uniquename(tPreClean)

%tlayout% := record
string Append_Prep_Address1;
string Append_Prep_AddressLast;
unsigned8 rawaid := 0;
infile;
end;

%tlayout% %tPreClean%(infile pInput) := transform

self.Append_Prep_Address1 := lib_StringLib.StringLib.StringToUpperCase(regexreplace(' +',pInput.instreet,' '));
self.Append_Prep_AddressLast := lib_StringLib.StringLib.StringToUpperCase(trim(pInput.incity,left,right) + if(pInput.incity <> '',', ','')
																				  + trim(pInput.InState,left,right) 
																				  + ' '
																				  + trim(pInput.InZip,left,right)[1..5]);
self := pInput;
end;
outfile := project(infile,%tPreClean%(left));
endmacro;