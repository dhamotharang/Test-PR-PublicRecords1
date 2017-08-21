

import crim_common;
import crim_cp_ln;

export Layout_criminal_supplimental_cp := RECORD
  INTEGER ecl_cade_id;
  crim_common.Layout_Moxie_Crim_Offender2.previous.offender_key;
  crim_cp_ln.layout_cross_criminal_supplimental;
  end;
