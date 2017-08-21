export Layout_File_WA_in := module	 
	export layout_AmendmentType := RECORD,maxlength(30000)
				string amendType																	{xpath('@Type')};
	END;

	export layout_Debtors			 := RECORD,maxlength(30000)
				string OrganizationName														{xpath('Names/OrganizationName')};
				string LName																			{xpath('Names/IndividualName/LastName')};
				string FName																			{xpath('Names/IndividualName/FirstName')};
				string MName																			{xpath('Names/IndividualName/MiddleName')};
				string Suffix																			{xpath('Names/IndividualName/Suffix')};
				string MailAddress																{xpath('Names/MailAddress')};
				string City																				{xpath('Names/City')};
				string State																			{xpath('Names/State')};
				string PostalCode																	{xpath('Names/PostalCode')};
				string Country																		{xpath('Names/Country')};
				string TaxID																			{xpath('Names/TaxID')};
				string OrganizationalType													{xpath('Names/OrganizationalType')};
				string OrganizationalJuris												{xpath('Names/OrganizationalJuris')};
				string OrganizationalID														{xpath('Names/OrganizationalID')};
				string AltCapacity																{xpath('DebtorAltCapacity/@AltCapacity')};
	END;

	export layout_Secured			 := RECORD,maxlength(30000)
				string OrganizationName														{xpath('OrganizationName')};
				string LName																			{xpath('IndividualName/LastName')};
				string FName																			{xpath('IndividualName/FirstName')};
				string MName																			{xpath('IndividualName/MiddleName')};
				string Suffix																			{xpath('IndividualName/Suffix')};
				string MailAddress																{xpath('MailAddress')};
				string City																				{xpath('City')};
				string State																			{xpath('State')};
				string PostalCode																	{xpath('PostalCode')};
				string Country																		{xpath('Country')};
				string TaxID																			{xpath('TaxID')};
				string OrganizationalType													{xpath('OrganizationalType')};
				string OrganizationalJuris												{xpath('OrganizationalJuris')};
				string OrganizationalID														{xpath('OrganizationalID')};
	END;

	export layout_Assignor			 := RECORD,maxlength(30000)
				string OrganizationName														{xpath('OrganizationName')};
				string LName																			{xpath('IndividualName/LastName')};
				string FName																			{xpath('IndividualName/FirstName')};
				string MName																			{xpath('IndividualName/MiddleName')};
				string Suffix																			{xpath('IndividualName/Suffix')};
				string MailAddress																{xpath('MailAddress')};
				string City																				{xpath('City')};
				string State																			{xpath('State')};
				string PostalCode																	{xpath('PostalCode')};
				string Country																		{xpath('Country')};
				string TaxID																			{xpath('TaxID')};
				string OrganizationalType													{xpath('OrganizationalType')};
				string OrganizationalJuris												{xpath('OrganizationalJuris')};
				string OrganizationalID														{xpath('OrganizationalID')};
	END;

	export layout_AuthSecured			 := RECORD,maxlength(30000)
				string OrganizationName														{xpath('OrganizationName')};
				string LName																			{xpath('IndividualName/LastName')};
				string FName																			{xpath('IndividualName/FirstName')};
				string MName																			{xpath('IndividualName/MiddleName')};
				string Suffix																			{xpath('IndividualName/Suffix')};
	END;

	export layout_AuthDebtor			 := RECORD,maxlength(30000)
				string OrganizationName														{xpath('OrganizationName')};
				string LName																			{xpath('IndividualName/LastName')};
				string FName																			{xpath('IndividualName/FirstName')};
				string MName																			{xpath('IndividualName/MiddleName')};
				string Suffix																			{xpath('IndividualName/Suffix')};
	END;

	export layout_XMLRec := record,maxlength(50000)
				string ContactName 																{xpath('Filer/ContactName')};
				string ContactPhone																{xpath('Filer/ContactPhone')};
				string ContactNameAndPhone                    				                    {xpath('Filer/ContactNameAndPhone')};
				string BoxBLine1 																{xpath('Filer/BoxBLine1')};
				string BoxBLine2 																{xpath('Filer/BoxBLine2')};
				string BoxBLine3 																{xpath('Filer/BoxBLine3')};
				string BoxBLine4 																{xpath('Filer/BoxBLine4')};
				string transType  																{xpath('TransType')};
				string method																			{xpath('FilingMethod@Method')};          
				string amendAction																{xpath('AmendmentActionLoop/AmendmentAction[1]@Action')};
			// what follows is the child dataset that contains the multiple tags in the loops - notice xpath is the outer loop path w/o the attribute 
				dataset (layout_AmendmentType) AmendmentTypeLoop 	{xpath('AmendmentTypeLoop/AmendmentType')};
				string originalFileNumber  												{xpath('OriginalFileNumber')};
				string optionalFilerReferenceData										{xpath('OptionalFilerReferenceData')};
				string expiration				  												{xpath('LapseDate')};
				string FileNumber 				 												{xpath('FileNumber')};
				string FileDate  																	{xpath('FileDate')};
				string FileTime  																	{xpath('FileTime')};
				string FilingOffice  															{xpath('FilingOffice')};
				string AltNameDesignation													{xpath('AltNameDesignation@AltName')};
				string AltFilingType															{xpath('AltFilingType@AltType')};
				string Designation																{xpath('FileInRealEstate/Designation@Type')};
				string RealEstateDescription											{xpath('FileInRealEstate/RealEstateDescription')};
				dataset (layout_Debtors) Debtors					 				{xpath('Debtors/DebtorName')};
				dataset (layout_Secured) Secured					 				{xpath('Secured/Names')};		
				dataset (layout_Assignor) Assignor								{xpath('Assignor/Names')};	
				string ColText																		{xpath('Collateral/ColText')};
				dataset (layout_AuthSecured) AuthSecured	 				{xpath('AuthorizingParty/AuthSecuredParty')};
				dataset (layout_AuthDebtor) AuthDebtor					 	{xpath('AuthorizingParty/AuthDebtor')};
	end;
end;