import dops;

DopsEmail := 'Sudhir.Kasavajjala@lexisnexisrisk.com,Michael.Gould@lexisnexis.com,QualityAssurance@seisint.com,Charles.Salvo@lexisnexisrisk.com';
		
EXPORT UpdateDops(string version,string build_name) :=  FUNCTION
          return if ( trim(build_name) = 'Cortera',
					  Sequential( 
						dops.updateversion('CorteraKeys',version,DopsEmail,,'N') ,
						dops.updateversion('CorteraKeys',version,DopsEmail,,'N',,,'A')
						             ),
						
						dops.updateversion('CorteraTradelineKeys',version,DopsEmail,,'N') 
					);
	end;