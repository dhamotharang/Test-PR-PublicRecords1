import header,doxie;
#workunit ('name', 'Build Relatives keys');

r := dataset('~thor_data400::base::relatives',header.Layout_Relatives,flat);

header.MAC_Despray_Relatives(r,first_thing);

u := doxie.File_Relatives_Unix_Plus;


two := BUILDINDEX(u,{same_lname,person1,person2,number_cohabits,(big_endian unsigned8 )__filepos},
			'key::moxie.relatives.same_lname.person1.person2.number_cohabits.key',moxie,overwrite);

	
three := BUILDINDEX(u,{same_lname,person2,person1,number_cohabits,(big_endian unsigned8 )__filepos},
			'key::moxie.relatives.same_lname.person2.person1.number_cohabits.key',moxie,overwrite);
			
sequential(first_thing,parallel(two,three));