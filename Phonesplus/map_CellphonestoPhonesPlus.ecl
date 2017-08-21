import Cellphone,gong, ut;

ppCandidate := sort(distribute(CellPhone.CellPhones_DID,hash(CellPhone[1..3],CellPhone[4..6],CellPhone[7])),CellPhone[4..6],CellPhone[7],local);

layout_ppCandidate := record
string3 npa;
string3 nxx;
string1 tb;
Phonesplus.layoutCommonOut;
end;

layout_ppCandidate t_ppCandidate(ppCandidate input) := Transform

is_valid_date(string dt)  		:= if((unsigned3) dt[..6] >= 180001 and (unsigned3) dt[..6] <= (unsigned3)ut.GetDate[..6], true, false);

self.npa 						:= input.CellPhone[1..3];
self.nxx 						:= input.CellPhone[4..6];
self.tb 						:= input.CellPhone[7];

self.DateVendorFirstReported 	:= if(is_valid_date(input.DateFirstSeen),
									(unsigned3) input.DateFirstSeen[1..6], 0);
self.DateVendorLastReported 	:= if(is_valid_date(input.DateLastSeen), 
										(unsigned3)input.DateLastSeen[..6], 
										if(is_valid_date(input.DateFirstSeen), 
										(unsigned3)input.DateFirstSeen[..6], 0));
self.DateFirstSeen 				:= if(is_valid_date(input.RegistrationDate),
										(unsigned3) input.RegistrationDate[1..6], 0);
self.DateLastSeen 				:= if(is_valid_date(input.RegistrationDate),
										(unsigned3) input.RegistrationDate[1..6], 0);
self.dt_nonglb_last_seen 		:= 0;
self.glb_dppa_flag		 		:= '';
self.ActiveFlag					:= '';
self.RecordKey				 	:= ''; //hashmd5((data)input);
self.CellphoneIDKey         	:= hashmd5((data)input.Cellphone +(data)input.zip5+(data)input.prim_range+(data)input.prim_name);
self.phone7IDKey         		:= hashmd5((data)input.Cellphone[1..7] +(data)input.zip5+(data)input.prim_range+(data)input.prim_name);
self.InitScore					:= 11;
self.InitScoreType				:= 'CELLSOURCE';
self.ConfidenceScore			:= 0;
self.src						:= '';
self.ListingType		 		:= '';
self.PublishCode		 		:= '';
self.RegistrationDate 			:= if(is_valid_date(input.RegistrationDate),
										(unsigned3) input.RegistrationDate[1..6], 0);
self.did						:= (unsigned)input.did;

self 							:= input;

end;

export map_CellPhonestoPhonesplus := project(ppCandidate,t_ppCandidate(left)) 
								  :persist('~thor400_30::persist::Phonesplus::map_CellPhonestoPhonesplus');
