import header,doxie, lib_fileservices, header_services,_Control;

// Moxie Keys built on demo thor and DKC'ed automatically

DestinationIP := 'edata12-bld.br.seisint.com';
DestinationVolume := '/thor_back5/local_data/demo/relatives/';

DKCKeys(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationVolume+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

d00 := fileservices.despray('~thor::out::relatives',DestinationIP,DestinationVolume + 'relatives.d00',,,,true);
key1 := DKCKeys('~thor::key::moxie.relatives.same_lname.person1.person2.number_cohabits.recent_cohabit.key','relatives.same_lname.person1.person2.number_cohabits.recent_cohabit.key');
key2 := DKCKeys('~thor::key::moxie.relatives.same_lname.person2.person1.number_cohabits.recent_cohabit.key','relatives.same_lname.person2.person1.number_cohabits.recent_cohabit.key');

ro := dataset('~thor_data400::base::relatives',header.Layout_Relatives,flat);

header.layout_relatives tSuppress(ro l) := transform
 self := l;
end;

rs := project(ro,tSuppress(left));

r:= rs; 


header.MAC_Despray_Relatives(r,first_thing);

u := doxie.File_Relatives_Unix_Plus;


two := BUILDINDEX(u,{same_lname,person1,person2,number_cohabits,recent_cohabit, (big_endian unsigned8 )__filepos},
			'key::moxie.relatives.same_lname.person1.person2.number_cohabits.recent_cohabit.key',moxie,overwrite);

	
three := BUILDINDEX(u,{same_lname,person2,person1,number_cohabits,recent_cohabit, (big_endian unsigned8 )__filepos},
			'key::moxie.relatives.same_lname.person2.person1.number_cohabits.recent_cohabit.key',moxie,overwrite);
			
export bwr_moxie_relatives := sequential(first_thing,parallel(two,three),d00,key1,key2);