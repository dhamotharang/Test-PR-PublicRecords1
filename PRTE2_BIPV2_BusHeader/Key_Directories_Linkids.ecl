﻿import bipv2, AutoStandardI, tools, topbusiness_bipv2;

export Key_Directories_Linkids := 
module

  shared ds_contacts       := PRTE2_BIPV2_BusHeader.Key_Contact_Linkids.keybuilt;
  shared ds_industry       := PRTE2_BIPV2_BusHeader.key_industry_linkids.keybuilt;
  shared ds_contactsbuilt  := PRTE2_BIPV2_BusHeader.Key_Contact_Linkids.keybuilt;
  shared ds_industrybuilt  := PRTE2_BIPV2_BusHeader.key_industry_linkids.keybuilt;

  shared fmakecommon(
     dataset(recordof(ds_contacts))  pcontacts
    ,dataset(recordof(ds_industry))  pindustry
  ) := 
  function
  
	layouts.rec_other_directories_layout xform_contacts(ds_contacts le) := transform
	   self.rec_type        := 'C';
     self.contacts_fields := le;
     self                 := le;
     self                 := [];//for the industry fields
    end;

    layouts.rec_other_directories_layout xform_industry(ds_industry le) := transform
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
  
  shared superfile_name := keynames().directories_linkids.QA;

  BIPV2.IDmacros.mac_IndexWithXLinkIDs(concat_them, k, superfile_name)
  export Key := k;


  BIPV2.IDmacros.mac_IndexWithXLinkIDs(concat_thembuilt, kb, superfile_name)  //for use inside BIP build since keys haven't been promoted to qa yet.
  export kbuilt := kb;
  
  export keyvs := tools.macf_FilesIndex('Key' ,keynames().directories_linkids);
  export keybuilt := keyvs.built;
  export keyfather := keyvs.father;
  export keygrandfather := keyvs.grandfather;

  //DEFINE THE INDEX ACCESS
  export kFetch(
                  dataset(BIPV2.IDlayouts.l_xlink_ids) inputs 
                  ,string1 Level = BIPV2.IDconstants.Fetch_Level_DotID
                  ,unsigned2 ScoreThreshold = 0
									,BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
									JoinLimit=25000
                  ) :=
  function

    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level, JoinLimit);
    isperm := BIPV2.mod_sources.isPermitted(in_mod);

    ds_restricted := out(isperm.bySource(industry_fields.source, contacts_fields.vl_id)
    and isperm.bySource(contacts_fields.source, contacts_fields.vl_id)
    );
    return ds_restricted;
									
  end;
	
end;