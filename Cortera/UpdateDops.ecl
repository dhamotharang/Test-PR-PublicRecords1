﻿import dops;

DopsEmail := 'Sudhir.Kasavajjala@lexisnexisrisk.com,Michael.Gould@lexisnexis.com,QualityAssurance@seisint.com,Charles.Salvo@lexisnexisrisk.com,Donald.Lingle@lexisnexisrisk.com';

EXPORT UpdateDops(string version) := 
						dops.updateversion('CorteraKeys',version,DopsEmail,,'N');