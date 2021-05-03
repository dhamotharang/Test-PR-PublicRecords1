import header_services, business_header, AID, infutor, header, ut,STD, data_services ;


EXPORT infutor_reflection_header(dataset(header.layout_header) ds_Xform) := function

  return Infutor.Prep_Build.Reflection_header(ds_Xform);

end ;