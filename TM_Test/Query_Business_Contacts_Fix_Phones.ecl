f := Business_Header.File_Business_Contacts;

layout_phone_source := record
f.source;
f.phone;
string30 phone_string := (string)f.phone;
end;

fphone := table(f(from_hdr = 'N', phone >= 10000000000), layout_phone_source);

count(fphone);
output(fphone);

layout_phone_fix := record
unsigned6 cleaned_phone;
end;

fix_phones := project(fphone,
                      transform(layout_phone_fix,
						  self.cleaned_phone := (unsigned6)address.CleanPhone(left.phone_string)));

count(fix_phones(cleaned_phone = 0));
count(fix_phones(cleaned_phone <> 0));					  
output(fix_phones);

