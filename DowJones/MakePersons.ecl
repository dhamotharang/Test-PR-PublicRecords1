import Worldcheck_Bridger, ut;

dPerson	:= File_Person;

Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp 
					xForm_Person(Layouts.rPersons src) := TRANSFORM

		self.id := src.id;
		self.Entity_Unique_ID := 'DJ' + src.id;
		self.Reference_ID := src.id;
		self.type := 'Individual';
		self.Listed_Date := ut.ConvertDate(src.date, '%d-%B-%Y', '%m/%d/%Y');
		self.comments := '';
		self.gender := src.gender;
		
		self := src;
		self := [];
END;

dXg := SORT(Project(dPerson, xForm_Person(LEFT)),id,LOCAL);

dXgNamed := JOIN(dXg, ExtractNames(NameType='Primary Name'), LEFT.id = RIGHT.ID,
							TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
		self.title 						:= RIGHT.TitleHonorific;
		self.first_name 			:= RIGHT.FirstName;
		self.middle_name 			:= RIGHT.MiddleName;
		self.last_name 				:= RIGHT.SurName;
		self.generation 			:= RIGHT.Suffix;
		self.full_name 				:= RIGHT.FullName;
		self := LEFT;),
								LEFT OUTER, NOSORT, KEEP(1), LOCAL);
							
akanames := $.Functions.RollupNames;
dXg1 := JOIN(dXgNamed, akanames,LEFT.id = RIGHT.ID,
				TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
						self.aka_list.aka := RIGHT.aka;
						SELF := LEFT;), LEFT OUTER, LOCAL);

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} rollInfo(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} R) := transform
						self.id  := L.id;
						self.additionalinfo := L.additionalinfo + R.additionalinfo;
			end;
		 
	info :=	SORT(DISTRIBUTE(Functions.GetDob(dPerson) & Functions.GetIdsAsAddlinfo &
								Functions.GetCitizenship(dPerson) &
								Functions.GetRoles(dPerson) & Functions.GetBirthPlaces(dPerson) & Functions.GetSources
								& GetSanctionsAsAddlInfo & GetImagesAsAddlInfo,(integer)id)
								,id,LOCAL);
	addlinfo := ROLLUP(	info,			
							id, rollInfo(left, right),local);

	dXg2 := JOIN(dXg1, addlinfo,LEFT.id = RIGHT.ID,
				TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
						self.additional_info_list.additionalinfo := RIGHT.additionalinfo;
						SELF := LEFT;), LEFT OUTER, LOCAL);

IdList := $.Functions.GetIdsAsIdlist;
dXg3 := JOIN(dXg2, IdList, LEFT.id = RIGHT.ID,
				TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
						self.identification_list.identification := RIGHT.identification;
						SELF := LEFT;), LEFT OUTER, LOCAL);

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} rollAddr(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} R) := transform
						self.id  := L.id;
						self.address := L.address + R.address;
			end;
	addr :=	SORT(Functions.GetAddresses(dPerson) & Functions.GetResidence(dPerson),id,LOCAL);
	addresses := ROLLUP(addr,	id, rollAddr(left, right), local);
	dXg4 := JOIN(dXg3, addresses,LEFT.id = RIGHT.ID,
				TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
						self.address_list.address := RIGHT.address;
						SELF := LEFT;), LEFT OUTER, LOCAL);

	ct := Comments(dPerson);						
	dXg5 := JOIN(dXg4, ct, LEFT.id = RIGHT.ID,
				TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
						self.comments := RIGHT.cmts;
						SELF := LEFT;), LEFT OUTER, LOCAL);

//Bug: 145107 - INNER JOIN is used for description.
	dXg6 := JOIN(dXg5, Functions.GetDescriptions, LEFT.id = RIGHT.ID,
				TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
						self.reason_listed := RIGHT.description;
						SELF := LEFT;), INNER, LOCAL);
						
// limit child datasets to 256 entries
maxn := 256;
maxAka := 255;		// because the primary name is part of the count
EXPORT MakePersons := PROJECT(dXg6, TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
						self.aka_list.aka := CHOOSEN(left.aka_list.aka, maxAka);
						self.additional_info_list.additionalinfo := CHOOSEN(left.additional_info_list.additionalinfo,maxn);
						self.identification_list.identification := CHOOSEN(left.identification_list.identification,maxn);
						self.address_list.address := CHOOSEN(left.address_list.address,maxn);
						self := Left;));