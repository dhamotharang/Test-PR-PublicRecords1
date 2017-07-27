EXPORT File_Industry_base(string pversion = 'qa') := Files(pversion).Industry_Linkids.logical(
																										 siccode<>'' or
																										 naics<>'' or
																										 industry_description<>'' or
																										 business_description<>''
																										);
