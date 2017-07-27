Import Data_Services, doxie, MXD_Common;

MXDocketSearch := record	
	unsigned1 search_type;
	string50  n1; 
	string50  n2;
	string50  n3;
	string1   minit;
	unsigned1 nature_type;	
	unsigned2 year;
	string3		state;
	string1   gender;  
	unsigned8 rec_id;	
	unsigned8 entity_id;	
END;

base_recs_seeded	:= MXD_MXDocket.FileKeyBuild;

SearchType 			:= ENUM(unsigned1, FLM, LMX, FMX);
SearchTypeInUse := 3;

string strip_prefix(string name) := function
	prefix := '^(ET |SAN |SANTA |LOS |DE DI |VON DER |DON |DOS |DAS |ZUM |DALLA |DE DE LOS |DE DE LA |DE LA |DE DE |DE DEL |D LA |VON |DE LE |DE S C |DE DE LA |DE A LA |A LA |DE LA DE LA |DA LA |DE SC |DEL LA |DE LAS |DE LOS |DEL LOS |DE SAN |DEL SAN |DE S |DEL PERPETUO |DE LOS TRES |DE J Y |DEL SAGRADO CORAZON DE |DEL SAGRADO |DEL NUESTRA |DE NUESTRA |DE |BAS |BEN |DEL |LES |LEZ |LA |EL |DA |DI |WIDOW OF |VIUDA |Y )';
	return regexreplace(prefix, name, '');
end;

MXDocketSearch norm2Search(base_recs_seeded l, integer c) := transform
	
	// replace all special characters for 'flat' characters (e.g. Ñ -> N).
	unicode50	flat_fname 			:= MXD_Common.FN_Unicode2Flat(l.firstname);
	unicode50	flat_lname 			:= MXD_Common.FN_Unicode2Flat(l.lastname);
	unicode50	flat_mname 			:= MXD_Common.FN_Unicode2Flat(l.middlename1);
	unicode50	flat_matronymic := MXD_Common.FN_Unicode2Flat(l.matronymic);
	
	string50 fname 			:= transfer(fromunicode(flat_fname, 'UTF-8'), string);
	string50 lname 			:= strip_prefix(transfer(fromunicode(flat_lname, 'UTF-8'), string));
	string20 mname 			:= strip_prefix(transfer(fromunicode(flat_mname, 'UTF-8'), string));
	string50 matronymic := strip_prefix(transfer(fromunicode(flat_matronymic, 'UTF-8'), string));
	
	n1 := map(c=SearchType.FLM=>fname,
					  c=SearchType.LMX=>lname,
						c=SearchType.FMX=>fname,
						'');
	n2 := map(c=SearchType.FLM=>lname,
						c=SearchType.LMX=>matronymic,
						c=SearchType.FMX=>matronymic,
						'');
	n3 := map(c=SearchType.FLM=>matronymic,
						c=SearchType.LMX=>'',
						c=SearchType.FMX=>'',
						'');
	self.search_type 	:= c;						
	self.n1 					:= if(n1<>'', n1, skip);
	self.n2 					:= if(n2<>'', n2, skip);
	self.n3						:= n3;
	self.minit 				:= mname[1];
	self.nature_type 	:= l.nature_type;
	self.year					:= l.date_pub/10000;
	self.state 				:= l.geoCode;
	self.gender 			:= l.gender;
	self.entity_id 		:= l.entity_id;
	self.rec_id 			:= l.rec_id;
end;

dsDocketSearchRecs := dedup(sort(normalize(base_recs_seeded, SearchTypeInUse, norm2Search(left, counter),local),record,local),record,local);

export Key_DocketSearch := index(	dsDocketSearchRecs,
																	{search_type, n1, n2, n3, minit, nature_type, year, state, gender},															 
																	{entity_id, rec_id},
																	Data_Services.Data_location.Prefix('MXData')+'thor_data400::key::mxd_mxdocket::'+doxie.Version_SuperKey+'::docket_search_idx');	