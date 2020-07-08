IMPORT PhoneMart, MDR, UT, PromoteSupers, std, Prte2, PRTE2_PhoneMart, Address, AID, AID_Support;

EXPORT Proc_build_base := FUNCTION

    ds_Boca_out := Project(PRTE2_PhoneMart.Files.IN_PhonesPlus(((string)(did))[1..3]='888'), Transform(PRTE2_PhoneMart.Layouts.PRTE_PhoneMart_Base,
                                                SELF.phone := LEFT.cellphone,
                                                SELF.dt_vendor_first_reported := (UNSIGNED6)((string)LEFT.datevendorfirstreported + '01'),
                                                SELF.dt_vendor_last_reported := (UNSIGNED6)((string)LEFT.datevendorlastreported + '01'),
                                                SELF.dt_first_seen := (UNSIGNED6)((string)LEFT.datefirstseen + '01'),
                                                SELF.dt_last_seen := (UNSIGNED6)((string)LEFT.datelastseen + '01'),
                                                SELF.record_type := '4',
                                                SELF.address := LEFT.Address1 + LEFT.Address2,
                                                SELF.city := LEFT.origcity,
                                                SELF.zipcode := LEFT.origzip,
                                                SELF.history_flag := '',
                                                SELF.Bug_Num := 'PRCT-244',
                                                SELF := LEFT, //one to one mapping
                                                SELF := [])); //all other fields remain blank

    
      addGSFiltered := MDR.macGetGlobalSid(ds_Boca_out,'PhoneMart','','global_sid');    
    
    //Build Base
      PromoteSupers.MAC_SF_BuildProcess(addGSFiltered, Constants.base, bld_base, ,, true);
  
  return bld_base;
end;