import Address,Business_Header,Business_Header_ss,Doxie,doxie_cbrs,fsm,Header_Services,Text,ut,Watchdog, Risk_Indicators, VIN, doxie_files, MEOW, SEEP;

// Temporary fix for ERROR:  (0, 0): 100 Dataset '' is not active
#option ('commonUpChildGraphs', false)

// Extend maximum size for variable length records
#option ('maxlength', 32768)

// Temporary fix for problems with new key structures
#option ('optimizeChildSource', false)

export EntityEnhancer(DATASET(Layout_Entity) indata) := FUNCTION

unsigned in_maxDids := 25 : stored('MaxDids');
unsigned in_maxFull := 25 : stored('MaxFull');

maxDids := if (in_maxDids > 100, 100, in_maxDids);
maxFull := if (in_maxFull > maxDids, maxDids, in_maxFull);

result_score :=
	record
		integer score;
	end;
	
result_address :=
	record
		string street :='';
		string city := '';
		string2 st := '';
		string5 zip5 := '';
    end;

result_person := 
	record(result_score)
		string fname :='';
		string lname := '';
		integer did := 0;
		dataset(result_address) addresses { maxcount(1) };
  end;

result_business_association := 
  record
		string name :='';
		integer bdid := 0;
		dataset(result_address) addresses { maxcount(1) };
  end;

result_person_business := 
	record(result_score)
		string fname :='';
		string lname := '';
		integer did := 0;
		dataset(result_address) addresses { maxcount(1) };
		dataset(result_business_association) businesses { maxcount(25) };
  end;

result_business := 
	record(result_score)
		string name :='';
		integer bdid := 0;
		dataset(result_address) addresses { maxcount(1) };
		dataset(result_person) people { maxcount(50) };
  end;
  
result_meow_link := 
	record(result_score)
	   string class := '';
	   string entity := '';
	   string link_description := '';
	   boolean verified := false;
	end;

result_meow_stat :=
    record
	   string stat_name := '';
	   string stat_value := '';
	end;

entity :=
  record
	  string orig := '';
		unsigned4 docId;
		unsigned4 pos;
	end;

entity_meow :=
  record
	  string orig := '';
		unsigned4 docId;
		unsigned4 pos;
		boolean verified := false;
		boolean resolved := false;
	end;
	
entity_address := 
	record(entity_meow)
	  String182 clean;
		dataset(result_address) addresses { maxcount(1) };
		DATASET(result_person) people { maxcount(100) };
		DATASET(result_business) businesses { maxcount(25) };
		DATASET(result_meow_link) links { maxcount(100) };
		DATASET(result_meow_stat) stats { maxcount(10) };
  end;

entity_person := 
	record(entity_meow)
	  Address.Layout_Clean_Name clean;
		DATASET(result_person_business) people { maxcount(100) };
		DATASET(result_meow_link) links { maxcount(100) };
		DATASET(result_meow_stat) stats { maxcount(10) };
  end;

entity_ssn := 
	record(entity)
	  string9 clean;
		DATASET(result_person) people { maxcount(100) };
  end;
  
entity_fein := 
	record(entity)
	  string9 clean;
		DATASET(result_business) businesses { maxcount(25) };
  end;

entity_phone := 
	record(entity_meow)
	  string10 clean;
		DATASET(result_person) people { maxcount(100) };
		DATASET(result_business) businesses { maxcount(25) };
		DATASET(result_meow_link) links { maxcount(100) };
		DATASET(result_meow_stat) stats { maxcount(10) };
  end;

entity_business := 
	record(entity_meow)
		dataset(result_business) businesses { maxcount(25) };
		DATASET(result_meow_link) links { maxcount(100) };
		DATASET(result_meow_stat) stats { maxcount(10) };
  end;

entity_url := entity;

entity_email := 
	record(entity_meow)
		DATASET(result_person) people { maxcount(100) };
		DATASET(result_business) businesses { maxcount(25) };
		DATASET(result_meow_link) links { maxcount(100) };
		DATASET(result_meow_stat) stats { maxcount(10) };
  end;
  
entity_city :=
	record(entity_meow)
		DATASET(result_person) people { maxcount(100) };
		DATASET(result_business) businesses { maxcount(25) };
		DATASET(result_meow_link) links { maxcount(100) };
		DATASET(result_meow_stat) stats { maxcount(10) };
  end;
  
entity_state :=
 	record(entity_meow)
		DATASET(result_person) people { maxcount(100) };
		DATASET(result_business) businesses { maxcount(25) };
		DATASET(result_meow_link) links { maxcount(100) };
		DATASET(result_meow_stat) stats { maxcount(10) };
  end;
  
entity_country := entity;

entity_vehicle := 
	record(entity_meow)
	  string4 model_year := '';
	  string60 make_description := '';
	  string60 model_description := '';
		DATASET(result_person) people { maxcount(100) };
		DATASET(result_business) businesses { maxcount(25) };
		DATASET(result_meow_link) links { maxcount(100) };
		DATASET(result_meow_stat) stats { maxcount(10) };
  end;

entity_docket := entity;

entity_date := 
    record(entity)
	string8 clean;
  end;

// Clean the orig input according to type
CleanEntity(string class, string orig) := MODULE

string CleanPerson() := FUNCTION
string73 cleanedName := Address.CleanPerson73(orig);
string20 clean_fname := cleanedName[6..25];
string20 clean_lname := cleanedName[46..65];
string20 clean_mname := cleanedName[26..45];
string5  clean_name_suffix := cleanedName[66..70];
return stringlib.stringcleanspaces(trim(trim(clean_fname) + ' ' + trim(clean_mname) + ' ' + trim(clean_lname) + trim(clean_name_suffix)));
END; 

string CleanBusiness() := FUNCTION
return stringlib.stringtouppercase(fsm.cl(orig));
END;

string CleanVehicle() := FUNCTION
return stringlib.stringtouppercase(orig);
END;

StripExtension(string phone) := FUNCTION
extpos := map(Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'EXT', 1) > 0 =>  
                Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'EXT', 1),
			  Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'X', 1) > 0 =>
			    Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'X', 1),
			  0);
			  
  return if(extpos > 0, trim(phone[1..(extpos -1)]), trim(phone));
END;

string CleanPhone() := FUNCTION
return Address.CleanPhone(StripExtension(orig));
END;

string CleanEmail() := FUNCTION
return stringlib.stringtouppercase(orig);
END;

string CleanSSN() := FUNCTION
return stringLib.stringfilter(orig, '0123456789');
END;

string CleanFEIN() := FUNCTION
return stringLib.stringfilter(orig, '0123456789');
END;

string CleanAddress() := FUNCTION
        string decomma := stringlib.stringFindReplace(trim(orig), ',', ' ');
		string unispace := stringlib.stringCleanSpaces(decomma);
		unsigned numspaces := length(stringlib.stringFilter(unispace, ' '));
		unsigned splitpoint := stringlib.stringFind(unispace, ' ', numspaces-2);
		clean := unispace[..splitpoint] + ' ' + unispace[splitpoint..];

return clean;
END;

string CleanCity() := FUNCTION
return stringlib.stringtouppercase(fsm.cl(orig));
END;

string CleanState() := FUNCTION
state := stringlib.stringtouppercase(orig);
return if(length(trim(state)) = 2, ut.St2Name(state), state);
END;

string CleanCountry() := FUNCTION
return stringlib.stringtouppercase(orig);
END;

string CleanURL() := FUNCTION
return stringlib.stringtouppercase(orig);
END;

string CleanDocket() := FUNCTION
return stringlib.stringtouppercase(orig);
END;

string orig_cleaned := map(class = 'person' => CleanPerson(),
			               class = 'business' => CleanBusiness(),
					       class = 'vehicle' => CleanVehicle(),
					       class = 'phone' => CleanPhone(),
					       class = 'email' => CleanEmail(),
					       class = 'ssn' => CleanSSN(),
					       class = 'fein' => CleanFein(),
					       class = 'address' => CleanAddress(),
					       class = 'city' => CleanCity(),
					       class = 'state' => CleanState(),
					       class = 'country' => CleanCountry(),
					       class = 'url' => CleanURL(),
					       class = 'docket' => CleanDocket(),
						   class = 'date' => SEEP.CleanDate(orig),
					       '');

export clean := orig_cleaned;
END;

// Project entities into MEOW format
meow.Layout_EntityList into(indata l, unsigned c) := transform
            self.CleanedInput := CleanEntity(l.class, l.orig).clean;
            self.entity_type := map(l.class = 'person' => meow.EntityType.t_Person,
			                        l.class = 'business' => meow.EntityType.t_Company,
									l.class = 'vehicle' => meow.EntityType.t_Vin,
									l.class = 'phone' => meow.EntityType.t_Phone,
									l.class = 'email' => meow.EntityType.t_email,
									l.class = 'ssn' => meow.EntityType.t_SSN,
									l.class = 'fein' => meow.EntityType.t_FEIN,
									l.class = 'address' => meow.EntityType.t_Address,
									l.class = 'city' => meow.EntityType.t_City,
									l.class = 'state' => meow.EntityType.t_State,
									l.class = 'country' => meow.EntityType.t_country,
									l.class = 'url' => meow.EntityType.t_url,
									l.class = 'docket' => meow.EntityType.t_Docket,
									l.class = 'date' => meow.EntityType.t_Date,
									meow.EntityType.t_Unknown);
            self.local_entity_number := c;
            self.verified := false;
            self.resolved := false;
            self.Identifications := [];
            self.Links := [];
            self.Tried := [];
  end;    

// Eliminate duplicates before meow processing
meow_data := sort(dedup(sort(project(indata,into(left,counter)), entity_type, CleanedInput, local_entity_number), entity_type, CleanedInput), local_entity_number);

dummy_meow_result := dataset([], MEOW.Layout_EntityList);

meow_result := meow.Func_Meow_Basic(meow_data);

layout_identification := record
unsigned2 entity_number;
MEOW.Layout_IdRef;
end;

layout_identification GetIdentifications(meow_result l, MEOW.Layout_IdRef r) := transform
self.entity_number := l.local_entity_number;
self := r;
end;

meow_identifications := normalize(meow_result,
                                  left.Identifications,
								  GetIdentifications(left, right))(id <> 0);
layout_did := record
unsigned6 did;
unsigned2 score := 0;
end;

layout_bdid := record
unsigned6 bdid;
unsigned2 score := 0;
end;
								  
GetMeowDids(unsigned2 entity_num) := function
    dids := project(meow_identifications(entity_number = entity_num, id_type = meow.IdType.it_did),
                transform(layout_did, self.did := left.id, self.score := left.score));
    return dids;
end;

GetMeowBDids(unsigned2 entity_num) := function
    bdids := project(meow_identifications(entity_number = entity_num, id_type = meow.IdType.it_bdid),
                transform(layout_bdid, self.bdid := left.id, self.score := left.score));
    return bdids;
end;

string MapLinkDescription(unsigned1 ltype) := 
    map(ltype = meow.LinkType.lt_unknown => 'Unknown',
        ltype = meow.LinkType.lt_has => 'Has',
	    ltype = meow.LinkType.lt_geo => 'Geographical',
	    ltype = meow.LinkType.lt_address => 'Address',
	    ltype = meow.LinkType.lt_similar => 'Similar',
	    ltype = meow.LinkType.lt_works_for => 'Works for',
	    ltype = meow.LinkType.lt_relative => 'Relative',
	    ltype = meow.LinkType.lt_owner_similar => 'Owner similar',
	    ltype = meow.LinkType.lt_owner_same => 'Owner same',
		ltype = meow.LinkType.lt_corporate_linkage => 'Corporate linkage',
		ltype = meow.LinkType.lt_temporal => 'Temporal',
		'');
	
layout_link := record
unsigned2 entity_number;
unsigned1 link_entity_type := 0;
string link_CleanedInput := '';
MEOW.Layout_EntityLinks;
end;

layout_link GetLinks(meow_result l, MEOW.Layout_EntityLinks r) := transform
self.entity_number := l.local_entity_number;
self := r;
end;

meow_links_init :=  normalize(meow_result,
                         left.Links,
						 GetLinks(left, right));
						 
meow_links := join(meow_links_init,
                   meow_data,
				   left.local_entity_number = right.local_entity_number,
				   transform(layout_link,
				             self.link_CleanedInput := right.CleanedInput,
							 self.link_entity_type := right.entity_type,
							 self := left));
							 
string MapEntityType(unsigned1 entity_type) :=
    map(entity_type = meow.EntityType.t_Person => 'person',
	    entity_type = meow.EntityType.t_Company => 'business',
		entity_type = meow.EntityType.t_Vin => 'vehicle',
		entity_type = meow.EntityType.t_Phone => 'phone',
		entity_type = meow.EntityType.t_email => 'email',
		entity_type = meow.EntityType.t_SSN => 'ssn',
		entity_type = meow.EntityType.t_FEIN => 'fein',
		entity_type = meow.EntityType.t_Address => 'address',
		entity_type = meow.EntityType.t_City => 'city',
		entity_type = meow.EntityType.t_State => 'state',
		entity_type = meow.EntityType.t_country => 'country',
		entity_type = meow.EntityType.t_url => 'url',
		entity_type = meow.EntityType.t_Docket => 'docket',
		entity_type = meow.EntityType.t_Date => 'date',
		''); 
								   
// First record is record to be enhanced
found := choosen(indata, 1);

// Filter cityuy entities for address enhancement
cities := indata(class = 'city');

// Enhance entity
getBdidsByDID(unsigned6 indid) := FUNCTION
  bdids := Business_Header.Key_Employment_Did(KEYED(sdid = indid), (unsigned6) bdid <> 0, (integer) score > 100);
	return PROJECT(bdids, transform(doxie.Layout_ref_bdid, self.bdid := (unsigned6)left.bdid));
END;

getBusinessAssociations(DATASET(doxie.Layout_ref_bdid) allbdids) := module
 deduped := choosen(DEDUP(SORT(allbdids, bdid), bdid), maxDids); 
 numBdids := count(deduped);
 selected := if(numBDIDs > maxFull, choosen(deduped, maxFull), deduped);
 fullinfo := PROJECT(join(selected,Business_Header.Key_BH_Best,KEYED(left.bdid = right.bdid)),
   TRANSFORM(result_business_association, 
	    inbdid := LEFT.bdid;
	    self.name := LEFT.company_name;
			self.addresses := DATASET([{Address.addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name,
                         LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range), LEFT.city, LEFT.state, LEFT.zip}], result_address);
	    self := LEFT, 
			self := []
      )
	 );

 export DATASET(result_business_association) businesses := fullinfo;
end;

getPeople(DATASET(layout_did) alldids) := module
 shared deduped := choosen(DEDUP(SORT(alldids, -score, did),score, did), maxDids); 
 shared fullinfo := PROJECT(join(deduped,watchdog.Key_watchdog_glb,KEYED(left.did = right.did)),
   TRANSFORM(result_person, 
	    self := LEFT, 
			self.addresses := DATASET([{Address.addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name,
                         LEFT.suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range), LEFT.city_name, LEFT.st, LEFT.zip}], result_address);
			self := []
      )
	 );
 shared fullinfo_business := PROJECT(join(deduped,watchdog.Key_watchdog_glb,KEYED(left.did = right.did)),
   TRANSFORM(result_person_business, 
	    self := LEFT, 
			self.addresses := DATASET([{Address.addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name,
                         LEFT.suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range), LEFT.city_name, LEFT.st, LEFT.zip}], result_address);
		bigbdids := getBdidsByDID(LEFT.did);
		self.businesses  := getBusinessAssociations(bigbdids).businesses;
		self := []
      )
	 );
	 
 export DATASET(result_person) people := fullinfo;
 export DATASET(result_person_business) people_business_association := fullinfo_business;
end;

getBusinesses(DATASET(layout_bdid) allbdids) := module
 deduped := choosen(DEDUP(SORT(allbdids, -score, bdid), score, bdid), maxDids); 
 fullinfo := PROJECT(join(deduped,Business_Header.Key_BH_Best,KEYED(left.bdid = right.bdid)),
   TRANSFORM(result_business, 
	    inbdid := LEFT.bdid;
	    contacts := PROJECT(Business_Header.Key_Business_Contacts_BDID(KEYED(bdid = inbdid), did <> 0, from_hdr = 'N'), layout_did);
	    self.name := LEFT.company_name;
			self.addresses := DATASET([{Address.addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name,
                         LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range), LEFT.city, LEFT.state, LEFT.zip}], result_address);
			self.people := getPeople(contacts).people;
	    self := LEFT, 
			self := []
      )
	 );
 export DATASET(result_business) businesses := fullinfo;
end;

getBdidsByPhone(integer inphone) := FUNCTION
  bdids := Business_Header_SS.Key_BH_Phone(KEYED(phone=inphone));
	return PROJECT(bdids, layout_bdid);
END;

getBdidsByFEIN(integer infein) := FUNCTION
  bdids := Business_Header_SS.Key_BH_FEIN(KEYED(fein=infein));
	return PROJECT(bdids, layout_bdid);
END;

getBdidsByName(string81 inname) := FUNCTION
  bdids := Business_Header_SS.Key_BH_CompanyName_Unlimited(KEYED(clean_company_name20=inname[1..20]),
			KEYED(clean_company_name60=inname[21..80]));
	return PROJECT(bdids, layout_bdid);
END;

getBdidsByAddr(qstring10 in_prim_range, qstring28 in_prim_name, unsigned3 in_zip, qstring8 in_sec_range) := FUNCTION
  bdids := doxie_cbrs.key_addr_bdid(keyed(prim_name=in_prim_name),
									keyed(zip=in_zip),
									keyed(in_sec_range = '' or sec_range=in_sec_range),
									keyed(prim_range=in_prim_range));
	return PROJECT(bdids, layout_bdid);
END;

Layout_ref_seq := record
unsigned4 seq_no;
end;

getVehicle(DATASET(Layout_ref_seq) allseqs, boolean verified, string60 Manufacturer, string60 Model, string4 Year) := module
 shared fullinfo := join(allseqs,doxie_files.Key_Vehicles,KEYED(left.seq_no = right.sseq_no));

 // Dedup to most current according to history flag
 shared deduped := dedup(sort(fullinfo, history), true);
 shared numseqs := count(deduped);
 
 shared layout_did getVehicleDids(deduped l, unsigned1 cnt) := transform
   self.did := choose(cnt, (unsigned6)l.own_1_did, (unsigned6)l.own_2_did,
                           (unsigned6)l.reg_1_did, (unsigned6)l.reg_2_did);
 end;
 
 shared layout_bdid getVehicleBdids(deduped l, unsigned1 cnt) := transform
   self.bdid := choose(cnt, l.own_1_bdid, l.own_2_bdid,
                            l.reg_1_bdid, l.reg_2_bdid);
 end;

 shared dids := normalize(deduped, 4, getVehicleDids(left, counter))(did <> 0);
 shared result_people := getPeople(dids).people;                                            
 
 shared bdids := normalize(deduped, 4, getVehicleBdids(left, counter))(bdid <> 0);
 shared result_businesses := choosen(getBusinesses(bdids).businesses, maxfull);                                            

 export string4 model_year := if(verified and numseqs > 0, deduped[1].model_year, Year);
 export string60 make_description := if(verified and numseqs > 0, deduped[1].make_description, Manufacturer);
 export string60 model_description := if(verified and numseqs > 0, deduped[1].model_description, Model);
 export DATASET(result_person) people := if(verified and numseqs > 0, result_people, dataset([], result_person));
 export DATASET(result_business) businesses := if(verified and numseqs > 0, result_businesses, dataset([], result_business));

end;

getMeowPeople(unsigned1 entity_num) := FUNCTION
    dids := getMeowDids(entity_num);
    init_people := getPeople(dids).people;                                            
    meow_people := sort(join(init_people,
                              meow_identifications(entity_number = entity_num, id_type = meow.IdType.it_did),
							  left.did = right.id,
							  transform(result_person,
							            self.score := right.score,
										self := left)), -score);
    return meow_people;
END;

getMeowPeopleBusiness(unsigned1 entity_num) := FUNCTION
    dids := getMeowDids(entity_num);
    init_people := getPeople(dids).people_business_association;                                            
    meow_people := sort(join(init_people,
                              meow_identifications(entity_number = entity_num, id_type = meow.IdType.it_did),
							  left.did = right.id,
							  transform(result_person_business,
							            self.score := right.score,
										self := left)), -score);
    return meow_people;
END;

/*
getMeowPeople(unsigned1 entity_num) := FUNCTION
    layout_person_match := record
	  result_person;
	  boolean entity_match := false;
	end;

    layout_meow_data_clean := record
	  meow.Layout_EntityList;
      string20 clean_fname;
      string20 clean_lname;
	end;
	
    dids := getMeowDids(entity_num);
    init_people := project(getPeople(dids).people, transform(layout_person_match, self := left));
	
	layout_meow_data_clean CleanPersonName(meow_data l) := transform
      string73 cleanedName := Address.CleanPerson73(l.cleanedinput);
      self.clean_fname := cleanedName[6..25];
      self.clean_lname := cleanedName[46..65];
	  self := l;
	end;

    meow_data_clean := project(meow_data(entity_type = meow.EntityType.t_Person ), CleanPersonName(left));

    // temporary until meow links for people are implemented
    match_people := join(init_people,
	                     meow_data_clean,
						 left.lname = right.clean_lname and
						   datalib.PreferredFirst(left.fname) = datalib.PreferredFirst(right.clean_fname),
						 transform(layout_person_match, self.entity_match := true, self := left));

	match_people_combined := dedup(sort(init_people+match_people, did, if(entity_match, 0, 1)), did);

    meow_people := project(choosen(sort(match_people_combined, -score, if(entity_match, 0, 1)), maxfull), result_person);
						 
    return meow_people;
END;
*/

getMeowBusinesses(unsigned1 entity_num) := FUNCTION
    bdids := getMeowBdids(entity_num);
    init_businesses := getBusinesses(bdids).businesses;                                            
    meow_businesses := sort(join(init_businesses,
                              meow_identifications(entity_number = entity_num, id_type = meow.IdType.it_bdid),
							  left.bdid = right.id,
							  transform(result_business,
							            self.score := right.score,
										self := left)), -score);
    return meow_businesses;
END;

/*
getMeowBusinesses(unsigned1 entity_num) := FUNCTION
    layout_business_match := record
	  result_business;
	  boolean entity_match := false;
	end;
	
    bdids := getMeowBdids(entity_num);
    init_businesses := project(getBusinesses(bdids).businesses, transform(layout_business_match, self := left));                                            

    // temporary until meow links for businesses are implemented
    match_businesses := join(init_businesses,
	                         meow_data(entity_type = meow.EntityType.t_Company),
							 ut.CompanySimilar100(stringlib.stringtouppercase(fsm.cl(left.name)), right.cleanedinput) <= 25,
							 transform(layout_business_match, self.entity_match := true, self := left),
							 all);
							 
	match_businesses_combined := dedup(sort(init_businesses+match_businesses, bdid, if(entity_match, 0, 1)), bdid);
	                         
    meow_businesses := project(choosen(sort(match_businesses_combined, -score, if(entity_match, 0, 1)), maxfull), result_business);
    return meow_businesses;
END;
*/

getMeowLinks(unsigned1 entity_num) := FUNCTION
	links := choosen(sort(dedup(sort(project(meow_links(entity_number=entity_num),
		               transform(result_meow_link,
							     self.class := MapEntityType(left.link_entity_type),
								 self.link_description := MapLinkDescription(left.Link_Type),
								 self.entity := left.link_CleanedInput,
								 self.score := left.Strength,
								 self := left)), class, link_description, entity, -score),
								                                class, link_description, entity), -score), 100);
    return links;
END;

string format_tenths(real stat_value) := function
  stat_value_init := (string)round(stat_value * 10);
  stat_value_adjust := if(length(stat_value_init) = 1, '0'+ stat_value_init, stat_value_init);
  stat_value_format_tenths := if(length(stat_value_init) = 1,
                                      '0.' + stat_value_init,
									  stat_value_init[1..length(stat_value_init)-1] + '.' + stat_value_init[length(stat_value_init)..]);
  return stat_value_format_tenths;
end;

getMeowStats() := FUNCTION
  stats := dataset([{'Total Entities', ''},
                    {'Total Verified', ''},
					{'Total Resolved', ''},
                    {'Total Links', ''},
                    {'Total Links Attempted', ''},
				    {'Links Per Entity', ''},
				    {'Links Attempted Per Entity', ''}], result_meow_stat);

  total_entities := count(meow_data);
  total_verified := count(meow_result(verified));
  total_resolved := count(meow_result(resolved));
  total_links := 	meow.Func_Stats_CountLinks(meow_result);
  total_links_attempted := meow.Func_Stats_CountLinksAttempted(meow_result);

  stats_init := project(stats,
                        transform(result_meow_stat,
					    self.stat_value := map(left.stat_name = 'Total Entities' => (string)total_entities,
						                       left.stat_name = 'Total Verified' => (string)total_verified,
											   left.stat_name = 'Total Resolved' => (string)total_resolved,
					                           left.stat_name = 'Total Links' => (string)total_links,
					                           left.stat_name = 'Total Links Attempted' => (string)total_links_attempted,
											   left.stat_name = 'Links Per Entity' => format_tenths(total_links/total_entities),
											   left.stat_name = 'Links Attempted Per Entity' => format_tenths(total_links_attempted/total_entities),
											   left.stat_value),
					    self := left));
  return stats_init;

END;

getVehicleMeow(DATASET(Layout_ref_seq) allseqs, boolean verified, string60 Manufacturer, string60 Model, string4 Year) := module
 shared fullinfo := join(allseqs,doxie_files.Key_Vehicles,KEYED(left.seq_no = right.sseq_no));

 // Dedup to most current according to history flag
 shared deduped := dedup(sort(fullinfo, history), true);
 shared numseqs := count(deduped);
 
 shared result_people := getMeowPeople(1);
 shared result_businesses := getMeowBusinesses(1);

 export string4 model_year := if(verified and numseqs > 0, deduped[1].model_year, Year);
 export string60 make_description := if(verified and numseqs > 0, deduped[1].make_description, Manufacturer);
 export string60 model_description := if(verified and numseqs > 0, deduped[1].model_description, Model);
 export DATASET(result_person) people := if(verified and numseqs > 0, result_people, dataset([], result_person));
 export DATASET(result_business) businesses := if(verified and numseqs > 0, result_businesses, dataset([], result_business));

end;

getSeqsByVin(string17 invin, boolean verified) := FUNCTION
  seqs := doxie_files.Key_Vehicle_Vin(KEYED(svin=invin));
	return if(verified, PROJECT(seqs, Layout_ref_seq), dataset([], Layout_ref_seq));
END;

// Remove any nickname in parenthesis
RemoveNickname(string name) := FUNCTION

  unsigned1 paren_start := stringlib.StringFind(name, '(', 1);
  unsigned1 paren_end := stringlib.StringFind(name, ')', 1);
  string fixed_name := if(paren_start > 0 and paren_end > 0,
                          name[1..(paren_start-1)] + name[(paren_end+1)..],
						  name);
  
  return fixed_name;
END;

entity_person extract_person(found L) := 
  TRANSFORM
		string73 cleanedName := Address.CleanPerson73(RemoveNickname(L.orig));
        self.orig := L.orig;
		self.docId := L.docId;
		self.pos := L.pos;
        self.verified := true;
		fname_value := cleanedName[6..25];
		lname_value := cleanedName[46..65];
		self.clean.title := cleanedName[1..5];
		self.clean.fname := fname_value;
		self.clean.mname := cleanedName[26..45];
		self.clean.lname := lname_value;
		self.clean.name_suffix := cleanedName[66..70];
		self.clean.name_score  := cleanedName[71..73];
		// No phonetics on last name for now
		bignames := Header_Services.Fetch_Header_Name_Function(fname_value, lname_value, false, true);
		bigdids := project(bignames.outrec, layout_did);
		// We need to decide if we want to return the names where best does not match parsed input
//		self.people := choosen(getPeople(bignames.outrec).people, maxFull);
		self.people := choosen(sort(getPeople(bigdids).people_business_association(lname=lname_value,
		                            Datalib.preferredfirst(fname) = Datalib.preferredfirst(fname_value)
									  OR Datalib.preferredfirst(fname)[1..length(trim(fname_value))]=(STRING20)fname_value
									  OR fname[1..length(trim(fname_value))]=fname_value),
									if(fname = fname_value, 0, 1), fname, did), maxFull);
		self := [];
  END;

entity_person extract_person_meow(found L) := 
  TRANSFORM
		string73 cleanedName := Address.CleanPerson73(L.orig);
        self.orig := L.orig;
		self.docId := L.docId;
		self.pos := L.pos;
	    self.verified := meow_result[1].verified;
	    self.resolved := meow_result[1].resolved;
		fname_value := cleanedName[6..25];
		lname_value := cleanedName[46..65];
		self.clean.title := cleanedName[1..5];
		self.clean.fname := fname_value;
		self.clean.mname := cleanedName[26..45];
		self.clean.lname := lname_value;
		self.clean.name_suffix := cleanedName[66..70];
		self.clean.name_score  := cleanedName[71..73];
    self.people := getMeowPeopleBusiness(1);
//    self.businesses := getMeowBusinesses(1);
	self.links := getMeowLinks(1);
	self.stats := getMeowStats();
  END;

entity_business extract_business(found L) := 
  TRANSFORM
		string81 cleanCompanyName := ut.CleanCompany(L.orig);
		self.docId := L.docId;
		self.pos := L.pos;
		self.orig := L.orig;
        self.verified := true;
		bigbdids := getBdidsByName(cleanCompanyName);
		self.businesses  := choosen(getBusinesses(bigbdids).businesses, maxfull);
		self := [];
  END;

entity_business extract_business_meow(found L) := 
  TRANSFORM
		string81 cleanCompanyName := ut.CleanCompany(L.orig);
		self.docId := L.docId;
		self.pos := L.pos;
		self.orig := L.orig;
	    self.verified := meow_result[1].verified;
	    self.resolved := meow_result[1].resolved;
    self.businesses := getMeowBusinesses(1);
	self.links := getMeowLinks(1);
	self.stats := getMeowStats();
  END;

entity_phone extract_phone(found L) := 
  TRANSFORM
	string10 clean_phone := Address.CleanPhone(L.orig);
    self.orig := L.orig;
		self.docId := L.docId;
		self.pos := L.pos;
        self.verified := true;
		self.clean := clean_phone;
		bigdids := project(Header_Services.Fetch_Header_Phone_Function(clean_phone, '', ''), layout_did);
		bigbdids := getBdidsByPhone((integer) clean_phone);

		self.people := getPeople(bigdids).people;
		self.businesses  := choosen(getBusinesses(bigbdids).businesses, maxfull);
		self.links := [];
		self.stats := [];
  END;

StripExtension(string phone) := FUNCTION
extpos := map(Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'EXT', 1) > 0 =>  
                Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'EXT', 1),
			  Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'X', 1) > 0 =>
			    Stringlib.StringFind(Stringlib.StringToUpperCase(phone), 'X', 1),
			  0);
			  
  return if(extpos > 0, trim(phone[1..(extpos -1)]), trim(phone));
END;

entity_phone extract_phone_meow(found L) := 
  TRANSFORM
	string10 clean_phone := Address.CleanPhone(StripExtension(L.orig));
    self.orig := L.orig;
		self.docId := L.docId;
		self.pos := L.pos;
		self.clean := clean_phone;
	    self.verified := meow_result[1].verified;
	    self.resolved := meow_result[1].resolved;

    self.people := getMeowPeople(1);
    self.businesses := getMeowBusinesses(1);
	self.links := getMeowLinks(1);
	self.stats := getMeowStats();
  END;

entity_ssn extract_ssn(found L) := 
  TRANSFORM
	string9	clean_ssn := StringLib.stringFilter(L.orig, '0123456789');
    self.orig := L.orig;
		self.docId := L.docId;
		self.pos := L.pos;
		self.clean := clean_ssn;

		bigdids := project(Header_Services.Fetch_Header_SSN_Function(clean_ssn, '', '', 100), layout_did);
		self.people := getPeople(bigdids).people;
  END;
  
  
entity_fein extract_fein(found L) := 
  TRANSFORM
	string9	clean_fein := StringLib.stringFilter(L.orig, '0123456789');
    self.orig := L.orig;
		self.docId := L.docId;
		self.pos := L.pos;
		ok := EXISTS(Business_Header_SS.Key_BH_FEIN(KEYED(fein=(unsigned6)clean_fein)));
		self.clean := IF(ok, clean_fein, SKIP);

		bigbdids := getBdidsByFEIN((unsigned6)clean_fein);
		self.businesses  := choosen(getBusinesses(bigbdids).businesses, maxfull);
  END;

entity_address extract_address(found L) := 
  TRANSFORM
/*
        layout_city_position := record
          string city_name := '';
		  unsigned city_pos := 0;
          unsigned position := 0;
        end;
		
        city_info := sort(join(dataset(L), cities,
		                      left.docID = right.docID and
						      length(trim(left.orig)) >= length(trim(right.orig)) and
						      left.pos <= right.pos and
                              (right.pos + length(trim(right.orig))) <= (left.pos + length(trim(left.orig))),
							  transform(layout_city_position,
							            self.position := right.pos - left.pos,
										self.city_name := right.orig,
										self.city_pos := right.pos)), -city_pos);
										
        splitpoint := if(count(city_info) = 0, skip, city_info[1].position);

		clean := Address.CleanAddress182(L.orig[..(splitpoint-1)], L.orig[(splitpoint+1)..]);
*/		
//  use previous method of calculating splitpoint until docID and pos and all entities available
        string decomma := stringlib.stringFindReplace(trim(L.orig), ',', ' ');
		string unispace := stringlib.stringCleanSpaces(decomma);
		unsigned numspaces := length(stringlib.stringFilter(unispace, ' '));
		unsigned splitpoint := stringlib.stringFind(unispace, ' ', numspaces-2);

		clean := Address.CleanAddress182(unispace[..splitpoint], unispace[splitpoint..]);

		prim_range := clean[1..10];
		predir := clean[11..12];
		prim_name := clean[13..40];
		addr_suffix := clean[41..44];			// If using USPS Standard Suffixes char suffix[4] is OK.
		postdir := clean[45..46];
		unit_desig := clean[47..56];
		sec_range := clean[57..64];
		p_city_name := clean[65..89];
		v_city_name := clean[90..114];
		st := clean[115..116];
		zip5 := clean[117..121];
		zip4 := clean[122..125];

		bigdids := Header_Services.Fetch_Address_Function(prim_range, ut.stripOrdinal(prim_name), v_city_name, st, zip5, 10, sec_range, '', '', false);
		bigbdids := getBdidsByAddr((qstring)prim_range, (qstring)prim_name, (unsigned3)zip5, (qstring)sec_range);

    self.orig := L.orig;
		self.docId := L.docId;
		self.pos := L.pos;
        self.verified := true;
		self.clean := clean;
		self.addresses := dataset([{Address.addr1FromComponents(prim_range, predir, prim_name,
                         addr_suffix, postdir, unit_desig, sec_range), v_city_name, st, zip5}], result_address);
		self.people := getPeople(project(bigdids.outrecs, layout_did)).people;
		self.businesses  := choosen(getBusinesses(bigbdids).businesses, maxfull);
		self.links := [];
		self.stats := [];
  END;

entity_address extract_address_meow(found L) := 
  TRANSFORM
        layout_city_position := record
          string city_name := '';
		  unsigned city_pos := 0;
          unsigned position := 0;
        end;
		
        city_info := sort(join(dataset(L), cities,
		                      left.docID = right.docID and
						      length(trim(left.orig)) >= length(trim(right.orig)) and
						      left.pos <= right.pos and
                              (right.pos + length(trim(right.orig))) <= (left.pos + length(trim(left.orig))),
							  transform(layout_city_position,
							            self.position := right.pos - left.pos,
										self.city_name := right.orig,
										self.city_pos := right.pos)), -city_pos);
										
        splitpoint := if(count(city_info) = 0, skip, city_info[1].position);

		clean := Address.CleanAddress182(L.orig[..(splitpoint-1)], L.orig[(splitpoint+1)..]);
/*	
//  use previous method of calculating splitpoint until docID and pos and all entities available
        string decomma := stringlib.stringFindReplace(trim(L.orig), ',', ' ');
		string unispace := stringlib.stringCleanSpaces(decomma);
		unsigned numspaces := length(stringlib.stringFilter(unispace, ' '));
		unsigned splitpoint := stringlib.stringFind(unispace, ' ', numspaces-2);

		clean := Address.CleanAddress182(unispace[..splitpoint], unispace[splitpoint..]);
*/
		prim_range := clean[1..10];
		predir := clean[11..12];
		prim_name := clean[13..40];
		addr_suffix := clean[41..44];			// If using USPS Standard Suffixes char suffix[4] is OK.
		postdir := clean[45..46];
		unit_desig := clean[47..56];
		sec_range := clean[57..64];
		p_city_name := clean[65..89];
		v_city_name := clean[90..114];
		st := clean[115..116];
		zip5 := clean[117..121];
		zip4 := clean[122..125];
/*
		bigdids := Header_Services.Fetch_Address_Function(prim_range, ut.stripOrdinal(prim_name), v_city_name, st, zip5, 10, sec_range, '', '', '', false);
		bigbdids := getBdidsByAddr((qstring)prim_range, (qstring)prim_name, (unsigned3)zip5, (qstring)sec_range);
*/
        self.orig := L.orig;
		self.docId := L.docId;
		self.pos := L.pos;
	    self.verified := meow_result[1].verified;
	    self.resolved := meow_result[1].resolved;
		self.clean := clean;
		self.addresses := dataset([{Address.addr1FromComponents(prim_range, predir, prim_name,
                         addr_suffix, postdir, unit_desig, sec_range), v_city_name, st, zip5}], result_address);
/*
        self.people := if(exists(meow_identifications(entity_number=1, id_type = meow.IdType.it_did)),
		                     getMeowPeople(1),
						     getPeople(project(bigdids.outrecs, layout_did)).people);
        self.businesses := if(exists(meow_identifications(entity_number=1, id_type = meow.IdType.it_bdid)),
		                     getMeowBusinesses(1),
							 choosen(getBusinesses(bigbdids).businesses, maxfull));
*/
        self.people := getMeowPeople(1);
        self.businesses := getMeowBusinesses(1);
	    self.links := getMeowLinks(1);
	    self.stats := getMeowStats();
	    self := L;
  END;

entity_url extract_url(found L) := 
  TRANSFORM
		self := L;
  END;
  
entity_email extract_email(found L) := 
  TRANSFORM
		self := L;
        self := [];
  END;

entity_email extract_email_meow(found L) := 
  TRANSFORM
	self.verified := meow_result[1].verified;
	self.resolved := meow_result[1].resolved;
    self.people := getMeowPeople(1);
    self.businesses := getMeowBusinesses(1);
	self.links := getMeowLinks(1);
	self.stats := getMeowStats();
	self := L;
  END;
   
entity_city extract_city(found L) := 
  TRANSFORM
        self.verified := true;
		self := L;
        self := [];
  END;

entity_city extract_city_meow(found L) := 
  TRANSFORM
	self.verified := meow_result[1].verified;
	self.resolved := meow_result[1].resolved;
    self.people := getMeowPeople(1);
    self.businesses := getMeowBusinesses(1);
	self.links := getMeowLinks(1);
	self.stats := getMeowStats();
	self := L;
  END;

entity_state extract_state(found L) := 
  TRANSFORM
    self.verified := true;
	self := L;
    self := [];
  END;

entity_state extract_state_meow(found L) := 
  TRANSFORM
	self.verified := meow_result[1].verified;
	self.resolved := meow_result[1].resolved;
    self.people := getMeowPeople(1);
    self.businesses := getMeowBusinesses(1);
	self.links := getMeowLinks(1);
	self.stats := getMeowStats();
	self := L;
  END;

entity_country extract_country(found L) := 
  TRANSFORM
		self := L;
  END;

entity_vehicle extract_vehicle(found L) := 
  TRANSFORM
		VinInfo := (VIN.VerifyVin(L.orig))[1];
	    string4 VinYear := if(VinInfo.Year <> 0, intformat(VinInfo.Year, 4,1), '');

        bigseqs := getSeqsByVin(L.orig, VinInfo.Verified);
		
		vehinfo := getVehicle(bigseqs, VinInfo.Verified, VinInfo.Manufacturer, VinInfo.Model, VinYear);
		
		self.orig := L.orig;
		self.verified := VinInfo.Verified;
	    self.model_year := vehinfo.model_year;
	    self.make_description := vehinfo.make_description;
	    self.model_description := vehinfo.model_description;
		self.people := vehinfo.people;
		self.businesses := vehinfo.businesses;
		self.links := [];
		self.stats := [];
		self := L;
  END;
  
entity_vehicle extract_vehicle_meow(found L) := 
  TRANSFORM
		VinInfo := (VIN.VerifyVin(L.orig))[1];
	    string4 VinYear := if(VinInfo.Year <> 0, intformat(VinInfo.Year, 4,1), '');

        bigseqs := getSeqsByVin(L.orig, VinInfo.Verified);
		
		vehinfo := getVehicleMeow(bigseqs, VinInfo.Verified, VinInfo.Manufacturer, VinInfo.Model, VinYear);
		
		self.orig := L.orig;
		self.verified := meow_result[1].verified;
		self.resolved := meow_result[1].resolved;
	    self.model_year := vehinfo.model_year;
	    self.make_description := vehinfo.make_description;
	    self.model_description := vehinfo.model_description;
		self.people := vehinfo.people;
		self.businesses := vehinfo.businesses;
	    self.links := getMeowLinks(1);
	    self.stats := getMeowStats();
		self := L;
  END;

entity_docket extract_docket(found L) := 
  TRANSFORM
		self := L;
  END;

entity_date extract_date(found L) := 
  TRANSFORM
        self.clean := SEEP.CleanDate(L.orig);
		self := L;
  END;

set_class := set(found, Stringlib.StringToLowerCase(class));

indata_count := count(indata);

//output(indata, named('input'));
//output(found, named('found'));
//output(meow_data, named('meow_input'));
//output(meow_result, named('meow_result'));
//output(meow_identifications, named('meow_identifications'));
//output(meow_links, named('meow_links'));

output(if ('person' in set_class and indata_count > 1, PROJECT(found(class = 'person'), extract_person_meow(LEFT)),
                                                     PROJECT(found(class = 'person'), extract_person(LEFT))), named('person'));
output(if ('phone' in set_class and indata_count > 1, PROJECT(found(class = 'phone'), extract_phone_meow(LEFT)),
                                                    PROJECT(found(class = 'phone'), extract_phone(LEFT))), named('phone'));
output(if ('ssn' in set_class, PROJECT(found(class = 'ssn'), extract_ssn(LEFT))), named('ssn'));
output(if ('business' in set_class and indata_count > 1, PROJECT(found(class = 'business'), extract_business_meow(LEFT)),
                                                     PROJECT(found(class = 'business'), extract_business(LEFT))), named('business'));
output(if ('address' in set_class and indata_count > 1, PROJECT(found(class = 'address'), extract_address_meow(LEFT)),
                                                      PROJECT(found(class = 'address'), extract_address(LEFT))), named('address'));
output(if ('url' in set_class, PROJECT(found(class = 'url'), extract_url(LEFT))), named('url'));
output(if ('email' in set_class and indata_count > 1, PROJECT(found(class = 'email'), extract_email_meow(LEFT)),
                                                    PROJECT(found(class = 'email'), extract_email(LEFT))), named('email'));
output(if ('city' in set_class and indata_count > 1, PROJECT(found(class = 'city'), extract_city_meow(LEFT)),
                                                   PROJECT(found(class = 'city'), extract_city(LEFT))), named('city'));
output(if ('state' in set_class and indata_count > 1, PROJECT(found(class = 'state'), extract_state_meow(LEFT)),
                                                    PROJECT(found(class = 'state'), extract_state(LEFT))), named('state'));
output(if ('country' in set_class, PROJECT(found(class = 'country'), extract_country(LEFT))), named('country'));
output(if ('vehicle' in set_class and indata_count > 1, PROJECT(found(class = 'vehicle'), extract_vehicle_meow(LEFT)),
                                                      PROJECT(found(class = 'vehicle'), extract_vehicle(LEFT))), named('vehicle'));
output(if ('fein' in set_class, PROJECT(found(class = 'fein'), extract_fein(LEFT))), named('fein'));
output(if ('docket' in set_class, PROJECT(found(class = 'docket'), extract_docket(LEFT))), named('docket'));
output(if ('date' in set_class, PROJECT(found(class = 'date'), extract_date(LEFT))), named('date'));

return indata_count;

END;
