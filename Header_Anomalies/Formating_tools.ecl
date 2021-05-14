
// This function allows the user to display stats in proper format
// Refer to the code for place value examples

Export Formating_tools := Module


    Export String15 comma_format(Integer InVal ) := Function

      String14 comma_val := (String)InVal;

      num_len   := length(Trim(comma_val, All)); 

      comma_str := map(num_len <= 3 => comma_val,  // 100
                      num_len Between 3 And 4 =>
                      comma_val[0..1] + ',' + comma_val[2..5], // 1,000
                      num_len Between 4 And 5 =>
                      comma_val[1..2] + ',' + comma_val[3..5],  //10,000
                      num_len Between 5 And 6 =>
                      comma_val[1..3] + ',' + comma_val[4..6],   // 100,000
                      num_len Between 6 And 7 =>
                      comma_val[0..1] + ',' + comma_val[2..4] + ',' + comma_val[5..7], // 1,000,000
                      num_len Between 7 And 8 =>
                      comma_val[1..2] + ',' + comma_val[3..5] + ',' + comma_val[6..8], // 10,000,000
                      num_len Between 8 And 9 =>
                      comma_val[1..3] + ',' + comma_val[4..6] + ',' + comma_val[7..9], // 100,000,000
                      num_len Between 9 And 10 =>
                      comma_val[0..1] + ',' + comma_val[2..4] + ',' + comma_val[5..7] + ',' + comma_val[8..10], // 1,000,000,000
                      num_len Between 10 And 11 =>
                      comma_val[1..2] + ',' + comma_val[3..5] + ',' + comma_val[6..8] + ',' + comma_val[9..11], // 10,000,000,000
                      num_len Between 11 And 12 =>
                      comma_val[1..3] + ',' + comma_val[4..6] + ',' + comma_val[7..9] + ',' + comma_val[10..12], // 100,000,000,000                           
                      comma_val );
          
      curr_str :=  Trim(comma_str, all);
      Spaces  := 15 - length(curr_str) + 1;
      
      Return  Choose(Spaces,
                    curr_str,
                    ' ' + curr_str,
                    '  ' + curr_str,
                    '   ' + curr_str,
                    '    ' + curr_str,
                    '     ' + curr_str,
                    '      ' + curr_str,
                    '       ' + curr_str,
                    '        ' + curr_str,
                    '         ' + curr_str,
                    '          ' + curr_str );
    End;


    Export String date_format( Unsigned InVal ) := Function
      
      String date_val := (String)InVal;
      
      date_length := length(Trim(date_val, all));

      date_sep := if(date_length Between 7 And 8, date_val[1..6] + '/' + date_val[7..8], date_val[1..6] + '/' + date_val[7..8]);

      Return  date_sep;

    End;


End;