IMPORT $, Std, Gateway,data_services,Inql_FFD;

EXPORT FN_File_Decryption(dataset(Layouts.Input_Encrypted) pInFile) := function

ds_common_input := PROJECT(pInFile, TRANSFORM(Inql_FFD.Layouts.Comomn_Input_Encrypted,
                              SELF.text := IF (LEFT.text_1 != '', LEFT.text_1, LEFT.text_2),
                              SELF := LEFT));

ds_ddp := DEDUP(SORT(ds_common_input, key_group, key_version, key_encrypted), key_group, key_version, key_encrypted);
ds_keys := PROJECT(ds_ddp, TRANSFORM(Inql_FFD.layouts.t_Key,
                             SELF.EncryptionKey := LEFT.key_encrypted,
                             SELF.KeyGroup := LEFT.key_group,
                             SELF.KeyVersion := LEFT.key_version));

ds_gateways := DATASET([{Inql_FFD._Constants.DECRYPTION_SERVICENAME, Inql_FFD._Constants.DECRYPTION_ESP_URL}] 
                       ,Gateway.layouts.config);
											 
ds_soap := Inql_FFD.FN_SoapCall_KeyDecryption(ds_keys, Inql_FFD._Constants.DECRYPTION_KEY_PUBLIC, ds_gateways);
ds_rsa_keys := ds_soap[1].response.keys;
Inql_FFD.Layouts.Decrypted_Keys DecryptKeys (Inql_FFD.layouts.t_RsaKey L) := TRANSFORM
  SELF.key_group := L.KeyGroup;
  SELF.key_version := L.KeyVersion;
  SELF.key_encrypted := L.EncryptionKey;
  SELF.key_decrypted := Inql_FFD.FN_Python_DataDecryption.PythonDecryptRsaPksc_OAEP(L.RSAProtectedKey);
END;
keys_decrypted := PROJECT(ds_rsa_keys, DecryptKeys(LEFT));

Inql_FFD.Layouts.Decrypted_Text DecryptText (Inql_FFD.Layouts.Comomn_Input_Encrypted L, Inql_FFD.Layouts.decrypted_keys R) := 
  TRANSFORM
		SELF.text_decrypted := Inql_FFD.FN_Python_DataDecryption.pythonDecryptAES(R.key_decrypted, L.text);
		SELF := L;
		SELF := R;
END;

ds_input_decrypted_xml := JOIN(ds_common_input, keys_decrypted,
																			 LEFT.key_encrypted = RIGHT.key_encrypted,
																			 DecryptText(LEFT, RIGHT),
																			 LEFT OUTER, KEEP(1), LIMIT(0));
			 
Inql_FFD.Layouts.decrypted_data createFailure() := 
  TRANSFORM
    SELF.transaction_id := FAILMESSAGE;
    SELF := [];
  END;

rec_input_decrypted_text:= record
recordof(ds_input_decrypted_xml);
dataset(Inql_FFD.Layouts.decrypted_data) plaintext;
end;

ds_input_decrypted_text := project(ds_input_decrypted_xml,transform(rec_input_decrypted_text,
										Inql_FFD.Layouts.decrypted_data plaintext_fields :=	FROMXML(Inql_FFD.Layouts.decrypted_data,left.text_decrypted,trim, ONFAIL(createFailure()));				
										self.plaintext:= plaintext_fields;
										self:=left;));

decrypted_base       					:=  project(ds_input_decrypted_text, transform(Inql_FFD.Layouts.Input_Decrypted,
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
						self.email_address					:= left.plaintext[1].email_address;
						self.state_id_number				:= left.plaintext[1].state_id_number;
						self.state_id_state					:= left.plaintext[1].state_id_state;
						self.eu_company_name				:= left.plaintext[1].eu_company_name;
						self.eu_address_street			:= left.plaintext[1].eu_address_street;
						self.eu_address_city				:= left.plaintext[1].eu_address_city;
						self.eu_address_state				:= left.plaintext[1].eu_address_state;
						self.eu_address_zip5				:= left.plaintext[1].eu_address_zip5;
						self.eu_address_phone				:= left.plaintext[1].eu_address_phone;
						self.phone									:= left.plaintext[1].phone;
						self                        := left;
						self 												:= [];
						)); 

return decrypted_base ;

end;