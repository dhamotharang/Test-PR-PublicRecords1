IMPORT Risk_Indicators;

EXPORT CVI1909_1_0(INTEGER1 NAP_Summary, INTEGER1 NAS_Summary, STRING BaseCVI, 
                                          STRING verdob, STRING in_addr_type, STRING in_zipclass, STRING in_socsverlevel, 
                                          STRING9 in_ssn, BOOLEAN in_ssnExists, BOOLEAN in_lastssnmatch2) := FUNCTION
                                
        CustomCVITemp := MAP(
                BaseCVI = '00' => '00',
                BaseCVI = '10' => '10',
                Risk_Indicators.rcSet.isCodePO(in_addr_type) => '10',
                Risk_Indicators.rcSet.isCode12(in_zipclass) => '10',
                NAS_Summary IN [10, 11, 12] AND verdob = 'Y' => '80',
                NAS_Summary IN [10, 11, 12] AND verdob = 'N' => '70',
                NAP_Summary IN [3, 5, 8, 10, 11, 12] AND verdob = 'Y' => '61', 
                NAS_Summary IN [3, 5, 8] AND verdob = 'Y' => '60',
                NAS_Summary IN [4, 7, 9] AND verdob = 'Y' => '50',
                NAS_Summary IN [4, 9] AND NAP_Summary IN [3, 8, 10, 12] => '42',
                NAS_Summary IN [7, 9] AND NAP_Summary IN [5, 8, 11, 12] => '41',
                NAS_Summary = 6 AND NAP_Summary IN [10, 11, 12] => '40',
                '20');
 
        FinalCVI := IF(CustomCVITemp IN ['40', '41', '42', '50', '70'] AND Risk_Indicators.rcSet.isCode72(in_socsverlevel, in_SSN, in_ssnExists, in_lastssnmatch2), '30', CustomCVITemp);

        RETURN FinalCVI;
        
END;