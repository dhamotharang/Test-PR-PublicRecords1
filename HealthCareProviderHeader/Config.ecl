EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT MatchThreshold := 45;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
// Configuration of individual fields
EXPORT SSN_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT DOB_Force := 3; 
EXPORT SNAME_Force := 0; 
EXPORT FNAME_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT DERIVED_GENDER_Force := 0; 
EXPORT C_LIC_NBR_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT UPIN_Force := 0; 
EXPORT NPI_NUMBER_Force := 0; 
EXPORT DEA_NUMBER_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT VENDOR_ID_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT LIC_TYPE_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT MAINNAME_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT FULLNAME_Force := -3; 
END;
