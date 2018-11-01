import idl_header,address,InsuranceHeader_PostProcess;

shared sourceTools := idl_header.SourceTools;

hdr := dataset('~thor_data400::base::insuranceheader::idl_salt_iter_w20140327-135027_best',idl_header.Layout_Header_address,thor);

dist1 := distribute(hdr,hash(did));												

//Project into slim layout with counts
p1 := project(dist1,
              transform(InsuranceHeader_PostProcess.layouts.layout_did_rid_srcd,
							          self.source_cnt          := 1;
							          self.ins_source_cnt      := IF(sourceTools.SourceIsIns(left.src),1,0);
							          self := left,
												self := [],
												self := []));										
												
//Dedup into individual sources
s1 := sort(p1,did,addr_ind,src,local);
d1 := dedup(s1,left.did = right.did and left.addr_ind = right.addr_ind and left.src = right.src and left.addr_ind<>'',local);
														
//Count total and insurance sources
r1 := rollup(d1,
				   left.did = right.did AND left.addr_ind = right.addr_ind,
           transform(InsuranceHeader_PostProcess.layouts.layout_did_rid_srcd,
           self.source_cnt          := left.source_cnt + right.source_cnt,											               
           self.ins_source_cnt      := left.ins_source_cnt + right.ins_source_cnt,			
					 self := left,
					 self := []),local);
					 
//Update count fields and remove insurance records
j1 := JOIN(dist1(sourceTools.SourceIsPublicHeader(src)),r1,
				   left.did = right.did AND left.addr_ind = right.addr_ind,
           transform(InsuranceHeader_PostProcess.layout_did_rid,
           self.source_cnt          := IF(left.addr_ind='',0,right.source_cnt),	
					 self.ins_source_cnt      := IF(left.addr_ind='',0,right.ins_source_cnt),	
					 self := left,
					 self := []),left outer,local);
					 
//Remove insurance sources and blank address indicators
f1 := dist1(sourceTools.SourceIsPublicHeader(src) AND addr_ind<>'');

//Get best addresses
idl_Header.mac_best_address_v1(f1, did, 30, best);
d2 := dedup(sort(best,did,rid,rec_type,-dt_last_seen,dt_first_seen,-dt_vendor_last_reported,local),did,rid,rec_type,local);

//Update Best Addr Indicator
export CreateDIDRIDFile := join(j1,d2,
               left.did = right.did and
							 left.rid = right.rid,
							 transform(InsuranceHeader_PostProcess.layout_did_rid,
							           self.best_addr_ind := IF(left.rid = right.rid,'B','');
												 self := left),
												 left outer,local);
												 
output(CreateDIDRIDFile,,'~thor::address_link::best::didrid::' + workunit,overwrite);	
