EXPORT fn_Population_Ported(string population, string patternfield, string total) := function

isValidPopulation	:=	case(patternfield,
'A'=>(((decimal10_2)population/(decimal10_2)total)*100)>=40.0 AND(((decimal10_2)population/(decimal10_2)total)*100)<=51.0,
'U'=>(((decimal10_2)population/(decimal10_2)total)*100)>=33.0 AND(((decimal10_2)population/(decimal10_2)total)*100)<=39.0,
'D'=>(((decimal10_2)population/(decimal10_2)total)*100)>=9.0 AND(((decimal10_2)population/(decimal10_2)total)*100)<=15.0,
TRUE);

return if(isValidPopulation,0,1);
end;