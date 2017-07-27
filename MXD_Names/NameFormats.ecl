export NameFormats :=MODULE

export L_NameFormatLayout :=RECORD
STRING name_Format;
UNSIGNED1 name_part_position;
Layouts.NamePartType name_part_type;
END;

export L_MultipleNameFormatLayout :=RECORD
STRING name_Format;
UNSIGNED1 name_part_position;
UNSIGNED1 name_id;
Layouts.NamePartType name_part_Type;
STRING new_name_format;
END;

// export L_NameFormatIDXLayout :=RECORD
// UNSIGNED4 nameFormat;
// UNSIGNED1 cnt;
// Layouts.NamePartType nameType;
// END;

export dsLNFNFormats :=DATASET(
[
////four words (PEREZ HERNANDEZ GLORIA SYLVIA )
{'LLFF',	1,	Layouts.NamePartType.LastName},
{'LLFF',	2,	Layouts.NamePartType.Matronymic},
{'LLFF',	3,	Layouts.NamePartType.FirstName},
{'LLFF',	4,	Layouts.NamePartType.MiddleName1},

{'LLF',	1,	Layouts.NamePartType.LastName},
{'LLF',	2,	Layouts.NamePartType.Matronymic},
{'LLF',	3,	Layouts.NamePartType.FirstName}
],L_NameFormatLayout);

//These are the formats to use when parsing names unless the name format
//matches one of the "exception" formats (multiple people, compound last names, etc)
export dsBRExceptionNameFormats := DATASET(
[

////four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'FFFL',	1,	Layouts.NamePartType.FirstName},
{'FFFL',	2,	Layouts.NamePartType.MiddleName1},
{'FFFL',	3,	Layouts.NamePartType.MiddleName2},
{'FFFL',	4,	Layouts.NamePartType.LastName},
////four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'FFFX',	1,	Layouts.NamePartType.FirstName},
{'FFFX',	2,	Layouts.NamePartType.MiddleName1},
{'FFFX',	3,	Layouts.NamePartType.MiddleName2},
{'FFFX',	4,	Layouts.NamePartType.LastName},
////four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'FFFF',	1,	Layouts.NamePartType.FirstName},
{'FFFF',	2,	Layouts.NamePartType.MiddleName1},
{'FFFF',	3,	Layouts.NamePartType.MiddleName2},
{'FFFF',	4,	Layouts.NamePartType.LastName},

////five words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'FFFFL',	1,	Layouts.NamePartType.FirstName},
{'FFFFL',	2,	Layouts.NamePartType.MiddleName1},
{'FFFFL',	3,	Layouts.NamePartType.MiddleName2},
{'FFFFL',	4,	Layouts.NamePartType.MiddleName3},
{'FFFFL',	5,	Layouts.NamePartType.LastName},
////five words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'FFFFF',	1,	Layouts.NamePartType.FirstName},
{'FFFFF',	2,	Layouts.NamePartType.MiddleName1},
{'FFFFF',	3,	Layouts.NamePartType.MiddleName2},
{'FFFFF',	4,	Layouts.NamePartType.MiddleName3},
{'FFFFF',	5,	Layouts.NamePartType.LastName},
////five words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'FFFFX',	1,	Layouts.NamePartType.FirstName},
{'FFFFX',	2,	Layouts.NamePartType.MiddleName1},
{'FFFFX',	3,	Layouts.NamePartType.MiddleName2},
{'FFFFX',	4,	Layouts.NamePartType.MiddleName3},
{'FFFFX',	5,	Layouts.NamePartType.LastName},

//four words w husbands last name(GLORIA SYLVIA PEREZ DE HERNANDEZ)
{'FFLH',	1,	Layouts.NamePartType.FirstName},
{'FFLH',	2,	Layouts.NamePartType.MiddleName1},
{'FFLH',	3,	Layouts.NamePartType.LastName},
{'FFLH',	4,	Layouts.NamePartType.HusbandsLastName},

//five words w husbands last name(GLORIA SYLVIA PEREZ DE HERNANDEZ)
{'FFLLH',	1,	Layouts.NamePartType.FirstName},
{'FFLLH',	2,	Layouts.NamePartType.MiddleName1},
{'FFLLH',	3,	Layouts.NamePartType.LastName},
{'FFLLH',	4,	Layouts.NamePartType.Matronymic},
{'FFLLH',	5,	Layouts.NamePartType.HusbandsLastName},

//3 words w husbands last name(GLORIA SYLVIA DE HERNANDEZ)
{'FLH',	1,	Layouts.NamePartType.FirstName},
{'FLH',	2,	Layouts.NamePartType.LastName},
{'FLH',	3,	Layouts.NamePartType.HusbandsLastName}

],L_NameFormatLayout);
//These are the formats to use when parsing names unless the name format
//matches one of the "exception" formats (multiple people, compound last names, etc)
export dsBRDefaultNameFormats := DATASET(
[

//one (GLORIA)
{'F',	1,	Layouts.NamePartType.FirstName},

//one (GLORIA)
{'L',	1,	Layouts.NamePartType.FirstName},

//one (GLORIA)
{'X',	1,	Layouts.NamePartType.FirstName},

//two words (GLORIA PEREZ)
{'..',	1,	Layouts.NamePartType.FirstName},
{'..',	2,	Layouts.NamePartType.LastName},

//three words (GLORIA PEREZ HERNANDEZ)
{'.F.',	1,	Layouts.NamePartType.FirstName},
{'.F.',	2,	Layouts.NamePartType.MiddleName1},
{'.F.',	3,	Layouts.NamePartType.LastName},

//three words (GLORIA PEREZ HERNANDEZ)
{'.L.',	1,	Layouts.NamePartType.FirstName},
{'.L.',	2,	Layouts.NamePartType.LastName},
{'.L.',	3,	Layouts.NamePartType.Matronymic},

//three words (GLORIA PEREZ HERNANDEZ)
{'.X.',	1,	Layouts.NamePartType.FirstName},
{'.X.',	2,	Layouts.NamePartType.LastName},
{'.X.',	3,	Layouts.NamePartType.Matronymic},

//three words w husband last name(GLORIA PEREZ DE HERNANDEZ)
{'..HU',	1,	Layouts.NamePartType.FirstName},
{'..HU',	2,	Layouts.NamePartType.LastName},
{'..HU',	3,	Layouts.NamePartType.HusbandsLastName},

//three words w husband last name(GLORIA PEREZ DE HERNANDEZ)
{'FLH',	1,	Layouts.NamePartType.FirstName},
{'FLH',	2,	Layouts.NamePartType.LastName},
{'FLH',	3,	Layouts.NamePartType.HusbandsLastName},

//four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'...F',	1,	Layouts.NamePartType.FirstName},
{'...F',	2,	Layouts.NamePartType.MiddleName1},
{'...F',	3,	Layouts.NamePartType.LastName},
{'...F',	4,	Layouts.NamePartType.Matronymic},

//four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'...L',	1,	Layouts.NamePartType.FirstName},
{'...L',	2,	Layouts.NamePartType.MiddleName1},
{'...L',	3,	Layouts.NamePartType.LastName},
{'...L',	4,	Layouts.NamePartType.Matronymic},

//four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'...X',	1,	Layouts.NamePartType.FirstName},
{'...X',	2,	Layouts.NamePartType.MiddleName1},
{'...X',	3,	Layouts.NamePartType.LastName},
{'...X',	4,	Layouts.NamePartType.Matronymic},

//four words w husbands last name(GLORIA SYLVIA PEREZ DE HERNANDEZ)
{'.F.H',	1,	Layouts.NamePartType.FirstName},
{'.F.H',	2,	Layouts.NamePartType.MiddleName1},
{'.F.H',	3,	Layouts.NamePartType.LastName},
{'.F.H',	4,	Layouts.NamePartType.HusbandsLastName},

//four words w husbands last name(GLORIA SYLVIA PEREZ DE HERNANDEZ)
{'.L.H',	1,	Layouts.NamePartType.FirstName},
{'.L.H',	2,	Layouts.NamePartType.LastName},
{'.L.H',	3,	Layouts.NamePartType.Matronymic},
{'.L.H',	4,	Layouts.NamePartType.HusbandsLastName},

//five words (GLORIA CARMEN SYLVIA PEREZ HERNANDEZ)
{'.....',	1,	Layouts.NamePartType.FirstName},
{'.....',	2,	Layouts.NamePartType.MiddleName1},
{'.....',	3,	Layouts.NamePartType.MiddleName2},
{'.....',	4,	Layouts.NamePartType.LastName},
{'.....',	5,	Layouts.NamePartType.Matronymic},

//six words (GLORIA CARMEN MARIA SYLVIA PEREZ HERNANDEZ)
{'......',	1,	Layouts.NamePartType.FirstName},
{'......',	2,	Layouts.NamePartType.MiddleName1},
{'......',	3,	Layouts.NamePartType.MiddleName2},
{'......',	4,	Layouts.NamePartType.MiddleName3},
{'......',	5,	Layouts.NamePartType.LastName},
{'......',	6,	Layouts.NamePartType.Matronymic},

//seven words (GLORIA CARMEN MARIA GUADALUPE SYLVIA PEREZ HERNANDEZ)
{'.......',	1,	Layouts.NamePartType.FirstName},
{'.......',	2,	Layouts.NamePartType.MiddleName1},
{'.......',	3,	Layouts.NamePartType.MiddleName2},
{'.......',	4,	Layouts.NamePartType.MiddleName3},
{'.......',	5,	Layouts.NamePartType.MiddleName4},
{'.......',	6,	Layouts.NamePartType.LastName},
{'.......',	7,	Layouts.NamePartType.Matronymic},


//eight words (GLORIA CARMEN MARIA GUADALUPE JOSE SYLVIA PEREZ HERNANDEZ)
{'........',	1,	Layouts.NamePartType.FirstName},
{'........',	2,	Layouts.NamePartType.MiddleName1},
{'........',	3,	Layouts.NamePartType.MiddleName2},
{'........',	4,	Layouts.NamePartType.MiddleName3},
{'........',	5,	Layouts.NamePartType.MiddleName4},
{'........',	6,	Layouts.NamePartType.MiddleName5},
{'........',	7,	Layouts.NamePartType.LastName},
{'........',	8,	Layouts.NamePartType.Matronymic}

],L_NameFormatLayout);


export dsMXDefaultNameFormats :=dsBRDefaultNameFormats;
//These are the formats to use when parsing names unless the name format
//matches one of the "exception" formats (multiple people, compound last names, etc)

export dsDocketDefaultNameFormats := DATASET(
[

//one (GLORIA)
{'F',	1,	Layouts.NamePartType.FirstName},

//one (GLORIA)
{'L',	1,	Layouts.NamePartType.FirstName},

//one (GLORIA)
{'X',	1,	Layouts.NamePartType.FirstName},

//two words (GLORIA PEREZ)
{'..',	1,	Layouts.NamePartType.FirstName},
{'..',	2,	Layouts.NamePartType.LastName},

//three words (GLORIA PEREZ HERNANDEZ)
// {'.F.',	1,	Layouts.NamePartType.FirstName},
// {'.F.',	2,	Layouts.NamePartType.MiddleName1},
// {'.F.',	3,	Layouts.NamePartType.LastName},

//three words (GLORIA PEREZ HERNANDEZ)
// {'.L.',	1,	Layouts.NamePartType.FirstName},
// {'.L.',	2,	Layouts.NamePartType.LastName},
// {'.L.',	3,	Layouts.NamePartType.Matronymic},

//three words (GLORIA PEREZ HERNANDEZ)
{'.FL',	1,	Layouts.NamePartType.FirstName},
{'.FL',	2,	Layouts.NamePartType.MiddleName1},
{'.FL',	3,	Layouts.NamePartType.LastName},

//three words (GLORIA PEREZ HERNANDEZ)
{'.LL',	1,	Layouts.NamePartType.FirstName},
{'.LL',	2,	Layouts.NamePartType.LastName},
{'.LL',	3,	Layouts.NamePartType.Matronymic},

//three words (GLORIA PEREZ HERNANDEZ)
{'.LX',	1,	Layouts.NamePartType.FirstName},
{'.LX',	2,	Layouts.NamePartType.LastName},
{'.LX',	3,	Layouts.NamePartType.Matronymic},

//three words (GLORIA PEREZ HERNANDEZ)
{'.LF',	1,	Layouts.NamePartType.FirstName},
{'.LF',	2,	Layouts.NamePartType.LastName},
{'.LF',	3,	Layouts.NamePartType.Matronymic},

//three words (GLORIA PEREZ HERNANDEZ)
{'.FH',	1,	Layouts.NamePartType.FirstName},
{'.FH',	2,	Layouts.NamePartType.MiddleName1},
{'.FH',	3,	Layouts.NamePartType.HusbandsLastName},

//three words (GLORIA PEREZ HERNANDEZ)
{'.LH',	1,	Layouts.NamePartType.FirstName},
{'.LH',	2,	Layouts.NamePartType.LastName},
{'.LH',	3,	Layouts.NamePartType.HusbandsLastName},


//three words (GLORIA PEREZ HERNANDEZ)
{'.X.',	1,	Layouts.NamePartType.FirstName},
{'.X.',	2,	Layouts.NamePartType.MiddleName1},
{'.X.',	3,	Layouts.NamePartType.LastName},

//four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'...F',	1,	Layouts.NamePartType.FirstName},
{'...F',	2,	Layouts.NamePartType.MiddleName1},
{'...F',	3,	Layouts.NamePartType.LastName},
{'...F',	4,	Layouts.NamePartType.Matronymic},

//four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'...L',	1,	Layouts.NamePartType.FirstName},
{'...L',	2,	Layouts.NamePartType.MiddleName1},
{'...L',	3,	Layouts.NamePartType.LastName},
{'...L',	4,	Layouts.NamePartType.Matronymic},

//four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'...X',	1,	Layouts.NamePartType.FirstName},
{'...X',	2,	Layouts.NamePartType.MiddleName1},
{'...X',	3,	Layouts.NamePartType.LastName},
{'...X',	4,	Layouts.NamePartType.Matronymic},

//four words w husbands last name(GLORIA SYLVIA PEREZ DE HERNANDEZ)
{'.F.H',	1,	Layouts.NamePartType.FirstName},
{'.F.H',	2,	Layouts.NamePartType.MiddleName1},
{'.F.H',	3,	Layouts.NamePartType.LastName},
{'.F.H',	4,	Layouts.NamePartType.HusbandsLastName},

//four words w husbands last name(GLORIA SYLVIA PEREZ DE HERNANDEZ)
{'.L.H',	1,	Layouts.NamePartType.FirstName},
{'.L.H',	2,	Layouts.NamePartType.LastName},
{'.L.H',	3,	Layouts.NamePartType.Matronymic},
{'.L.H',	4,	Layouts.NamePartType.HusbandsLastName},

//four words (GLORIA PEREZ HERNANDEZ)
{'.F.H',	1,	Layouts.NamePartType.FirstName},
{'.F.H',	2,	Layouts.NamePartType.MiddleName1},
{'.F.H',	3,	Layouts.NamePartType.LastName},
{'.F.H',	4,	Layouts.NamePartType.HusbandsLastName},

//five words (GLORIA CARMEN SYLVIA PEREZ HERNANDEZ)
{'....L',	1,	Layouts.NamePartType.FirstName},
{'....L',	2,	Layouts.NamePartType.MiddleName1},
{'....L',	3,	Layouts.NamePartType.MiddleName2},
{'....L',	4,	Layouts.NamePartType.LastName},
{'....L',	5,	Layouts.NamePartType.Matronymic},

//five words (GLORIA CARMEN SYLVIA PEREZ HERNANDEZ)
{'....H',	1,	Layouts.NamePartType.FirstName},
{'....H',	2,	Layouts.NamePartType.MiddleName1},
{'....H',	3,	Layouts.NamePartType.LastName},
{'....H',	4,	Layouts.NamePartType.Matronymic},
{'....H',	5,	Layouts.NamePartType.HusbandsLastName},

//six words (GLORIA CARMEN MARIA SYLVIA PEREZ HERNANDEZ)
{'.....H',	1,	Layouts.NamePartType.FirstName},
{'.....H',	2,	Layouts.NamePartType.MiddleName1},
{'.....H',	3,	Layouts.NamePartType.MiddleName2},
{'.....H',	4,	Layouts.NamePartType.LastName},
{'.....H',	5,	Layouts.NamePartType.Matronymic},
{'.....H',	6,	Layouts.NamePartType.HusbandsLastName},

//six words (GLORIA CARMEN MARIA SYLVIA PEREZ HERNANDEZ)
{'.....L',	1,	Layouts.NamePartType.FirstName},
{'.....L',	2,	Layouts.NamePartType.MiddleName1},
{'.....L',	3,	Layouts.NamePartType.MiddleName2},
{'.....L',	4,	Layouts.NamePartType.MiddleName3},
{'.....L',	5,	Layouts.NamePartType.LastName},
{'.....L',	6,	Layouts.NamePartType.Matronymic},

//seven words (GLORIA CARMEN MARIA GUADALUPE SYLVIA PEREZ HERNANDEZ)
{'.......',	1,	Layouts.NamePartType.FirstName},
{'.......',	2,	Layouts.NamePartType.MiddleName1},
{'.......',	3,	Layouts.NamePartType.MiddleName2},
{'.......',	4,	Layouts.NamePartType.MiddleName3},
{'.......',	5,	Layouts.NamePartType.MiddleName4},
{'.......',	6,	Layouts.NamePartType.LastName},
{'.......',	7,	Layouts.NamePartType.Matronymic},


//eight words (GLORIA CARMEN MARIA GUADALUPE JOSE SYLVIA PEREZ HERNANDEZ)
{'........',	1,	Layouts.NamePartType.FirstName},
{'........',	2,	Layouts.NamePartType.MiddleName1},
{'........',	3,	Layouts.NamePartType.MiddleName2},
{'........',	4,	Layouts.NamePartType.MiddleName3},
{'........',	5,	Layouts.NamePartType.MiddleName4},
{'........',	6,	Layouts.NamePartType.MiddleName5},
{'........',	7,	Layouts.NamePartType.LastName},
{'........',	8,	Layouts.NamePartType.Matronymic}

],L_NameFormatLayout);

export dsFirstOnlyNameFormats := DATASET(
[
//(Olga E escalante)
{'.',	1, 	Layouts.NamePartType.FirstName},

{'..',	1, 	Layouts.NamePartType.FirstName},
{'..',	2, 	Layouts.NamePartType.MiddleName1},

{'...',	1, 	Layouts.NamePartType.FirstName},
{'...',	2, 	Layouts.NamePartType.MiddleName1},
{'...',	3, 	Layouts.NamePartType.MiddleName2},

{'....',	1, 	Layouts.NamePartType.FirstName},
{'....',	2, 	Layouts.NamePartType.MiddleName1},
{'....',	3, 	Layouts.NamePartType.MiddleName2},
{'....',	4, 	Layouts.NamePartType.MiddleName3},

{'.....',	1, 	Layouts.NamePartType.FirstName},
{'.....',	2, 	Layouts.NamePartType.MiddleName1},
{'.....',	3, 	Layouts.NamePartType.MiddleName2},
{'.....',	4, 	Layouts.NamePartType.MiddleName3},
{'.....',	5, 	Layouts.NamePartType.MiddleName4},

{'......',	1, 	Layouts.NamePartType.FirstName},
{'......',	2, 	Layouts.NamePartType.MiddleName1},
{'......',	3, 	Layouts.NamePartType.MiddleName2},
{'......',	4, 	Layouts.NamePartType.MiddleName3},
{'......',	5, 	Layouts.NamePartType.MiddleName4},
{'......',	6, 	Layouts.NamePartType.MiddleName5}


],L_NameFormatLayout);


export dsPropertyDefaultNameFormats := DATASET(
[

//one (GLORIA)
{'F',	1,	Layouts.NamePartType.FirstName},

//one (GLORIA)
{'L',	1,	Layouts.NamePartType.FirstName},

//one (GLORIA)
{'X',	1,	Layouts.NamePartType.FirstName},

//two words (GLORIA PEREZ)
{'..',	1,	Layouts.NamePartType.FirstName},
{'..',	2,	Layouts.NamePartType.LastName},

//three words (GLORIA PEREZ HERNANDEZ)
// {'.F.',	1,	Layouts.NamePartType.FirstName},
// {'.F.',	2,	Layouts.NamePartType.MiddleName1},
// {'.F.',	3,	Layouts.NamePartType.LastName},

//three words (GLORIA PEREZ HERNANDEZ)
// {'.L.',	1,	Layouts.NamePartType.FirstName},
// {'.L.',	2,	Layouts.NamePartType.LastName},
// {'.L.',	3,	Layouts.NamePartType.Matronymic},

//three words (GLORIA PEREZ HERNANDEZ)
{'.FL',	1,	Layouts.NamePartType.FirstName},
{'.FL',	2,	Layouts.NamePartType.MiddleName1},
{'.FL',	3,	Layouts.NamePartType.LastName},

//three words (GLORIA PEREZ HERNANDEZ)
{'.LL',	1,	Layouts.NamePartType.FirstName},
{'.LL',	2,	Layouts.NamePartType.LastName},
{'.LL',	3,	Layouts.NamePartType.Matronymic},

//three words (GLORIA PEREZ HERNANDEZ)
{'.LX',	1,	Layouts.NamePartType.FirstName},
{'.LX',	2,	Layouts.NamePartType.LastName},
{'.LX',	3,	Layouts.NamePartType.Matronymic},

//three words (GLORIA PEREZ HERNANDEZ)
{'.LF',	1,	Layouts.NamePartType.FirstName},
{'.LF',	2,	Layouts.NamePartType.LastName},
{'.LF',	3,	Layouts.NamePartType.Matronymic},

//three words (GLORIA PEREZ HERNANDEZ)
{'.FH',	1,	Layouts.NamePartType.FirstName},
{'.FH',	2,	Layouts.NamePartType.MiddleName1},
{'.FH',	3,	Layouts.NamePartType.HusbandsLastName},

//three words (GLORIA PEREZ HERNANDEZ)
{'.LH',	1,	Layouts.NamePartType.FirstName},
{'.LH',	2,	Layouts.NamePartType.LastName},
{'.LH',	3,	Layouts.NamePartType.HusbandsLastName},

//three words (GLORIA PEREZ HERNANDEZ)
{'.XH',	1,	Layouts.NamePartType.FirstName},
{'.XH',	2,	Layouts.NamePartType.LastName},
{'.XH',	3,	Layouts.NamePartType.HusbandsLastName},

//three words (GLORIA PEREZ HERNANDEZ)
{'FXL',	1,	Layouts.NamePartType.FirstName},
{'FXL',	2,	Layouts.NamePartType.MiddleName1},
{'FXL',	3,	Layouts.NamePartType.LastName},

//four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'...F',	1,	Layouts.NamePartType.FirstName},
{'...F',	2,	Layouts.NamePartType.MiddleName1},
{'...F',	3,	Layouts.NamePartType.LastName},
{'...F',	4,	Layouts.NamePartType.Matronymic},

//four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'...L',	1,	Layouts.NamePartType.FirstName},
{'...L',	2,	Layouts.NamePartType.MiddleName1},
{'...L',	3,	Layouts.NamePartType.LastName},
{'...L',	4,	Layouts.NamePartType.Matronymic},

//four words (GLORIA SYLVIA PEREZ HERNANDEZ)
{'...X',	1,	Layouts.NamePartType.FirstName},
{'...X',	2,	Layouts.NamePartType.MiddleName1},
{'...X',	3,	Layouts.NamePartType.LastName},
{'...X',	4,	Layouts.NamePartType.Matronymic},

//four words w husbands last name(GLORIA SYLVIA PEREZ DE HERNANDEZ)
{'.F.H',	1,	Layouts.NamePartType.FirstName},
{'.F.H',	2,	Layouts.NamePartType.MiddleName1},
{'.F.H',	3,	Layouts.NamePartType.LastName},
{'.F.H',	4,	Layouts.NamePartType.HusbandsLastName},

//four words w husbands last name(GLORIA SYLVIA PEREZ DE HERNANDEZ)
{'.L.H',	1,	Layouts.NamePartType.FirstName},
{'.L.H',	2,	Layouts.NamePartType.LastName},
{'.L.H',	3,	Layouts.NamePartType.Matronymic},
{'.L.H',	4,	Layouts.NamePartType.HusbandsLastName},

//four words (GLORIA PEREZ HERNANDEZ)
{'.F.H',	1,	Layouts.NamePartType.FirstName},
{'.F.H',	2,	Layouts.NamePartType.MiddleName1},
{'.F.H',	3,	Layouts.NamePartType.LastName},
{'.F.H',	4,	Layouts.NamePartType.HusbandsLastName},

//five words (GLORIA CARMEN SYLVIA PEREZ HERNANDEZ)
{'....L',	1,	Layouts.NamePartType.FirstName},
{'....L',	2,	Layouts.NamePartType.MiddleName1},
{'....L',	3,	Layouts.NamePartType.MiddleName2},
{'....L',	4,	Layouts.NamePartType.LastName},
{'....L',	5,	Layouts.NamePartType.Matronymic},

//five words (GLORIA CARMEN SYLVIA PEREZ HERNANDEZ)
{'....H',	1,	Layouts.NamePartType.FirstName},
{'....H',	2,	Layouts.NamePartType.MiddleName1},
{'....H',	3,	Layouts.NamePartType.LastName},
{'....H',	4,	Layouts.NamePartType.Matronymic},
{'....H',	5,	Layouts.NamePartType.HusbandsLastName},

//six words (GLORIA CARMEN MARIA SYLVIA PEREZ HERNANDEZ)
{'.....H',	1,	Layouts.NamePartType.FirstName},
{'.....H',	2,	Layouts.NamePartType.MiddleName1},
{'.....H',	3,	Layouts.NamePartType.MiddleName2},
{'.....H',	4,	Layouts.NamePartType.LastName},
{'.....H',	5,	Layouts.NamePartType.Matronymic},
{'.....H',	6,	Layouts.NamePartType.HusbandsLastName},

//six words (GLORIA CARMEN MARIA SYLVIA PEREZ HERNANDEZ)
{'.....L',	1,	Layouts.NamePartType.FirstName},
{'.....L',	2,	Layouts.NamePartType.MiddleName1},
{'.....L',	3,	Layouts.NamePartType.MiddleName2},
{'.....L',	4,	Layouts.NamePartType.MiddleName3},
{'.....L',	5,	Layouts.NamePartType.LastName},
{'.....L',	6,	Layouts.NamePartType.Matronymic},

//seven words (GLORIA CARMEN MARIA GUADALUPE SYLVIA PEREZ HERNANDEZ)
{'.......',	1,	Layouts.NamePartType.FirstName},
{'.......',	2,	Layouts.NamePartType.MiddleName1},
{'.......',	3,	Layouts.NamePartType.MiddleName2},
{'.......',	4,	Layouts.NamePartType.MiddleName3},
{'.......',	5,	Layouts.NamePartType.MiddleName4},
{'.......',	6,	Layouts.NamePartType.LastName},
{'.......',	7,	Layouts.NamePartType.Matronymic},


//eight words (GLORIA CARMEN MARIA GUADALUPE JOSE SYLVIA PEREZ HERNANDEZ)
{'........',	1,	Layouts.NamePartType.FirstName},
{'........',	2,	Layouts.NamePartType.MiddleName1},
{'........',	3,	Layouts.NamePartType.MiddleName2},
{'........',	4,	Layouts.NamePartType.MiddleName3},
{'........',	5,	Layouts.NamePartType.MiddleName4},
{'........',	6,	Layouts.NamePartType.MiddleName5},
{'........',	7,	Layouts.NamePartType.LastName},
{'........',	8,	Layouts.NamePartType.Matronymic}

],L_NameFormatLayout);

export dsDocketMultipleNameFormats := DATASET(
[
//(Olga E escalante)
{'.Y.',	1, 	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.Y.',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA Y JOSE PEREZ)
{'.Y.X',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'.Y.X',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'.Y.X',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'.Y.X',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA Y JOSE PEREZ)
{'.Y.L',	1,	1,	Layouts.NamePartType.FirstName,'FL'},
{'.Y.L',	3,	2,	Layouts.NamePartType.FirstName,'FL'},
{'.Y.L',	4,	1,	Layouts.NamePartType.LastName,'FL'},
{'.Y.L',	4,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA ET AL JOSE PEREZ)
{'FE.L',	1,	1,	Layouts.NamePartType.FirstName,'F'},
{'FE.L',	3,	2,	Layouts.NamePartType.FirstName,'FL'},
{'FE.L',	4,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA ET AL JOSE PEREZ)
{'LE.L',	1,	1,	Layouts.NamePartType.LastName,'L'},
{'LE.L',	3,	2,	Layouts.NamePartType.FirstName,'FL'},
{'LE.L',	4,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA ET AL JOSE PEREZ)
{'FE.FL',	1,	1,	Layouts.NamePartType.FirstName,'F'},
{'FE.FL',	3,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'FE.FL',	4,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'FE.FL',	5,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA ET AL JOSE PEREZ)
{'FE.LL',	1,	1,	Layouts.NamePartType.FirstName,'F'},
{'FE.LL',	3,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'FE.LL',	4,	2,	Layouts.NamePartType.LastName,'FLL'},
{'FE.LL',	5,	2,	Layouts.NamePartType.Matronymic,'FLL'},


//(GLORIA ET AL JOSE PEREZ)
{'FLYFLL',	1,	1,	Layouts.NamePartType.FirstName,'FL'},
{'FLYFLL',	2,	1,	Layouts.NamePartType.LastName,'FL'},
{'FLYFLL',	4,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'FLYFLL',	5,	2,	Layouts.NamePartType.LastName,'FLL'},
{'FLYFLL',	6,	2,	Layouts.NamePartType.Matronymic,'FLL'},


//(GLORIA ET AL JOSE PEREZ)
{'LE.FL',	1,	1,	Layouts.NamePartType.LastName,'L'},
{'LE.FL',	3,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'LE.FL',	4,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'LE.FL',	5,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA ET AL JOSE PEREZ)
{'LE.LL',	1,	1,	Layouts.NamePartType.LastName,'L'},
{'LE.LL',	3,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'LE.LL',	4,	2,	Layouts.NamePartType.LastName,'FLL'},
{'LE.LL',	5,	2,	Layouts.NamePartType.Matronymic,'FLL'},


//SEVEN

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'....Y.L.',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'....Y.L.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'....Y.L.',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'....Y.L.',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'....Y.L.',	6,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'....Y.L.',	7,	2,	Layouts.NamePartType.LastName,'FLL'},
{'....Y.L.',	8,	2,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'....Y.L.',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'....Y.L.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'....Y.L.',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'....Y.L.',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'....Y.L.',	6,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'....Y.L.',	7,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'....Y.L.',	8,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'....Y..',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'....Y..',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'....Y..',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'....Y..',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'....Y..',	6,	2,	Layouts.NamePartType.FirstName,'FL'},
{'....Y..',	7,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'.F.Y..',	1,	1,	Layouts.NamePartType.FirstName,'FFL'},
{'.F.Y..',	2,	1,	Layouts.NamePartType.MiddleName1,'FFL'},
{'.F.Y..',	3,	1,	Layouts.NamePartType.LastName,'FFL'},
{'.F.Y..',	5,	2,	Layouts.NamePartType.FirstName,'FL'},
{'.F.Y..',	6,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'...Y..',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'...Y..',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'...Y..',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'...Y..',	5,	2,	Layouts.NamePartType.FirstName,'FL'},
{'...Y..',	6,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA Y JOSE HERNANDEZ PEREZ)
{'.Y.L.',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.L.',	3,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.L.',	4,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.Y.L.',	5,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.L.',	4,	2,	Layouts.NamePartType.LastName,'FLL'},
{'.Y.L.',	5,	2,	Layouts.NamePartType.Matronymic,'FLL'},


//(GLORIA Y JOSE T PEREZ)
{'.Y.X.',	1,	1,		Layouts.NamePartType.FirstName,'FLL'},
{'.Y.X.',	3,	2,		Layouts.NamePartType.FirstName,'FLL'},
{'.Y.X.',	4,	1,		Layouts.NamePartType.LastName,'FLL'},
{'.Y.X.',	5,	1,		Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.X.',	4,	2,		Layouts.NamePartType.LastName,'FLL'},
{'.Y.X.',	5,	2,		Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'.Y.F.',	1,	1,	Layouts.NamePartType.FirstName,'FL'},
{'.Y.F.',	3,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'.Y.F.',	4,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'.Y.F.',	5,	1,	Layouts.NamePartType.LastName,'FL'},
{'.Y.F.',	5,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'.F.Y.F.',	1,	1,	Layouts.NamePartType.FirstName,'FFL'},
{'.F.Y.F.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFL'},
{'.F.Y.F.',	3,	1,	Layouts.NamePartType.LastName,'FFL'},
{'.F.Y.F.',	5,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'.F.Y.F.',	6,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'.F.Y.F.',	7,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'.F.(Y|E).L.',	1,	1,	Layouts.NamePartType.FirstName,'FFL'},
{'.F.(Y|E).L.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFL'},
{'.F.(Y|E).L.',	3,	1,	Layouts.NamePartType.LastName,'FFL'},
{'.F.(Y|E).L.',	5,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'.F.(Y|E).L.',	6,	2,	Layouts.NamePartType.LastName,'FLL'},
{'.F.(Y|E).L.',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},


//(GLORIA Y JOSE PEDRO PEREZ)
{'.L.(Y|E).L.',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.L.(Y|E).L.',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.L.(Y|E).L.',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.L.(Y|E).L.',	5,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'.L.(Y|E).L.',	6,	2,	Layouts.NamePartType.LastName,'FLL'},
{'.L.(Y|E).L.',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'.L.Y.F.',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.L.Y.F.',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.L.Y.F.',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.L.Y.F.',	5,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'.L.Y.F.',	6,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'.L.Y.F.',	7,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'.L.Y....',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.L.Y....',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.L.Y....',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.L.Y....',	5,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'.L.Y....',	6,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'.L.Y....',	7,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'.L.Y....',	8,	2,	Layouts.NamePartType.Matronymic,'FFLL'},


//(GLORIA Y JOSE PEDRO PEREZ)
{'.F.Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFL'},
{'.F.Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFL'},
{'.F.Y....',	3,	1,	Layouts.NamePartType.LastName,'FFL'},
{'.F.Y....',	5,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'.F.Y....',	6,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'.F.Y....',	7,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'.F.Y....',	8,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'FFY....',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'FFY....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'FFY....',	4,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'FFY....',	5,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'FFY....',	6,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'FFY....',	7,	2,	Layouts.NamePartType.Matronymic,'FFLL'},
{'FFY....',	6,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'FFY....',	7,	1,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'FLY....',	1,	1,	Layouts.NamePartType.FirstName,'FL'},
{'FLY....',	2,	1,	Layouts.NamePartType.LastName,'FL'},
{'FLY....',	4,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'FLY....',	5,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'FLY....',	6,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'FLY....',	7,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'....Y.F.',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'....Y.F.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'....Y.F.',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'....Y.F.',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'....Y.F.',	6,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'....Y.F.',	7,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'....Y.F.',	8,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'....Y.L.',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'....Y.L.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'....Y.L.',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'....Y.L.',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'....Y.L.',	6,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'....Y.L.',	7,	2,	Layouts.NamePartType.LastName,'FLL'},
{'....Y.L.',	8,	2,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'....Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'....Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'....Y....',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'....Y....',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'....Y....',	6,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'....Y....',	7,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'....Y....',	8,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'....Y....',	9,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'...Y...Y....',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'...Y...Y....',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'...Y...Y....',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'...Y...Y....',	5,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'...Y...Y....',	6,	2,	Layouts.NamePartType.LastName,'FLL'},
{'...Y...Y....',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},
{'...Y...Y....',	9,	3,	Layouts.NamePartType.FirstName,'FFLL'},
{'...Y...Y....',	10,	3,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'...Y...Y....',	11,	3,	Layouts.NamePartType.LastName,'FFLL'},
{'...Y...Y....',	12,	3,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'FLLFLLYFLL',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'FLLFLLYFLL',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'FLLFLLYFLL',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'FLLFLLYFLL',	4,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'FLLFLLYFLL',	5,	2,	Layouts.NamePartType.LastName,'FLL'},
{'FLLFLLYFLL',	6,	2,	Layouts.NamePartType.Matronymic,'FLL'},
{'FLLFLLYFLL',	8,	3,	Layouts.NamePartType.FirstName,'FLL'},
{'FLLFLLYFLL',	9,	3,	Layouts.NamePartType.LastName,'FLL'},
{'FLLFLLYFLL',	10,	3,	Layouts.NamePartType.Matronymic,'FLL'},

{'FLLFLLYFFLL',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'FLLFLLYFFLL',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'FLLFLLYFFLL',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'FLLFLLYFFLL',	4,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'FLLFLLYFFLL',	5,	2,	Layouts.NamePartType.LastName,'FLL'},
{'FLLFLLYFFLL',	6,	2,	Layouts.NamePartType.Matronymic,'FLL'},
{'FLLFLLYFFLL',	8,	3,	Layouts.NamePartType.FirstName,'FLL'},
{'FLLFFLLYFLL',	9,	3,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'FLLFLLYFFLL',	10,	3,	Layouts.NamePartType.LastName,'FLL'},
{'FLLFLLYFFLL',	11,	3,	Layouts.NamePartType.Matronymic,'FLL'},

{'FLLFFLLYFLL',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'FLLFFLLYFLL',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'FLLFFLLYFLL',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'FLLFFLLYFLL',	4,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'FLLFFLLYFLL',	5,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'FLLFFLLYFLL',	6,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'FLLFFLLYFLL',	7,	2,	Layouts.NamePartType.Matronymic,'FFLL'},
{'FLLFFLLYFLL',	9,	3,	Layouts.NamePartType.FirstName,'FLL'},
{'FLLFFLLYFLL',	10,	3,	Layouts.NamePartType.LastName,'FLL'},
{'FLLFFLLYFLL',	11,	3,	Layouts.NamePartType.Matronymic,'FLL'},


{'FFLLFLLYFLL',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'FFLLFLLYFLL',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'FFLLFLLYFLL',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'FFLLFLLYFLL',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'FFLLFLLYFLL',	5,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'FFLLFLLYFLL',	6,	2,	Layouts.NamePartType.LastName,'FLL'},
{'FFLLFLLYFLL',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},
{'FFLLFLLYFLL',	9,	3,	Layouts.NamePartType.FirstName,'FLL'},
{'FFLLFLLYFLL',	10,	3,	Layouts.NamePartType.LastName,'FLL'},
{'FFLLFLLYFLL',	11,	3,	Layouts.NamePartType.Matronymic,'FLL'},

{'FFLLFFLLYFLL',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'FFLLFFLLYFLL',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'FFLLFFLLYFLL',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'FFLLFFLLYFLL',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'FFLLFFLLYFLL',	5,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'FFLLFFLLYFLL',	6,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'FFLLFFLLYFLL',	7,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'FFLLFFLLYFLL',	8,	2,	Layouts.NamePartType.Matronymic,'FFLL'},
{'FFLLFFLLYFLL',	10,	3,	Layouts.NamePartType.FirstName,'FLL'},
{'FFLLFFLLYFLL',	11,	3,	Layouts.NamePartType.LastName,'FLL'},
{'FFLLFFLLYFLL',	12,	3,	Layouts.NamePartType.Matronymic,'FLL'}

/*        
FEFFLL              
FFF                 
FFFFLX              
FFLLELL             
     
FLLEFLL             
FYFFLL              
FFLLEFLL            
FFLLFFLLFFLLYFFLL   
FLLFFLLFFLLYFLL     
FLLFLLFLLFFLLYFFLLFF
FLLYFFLLL           
FLLYFFLYXL          
FLYFFL              
*/
/*

//(GLORIA Y JOSE PEDRO HERNANDEZ PEREZ)
{'.Y....',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y....',	3,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'.Y....',	4,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'.Y....',	5,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.Y....',	6,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y....',	5,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'.Y....',	6,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA Y JOSE PEDRO HERNANDEZ PEREZ)
{'.Y.....',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.....',	3,	2,	Layouts.NamePartType.FirstName,'FFFLL'},
{'.Y.....',	4,	2,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'.Y.....',	5,	2,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'.Y.....',	6,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.Y.....',	7,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.....',	6,	2,	Layouts.NamePartType.LastName,'FFFLL'},
{'.Y.....',	7,	2,	Layouts.NamePartType.Matronymic,'FFFLL'},


//(GLORIA MARIA Y JOSE PEREZ)
{'..Y..',	1,	1,	Layouts.NamePartType.FirstName,'FFL'},
{'..Y..',	2,	1,	Layouts.NamePartType.MiddleName1,'FFL'},
{'..Y..',	4,	2,	Layouts.NamePartType.FirstName,'FL'},
{'..Y..',	5,	1,	Layouts.NamePartType.LastName,'FFL'},
{'..Y..',	5,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA MARIA Y JOSE HERNANDEZ PEREZ)
{'..Y.L.',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y.L.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},

{'..Y.L.',	4,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'..Y.L.',	5,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y.L.',	6,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y.L.',	5,	2,	Layouts.NamePartType.LastName,'FLL'},
{'..Y.L.',	6,	2,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA MARIA Y JOSE T PEREZ)
{'..Y.X.',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y.X.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y.X.',	4,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'..Y.X.',	5,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y.X.',	6,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y.X.',	5,	2,	Layouts.NamePartType.LastName,'FLL'},
{'..Y.X.',	6,	2,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA MARIA Y JOSE PEDRO PEREZ)
{'..Y.F.',	1,	1,	Layouts.NamePartType.FirstName,'FFL'},
{'..Y.F.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFL'},
{'..Y.F.',	4,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'..Y.F.',	5,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'..Y.F.',	6,	1,	Layouts.NamePartType.LastName,'FFL'},
{'..Y.F.',	6,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA MARIA Y JOSE PEDRO HERNANDEZ PEREZ)
{'..Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y....',	4,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y....',	5,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y....',	6,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y....',	7,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y....',	6,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y....',	7,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA MARIA Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'..Y.....',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y.....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y.....',	4,	2,	Layouts.NamePartType.FirstName,'FFFLL'},
{'..Y.....',	5,	2,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'..Y.....',	6,	2,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'..Y.....',	7,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y.....',	8,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y.....',	7,	2,	Layouts.NamePartType.LastName,'FFFLL'},
{'..Y.....',	8,	2,	Layouts.NamePartType.Matronymic,'FFFLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEREZ)
{'...Y..',	1,	1,	Layouts.NamePartType.FirstName,'FFFL'},
{'...Y..',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFL'},
{'...Y..',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFL'},
{'...Y..',	5,	2,	Layouts.NamePartType.FirstName,'FL'},
{'...Y..',	6,	1,	Layouts.NamePartType.LastName,'FFFL'},
{'...Y..',	6,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO PEREZ)
{'...Y.F.',	1,	1,	Layouts.NamePartType.FirstName,'FFFL'},
{'...Y.F.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFL'},
{'...Y.F.',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFL'},
{'...Y.F.',	5,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'...Y.F.',	6,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'...Y.F.',	7,	1,	Layouts.NamePartType.LastName,'FFFL'},
{'...Y.F.',	7,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA MARIA GUADALUPE Y JOSE HERNANDEZ PEREZ)
{'...Y.L.',	1,	1,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y.L.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y.L.',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y.L.',	5,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'...Y.L.',	6,	1,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y.L.',	7,	1,	Layouts.NamePartType.Matronymic,'FFFLL'},
{'...Y.L.',	6,	2,	Layouts.NamePartType.LastName,'FLL'},
{'...Y.L.',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},


//(GLORIA MARIA GUADALUPE Y JOSE T PEREZ)
{'...Y.X.',	1,	1,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y.X.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y.X.',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y.X.',	5,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'...Y.X.',	6,	1,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y.X.',	7,	1,	Layouts.NamePartType.Matronymic,'FFFLL'},
{'...Y.X.',	6,	2,	Layouts.NamePartType.LastName,'FLL'},
{'...Y.X.',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON PEREZ)
{'...Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y....',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y....',	5,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'...Y....',	6,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'...Y....',	7,	1,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y....',	8,	1,	Layouts.NamePartType.Matronymic,'FFFLL'},
{'...Y....',	7,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'...Y....',	8,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'...Y.....',	1,	1,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y.....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y.....',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y.....',	5,	2,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y.....',	6,	2,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y.....',	7,	2,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y.....',	8,	1,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y.....',	9,	1,	Layouts.NamePartType.Matronymic,'FFFLL'},
{'...Y.....',	8,	2,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y.....',	9,	2,	Layouts.NamePartType.Matronymic,'FFFLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'....Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFFFLL'},
{'....Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFFLL'},
{'....Y....',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFFLL'},
{'....Y....',	4,	1,	Layouts.NamePartType.MiddleName3,'FFFFLL'},
{'....Y....',	6,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'....Y....',	7,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'....Y....',	8,	1,	Layouts.NamePartType.LastName,'FFFFLL'},
{'....Y....',	9,	1,	Layouts.NamePartType.Matronymic,'FFFFLL'},
{'....Y....',	8,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'....Y....',	9,	2,	Layouts.NamePartType.Matronymic,'FFLL'},


//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'..Y..Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y....',	4,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y....',	5,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y....',	7,	3,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y....',	8,	3,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y....',	9,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y....',	10,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y..Y....',	9,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y....',	10,	2,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y..Y....',	9,	3,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y....',	10,	3,	Layouts.NamePartType.Matronymic,'FFLL'},


//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'..Y..Y...',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y...',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y...',	4,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y...',	5,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y...',	7,	3,	Layouts.NamePartType.FirstName,'FLL'},
{'..Y..Y...',	8,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y...',	9,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y..Y...',	8,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y...',	9,	2,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y..Y...',	8,	3,	Layouts.NamePartType.LastName,'FLL'},
{'..Y..Y...',	9,	3,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA Y GUADALUPE Y JOSE HERNANDEZ PEREZ)
{'.Y.Y...',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.Y...',	3,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.Y...',	5,	3,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.Y...',	6,	1,	Layouts.NamePartType.Lastname,'FLL'},
{'.Y.Y...',	7,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.Y...',	6,	2,	Layouts.NamePartType.Lastname,'FLL'},
{'.Y.Y...',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.Y...',	6,	3,	Layouts.NamePartType.Lastname,'FLL'},
{'.Y.Y...',	7,	3,	Layouts.NamePartType.Matronymic,'FLL'}
*/
],L_MultipleNameFormatLayout);

export dsBRMultipleNameFormats := DATASET(
[
//(Olga E escalante)
{'.Y.',	1, 	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.',	2,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.Y.',	3,	1,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA Y JOSE PEREZ)
{'.Y.X',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'.Y.X',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'.Y.X',	3,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'.Y.X',	4,	1,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA Y JOSE PEREZ)
{'.Y.L',	1,	1,	Layouts.NamePartType.FirstName,'FL'},
{'.Y.L',	3,	2,	Layouts.NamePartType.FirstName,'FL'},
{'.Y.L',	4,	1,	Layouts.NamePartType.LastName,'FL'},
{'.Y.L',	4,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA Y JOSE HERNANDEZ PEREZ)
{'.Y.L.',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.L.',	3,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.L.',	4,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.Y.L.',	5,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.L.',	4,	2,	Layouts.NamePartType.LastName,'FLL'},
{'.Y.L.',	5,	2,	Layouts.NamePartType.Matronymic,'FLL'},


//(GLORIA Y JOSE T PEREZ)
{'.Y.X.',	1,	1,		Layouts.NamePartType.FirstName,'FLL'},
{'.Y.X.',	3,	2,		Layouts.NamePartType.FirstName,'FLL'},
{'.Y.X.',	4,	1,		Layouts.NamePartType.LastName,'FLL'},
{'.Y.X.',	5,	1,		Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.X.',	4,	2,		Layouts.NamePartType.LastName,'FLL'},
{'.Y.X.',	5,	2,		Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA Y JOSE PEDRO PEREZ)
{'.Y.F.',	1,	1,	Layouts.NamePartType.FirstName,'FL'},

{'.Y.F.',	3,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'.Y.F.',	4,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'.Y.F.',	5,	1,	Layouts.NamePartType.LastName,'FL'},
{'.Y.F.',	5,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA Y JOSE PEDRO HERNANDEZ PEREZ)
{'.Y....',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y....',	3,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'.Y....',	4,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'.Y....',	5,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.Y....',	6,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y....',	5,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'.Y....',	6,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA Y JOSE PEDRO HERNANDEZ PEREZ)
{'.Y.....',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.....',	3,	2,	Layouts.NamePartType.FirstName,'FFFLL'},
{'.Y.....',	4,	2,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'.Y.....',	5,	2,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'.Y.....',	6,	1,	Layouts.NamePartType.LastName,'FLL'},
{'.Y.....',	7,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.....',	6,	2,	Layouts.NamePartType.LastName,'FFFLL'},
{'.Y.....',	7,	2,	Layouts.NamePartType.Matronymic,'FFFLL'},


//(GLORIA MARIA Y JOSE PEREZ)
{'..Y..',	1,	1,	Layouts.NamePartType.FirstName,'FFL'},
{'..Y..',	2,	1,	Layouts.NamePartType.MiddleName1,'FFL'},
{'..Y..',	4,	2,	Layouts.NamePartType.FirstName,'FL'},
{'..Y..',	5,	1,	Layouts.NamePartType.LastName,'FFL'},
{'..Y..',	5,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA MARIA Y JOSE HERNANDEZ PEREZ)
{'..Y.L.',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y.L.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},

{'..Y.L.',	4,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'..Y.L.',	5,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y.L.',	6,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y.L.',	5,	2,	Layouts.NamePartType.LastName,'FLL'},
{'..Y.L.',	6,	2,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA MARIA Y JOSE T PEREZ)
{'..Y.X.',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y.X.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y.X.',	4,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'..Y.X.',	5,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y.X.',	6,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y.X.',	5,	2,	Layouts.NamePartType.LastName,'FLL'},
{'..Y.X.',	6,	2,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA MARIA Y JOSE PEDRO PEREZ)
{'..Y.F.',	1,	1,	Layouts.NamePartType.FirstName,'FFL'},
{'..Y.F.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFL'},
{'..Y.F.',	4,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'..Y.F.',	5,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'..Y.F.',	6,	1,	Layouts.NamePartType.LastName,'FFL'},
{'..Y.F.',	6,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA MARIA Y JOSE PEDRO HERNANDEZ PEREZ)
{'..Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y....',	4,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y....',	5,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y....',	6,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y....',	7,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y....',	6,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y....',	7,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA MARIA Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'..Y.....',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y.....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y.....',	4,	2,	Layouts.NamePartType.FirstName,'FFFLL'},
{'..Y.....',	5,	2,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'..Y.....',	6,	2,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'..Y.....',	7,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y.....',	8,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y.....',	7,	2,	Layouts.NamePartType.LastName,'FFFLL'},
{'..Y.....',	8,	2,	Layouts.NamePartType.Matronymic,'FFFLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEREZ)
{'...Y..',	1,	1,	Layouts.NamePartType.FirstName,'FFFL'},
{'...Y..',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFL'},
{'...Y..',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFL'},
{'...Y..',	5,	2,	Layouts.NamePartType.FirstName,'FL'},
{'...Y..',	6,	1,	Layouts.NamePartType.LastName,'FFFL'},
{'...Y..',	6,	2,	Layouts.NamePartType.LastName,'FL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO PEREZ)
{'...Y.F.',	1,	1,	Layouts.NamePartType.FirstName,'FFFL'},
{'...Y.F.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFL'},
{'...Y.F.',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFL'},
{'...Y.F.',	5,	2,	Layouts.NamePartType.FirstName,'FFL'},
{'...Y.F.',	6,	2,	Layouts.NamePartType.MiddleName1,'FFL'},
{'...Y.F.',	7,	1,	Layouts.NamePartType.LastName,'FFFL'},
{'...Y.F.',	7,	2,	Layouts.NamePartType.LastName,'FFL'},

//(GLORIA MARIA GUADALUPE Y JOSE HERNANDEZ PEREZ)
{'...Y.L.',	1,	1,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y.L.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y.L.',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y.L.',	5,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'...Y.L.',	6,	1,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y.L.',	7,	1,	Layouts.NamePartType.Matronymic,'FFFLL'},
{'...Y.L.',	6,	2,	Layouts.NamePartType.LastName,'FLL'},
{'...Y.L.',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},


//(GLORIA MARIA GUADALUPE Y JOSE T PEREZ)
{'...Y.X.',	1,	1,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y.X.',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y.X.',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y.X.',	5,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'...Y.X.',	6,	1,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y.X.',	7,	1,	Layouts.NamePartType.Matronymic,'FFFLL'},
{'...Y.X.',	6,	2,	Layouts.NamePartType.LastName,'FLL'},
{'...Y.X.',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON PEREZ)
{'...Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y....',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y....',	5,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'...Y....',	6,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'...Y....',	7,	1,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y....',	8,	1,	Layouts.NamePartType.Matronymic,'FFFLL'},
{'...Y....',	7,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'...Y....',	8,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'...Y.....',	1,	1,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y.....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y.....',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y.....',	5,	2,	Layouts.NamePartType.FirstName,'FFFLL'},
{'...Y.....',	6,	2,	Layouts.NamePartType.MiddleName1,'FFFLL'},
{'...Y.....',	7,	2,	Layouts.NamePartType.MiddleName2,'FFFLL'},
{'...Y.....',	8,	1,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y.....',	9,	1,	Layouts.NamePartType.Matronymic,'FFFLL'},
{'...Y.....',	8,	2,	Layouts.NamePartType.LastName,'FFFLL'},
{'...Y.....',	9,	2,	Layouts.NamePartType.Matronymic,'FFFLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'....Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFFFLL'},
{'....Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFFFLL'},
{'....Y....',	3,	1,	Layouts.NamePartType.MiddleName2,'FFFFLL'},
{'....Y....',	4,	1,	Layouts.NamePartType.MiddleName3,'FFFFLL'},
{'....Y....',	6,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'....Y....',	7,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'....Y....',	8,	1,	Layouts.NamePartType.LastName,'FFFFLL'},
{'....Y....',	9,	1,	Layouts.NamePartType.Matronymic,'FFFFLL'},
{'....Y....',	8,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'....Y....',	9,	2,	Layouts.NamePartType.Matronymic,'FFLL'},

//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'..Y..Y....',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y....',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y....',	4,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y....',	5,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y....',	7,	3,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y....',	8,	3,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y....',	9,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y....',	10,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y..Y....',	9,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y....',	10,	2,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y..Y....',	9,	3,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y....',	10,	3,	Layouts.NamePartType.Matronymic,'FFLL'},


//(GLORIA MARIA GUADALUPE Y JOSE PEDRO SIMON HERNANDEZ PEREZ)
{'..Y..Y...',	1,	1,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y...',	2,	1,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y...',	4,	2,	Layouts.NamePartType.FirstName,'FFLL'},
{'..Y..Y...',	5,	2,	Layouts.NamePartType.MiddleName1,'FFLL'},
{'..Y..Y...',	7,	3,	Layouts.NamePartType.FirstName,'FLL'},
{'..Y..Y...',	8,	1,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y...',	9,	1,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y..Y...',	8,	2,	Layouts.NamePartType.LastName,'FFLL'},
{'..Y..Y...',	9,	2,	Layouts.NamePartType.Matronymic,'FFLL'},
{'..Y..Y...',	8,	3,	Layouts.NamePartType.LastName,'FLL'},
{'..Y..Y...',	9,	3,	Layouts.NamePartType.Matronymic,'FLL'},

//(GLORIA Y GUADALUPE Y JOSE HERNANDEZ PEREZ)
{'.Y.Y...',	1,	1,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.Y...',	3,	2,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.Y...',	5,	3,	Layouts.NamePartType.FirstName,'FLL'},
{'.Y.Y...',	6,	1,	Layouts.NamePartType.Lastname,'FLL'},
{'.Y.Y...',	7,	1,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.Y...',	6,	2,	Layouts.NamePartType.Lastname,'FLL'},
{'.Y.Y...',	7,	2,	Layouts.NamePartType.Matronymic,'FLL'},
{'.Y.Y...',	6,	3,	Layouts.NamePartType.Lastname,'FLL'},
{'.Y.Y...',	7,	3,	Layouts.NamePartType.Matronymic,'FLL'}

],L_MultipleNameFormatLayout);

export dsMXMultipleNameFormats :=dsBRMultipleNameFormats;
export dsPropMultipleNameFormats :=dsBRMultipleNameFormats;
EnD;