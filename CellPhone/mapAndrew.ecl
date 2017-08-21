import CellPhone,Address,Gong;

Andrw := CellPhone.fileAndrew;
dAndrw := distribute(Andrw,hash32(Andrw.phone));
fAndrw := dAndrw(regexfind('[a-zA-Z]',cellphone,0) = '');

CellPhone.LayoutCommonInterm tAndrw(fAndrw input) := Transform
self.DateFirstSeen 	:= '20060306';
self.DateLastSeen 	:= '20060306';
self.Vendor 		:= '02';
self.SourceFile 	:= 'TRAFFIX-ANDREW';
self.OrigName 		:= trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.fname),'"'),left,right) + ' ' + 
					   trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.lname),'"'),left,right);
				   
self.NameFormat 	:= 'F';
self.Address1		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Address1),'"');
self.Address2		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Address2),'"');
self.OrigCity		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.City),'"');
self.OrigState		:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.State),'"');
self.OrigZip		:= stringlib.stringfilterout(input.Zip,'"');
self.HomePhone		:= if(stringlib.stringfilterout(input.phone,'" ') != stringlib.stringfilterout(input.cellphone,'" '),
						  stringlib.stringfilterout(input.phone,'" '),'');
self.Gender			:= if(stringlib.stringfilterout(StringLib.StringToUpperCase(input.gender),'"') = 'M','MALE',  
					   if(stringlib.stringfilterout(StringLib.StringToUpperCase(input.gender),'"') = 'F','FEMALE',''));					   
					   
self.Dob		    := stringlib.stringfilterout(input.Dob,'-"')[1..8];
self.CellPhone		:= stringlib.stringfilterout(input.cellphone,'"');
end;

pAndrw := project(fAndrw,tAndrw(left)); 

CellPhone.Cellphones_clean(pAndrw,cleanAndrw);


export mapAndrew := cleanAndrw: PERSIST('~thor_dell400::persist::cellphones_andrw');