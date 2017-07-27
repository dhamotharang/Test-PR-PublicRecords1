export MAC_ParseMXNameParts(
		ds,//the dataset containing names to parse.
		field, //the field containing the names to be parsed
		uid_field,//the unique identifier field for this dataset. this field value will become the "item_id" field in the result dataset
		includeSynonyms,//whether or not to return synonyms for words in the return dataset as well as the original parsed words
		normalizeMetaphones,//whether or not to return one record for word/mph1 and another for word/mph2, or whether to return one record containing word/mph1/mph2
		joinYLastNames, //when 'Y' last names are found (the last three words in a name are <lastname> <Y/E> <Lastname>, join those last three words
		firstNameFirst,//hint that the words are coming in first name first
		parse_orgs, //if a name contains "non-name" words and parse_orgs is false, the name will be designated as an org rather than a name, and won't be parsed into name parts
		dsSingleNameFormats,//the single name format config dataset to use to parse this data
		dsMultipleNameFormats,//the multiple name format config dataset to use to parse this data
		dsResult,//the result datafile, in mxd_Names.Layouts.L_MXPersonNamePart format
		dsResultBadSingle,//a list of names that could not be parsed--the single name formats file did not contain a format for this name
		dsResultBadMultiple//a list of multiple names that could not be parsed--the multiple name formats file did not contain a format for this name
	):= MACRO

#uniquename(dsNamePartsParsed)
mxd_Names.MAC_ParseNameParts(ds,field,uid_field,includeSynonyms,normalizeMetaphones,joinYLastNames,parse_orgs,%dsNamePartsParsed%);

#uniquename(dsNamePartsFNF)
//handle birth-record specific name formatting--first name always comes first, even if it's a last name type
%dsNamePartsFNF% :=PROJECT(%dsNamePartsParsed%, TRANSFORM(RECORDOF(%dsNamePartsParsed%),
SELF.name_format:=IF (LENGTH(trim(LEFT.name_format)) > 1,'F' + LEFT.name_format[2..LENGTH(LEFT.name_format)], LEFT.name_format);
SELF :=LEFT;));


#uniquename(dsNamePartsToUse)
%dsNamePartsToUse% := IF(firstNameFirst,%dsNamePartsFNF%,%dsNamePartsParsed%);

#uniquename(singleFilter)
//allocate name parts for single names
%singleFilter% :=REGEXFIND('(Y|E|AND)',%dsNamePartsToUse%.name_format,0) = '' 
							AND %dsNamePartsToUse%.probable_name_part not in [mxd_Names.Layouts.NamePartType.Suffix,
																														mxd_Names.Layouts.NamePartType.Title];

#uniquename(dsRecsetSingleNameFormats)
#uniquename(bad_item_ids)
#uniquename(dsSingleNamesToUse)

%dsSingleNamesToUse% :=%dsNamePartsToUse%(%singleFilter%);

mxd_Names.MAC_GetSpecificNameFormats(%dsSingleNamesToUse%,dsSingleNameFormats,%dsRecsetSingleNameFormats%,%bad_item_ids%);
dsResultBadSingle :=%bad_item_ids%;

#uniquename(dsNamesSingleDist)
#uniquename(dsSingleNameFormatsDist)
#uniquename(dsNamesSingle)
%dsNamesSingleDist% :=DISTRIBUTE(SORT(%dsSingleNamesToUse%,name_part_position,name_format),HASH32(name_part_position,name_format));
%dsSingleNameFormatsDist% :=DISTRIBUTE(SORT(%dsRecsetSingleNameFormats%,name_part_position,name_format),HASH32(name_part_position,name_format));
%dsNamesSingle% :=JOIN(%dsNamesSingleDist%, %dsSingleNameFormatsDist%,
LEFT.name_part_position=RIGHT.name_part_position AND RIGHT.name_Format=LEFT.name_format, 
TRANSFORM(RECORDOF(%dsNamePartsToUse%),
SELF.name_part_type :=IF (RIGHT.name_part_type!=0,RIGHT.name_part_type,LEFT.name_part_type);
SELF := LEFT;),LOCAL,LOOKUP);

//allocate name parts for multiple names
#uniquename(multFilter)
%multFilter% :=REGEXFIND('(Y|E|AND)',%dsNamePartsToUse%.name_format,0) != '' 
							AND %dsNamePartsToUse%.probable_name_part not in [mxd_Names.Layouts.NamePartType.Suffix,
																														mxd_Names.Layouts.NamePartType.Title];

#uniquename(dsMultipleNamesToUse)
%dsMultipleNamesToUse% :=%dsNamePartsToUse%(%multFilter%);

#uniquename(dsRecsetmultipleNameFormats)
#uniquename(bad_mitem_ids)
mxd_Names.MAC_GetSpecificNameFormats(%dsMultipleNamesToUse%,dsMultipleNameFormats,%dsRecsetMultipleNameFormats%,%bad_mitem_ids%);
dsResultBadMultiple :=%bad_mitem_ids%;

#uniquename(dsNamesMultipleDist)
#uniquename(dsMultipleNameFormatsDist)
%dsNamesMultipleDist% :=DISTRIBUTE(SORT(%dsMultipleNamesToUse%,name_part_position,name_format),HASH32(name_part_position,name_format));
%dsMultipleNameFormatsDist% :=DISTRIBUTE(SORT(%dsRecsetmultipleNameFormats%,name_part_position,name_format),HASH32(name_part_position,name_format));

#uniquename(dsNamesMultiple)
%dsNamesMultiple% :=JOIN(%dsNamesMultipleDist%, %dsMultipleNameFormatsDist%,
LEFT.name_part_position=RIGHT.name_part_position 
AND RIGHT.name_Format =LEFT.name_format, 
TRANSFORM(RECORDOF(%dsNamePartsToUse%),
SELF.name_part_type :=RIGHT.name_part_type;
SELF.name_format :=RIGHT.new_name_format;
SELF.total_parts :=LENGTH(TRIM(RIGHT.new_name_format));
SELF.name_id:=RIGHT.name_id;
SELF := LEFT;),LOCAL,ALL);

//renumber name part position
#uniquename(dsNamesMultipleSorted)
#uniquename(dsNamesNewNamePartPositions)
%dsNamesMultipleSorted% :=SORT(%dsNamesMultiple%, item_id, name_id, name_part_position);
%dsNamesNewNamePartPositions% :=ITERATE(%dsNamesMultipleSorted%,TRANSFORM(RECORDOF(%dsNamesMultiple%),
SELF.name_part_position :=IF(LEFT.item_id=RIGHT.item_id AND LEFT.name_id=RIGHT.name_id, LEFT.name_part_position + 1, 1);
SELF:=RIGHT));

dsResult :=SORT(%dsNamesSingle% + %dsNamesNewNamePartPositions% ,item_id,name_id,name_part_position);

ENDMACRO;