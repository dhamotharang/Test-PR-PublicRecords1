EXPORT Functions_C := MODULE
    Export UNSIGNED4 BusName_PrefixMatchCount(STRING a, STRING b) := BEGINC++
        unsigned int    minLength = lenA < lenB ? lenA : lenB;
        unsigned int    numMatched = 0;

        for (numMatched = 0; numMatched < minLength; numMatched++)
        {
            if (a[numMatched] != b[numMatched])
            {
                break;
            }
        }

        return numMatched;
    ENDC++;
END; // Module

//******************************************************************************

