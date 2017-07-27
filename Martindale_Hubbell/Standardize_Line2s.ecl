import address,ut;
export Standardize_Line2s(

	 dataset(layouts.temporary.aff_redid) pAffBase
	 ,set of string2											pFlags			= ['MA','LA','FN']	//'IA' = use indiv_audit_sortkey for name
	
) :=
function
	
	blankaddress := Address.CleanAddressFieldsFips('').addressrecord;
	
	ftrim(string pstring) := stringlib.stringtouppercase(trim(pstring,left,right));

	daffbasecleanedaddr2 := project(pAffBase, transform(layouts.temporary.aff_redid,
			contact_mailing_address1 :=	
														ftrim(left.rawfields.CONTACT_POBOX	) + ' ' 
													;        
			contact_mailing_address2 :=	
														ftrim(left.rawfields.CONTACT_CITY	) + ', ' 
													+ ftrim(left.rawfields.CONTACT_STATE	) + ' ' 
													+ ftrim(left.rawfields.CONTACT_ZIP		)
													;
																							
			contact_location_address1 :=	
														ftrim(left.rawfields.CONTACT_STREET	) + ' ' 
													;        
			contact_location_address2 := contact_mailing_address2;	
			
			mail_addr2_only			:= contact_mailing_address1  = '' and contact_mailing_address2  != '' and left.RawAid_mailing  = 0 and 'MA' in pFlags and left.rawfields.CONTACT_STATE != '' ;
			contact_addr2_only	:= contact_location_address1 = '' and contact_location_address2 != '' and left.RawAid_Location = 0 and 'LA' in pFlags and left.rawfields.CONTACT_STATE != '' ;
			
			assembled_nameFML 					:=	trim(left.rawfields.HEADER_AFF_INDIV_NAME_FIRSTNAME	) + ' '
																		+	trim(left.rawfields.HEADER_AFF_INDIV_NAME_LASTNAME)
																		;
			assembled_nameLFM 					:=	trim(left.rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_SORTKEY)
																		;                
																		
			clean_contact_nameFML			:= Address.CleanPersonFML73_fields(assembled_nameFML).CleanNameRecord;
			clean_contact_nameLFM			:= Address.CleanPersonLFM73_fields(assembled_nameLFM).CleanNameRecord;

			self.Clean_contact_mailing_address	:= map(mail_addr2_only										=> Address.CleanAddressParsed(contact_mailing_address1	,contact_mailing_address2	).addressrecord
																								,left.rawfields.CONTACT_STATE != '' => left.Clean_contact_mailing_address	
																								,blankaddress
																						);
      self.Clean_contact_location_address	:= map(contact_addr2_only									=> Address.CleanAddressParsed(contact_location_address1	,contact_location_address2).addressrecord
																								,left.rawfields.CONTACT_STATE != '' => left.Clean_contact_location_address
																								,blankaddress
																						);
			self.clean_contact_name							:= 
				map( left.did != 0		=> left.clean_contact_name
						,'FN' in pFlags
							and (			length(trim(left.clean_contact_name.fname)) > 3
										and length(trim(left.clean_contact_name.lname)) > 3
										and ut.WithinEditN(trim(left.clean_contact_name.fname),trim(clean_contact_nameFML.fname),1)
										and ut.WithinEditN(trim(left.clean_contact_name.lname),trim(clean_contact_nameFML.lname),1)
							)	=> clean_contact_nameFML
						,'IA' in pFlags 	
							and (			length(trim(left.clean_contact_name.fname)) > 3
										and length(trim(left.clean_contact_name.lname)) > 3
										and ut.WithinEditN(trim(left.clean_contact_name.fname),trim(clean_contact_nameLFM.fname),1)
										and ut.WithinEditN(trim(left.clean_contact_name.lname),trim(clean_contact_nameLFM.lname),1)
							)
								=> clean_contact_nameLFM
						,										 left.clean_contact_name
				);
			
			self																	:= left;
	));
	
	return daffbasecleanedaddr2;

end;