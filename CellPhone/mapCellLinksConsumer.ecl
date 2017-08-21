import CellPhone,Address,Gong;

CellLinks := CellPhone.fileCellLinksConsumer;
dCellLinks := distribute(CellLinks,hash32(CellLinks.phone)); 
fCellLinks := dCellLinks(regexfind('[a-zA-Z]',phone,0) = '');

CellPhone.LayoutCommonInterm tCellLinks(fCellLinks input) := Transform
self.DateFirstSeen 	:= '20060530';
self.DateLastSeen 	:= '20060530';
self.Vendor 		:= '01';
self.SourceFile 	:= 'KROLL-CELL LINKS CONSUMER';
self.OrigName 		:= trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.name),'"'),left,right);
				   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Address1),'"');
self.Address2		:= if(input.Address1 != input.Address2,
					   if(regexfind('APT |UNIT |FLOOR |#',input.Address2,0) = '', 
					   '',StringLib.StringFilter(StringLib.StringToUpperCase(input.Address2),
					   ' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789')),'');

self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.City),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.State),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,'"');
self.CellPhone		:= stringlib.stringfilterout(input.phone,'"');
self.Company		:= if(CellPhone.func_is_company(trim(input.Address2)) = '', 
						'',StringLib.StringFilter(StringLib.StringToUpperCase(input.Address2),
							' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789'));

self.KeyCode		:= stringlib.stringfilterout(input.keycode,'"');
end;

pCellLinks := project(fCellLinks,tCellLinks(left));
CellPhone.Cellphones_clean(pCellLinks,cleanCellLinks); 
export mapCellLinksConsumer := cleanCellLinks: PERSIST('~thor_dell400::persist::cellphones_CellLinks');