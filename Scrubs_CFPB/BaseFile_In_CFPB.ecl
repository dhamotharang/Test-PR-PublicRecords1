IMPORT Scrubs_CFPB as x;

d := DATASET('~thor50_dev_eclcc::base::cfpb::blkgrp',x.BaseFile_Layout_CFPB,THOR);

EXPORT BaseFile_In_CFPB := d;