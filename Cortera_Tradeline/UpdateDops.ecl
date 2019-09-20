import dops;

DopsEmail := 'Charles.Salvo@lexisnexisrisk.com';
		
EXPORT UpdateDops(string version) := 
						dops.updateversion('CorteraTradelineKeys',version,DopsEmail,,'N');
