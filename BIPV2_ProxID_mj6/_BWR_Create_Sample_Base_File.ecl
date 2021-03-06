import BIPV2_ProxID_mj6,tools;
pversion := '20131025_47';
dbase := BIPV2_ProxID_mj6.files(,true).base.qa(TRIM(v_city_name) in ['MICHIGAN CITY','DAYTON','MIAMISBURG','BOCA RATON','WESTON'],TRIM(st) in ['IN','OH','FL']);
writefile := tools.macf_WriteFile(BIPV2_ProxID_mj6.filenames(pversion).base.logical,dbase);
//output(BIPV2_ProxID_mj6.files('20130808_44a').base.qa);
sequential(
   writefile
  ,BIPV2_ProxID_mj6._promote(pversion,'base').new2built
  ,BIPV2_ProxID_mj6._promote(pversion,'base').built2qa
);
//output(bipv2.CommonBase.DS_base);
