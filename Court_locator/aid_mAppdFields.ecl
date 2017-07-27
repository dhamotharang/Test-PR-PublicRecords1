////////////////////////////////////////////////////////////////////////////////////////
//Macro: Append Prep Address Fields
////////////////////////////////////////////////////////////////////////////////////////
export aid_mAppdFields(infile,inStreet1,inStreet2,incity,inState,inZip,outfile) := macro
#uniquename(tlayout)
#uniquename(tPreClean)

%tlayout% := record
string Append_Prep_Address1;
string Append_Prep_AddressLast;
unsigned8 rawaid := 0;
infile;
end;

%tlayout% %tPreClean%(infile pInput) := transform
self.Append_Prep_Address1 :=stringlib.stringfilterout(StringLib.stringcleanspaces(StringLib.StringToUpperCase(
																						trim(pInput.inStreet1,left,right)
																					+ ' '
																					+ trim(pInput.inStreet2,left,right))),'"');
self.Append_Prep_AddressLast := stringlib.stringfilterout(StringLib.stringcleanspaces(StringLib.StringToUpperCase(
																						trim(pInput.InCity,left,right) 
																					+ ' '
																				  + trim(pInput.InState,left,right) 
																				  + ' '
																				  + trim(pInput.InZip,left,right))),'"');
self := pInput;
end;
outfile := project(infile,%tPreClean%(left));
endmacro;