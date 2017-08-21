export Normalize_and_Rollup_Companies (string filedate) := function

ds_in 	:= WorldCheck.File_WorldCheck_In;

ds 		:= distribute(ds_in, random());

WorldCheck.Layout_WorldCheck_in fixcomp(ds l):= transform
self.companies := l.companies[1..1000];
self := l;
end;

in_file := project(ds, fixcomp(left));

// Shared parsing patterns for most
pattern SingleValue   := pattern('[^;]+');

// Invalid values which should be skipped
Invalid_Values        := [''             ,','
						 ,'NONE'         ,'N/A'
						 ,'NOT AVAILABLE','UNAVAILABLE'
						 ,'UNKNOWN'      ,'NONE REPORTED'];

// ds_with_new_fields := PROJECT(in_file, trfProject(left, counter));

layout_Companies     := WorldCheck.Layout_WorldCheck_Cleaned.layout_Companies;
Layout_WorldCheck_temp   := record
    string    UID;
	string255 Category;
    string50  Company           := ''; // Normalized for child dataset
end;
Layout_WorldCheck_rollup := record
    string  UID;
end;

MyParsedRecord := record, maxlength(10000)
	in_file;
	string CompleteValue := TRIM(MATCHTEXT(SingleValue),left,right);
end;

/* Parse the Company values	*/
MyParsedCompaniesds := PARSE(in_file,Companies,SingleValue,MyParsedRecord,scan,first);
/* Transform the Company values while specifying the invalid Company values */
Layout_WorldCheck_temp trfCompany(MyParsedCompaniesds l) := transform
	self.Company := IF(stringlib.StringToUpperCase(TRIM(l.CompleteValue,left,right)) in Invalid_Values
							 ,SKIP
							 ,TRIM(l.CompleteValue,left,right));
	self := l;
end;
/* Normalize the Company values */
ds_NormCompanies := NORMALIZE(MyParsedCompaniesds
						,1
						,trfCompany(left));

WorldCheck.Out_Companies_Stats_Population(ds_NormCompanies
                                         ,filedate
										 ,do_STRATA);
do_STRATA;

count_ds_Companies := count(ds_NormCompanies);
output('Company count: ' + count_ds_Companies);
ds_NormCompanies_sorted := sort(ds_NormCompanies,UID);

ds_filter := ds_NormCompanies_sorted(regexfind('[A-Z]+|'+'[a-z]+',company,0)='');

Layout_WorldCheck_temp CompP(ds_filter l, in_file r) := TRANSFORM
self.Company := StringLib.StringToUpperCase(TRIM(r.last_name,left,right));
SELF := l;
END;

CompanyFind := JOIN(ds_filter,in_file,
LEFT.Company = RIGHT.UID,
CompP(LEFT,RIGHT),
LEFT OUTER);

ds_filter_2 := ds_NormCompanies_sorted(regexfind('[A-Z]+|'+'[a-z]+',company,0)<>'');

ds_normcompanies_concat := CompanyFind + ds_filter_2;

/* Rollup of Places of Birth////////*/
Company_rollup := record,maxlength(5000)
	Layout_WorldCheck_rollup;
	dataset(layout_Companies) Company_detail;
end;

Company_rollup t_Company(ds_normcompanies_concat L) := transform
	self.Company_detail := row(L,WorldCheck.Layout_WorldCheck_Cleaned.layout_Companies);
	self := L;
end;

p_Company := project(ds_normcompanies_concat, t_Company(left));

Company_rollup  t_Company_child(p_Company L, p_Company R) := transform
	self.Company_detail       := L.Company_detail + row({r.Company_detail[1].Company}
											   ,WorldCheck.Layout_WorldCheck_Cleaned.layout_Companies);
	self                  := L;
end;

Company_out := rollup(sort(p_Company,record)
				 ,t_Company_child(left,right)
				 ,uid);	
count_ds_Companies_rollup := count(Company_out);
output('Company rollup count: ' + count_ds_Companies_rollup);
// output(Company_out);

Company_out_dist := sort(distribute(Company_out, hash32(UID)), uid, local) : persist(WorldCheck.cluster_name + 'Persist::WorldCheck::Company::rollup');

return Company_out_dist ;

end;