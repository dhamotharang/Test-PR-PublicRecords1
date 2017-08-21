EXPORT fn_Population_Deact(string population, string patternfield, string total) := function

isValidPopulation	:=	case(patternfield,
'DE'=>(((decimal10_2)population/(decimal10_2)total)*100)>=61.0 AND(((decimal10_2)population/(decimal10_2)total)*100)<=72.0,
'SW'=>(((decimal10_2)population/(decimal10_2)total)*100)>=4.0 AND(((decimal10_2)population/(decimal10_2)total)*100)<=15.0,
'SU'=>(((decimal10_2)population/(decimal10_2)total)*100)>=3.0 AND(((decimal10_2)population/(decimal10_2)total)*100)<=14.0,
TRUE);

return if(isValidPopulation,0,1);
end;