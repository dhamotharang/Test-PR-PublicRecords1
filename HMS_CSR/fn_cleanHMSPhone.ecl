IMPORT ut,Hms_csr;

EXPORT fn_cleanHMSPhone (string phone):= FUNCTION
		 return if(ut.CleanPhone(phone) [1] not in ['0','1'] and length(ut.CleanPhone(phone))>=10 and length(REGEXREPLACE('9',ut.CleanPhone(phone),''))>0,
									ut.CleanPhone(phone), 
							'');		
END;