IMPORT business_header,doxie, ut, data_services, STD;

bh := Business_Header.File_Business_Header_Base_for_keybuild(prim_name!='' AND zip!=0);

layout_bh_slim :=
RECORD
  bh.prim_name;
  bh.zip;
  bh.sec_range;
  bh.prim_range;
  bh.bdid;
END;

layout_bh_slim tstripordinal(bh l) :=
TRANSFORM
  SELF.prim_name := ut.StripOrdinal(STD.STR.ToUpperCase(l.prim_name));
  SELF := l;
END;

bh_slim := PROJECT(bh, tstripordinal(LEFT));


d := DEDUP(bh_slim,prim_name,zip,sec_range,prim_range, bdid, ALL);

EXPORT Key_Addr_bdid := INDEX(d,
{prim_name,zip,sec_range,prim_range},
{bdid},
data_services.data_location.prefix() + 'thor_data400::key::cbrs.addr.bdid_' + doxie.Version_SuperKey);
