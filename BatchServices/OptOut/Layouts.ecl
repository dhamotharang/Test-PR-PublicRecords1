IMPORT BatchServices, BatchShare, DidVille;

EXPORT Layouts := MODULE

  SHARED Input_Base := RECORD
    UNSIGNED6 did;
    STRING9  ssn;
    STRING8  dob;
    STRING10 phone;
    STRING5  title;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5  suffix;
    STRING10 prim_range;
    STRING2  predir;
    STRING28 prim_name;
    STRING4  addr_suffix;
    STRING2  postdir;
    STRING10 unit_desig;
    STRING8  sec_range;
    STRING25 city_name;
    STRING2  st;
    STRING5  zip;
    STRING4  zip4;
  END;

  EXPORT Input := RECORD
    STRING20 acctno;
    Input_Base;
  END;

  EXPORT Input_Processed := RECORD(Input)
    STRING20 orig_acctno := '';
    Batchshare.Layouts.ShareErrors;
  END;

  EXPORT Input_Ex := RECORD(Input_Processed)
    UNSIGNED6 srch_did := 0;
  END;

  EXPORT batch_in_didvile_rec := RECORD(DidVille.Layout_did_inbatch)
    UNSIGNED6 did := 0;
  END;

  EXPORT Output_Layout := RECORD
    STRING20          acctno;
    UNSIGNED8         lexid;
    UNSIGNED8         exemptions;
    STRING10          act_id;
    STRING8           date_added;
    BOOLEAN           optout_flag;
    BOOLEAN           test_flag;
    // echo input params
    UNSIGNED6         input_did;
    STRING9           input_ssn;
    STRING8           input_dob;
    STRING10          input_phone;
    STRING5           input_title;
    STRING20          input_fname;
    STRING20          input_mname;
    STRING20          input_lname;
    STRING5           input_suffix;
    STRING10          input_prim_range;
    STRING2           input_predir;
    STRING28          input_prim_name;
    STRING4           input_addr_suffix;
    STRING2           input_postdir;
    STRING10          input_unit_desig;
    STRING8           input_sec_range;
    STRING25          input_city_name;
    STRING2           input_st;
    STRING5           input_zip;
    STRING4           input_zip4;
    //
    Batchshare.Layouts.ShareErrors;
  END;

END;