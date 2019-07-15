//S44
BIPV2_Files.files_ingest.ds_as_linking                  ; //source ingest
BIPV2_Files.files_ingest.DS_BUILDING                    ; //prepingest
BIPV2_Files.files_ingest.DS_BASE                        ; //runingest
BIPV2_Files.files_dotid().DS_BASE                       ; //dotid
BIPV2_Proxid.files().base.built                         ; //proxid
BIPV2_Files.files_proxid().DS_PROXID_BUILT              ; //final proxid output file
BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING ; //hrchy
BIPV2_Files.files_lgid3.DS_BASE                         ; //lgid3 base
BIPV2_Files.files_powid_down.DS_BASE                    ; //powid down base
BIPV2_Files.files_powid().DS_BASE                       ; //powid up base
BIPV2_Files.files_empid_down().DS_BASE                  ; //empid down base
bipv2.CommonBase.ds_built                               ; //commonbase

//S43
dataset('~thor_data400::base::bipv2::father::source_ingest::data', BIPV2.Layout_Business_Linking_Full, thor);; //source ingest
BIPV2_Files.files_ingest.DS_FATHER                                                                          ; //prepingest
BIPV2_Files.files_ingest.DS_FATHER                                                                          ; //runingest
BIPV2_Files.files_dotid().DS_FATHER                                                                         ; //dotid
BIPV2_Proxid.files().base.qa                                                                                ; //proxid
BIPV2_Files.files_proxid().DS_PROXID_BASE                                                                   ; //final proxid output file
BIPv2_HRCHY.Files().base.qa                                                                                 ; //hrchy
BIPV2_Files.files_lgid3.DS_FATHER                                                                           ; //lgid3 base
BIPV2_Files.files_powid_down.DS_FATHER                                                                      ; //powid down base
BIPV2_Files.files_powid().DS_FATHER                                                                         ; //powid up base
BIPV2_Files.files_empid_down().DS_FATHER                                                                    ; //empid down base
bipv2.CommonBase.ds_base                                                                                    ; //commonbase

//S42
dataset('~thor_data400::base::bipv2::GRANDFATHER::source_ingest::data', BIPV2.Layout_Business_Linking_Full, thor);                  ; //source ingest
BIPV2_Files.files_ingest.DS_GRANDFATHER                    ; //prepingest
BIPV2_Files.files_ingest.DS_GRANDFATHER                        ; //runingest
BIPV2_Files.files_dotid().DS_GRANDFATHER                       ; //dotid
BIPV2_Proxid.files().base.father                         ; //proxid
BIPV2_Files.files_proxid().DS_PROXID_FATHER              ; //final proxid output file
BIPv2_HRCHY.Files().base.father ; //hrchy
BIPV2_Files.files_lgid3.DS_GRANDFATHER                         ; //lgid3 base
BIPV2_Files.files_powid_down.DS_GRANDFATHER                    ; //powid down base
BIPV2_Files.files_powid().DS_GRANDFATHER                       ; //powid up base
BIPV2_Files.files_empid_down().DS_GRANDFATHER                  ; //empid down base
bipv2.CommonBase.ds_father                               ; //commonbase