export f_QA_CleanAddress182(string server1,string server2):= function 

import lib_system; 

 
rRawAddress  :=

record

  string80   Line1;
  string60   LineLast;

end;

rACEStruct  :=
record
  string10   prim_range;
  string2    predir;
  string28   prim_name;
  string4    addr_suffix;
  string2    postdir;
  string10   unit_desig;
  string8    sec_range;
  string25   p_city_name;
  string25   v_city_name;
  string2    st;
  string5    zip5;
  string4    zip4;
  string4    cart;
  string1    cr_sort_sz;
  string4    lot;
  string1    lot_order;
  string2    dbpc;
  string1    chk_digit;
  string2    rec_type;
  string5    county;
  string10   geo_lat;
  string11   geo_long;
  string4    msa;
  string7    geo_blk;
  string1    geo_match;
  string4    err_stat;

end;

 

rRawCleanPairs  :=

record

  rRawAddress   Raw;
  rACEStruct    Clean;

end;

 

dRawCleanPairs := dataset('~thor::base::ace_cleaner_baseline_20110211',rRawCleanPairs,thor);

rRawAddress trecs(dRawCleanPairs l):= transform
self.line1:=l.raw.line1;
self.LineLast:= l.raw.LineLast;
end;

precs:= project(dRawCleanPairs,trecs(left));
// precs:= project(choosen(dRawCleanPairs,10000),trecs(left));


 
prodserver := precs;
dev_server := precs;

 

cleaned := record //File layout after address cleansing file 1

STRING182  prod_clean_address;
string1 err_stat;
data key;
string80   Line1;
string60   LineLast;
end;

 cleaned_old := record //File layout after address cleansing file 2

STRING182  dev_clean_address;
string1 err_stat_old;
data key;
string80   Line1;
string60   LineLast;
end;

cleaned_old clean_the_address_old (dev_server l) := transform //Address cleansing new server
self.dev_clean_address := AddrCleanLib.CleanAddress182(
  l.line1 , 
  l.linelast,server1,11000); 

  self.err_stat_old:=self.dev_clean_address[179..182];
  self.key:= hashmd5(l.line1,
           l.linelast);
	self.line1:=l.line1;
self.LineLast:= l.LineLast;	 
 end;

 
   
cleaned  clean_the_address(prodserver l) := transform //Address cleansing old cleaner
self.prod_clean_address :=  AddrCleanLib.CleanAddress182(
 
l.line1 ,
l.linelast,server2,11000); 
  
self.err_stat :=self.prod_clean_address[179..182];
self.key:= hashmd5(l.line1, 
           l.linelast);
					 	self.line1:=l.line1;
            self.LineLast:= l.LineLast;	 
end;
   
    
   
prod_cleanaddress := project(prodserver,clean_the_address(left)):persist('~thor400_72_dev::temp::qa_address_clean');; //File //output after cleansing
dev_cleanaddress := project(dev_server,clean_the_address_old(left)):persist('~thor400_72_dev::temp::qa_address_clean_prod');;
   
   

  
	 
   layout_stat := record
   
   prod_cleanaddress.err_stat;
   
   dev_cleanaddress.err_stat_old;
   
   total:=count(group);  
   
   end;
	 
	 address182_layout:= record
   string80   Line1;
   string60   LineLast;
   data key;
   address.Layout_Clean182;
   		end;
   		
			
    
 address182_layout tAddrClean(recordof(prod_cleanaddress) R):= transform
 self.line1           := R.Line1;
 self.LineLast        := R.linelast;
self.prim_range			 := R.prod_clean_address [1..10];
self.predir 				 := R.prod_clean_address [11..12];
self.prim_name  		 := R.prod_clean_address [13..40];
self.addr_suffix		 := R.prod_clean_address [41..44];
self.postdir         := R.prod_clean_address [45..46]; 
self.unit_desig 		 := R.prod_clean_address [47..56]; 
self.sec_range			 := R.prod_clean_address [57..64]; 	 
self.p_city_name     := R.prod_clean_address [65..89]; 	 
self.v_city_name     := R.prod_clean_address [90..114]; 
self.st              := R.prod_clean_address [115..116]; 
self.zip             := R.prod_clean_address [117..121];
self.zip4            := R.prod_clean_address [122..125];
self.cart            := R.prod_clean_address [126..129]; 
self.cr_sort_sz      := R.prod_clean_address [130];
self.lot             := R.prod_clean_address [131..134];
self.lot_order       := R.prod_clean_address [135];
self.dbpc            := R.prod_clean_address [136..137]; 
self.chk_digit       := R.prod_clean_address [138];
self.rec_type        := R.prod_clean_address [139..140];   
self.county          := R.prod_clean_address [141..145];
self.geo_lat         := R.prod_clean_address [146..155];
self.geo_long        := R.prod_clean_address [156..166];
self.msa             := R.prod_clean_address [167..170];
self.geo_blk         := R.prod_clean_address [171..177]; 
self.geo_match       := R.prod_clean_address [178];
self.err_stat        := R.prod_clean_address [179..182];  
 
self := R;

end;



address182_layout tAddrCleanOld(recordof(dev_cleanaddress) l) := transform
self.line1           := L.line1;
self.LineLast        := L.linelast;
self.prim_range			 := L.dev_clean_address [1..10];
self.predir 				 := L.dev_clean_address [11..12];
self.prim_name  		 := L.dev_clean_address [13..40];
self.addr_suffix		 := L.dev_clean_address [41..44];
self.postdir         := L.dev_clean_address [45..46]; 
self.unit_desig 		 := L.dev_clean_address [47..56]; 
self.sec_range			 := L.dev_clean_address [57..64]; 	 
self.p_city_name     := L.dev_clean_address [65..89]; 	 
self.v_city_name     := L.dev_clean_address [90..114]; 
self.st              := L.dev_clean_address [115..116]; 
self.zip             := L.dev_clean_address [117..121];
self.zip4            := L.dev_clean_address [122..125];
self.cart            := L.dev_clean_address [126..129]; 
self.cr_sort_sz      := L.dev_clean_address [130];
self.lot             := L.dev_clean_address [131..134];
self.lot_order       := L.dev_clean_address [135];
self.dbpc            := L.dev_clean_address [136..137]; 
self.chk_digit       := L.dev_clean_address [138];
self.rec_type        := L.dev_clean_address [139..140];   
self.county          := L.dev_clean_address [141..145];
self.geo_lat         := L.dev_clean_address [146..155];
self.geo_long        := L.dev_clean_address [156..166];
self.msa             := L.dev_clean_address [167..170];
self.geo_blk         := L.dev_clean_address [171..177]; 
self.geo_match       := L.dev_clean_address [178];
self.err_stat        := L.dev_clean_address [179..182];  
 
self := l;

end;


prFileProd := project(prod_cleanaddress , tAddrClean(left));
prFileDev := project(dev_cleanaddress , tAddrCleanOld(left));
//output(prFileProd);//Parse result
//output(prFileDev);//Parse result

Common_layout:= record
          string80        Line1;
          string60        LineLast;
					string10        prod_prim_range; 
         string10        prim_range; 	// [1..10]
				  string2         prod_predir;		// [11..12]
         string2         predir;		// [11..12]
				 string28        prod_prim_name;	// [13..40]
         string28        prim_name;	// [13..40]
				  string4        prod_addr_suffix;  // [41..44]
         string4         addr_suffix;  // [41..44]
				 string2         prod_postdir;		// [45..46]
         string2         postdir;		// [45..46]
				 string10        prod_unit_desig;	// [47..56]
         string10        unit_desig;	// [47..56]
				 string8         prod_sec_range;	// [57..64]
         string8         sec_range;	// [57..64]
				 string25        prod_p_city_name;	// [65..89]
         string25        p_city_name;	// [65..89]
				 string25        prod_v_city_name;  // [90..114]
         string25        v_city_name;  // [90..114]
				 string2         prod_st;			// [115..116]
         string2         st;			// [115..116]
				 string5         prod_zip;		// [117..121]
         string5         zip;		// [117..121]
				 string4         prod_zip4;		// [122..125]
         string4         zip4;		// [122..125]
				 string4         prod_cart;		// [126..129]
         string4         cart;		// [126..129]
				 string1         prod_cr_sort_sz;	// [130]
         string1         cr_sort_sz;	// [130]
				 string4         prod_lot;		// [131..134]
         string4         lot;		// [131..134]
				 string1         prod_lot_order;	// [135]
         string1         lot_order;	// [135]
				 string2         prod_dbpc;		// [136..137]
         string2         dbpc;		// [136..137]
				 string1         prod_chk_digit;	// [138]
         string1         chk_digit;	// [138]
				 string2         prod_rec_type;	// [139..140]
         string2         rec_type;	// [139..140]
				 string5         prod_county;		// [141..145]
         string5         county;		// [141..145]
				 string10        prod_geo_lat;		// [146..155]
         string10        geo_lat;		// [146..155]
				 string11        prod_geo_long;	// [156..166]
         string11        geo_long;	// [156..166]
				 string4         prod_msa;		// [167..170]
         string4         msa;		// [167..170]
				 string7         prod_geo_blk;		// [171..177]
         string7         geo_blk;		// [171..177]
				 string1         prod_geo_match;	// [178]
         string1         geo_match;	// [178]
				 string4         prod_err_stat;	// [179..182]
         string4         err_stat;	// [179..182]
   
         
         end;
				 
 
				  
   
Common_layout prodRecs(dev_cleanaddress L,prod_cleanaddress R):= transform  
self.Line1                 := R.Line1;
self.LineLast              := R.Linelast; 
self.prod_prim_range			 := R.prod_clean_address [1..10];
self.prod_predir 				   := R.prod_clean_address [11..12];
self.prod_prim_name  		   := R.prod_clean_address [13..40];
self.prod_addr_suffix		   := R.prod_clean_address [41..44];
self.prod_postdir          := R.prod_clean_address [45..46]; 
self.prod_unit_desig 		   := R.prod_clean_address [47..56]; 
self.prod_sec_range			   := R.prod_clean_address [57..64]; 	 
self.prod_p_city_name      := R.prod_clean_address [65..89]; 	 
self.prod_v_city_name      := R.prod_clean_address [90..114]; 
self.prod_st               := R.prod_clean_address [115..116]; 
self.prod_zip              := R.prod_clean_address [117..121];
self.prod_zip4             := R.prod_clean_address [122..125];
self.prod_cart            := R.prod_clean_address [126..129]; 
self.prod_cr_sort_sz      := R.prod_clean_address [130];
self.prod_lot             := R.prod_clean_address [131..134];
self.prod_lot_order       := R.prod_clean_address [135];
self.prod_dbpc            := R.prod_clean_address [136..137]; 
self.prod_chk_digit       := R.prod_clean_address [138];
self.prod_rec_type        := R.prod_clean_address [139..140];   
self.prod_county          := R.prod_clean_address [141..145];
self.prod_geo_lat         := R.prod_clean_address [146..155];
self.prod_geo_long        := R.prod_clean_address [156..166];
self.prod_msa             := R.prod_clean_address [167..170];
self.prod_geo_blk         := R.prod_clean_address [171..177]; 
self.prod_geo_match       := R.prod_clean_address [178];
self.prod_err_stat        := R.prod_clean_address [179..182];
   
    
self.prim_range			 := L.dev_clean_address [1..10];
self.predir 				 := L.dev_clean_address [11..12];
self.prim_name  		 := L.dev_clean_address [13..40];
self.addr_suffix		 := L.dev_clean_address [41..44];
self.postdir         := L.dev_clean_address [45..46]; 
self.unit_desig 		 := L.dev_clean_address [47..56]; 
self.sec_range			 := L.dev_clean_address [57..64]; 	 
self.p_city_name     := L.dev_clean_address [65..89]; 	 
self.v_city_name     := L.dev_clean_address [90..114]; 
self.st              := L.dev_clean_address [115..116]; 
self.zip             := L.dev_clean_address [117..121];
self.zip4            := L.dev_clean_address [122..125];
self.cart            := L.dev_clean_address [126..129]; 
self.cr_sort_sz      := L.dev_clean_address [130];
self.lot             := L.dev_clean_address [131..134];
self.lot_order       := L.dev_clean_address [135];
self.dbpc            := L.dev_clean_address [136..137]; 
self.chk_digit       := L.dev_clean_address [138];
self.rec_type        := L.dev_clean_address [139..140];   
self.county          := L.dev_clean_address [141..145];
self.geo_lat         := L.dev_clean_address [146..155];
self.geo_long        := L.dev_clean_address [156..166];
self.msa             := L.dev_clean_address [167..170];
self.geo_blk         := L.dev_clean_address [171..177]; 
self.geo_match       := L.dev_clean_address [178];
self.err_stat        := L.dev_clean_address [179..182];  
   
    
end;
	 
	 

	 
	 
 diffRecs := join(distribute(dev_cleanaddress ,hash(key)),distribute(prod_cleanaddress,hash(key)),
              left.key = right.key,
							prodRecs(left,right),
							 
							local);
 
 //output(diffRecs);
 
  
	layout_report:= record
	
	 diffRecs.st;
	 has_diff_prim_range	 := AVE(group,IF(diffRecs.prim_range!= diffRecs.prod_prim_range	,100,0));
	 has_diff_predir	 := AVE(group,IF(diffRecs.predir!= diffRecs.prod_predir	,100,0));
	 has_diff_prim_name	 := AVE(group,IF(diffRecs.prim_name!= diffRecs.prod_prim_name	,100,0));
	 has_diff_addr_suffix	 := AVE(group,IF(diffRecs.addr_suffix!= diffRecs.prod_addr_suffix	,100,0));
	 has_diff_postdir	 := AVE(group,IF(diffRecs.postdir!= diffRecs.prod_postdir	,100,0));
	 has_diff_unit_desig	 := AVE(group,IF(diffRecs.unit_desig!= diffRecs.prod_unit_desig	,100,0));
	 has_diff_sec_range	 := AVE(group,IF(diffRecs.sec_range!= diffRecs.prod_sec_range	,100,0));
	 has_diff_p_city_name	 := AVE(group,IF(diffRecs.p_city_name!= diffRecs.prod_p_city_name	,100,0));
	 has_diff_v_city_name	 := AVE(group,IF(diffRecs.v_city_name!= diffRecs.prod_v_city_name	,100,0));
	 has_diff_st	 := AVE(group,IF(diffRecs.st!= diffRecs.prod_st	,100,0));
	 has_diff_zip	 := AVE(group,IF(diffRecs.zip!= diffRecs.prod_zip	,100,0));
	 has_diff_zip4 	 := AVE(group,IF(diffRecs.zip4 != diffRecs.prod_zip4 	,100,0));
	 has_diff_cart 	 := AVE(group,IF(diffRecs.cart != diffRecs.prod_cart 	,100,0));
	 has_diff_cr_sort_sz  	 := AVE(group,IF(diffRecs.cr_sort_sz  != diffRecs.prod_cr_sort_sz  	,100,0));
	 has_diff_lot  	 := AVE(group,IF(diffRecs.lot  != diffRecs.prod_lot  	,100,0));
	 has_diff_lot_order  	 := AVE(group,IF(diffRecs.lot_order  != diffRecs.prod_lot_order  	,100,0));
	 has_diff_dbpc  	 := AVE(group,IF(diffRecs.dbpc  != diffRecs.prod_dbpc  	,100,0));
	 has_diff_chk_digit  	 := AVE(group,IF(diffRecs.chk_digit  != diffRecs.prod_chk_digit  	,100,0));
	 has_diff_rec_type  	 := AVE(group,IF(diffRecs.rec_type  != diffRecs.prod_rec_type  	,100,0));
	 has_diff_county  	 := AVE(group,IF(diffRecs.county  != diffRecs.prod_county  	,100,0));
	 has_diff_geo_lat  	 := AVE(group,IF(diffRecs.geo_lat  != diffRecs.prod_geo_lat  	,100,0));
	 has_diff_geo_long  	 := AVE(group,IF(diffRecs.geo_long  != diffRecs.prod_geo_long  	,100,0));
	 has_diff_msa  	 := AVE(group,IF(diffRecs.msa  != diffRecs.prod_msa  	,100,0));
	 has_diff_geo_blk   	 := AVE(group,IF(diffRecs.geo_blk   != diffRecs.prod_geo_blk   	,100,0));
	 has_diff_geo_match  	 := AVE(group,IF(diffRecs.geo_match  != diffRecs.prod_geo_match  	,100,0));
	 has_diff_err_stat  	 := AVE(group,IF(diffRecs.err_stat  != diffRecs.prod_err_stat  	,100,0));
	  
	 end;
	 
 

 
 
 // group Report//
 
 
 outfile := diffRecs;
 
 
 
	//prim_range diff//
	
dprim_range := outfile(prod_prim_range != prim_range);

ct_dprim_range:= count(dprim_range);

dprim_range_layout := record
dprim_range.st;
total := count(group)/ct_dprim_range*100;
end;

 
// predir diff//

dpredir := outfile(prod_predir != predir);


ct_dpredir:=count(dpredir);

dpredir_layout := record
dpredir.st;
total := count(group)/ct_dpredir*100;
end;

// prim_name diff//

dprim_name := outfile(prod_prim_name != prim_name);

ct_dprim_name:=count(dprim_name);

dprim_name_layout := record
dprim_name.st;
total := count(group)/ct_dprim_name*100;
end;

 
// addr_suffix diff //		 

daddr_suffix := outfile(prod_addr_suffix != addr_suffix);

ct_daddr_suffix:= count(daddr_suffix);

daddr_suffix_layout := record
daddr_suffix.st;
total := count(group)/ct_daddr_suffix*100;
end;

// postdir diff //

dpostdir := outfile(prod_postdir != postdir);

ct_dpostdir:= count(dpostdir);

dpostdir_layout := record
dpostdir.st;
total := count(group)/ct_dpostdir*100;
end;

 // unit_desig diff //
 
dunit_desig := outfile(prod_unit_desig != unit_desig);

ct_dunit_desig:= count(dunit_desig);

dunit_desig_layout := record
dunit_desig.st;
total := count(group)/ct_dunit_desig*100;
end;
 

// sec_range diff //
dsec_range := outfile(prod_sec_range != sec_range);

ct_dsec_range:=count(dsec_range);

dsec_range_layout := record
dsec_range.st;
total := count(group)/ct_dsec_range*100;
end;

 
// p_city_name diff //		 
dp_city_name := outfile(prod_p_city_name != p_city_name);

ct_dp_city_name:= count(dp_city_name);

dp_city_name_layout := record
dp_city_name.st;
total := count(group)/ct_dp_city_name*100;
end;

// v_city_name diff //

dv_city_name := outfile(prod_v_city_name != v_city_name);

ct_dv_city_name:= count(dv_city_name);

dv_city_name_layout := record
dv_city_name.st;
total := count(group)/ct_dv_city_name*100;
end;

 
// st diff //		 
		 
dst := outfile(prod_st != st);

ct_dst:= count(dst);

dst_layout := record
dst.st;
total := count(group)/ct_dst*100;
end;

 
// zip diff //
		 
dzip := outfile(prod_zip  != zip );

ct_dzip:= count(dzip);

dzip_layout := record
dzip.st;
total := count(group)/ct_dzip*100;
end;

 
// zip5 diff //

 dzip5 := outfile(prod_zip != zip);
   
   ct_dzip5:=count(dzip5);
   
   dzip5_layout := record
   dzip5.st;
	 dzip5.err_stat;
   total := count(group)/ct_dzip5*100;
   end;
   
  


// zip4 diff //

dzip4 := outfile(prod_zip4 != zip4);

ct_dzip4:=count(dzip4);

dzip4_layout := record
dzip4.st;
total := count(group)/ct_dzip4*100;
end;

 
// cart diff //

dcart := outfile(prod_cart != cart);

ct_dcart:=count(dcart);

dcart_layout := record
dcart.st;
total := count(group)/ct_dcart*100;
end;

 

// cr_sort_sz diff //

dcr_sort_sz := outfile(prod_cr_sort_sz != cr_sort_sz);

ct_dcr_sort_sz:= count(dcr_sort_sz);

dcr_sort_sz_layout := record
dcr_sort_sz.st;
total := count(group)/ct_dcr_sort_sz*100;
end;

 
		 
//lot diff //

dlot := outfile(prod_lot != lot);

ct_dlot:= count(dlot);

dlot_layout := record
dlot.st;
total := count(group)/ct_dlot*100;
end;

 
		 
// lot_order diff //	 
dlot_order := outfile(prod_lot_order != lot_order);

ct_dlot_order:=count(dlot_order);

dlot_order_layout := record
dlot_order.st;
total := count(group)/ct_dlot_order*100;
end;
 
// dbpc diff //		 
		 
ddbpc := outfile(prod_dbpc != dbpc);

ct_ddbpc:= count(ddbpc);

ddbpc_layout := record
ddbpc.st;
total := count(group);
end;

 
		 
//chk_digit diff //
		 
dchk_digit := outfile(prod_chk_digit != chk_digit);

ct_dchk_digit:= count(dchk_digit);

dchk_digit_layout := record
dchk_digit.st;
total := count(group)/ct_dchk_digit*100;
end;

 
// rec_type diff //
		 
drec_type := outfile(prod_rec_type != rec_type);

ct_drec_type:= count(drec_type);

drec_type_layout := record
drec_type.st;
total := count(group)/ct_drec_type*100;
end;
 

		 
// county diff //
		 
dcounty := outfile(prod_county != county);

ct_dcounty:= count(dcounty);

dcounty_layout := record
dcounty.st;
total := count(group)/ct_dcounty*100;
end;

 

//geo_lat diff //

dgeo_lat := outfile(prod_geo_lat != geo_lat);

ct_dgeo_lat:= count(dgeo_lat);

dgeo_lat_layout := record
dgeo_lat.st;
total := count(group)/ct_dgeo_lat*100;
end;

 
		 
// geo_long diff //
		 
dgeo_long := outfile(prod_geo_long != geo_long);

ct_dgeo_long:= count(dgeo_long);

dgeo_long_layout := record
dgeo_long.st;
total := count(group)/ct_dgeo_long*100;
end;

 
		 
// msa diff //	 

dmsa := outfile(prod_msa != msa);

ct_dmsa:= count(dmsa);

dmsa_layout := record
dmsa.st;
total := count(group)/ct_dmsa*100;
end;

 
		 
// geo_match diff //
		 
dgeo_match := outfile(prod_geo_match != geo_match);

ct_dgeo_match:= count(dgeo_match);

dgeo_match_layout := record
dgeo_match.st;
total := count(group)/ct_dgeo_match*100;
end;

 
		 
// err_stat diff //
 
derr_stat := outfile(prod_err_stat != err_stat);

ct_err_stat:=count(derr_stat);

 
derr_stat_layout := record
derr_stat.st;
derr_stat.err_stat  ;
total := count(group);
perct := count(group)/ct_err_stat*100;
end;



 return sequential(
 output (dev_cleanaddress,named('dev_cleanaddress') )
 ,output (prod_cleanaddress, named('prod_cleanaddress'))
 ,output(prFileProd, named('parsed_prod_cleanaddress')) 
,output(prFileDev,named('parsed_dev_cleanaddress') ) 
 ,output(diffRecs , named ('Prod_Dev_Compare'))
  ,output(sort(table(diffRecs,layout_report,st,few),st), named('Total_Percentage_Report_of_changes'))
 ,output(sort(table(dprim_range,dprim_range_layout,st,few),st),all,named('prim_range'))
 ,output(dprim_range, named('sample_Prim_range'))

 ,output(sort(table(dpredir,dpredir_layout,st,few),st),all,named('predir'))
 ,output(dpredir,named('sample_predir'))
 
 ,output(sort(table(dprim_name,dprim_name_layout,st,few),st),all,named('prim_name'))

,output(dprim_name,named('sample_prim_name'))

,output(sort(table(daddr_suffix,daddr_suffix_layout,st,few),st),all,named('addr_suffix'))

,output(daddr_suffix,named('sample_addr_suffix'))

,output(sort(table(dpostdir,dpostdir_layout,st,few),st),all,named('postdir'))

,output(dpostdir,named('sample_postdir'))

,output(sort(table(dunit_desig,dunit_desig_layout,st,few),st),all,named('unit_desig'))

,output(dunit_desig,named('sample_unit_desig'))

,output(sort(table(dsec_range,dsec_range_layout,st,few),st),all,named('sec_range'))

,output(dsec_range,named('sample_sec_range'))

,output(sort(table(dp_city_name,dp_city_name_layout,st,few),st),all,named('p_city_name'))

,output(dp_city_name,named('sample_p_city_name'))

,output(sort(table(dv_city_name,dv_city_name_layout,st,few),st),all,named('v_city_name'))

,output(dv_city_name,named('sample_v_city_name'))

,output(sort(table(dst,dst_layout,st,few),st),all,named('st'))

,output(dst,named('sample_st'))

,output(sort(table(dzip,dzip_layout,st,few),st),all,named('zip'))

,output(dzip,named('sample_zip'))
 
,output(sort(table(dzip4,dzip4_layout,st,few),st),all,named('zip4'))

,output(dzip4,named('sample_zip4'))

,output(sort(table(dcart,dcart_layout,st,few),st),all,named('cart'))

,output(dcart,named('sample_cart'))
,output(sort(table(dcr_sort_sz,dcr_sort_sz_layout,st,few),st),all,named('cr_sort_sz'))

,output(dcr_sort_sz ,named('sample_cr_sort_sz'))

,output(sort(table(dlot,dlot_layout,st,few),st),all,named('lot'))

,output(dlot,named('sample_lot'))

,output(sort(table(dlot_order,dlot_order_layout,st,few),st),all,named('lot_order'))

,output(dlot_order,named('sample_lot_order'))

,output(sort(table(ddbpc,ddbpc_layout,st,few),st),all,named('dbpc'))

,output(ddbpc,named('sample_dbpc'))

,output(sort(table(dchk_digit,dchk_digit_layout,st,few),st),all,named('chk_digit'))

,output(dchk_digit,named('sample_chk_digit'))

,output(sort(table(drec_type,drec_type_layout,st,few),st),all,named('rec_type'))

,output(drec_type,named('sample_rec_type'))

,output(sort(table(dcounty,dcounty_layout,st,few),st),all,named('county'))

,output(dcounty,named('sample_county'))

,output(sort(table(dgeo_lat,dgeo_lat_layout,st,few),st),all,named('geo_lat'))
 ,output(dgeo_lat,named('sample_geo_lat'))
 
 ,output(sort(table(dgeo_long,dgeo_long_layout,st,few),st),all,named('geo_long'))

 ,output(dgeo_long,named('sample_geo_long'))
 
 
,output(sort(table(dmsa,dmsa_layout,st,few),st),all,named('msa'))

 ,output(dmsa,named('sample_msa'))

 
 ,output(sort(table(dgeo_match,dgeo_match_layout,st,few),st),all,named('geo_match'))

 ,output(dgeo_match,named('sample_geo_match'))
 
 

,output(sort(table(derr_stat,derr_stat_layout,st,err_stat,few),st,err_stat),all,named ('err_stat'))
 
,output(derr_stat,named('sample_err_stat'))

 );
 
 end;
 
 