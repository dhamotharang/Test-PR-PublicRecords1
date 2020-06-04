EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := false; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT MatchThreshold := 40;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
// Configuration of individual fields
EXPORT sbfe_id_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT Lgid3IfHrchy_Force := 0; 
EXPORT company_name_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT cnp_number_Force := 0; 
EXPORT cnp_number_OR1_sbfe_id_Force := 0;
EXPORT active_duns_number_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT duns_number_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT duns_number_concept_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT company_fein_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT company_inc_state_Force := 0; 
EXPORT company_inc_state_OR1_active_duns_number_Force := 0;
EXPORT company_inc_state_OR2_duns_number_Force := 0;
EXPORT company_inc_state_OR3_duns_number_concept_Force := 0;
EXPORT company_inc_state_OR4_company_fein_Force := 0;
EXPORT company_inc_state_OR5_sbfe_id_Force := 0;
END;
