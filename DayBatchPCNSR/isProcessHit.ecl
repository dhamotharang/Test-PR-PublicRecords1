export 	isProcessHit(STRING10 m,STRING20 s) := 
																		MAP(s = 'AC2A' AND m IN ['FL13Z','FL137Z','L137Z','L13Z'] OR
																				s = 'AC2B' AND m IN ['137Z','F137Z','13Z','F13Z'] OR
																				s = 'USPAGE_FL13Z' AND m IN ['FL137Z','FL13Z','L137Z','L13Z','137Z','13Z','FL3Z','L3Z'] OR
																				s = 'USPAGE_FL137Z' AND m IN ['FL137Z','FL13Z','L137Z','L13Z','137Z','13Z','FL3Z','L3Z','F137Z','F13Z'] OR
																				s = 'AC04' AND m IN ['LZ','FLZ'] OR
																				s = 'PHA1' AND m IN ['FL137Z','FL13Z','L137Z','L13Z','F137Z','F13Z','137Z','13Z'] OR
																				s = 'PH50' AND m IN ['FL137Z','FL13Z','L137Z','L13Z','F137Z','F13Z','137Z','13Z'] OR
																				s = 'AC4A' AND m IN ['FLP','LP','FP','P'] OR
																				s = 'AC03' AND m IN ['Z','FLZ','FZ','LZ']
																				=> true,
																				false
																				);