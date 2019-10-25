import $;
export sources := module
    export BaseBLKGRP := $.Build_BLKGRP('~thor::cfpb_race_proxy::blkgrp');
    export BaseBLKGRP_attr_over18 := $.Build_BLKGRP_attr_over18('~thor::cfpb_race_proxy::blkgrp_attr_over18');
    export BaseCensus_surnames := $.Build_census_surnames('~thor::cfpb_race_proxy::names_2010census2');
end;