import ConsumerFinancialProtectionBureau, RoxieKeyBuild, PromoteSupers, std;
export Build_all(string filedate, boolean pUseProd = false, boolean isfcra = false) := function
    ConsumerFinancialProtectionBureau.MAC_keybuild('blkgrp',filedate, pUseProd, isfcra, seq_blkgrp);
    ConsumerFinancialProtectionBureau.MAC_keybuild('blkgrp_attr_over18',filedate, pUseProd, isfcra, seq_blkgrp_attr_over18);
    ConsumerFinancialProtectionBureau.MAC_keybuild('census_surnames',filedate, pUseProd, isfcra, seq_census_surnames);
    build_keys := parallel(
                seq_blkgrp,seq_blkgrp_attr_over18,seq_census_surnames
            );
    return build_keys;
end;