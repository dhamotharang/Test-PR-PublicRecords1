import WorldCheck;

export Normalize_External_Sources (string filedate) := function

in_file := WorldCheck.File_WorldCheck_In;

// Shared parsing pieces for external sources
pattern SingleExtSrc  := pattern('[^ ]+');

MyParsedExtSrcRecord := record, maxlength(30900)
	in_file;
	string CompleteExtSrc := TRIM(MATCHTEXT(SingleExtSrc),left,right);
end;

// Invalid values which should be skipped
Invalid_Values := [''             ,','
				  ,'NONE'         ,'N/A'
				  ,'NOT AVAILABLE','UNAVAILABLE'
				  ,'UNKNOWN'      ,'NONE REPORTED'];

layout_Ext_Sources := WorldCheck.Layout_WorldCheck_Ext_Sources;

/* Parse the External Source values */
MyParsedExtSrcsds := PARSE(in_file,External_Sources,SingleExtSrc,MyParsedExtSrcRecord,scan,first);
/* Transform the External Source values while specifying the invalid External Source values */
layout_Ext_Sources trfExtSrc(MyParsedExtSrcsds l) := transform
	self.External_Source := IF(stringlib.StringToUpperCase(TRIM(l.CompleteExtSrc,left,right)) in Invalid_Values
							 ,SKIP
							 ,TRIM(l.CompleteExtSrc,left,right));
	self.UID := (INTEGER)l.UID;
	self := l;
end;

/* Normalize the External Sources */
ds_NormExt_Srcs := NORMALIZE(MyParsedExtSrcsds
						,1
						,trfExtSrc(left));
count_ds_Ext_Srcs := count(ds_NormExt_Srcs);

output('External Sources count: ' + count_ds_Ext_Srcs);
// output(sort(ds_NormExt_Srcs,UID,External_Source));

ds_NormExt_Srcs_deduped := distribute(dedup(ds_NormExt_Srcs,UID,External_Source),hash32(UID));
count_ds_Ext_Srcs_deduped := count(ds_NormExt_Srcs_deduped);

output('External Sources count: ' + count_ds_Ext_Srcs_deduped);

return ds_NormExt_Srcs_deduped;

end;
 