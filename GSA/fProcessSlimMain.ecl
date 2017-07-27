
export fProcessSlimMain(dataset(GSA.Layouts_GSA.layout_GSA_ID) pRawFileInput) := function

		export trimUpper(string s) := function
				return trim(stringlib.StringToUppercase(s),left,right);
		end;

		layouts_gsa.slim_main_lo setMain(pRawFileInput l) := transform
			self.primary_aka_name := 'P';
			self.name             := trimUpper(if((l.first_name <> '' AND l.last_name <> ''),StringLib.StringCleanSpaces(l.title+' '+l.first_name+' '+l.middle_name+' '+l.last_name+' '+l.generation),
																					StringLib.StringCleanSpaces(l.full_name)));
			// World Bridger requirements have the letters EP attached to the beginning. Strip 'em off.
			// Double-check they're there before removal, though.
			formatted_number      := trimUpper(l.Entity_Unique_ID);
			self.SAM_number       := IF(formatted_number[1..2] = 'EP', formatted_number[3..], formatted_number);
			self.Classification   := trimUpper(l.type);
			self                  := l;
		end;

		//set the primary_aka_name field to 'P'rimary, to identify each original Name record
		slim_main := project(pRawFileInput,setMain(left));   //distribution retained	

		return slim_main;

end; //end fProcessSlimMain function