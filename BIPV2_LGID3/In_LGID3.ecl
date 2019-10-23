import ut, BIPV2_Files, BIPV2;
// Hierarchy build output
// l_hrchy := recordof(BIPV2.files.business_header_building);
// ds_hrchy := dataset(ut.foreign_prod+'thor_data400::bipv2_hrchy::base::20130521::data', l_hrchy, thor);
// ds_hrchy := BIPV2.files.business_header_building;
// ds_hrchy := BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING;
// ...which must be tweaked into our layout
// ds_tweak := _idIntegrity.explode_DidsNoRid0(ds_hrchy,rcid,proxid) : independent;
// EXPORT In_LGID3 := project(ds_tweak, transform(BIPV2_LGID3.Layout_LGID3, self.LGID3:=left.proxid, self:=left));
// Followup iterations
// EXPORT In_LGID3 := dataset('~temp::lgid3::BIPV2_LGID3::it6d', BIPV2_LGID3.Layout_LGID3, thor);
EXPORT In_LGID3 := BIPV2_Files.files_lgid3.DS_BUILDING;
// EXPORT In_LGID3 := BIPV2_LGID3._files().base.built;
