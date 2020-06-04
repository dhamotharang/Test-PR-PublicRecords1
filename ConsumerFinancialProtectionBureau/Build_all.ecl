import ConsumerFinancialProtectionBureau;
export Build_all(string filedate, boolean pUseProd = false, boolean isfcra = false) := function

    ConsumerFinancialProtectionBureau.MAC_build_base('blkgrp',filedate, pUseProd, bld_base_blkgrp);
    ConsumerFinancialProtectionBureau.MAC_build_base('blkgrp_attr_over18',filedate, pUseProd, bld_base_blkgrp_attr_over18);
    ConsumerFinancialProtectionBureau.MAC_build_base('census_surnames',filedate, pUseProd, bld_base_census_surnames);

    ConsumerFinancialProtectionBureau.MAC_build_key('blkgrp',filedate, pUseProd, isfcra, bld_key_blkgrp);
    ConsumerFinancialProtectionBureau.MAC_build_key('blkgrp_attr_over18',filedate, pUseProd, isfcra, bld_key_blkgrp_attr_over18);
    ConsumerFinancialProtectionBureau.MAC_build_key('census_surnames',filedate, pUseProd, isfcra, bld_key_census_surnames);

    build_keys := if(isfcra, 
                    parallel(
                        bld_key_blkgrp,
                        bld_key_blkgrp_attr_over18,
                        bld_key_census_surnames
                        ), 
                    parallel(
                        sequential(bld_base_blkgrp,bld_key_blkgrp),
                        sequential(bld_base_blkgrp_attr_over18,bld_key_blkgrp_attr_over18),
                        sequential(bld_base_census_surnames,bld_key_census_surnames)
                        )
                    );
    return build_keys;
end;