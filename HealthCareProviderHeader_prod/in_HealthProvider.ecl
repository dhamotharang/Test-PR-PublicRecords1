import HealthCareProvider;

string hdrIteration_filebase  := '~temp::lnpid::healthcareproviderheader_prod::';
string hdrIteration_filename  := 'it_source';
string hdrIteration_filepath  := hdrIteration_filebase + hdrIteration_filename : STORED('hdrIteration_filepath');
    
oldlayout_HealthProvider := HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header;

in_HealthProvider1 	  := DATASET(hdrIteration_filepath, layout_HealthProvider, THOR);
// in_HealthProvider2    := PROJECT(in_HealthProvider1, layout_HealthProvider);
// in_HealthProvider2    := PROJECT(in_HealthProvider1,
  // TRANSFORM(RECORDOF(LEFT),
    // SELF.DOB := IF(LEFT.SRC <> 'SJ',
                   // LEFT.DOB,
                   // IF(REGEXFIND('^[0-9][0-9][0-9][0-9]0101$', (string)LEFT.dob),
                      // (TYPEOF(LEFT.dob))(((string)LEFT.dob)[1..4] + '0000'),
                      // LEFT.dob)), 
    // SELF     := LEFT),
    // LOCAL);
  
EXPORT in_HealthProvider  := in_HealthProvider1;