DAddress       := DISTRIBUTE(hygenics_soff.file_in_so_addresshistory, HASH32(RecordID));
DSortedAddress := SORT(DAddress, RecordID, LOCAL);

IdTable        := table(DSortedAddress, Hygenics_SOff.Layout_Denorm_Address, RecordID, LOCAL);
 
	Hygenics_SOff.Layout_Denorm_Address DeNormAddress(Hygenics_SOff.Layout_Denorm_Address L, Hygenics_soff.Layout_in_SO_Addresshistory R, INTEGER C) := TRANSFORM				
				
		address_1 := trim(trim(r.street, left, right), left, right);//+' '+ trim(r.unit, left, right), left, right);
		address_2 := trim(trim(trim(r.city, left, right)+
							if(trim(r.orig_state, left, right)<>'', 
								', '+trim(r.orig_state, left, right), 
								' '), left, right)+' '+
							trim(r.orig_zip, left, right), left, right);
				
				SELF.registration_address_3		:=  IF(C=1, 
															address_1, 
															L.registration_address_3);
				SELF.registration_address_4		:=  IF(C=1, 
															address_2, 
															L.registration_address_4);
				SELF.registration_address_5		:=  '';

				SELF.other_registration_address_1	:=  IF(C=2, 
															address_1, 
															L.other_registration_address_1);	
				SELF.other_registration_address_2	:=  IF(C=2, 
															address_2, 
															L.other_registration_address_2);
				SELF.other_registration_address_3	:=  IF(C=3, 
															address_1, 
															L.other_registration_address_3);
				SELF.other_registration_address_4	:=  IF(C=3, 
															address_2, 
															L.other_registration_address_4);
				SELF.other_registration_address_5	:=  '';

				SELF := L;
	end;
	
denorm_address := DENORMALIZE(IdTable, DSortedAddress,
									LEFT.recordid = RIGHT.recordid,
									DeNormAddress(LEFT,RIGHT,COUNTER),LOCAL):persist('~thor_200::persist::soff_addresshistory');	
	 
export Mapping_Denorm_Address := denorm_address; 