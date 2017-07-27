import Cellphone;



cellphones := CellPhone.file_cellphones_base;
dcellphones := distribute(cellphones,hash(RecordKey));

	
Phonesplus.layoutCommonOut tcellphones(dcellphones input) := Transform

self.DateFirstSeen 			:= (unsigned3)input.DateFirstSeen;
self.DateLastSeen 			:= (unsigned3)input.DateLastSeen;
self.dt_nonglb_last_seen 	:= 0;
self.src					:= '';
self.RegistrationDate 		:= 0;
self.did					:= (unsigned6)input.did;

self 						:= input;

end;



pcellphones := project(dcellphones,tcellphones(left));
export PhonesPlus_DID := output(pcellphones,,'~thor_data400::out::phonesplus_did_' + Phonesplus.version,overwrite);