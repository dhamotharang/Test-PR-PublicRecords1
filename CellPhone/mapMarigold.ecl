import CellPhone,Address,Gong;

Mari := CellPhone.fileMarigold;
dMari := distribute(Mari,hash32(Mari.cellphone));
fMari := dMari(regexfind('[a-zA-Z]',cellphone,0) = '');

CellPhone.LayoutCommonInterm tMari(fMari input) := Transform
self.DateFirstSeen 	:= '20060310';
self.DateLastSeen 	:= '20060310';
self.Vendor 		:= '01';
self.SourceFile 	:= 'KROLL-MARIGOLD';
self.OrigName 		:= trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.name),'"'),left,right);
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.street),'"');
self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.city),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.state),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,'"-');
self.CellPhone		:= stringlib.stringfilterout(input.cellphone,'"');
end;

pMari := project(fMari,tMari(left));
CellPhone.Cellphones_clean(pMari,cleanMari);
export mapMarigold := cleanMari: PERSIST('~thor_dell400::persist::cellphones_Mari');