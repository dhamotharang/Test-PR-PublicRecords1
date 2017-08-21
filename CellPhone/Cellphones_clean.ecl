import CellPhone,Address,Gong;


export CellPhones_clean(infile,outfile) := macro

#uniquename(dcellphones)				
%dcellphones% := distribute(infile,hash(Cellphone));

#uniquename(tcellphones)
#uniquename(preCleanName)
#uniquename(CleanName)
#uniquename(CleanAddress)
#uniquename(CleanCellPhone)
#uniquename(CleanHomePhone)	
CellPhone.layoutCommonOut %tcellphones%(%dcellphones% input) := Transform

%preCleanName%		:= StringLib.StringFilter(StringLib.StringToUpperCase(input.OrigName),
					   ' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 

%CleanName%			:= Address.CleanPersonFML73(%preCleanName%);

%CleanAddress%		:= Address.CleanAddress182(input.Address1 + ' ' + input.Address2,
					   input.OrigCity + ' ' + input.OrigState+' '+ input.OrigZip);

%CleanCellPhone%		:= CellPhone.CleanPhones(input.CellPhone);	
%CleanHomePhone%		:= CellPhone.CleanPhones(input.HomePhone);				   

self.OrigName		:= %preCleanName%;
self.DOB			:= if(input.Dob[1..4] > '1900' and input.Dob[1..4] < '2000',input.Dob,'');
self.CellPhone		:= if (%CleanCellPhone%[1] != '0' and %CleanCellPhone%[1] != '1' and %CleanCellPhone%[4..10] != '5551212',
					   %CleanCellPhone%, '');
self.HomePhone		:= if (%CleanHomePhone%[1] != '0' and %CleanHomePhone%[1] != '1',
					   %CleanHomePhone%, '');
self.Company		:= if(input.Company = '',if(CellPhone.func_is_company(trim(input.OrigName)) = '', 
												'',StringLib.StringFilter(StringLib.StringToUpperCase(input.OrigName),
												' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789')),input.Company);
self.RegistrationDate := StringLib.StringFilter(input.RegistrationDate,'0123456789');

self.prim_range 	:= %CleanAddress%[1..10]; 
self.predir 		:= %CleanAddress%[11..12];					   
self.prim_name 		:= %CleanAddress%[13..40];
self.addr_suffix 	:= %CleanAddress%[41..44];
self.postdir 		:= %CleanAddress%[45..46];
self.unit_desig 	:= %CleanAddress%[47..56];
self.sec_range 		:= %CleanAddress%[57..64];
self.p_city_name 	:= %CleanAddress%[65..89];
self.v_city_name 	:= %CleanAddress%[90..114];
self.state 			:= if(%CleanAddress%[115..116]='',ziplib.ZipToState2(%CleanAddress%[117..121]),
					   %CleanAddress%[115..116]);

self.zip5 			:= %CleanAddress%[117..121];
self.zip4 			:= %CleanAddress%[122..125];
self.cart 			:= %CleanAddress%[126..129];
self.cr_sort_sz 	:= %CleanAddress%[130];
self.lot 			:= %CleanAddress%[131..134];
self.lot_order 		:= %CleanAddress%[135];
self.dpbc 			:= %CleanAddress%[136..137];
self.chk_digit 		:= %CleanAddress%[138];
self.rec_type 		:= %CleanAddress%[139..140];
self.ace_fips_st	:= %CleanAddress%[141..142];
self.ace_fips_county:= %CleanAddress%[143..145];
self.geo_lat 		:= %CleanAddress%[146..155];
self.geo_long 		:= %CleanAddress%[156..166];
self.msa 			:= %CleanAddress%[167..170];
self.geo_blk 		:= %CleanAddress%[171..177];
self.geo_match 		:= %CleanAddress%[178];
self.err_stat 		:= %CleanAddress%[179..182];


self.title 			:= %CleanName%[1..5];
self.fname 			:= %CleanName%[6..25];
self.mname 			:= %CleanName%[26..45];
self.lname 			:= %CleanName%[46..65];
self.name_suffix 	:= %CleanName%[66..70];
self.name_score 	:= %CleanName%[71..73]; 

self				:= input; 

end;

#uniquename(pcellphones)
%pcellphones% := project(%dcellphones%,%tcellphones%(left));

#uniquename(scellphones)
%scellphones% := sort(%pcellphones%,Cellphone,SourceFile,lname,fname,prim_range,prim_name,
					zip5,local);
#uniquename(ddcellphones)
%ddcellphones% := dedup(%scellphones%,Cellphone,SourceFile,lname,fname,prim_range,prim_name,
					zip5,local);
#uniquename(fcellphones)
%fcellphones% := %ddcellphones%(CellPhone !='');

outfile := %fcellphones%(not(name_score < '080' and Company =''));
endmacro;



