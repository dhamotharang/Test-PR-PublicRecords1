/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from topbusiness_share.xml. ***/
/*===================================================*/

export topbusiness_share := MODULE
			
export t_TopBusinessSourceDocInfo := record
	share.t_BusinessIdentity BusinessIds {xpath('BusinessIds')};
	string20 IdType {xpath('IdType')};
	string100 IdValue {xpath('IdValue')};
	string25 Section {xpath('Section')};
	string2 Source {xpath('Source')};
	share.t_Address Address {xpath('Address')};
	share.t_NameAndCompany Name {xpath('Name')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from topbusiness_share.xml. ***/
/*===================================================*/

