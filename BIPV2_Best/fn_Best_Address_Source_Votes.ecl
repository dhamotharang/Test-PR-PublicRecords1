export fn_Best_Address_Source_Votes(STRING source,INTEGER Dups) :=
MAP( 	Src in ['DN'] 																			=> Dups * 2.0, 
						Dups ); // Treat as normal