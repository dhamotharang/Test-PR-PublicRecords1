import bipv2_build,topbusiness_bipv2,bipv2,AutoStandardI,tools,doxie;

export key_directories_linkids :=
module

  shared ds_contacts       := bipv2_build.key_contact_linkids.key;
  shared ds_industry       := topbusiness_bipv2.key_industry_linkids.key;
  shared ds_contactsbuilt  := bipv2_build.key_contact_linkids.keybuilt;
  shared ds_industrybuilt  := topbusiness_bipv2.key_industry_linkids.keybuilt;


  shared fmakecommon(
     dataset(recordof(ds_contacts))  pcontacts
    ,dataset(recordof(ds_industry))  pindustry
  ) := 
  function
    BIPV2_Build.Layout_Directories_Linkids_key xform_contacts(ds_contacts le) := transform
     self.rec_type        := 'C';
     self.contacts_fields := le;
     self                 := le;
     self                 := [];//for the industry fields
    end;

    BIPV2_Build.Layout_Directories_Linkids_key xform_industry(ds_industry le) := transform
     self.rec_type        := 'I';
     self.industry_fields := le;
     self                 := le;
     self                 := [];//for the contacts fields
    end;

    proj_contacts := project(pcontacts,xform_contacts(left));
    proj_industry := project(pindustry,xform_industry(left));

    concat_them := proj_contacts+proj_industry;
    return concat_them;

  end;
 
  export concat_them       := fmakecommon(ds_contacts      ,ds_industry      );
  shared concat_thembuilt  := fmakecommon(ds_contactsbuilt ,ds_industrybuilt );
  
  shared superfile_name := keynames().directories_linkids.QA;//vern can you create so that it's consistent with other business header keys?

  BIPV2.IDmacros.mac_IndexWithXLinkIDs(concat_them, k, superfile_name)
  export Key := k;


  BIPV2.IDmacros.mac_IndexWithXLinkIDs(concat_thembuilt, kb, superfile_name)  //for use inside BIP build since keys haven't been promoted to qa yet.
  export kbuilt := kb;
  
  export keyvs(string pversion = '',boolean penvironment = tools._Constants.IsDataland) := tools.macf_FilesIndex('Key' ,keynames(pversion,penvironment).directories_linkids);
  export keybuilt := keyvs().built;
  export keyfather := keyvs().father;
  export keygrandfather := keyvs().grandfather;

  //DEFINE THE INDEX ACCESS
  export kFetch(
                  dataset(BIPV2.IDlayouts.l_xlink_ids) inputs 
                  ,string1 Level = BIPV2.IDconstants.Fetch_Level_DotID
                  ,unsigned2 ScoreThreshold = 0
									,BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
									JoinLimit=25000
                  ,doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END
                  ) :=
  function

    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level, JoinLimit);
    isperm := BIPV2.mod_sources.isPermitted(in_mod);

    ds_restricted := out(isperm.bySource(industry_fields.source, contacts_fields.vl_id)
    and isperm.bySource(contacts_fields.source, contacts_fields.vl_id)
    );
    
    BIPV2_build.mac_check_access(ds_restricted, ds_restricted_out, mod_access, false, contact_fields.contact_did);
    
    return ds_restricted_out;
									
  end;
  
end;