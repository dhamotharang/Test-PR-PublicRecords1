IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT Base := MODULE
	
		EXPORT Business_Address := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OH.Filenames().Base.Business_Address.QA))) > 0;
		EXPORT Agent_Contact := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OH.Filenames().Base.Agent_Contact.QA))) > 0;
		EXPORT Business_Associate := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OH.Filenames().Base.Business_Associate.QA))) > 0;
		EXPORT Business := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OH.Filenames().Base.Business.QA))) > 0;
		EXPORT Explanation := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OH.Filenames().Base.Explanation.QA))) > 0;
		EXPORT Text_Information := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OH.Filenames().Base.Text_Information.QA))) > 0;
		EXPORT Old_Name := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OH.Filenames().Base.Old_Name.QA))) > 0;
		EXPORT Authorized_Share := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OH.Filenames().Base.Authorized_Share.QA))) > 0;	
		EXPORT Document_Transaction := COUNT(NOTHOR(FileServices.SuperFileContents(Corp2_Raw_OH.Filenames().Base.Document_Transaction.QA))) > 0;		
		
	end;
	
end;