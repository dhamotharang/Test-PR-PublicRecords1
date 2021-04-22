import PhonesInfo,dx_PhonesInfo;

EXPORT Files := module

      EXPORT trans_in := DATASET(constants.trans_in_name, Layouts.transactions, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
			
			EXPORT type_in := DATASET(constants.type_in_name, Layouts.phone_Type, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
						
			Export trans_in_prime:= constants.trans_in_prime_name;
			
			Export type_in_prime:= constants.type_in_prime_name;
			
	trans_in_prime_indexed := index({ 
  string10 phone;
  }, layouts.transactions, trans_in_prime);
	    Export trans_in_prime_flat:=Project(trans_in_prime_indexed,layouts.transactions);
	
	type_in_prime_indexed := index({ 
  string10 phone;
  }, layouts.phone_type, type_in_prime);
		 Export type_in_prime_flat:=Project(type_in_prime_indexed,layouts.phone_type);
	
		 Export trans_base:= dataset(constants.trans_base_name, Layouts.transactions,flat);
			
		 Export type_base:= dataset(constants.type_base_name, Layouts.phone_type,flat);
						
		END;