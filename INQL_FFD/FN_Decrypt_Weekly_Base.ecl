EXPORT FN_Decrypt_Weekly_Base() := Function


weekly_base											:= INQL_FFD.Files(false, true).Base.Built;
weekly_base_encrypted						:= INQL_FFD.Files(false, true).Base_Encrypted.Built;
tr_encrypted										:= table(weekly_base_encrypted,{transaction_id});

base_noencrypted 							  := join(weekly_base,tr_encrypted,
																	left.transaction_id = right.transaction_id, lookup,left only);
base_encrypted_empty						:= join(weekly_base,tr_encrypted,
																	left.transaction_id = right.transaction_id,lookup);
base_encrypted_encrypted  			:= join(base_encrypted_empty,weekly_base_encrypted,
																	left.transaction_id = right.transaction_id);
																	
ds_input_decrypted_xml			:= project(base_encrypted_encrypted, 
                                TRANSFORM({recordof(base_encrypted_encrypted),string text_decrypted},
																	SELF.text_decrypted := Inql_FFD.FN_Python_DataDecryption.pythonDecryptAES(left.key_decrypted, left.text);
																	SELF 								:= Left;));

rec_input_decrypted_text:= record
recordof(ds_input_decrypted_xml);
dataset(Inql_FFD.Layouts.decrypted_data) plaintext;
end;
Inql_FFD.Layouts.decrypted_data createFailure() := 
  TRANSFORM
    SELF.transaction_id := FAILMESSAGE;
    SELF := [];
  END;
ds_base_decrypted_text := project(ds_input_decrypted_xml,transform(rec_input_decrypted_text,
										Inql_FFD.Layouts.decrypted_data plaintext_fields :=	FROMXML(Inql_FFD.Layouts.decrypted_data,left.text_decrypted,trim, ONFAIL(createFailure()));				
										self.plaintext:= plaintext_fields;
										self:=left;));
										
decrypted_base       					:=  project(ds_base_decrypted_text, transform(Inql_FFD.Layouts.base,
            self.transaction_id         := left.transaction_id;
						self.appended_did         	:= (unsigned)left.plaintext[1].lex_id;
						self.ssn										:= left.plaintext[1].ssn;
						self.drivers_license_number	:= left.plaintext[1].drivers_license_number;
						self.drivers_license_state	:= left.plaintext[1].drivers_license_state;
						self.name_first							:= left.plaintext[1].name_first;
						self.name_last							:= left.plaintext[1].name_last;
						self.name_middle						:= left.plaintext[1].name_middle;
						self.name_suffix						:= left.plaintext[1].name_suffix;
						self.addr_street						:= left.plaintext[1].addr_street;
						self.addr_city							:= left.plaintext[1].addr_city;
						self.addr_state							:= left.plaintext[1].addr_state;
						self.addr_zip5							:= left.plaintext[1].addr_zip5;
						self.addr_zip4							:= left.plaintext[1].addr_zip4;
						self.dob										:= left.plaintext[1].dob;
						self.email_addr							:= left.plaintext[1].email_address;
						self.state_id_number				:= left.plaintext[1].state_id_number;
						self.state_id_state					:= left.plaintext[1].state_id_state;
						self.eu_company_name				:= left.plaintext[1].eu_company_name;
						self.eu_addr_street					:= left.plaintext[1].eu_address_street;
						self.eu_addr_city						:= left.plaintext[1].eu_address_city;
						self.eu_addr_state					:= left.plaintext[1].eu_address_state;
						self.eu_addr_zip5						:= left.plaintext[1].eu_address_zip5;
						self.eu_phone_nbr						:= left.plaintext[1].eu_address_phone;
						self.phone_nbr							:= left.plaintext[1].phone;
						self                        := left;
						self 												:= [];
						)); 

curr_weekly_base := base_noencrypted  + decrypted_base;
return curr_weekly_base;
end;