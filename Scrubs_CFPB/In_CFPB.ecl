IMPORT Scrubs_CFPB as x;

d := DATASET('~thor50_dev_eclcc::base::cfpb::blkgrp',x.Layout_CFPB,THOR);

EXPORT In_CFPB := d;