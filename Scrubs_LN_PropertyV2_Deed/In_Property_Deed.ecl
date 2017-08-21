import ln_propertyv2, ut, LN_PropertyV2_Fast;
EXPORT In_Property_Deed (string1 source, string version) := function


File_deed_delta:=  LN_PropertyV2_Fast.Files.base.deed_mortg;
File_deed_full := LN_PropertyV2.File_Deed;

 new_ly := record
 recordof(File_deed_full);
 string5 fips;
 end;
 
MaxprocessDate := if(version = '', Max(File_deed_full +File_deed_delta,process_date), version);

RecsforDate := if(count(File_deed_delta( process_date[..8] = MaxprocessDate)) > 0, 
																	File_deed_delta( process_date[..8] = MaxprocessDate),
																	File_deed_full( process_date[..8] = MaxprocessDate)) :INDEPENDENT;
																	
																	
File_source := project(if(source = 'O', RecsforDate (vendor_source_flag = source), RecsforDate (vendor_source_flag <> 'O')),  transform(new_ly, self.fips := left.fips_code, self:= left));

	 
return (File_source);
	 
	 end;

/* EXPORT In_Property_Deed := LN_( process_date = MaxprocessDateLN) +  
   	                       Fares(process_date = MaxProcessDateFares);
*/