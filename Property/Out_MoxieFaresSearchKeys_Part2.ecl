import property,Lib_KeyLib;
#workunit ('name', 'Build Fares Search File Keys 2');

string_rec := record
	property.Layout_prop_out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(property.Filename_Fares_DID_Out, string_rec, THOR);


MyFields := record		
  h.process_date;
  string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);
  string45 company1 := h._company[1..45];
  string45 lfm :='';
  h.prim_range;
  h.prim_name;
    h.st;
  h.zip;
  h.__filepos;
end;

t := table(h,MyFields);


MyFields use_lfm(MyFields l, unsigned1 cnt) := TRANSFORM
	self.lfm := choose(cnt, l.lfmname, l.company1);
	self := l;
end;

lfm_records := NORMALIZE(t,2,use_lfm(left,counter));

kLFMName		:= BUILDINDEX(lfm_records(lfm<>''),{lfm,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'lfmname.key', MOXIE, overwrite);
kStLFMName		:= BUILDINDEX(lfm_records(lfm<>''),{st,lfm,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'st.lfmname.key', MOXIE, overwrite);
kZ5LFMName		:= BUILDINDEX(lfm_records(lfm<>''),{zip,lfm,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'z5.lfmname.key', MOXIE, overwrite);
kZ5PrimLFMName	:= BUILDINDEX(lfm_records(lfm<>''),{zip,prim_name,prim_range,lfm,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'z5.prim_name.prim_range.lfmname.key', MOXIE, overwrite);
								
kPDateLFMName	:= BUILDINDEX(lfm_records(lfm<>''),{process_date,lfm,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'process_date.lfmname.key', MOXIE, overwrite);
								

export Out_MoxieFaresSearchKeys_Part2
 :=
  parallel
	(
	 kLFMName
	,kStLFMName
	,kZ5LFMName
	,kZ5PrimLFMName
	,kPDateLFMName
	)
  ;