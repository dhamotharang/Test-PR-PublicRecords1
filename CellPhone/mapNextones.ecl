import CellPhone,Address,Gong;

Next := CellPhone.fileNextones; 
dNext := distribute(Next,hash32(Next.MSISDN));
fNext := dNext(regexfind('[a-zA-Z]',MSISDN,0) = '');

CellPhone.LayoutCommonInterm tNext(fNext input) := Transform
self.DateFirstSeen 		:= '20051205';
self.DateLastSeen 		:= '20051205';
self.Vendor 			:= '05';
self.SourceFile 		:= 'NEXTONES';
self.CellPhone	 	   		:= stringlib.stringfilterout(input.MSISDN,'" ');
self.OrigName 			:= trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.FirstName),'"'),left,right) + ' ' + 
						   trim(stringlib.stringfilterout(StringLib.StringToUpperCase(input.SecondName),'"'),left,right);

self.NameFormat 		:= 'F';
self.OrigZip			:= stringlib.stringfilterout(input.ZIP,'"-');
self.AgeGroup			:= stringlib.stringfilterout(input.AgeGroup,'"');
self.Email				:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Email),'"');
self.Gender				:= stringlib.stringfilterout(StringLib.StringToUpperCase(input.Gender),'"');
self.RegistrationDate	:= if(stringlib.stringfilterout(input.RegistrationDate,' /"')[3..4] between '01' and '12',
						   stringlib.stringfilterout(input.RegistrationDate,' /"')[5..8] +
						   stringlib.stringfilterout(input.RegistrationDate,' /"')[3..4] +
						   stringlib.stringfilterout(input.RegistrationDate,' /"')[1..2],
						   if(stringlib.stringfilterout(input.RegistrationDate,' /"')[1..2] between '01' and '12',
						   stringlib.stringfilterout(input.RegistrationDate,' /"')[5..8] +
						   stringlib.stringfilterout(input.RegistrationDate,' /"')[1..4], ''));

self.PhoneModel			:= stringlib.stringfilterout(input.PhoneModel,'"');
self.IPAddress			:= stringlib.stringfilterout(input.IPAddress,'"');
self.CarrierCode		:= stringlib.stringfilterout(input.CarrierCode,'"');
self.CountryCode		:= stringlib.stringfilterout(input.CountryCode,'"');
end;


pNext := project(fNext,tNext(left));
CellPhone.Cellphones_clean(pNext,cleanNext);
export mapNextones := cleanNext: PERSIST('~thor_dell400::persist::cellphones_Next');