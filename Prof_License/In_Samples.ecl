import ut;

a := Set(Prof_License.InFile_Validate,state);

output(a,named('Updated_States'));

a1 := Prof_License.File_prolic_in( source_st in a and ut.DaysApart(ut.GetDate,date_last_seen) < 25 and ut.DaysApart(ut.GetDate,date_first_seen) < 25 ) : global;


EXPORT In_Samples := output(choosesets(a1,source_st = a[1] => 25 ,
                     source_st = a[2] => 25 ,
										 source_st = a[3] => 25 ,
										 source_st = a[4] => 25 ,
										 source_st = a[5] => 25 ,
										 source_st = a[6] => 25 ,
										 source_st = a[7] => 25 ,
										 source_st = a[8] => 25 ,
										 source_st = a[9] => 25 ,
										 source_st = a[10] => 25 ,
										 source_st = a[11] => 25 ,
										 source_st = a[12] => 25 ,
										 source_st = a[13] => 25 ,
										 source_st = a[14] => 25 ,
										 source_st = a[15] => 25 ),all) : independent;