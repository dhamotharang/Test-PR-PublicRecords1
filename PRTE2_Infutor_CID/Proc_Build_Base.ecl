IMPORT Cortera, MDR, UT, PromoteSupers, std, Prte2, PRTE2_Cortera, Address, AID, AID_Support;
EXPORT Proc_build_base (string filedate) := FUNCTION

    ds_Boca_out := Project(PRTE2_Infutor_CID.Files.IN_PhonesPlus(did[1..4]='8888'), Transform(PRTE2_Infutor_CID.Layouts.Infutor_Base,
                                                SELF.historical := false,
                                                SELF.orig_crte := LEFT.cart,
                                                SELF.orig_dpbc := LEFT.dpbc,
                                                SELF.did_instantid := LEFT.did;
                                                SELF.dt_first_seen := (UNSIGNED6)((string)LEFT.datelastseen + '01'),
                                                SELF.dt_last_seen := (UNSIGNED6)((string)LEFT.datelastseen + '01'),
                                                SELF.dt_vendor_first_reported := (UNSIGNED6)((string)LEFT.datevendorfirstreported + '01'),
                                                SELF.dt_vendor_last_reported := (UNSIGNED6)((string)LEFT.datevendorlastreported + '01'),
                                                SELF.name_suffix := LEFT.name_suffix,
                                                SELF.orig_addressvalidationdate := (string)LEFT.datelastseen + '01',
                                                SELF.orig_city := LEFT.origcity,
                                                SELF.orig_cnty := LEFT.ace_fips_county,
                                                SELF.county := SELF.orig_cnty,
                                                SELF.orig_firstdate := (string)LEFT.datefirstseen +'01',
                                                SELF.orig_firstname := LEFT.fname,
                                                SELF.orig_lastdate := (string)LEFT.datelastseen +'01',
                                                SELF.orig_lastname := LEFT.lname,
                                                SELF.orig_mi := LEFT.mname,
                                                SELF.orig_phone := LEFT.cellphone,
                                                SELF.orig_phonetype := LEFT.orig_phone_type,
                                                SELF.orig_primaryhousenumber := LEFT.prim_range,
                                                SELF.orig_primarypostdirabbrev := LEFT.postdir,
                                                SELF.orig_primarypredirabbrev := LEFT.predir,
                                                SELF.orig_primarystreetname := LEFT.prim_name,
                                                SELF.orig_primarystreettype := LEFT.addr_suffix,
                                                SELF.orig_recordtype := 'R',
                                                SELF.orig_secondaryaptnbr := LEFT.sec_range,
                                                SELF.orig_secondaryapttype := LEFT.unit_desig,
                                                SELF.orig_state := LEFT.origstate,
                                                SELF.orig_telephoneconfidencescore := (string)LEFT.confidencescore,
                                                SELF.orig_zip := LEFT.origzip,
                                                SELF.orig_zip4 := LEFT.zip4,
                                                SELF.persistent_record_id := filedate + '_' + (string)intformat(counter, 10,1),
                                                SELF.phone := LEFT.CELLPHONE,
                                                SELF.rawaidin := LEFT.rawaid,
                                                SELF.sequence_number := (string)counter;
                                                SELF.st := LEFT.state,
                                                SELF.title := LEFT.title,
                                                SELF.zip := LEFT.zip5,
                                                SELF := LEFT, //one to one mapping
                                                SELF := [])); //all other fields remain blank

    
      addGSFiltered := MDR.macGetGlobalSid(ds_Boca_out,'infutorcid','','global_sid');    
    
    //Build Base
      PromoteSupers.MAC_SF_BuildProcess(addGSFiltered, Constants.base, bld_base, ,, true);
  
  return bld_base;
end;