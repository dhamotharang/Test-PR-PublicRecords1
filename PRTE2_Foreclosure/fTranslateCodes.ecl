
EXPORT fTranslateCodes(dataset(Layouts.incoming_boca) incoming_file = dataset([], Layouts.incoming_boca)):= function

//Translate Property Codes
//--Deed Description
rsForeclosureCoded1	 	:=	JOIN(incoming_file, Files.File_Foreclosure_Codes,
															 right.code_type		=	'deed' AND
															 left.deed_category = right.code,
																	transform(Layouts.base,
																					  self.deed_desc	:=	right.code_desc;
																						self := left,
																						self := []), 		
																						left outer,	lookup
																							 );
//--Document Description
rsForeclosureCoded2		 	:=	JOIN(rsForeclosureCoded1, Files.File_Foreclosure_Codes,
																	 right.code_type	  =	'document' AND 
																	 left.document_type = right.code,
																			transform(Layouts.base,
																								self.document_desc	:=	right.code_desc;
																								self := left), 		
																								left outer,	lookup
																								);

//--Et Al Description
rsForeclosureCoded3		 	:=	JOIN(rsForeclosureCoded2, Files.File_Foreclosure_Codes,
																 right.code_type	=	'etal' AND 
																 left.defendant_borrower_owner_et_al_indicator = right.code,
																			transform(Layouts.base,
																								self.et_al_desc	:=	right.code_desc;
																								self := left), 		
																								left outer,	lookup
																								);
//--Property Description																						 
rsForeclosureCoded4		 	:=	JOIN(rsForeclosureCoded3, Files.File_Foreclosure_Codes,
															  	right.code_type	=	'property' AND
																	left.property_indicator = right.code,
																			transform(Layouts.base,
																								self.property_desc	:=	right.code_desc;
																								self := left), 		
																								left outer,	lookup
																								);
																							
//--Land Use Description																						 
rsForeclosureCoded5		 	:=	JOIN(rsForeclosureCoded4, Files.File_Foreclosure_Codes,
																 right.code_type	=	'land_use'  AND
															   left.use_code = right.code,
																			transform(Layouts.base,
																								self.use_desc	:=	right.code_desc;
																								self := left), 		
																								left outer,	lookup
																								);


return rsForeclosureCoded5;
end;	