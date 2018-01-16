import doxie, Data_Services;

f_qsent := Phonesplus.file_qsent_base(PublishCode != 'NP');

key_qsent := RECORD
	Phonesplus.layoutCommonKeys;
END;

key_qsent slim_phonesplus(f_qsent input) :=  TRANSFORM 
	SELF := input; 
END;

p_qsent := PROJECT(f_qsent,slim_phonesplus(LEFT));




fqsent_did := p_qsent((unsigned)did<>0, (unsigned)CellPhone<>0);
export key_qsent_did := index(fqsent_did,
                                {unsigned6 l_did := did},{fqsent_did},
                                Data_Services.Data_location.Prefix()+'thor_data400::key::qsent_did_'+doxie.Version_SuperKey);