
layout_payload := record
string payload;
end;

payload := (dataset('~thor_data400::in::intrado_exr',layout_payload,csv(terminator('\n'), separator(''), quote('')))
					(payload[1..2] = '41'));

CellPhone.layoutIntrado_EXR t_payload(payload input) := Transform

self.transaction_code 			:= input.payload[1..2];
self.record_number 				:= input.payload[3..11];
self.reserved 					:= input.payload[12..25];
self.current_date 				:= input.payload[26..33];
self.phone10					:= input.payload[34..43];
self.service_begin_date 		:= input.payload[44..51];
self.service_end_date 			:= input.payload[52..59];
self.overall_ocn				:= input.payload[60..63];
self.regional_ocn				:= input.payload[64..67];
self.revenue_acct_offc			:= input.payload[68..70];
self.BNA_indicator				:= input.payload[71];
self.local_route_no				:= input.payload[72..81];
self.mobile_ID_no				:= input.payload[82..91];
self.local_serv_resale_ind		:= input.payload[92];
self.local_serv_wireless_ind	:= input.payload[93];
self.local_serv_unbundled_ind	:= input.payload[94];
self.local_serv_ported_ind		:= input.payload[95];
self.local_serv_pooled_ind 		:= input.payload[96];
self.co_code_ind 				:= input.payload[97];
self.reserved1 					:= input.payload[98..110];
self.state_origin				:= input.payload[111..112];
self.lata				 		:= input.payload[113..116];
self.end_office_CLLI 			:= input.payload[117..127];
self.h_coord					:= input.payload[128..132];
self.v_coord					:= input.payload[133..137];
self.nena_ID					:= input.payload[138..142];
self.class_of_Service			:= input.payload[143];
self.company_type				:= input.payload[144];
self.reserved3					:= input.payload[145..229];
self.last_update				:= input.payload[230..237];
self.reserved4					:= input.payload[238..247];
self.clientID					:= input.payload[248..251];
self.reserved5					:= input.payload[252..449];
self.lf							:= input.payload[450];
end;


p_payload := dedup(sort(distribute(project(payload,t_payload(left)),hash(phone10)),phone10,last_update,local),phone10,right,local) 
				: PERSIST('~thor_dell400::persist::intradoEXR');




export fileIntrado_EXR := p_payload;

