import CellPhone,Address,Gong;

AdvtgMobile := CellPhone.fileKroll_AdvtgMobile;
dAdvtgMobile := distribute(AdvtgMobile,hash32(AdvtgMobile.phone)); 
fAdvtgMobile := dAdvtgMobile(regexfind('[a-zA-Z]',phone,0) = '');

CellPhone.LayoutCommonInterm tAdvtgMobile(fAdvtgMobile input) := Transform
self.DateFirstSeen 	:= '20070827';
self.DateLastSeen 	:= '20070827';
self.Vendor 		:= '01';
self.SourceFile 	:= 'KROLL-ADVTG MOBILE';
self.OrigName 		:= input.firstname + ' ' + input.lastname;
				   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Address1),'"');

self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.City),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.State),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,'"');
self.CellPhone		:= stringlib.stringfilterout(input.phone,'"');

self.KeyCode		:= stringlib.stringfilterout(input.src,'"');
end;

pAdvtgMobile := project(fAdvtgMobile,tAdvtgMobile(left));
CellPhone.Cellphones_clean(pAdvtgMobile,cleanAdvtgMobile); 
export map_krollAdvtgMobile := cleanAdvtgMobile: PERSIST('~thor_dell400::persist::cellphones_AdvtgMobile');