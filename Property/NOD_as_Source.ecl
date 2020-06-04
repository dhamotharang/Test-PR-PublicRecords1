import property, header;

export NOD_as_Source(
       dataset(Property.Layout_Fares_Foreclosure_v2) pNoticeOfDefault=dataset([],Property.Layout_Fares_Foreclosure_v2),
       boolean p4HdrBld=false) := function

  dSourceData := dataset('~thor_data400::Base::ForeclosureHeader_Building',Property.Layout_Fares_Foreclosure_v2, flat);

  dSrcData := project(if(p4HdrBld, dSourceData, pNoticeOfDefault),Property.Layout_Fares_Foreclosure);

  src_rec := header.layouts_SeqdSrc.ND_src_rec;

//Core Logic Records
  header.Mac_Set_Header_Source(dSrcData(trim(deed_category) in ['N','L','R'] and source = 'FR'),
                               Property.Layout_Fares_Foreclosure,
                               src_rec,'NT',withUID1);
//BlackKnight Records                                
  header.Mac_Set_Header_Source(dSrcData(trim(deed_category) in ['N','L','R'] and source = 'B7'),
                               Property.Layout_Fares_Foreclosure,
                               src_rec,'B7',withUID2);

  withUID := withUID1 + withUID2;                               

  return withUID;

end;
