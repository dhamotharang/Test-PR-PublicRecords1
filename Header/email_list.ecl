EXPORT email_list := MODULE

 EXPORT BocaDevelopers := 'gabriel.marcan@lexisnexisrisk.com'
                        + ',Debendra.Kumar@lexisnexisrisk.com'
                        ;
 EXPORT BocaDevelopersEx := BocaDevelopers
                        + ',jose.bello@lexisnexisrisk.com'
                        ;
                         
 EXPORT AlphaDevelopers := 'Cody.Fouts@lexisnexisrisk.com'
                         + ',Ayeesha.Kayttala@lexisnexisrisk.com'
                         ;
 EXPORT AlphaDevelopersEx := 'aleida.lima@lexisnexis.com'
                           + ',manish.shah@lexisnexis.com'
                           ;
 EXPORT others := 'Gavin.Witz@lexisnexisrisk.com'
                + ',Manjunath.Venkataswamy@lexisnexisrisk.com'
                ;
 EXPORT ops := 'michael.gould@lexisnexis.com';
 
 EXPORT statsInc := BocaDevelopersEx + ',' + AlphaDevelopers + ',' + others;    
 EXPORT statsMon := statsInc + ',' + AlphaDevelopersEx + ','  + ops;

END;