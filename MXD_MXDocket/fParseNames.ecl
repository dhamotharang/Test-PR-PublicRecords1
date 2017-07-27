import mxd_Names, mxd_Common;

export fParseNames(DATASET(MXD_MXDocket.Layouts_build.temp) dsDockets) := FUNCTION

L_docket_ext :=RECORD
		MXD_MXDocket.Layouts_build.temp;
		boolean party1_isBusiness :=false;
		boolean party2_isBusiness :=false;
END;


//identify multiple people in parties
dsCleaned :=PROJECT(dsDockets, TRANSFORM(RECORDOF(L_docket_ext),
											SELF.party1_multiple		:=	IF(LEFT.party1_type=1 AND LEFT.party1_multiple=false and mxd_Names.Mod_NameStats.HasMultipleNames(LEFT.party1_original),true,LEFT.party1_multiple);
											SELF.party2_multiple 		:=	IF(LEFT.party2_type=1 AND LEFT.party2_multiple=false and mxd_Names.Mod_NameStats.HasMultipleNames(LEFT.party2_original),true,LEFT.party2_multiple);
											SELF.party1_original 		:=	REGEXREPLACE(u' ET AL$',mxd_Common.FN_CleanupNameData(LEFT.party1_original),u'');
											SELF.party2_original 		:=	REGEXREPLACE(u' ET AL$',mxd_Common.FN_CleanupNameData(LEFT.party2_original),u'');
											SELF.party1_isBusiness	:=	mxd_Common.FN_IsBusiness(LEFT.party1_original);
											SELF.party2_isBusiness	:=	mxd_Common.FN_IsBusiness(LEFT.party2_original);
											SELF :=LEFT;));

// trim(party1_original) != u'PEOPLE OF MEXICO' AND (
// trim(party2_original) != u'PEOPLE OF MEXICO' AND ( 

dsNonPeople1 :=PROJECT(dsCleaned(party1_type != 1 or party1_isbusiness=true),TRANSFORM(MXD_MXDocket.Layouts_build.DocketPerson,
											Self.not_parsed		:=	true;
											self.is_org				:=	true;
											SELF.isParty1			:=	true;
											SELF.person_id		:=	1;
											SELF.rec_id				:=	LEFT.rec_id;
											SELF.full_name 		:=	LEFT.party1_original;));
											
dsNonPeople2 :=PROJECT(dsCleaned(party2_type != 1 or party2_isbusiness=true),TRANSFORM(MXD_MXDocket.Layouts_build.DocketPerson,
											Self.not_parsed		:=	true;
											self.is_org				:=	true;
											SELF.isParty2			:=	true;
											SELF.person_id		:=	LEFT.rec_id;
											SELF.rec_id				:=	LEFT.rec_id;
											SELF.full_name		:=	LEFT.party2_original;));

dsNonPeople :=	dsNonPeople1 + dsNonPeople2;

dsDockets2 	:=	dsCleaned : PERSIST('~thor_data400::PERSIST::mxd_mxdocket::DocketNames1');

// trim(party1_original) != u'PEOPLE OF MEXICO' and 
// trim(party2_original) != u'PEOPLE OF MEXICO' and 

dsPp1 			:=	dsDockets2(party1_type=1 and party1_isbusiness=false);
dsPp2 			:=	dsDockets2(party2_type=1 and party2_isbusiness=false);

//standard name parsing 

// changed 4th parameter to 'true' for the synonym table -Uma
mxd_Names.MAC_ParseMXNameParts(dsPp1,party1_original,rec_id,false,false,true,true,false,
																	mxd_Names.NameFormats.dsDocketDefaultNameFormats, mxd_Names.NameFormats.dsDocketMultipleNameFormats,
																	dsNamePartsP1,dsNamePartsSingleBadP1,dsNamePartsMultipleBadP1
															 );
//changed 4th parameter to 'true' for the synonym table -Uma
mxd_Names.MAC_ParseMXNameParts(dsPp2,party2_original,rec_id,false,false,true,true,false,
																	mxd_Names.NameFormats.dsDocketDefaultNameFormats, mxd_Names.NameFormats.dsDocketMultipleNameFormats,
																	dsNamePartsP2,dsNamePartsSingleBadP2,dsNamePartsMultipleBadP2
															 );

dsAllBadP1 :=	TABLE(dsNamePartsSingleBadP1 + dsNamePartsMultipleBadP1,{item_id,name_format,norm_name}) ;
dsAllBadP2 :=	TABLE(dsNamePartsSingleBadP2 + dsNamePartsMultipleBadP2,{item_id,name_format,norm_name}) ;

dsBadIdsP1 :=	DEDUP(SORT(dsAllBadP1,item_id),item_id);
dsBadIdsP2 :=	DEDUP(SORT(dsAllBadP2,item_id),item_id);

dsUnparsedPeopleP1 := PROJECT(dsBadIdsP1, TRANSFORM(MXD_MXDocket.Layouts_build.DocketPerson,
																SELF.not_parsed		:=	true;
																SELF.rec_id				:=	LEFT.item_id;
																SELF.isparty1			:=	true;
																SELF.name_format	:=	LEFT.name_format;
																SELF.full_name		:=	LEFT.norm_name;));

dsUnparsedPeopleP2 := PROJECT(dsBadIdsP2, TRANSFORM(MXD_MXDocket.Layouts_build.DocketPerson,
																SELF.not_parsed		:=	true;
																SELF.rec_id				:=	LEFT.item_id;
																SELF.isparty2			:=	true;
																SELF.name_format	:=	LEFT.name_format;
																SELF.full_name		:=	LEFT.norm_name;));

dsUnparsedPeople := dsUnparsedPeopleP1 + dsUnparsedPeopleP2;

L_formatcount := RECORD
	dsUnparsedPeople.Name_format;
	dsUnparsedPeople.full_name;
	cnt :=COUNT(GROUP);
END;

badFormats :=TABLE(dsUnparsedPeople, l_formatcount,name_format);

L_flag := RECORD
	RECORDOF(dsNamePartsP2);
	BOOLEAN isParty1 :=false;
	BOOLEAN isParty2 :=false;
END;

dsP1flag :=PROJECT(dsNamePartsP1, TRANSFORM(L_flag,
										SELF.isParty1 :=	true;
										SELF 					:=	LEFT;));

dsP2flag :=PROJECT(dsNamePartsP2, TRANSFORM(L_flag,
										SELF.isParty2 :=	true;
										SELF					:=	LEFT;));

dsAllParty :=dsP1flag + dsP2flag;
//output(dsAllParty[101..200],NAMED('allparty'));

itemids := PROJECT(dsDockets,TRANSFORM(MXD_MXDocket.Layouts_build.DocketPerson,
										SELF.rec_id 	:=	LEFT.rec_id;));

itemidP1_name2 :=JOIN(itemids,dsAllParty(isParty1=true and name_id=2),
											LEFT.rec_id=RIGHT.item_id,
											TRANSFORM(MXD_MXDocket.Layouts_build.DocketPerson,
												SELF:=LEFT)
											);

itemidP1_name3 :=JOIN(itemids,dsAllParty(isParty1=true and name_id=3),
											LEFT.rec_id=RIGHT.item_id,
											TRANSFORM(MXD_MXDocket.Layouts_build.DocketPerson,
												SELF:=LEFT)
										  );

itemidP2_name2 :=JOIN(itemids,dsAllParty(isParty2=true and name_id=2),
											LEFT.rec_id=RIGHT.item_id,
											TRANSFORM(MXD_MXDocket.Layouts_build.DocketPerson,
												SELF:=LEFT)
											);

itemidP2_name3 :=JOIN(itemids,dsAllParty(isParty2=true and name_id=3),
											LEFT.rec_id=RIGHT.item_id,
											TRANSFORM(MXD_MXDocket.Layouts_build.DocketPerson,
												SELF:=LEFT)
										  );

MXD_MXDocket.Layouts_build.DocketPerson ProcessNameParts(MXD_MXDocket.Layouts_build.DocketPerson L, L_flag R, INTEGER C) := TRANSFORM
		SELF.rec_id				:=	R.item_id;
		SELF.firstName		:=	IF (R.name_part_type=mxd_Names.Layouts.NamePartType.FirstName,R.name_part_text,L.FirstName);
		SELF.lastName			:=	IF (R.name_part_type=mxd_Names.Layouts.NamePartType.LastName,R.name_part_text,L.LastName);
		SELF.patronymic		:=	IF (R.name_part_type=mxd_Names.Layouts.NamePartType.LastName,R.name_part_text,L.Patronymic);
		SELF.matronymic		:=	IF (R.name_part_type=mxd_Names.Layouts.NamePartType.Matronymic,R.name_part_text,L.Matronymic);
		SELF.middleName1	:=	IF (R.name_part_type=mxd_Names.Layouts.NamePartType.MiddleName1,R.name_part_text,L.MiddleName1);
		SELF.middleName2	:=	IF (R.name_part_type=mxd_Names.Layouts.NamePartType.MiddleName2,R.name_part_text,L.MiddleName2);
		SELF.middleName3	:=	IF (R.name_part_type=mxd_Names.Layouts.NamePartType.MiddleName3,R.name_part_text,L.MiddleName3);
		SELF.middleName4	:=	IF (R.name_part_type=mxd_Names.Layouts.NamePartType.MiddleName4,R.name_part_text,L.MiddleName4);
		SELF.middleName5	:=	IF (R.name_part_type=mxd_Names.Layouts.NamePartType.MiddleName5,R.name_part_text,L.MiddleName5);
		SELF.gender				:=	IF (L.gender='' OR (L.gender='U' and R.name_part_type=mxd_Names.Layouts.NamePartType.FirstName), 
																if (R.probable_gender != '', R.Probable_gender, DataLib.Gender((STRING)R.name_part_text)),
																L.gender
															);
		SELF.isParty1			:=	R.isParty1;
		SELF.isParty2			:=	R.isParty2;
		SELF.full_name		:=	R.norm_name;
		SELF							:=	L;
END;

dsPeople_p1		:=	DENORMALIZE(itemids,dsAllParty(isParty1=true and name_id=1),LEFT.rec_id=RIGHT.item_id,
																ProcessNameParts(LEFT,RIGHT,COUNTER)
															);

dsPeople_p2		:=	DENORMALIZE(itemids,dsAllParty(isParty2=true and name_id=1),LEFT.rec_id=RIGHT.item_id,
																ProcessNameParts(LEFT,RIGHT,COUNTER)
															);

dsPeople_p1n2	:=	DENORMALIZE(itemidP1_name2,dsAllParty(isParty1=true and name_id=2),LEFT.rec_id=RIGHT.item_id,
																ProcessNameParts(LEFT,RIGHT,COUNTER)
															);

dsPeople_p1n3	:=	DENORMALIZE(itemidP1_name3,dsAllParty(isParty1=true and name_id=3),LEFT.rec_id=RIGHT.item_id,
																ProcessNameParts(LEFT,RIGHT,COUNTER)
														  );

dsPeople_p2n2	:=	DENORMALIZE(itemidP2_name2,dsAllParty(isParty2=true and name_id=2),LEFT.rec_id=RIGHT.item_id,
																ProcessNameParts(LEFT,RIGHT,COUNTER)
														  );

dsPeople_p2n3	:=	DENORMALIZE(itemidP2_name3,dsAllParty(isParty2=true and name_id=3),LEFT.rec_id=RIGHT.item_id,
																ProcessNameParts(LEFT,RIGHT,COUNTER)
														  );


allPeople 	:=dsPeople_p1 + dsPeople_p2 + dsPeople_p1n2 + dsPeople_p1n3 + dsPeople_p2n2 + dsPeople_p2n3 + dsUnparsedPeople + dsNonPeople;
sortPeople 	:=SORT(allPeople(full_name != u''),rec_id,isParty1,firstname,middlename1,middlename2,middlename3,middlename4,middlename5,lastname,matronymic);
dedupPeople :=DEDUP(sortPeople,rec_id,isParty1,firstname,middlename1,middlename2,middlename3,middlename4,middlename5,lastname,matronymic);

dsUIDPeople :=
	ITERATE(dedupPeople,
					TRANSFORM(RECORDOF(dedupPeople),
										SELF.person_id := 
											IF(LEFT.person_id = 0,
													(ThorLib.Node()+1)*0xFFFFFFFF + RIGHT.person_id+RANDOM(),
													(ThorLib.Nodes()*0xFFFFFFFF)+LEFT.person_id);
										SELF := RIGHT;),
					LOCAL);


dsFN := project(dsUIDPeople,TRANSFORM(recordof(dsuidpeople),
																				fullname := LEFT.firstname + u' ' + LEFT.middlename1 + u' ' + LEFT.middlename2 + u' ' +
																										LEFT.middlename3 + u' '+ LEFT.middlename4 + u' '+ LEFT.middlename5 + u' ' + 
																										LEFT.lastname + u' ' + LEFT.matronymic;

																				fn2 :=	TRIM(UnicodeLib.UnicodeCleanSpaces(fullname),LEFT,RIGHT);
																				SELF.full_name 	:=LEFT.full_name;//if (LEFT.is_org=false and fn2 != u'' and transfer(fn2[1],unsigned2) > 31,fn2,LEFT.full_name);
																				SELF 						:= LEFT;)
								);

// output(SORT(badFormats, -cnt),, '~mxd::mx::docket::badnameformats',overwrite);
// output(dsunparsedpeople(rec_id in [25010128721,220010187857,3942193,985011190001,985011210033,985011211505]));
return dsFN;


END;