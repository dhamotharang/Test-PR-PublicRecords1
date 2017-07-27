export CID_Converter(ebcdic string1 cid_data) := case(stringlib.data2string((data)cid_data),
'15' => '85',
'25' => '0A',
'4A' => '5B',
'4F' => '21',
'5A' => '5D',
'AD' => 'DD',
'B0' => 'A2',
'BA' => 'AC',
'BB' => '7C',
'BD' => 'A8',
stringlib.data2string((data)(string)cid_data));


/*myRec := record
 ebcdic string1 inByte;
 string1 outByte;
 string2 ebcdic_number;
 string2 ascii_number;
 string1 eol;
end;

export Cid_Converter := dataset('~thor_data400::in::ebcdic_table',myRec,flat);*/