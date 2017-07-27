ds1 := DATASET('~thor400_84::in::tucs1', Transunion_PTrak.Layout_CP_Tucs_In, csv(separator('|'), terminator('\n')) );
ds2 := DATASET('~thor400_84::in::tucs2', Transunion_PTrak.Layout_CP_Tucs_In, csv(separator('|'), terminator('\n')) );
export File_cp_Transunion_Full_In := ds1 + ds2;