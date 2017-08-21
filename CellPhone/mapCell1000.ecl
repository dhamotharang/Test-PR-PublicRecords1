import CellPhone,Address,Gong;

Cell1000 := CellPhone.fileCell1000;
dCell1000 := distribute(Cell1000,hash32(Cell1000.number));
fCell1000 := dCell1000(regexfind('[a-zA-Z]',number,0) = '');

CellPhone.LayoutCommonInterm tCell1000(fCell1000 input) := Transform
self.DateFirstSeen 	:= '20060504';
self.DateLastSeen 	:= '20060504';
self.Vendor 		:= '02';
self.SourceFile 	:= 'TRAFFIX-CELL1000';
self.OrigName 		:= trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.name),'"'),left,right);
					   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.address),'"');
self.Address2		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.address3),'"');
self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.city),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.state),'"');
self.OrigZip		:= stringlib.stringfilter(input.zip,'0123456789');
self.HomePhone		:= if(stringlib.stringfilter(input.number,'0123456789') != stringlib.stringfilter(input.number,'0123456789'),
						  stringlib.stringfilter(input.number,'0123456789'),'');

self.CellPhone		:= stringlib.stringfilter(input.number,'0123456789');
end;

pCell1000 := project(fCell1000,tCell1000(left));
CellPhone.Cellphones_clean(pCell1000,cleanCell1000); 
export mapCell1000 := cleanCell1000: PERSIST('~thor_dell400::persist::cellphones_cell1000');

