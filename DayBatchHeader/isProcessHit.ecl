export 	isProcessHit(STRING10 m,STRING20 s) := 
																		MAP(s = 'IE01' AND m IN ['FL137ZS','FL13ZS','FL137Z','FL13Z','L137ZS','L13ZS','L137Z','L13Z','FLS','LS'] OR
																				s = 'IE02' AND m IN ['FL137ZS','FL13ZS','FL137Z','FL13Z','L137ZS','L13ZS','L137Z','L13Z','FLS','LS'] OR
																				s = 'I500' AND m IN ['FL137ZS','FL13ZS','FL137Z','FL13Z','L137ZS','L13ZS','L137Z','L13Z','FLS','LS'] OR
																				s = 'AAPSRCH2_FL13SZ' AND m IN ['FL137ZS','FL13ZS'] OR
																				s = 'AFNI_SFL13Z_C' AND (stringLib.StringContains(m,'S',false) 
																																OR m IN ['FL137Z','FL13Z','L137Z','L13Z','fL137Z','fL13Z']) OR
																				s = 'PSRCH2_SSN_C' AND stringLib.StringContains(m,'S',false) OR
																				s = 'PSRCH2_FL13Z_C' AND m IN ['FL137ZS','FL13ZS','FL137Z','FL13Z'] OR
																				s = 'PSRCH2_FL13Z_X_5A' AND m IN ['FL137ZS','FL13ZS','FL137Z','FL13Z']
																					=> true,
																					false
																				);