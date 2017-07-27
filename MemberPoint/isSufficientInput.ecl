/*
Name and Address
OR
Name and SSN
OR 
Name, Partial Address and DOB (Partial address is defined as either, 
																								StreetAddress1, city & zip or 
																								StreetAddress1, city & state)

Street Address = StreetAddress1

Address means it is a complete address consisting of 
				StreetAddress1, City, State & Zip5
*/

EXPORT isSufficientInput :=  FUNCTIONMACRO
			NameNotBlank:= ((report_by.Name.First <> '' AND report_by.Name.Last <> '') OR 
											report_by.Name.full <> '');
			SSNNotBlank:= (report_by.SSN <> '');
			DOBNotBlank:= (report_by.DOB.Year <> 0 AND report_by.DOB.Month <> 0 AND report_by.DOB.Day <> 0);
			PartialAddressNotBlank:= ((report_by.Address.StreetAddress1 <> '' AND report_by.Address.City <> '' AND report_by.Address.Zip5 <> '') OR
																(report_by.Address.StreetAddress1 <> '' AND report_by.Address.City <> '' AND report_by.Address.State <> ''));
			AddressNotBlank:= ((report_by.Address.StreetName <> '' OR report_by.Address.StreetAddress1 <> '') AND report_by.Address.City <> '' AND report_by.Address.State <> '' AND report_by.Address.Zip5 <> '');
	
			RETURN (NameNotBlank AND AddressNotBlank) OR
							(NameNotBlank AND SSNNotBlank) OR
							(NameNotBlank AND PartialAddressNotBlank AND DOBNotBlank);
ENDMACRO;