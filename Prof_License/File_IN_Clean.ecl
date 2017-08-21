import Address;

export File_IN_Clean:= Function

 Input_file:=Prof_License.File_IN_Raw;
 
        trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
 Prof_License.Layout_IN_raw.clean_input clean_trans( Prof_License.Layout_IN_raw.input l):= transform
     self.Website				:=trimUpper(l.Website);            ;
     self.State					:=trimUpper(l.State);            ;
     self.BusinessName			:=trimUpper(l.BusinessName);
     self.NameFirst				:=trimUpper(l.NameFirst);
     self.NameMiddle			:=trimUpper(l.NameMiddle)            ;
     self.NameLast				:=trimUpper(l.NameLast)            ;
     self.NameSuffix			:=trimUpper(l.NameSuffix)            ;
     self.NameTitle				:=trimUpper(l.NameTitle)            ;
     self.Address				:=trimUpper(l.Address)            ;
     self.AddressCity			:=trimUpper(l.AddressCity)            ;
     self.AddrState				:=trimUpper(l.AddrState)            ;
     self.LicenseNo				:=trimUpper(l.LicenseNo)            ;    //Alphanumeric
     self.LicenseType			:=trimUpper(l.LicenseType)            ;
     self.Profession			:=trimUpper(l.Profession)            ;
     self.LicenseStatus			:=trimUpper(l.LicenseStatus)            ;
	 self.County			    :=trimUpper(l.County);
	 string73 tempName     		:=Address.CleanPersonFML73(trim(l.NameFirst) + trim(' '+l.NameMiddle) +trim(' '+ l.NameLast));
	 self.title                 := tempName[1..5];
	 self.fname           		:= tempName[6..25];
	 self.mname           		:= tempName[26..45];
	 self.lname          		:= tempName[46..65];
	 self.name_suffix	 		:= tempName[66..70];
	 self				 		:=l;
	 
end;

  IN_Clean:=project( Input_file,clean_trans(left)) ;

return IN_Clean;

end ;