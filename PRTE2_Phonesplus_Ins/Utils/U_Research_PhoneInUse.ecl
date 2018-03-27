IMPORT ut;
// The DIDs being checked in here are the first 176 and the last 155 in the full spreadsheet.
// Got 100% success

KeyFileName := ut.foreign_prod+'prte::key::phonesplusv2::20160311::phone';

Layout_In_EclWatch := RECORD
  unsigned6 did;
END;
IndexFields := RECORD
  string7 p7;
  string3 p3;
  string6 dph_lname;
  string20 pfname;
  string2 st;
END;

prct_data_key := INDEX({IndexFields}, Layout_In_EclWatch, keyFileName);

// If we want to do this we need to turn it into two fields to match P7,P3
// phone_List := [
// 888809000000,
// 888809052178
// ];

// Count1 := COUNT(phone_List);
// Count2 := COUNT(prct_data_key(did in phone_List));
// OUTPUT('Comparing: '+count1+' / '+count2+' should be equal');
// output(prct_data_key(did in did_lst), all);

// TmpList := prct_data_key(p7[1..3] = '200' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..3] = '209' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..3] = '223' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..3] = '227' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..3] = '229' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..3] = '230' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..3] = '232' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..3] = '240' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..3] = '242' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..3] = '244' and P3 = '907');	// finds 0
// TmpList := prct_data_key(p7[1..4] = '2000' and P3 = '907');	// finds 0
// reality tests - these should find records
// TmpList := prct_data_key(p7[1..4] = '0000' and P3 = '531');			// finds 1
OUTPUT(COUNT(TmpList));
OUTPUT(TmpList);

