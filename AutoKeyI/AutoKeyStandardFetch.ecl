import AutokeyI;

ids_rec := record
  unsigned6 ID;
  boolean isDID;
  boolean isBDID;
  boolean IsFake;
end;

EXPORT AutoKeyStandardFetch (AutokeyI.AutoKeyStandardFetchArgumentInterface args) := FUNCTION

  ids_fetched :=  AutokeyI.FetchI.new.do (AutokeyI.FetchI_Pkg.new.val(args), args);
  mod := module
    export dataset(ids_rec) ids := project (ids_fetched, ids_rec);
  end;
	return mod;
           
END;