import LocationID_iLink, LocationID_Ingest;

export Layouts := module

  export LocIDRawIdRec := record
    LocationID_Ingest.files_locationid.ds_base.locid;
    typeof(LocationID_Ingest.files_locationid.ds_base.aid) cleanaid;
    typeof(LocationID_Ingest.files_locationid.ds_base.aid) rawaid;
    LocationID_iLink.Files.rawAIDDs.line1;
    LocationID_iLink.Files.rawAIDDs.linelast;
  end;
end;