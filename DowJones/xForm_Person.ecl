import Worldcheck_Bridger, ut;




EXPORT Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp 
					xForm_Person(Layouts.rPersons src) := TRANSFORM

		self.id := src.id;
		self.Entity_Unique_ID := 'DJ' + src.id;
		self.Reference_ID := src.id;
		self.type := 'Individual';
		self.Listed_Date := ut.ConvertDate(src.date, '%d-%B-%Y', '%m/%d/%Y');
		self.comments := '';
		self.gender := src.gender;
		
		// Extract primary name
/*		primaryName := src.NameDetails(nameType = 'Primary Name')[1];
//		self.title 					:= IF(Exists(primaryName),primaryName.TitleHonorofic,'');
		self.title 						:= primaryName.NameValue[1].TitleHonorific;
		self.first_name 			:= primaryName.NameValue[1].FirstName;
		self.middle_name 			:= primaryName.NameValue[1].MiddleName;
		self.last_name 				:= primaryName.NameValue[1].SurName;
		self.generation 			:= (string)primaryName.NameValue[1].Suffix;
		//self.full_name				:= primaryName.NameValue[1].SingleStringName;
		self.full_name := MAP(
								COUNT(primaryName.NameValue[1].OriginalScriptName) > 0 => primaryName.NameValue[1].OriginalScriptName[1],
								COUNT(primaryName.NameValue[1].SingleStringName) > 0 => primaryName.NameValue[1].SingleStringName[1],
								'');
*/		
		
		self := src;
		self := [];
END;