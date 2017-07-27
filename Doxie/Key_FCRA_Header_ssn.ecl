import autokey, header, ut,mdr,doxie_build;

fhb       :=doxie_build.file_header_building(src in mdr.sourceTools.set_scoring_FCRA);
hpk       :=distribute(header.Prepped_For_Keys,hash(rid));
fcra_rids :=distribute(table(fhb,{rid}),hash(rid));

t := join(hpk,fcra_rids,left.rid=right.rid,local);

autokey.MAC_SSN(t,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,city_name,zip,sec_range,
						states,
						lname1,lname2,lname3,
						city1,city2,city3,
						rel_fname1,rel_fname2,rel_fname3,
						lookups,
						did,
						ut.Data_Location.Person_header+'thor_data400::key::fcra::header.ssn.did',
						k)

export Key_FCRA_Header_ssn := k;