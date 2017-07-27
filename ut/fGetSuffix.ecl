EXPORT fGetSuffix(string SuffixIn)	:= function
setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
return		map(SuffixIn = '1' => 'I'
						,SuffixIn in ['2','ND'] => 'II'
						,SuffixIn in ['3','RD'] => 'III'
						,SuffixIn = '4' => 'IV'
						,SuffixIn = '5' => 'V'
						,SuffixIn = '6' => 'VI'
						,SuffixIn = '7' => 'VII'
						,SuffixIn = '8' => 'VIII'
						,SuffixIn = '9' => 'IX'
            ,SuffixIn = 'IIII' => 'IV'
						,SuffixIn in setValidSuffix => SuffixIn
						,'');
END;
