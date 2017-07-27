import address,ut;
export Standardize_Unaff_Line2s(

		dataset(layouts.temporary.unaff_redid)	pUnaffBase
	 ,set of string2													pFlags			= ['MA','LA','FN']	//'IA' = use indiv_audit_sortkey for name
	
) :=
function

	blankaddress := Address.CleanAddressFieldsFips('').addressrecord;

	ftrim(string pstring) := stringlib.stringtouppercase(trim(pstring,left,right));

	dUnaffbasecleanedaddr2 := project(pUnaffBase, transform(layouts.temporary.unaff_redid,
			contact_mailing_address1 :=	
														ftrim(left.rawfields.POBOX	) + ' ' 
													;        
			contact_mailing_address2 :=	
														ftrim(left.rawfields.CITY		) + ', ' 
													+ ftrim(left.rawfields.STATE	) + ' ' 
													+ ftrim(left.rawfields.ZIP		)
													;
																							
			contact_location_address1 :=	
														ftrim(left.rawfields.STREET	) + ' ' 
													;        
			contact_location_address2 := contact_mailing_address2;	
			
			mail_addr2_only			:= contact_mailing_address1  = '' and contact_mailing_address2  != '' and left.RawAid_mailing  = 0 and 'MA' in pFlags and left.rawfields.STATE != '';
			contact_addr2_only	:= contact_location_address1 = '' and contact_location_address2 != '' and left.RawAid_Location = 0 and 'LA' in pFlags and left.rawfields.STATE != '';
			
			assembled_nameFML 					:=	trim(left.rawfields.NAME_FIRSTNAME) + ' '
																		+	trim(left.rawfields.NAME_LASTNAME )
																		;                
			assembled_nameLFM 					:=	trim(left.rawfields.indiv_audit_sortkey)
																		;                

			clean_contact_nameFML			:= Address.CleanPersonFML73_fields(assembled_nameFML).CleanNameRecord;
			clean_contact_nameLFM			:= Address.CleanPersonLFM73_fields(assembled_nameLFM).CleanNameRecord;

			self.Clean_contact_mailing_address	:= map(mail_addr2_only						=> Address.CleanAddressParsed(contact_mailing_address1	,contact_mailing_address2	).addressrecord
																								,left.rawfields.STATE != '' => left.Clean_contact_mailing_address	
																								,blankaddress
																						);
      self.Clean_contact_location_address	:= map(contact_addr2_only					=> Address.CleanAddressParsed(contact_location_address1	,contact_location_address2).addressrecord
																								,left.rawfields.STATE != '' => left.Clean_contact_location_address
																								,blankaddress
																						);
			self.clean_contact_name							:= 
				map( left.did != 0		=> left.clean_contact_name
						,'FN' in pFlags
							and (ut.WithinEditN(trim(left.clean_contact_name.fname),trim(clean_contact_nameFML.fname),1)
									and ut.WithinEditN(trim(left.clean_contact_name.lname),trim(clean_contact_nameFML.lname),1)
							)	=> clean_contact_nameFML
						,'IA' in pFlags 	
							and (ut.WithinEditN(trim(left.clean_contact_name.fname),trim(clean_contact_nameLFM.fname),1)
									and ut.WithinEditN(trim(left.clean_contact_name.lname),trim(clean_contact_nameLFM.lname),1)
							)
								=> clean_contact_nameLFM
						,										 left.clean_contact_name
				);
			
			self															:= left;
	));
	
	return dUnaffbasecleanedaddr2;

end;