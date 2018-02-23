EXPORT fn_ValidateInput := function

fnew := nothor(FileServices.Superfilecontents( '~thor_data400::in::prolic::allsources'));

fsort := sort(fnew,trim(name));

fprev := sort(File_In_Allsrc,flname);

recordof(fprev) tnew ( fprev l , fsort r ) := transform
self := l;
end;

jdiff := join ( fprev,
           fsort,
					 trim(left.flname)=trim(right.name),
					 tnew(left,right),
					 left only
					);

st_missing := jdiff[1].flname;

dsconcatall := output(Prof_License.File_prolic_in,,'~thor_data400::in::prolic_all_sources_'+workunit,compressed,overwrite);

return Sequential (IsValidDate,
                         dsconcatall,
                        FileServices.AddSuperfile('~thor_data400::in::prolic_all_sources', '~thor_data400::in::prolic_all_sources_'+workunit),
                        if ( count(jdiff) > 0 ,Sequential(output(jdiff,named('Missingfiles')),FAIL('IN files  missing.Please verify --'+st_missing),Output('Please go ahead with build process')));
              );
end;
/*

fvalid(string name) := function
string name1 := if ( trim(regexreplace('~',name,'')) not in fset,trim(name),'');

return output(dataset([name1],{string filename}),named('Missinglist'));//,'~thor_data400::in::prolic_missing_states',overwrite);
end;

return nothor(apply(File_In_Allsrc,fvalid(flname)));

*/


//return Sequential(output(fcnt,named('FileCount')),if ( fcnt <> 57   , FAIL('One IN file is missing.Please verify'),Output('Please go ahead with build process')));

