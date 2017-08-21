import CellPhone,Address,Gong;

DSI := CellPhone.fileDSI;
dDSI := distribute(DSI,hash32(DSI.directphone));
fDSI := dDSI(regexfind('[a-zA-Z]',directphone,0) = '');

CellPhone.LayoutCommonInterm tDSI(fDSI input) := Transform
self.DateFirstSeen 	:= '20051205';
self.DateLastSeen 	:= '20051205';
self.Vendor 		:= '01';
self.SourceFile 	:= 'KROLL_DSI';
self.OrigName 		:= trim(regexreplace('  +',trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.prefix),'"'),left,right) + ' '+ 
					   trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.fname),'"'),left,right) + ' ' + 
					   trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.mname),'"'),left,right) + ' ' +
					   trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.lname),'"'),left,right) + ' ' +
					   trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.suffix),'"'),left,right) + ' ',' '),left,right);
					   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.street),'"');
self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.city),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.state),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,'-"');
self.Country		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.country),'"');
self.CellPhone		:= stringlib.stringfilterout(input.directphone,'"');
self.Company		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.company),'"');
self.KeyCode		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.keycode),'"');
self.GlobalKeyCode	:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.globalkeycode),'"');
end;

pDSI := project(fDSI,tDSI(left));
CellPhone.Cellphones_clean(pDSI,cleanDSI);
export mapDSI := cleanDSI: PERSIST('~thor_dell400::persist::cellphones_DSI');