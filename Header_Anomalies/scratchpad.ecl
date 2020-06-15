Import STD;


// val  := 100;
// val1 := 1000;
// val2 := 10000;
// val3 := 100000;
// val4 := 1000000;
// val5 := 10000000;
// val6 := 100000000;
// val7 := 1000000000;
// val8 := 10000000000;
// val9 := 100000000000;


// String15 comma_format(Integer InVal ) := Function

//   String14 comma_val := (String)InVal;

//   num_len   := length(Trim(comma_val, All)); 

//   comma_str := map(num_len <= 3 => comma_val,  // 100
//                   num_len Between 3 And 4 =>
//                   comma_val[0..1] + ',' + comma_val[2..5], // 1,000
//                   num_len Between 4 And 5 =>
//                   comma_val[1..2] + ',' + comma_val[3..5],  //10,000
//                   num_len Between 5 And 6 =>
//                   comma_val[1..3] + ',' + comma_val[4..6],   // 100,000
//                   num_len Between 6 And 7 =>
//                   comma_val[0..1] + ',' + comma_val[2..4] + ',' + comma_val[5..7], // 1,000,000
//                   num_len Between 7 And 8 =>
//                   comma_val[1..2] + ',' + comma_val[3..5] + ',' + comma_val[6..8], // 10,000,000
//                   num_len Between 8 and 9 =>
//                   comma_val[1..3] + ',' + comma_val[4..6] + ',' + comma_val[7..9], // 100,000,000
//                   num_len Between 9 And 10 =>
//                   comma_val[0..1] + ',' + comma_val[2..4] + ',' + comma_val[5..7] + ',' + comma_val[8..10], // 1,000,000,000
//                   num_len Between 10 And 11 =>
//                   comma_val[1..2] + ',' + comma_val[3..5] + ',' + comma_val[6..8] + ',' + comma_val[9..11], // 10,000,000,000
//                   num_len Between 11 and 12 =>
//                   comma_val[1..3] + ',' + comma_val[4..6] + ',' + comma_val[7..9] + ',' + comma_val[10..12], // 100,000,000,000                           
//                   comma_val );

                  
//   curr_str :=  Trim(comma_str, all);
//   Spaces  := 15 - length(curr_str) + 1;
//   Return  Choose(Spaces,
//                  curr_str,
//                  ' ' + curr_str,
//                  '  ' + curr_str,
//                  '   ' + curr_str,
//                  '    ' + curr_str,
//                  '     ' + curr_str,
//                  '      ' + curr_str,
//                  '       ' + curr_str,
//                  '        ' + curr_str,
//                  '         ' + curr_str,
//                  '          ' + curr_str );
// End;

// num  := comma_format(val);
// num1 := comma_format(val1);
// num2 := comma_format(val2);
// num3 := comma_format(val3);
// num4 := comma_format(val4);
// num5 := comma_format(val5);
// num6 := comma_format(val6);
// num7 := comma_format(val7);
// num8 := comma_format(val8);
// num9 := comma_format(val9);



// output(num);
// output(num1);
// output(num2);
// output(num3);
// output(num4);
// output(num5);
// output(num6);
// output(num7);
// output(num8);
// output(num9);

personRecord := RECORD
  Unsigned dob;
END;

personDataset := Dataset([{19871010},
                          {19881111},
                          {20080926},
                          {20150222}], personRecord);

outPersonRecord := RECORD
  String dob_string;
END;


outPersonRecord distSlim( personDataset Le ) := Transform
  val := Le.dob;
  val_string := (>String<) val;
  Self.dob_string :=  STD.Date.ConvertDateFormat(val_string, '%m%d')
End;

result_normdist := Project(personDataset, distSlim(Left));


// t1_dob := Table(result_normdist, {dob}, dob);

// t2_dob := Table(t1_dob, {dob, lexid_count := comma_format(Count(Group))}, dob );

// normal_distribution := Sort(t2_dob, -lexid_count );

output(result_normdist);