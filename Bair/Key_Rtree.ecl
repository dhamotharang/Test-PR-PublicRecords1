import Data_Services;

EXPORT Key_Rtree(string v='qa') := MODULE

r:=RECORD
  integer4 parentnodeid;
  integer4 bboxminx;
  integer4 bboxminy;
  integer4 bboxmaxx;
  integer4 bboxmaxy;
  integer4 nodeid;
  unsigned8 dsfpos;
  integer4 level;
  integer2 nodetype;
  string50 geom;
	string11 longitude;
  string10 latitude;
  string8 date;
  string10 ucr_group;
  string10 ori;
	unsigned8 etype;
  string100 eid;
  unsigned8 __internal_fpos__;
 END;

d:=dataset([],r);
i:=index(d,{parentnodeid, bboxminx, bboxminy, bboxmaxx, bboxmaxy},{d},data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::rtree::'+v);

EXPORT Main := i;

i:=dataset(data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::rtree::'+v+'::metadata',{ integer2 maxlevels },flat);

EXPORT metadata := i;

END;