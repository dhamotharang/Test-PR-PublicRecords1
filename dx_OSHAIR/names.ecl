IMPORT tools; 
  
EXPORT Names(
  STRING  pversion       = ''
 ,BOOLEAN pUseOtherEnvironment = FALSE
) :=
MODULE

 SHARED lkeyTemplate                       := constants(pUseOtherEnvironment).oldkeyTemplate;
 
 EXPORT bdid                               := lkeyTemplate + '::bdid_qa';
 EXPORT linkids                            := lkeyTemplate + '::linkids_qa';
 EXPORT inspection                         := lkeyTemplate + '::inspection_qa';
 EXPORT program                            := lkeyTemplate + '::program_qa';
 EXPORT related_activity                   := lkeyTemplate + '::related_activity_qa';
 EXPORT optional_info                      := lkeyTemplate + '::optional_info_qa';
 EXPORT violations                         := lkeyTemplate + '::violations_qa';
 EXPORT hazardous_substance                := lkeyTemplate + '::hazardous_substance_qa';
 EXPORT accident                           := lkeyTemplate + '::accident_qa';
 
 EXPORT delta_rid_inspection               := lkeyTemplate + '::inspection::delta_rid_qa';
 EXPORT delta_rid_accident                 := lkeyTemplate + '::accident::delta_rid_qa';
 EXPORT delta_rid_hazardous_substance      := lkeyTemplate + '::hazardous_substance::delta_rid_qa';
 EXPORT delta_rid_violations               := lkeyTemplate + '::violations::delta_rid_qa';
 EXPORT delta_rid_program                  := lkeyTemplate + '::program::delta_rid_qa';
 EXPORT delta_rid_autokey_payload          := lkeyTemplate + '::autokey_payload::delta_rid_qa';
 
 EXPORT bdid_new                           := lkeyTemplate + '::' + pversion + '::bdid';
 EXPORT linkids_new                        := lkeyTemplate + '::' + pversion + '::linkids';
 EXPORT inspection_new                     := lkeyTemplate + '::' + pversion + '::inspection';
 EXPORT program_new                        := lkeyTemplate + '::' + pversion + '::program';
 EXPORT related_activity_new               := lkeyTemplate + '::' + pversion + '::related_activity';
 EXPORT optional_info_new                  := lkeyTemplate + '::' + pversion + '::optional_info';
 EXPORT violations_new                     := lkeyTemplate + '::' + pversion + '::violations';
 EXPORT hazardous_substance_new            := lkeyTemplate + '::' + pversion + '::hazardous_substance';
 EXPORT accident_new                       := lkeyTemplate + '::' + pversion + '::accident';
  
 EXPORT delta_rid_inspection_new           := lkeyTemplate + '::' + pversion + '::inspection::delta_rid';
 EXPORT delta_rid_accident_new             := lkeyTemplate + '::' + pversion + '::accident::delta_rid';
 EXPORT delta_rid_hazardous_substance_new  := lkeyTemplate + '::' + pversion + '::hazardous_substance::delta_rid';
 EXPORT delta_rid_violations_new           := lkeyTemplate + '::' + pversion + '::violations::delta_rid';
 EXPORT delta_rid_program_new              := lkeyTemplate + '::' + pversion + '::program::delta_rid';
 EXPORT delta_rid_autokey_payload_new      := lkeyTemplate + '::' + pversion + '::autokey_payload::delta_rid';

END;
