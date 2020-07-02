export string Counts_Translation(UNSIGNED cnt) := FUNCTION

AdjustCountNumber(unsigned cnt):=
                          MAP(cnt=0 => 0,
                              cnt<5 =>1,
                              cnt<50 =>cnt-cnt%5,
                              cnt<100 =>cnt-cnt%10,
                              cnt<500 =>cnt-cnt%50,
                              cnt-cnt%100);


    adjustedNumber := AdjustCountNumber(cnt);
    return MAP (adjustedNumber=0 =>'none found',
                adjustedNumber=1 => 'less than 5',
                'approximately ' + adjustedNumber);

END;
