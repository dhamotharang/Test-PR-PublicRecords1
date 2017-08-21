import header, ut, did_add;

export fndelta_output(string hdrfileversion) := function

jn := dataset('~thor_data400::out::header::deltas',layout_header_delta.combined, thor);

/* add's entire record and removal rid's only */
adds_only := project(jn(delta_flag = 'A'), recordof(header.File_Headers));
rems_only := project(jn(delta_flag = 'R'), {unsigned8 rid});

/* normalize changes. rid, field name, field value */

changes_denorm := jn(delta_flag = 'C');

norm_changes := record unsigned8 rid; string20 changed_field; string changed_value; end;

norm_changes tNormChanges(recordof(jn) le, integer c) := transform
	self.rid := le.rid;
	self.changed_field := 
			stringlib.stringcleanspaces(StringLib.StringFindReplace(
			le.changed_field[stringlib.stringfind(le.changed_field, '|', c-1)..stringlib.stringfind(le.changed_field, '|', c)-1],
				'|', ''));
	self.changed_value := 
			stringlib.stringcleanspaces(StringLib.StringFindReplace(
			le.changed_value[stringlib.stringfind(le.changed_value, '|changed_values|', c-1)..stringlib.stringfind(le.changed_value, '|changed_values|', c)-1],
				'|changed_values|', ''));
end;

changes := normalize(changes_denorm, length(stringlib.stringfilter(left.changed_field, '|')), tNormChanges(left, counter))(changed_field <>'');		

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////BUILD OUTPUT FILES////////////////////////////////////////////////////////////////////////////////////

/* Get the prod header version from production environment */
// hdrfileversion := did_add.get_EnvVariable('header_file_version') : stored('shdrfileversion');
// hdrfileversion := 'testing8'; // for testing only

Build_File_Ouputs :=
sequential(
parallel(
output(distribute(adds_only, hash(rid)),,'~thor_data400::out::header::deltas_adds::'+hdrfileversion,cluster('thor400_84'), overwrite, __compressed__, csv(separator('\t')));
output(distribute(rems_only, hash(rid)),,'~thor_data400::out::header::deltas_rems::'+hdrfileversion,cluster('thor400_84'), overwrite, __compressed__);
output(distribute(changes,   hash(rid)),,'~thor_data400::out::header::deltas_chgs::'+hdrfileversion,cluster('thor400_84'), overwrite, __compressed__, csv(separator('\t'))));
parallel(
fileservices.clearsuperfile('~thor_data400::out::header::deltas_adds_father',true);
fileservices.addsuperfile('~thor_data400::out::header::deltas_adds_father', '~thor_data400::out::header::deltas_adds',,true);
fileservices.clearsuperfile('~thor_data400::out::header::deltas_adds');
fileservices.addsuperfile('~thor_data400::out::header::deltas_adds', '~thor_data400::out::header::deltas_adds::'+hdrfileversion);

fileservices.clearsuperfile('~thor_data400::out::header::deltas_rems_father',true);
fileservices.addsuperfile('~thor_data400::out::header::deltas_rems_father', '~thor_data400::out::header::deltas_rems',,true);
fileservices.clearsuperfile('~thor_data400::out::header::deltas_rems');
fileservices.addsuperfile('~thor_data400::out::header::deltas_rems', '~thor_data400::out::header::deltas_rems::'+hdrfileversion);

fileservices.clearsuperfile('~thor_data400::out::header::deltas_chgs_father',true);
fileservices.addsuperfile('~thor_data400::out::header::deltas_chgs_father', '~thor_data400::out::header::deltas_chgs',,true);
fileservices.clearsuperfile('~thor_data400::out::header::deltas_chgs');
fileservices.addsuperfile('~thor_data400::out::header::deltas_chgs', '~thor_data400::out::header::deltas_chgs::'+hdrfileversion)
));

/////END CODING//////////////////////////////////////////////////////////////////////////////////////////

return Build_File_Ouputs;
end;
