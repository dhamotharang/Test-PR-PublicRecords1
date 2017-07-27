Import Data_Services, doxie_files, doxie,ut,lib_stringlib,Lib_FileServices;

//f_sanctn_license := SANCTN.file_base_license(license_number != '');
f_sanctn_license := SANCTN.file_base_license(cln_license_number != '');
KeyName 			:= 'thor_data400::key::sanctn::';


layout_SANCTN_license_key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE];
END;

//modified to include non-NMLS records
f_sanctn_license_new := project(f_sanctn_license(NOT REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),nocase)), 
                                TRANSFORM(layout_SANCTN_license_key, SELF := LEFT));

EXPORT key_license_nbr  := index(f_sanctn_license_new
                                ,{CLN_LICENSE_NUMBER,LICENSE_STATE}
																,{f_sanctn_license_new}
																,Data_Services.Data_location.Prefix('sanctn')+KeyName +'license_nbr_'+doxie.Version_SuperKey);
																

