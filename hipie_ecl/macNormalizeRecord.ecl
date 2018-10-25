//==================================================================================
/*
	Author: Dan Camper
*/

/*
fieldMapStr := 'new1=old1A|old1B,new2=old2A|old2B';

example usage:

ds := DATASET('~file', DataRec, FLAT);

fieldMap := 'first_name=first_name_1|first_name_2|first_name_3|first_name_4|first_name_5|first_name_6|first_name_7|first_name_8|first_name_9|first_name_10'
            + ',middle_name=middle_name_1|middle_name_2|middle_name_3|middle_name_4|middle_name_5|middle_name_6|middle_name_7|middle_name_8|middle_name_9|middle_name_10'
            + ',last_name=last_name_1|last_name_2|last_name_3|last_name_4|last_name_5|last_name_6|last_name_7|last_name_8|last_name_9|last_name_10'
            + ',ssn=ssn_1|ssn_2|ssn_3|ssn_4|ssn_5|ssn_6|ssn_7|ssn_8|ssn_9|ssn_10';


r10 := FN_NormalizeRecord
    (
        ds,
        fieldMap,
        'dea_number = \'\''
    );
*/

export macNormalizeRecord(inFile, fieldMapStr, skipFilter = '\'\'', keepOldFields='false') := FUNCTIONMACRO
    IMPORT Std;
    LOADXML('<xml/>');
    #UNIQUENAME(recid)
    #DECLARE(fieldPos)
    #DECLARE(oldFieldName)
    #DECLARE(newFieldName)
    #DECLARE(allOldFields)
    #DECLARE(tempText)
    #DECLARE(loopCounter)
    #DECLARE(numOldFields)
    #DECLARE(maxNumOldFields)

    // Append unique record numbers that we'll use
    LOCAL MyRec := RECORD
        UNSIGNED8   %recid%;
        RECORDOF(inFile);
    END;

    LOCAL myInFile := PROJECT
        (
            DISTRIBUTE(inFile),
            TRANSFORM
                (
                    MyRec,
                    SELF.%recid% := ((COUNTER - 1) * Std.System.Thorlib.Nodes()) + Std.System.Thorlib.Node() + COUNTER,
                    SELF := LEFT
                ),
            LOCAL
        );
				
    #DECLARE(fieldlist)
    #DECLARE(mycount)
    #SET(fieldlist  ,',' + regexreplace(',',REGEXREPLACE('\\|', REGEXREPLACE('^\\|', REGEXREPLACE(',?\\w+=', fieldMapStr, '|'), ''), ','),',,',nocase) + ',')//REGEXREPLACE('\\|', REGEXREPLACE('^\\|', REGEXREPLACE(',?\\w+=', fieldMapStr, '|'), ''), ','))
    #SET(mycount  ,0)
    #LOOP
      #IF(%mycount% > 20 or (not regexfind('^(.*?)([,]\\w+[,])(.*?)\\g2(.*)$',%'fieldlist'%,nocase))  )
        #BREAK
      #END
      
      #SET(fieldlist , regexreplace('^(.*?)([,]\\w+[,])(.*?)\\g2(.*)$',%'fieldlist'% ,'$1$2$3$4'))
      #SET(mycount  ,%mycount% + 1)
      
    #END

    LOCAL oldFieldList_prep := trim(regexreplace(',,',%'fieldlist'%,','));

    LOCAL oldFieldList := oldFieldList_prep[2..(length(trim(oldFieldList_prep)) - 1)];

    // Define final record structure
    LOCAL FinalRec := RECORD
        RECORDOF(myInFile) #IF(~keepOldFields)  - [#EXPAND(oldFieldList)] #END;

        #SET(fieldPos, 1)
        #LOOP
            #SET(newFieldName, REGEXFIND('(^|,)([a-z_0-9]+)', fieldMapStr[%fieldPos%..], 2, NOCASE))
            #IF (%'newFieldName'% != '')
                #SET(oldFieldName, REGEXFIND('(^|,)[a-z_0-9]+=([a-z_0-9]+)', fieldMapStr[%fieldPos%..], 2, NOCASE))

                TYPEOF(inFile.%oldFieldName%)       %newFieldName%;

                #SET(tempText, REGEXFIND('(^|,)[a-z_0-9]+=([a-z_0-9|]+)', fieldMapStr[%fieldPos%..], 0, NOCASE))
                #SET(fieldPos, %fieldPos% + LENGTH(%'tempText'%) + 1)
            #ELSE
                #BREAK
            #END
        #END
    END;

    // Normalize transformation
    LOCAL FinalRec MakeFinalRec(RECORDOF(myInFile) l, UNSIGNED2 c) := TRANSFORM
        #SET(fieldPos, 1)
        #SET(maxNumOldFields, 0)
        #LOOP
            #SET(newFieldName, REGEXFIND('(^|,)([a-z_0-9]+)', fieldMapStr[%fieldPos%..], 2, NOCASE))
            #IF (%'newFieldName'% != '')
                #SET(allOldFields, REGEXREPLACE('\\|', REGEXFIND('=([a-z_0-9|]+)', fieldMapStr[%fieldPos%..], 1, NOCASE), ' '))
                #SET(numOldFields, Std.Str.CountWords(%'allOldFields'%, ' '))
                #SET(maxNumOldFields, MAX(%maxNumOldFields%, %numOldFields%))

                SELF.%newFieldName% := CHOOSE
                    (
                        c,
                        #SET(loopCounter, 1)
                        #LOOP
                            #IF(%loopCounter% <= %numOldFields%)
                                #SET(oldFieldName, Std.Str.GetNthWord(%'allOldFields'%, %loopCounter%))

                                (TYPEOF(FinalRec.%newFieldName%))l.%oldFieldName%,

                                #SET(loopCounter, %loopCounter% + 1)
                            #ELSE
                                // Default final value, NULL in whatever data format we need
                                (TYPEOF(FinalRec.%newFieldName%))''
                                #BREAK
                            #END
                        #END
                    );

                #SET(tempText, REGEXFIND('(^|,)[a-z_0-9]+=([a-z_0-9|]+)', fieldMapStr[%fieldPos%..], 0, NOCASE))
                #SET(fieldPos, %fieldPos% + LENGTH(%'tempText'%) + 1)
            #ELSE
                #BREAK
            #END
        #END

        SELF := l;
    END;

    LOCAL processedResults := NORMALIZE
        (
            myInFile,
            %maxNumOldFields%,
            MakeFinalRec(LEFT, COUNTER)
        );

    // Apply a skip filter if one was applied; note that a skip filter
    // might remove all original records, so we need to take care
    // to add those records back into the result
    #IF(skipFilter != '')
        LOCAL filteredResults := processedResults(~(#EXPAND(skipFilter)));

        LOCAL filteredOutResults := JOIN
            (
                DISTRIBUTE(myInFile, HASH32(%recid%)),
                DISTRIBUTE(filteredResults, HASH32(%recid%)),
                LEFT.%recid% = RIGHT.%recid%,
                TRANSFORM
                    (
                        FinalRec,
                        SELF := LEFT,
                        SELF := []
                    ),
                LOCAL, LEFT ONLY
            );

        LOCAL keepResults := filteredResults + filteredOutResults;
    #ELSE
        LOCAL keepResults := processedResults;
    #END

    // Rewrite the result, removing our temporary record ID
    LOCAL results := PROJECT
        (
            keepResults,
            TRANSFORM
                (
                    RECORDOF(keepResults) - [%recid%],
                    SELF := LEFT
                ),
            LOCAL
        );

    RETURN results;
ENDMACRO;