import iesp, doxie;

out_rec := iesp.internetdomain.t_InetDomainRecord;


EXPORT dataset (out_rec) internetdomain_records (
  dataset (doxie.layout_references) dids,
  input.internetdomains in_params = module (input.internetdomains) end,
  boolean IsFCRA = false
) := FUNCTION

  return dataset ([], out_rec);
END;
