IMPORT DueDiligence;


EXPORT getInputBest(DATASET(DueDiligence.v3Layouts.DDInput.PersonSearch) inData,
                    STRING10 ssnMask) := FUNCTION


    RETURN DATASET([], DueDiligence.v3Layouts.InternalPersonSupp.PersonResults);
END;