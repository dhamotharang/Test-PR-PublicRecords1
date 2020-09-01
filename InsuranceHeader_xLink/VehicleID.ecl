LAYOUT :=   {unsigned8 DID;
  string25 vin;
  string25 fname;
  unsigned4 last_seen_date;
  unsigned4 first_seen_date;};

BOOLEAN isCustTestEnv := FALSE:STORED('CustomerTestEnv');
BOOLEAN isIncremental := FALSE:STORED('IsIncrementalBuild'); 
BOOLEAN isSpecificities := FALSE:STORED('isSpecificitiesBuild');
EXPORT VehicleID := dataset([], layout);
