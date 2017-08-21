import CellPhone,Address,Gong;

cell1mm := CellPhone.fileCell1mm;
d_cell1mm := distribute(cell1mm,hash32(cell1mm.phone));
f_cell1mm := d_cell1mm(regexfind('[a-zA-Z]',phone,0) = '');

/* ***************************************************************** */
/* f2_cell1mm := f_cell1mm(attn != '' and name != attn);
f3_cell1mm := f_cell1mm(attn = '' or name = attn);


f2_cell1mm t_cell1mm(f2_Cell1mm l, unsigned1 cnt) := transform

self.name := choose(cnt,l.name,l.attn);
self := l;
end;

n_cell1mm := normalize(f2_cell1mm, 2, t_cell1mm(left, counter));

all_cell1mm := n_cell1mm+f3_cell1mm; */
/* ***************************************************************** */
CellPhone.LayoutCommonInterm tcell1mm(f_cell1mm input) := Transform
self.DateFirstSeen 	:= '20060504';
self.DateLastSeen 	:= '20060504';
self.Vendor 		:= '02';
self.SourceFile 	:= 'TRAFFIX-CELL1MM';
self.OrigName 		:= trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.name),'"'),left,right);
					   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.address),'"');
self.Address2		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.address3),'"');
self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.city),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.state),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,'-"');
self.CellPhone		:= stringlib.stringfilterout(input.phone,'"');
end;

pcell1mm := project(f_cell1mm,tcell1mm(left));
CellPhone.Cellphones_clean(pcell1mm,cleancell1mm); 
export mapcell1mm := cleancell1mm: PERSIST('~thor_dell400::persist::cellphones_cell1mm');

