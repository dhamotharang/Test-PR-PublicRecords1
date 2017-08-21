import ut; 
export BaseFile_Iyetek := dataset(ut.foreign_prod+'~thor_data400::base::Iyetek_metadata',FLAccidents_Ecrash.Layout_metadata.base,thor) (trim(incident_id,left,right) not in  Suppress_iyetek); 
