﻿IMPORT dx_common;

rec := dx_common.layout_ridkey;

EXPORT Key_Intermediate_Delta_Rid(integer typ=0) := INDEX ({rec.record_sid}, rec, $.Names().i_intermediate_delta_rid_super,OPT);
