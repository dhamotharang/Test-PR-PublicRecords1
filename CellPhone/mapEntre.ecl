import CellPhone,Address,Gong;

Entre := CellPhone.fileEntre;
dEntre := distribute(Entre,hash32(Entre.phone_nbr));
fEntre := dEntre(regexfind('[a-zA-Z]',phone_nbr,0) = '');

CellPhone.LayoutCommonInterm tEntre(fEntre input) := Transform
self.DateFirstSeen 	:= '20051205';
self.DateLastSeen 	:= '20051205';
self.Vendor 		:= '01';
self.SourceFile 	:= 'KROLL_ENTREPRENUERICELL';
self.OrigName 		:= trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.first_name),'"'),left,right) + ' ' + 
					   trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.last_name),'"'),left,right);
					   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.addr_1),'"');
self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.city),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.st_cd),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip_cd,'"- ') + stringlib.stringfilterout(input.zip_cd_4,'"- ');
self.CellPhone		:= stringlib.stringfilterout(input.phone_nbr,'"');
end;


pEntre := project(fEntre,tEntre(left));
CellPhone.Cellphones_clean(pEntre,cleanEntre);
export mapEntre := cleanEntre: PERSIST('~thor_dell400::persist::cellphones_Entre');