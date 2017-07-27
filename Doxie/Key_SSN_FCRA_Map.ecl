// New data for ssn issue date/state;
// Probably, references to base/key files/attributes will be changed eventually
// (now they're refer to "...ssnissue2..."
import header, doxie, ut;

df := header.File_SSN_Map (ssn5!= '');

export Key_SSN_FCRA_Map := index (df, {ssn5, start_serial, end_serial}, {df},
  '~thor_data400::key::ssnissue2::fcra::' + doxie.Version_SuperKey + '::ssn5');