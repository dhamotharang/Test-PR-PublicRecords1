IMPORT dx_FirstData, Risk_Indicators, riskwise, STD;

EXPORT getFirstData(Grouped dataset(risk_indicators.layout_bocashell_btst_out) btst_clam, String Modelname) := FUNCTION
  
  //states that do not provide enough data to Kohls during a DL card swipe
  //only one state is known to do this at the moment (New Hampshire)
  low_dl_data_states := ['NH'];
  
  risk_indicators.layout_bocashell_btst_out xfm_FirstData(risk_indicators.layout_bocashell_btst_out le, Recordof(dx_FirstData.key_driverslicense()) ri) := Transform
    
    check_FirstData := STD.STR.ToLowerCase(Modelname) = 'osn1910_1' and le.ship_to_out.did = 0 and le.ship_to_out.shell_input.dl_state in low_dl_data_states;
    
    self.ship_to_out.did := IF(~check_FirstData, le.ship_to_out.did, ri.lex_id); //IF input shipto lexid is not found (0) then try to use the lex_id from the key
    self := le;
  END;
  
  do_FirstData_lookup := Join(btst_clam, dx_FirstData.key_driverslicense(),
                              left.ship_to_out.shell_input.dl_state in low_dl_data_states and 
                              keyed(left.ship_to_out.shell_input.dl_state  = right.dl_state) and 
                              keyed(left.ship_to_out.shell_input.dl_number = right.dl_id),
                              xfm_FirstData(left, right), left outer, atmost(riskwise.max_atmost));
  
  Return do_FirstData_lookup;
END;