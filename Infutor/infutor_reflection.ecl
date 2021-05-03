import header_services, business_header, AID, infutor, header ;


EXPORT infutor_reflection(dataset(infutor_layout_main.layout_base_tracker) ds_base) := function

  return Infutor.Prep_Build.Reflection(ds_base);

end;