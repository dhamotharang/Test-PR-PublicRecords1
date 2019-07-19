// New data for ssn issue date/state;
// Probably, references to base/key files/attributes will be changed eventually
// (now they're refer to "...ssnissue2..."
import header, doxie, data_services, vault, _control
;

df := header.File_SSN_Map (ssn5!= '');

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_SSN_FCRA_Map := vault.doxie.Key_SSN_FCRA_Map;

#ELSE
export Key_SSN_FCRA_Map := index (df, 
                                  {ssn5, start_serial, end_serial}, 
                                  {df},
                                  data_services.data_location.prefix() + 'thor_data400::key::ssnissue2::fcra::' + doxie.Version_SuperKey + '::ssn5');


#END;

