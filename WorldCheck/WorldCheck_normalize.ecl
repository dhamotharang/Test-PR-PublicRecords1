import WorldCheck, lib_stringlib;

Layout_out := WorldCheck.Layout_WorldCheck_In_Normalized;

Layout_temp := record, maxlength(30900)
	unsigned8 key;
	string255 name_orig;
	string1   Name_Type;
	string100 Location;
	WorldCheck.Layout_WorldCheck_in;
end;

in_file := WorldCheck.File_WorldCheck_In;

//Remove '~' populated in the locations field
WorldCheck.Layout_WorldCheck_in locFix(in_file l) := transform
self.Locations := regexreplace('~,~|~',trim(l.locations,left,right),'');
self := l;
end;

in_file_2 := PROJECT(in_file, locFix(left));

// Add a key value for each of the records
Layout_temp trfProject(in_file_2 l) := transform
	self.key        := 0;
	self.name_orig  := trim(l.Last_Name,left,right) + ', ' + trim(l.First_Name,left,right);
    self.name_type  := '0';	// Name type of zero for the primary records
	self.Location   := '';
 	self            := l;	
end;

ds_with_new_fields := PROJECT(in_file_2, trfProject(left));

// Shared parsing pieces for AKAs and alternate spellings
pattern SingleName := pattern('[^;]+');

MyParsedRecord := record, maxlength(30900)
	ds_with_new_fields;
	string CompleteName := TRIM(MATCHTEXT(SingleName),left,right);
end;

Invalid_Names := ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];

////////// Begin parsing and normalizing name AKAs//////////
// Parse the AKA name values	
MyParsedAKAds := PARSE(ds_with_new_fields(trim(Aliases,left,right) != ''),Aliases,SingleName,MyParsedRecord,scan,first);
// Specify the invalid AKA name values
// Transform the AKA name values
Layout_temp trfAkaName(MyParsedAKADS l) := transform
	self.name_orig := IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
	                    ,SKIP
						,TRIM(l.CompleteName,left,right));
	self.name_type := '2'; // Name type of two for the AKA records
	self.Location  := '';
	self := l;
end;
// Normalize the AKA name values
ds_NormAKANames := NORMALIZE(MyParsedAKADS
                            ,1
							,trfAKAName(left));
////////// End parsing and normalizing name AKAs//////////

/*//////// Begin parsing and normalizing alternate names ////////*/
// Parse the ALT name values
MyParsedALTds := PARSE(ds_with_new_fields(trim(Alternate_Spelling,left,right) != ''),Alternate_Spelling,SingleName,MyParsedRecord,scan,first);
// Specify the invalid ALT name values
// Transform the ALT name values
Layout_temp trfALTName(MyParsedALTDS l) := transform
	self.name_orig := IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
	                    ,SKIP
						,TRIM(l.CompleteName,left,right));
	self.name_type := '3'; // Name type of three for the alternate spellings
	self.Location  := '';
	self := l;
end;
// Normalize the ALT name values
ds_NormALTNames := NORMALIZE(MyParsedALTDS
                            ,1
							,trfALTName(left));
////////// End parsing and normalizing alternate names//////////

/*//////// Begin parsing and normalizing locations ////////*/
// Parse the location values
MyParsedLocationsds := PARSE(ds_with_new_fields(trim(Locations,left,right) != '')
                            ,Locations
							,SingleName
							,MyParsedRecord
							,scan,first);
							
Layout_address_temp := record,maxlength(250)
    string  UID;
    string  Location;
end;   

Layout_address_temp trfLocation(MyParsedLocationsds l) := transform
	self.Location := IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
	                   ,SKIP
				   	   ,TRIM(l.CompleteName,left,right));
	self := l;
end;

/* Normalize the Location values */
ds_NormLocations := NORMALIZE(MyParsedLocationsds
                            ,1
							,trfLocation(left));
////////// End parsing and normalizing locations//////////

/* Make a union of the original values along with the AKA and ALT values */
ds_all_names := ds_with_new_fields 
              + ds_NormAKANames 
			  + ds_NormALTNames;

/* Join all the name values with the normalized locations */
Layout_temp j_names_and_locations(ds_all_names L, ds_NormLocations R) := transform
   self.Location := R.location;
   self          := L;
end;

ds_fully_normalized := JOIN(ds_all_names
                           ,ds_NormLocations
						   ,LEFT.UID = RIGHT.UID
						   ,j_names_and_locations(left,right)
						   ,LEFT OUTER);

// Dedup the AKA and Alternate name values
ds_dedupedNames := DEDUP(SORT(ds_fully_normalized
                             ,key
							 ,UID
							 ,name_type
							 ,name_orig
							 ,Category)
					    ,except key);

// Remove the aliases column
Layout_out trfRemAliases(ds_dedupedNames l, unsigned c) := transform
    self.key       := c;
 	self.name_orig := l.name_orig;
	self           := l;	
end;

ds_AllNames := DISTRIBUTE(PROJECT(SORT(ds_dedupedNames
                                      ,key
									  ,UID
									  ,name_type
									  ,name_orig
									  ,Category)
					             ,trfRemAliases(left,counter))
						 ,hash32(UID));

export WorldCheck_normalize := ds_AllNames : persist(WorldCheck.cluster_name + 'Persist::WorldCheck::Normalized');

