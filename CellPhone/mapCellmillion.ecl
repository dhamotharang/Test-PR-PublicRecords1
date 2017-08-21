import CellPhone,Address,Gong;

Cellmillion := CellPhone.fileCellmillion;
dCellmillion := distribute(Cellmillion,hash32(Cellmillion.cellphone)); 
fCellmillion := dCellmillion(regexfind('[a-zA-Z]',cellphone,0) = '');

CellPhone.LayoutCommonInterm tCellmillion(fCellmillion input) := Transform
self.DateFirstSeen 	:= input.receivingdt;
self.DateLastSeen 	:= input.receivingdt;
self.Vendor 		:= '02';
self.SourceFile 	:= 'TRAFFIX-CELLMILLION';



self.OrigName 		:= trim(stringlib.stringfilter(StringLib.StringToUpperCase(input.fname + ' ' + input.lname),
						' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),left,right);
				   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Address1),'"');
self.Address2		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Address2),'"');

self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.City),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.State),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,' "');
self.CellPhone		:= stringlib.stringfilterout(input.cellphone,' "');
self.Email          := input.email;
self.HomePhone		:= if(stringlib.stringfilter(input.phone,'1234567890') != stringlib.stringfilter(input.cellphone,'1234567890'),input.phone,'');
self.Gender			:= if(stringlib.stringfilterout(StringLib.StringToUpperCase(input.gender),'"') = 'M','MALE',  
					   if(stringlib.stringfilterout(StringLib.StringToUpperCase(input.gender),'"') = 'F','FEMALE',''));					   
					   
self.DOB			:= stringlib.stringfilterout(input.Dob,'-"')[1..10];



end;

pCellmillion := project(fCellmillion,tCellmillion(left));
CellPhone.Cellphones_clean(pCellmillion,cleanCellmillion);
export mapCellmillion := cleanCellmillion: PERSIST('~thor_dell400::persist::cellphones_Cellmillion');