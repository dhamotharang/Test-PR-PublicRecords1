
boolean validType(string rtype) := Accuity.Conversions.IsBusinessCode(rtype) OR 
									Accuity.Conversions.IsPersonCode(rtype);
									
boolean supportedSource(string src, string listcode) :=
				(src + ' ' + listcode) in Accuity.Sets.Include.source_listID;

allnames := Accuity.Reformat.Inputs.gwl(validType(Accuity.Reformat.Inputs.gwl.type),
					supportedSource(source,list_id));
					
// get all names with parentheses
names := allnames(Accuity.Persons.HasParen(full_name));

// find associate AKAs
//rawakas := names.AKAs;
//output(rawakas,ALL,named('allakas'));
//OUTPUT(rawakas(Accuity.Persons.HasParen(alias)),ALL,named('pakas'));


getNameType(string rtype) :=
	IF(Accuity.Conversions.IsBusinessCode(rtype),'B','P'); 

// distinguish between Business and Person
pnames := PROJECT(names, TRANSFORM(Layout_AkaConversion, 
			self.nametype := getNameType(LEFT.type);
			SELF := LEFT;));

// names may also be found in the Accuity AKA field
hasaka := allnames(count(AKAs)>0);

raka := RECORD
	string	id := hasaka.id;
	string	source := hasaka.source;
	string	list_id := hasaka.list_id;
	string	full_name := hasaka.full_name;
	string1	nametype := getNameType(hasaka.type);
	dataset(Accuity.Layouts.input.crAlias)	AKAs := hasaka.AKAs;
END;


tbl_aka := table(hasaka, 
					{integer akaCount := count(AKAs), 
					raka});
	
		ds1 := normalize(tbl_aka,left.akacount,transform(Layout_AkaConversion,
			self.id 				:= left.id;
			self.source 			:= left.source;
			self.list_id 			:= left.list_id;
			self.nametype := LEFT.nametype;
			self.full_name := left.AKAs[counter].alias;
		));

akas := ds1(Accuity.Persons.HasParen(full_name));

PreReport := SORT(DEDUP(pnames+akas,record,all),full_name,id);
export AkaReport := JOIN(PreReport, File_AKAList, LEFT.full_name=RIGHT.full_name,LEFT ONLY);

