
hhid_distributed_on_lname_addrid := distribute(first_data.Redefine_HHID(trim(lname)<>''),hash(lname,addr_id));//Gets other DID's at the same address

first_data.layout_fatrec t_get_additional_members(first_data.layout_fatrec l, first_data.Layout_Redefine_HHID r) := transform
 
 boolean has_right_rec := if(r.did<>0,true,false);
 
 self.did                 := if(has_right_rec,r.did,0);
 self.lname               := if(has_right_rec,r.lname,'');
 self.infutor_or_mktg_ind := '2';
 
 self.prim_range          := l.prim_range;
 self.predir              := l.predir;
 self.prim_name           := l.prim_name;
 self.addr_suffix         := l.addr_suffix;
 self.postdir             := l.postdir;
 self.unit_desig          := l.unit_desig;
 self.sec_range           := l.sec_range;
 self.p_city_name         := l.p_city_name;
 self.v_city_name         := l.v_city_name;
 self.st                  := l.st;
 self.zip                 := l.zip;
 self.zip4                := l.zip4;
 self.cart                := l.cart;
 self.cr_sort_sz          := l.cr_sort_sz;
 self.lot                 := l.lot;
 self.lot_order           := l.lot_order;
 self.dbpc                := l.dbpc;
 self.chk_digit           := l.chk_digit;
 self.rec_type            := l.rec_type;
 self.county              := l.county;
 self.geo_lat             := l.geo_lat;
 self.geo_long            := l.geo_long;
 self.msa                 := l.msa;
 self.geo_blk             := l.geo_blk;
 self.geo_match           := l.geo_match;
 self.err_stat            := l.err_stat;
 
 self.addr_id             := r.addr_id;
 
 self                     := [];
end;

//Note that this join likely pulled in people that are already in the Infutor data
//They get discarded in Append_Mktg_Best_To_Additional_Members
export Get_Additional_Members := join(first_data.Append_Mktg_Best_To_Infutor,hhid_distributed_on_lname_addrid,
                                      (left.mktg_lname=right.lname and left.addr_id=right.addr_id),
					                  t_get_additional_members(left,right),
						              left outer, local
						             );