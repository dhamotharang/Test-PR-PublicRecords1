EXPORT key_delta(dataset(spokeo.Layout_delta) delta) := 
						index(delta,
                             {LexId},{delta},
                             '~thor::spokeo::key::delta');
