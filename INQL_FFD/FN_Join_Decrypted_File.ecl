Import Inql_FFD;
EXPORT FN_Join_Decrypted_File (dataset(Inql_FFD.Layouts.Input) NonEncrypted, dataset(Inql_FFD.Layouts.Input_Decrypted) Decrypted) := function

dNonEncrypted := distribute(NonEncrypted, hash(transaction_id));
dDecrypted    := distribute(Decrypted, hash(transaction_id));

stdInput := join(dNonEncrypted, dDecrypted,
          left.transaction_id = right.transaction_id,
          transform(recordof(dNonEncrypted),
						self.ssn	:= if(right.transaction_id='',left.ssn,right.ssn);
						self.drivers_license_number	:= if(right.transaction_id='',left.drivers_license_number,right.drivers_license_number);
						self.drivers_license_state	:= if(right.transaction_id='',left.drivers_license_state,right.drivers_license_state);
						self.name_first	:= if(right.transaction_id='',left.name_first,right.name_first);
						self.name_last	:= if(right.transaction_id='',left.name_last,right.name_last);
						self.name_middle	:= if(right.transaction_id='',left.name_middle,right.name_middle);
						self.name_suffix	:= if(right.transaction_id='',left.name_suffix,right.name_suffix);
						self.addr_street	:= if(right.transaction_id='',left.addr_street,right.addr_street);
						self.addr_city	:= if(right.transaction_id='',left.addr_city,right.addr_city);
						self.addr_state	:= if(right.transaction_id='',left.addr_state,right.addr_state);
						self.addr_zip5	:= if(right.transaction_id='',left.addr_zip5,right.addr_zip5);
						self.addr_zip4	:= if(right.transaction_id='',left.addr_zip4,right.addr_zip4);
						self.dob	:= if(right.transaction_id='',left.dob,right.dob);
						self.email_addr	:= if(right.transaction_id='',left.email_addr,right.email_address);
						self.state_id_number	:= if(right.transaction_id='',left.state_id_number,right.state_id_number);
						self.state_id_state	:= if(right.transaction_id='',left.state_id_state,right.state_id_state);
						self.eu_company_name	:= if(right.transaction_id='',left.eu_company_name,right.eu_company_name);
						self.eu_addr_street	:= if(right.transaction_id='',left.eu_addr_street,right.eu_address_street);
						self.eu_addr_city	:= if(right.transaction_id='',left.eu_addr_city,right.eu_address_city);
						self.eu_addr_state	:= if(right.transaction_id='',left.eu_addr_state,right.eu_address_state);
						self.eu_addr_zip5	:= if(right.transaction_id='',left.eu_addr_zip5,right.eu_address_zip5);
						self.eu_phone_nbr	:= if(right.transaction_id='',left.eu_phone_nbr,right.eu_address_phone);
						self.phone_nbr	:= if(right.transaction_id='',left.phone_nbr,right.phone);
						self   := left;)
						,left outer);
					
Return stdInput;

end;