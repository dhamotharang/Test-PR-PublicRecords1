IMPORT Scrubs;

EXPORT Fn_Scrubs_PassFail(STRING pVersion) := FUNCTION 

    RETURN IF(
        SCRUBS.mac_ScrubsFailureTest('Scrubs_IDA_RawInput', pVersion)
        ,OUTPUT('Scrubs passed all tests')
        ,FAIL('Build Stopped before base file due to Scrubs Errors. See output in Orbit profile: Scrubs_IDA_RawInput')
    );
END;