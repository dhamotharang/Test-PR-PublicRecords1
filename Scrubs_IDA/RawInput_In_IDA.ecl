IMPORT Scrubs_IDA;

Export RawInput_In_IDA := DATASET('~thor_data400::in::clean::ida::built',Scrubs_IDA.RawInput_Layout_IDA,csv(heading(1), separator('|'),terminator(['\n', '\r\n']), quote('"')));

