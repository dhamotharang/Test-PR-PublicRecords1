import CellPhone,Address,Gong;

intradoNRLLP := sort(distribute(CellPhone.fileIntrado_EXR,hash(phone10)),phone10,local);
intradoBNA   := sort(distribute(CellPhone.fileIntrado_EXB,hash(phone10)),phone10,local);


layoutCombined := record
CellPhone.layoutIntrado_EXR;
string1 ActivityCode;
string20 BillingName1;
string20 BillingAddress1;
string20 BillingAddress2;
string20 BillingCity;
string2 BillingState;
string9 BillingZip;
string8 CompanyDataOwnerID;
string8 StartDate;
string8 EndDate;
end;

layoutCombined trecs(intradoNRLLP L,intradoBNA R) := transform
self := L;
self.ActivityCode :=R.ActivityCode;
self.BillingName1 :=R.BillingName1;
self.BillingAddress1 := R.BillingAddress1;
self.BillingAddress2 := R.BillingAddress2;
self.BillingCity := R.BillingCity;
self.BillingState := R.BillingState;
self.BillingZip := R.BillingZip;
self.CompanyDataOwnerID := R.CompanyDataOwnerID;
self.StartDate := R.StartDate;
self.EndDate := R.EndDate;

end;

j_Intrado	:= join(intradoNRLLP,intradoBNA,
					left.phone10 = right.phone10,
					trecs(left,right),
					local);
				
CellPhone.layoutIntrado_clean t_intrado(j_Intrado input) := Transform

CleanName			:= Address.CleanPersonFML73(input.BillingName1);
CleanAddress		:= Address.CleanAddress182(input.BillingAddress1,
					   input.BillingCity + ' ' + input.BillingState+' '+ input.BillingZip);
CleanCellPhone		:= CellPhone.CleanPhones(input.phone10);	


self.prim_range 	:= CleanAddress[1..10]; 
self.predir 		:= CleanAddress[11..12];					   
self.prim_name 		:= CleanAddress[13..40];
self.addr_suffix 	:= CleanAddress[41..44];
self.postdir 		:= CleanAddress[45..46];
self.unit_desig 	:= CleanAddress[47..56];
self.sec_range 		:= CleanAddress[57..64];
self.p_city_name 	:= CleanAddress[65..89];
self.v_city_name 	:= CleanAddress[90..114];
self.state 			:= if(CleanAddress[115..116]='',ziplib.ZipToState2(CleanAddress[117..121]),
					   CleanAddress[115..116]);

self.zip5 			:= CleanAddress[117..121];
self.zip4 			:= CleanAddress[122..125];
self.cart 			:= CleanAddress[126..129];
self.cr_sort_sz 	:= CleanAddress[130];
self.lot 			:= CleanAddress[131..134];
self.lot_order 		:= CleanAddress[135];
self.dpbc 			:= CleanAddress[136..137];
self.chk_digit 		:= CleanAddress[138];
self.rec_type 		:= CleanAddress[139..140];
self.ace_fips_st	:= CleanAddress[141..142];
self.ace_fips_county:= CleanAddress[143..145];
self.geo_lat 		:= CleanAddress[146..155];
self.geo_long 		:= CleanAddress[156..166];
self.msa 			:= CleanAddress[167..170];
self.geo_blk 		:= CleanAddress[171..177];
self.geo_match 		:= CleanAddress[178];
self.err_stat 		:= CleanAddress[179..182];

self.title 			:= CleanName[1..5];
self.fname 			:= CleanName[6..25];
self.mname 			:= CleanName[26..45];
self.lname 			:= CleanName[46..65];
self.name_suffix 	:= CleanName[66..70];
self.name_score 	:= CleanName[71..73]; 

self				:= input; 

end;

p_Intrado := project(j_Intrado,t_Intrado(left))(phone10 != ''): PERSIST('~thor_dell400::persist::Intrado_clean');



export Intrado_Clean := p_Intrado;




