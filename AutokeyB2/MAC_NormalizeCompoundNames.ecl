
export MAC_NormalizeCompoundNames(indataset, outdataset, name_field='lname', dedup_recs=false) := MACRO

import Header;

#uniquename(__hdr_const)
#uniquename(__delim_pattern)
#uniquename(__part_pattern)

%__hdr_const% := Header.constants.compound_names;
%__delim_pattern% := '['+%__hdr_const%.esc_delims+']*'; 
// same as: [A-Za-z_0123456789] - names with '_' or digits resolve to parts that can be discarded (if desired) when normalizing the records
%__part_pattern% := '([\\w]*)'; 

#uniquename(layout_source)	
%layout_source% := recordof (indataset);

#uniquename(layout_w_partname)	
%layout_w_partname% := record
	%layout_source%;
	boolean hasDelimiters := false;
end;

// we want to skip records with no delimiters in the last name (the vast majority) when
// normalizing the dataset, so lets flag the records accordingly. 
#uniquename(indataset_delims)
#uniquename(trimmed_lname)
%indataset_delims% := project(indataset, 
															transform(%layout_w_partname%,
																	%trimmed_lname% := trim(left.name_field, left, right);	
																	self.hasDelimiters := 
																		length (%trimmed_lname%) > length (StringLib.StringFilterOut (%trimmed_lname%, %__hdr_const%.esc_delims));
																	self := left));

#uniquename(part_pattern)
%part_pattern% := %__part_pattern%+%__delim_pattern%+%__part_pattern%+%__delim_pattern%+%__part_pattern%+%__delim_pattern%+%__part_pattern%;

#uniquename(reg_part_name)
#uniquename(valid_part_name)
#uniquename(normalize_name)
%layout_source% %normalize_name%(recordof(%indataset_delims%) l, integer c) := function

	%reg_part_name% := choose(c,
														l.name_field,
														// also creating an additional record with a clean (no delimiters) version of a compound name.
														// for instance, this should produce hits when using DELAHOYA or DEJESUS to find DE LA HOYA or DE JESUS.
														StringLib.StringFilterOut(l.name_field, %__hdr_const%.esc_delims),
														regexfind(%part_pattern%, l.name_field, 1),
														regexfind(%part_pattern%, l.name_field, 2),
														regexfind(%part_pattern%, l.name_field, 3),
														regexfind(%part_pattern%, l.name_field, 4));	

	%valid_part_name% :=  length(%reg_part_name%) > 2 and  										
												// excluding part names with digits
												length (%reg_part_name%) = length (StringLib.StringFilterOut (%reg_part_name%, %__hdr_const%.digits)) and
												%reg_part_name% not in %__hdr_const%.exclusion_names and
												%reg_part_name% not in %__hdr_const%.invalid_names;											
	
	// wrap transform into function, 'cause using SKIP side-effect within transform won't compile (see AutoKey.MAC_Add_Cities #26701)
	// always keep the first last name (which is the original last name) and make sure all others (normalized parts) are valid.
	%layout_source% t := transform, skip((c<>1) and (~%valid_part_name%))
		self.name_field := if(c=1, l.name_field, %reg_part_name%);											
		self := l;
	end;	
	
	return t;
	
end;

#uniquename(indataset_norm)
%indataset_norm% := normalize(%indataset_delims%, if(left.hasDelimiters, %__hdr_const%.nbr_parts+2, 1), %normalize_name%(left, counter), LOCAL);

// by default, not deduping records here as they will eventually be deduped when building the individual keys.
outdataset :=  if(dedup_recs, 
									dedup (sort(%indataset_norm%, record, local), record, local),
									%indataset_norm%);

ENDMACRO;
