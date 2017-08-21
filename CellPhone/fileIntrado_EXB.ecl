import Address;

layout_payload := record
string payload;
end;

payload := dataset('~thor_data400::in::intrado_exb',layout_payload,csv(terminator('\n'), separator(''), quote('')))
					(regexfind('[a-zA-Z]',payload[1]));
					
CellPhone.layoutIntrado_EXB t_payload(payload input) := Transform

self.ActivityCode 			:= input.payload[1];
self.phone10				:= input.payload[2..11];
self.BillingName1 			:= input.payload[12..31];
self.BillingAddress1 		:= input.payload[32..61];
self.BillingAddress2 		:= input.payload[62..91];
self.BillingCity			:= input.payload[92..111];
self.BillingState			:= input.payload[112..113];
self.BillingZip				:= input.payload[114..123];
self.CompanyDataOwnerID		:= input.payload[124..131];
self.Reserved				:= input.payload[132..142];
self.StartDate				:= input.payload[143..150];
self.EndDate				:= input.payload[151..158];
self.lf						:= input.payload[159];

end;

p_payload := dedup(sort(distribute(project(payload,t_payload(left)),hash(phone10)),phone10,StartDate,EndDate,local),phone10,right,local) 
					: PERSIST('~thor_dell400::persist::intradoEXB');

export fileIntrado_EXB := p_payload;