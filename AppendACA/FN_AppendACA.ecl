/**
 * Given a dataset and a set of fields describing cleaned address components,
 * attempt to match the those addresses with the ACA (prison) dataset and
 * append select attributes to the original file.  Appended fields may have
 * a custom prefix applied to their names.  The new dataset is returned.
 *
 * @param inFile                The dataset to process; REQUIRED.
 * @param primaryRangeField     The name of the field containing the primary
 *                              address range (street number); this is not a
 *                              string; REQUIRED.
 * @param primaryNameField      The name of the field containing the primary
 *                              name (street name); this is not a string;
 *                              REQUIRED.
 * @param addressSuffixField    The name of the field containing the address
 *                              suffix (e.g. "ST" "BLVD"); this is not a string;
 *                              REQUIRED.
 * @param preDirectionalField   The name of the field containing the pre-address
 *                              direction (e.g. "N" "SW"); this is not a string;
 *                              REQUIRED.
 * @param postDirectionalField  The name of the field containing the post-address
 *                              direction (e.g. "N" "SW"); this is not a string;
 *                              REQUIRED.
 * @param secondaryRangeField   The name of the field containing the secondary
 *                              range (apartment number, suite number); this is
 *                              not a string; REQUIRED.
 * @param cityField             The name of the field containing the city name;
 *                              this is not a string; REQUIRED.
 * @param stateField            The name of the field containing the two-;
 *                              character state abbreviation; this is not a
 *                              string; REQUIRED.
 * @param zip5Field             The name of the field containing the five-digit
 *                              zip code; this is not a string; REQUIRED.
 * @param appendPrefix          A string specifying a prefix to add to the
 *                              appended data fields; OPTIONAL, defaults to
 *                              an empty string.
 *
 * @return                      The modified dataset.
 */

EXPORT FN_AppendACA(inFile, primaryRangeField, primaryNameField, addressSuffixField, preDirectionalField, postDirectionalField, secondaryRangeField, cityField, stateField, zip5Field, appendPrefix = '\'\'') := FUNCTIONMACRO
    IMPORT AppendACA,ACA;

    LOCAL OutFileLayout := RECORD
        RECORDOF(inFile);
        STRING1     #EXPAND(appendPrefix + 'HitFound') := 'N';
        STRING200   #EXPAND(appendPrefix + 'Institution');
        STRING2     #EXPAND(appendPrefix + 'InstitutionType');
        STRING10    #EXPAND(appendPrefix + 'InstitutionTypeExp');
        STRING1     #EXPAND(appendPrefix + 'AddressType');
    END;

    LOCAL outFile := JOIN
        (
            inFile,
            PULL(ACA.key_aca_addr),
            LEFT.primaryNameField = RIGHT.prim_name
                AND LEFT.primaryRangeField = RIGHT.prim_range
                AND (LEFT.zip5Field != '' AND LEFT.zip5Field = RIGHT.zip)
                AND LEFT.secondaryRangeField = RIGHT.sec_range
                AND LEFT.addressSuffixField = RIGHT.addr_suffix
                AND LEFT.preDirectionalField = RIGHT.predir
                AND LEFT.postDirectionalField = RIGHT.postdir
                AND LEFT.cityField = RIGHT.p_city_name
                AND LEFT.stateField = RIGHT.st,
            TRANSFORM
                (
                    OutFileLayout,
                    SELF.#EXPAND(appendPrefix + 'HitFound') := IF(RIGHT.inst_type != '', 'Y','N'),
                    SELF.#EXPAND(appendPrefix + 'Institution') := RIGHT.Institution,
                    SELF.#EXPAND(appendPrefix + 'InstitutionType') := RIGHT.inst_type,
                    SELF.#EXPAND(appendPrefix + 'InstitutionTypeExp') := RIGHT.inst_type_exp,
                    SELF.#EXPAND(appendPrefix + 'AddressType') := RIGHT.addr_type,
                    SELF := LEFT
                ),
            LEFT OUTER, LOOKUP
        );

    RETURN outFile;
ENDMACRO;
