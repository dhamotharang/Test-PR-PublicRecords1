EXPORT Constants := module

EXPORT KeyName_Workers_Compensation := 	'~prte::key::Workers_Compensation::'; 

EXPORT in_workers_compensation := '~PRTE::IN::Workers_Compensation';

EXPORT base_workers_compensation := '~PRTE::BASE::Workers_Compensation'; 

EXPORT ak_keyname := KeyName_Workers_Compensation +'autokey::@version@::'; 

EXPORT ak_logical(string filedate) := KeyName_Workers_Compensation + filedate + '::autokey::'; 
	
EXPORT ak_skip_set := ['C','P','Q','S']; //Skip Parms: B(Biz), C(Person Contact), F(FEIN), P(Personal Phones), Q(Biz Phones), S(SSN)

EXPORT ak_typestr := 'AK'; 

EXPORT valid_states := ['AA','AB','AE','AK','AL','AP','AR','AS','AZ','BC',
												'CA','CO','CT','DC','DE','FL','FM','GA','GU','HI',
												'IA','ID','IL','IN','KS','KY','LA','MA','MB','MD',
												'ME','MH','MI','MN','MO','MP','MS','MT','NB','NC',
												'ND','NE ','NH','NJ','NL','NM','NS','NT','NU','NV',
												'NY','OH','OK','ON','OR','PA','PE','PR','PW','QC',
												'RI','SC','SD','SK','TN','TX','UT','VA','VI','VT',
												'WA','WI','WV','WY','YT'];

END;

