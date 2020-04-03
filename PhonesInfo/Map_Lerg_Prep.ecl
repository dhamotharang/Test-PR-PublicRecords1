IMPORT AID;

EXPORT Map_Lerg_Prep(dataset(PhonesInfo.Layout_Lerg.lergPrep) inFile) := FUNCTION
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//PREP FOR ADDRESS CLEANER/////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
		filter_inFile := inFile(country in ['CA', 'US']);	//Restrict Records to Canada & US States/Territories
		
		//Address Cleaner Prep - Populate carrier or contact address, when available	
		Layout_Lerg.lergPrep addTr2(filter_inFile l):= transform
				self.address1							:= map(trim(l.carrier_address1, left, right)<>'' and trim(l.carrier_address2, left, right)<>'' 	=> trim(l.carrier_address1, left, right)+' '+trim(l.carrier_address2, left, right),
																				 trim(l.carrier_address1, left, right)<>'' 																								=> trim(l.carrier_address1, left, right),
																				 trim(l.contact_address1, left, right)<>'' and trim(l.contact_address2, left, right)<>''	=> trim(l.contact_address1, left, right)+' '+trim(l.contact_address2, left, right),
																				 trim(l.contact_address1, left, right)<>''																								=> trim(l.contact_address1, left, right),
																				 trim(l.contact_address2, left, right)<>''																								=> trim(l.contact_address2, left, right),	
																				'');
				self.address2 						:= map(trim(l.carrier_city, left, right)<>'' and trim(l.carrier_state, left, right)<>'' 				=> trim(trim(trim(l.carrier_city, left, right)+', '+trim(l.carrier_state, left, right), left, right)+' '+ trim(l.carrier_zip, left, right), left, right),
																				 trim(l.contact_city, left, right)<>'' and trim(l.contact_state, left, right)<>''					=> trim(trim(trim(l.contact_city, left, right)+', '+trim(l.contact_state, left, right), left, right)+' '+ trim(l.contact_zip, left, right), left, right),
																				'');
				self.append_Rawaid 				:= 0;	
				self 											:= l;
		end;
		
		addAddr 		:= project(filter_inFile, addTr2(left));	
	
	RETURN addAddr;

END;