//This function returns the text description of the corresponding Threat Metrix reason code
Import STD;

EXPORT getTMX_reasons(STRING5 rc) := Function

  Desc := Case(STD.STR.ToUpperCase(trim(rc)),
               'DI00' => 'High velocity of LexisNexis Digital Identity Network events for the input phone',
               'DI01' => 'Multiple unique emails found with input phone in the LexisNexis Digital Identity Network',
               'DI02' => 'Multiple unique devices found with input phone in the LexisNexis Digital Identity Network',
               'DI03' => 'Multiple unique LexID Digitals found with input phone in the LexisNexis Digital Identity Network',
               'DI04' => 'Multiple unique True IPs found with input phone in the LexisNexis Digital Identity Network',
               'DI05' => 'Multiple unique browser hashes found with input phone in the LexisNexis Digital Identity Network',
               'DI06' => 'Multiple unique login ids found with input phone in the LexisNexis Digital Identity Network',
               'DI10' => 'High velocity of LexisNexis Digital Identity Network events for the input email',
               'DI11' => 'Multiple unique phones found with input email in the LexisNexis Digital Identity Network',
               'DI12' => 'Multiple unique devices found with input email in the LexisNexis Digital Identity Network',
               'DI13' => 'Multiple unique LexID Digitals found with input email in the LexisNexis Digital Identity Network',
               'DI14' => 'Multiple unique true IPs found with input email in the LexisNexis Digital Identity Network',
               'DI15' => 'Multiple unique browser hashes found with input email in the LexisNexis Digital Identity Network',
               'DI16' => 'Multiple unique companies found with input email in the LexisNexis Digital Identity Network',
               'DI20' => 'Multiple unique devices found with LexID Digital in the LexisNexis Digital Identity Network',
               'DI21' => 'Multiple unique true ips found with LexID Digital in the LexisNexis Digital Identity Network',
               'DI30' => 'High velocity of LexisNexis Digital Identity Network events where the input email and input phone were found together',
               'DI31' => 'High velocity of LexisNexis Digital Identity Network events where the input email and input name were found together',
               'DI32' => 'High velocity of LexisNexis Digital Identity Network events where the input email and input address were found together',
               'DI40' => 'Email first seen in the LexisNexis Digital Identity Network in the last 6 months',
               'DI41' => 'Email last seen in the LexisNexis Digital Identity Network in the last month',
               'DI42' => 'Phone first seen in the LexisNexis Digital Identity Network in the last 6 months',
               'DI43' => 'Phone last seen in the LexisNexis Digital Identity Network in the last 2 months',
               'DI44' => 'Name first seen in the LexisNexis Digital Identity Network in the last 2 months',
               'DI45' => 'Name last seen in the LexisNexis Digital Identity Network in the last week',
               'DI46' => 'Address first seen in the LexisNexis Digital Identity Network in the last 6 months',
               'DI47' => 'Address last seen in the LexisNexis Digital Identity Network in the last 2 months',
               'DI48' => 'LexID Digital first seen in the LexisNexis Digital Identity Network in the last month',
               'DI50' => 'The average time between LexisNexis Digital Identity Network events with the input email indicates high risk',
               'DI51' => 'The average time between LexisNexis Digital Identity Network events with the input phone indicates high risk',
               'DI60' => 'The average distance between True Ips of the LexisNexis Digital Identity Network events for the input phone is more than 45 miles',
               'DI90' => 'Insufficient digital history',
               'DI97' => 'The input PII or LexID Digital reported as final status-rejected in the LexisNexis Digital Identity Network',
               'DI98' => 'The input PII or LexID Digital has reported on the LexisNexis Digital Identity Network blacklist',
               'DI99' => 'The input PII or LexID Digital reported as fraud in the LexisNexis Digital Identity Network',
                         'Invalid Reason code'
            );
            
  return Desc;

END;