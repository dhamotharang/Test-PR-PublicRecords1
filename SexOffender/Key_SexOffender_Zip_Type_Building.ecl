import autokey, doxie, doxie_build, ut, hygenics_search, hygenics_soff;

export Key_SexOffender_Zip_Type_Building (boolean IsFCRA = false) := function

f := doxie_build.file_SO_Enh_keybuilding;

xl := RECORD
	f;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('SEX'))| ut.bit_set(0,0);
	real lat;
	real long;
END;

xl xpand(f le,integer cntr) := TRANSFORM 
	SELF.did := cntr + autokey.did_adder('SEX'); 
	self.lat := (real)(ziplib.ZipToGeo21(le.alt_zip)[1..9]),
	self.long := (real)(ziplib.ZipToGeo21(le.alt_zip)[11..]),
	SELF := le; 
END;

DS := PROJECT(f,xpand(LEFT,COUNTER)) : PERSIST('persist::sex_offender_enh_fdids');

f_zip_type_base_fcra 	:= project(DS(seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key),transform(sexoffender.layout_zip_type_key,
														self.alt_zip := (INTEGER4)left.alt_zip,
														self.yob := (UNSIGNED2)(left.dob[1..4]),
														self.dob := (INTEGER4)left.dob, 
														self := left))(alt_zip<>0);

f_zip_type_base 			:= project(DS,transform(sexoffender.layout_zip_type_key,
														self.alt_zip := (INTEGER4)left.alt_zip,
														self.yob := (UNSIGNED2)(left.dob[1..4]),
														self.dob := (INTEGER4)left.dob, 
														self := left))(alt_zip<>0);

string file_name := if (IsFCRA, 
						Constants.Cluster+'::key::sexoffender::fcra::zip_type'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
						Constants.Cluster+'::key::sexoffender_zip_type'+doxie_build.buildstate+'_'+doxie.Version_SuperKey);

return if (IsFCRA,
           index(f_zip_type_base_fcra,{alt_zip, alt_type, yob, dob}, {did}, file_name, OPT),
           index(f_zip_type_base,{alt_zip, alt_type, yob, dob}, {did}, file_name));
end;