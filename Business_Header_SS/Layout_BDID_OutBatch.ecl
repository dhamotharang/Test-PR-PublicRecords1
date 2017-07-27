EXPORT Layout_BDID_OutBatch := RECORD
    unsigned6 BDID := 0;
    unsigned2 score := 0;
    Layout_BDID_InBatch;
    Layout_Best_Append;
END;