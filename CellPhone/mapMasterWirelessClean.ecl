import CellPhone,Address,Gong;

MastWireClean := CellPhone.fileMasterWirelessClean;
dMastWireClean := distribute(MastWireClean,hash32(MastWireClean.phone)); 
fMastWireClean := dMastWireClean(regexfind('[a-zA-Z]',phone,0) = '');

CellPhone.LayoutCommonInterm tMastWireClean(fMastWireClean input) := Transform
self.DateFirstSeen 	:= '20060906';
self.DateLastSeen 	:= '20060906';
self.Vendor 		:= '01';
self.SourceFile 	:= 'KROLL-MASTER WIRELESS CLEAN';
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

pMastWireClean := project(fMastWireClean,tMastWireClean(left));
CellPhone.Cellphones_clean(pMastWireClean,cleanMastWireClean);
export mapMasterWirelessClean := cleanMastWireClean: PERSIST('~thor_dell400::persist::cellphones_MastWireClean');