EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT MatchThreshold := 37;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT LinkpathCandidateCount := 50; // Number of candidates to consider from each linkpath in batch. Higher = better result and slower execution.
// Configuration of individual fields
EXPORT cnp_name_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT company_url_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
END;
