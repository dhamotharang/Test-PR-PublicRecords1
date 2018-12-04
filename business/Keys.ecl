IMPORT $;

EXPORT Keys := MODULE
	SHARED prefix := '~';//'~foreign::10.241.3.238:7070::';

	File_BestStatic := DATASET('', $.Layouts.key_static, THOR);

	EXPORT Key_BestStaticLinkIDs := INDEX(File_BestStatic,
															{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
															{File_BestStatic},
															prefix + 'thor_data400::key::bipv2_best::qa::linkids');


	File_Contacts := DATASET('', $.Layouts.key_contacts, THOR);

	EXPORT Key_Contacts := INDEX(File_Contacts,
															{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
															{File_Contacts},
															prefix + 'thor_data400::key::bipv2::business_header::qa::contact_linkids');
END;