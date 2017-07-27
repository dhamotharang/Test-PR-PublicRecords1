import header;

src_rec := record 
 unsigned4	seq := 0;
 header.Layout_Source_ID;
 unsigned6	bdid := 0;
 Property.Layout_Fares_Foreclosure;
end;

export File_Forclosures_BDID := dataset('~thor_data400::base::property_forclosures_bdid',src_rec,flat);
