IMPORT STD;

EXPORT Fn_ConcatInput(STRING BuildDateTime = mod_Utilities.strCurrentDateTimeStamp) := FUNCTION
  ECrash_incident := Infiles.incident; 
  ECrash_citation := Infiles.citation;
  ECrash_commercl := Infiles.commercl;
  ECrash_persn := Infiles.persn;
  ECrash_vehicl := Infiles.vehicl;
  ECrash_Property_damage := Infiles.Property_damage;
  ECrash_Document := Infiles.Document;
  dsDupesExtract := Files_eCrash.DS_DUPES_EXTRACT( filedate <> 'filedate');
  								 
  create_logical := SEQUENTIAL(
  OUTPUT(ECrash_commercl,,'~thor_data400::in::ecrash::commercl_patch_'+BuildDateTime, COMPRESSED, CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'))),
  OUTPUT(ECrash_Property_damage,,'~thor_data400::in::ecrash::Property_damage_patch_'+BuildDateTime, COMPRESSED, CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000))),
  OUTPUT(ECrash_citation,,'~thor_data400::in::ecrash::citation_patch_'+BuildDateTime, COMPRESSED, CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'))),
  OUTPUT(ECrash_vehicl,,'~thor_data400::in::ecrash::vehicl_patch_'+BuildDateTime, COMPRESSED, CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000))),
  OUTPUT(ECrash_persn,,'~thor_data400::in::ecrash::persn_patch_'+BuildDateTime, COMPRESSED, CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'))),
  OUTPUT(ECrash_incident,,'~thor_data400::in::ecrash::incident_patch_'+BuildDateTime, COMPRESSED, CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(60000))),
  OUTPUT(ECrash_Document,,'~thor_data400::in::ecrash::document_raw_'+BuildDateTime, COMPRESSED, CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'))),
	OUTPUT(dsDupesExtract,,'~thor_data400::out::ecrash::extract::caseDupes::thru_'+BuildDateTime, COMPRESSED, CSV(HEADING('filedate,flag,del_incident_id,add_incident_id\n'), TERMINATOR('\n'), SEPARATOR(','))));
  
  //please verify the logical files before clearing the super files
  clear_super := SEQUENTIAL(STD.File.ClearSuperFile('~thor_data400::in::ecrash::commercl_raw'), 
  STD.File.ClearSuperFile('~thor_data400::in::ecrash::citatn_raw'),
  STD.File.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new'),
  STD.File.ClearSuperFile('~thor_data400::in::ecrash::persn_raw'), 
  STD.File.ClearSuperFile('~thor_data400::in::ecrash::vehicl_raw'), 
  STD.File.ClearSuperFile('~thor_data400::in::ecrash::propertydamage_raw'),
  STD.File.ClearSuperFile('~thor_data400::in::ecrash::document_raw'),
	STD.File.ClearSuperFile('~thor_data400::out::ecrash::dupes'));
  
  add_super := SEQUENTIAL(STD.File.AddSuperFile('~thor_data400::in::ecrash::commercl_raw','~thor_data400::in::ecrash::commercl_patch_'+BuildDateTime), 
  STD.File.AddSuperFile('~thor_data400::in::ecrash::citatn_raw','~thor_data400::in::ecrash::citation_patch_'+BuildDateTime), 
  STD.File.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_patch_'+BuildDateTime), 
  STD.File.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::persn_patch_'+BuildDateTime), 
  STD.File.AddSuperFile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::vehicl_patch_'+BuildDateTime), 
  STD.File.AddSuperFile('~thor_data400::in::ecrash::propertydamage_raw','~thor_data400::in::ecrash::Property_damage_patch_'+BuildDateTime),
  STD.File.AddSuperFile('~thor_data400::in::ecrash::document_raw','~thor_data400::in::ecrash::document_raw_'+BuildDateTime),
	STD.File.AddSuperFile('~thor_data400::out::ecrash::dupes', '~thor_data400::out::ecrash::extract::caseDupes::thru_'+BuildDateTime));
  
  validate_counts := MAP(COUNT(Infiles.incident) <> COUNT(ECrash_incident) => FAIL('ECrash_Incident_counts_mismatch'),
                         COUNT(Infiles.persn) <> COUNT(ECrash_persn) => FAIL('ECrash_Person_counts_mismatch'),
                         COUNT(Infiles.vehicl) <> COUNT(ECrash_vehicl) => FAIL('ECrash_Vehicle_counts_mismatch'),
                         COUNT(Infiles.citation) <> COUNT(ECrash_citation) => FAIL('ECrash_Citation_counts_mismatch'),
                         COUNT(Infiles.Property_damage) <> COUNT(ECrash_Property_damage) => FAIL('ECrash_Ptydamage_counts_mismatch'),
                         COUNT(Infiles.commercl) <> COUNT(ECrash_commercl) => FAIL('ECrash_Commercial_counts_mismatch'),
                         OUTPUT('All_ECrash_Concat_filecnt_looks_good')
  										  );
  
  RETURN SEQUENTIAL(OUTPUT(COUNT(Infiles.incident),NAMED('raw_incident')),
                    OUTPUT(COUNT(ECrash_incident),NAMED('outputraw_incident')),
                    OUTPUT(COUNT(Infiles.persn),NAMED('raw_person')),
                    OUTPUT(COUNT(ECrash_persn),NAMED('outputraw_person')),
                    OUTPUT(COUNT(Infiles.vehicl),NAMED('raw_vehicle')), 
                    OUTPUT(COUNT(ECrash_vehicl),NAMED('outputraw_vehicle')),
                    OUTPUT(COUNT(Infiles.citation),NAMED('raw_citation')),
                    OUTPUT(COUNT(ECrash_citation),NAMED('outputraw_citation')),
                    OUTPUT(COUNT(Infiles.Property_damage),NAMED('raw_property')),
                    OUTPUT(COUNT(ECrash_Property_damage),NAMED('outputraw_property')),
                    OUTPUT(COUNT(Infiles.commercl),NAMED('raw_commercl')),
                    OUTPUT(COUNT(ECrash_commercl),NAMED('outputraw_commercl')),
										validate_counts,
                    create_logical,
										clear_super,
										add_super
  					       ); 
END;
  