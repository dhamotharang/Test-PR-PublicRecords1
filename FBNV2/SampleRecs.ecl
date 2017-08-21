export SampleRecs(string filedate) := Function

bus_base_old := DATASET('~thor_data400::base::fbnv2::business_father',fbnv2.Layout_Common.Business_AID , flat)(bdid != 0); 
bus_base_new := FBNV2.File_FBN_Business_Base_AID(bdid != 0);

cont_base_old := DATASET('~thor_data400::base::fbnv2::contact_father',fbnv2.Layout_Common.Contact_AID , flat)(did != 0); 
cont_base_new := FBNV2.File_FBN_Contact_Base_AID(did != 0);

new_bus_record_layout := record
fbnv2.Layout_Common.Business_AID;
end;

new_cont_record_layout := record
fbnv2.Layout_Common.Contact_AID;
end;


//Join on FBN Business Base Files by BDID's
new_bus_record_layout new_bus_records_output(bus_base_new l, bus_base_old r) := TRANSFORM
SELF := l;
END;


//Join on Contacts Base Files by DID's
new_cont_record_layout new_cont_records_output(cont_base_new l, cont_base_old r) := TRANSFORM
SELF := l;
END;

//New Records Found in New Business Basefile Only
new_bus_recs := join(bus_base_new, bus_base_old,
						left.bdid = right.bdid
						,new_bus_records_output(LEFT,RIGHT)
						,LEFT ONLY
						);
						
//New Records Found in New Contacts Basefile Only
new_cont_recs := join(cont_base_new, cont_base_old,
						left.did = right.did
						,new_cont_records_output(LEFT,RIGHT)
						,LEFT ONLY
						);
						
SampleRecs := parallel(output(choosen(sort(new_bus_recs, -bdid), 1000), named ('SampleNewBusiness')),
								 output(choosen(sort(new_cont_recs, -did), 1000), named('SampleNewContacts')))
								: success(FBNV2.SendEmail(filedate).build_success), failure(FBNV2.SendEmail(filedate).build_failure);	 

return SampleRecs;
end;								