lBaseKeyName 	:= 'key::moxie.civil_matter.';

rMoxieFileForKeybuildLayout
 :=
  record
	civil_court.Layout_Moxie_Matter;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

lMoxieFileForKeybuild := dataset(civil_court.Name_Moxie_Matter_Dev,rMoxieFileForKeybuildLayout,flat);

rKey_Fields_Layout
 :=
  record
	lMoxieFileForKeybuild.case_key;
	lMoxieFileForKeybuild.case_number;
	lMoxieFileForKeybuild.state_origin;
	big_endian unsigned8	filepos	:= (big_endian unsigned8)lMoxieFileForKeybuild.__filepos;
end;

lMatter_Keys_Table    := table(lMoxieFileForKeybuild,rKey_Fields_Layout);

//build matter keys
kCaseKey				:= buildindex(lMatter_Keys_Table(case_key<>''),
							{case_key,filepos},
							lBaseKeyName + 'case_key.key',moxie,overwrite);
kCaseNoStateOrigin		:= buildindex(lMatter_Keys_Table(case_number<>''),
							{case_number,state_origin,filepos},
							lBaseKeyName + 'case_number.state_origin.key',moxie,overwrite);
                           
//end matter keys

export Out_Moxie_Matter_Keys
 :=
  parallel(
			 kCaseKey 
			,kCaseNoStateOrigin
		   )
 ;