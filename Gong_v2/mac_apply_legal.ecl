export Mac_Apply_Legal(in_f, out_f) := macro
import Gong_Neustar ;

#uniquename(infile)
#uniquename(out_suppress)
#uniquename(tsuppress)

%out_suppress% := Gong_Neustar.Prep_Build.applyGongNeustarSup(in_f) ;

#uniquename(inf_flt)
%inf_flt% := %out_suppress%(publish_code<>'N' or bell_id in ['BAN','LSI','LSP','QST','SWB','LSS']);

#uniquename(filtern)
typeof(in_f) %filtern%(%inf_flt% l) := transform
	self.phone10 := if(l.omit_phone='Y' or l.publish_code='N', '', l.phone10);
	self.prim_range := if(l.omit_locality='Y' or l.omit_address='Y','',l.prim_range);
	self.predir := if(l.omit_locality='Y' or l.omit_address='Y','',l.predir);
	self.prim_name := if(l.omit_locality='Y' or l.omit_address='Y','',l.prim_name);
	self.suffix := if(l.omit_locality='Y' or l.omit_address='Y','',l.suffix);
	self.postdir := if(l.omit_locality='Y' or l.omit_address='Y','',l.postdir);
	self.unit_desig := if(l.omit_locality='Y' or l.omit_address='Y','',l.unit_desig);
	self.sec_range := if(l.omit_locality='Y' or l.omit_address='Y','',l.sec_range);
	self.p_city_name := if(l.omit_locality='Y','',l.p_city_name);
	self.v_predir := if(l.omit_locality='Y' or l.omit_address='Y','',l.v_predir); 
	self.v_prim_name := if(l.omit_locality='Y' or l.omit_address='Y','',l.v_prim_name); 
	self.v_suffix := if(l.omit_locality='Y' or l.omit_address='Y','',l.v_suffix); 
	self.v_postdir := if(l.omit_locality='Y' or l.omit_address='Y','',l.v_postdir); 
	self.v_city_name := if(l.omit_locality='Y','',l.v_city_name);
	self.st := if(l.omit_locality='Y','',l.st);
	self.z5 := if(l.omit_locality='Y','',l.z5);
	self.z4 := if(l.omit_locality='Y' or l.omit_address='Y','',l.z4); 
	self.cart := if(l.omit_locality='Y' or l.omit_address='Y','',l.cart); 
	self.cr_sort_sz := if(l.omit_locality='Y' or l.omit_address='Y','',l.cr_sort_sz);
	self.lot := if(l.omit_locality='Y' or l.omit_address='Y','',l.lot);
	self.lot_order := if(l.omit_locality='Y' or l.omit_address='Y','',l.lot_order);
	self.dpbc := if(l.omit_locality='Y' or l.omit_address='Y','',l.dpbc); 
	self.chk_digit := if(l.omit_locality='Y' or l.omit_address='Y','',l.chk_digit);
	self.rec_type := if(l.omit_locality='Y','',l.rec_type);
	self.county_code := if(l.omit_locality='Y','',l.county_code);
	self.geo_lat := if(l.omit_address='Y','',l.geo_lat);  //keep lat for omit_locality
	self.geo_long := if(l.omit_address='Y','',l.geo_long); //keep long for omit_locality
	self.msa := if(l.omit_locality='Y','',l.msa);
	self.geo_blk := if(l.omit_locality='Y' or l.omit_address='Y','',l.geo_blk);
	self.geo_match := if(l.omit_locality='Y','',l.geo_match);
	self.err_stat := if(l.omit_locality='Y','',l.err_stat);
	self := l;
end;

out_f := project(%inf_flt%, %filtern%(left));

endmacro;