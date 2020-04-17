﻿import std;

export Agency_Exclusion := module

 export Agency_ori_jurisdiction_list := ['IN'];
 export Agency_ori_exclusion_list := ['IL0222500', 'TXHPD0000',  //IL & TX
                                      'GA0040400', 'GA0440149', 'GA0590100', 'GA0604400', 'GA060459E', 'GAOCOFP00', 'CL0000001', 'ORINC072', 'LT123456' //GA
																		 ];
                
 Agency_ori_inclusion_list := ['GA1080000'];        
 inAgency := Infiles.agency(agency_ori not in Agency_ori_inclusion_list); 
 inAgency_ori_ga_list := set(inAgency(std.Str.ToUpperCase(trim(agency_ori, all))[1..2] = 'GA'),agency_ori); 
 export Agency_ori_list := inAgency_ori_ga_list + Agency_ori_exclusion_list;
                
end;
