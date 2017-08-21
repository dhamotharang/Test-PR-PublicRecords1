import lib_fileservices, std;

export Compute_Statistics :=  module

    // ******************************************************************************************
    // The following grouping is designed to construct a log message that continually appends to 
    // the output result. In this case it is used for the grouping of dataset counts.
    // ******************************************************************************************
    export LoggingRecord := record
        string80    _logDescription;
        integer     _count;
     end;

    export reportLogMsg(string80 _logDescription, integer _count, string LogName) := 
        output(dataset([{_logDescription, _count}], LoggingRecord), named (LogName), extend);
 
    // ******************************************************************************************
    // The input file can have cpt codes that do not have leading zeros. However, the old file
    // does have them. This function normalizes the cpt codes that are less than a full 5 digits
    // of data to add the leading zeros to it.
    // ******************************************************************************************
    export normalizeCptInput (string InputCode) := function
        // Strip away any of the spaces - basically all of the inputs look like the full size regardless
        adjustedCode := trim(InputCode, left, right); 

        // Now compute the adjusted string length 
        stringLength   := length(adjustedCode);

        // Check the filtered length and add the appropriate number of preceding zeros
        modifiedCode := if (stringLength = 5,   
                            InputCode,
                            case(stringLength, 1 =>  '0000' + InputCode,
                                               2 =>  '000'  + InputCode,
                                               3 =>  '00'   + InputCode,
                                               4 =>  '0'    + InputCode,
                                               InputCode));

        return modifiedCode;
    end;
  
end;