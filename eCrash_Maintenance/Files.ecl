EXPORT Files := MODULE
	
  EXPORT Incident_Raw_SF := '~thor_data400::in::ecrash::incidnt_raw_new';
  EXPORT Incident_Raw_LF(STRING Suffix) := Incident_Raw_SF + '_' + Suffix + '_' + WORKUNIT;
	
  EXPORT Person_Raw_SF := '~thor_data400::in::ecrash::persn_raw';
  EXPORT Person_Raw_LF(STRING Suffix) := Person_Raw_SF + '_' + Suffix + '_' + WORKUNIT;
	
  EXPORT Citation_Raw_SF := '~thor_data400::in::ecrash::citatn_raw';
  EXPORT Citation_Raw_LF(STRING Suffix) := Citation_Raw_SF + '_' + Suffix + '_' + WORKUNIT;
	
  EXPORT Vehicle_Raw_SF := '~thor_data400::in::ecrash::vehicl_raw';
  EXPORT Vehicle_Raw_LF(STRING Suffix) := Vehicle_Raw_SF + '_' + Suffix + '_' + WORKUNIT;
	
  EXPORT Commercial_Raw_SF := '~thor_data400::in::ecrash::commercl_raw';
  EXPORT Commercial_Raw_LF(STRING Suffix) := Commercial_Raw_SF + '_' + Suffix + '_' + WORKUNIT;
	
  EXPORT PropertyDamage_Raw_SF := '~thor_data400::in::ecrash::propertydamage_raw';
  EXPORT PropertyDamage_Raw_LF(STRING Suffix) := PropertyDamage_Raw_SF + '_' + Suffix + '_' + WORKUNIT;
	
  EXPORT Document_Raw_SF := '~thor_data400::in::ecrash::document_raw';
  EXPORT Document_Raw_LF(STRING Suffix) := Document_Raw_SF + '_' + Suffix + '_' + WORKUNIT;

END;