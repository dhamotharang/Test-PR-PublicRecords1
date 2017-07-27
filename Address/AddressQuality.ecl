export AddressQuality(string10 rng, string30 nme, string10 sfx, string10 sng, string30 city, string5 zp, string4 zp4= '') :=
  MAP( nme[1..3]='USS' and city='FPO' => 1,
       nme IN ['','NONE','MISSING','APT','WAY','NUM','BLVD','FLOOR','FLR','BLDG','AVE'] OR LENGTH(TRIM(nme)) < 3 => IF ( (unsigned4)rng=0, 10, 5 ),
       nme[1] NOT IN ['C','T','R'] and length(trim(nme,all))>2 and length(trim(stringlib.stringfilterout(nme,nme[1])))=0 => 2,
       nme IN ['LOT','CALL','ANYWHERE','UPPER','TRLR','SPACE','MOUNT','SPC'] and sfx='' => IF ( (unsigned4)rng=0, 11, 6 ),
       (length(trim(stringlib.stringfilter(rng+nme+sng,'0123456789')))=0 OR 
       length(trim(stringlib.stringfilterout(rng+nme+sng,'0123456789')))=0) AND zp4 not between '0002' and '9997' => 7,
			 (length(trim(stringlib.stringfilter(rng+nme+sng,'0123456789')))=0 OR 
       length(trim(stringlib.stringfilterout(rng+nme+sng,'0123456789')))=0) AND nme = 'PO BOX' => 7,
       nme[1..4]='APT ' or nme[1..5] in ['UNIT ','BLDG '] => 3,
       0 );