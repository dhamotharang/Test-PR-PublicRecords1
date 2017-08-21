import header,ut,address,mdr,idl_header;

export Mac_Prep_for_BM(ifile,ofile,suffix_) := macro

//Various address and name fixes
#uniquename(scrub_)
header.Mac_scrub_fields(ifile,%scrub_%);

//Fix any funky DOBs
#uniquename(better_dob)
header.MAC_format_DOB(%scrub_%,dob,%better_dob%);
 
//fix any funky prim_ranges
#uniquename(better_pr)
header.MAC_Improve_Prim_Range(%better_dob%,prim_range,%better_pr%);

//Patch where mname equals 'NMI' or 'NMN'
#uniquename(better_name)
header.MAC_NMI_NMN(%better_pr%,mname,%better_name%);

//Patch where phone exchange equals '555'
#uniquename(keep_em_555)
header.MAC_555_phones(%better_name%, phone, %keep_em_555%);

#uniquename(char_swapped)
header.Mac_character_swapping(%keep_em_555%,%char_swapped%);

#uniquename(flipnames)
ut.mac_flipnames(%char_swapped%,fname,mname,lname,%flipnames%);

#uniquename(Fix_Suffix)
Header.mac_Fix_Suffix(%flipnames%,%Fix_Suffix%);

#uniquename(NoTtee)
header.Mac_clean_trustee_name(%Fix_Suffix%,%NoTtee%);

#if(suffix_='NHR')
	#uniquename(flagged)
	address.Mac_Is_Business_Parsed(%NoTtee%,%flagged%);
	#uniquename(NoBuss)
	%NoBuss% := %flagged%(nametype='P');
	ofile := project(%NoBuss%,{ifile})
						(fname<>'' and lname<>'' and header.isPersonRec(fname, mname, lname, name_suffix))
		:persist('~thor_data::persist::clean_'+suffix_)
		;
#else
	ofile := project(%NoTtee%,{ifile})
	((prim_name<>'' and zip<>'' and fname<>'' and lname<>'')
					or (mdr.sourcetools.sourceisdeath(src) and fname<>'' and lname<>'' and ssn<>''))
	:persist('~thor_data::persist::clean_'+suffix_)
	;
#end

endmacro;
