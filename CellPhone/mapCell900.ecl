import CellPhone,Address,Gong;

Cell900 := CellPhone.fileCell900;
dCell900 := distribute(Cell900,hash32(Cell900.phone));
fCell900 := dCell900(regexfind('[a-zA-Z]',cellphone,0) = '');

CellPhone.LayoutCommonInterm tCell900(fCell900 input) := Transform
self.DateFirstSeen 	:= '20060421';
self.DateLastSeen 	:= '20060421';
self.Vendor 		:= '02';
self.SourceFile 	:= 'TRAFFIX-CELL900';
self.OrigName 		:= trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.fname),'"'),left,right) + ' ' + 
					   trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.lname),'"'),left,right);
					   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.address1),'"');
self.Address2		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.address2),'"');
self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.city),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.state),'"');
self.OrigZip		:= stringlib.stringfilterout(input.zip,'-"');
self.HomePhone		:= if(stringlib.stringfilterout(input.phone,'" ') != stringlib.stringfilterout(input.cellphone,'" '),
						  stringlib.stringfilterout(input.phone,'" '),'');
self.Email			:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.email),'"');
self.Gender			:= if(stringlib.stringfilterout(StringLib.StringToUpperCase(input.gender),'"') = 'M','MALE',  
					   if(stringlib.stringfilterout(StringLib.StringToUpperCase(input.gender),'"') = 'F','FEMALE',''));	
self.Dob		    := stringlib.stringfilterout(input.Dob,'-"')[1..8];
self.CellPhone		:= stringlib.stringfilterout(input.cellphone,'"');
end;

pCell900 := project(fCell900,tCell900(left));
CellPhone.Cellphones_clean(pcell900,cleancell900);
export mapcell900 := cleancell900: PERSIST('~thor_dell400::persist::cellphones_cell900');