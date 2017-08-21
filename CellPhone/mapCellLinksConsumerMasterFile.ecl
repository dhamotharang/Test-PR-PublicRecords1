import CellPhone,Address,Gong;

CellLinksM := CellPhone.fileCellLinksConsumerMasterFile;
dCellLinksM := distribute(CellLinksM,hash32(CellLinksM.phone)); 
fCellLinksM := dCellLinksM(regexfind('[a-zA-Z]',phone,0) = '');


CellPhone.LayoutCommonInterm tCellLinksM(fCellLinksM input) := Transform
self.DateFirstSeen 	:= '20060604';
self.DateLastSeen 	:= '20060604';
self.Vendor 		:= '01';
self.SourceFile 	:= 'KROLL-CELL LINKS CONSUMER';
self.OrigName 		:= trim(stringlib.stringfilter(StringLib.StringToUpperCase(input.FirstName),' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),left,right) + ' ' + 
					   trim(stringlib.stringfilter(StringLib.StringToUpperCase(input.LastName),' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),left,right);
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Address1),'"');
self.Address2		:= if(input.Address1 != input.Address2,
					   if(regexfind('APT |UNIT |FLOOR |#',input.Address2,0) = '', 
					   '',StringLib.StringFilter(StringLib.StringToUpperCase(input.Address2),
					   ' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789')),'');

self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.City),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.State),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,'" ');
self.CellPhone		:= stringlib.stringfilterout(input.phone,'" ');
self.Company		:= if(CellPhone.func_is_company(trim(input.Address2)) = '', 
						'',StringLib.StringFilter(StringLib.StringToUpperCase(input.Address2),
							' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789'));

self.KeyCode		:= stringlib.stringfilterout(input.source,'" ');
end;

pCellLinksM := project(fCellLinksM,tCellLinksM(left));
CellPhone.Cellphones_clean(pCellLinksM,cleanCellLinksM);
export mapCellLinksConsumerMasterFile := cleanCellLinksM: PERSIST('~thor_dell400::persist::cellphones_CellLinksM');