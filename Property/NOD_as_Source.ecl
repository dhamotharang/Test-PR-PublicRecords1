import property, header;

export NOD_as_Source(
       dataset(property.Layout_Fares_Foreclosure) pNoticeOfDefault=dataset([],property.Layout_Fares_Foreclosure),
       boolean p4HdrBld=false) := function

  dSourceData := dataset('~thor_data400::Base::ForeclosureHeader_Building',Property.Layout_Fares_Foreclosure, flat);

  dSrcData := if(p4HdrBld, dSourceData, pNoticeOfDefault);

  src_rec := record
    header.layout_source_id;
    property.Layout_Fares_Foreclosure;
  end;

  header.Mac_Set_Header_Source(dSrcData(trim(deed_category)='N'),
                               property.Layout_Fares_Foreclosure,
                               src_rec,'NT',withUID);

  dNODHeader := withUID : persist('persist::headerbuild_nod_src');

  dNODOther := withUID;

  dsSrc := if(p4HdrBld, dNODHeader, dNODOther);

  return dsSrc;

end;
