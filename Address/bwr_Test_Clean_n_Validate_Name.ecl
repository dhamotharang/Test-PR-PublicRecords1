pName																:= 'WEB ADMINISTRATOR';
pNameOrder													:= 'F'								;
pNameScoreThreshold									:= 75									;
pBusiness_HeaderCleanNameThreshold	:= 3									;
pRequiresCommaInLastName						:= false							;


clean_name := Address.Clean_n_Validate_Name(

	 pName															:= pName															
	,pNameOrder													:= pNameOrder												
	,pNameScoreThreshold								:= pNameScoreThreshold								
	,pBusiness_HeaderCleanNameThreshold	:= pBusiness_HeaderCleanNameThreshold
	,pRequiresCommaInLastName						:= pRequiresCommaInLastName					
                                     
);

output(pName											, named('OrigName'	));
output(clean_name.CleanNameRecord	, named('CleanName'	));