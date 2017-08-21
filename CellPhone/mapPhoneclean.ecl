Phoneclean := CellPhone.filePhoneclean;
dPhoneclean := distribute(Phoneclean,hash32(Phoneclean.phone)); 
fPhoneclean := dPhoneclean(regexfind('[a-zA-Z]',phone,0) = '');

CellPhone.LayoutCommonInterm tPhoneclean(fPhoneclean input) := Transform
self.DateFirstSeen 	:= '20060630';
self.DateLastSeen 	:= '20060630';
self.Vendor 		:= '02';
self.SourceFile 	:= 'TRAFFIX-PHONECLEAN';
self.OrigName 		:= trim(stringlib.stringfilter(StringLib.StringToUpperCase(input.fname + ' ' + input.lname),
						' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),left,right);
				   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Address1),'"');
self.Address2		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Address2),'"');

self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.City),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.State),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,' "');
self.CellPhone		:= stringlib.stringfilterout(input.phone,' "');


end;

pPhoneclean := project(fPhoneclean,tPhoneclean(left))  : PERSIST('~thor_dell400::persist::cellphones_phoneclean');

export mapPhoneclean := pPhoneclean;