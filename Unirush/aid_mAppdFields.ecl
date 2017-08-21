////////////////////////////////////////////////////////////////////////////////////////
//Macro: Append Prep Address Fields
////////////////////////////////////////////////////////////////////////////////////////
export aid_mAppdFields(infile,inStreet1,inStreet2,inCity,inState,inZip,outfile) := macro
#uniquename(tlayout)
#uniquename(tPreClean)
#uniquename(prep_city1)
#uniquename(prep_city)
#uniquename(tPreClean)
#uniquename(c_4token)
#uniquename(c_3token)
#uniquename(c_2token)
#uniquename(c_1token)
#uniquename(drvd_city)
#uniquename(prsd_city)

%tlayout% := record
string Append_Prep_Address1;
string Append_Prep_AddressLast;
//unsigned8 rawaid := 0;
infile;
end;

%tlayout% %tPreClean%(infile pInput) := transform
self.Append_Prep_Address1 :=lib_StringLib.StringLib.StringToUpperCase(trim(pInput.instreet1 + ' ' + pInput.instreet2,left,right));
self.Append_Prep_AddressLast := lib_StringLib.StringLib.StringToUpperCase(trim(pInput.incity,left,right) + if(pInput.incity <> '',', ','')
																				  + trim(pInput.InState,left,right) 
																				  + ' '
																				  + trim(pInput.InZip,left,right)[1..5]);
self := pInput;
end;
outfile := project(infile,%tPreClean%(left));
endmacro;