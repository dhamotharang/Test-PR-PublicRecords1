EXPORT mac_knowx_best_records(inbdids, knowx_outfile, outrec = 'doxie_cbrs.Layout_BH_Best_String',outerjoin = 'FALSE') := MACRO
IMPORT doxie,drivers,ut,Business_HEader,MDR;
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
  (NOT MDR.sourceTools.SourceIsEBR(RIGHT.source) OR NOT doxie.DataRestriction.EBR) AND
  (RIGHT.dppa_state = '' OR (dppa_ok AND drivers.state_dppa_ok(RIGHT.dppa_state,dppa_purpose,,RIGHT.source))) AND
  (RIGHT.source <> MDR.sourceTools.src_Dunn_Bradstreet OR Doxie.DataPermission.use_DNB),
  %knowx_tra%(LEFT, RIGHT)
  #IF(outerjoin)
  ,LEFT OUTER
  #END
  );

    
ENDMACRO;
