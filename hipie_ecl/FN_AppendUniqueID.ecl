/**
 * Append a unique numeric record identifier to a dataset.  The new dataset
 * is returned.
 *
 * @param inFile                The dataset to process; REQUIRED.
 * @param startingID            The minimum record identifier to assign;
 *                              OPTIONAL; defaults to 1.
 * @param strictlySequential    If TRUE, the assigned IDs will be in numerically
 *                              increasing order; if FALSE, the assigned IDs
 *                              will be unique but there may be gaps,
 *                              depending on how the records are distributed;
 *                              OPTIONAL; defaults to FALSE.
 * @param appendPrefix          A string specifying a prefix to add to the
 *                              appended 'RecID' field; OPTIONAL, defaults to
 *                              an empty string.
 *
 * @return                      A new dataset with the appended unique identifer
 *                              field.
 */

EXPORT FN_AppendUniqueID(inFile, startingID = 1, strictlySequential = FALSE, appendPrefix = '\'\'') := FUNCTIONMACRO
    IMPORT Std;

    // Definition of result layout
    LOCAL ResultRec := RECORD
        RECORDOF(inFile);
        UNSIGNED6   #EXPAND(appendPrefix + 'RecID');
    END;

    //--------------------------------------------------------------------------
    // Assign sequential values for only a few records
    //--------------------------------------------------------------------------

    LOCAL seqFew := PROJECT
        (
            inFile,
            TRANSFORM
                (
                    ResultRec,
                    SELF.#EXPAND(appendPrefix + 'RecID') := startingID + COUNTER - 1,
                    SELF := LEFT
                )
        );

    //--------------------------------------------------------------------------
    // Assign sequential values for many records
    //--------------------------------------------------------------------------

    #UNIQUENAME(nodeNum);
    #UNIQUENAME(nodeCount);
    #UNIQUENAME(nodeOffset);

    LOCAL ResultRecWithNode := RECORD
        ResultRec;
        UNSIGNED4   %nodeNum%;
    END;

    // Append zero-value RecID value and the Thor node number to each record
    LOCAL inFileWithNodeNum := PROJECT
        (
            inFile,
            TRANSFORM
                (
                    ResultRecWithNode,
                    SELF.#EXPAND(appendPrefix + 'RecID') := 0,
                    SELF.%nodeNum% := Std.System.Thorlib.Node(),
                    SELF := LEFT
                ),
            LOCAL
        );

    // Count the number of records on each node
    LOCAL recCountsPerNode := TABLE
        (
            inFileWithNodeNum,
            {
                UNSIGNED4   %nodeNum% := Std.System.Thorlib.Node(),
                UNSIGNED6   %nodeCount% := COUNT(GROUP),
                UNSIGNED6   %nodeOffset% := 0
            },
            LOCAL
        );

    // Compute the node offset, which is the minimum RecID value for any
    // record on that node
    LOCAL nodeOffsets := ITERATE
        (
            recCountsPerNode,
            TRANSFORM
                (
                    RECORDOF(recCountsPerNode),
                    SELF.%nodeOffset% := IF(COUNTER = 1, startingID, LEFT.%nodeOffset% + LEFT.%nodeCount%),
                    SELF:=RIGHT
                )
        );

    // Append the node offset to the data
    LOCAL inFileWithOffsets := JOIN
        (
            inFileWithNodeNum,
            nodeOffsets,
            LEFT.%nodeNum% = RIGHT.%nodeNum%,
            MANY LOOKUP
        );

    // Iterate through the records on each node, computing the RecID value
    LOCAL inFileSequenced := ITERATE
        (
            inFileWithOffsets,
            TRANSFORM
                (
                    RECORDOF(inFileWithOffsets),
                    SELF.#EXPAND(appendPrefix + 'RecID') := IF(LEFT.%nodeNum% = RIGHT.%nodeNum%, LEFT.#EXPAND(appendPrefix + 'RecID') + 1, RIGHT.%nodeOffset%),
                    SELF := RIGHT
                ),
            LOCAL
        );

    // Put the data in its final form
    LOCAL seqMany := PROJECT
        (
            inFileSequenced,
            TRANSFORM
                (
                    ResultRec,
                    SELF := LEFT
                ),
            LOCAL);

    //--------------------------------------------------------------------------
    // Assign unique values, not necessarily sequential
    //--------------------------------------------------------------------------

    LOCAL uniq := PROJECT
        (
            inFile,
            TRANSFORM
                (
                    ResultRec,
                    SELF.#EXPAND(appendPrefix + 'RecID') := ((COUNTER - 1) * Std.System.Thorlib.Nodes()) + Std.System.Thorlib.Node() + startingID + COUNTER - 1,
                    SELF := LEFT
                ),
            LOCAL
        );

    //--------------------------------------------------------------------------
    // Create resulting dataset using a method dependent on the strictness
    // of the RecID value and the size of the input
    //--------------------------------------------------------------------------

    LOCAL result := IF
        (
            strictlySequential,
            IF
                (
                    COUNT(inFile) >= 1000000,
                    seqMany,
                    seqFew
                ),
            uniq
        );

    RETURN result;
ENDMACRO;
