import Address, AutoStandardI;

export Records(IParam.reportParams pMod) := function
        
  addr := AutoStandardI.InterfaceTranslator.clean_address.val(project (pMod, AutoStandardI.InterfaceTranslator.clean_address.params));
  ca := Address.CleanFields(addr);
  
  Layouts.feedback_input prep_input() := transform
    self.did := (unsigned6) pMod.did,
    self.prim_range := ca.prim_range,
    self.predir := ca.predir,
    self.prim_name := ca.prim_name,
    self.suffix := ca.addr_suffix,
    self.postdir := ca.postdir,
    self.sec_range := ca.sec_range,
    self.p_city_name := ca.p_city_name,
    self.v_city_name := ca.v_city_name,
    self.st := ca.st,
    self.zip := ca.zip,
    self.zip4 := ca.zip4,
    self.unit_desig := ca.unit_desig,
  end;

  dIn := dataset([prep_input()]);
  dRecs := Raw.byAddress(dIn);
  
  return dRecs;
    
end;
