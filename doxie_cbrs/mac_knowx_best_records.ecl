EXPORT mac_knowx_best_records(inbdids, knowx_outfile, mod_access, outrec = 'doxie_cbrs.Layout_BH_Best_String',outerjoin = 'FALSE') := MACRO
IMPORT doxie,drivers,ut,Business_Header,MDR;
//doxie.mac_header_field_Declare()

#uniquename(knowxbf)
#uniquename(Knowx_tra)

%knowxbf% := Business_Header.Key_BH_Best_KnowX;
outrec %knowx_tra%(inbdids l, %knowxbf% r) := TRANSFORM
  SELF.phone := IF (R.phone = 0, '', (STRING)R.phone);
  SELF.fein := IF (R.fein = 0, '', INTFORMAT(r.fein, 9, 1));
  SELF.zip := IF(r.zip > 0, INTFORMAT(r.zip,5,1), '');
  SELF.zip4 := IF(r.zip4 > 0, INTFORMAT(r.zip4,4,1), '');
  SELF.dt_last_seen := IF(r.dt_last_seen > 0, INTFORMAT(r.dt_last_seen,8,1), '');
  SELF := r;
  SELF := l;
END;

knowx_outfile := JOIN(inbdids, %knowxbf%,
                      KEYED(LEFT.bdid = RIGHT.bdid) AND
                      doxie.compliance.isBusHeaderSourceAllowed(RIGHT.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask) AND
                      (RIGHT.dppa_state = '' or (mod_access.isValidDPPA() AND mod_access.isValidDPPAState(RIGHT.dppa_state, , RIGHT.source))),
                      %knowx_tra%(LEFT, RIGHT)
                      #IF(outerjoin)				
                         ,LEFT OUTER
                      #END
                     );
    
ENDMACRO;
