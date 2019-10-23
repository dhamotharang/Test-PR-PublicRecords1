EXPORT custom_dedup_filesread(

   pFiles
  ,pRegexToken  = '\'^.*?(base|out)::(.*?)(::|_w|_0010_header|_5600_demo|_5610_demo|_nixie|_verified).*$\''
  
) :=
functionmacro

  ds_prep := project(pfiles,transform({recordof(left),string build_token,string version,string sortfield}
    ,self.build_token := regexfind(pRegexToken,left.name,2)
    ,self.version     := regexfind('[[:digit:]]{8}[[:alpha:]]?',left.name,0) 
    ,self.name        := left.name
    ,self.sortfield   := (string)(100000000 - (unsigned)self.version[1..8])
  ));

  return sort(dedup(sort(ds_prep(build_token != 'liens'),build_token,version),build_token,version)
    + dedup(sort(ds_prep(build_token = 'liens'),build_token,-version),build_token)
    ,sortfield,name)
  ;
  
endmacro;

// thor_data400::base::ebr_0010_header_aid_w20151130-113144
// thor_data400::base::ebr_5600_demographic_data_w20151130-113144

// thor_data400::base::ska_nixie_w20151201-003220
// thor_data400::base::ska_verified_w20151201-003220
