IMPORT Scrubs_IDA;

Export RawInput_In_IDA := DATASET('~thor_data400::in::ida::all',Scrubs_IDA.RawInput_Layout_IDA,CSV(HEADING(1),SEPARATOR('|')));

