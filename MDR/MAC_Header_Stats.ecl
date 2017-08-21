export MAC_Header_Stats(f, outputname) := macro

#uniquename(fcounts)

%fcounts% := record
f.pflag1;
f.pflag2;
f.pflag3;
f.src;
f.dt_first_seen;
f.dt_last_seen;
f.dt_vendor_last_reported;
f.dt_vendor_first_reported;
f.dt_nonglb_last_seen;
f.rec_type;
unsigned2 yob := f.dob div 10000;
f.title;  // int1 lookup - with cleaning
f.name_suffix; // int1 lookup
f.predir; // int1 lookup
f.suffix; // int1 lookup
f.postdir; // int1
f.unit_desig; // int1 lookup
f.st; // int1 lookup
f.tnt;
f.valid_SSN;
f.jflag1;
f.jflag2;
f.jflag3;
  end;

#uniquename(slimmy)
%slimmy% := table(f,%fcounts%);

ut.MAC_Field_Count(%slimmy%,%slimmy%.pflag1, 'pflag1', true, true, lbl_30, true)
ut.MAC_Field_Count(%slimmy%,%slimmy%.pflag2, 'pflag2', true, true, lbl_31, true)
ut.MAC_Field_Count(%slimmy%,%slimmy%.pflag3, 'pflag3', true, true, lbl_32, true)
ut.MAC_Field_Count(%slimmy%,%slimmy%.src, 'src', true, true, lbl_33)
ut.MAC_Field_Count(%slimmy%,%slimmy%.dt_first_seen, 'dt_first_seen', true, true, lbl_34)
ut.MAC_Field_Count(%slimmy%,%slimmy%.dt_last_seen, 'dt_last_seen', true, true, lbl_35)
ut.MAC_Field_Count(%slimmy%,%slimmy%.dt_vendor_first_reported, 'dt_vendor_first_reported', true, true, lbl_36)
ut.MAC_Field_Count(%slimmy%,%slimmy%.dt_vendor_last_reported, 'dt_vendor_last_reported', true, true, lbl_37)
ut.MAC_Field_Count(%slimmy%,%slimmy%.dt_nonglb_last_seen, 'dt_nonglb_last_seen', true, true, lbl_38)
ut.MAC_Field_Count(%slimmy%,%slimmy%.rec_type, 'rec_type', true, true, lbl_39)
ut.MAC_Field_Count(%slimmy%,%slimmy%.yob, 'yob', true, true, lbl_40)
ut.MAC_Field_Count(%slimmy%,%slimmy%.title, 'title', true, true, lbl_41)
ut.MAC_Field_Count(%slimmy%,%slimmy%.name_suffix, 'name_suffix', true, true, lbl_42)
ut.MAC_Field_Count(%slimmy%,%slimmy%.predir, 'predir', true, true, lbl_43)
ut.MAC_Field_Count(%slimmy%,%slimmy%.suffix, 'suffix', true, true, lbl_44)
ut.MAC_Field_Count(%slimmy%,%slimmy%.postdir, 'postdir', true, true, lbl_45)
ut.MAC_Field_Count(%slimmy%,%slimmy%.unit_desig, 'unit_desig', true, true, lbl_46)
ut.MAC_Field_Count(%slimmy%,%slimmy%.st, 'st', true, true, lbl_47)
ut.MAC_Field_Count(%slimmy%,%slimmy%.tnt, 'tnt', true, true, lbl_48, true)
ut.MAC_Field_Count(%slimmy%,%slimmy%.valid_ssn, 'valid_ssn', true, true, lbl_49, true)
ut.MAC_Field_Count(%slimmy%,%slimmy%.jflag1, 'jflag1', true, true, lbl_50, true)
ut.MAC_Field_Count(%slimmy%,%slimmy%.jflag2, 'jflag2', true, true, lbl_51, true)
ut.MAC_Field_Count(%slimmy%,%slimmy%.jflag3, 'jflag3', true, true, lbl_52, true)

outputname := sequential(
lbl_30,
lbl_31,
lbl_32,
lbl_33,
lbl_34,
lbl_35,
lbl_36,
lbl_37,
lbl_38,
lbl_39,
lbl_40,
lbl_41,
lbl_42,
lbl_43,
lbl_44,
lbl_45,
lbl_46,
lbl_47,
lbl_48,
lbl_49,
lbl_50,
lbl_51,
lbl_52
);

endmacro;