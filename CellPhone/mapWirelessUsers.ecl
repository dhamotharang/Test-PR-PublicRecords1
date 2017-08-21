import CellPhone,Address,Gong;

WireUse := CellPhone.fileWirelessUsers; 
dWireUse := distribute(WireUse,hash32(WireUse.cellphone));
fWireUse := dWireUse(regexfind('[a-zA-Z]',cellphone,0) = '');

CellPhone.LayoutCommonInterm tWireUse(fWireUse input) := Transform

self.DateFirstSeen 	:= '20060120';
self.DateLastSeen 	:= '20060120';
self.Vendor 		:= '01';
self.SourceFile 	:= 'KROLL-WIRELESS CELL USERS';
self.OrigName 		:= trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.name),'"'),left,right);
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.street),'"');
self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.city),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.state),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,'"-');
self.CellPhone		:= stringlib.stringfilterout(input.cellphone,'"');
end;


pWireUse := project(fWireUse,tWireUse(left));
CellPhone.Cellphones_clean(pWireUse,cleanWireUse);
export mapWirelessUsers := cleanWireUse: PERSIST('~thor_dell400::persist::cellphones_WireUse');