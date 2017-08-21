IMPORT Business_Header, ut;

lisDataland := _Dataset().IsDataland;

export BH_BDL2(

	 dataset(Business_Header.Layout_BDL2) pBDL2 		= Business_Header.Files(,lisDataland).Base.BDL2.QA
	,dataset(Layout_Business_Header_Base) pBH 			= Business_Header.Files(,lisDataland).Base.business_headers.Built
	,dataset(Layout_BH_Super_Group)				pSG 			= Business_Header.Files(,lisDataland).Base.super_group.Built
	,boolean															firstRun	= false

) :=
function
    
		// *** Business Header Super Group Base file *****
		dist_SG := distribute(pSG, hash(bdid));
		
		// *** If firstRun, then create an input BDL2 file from scratch using the
		// the business header base and Super group base files.
		// Note :- firstRun - is set only in case if ever have to run the BDL2 process from scratch.
		// So default is always false.
		// *** Business Header Base file *****
		dist_bh := distribute(pBH, hash(bdid));

		Layout_BH_GID := record
			 business_header.Layout_BH_Super_Group.group_id;
			 recordof(pBH);
		end;

		//**** Joining the Business header base and BH super group files to get the group_id for the BH base.
		//**** Transform to join the BH and BH super group files using there BDID.
		Layout_BH_GID buildBHG(dist_bh L, dist_SG R) :=transform
			self.group_id := R.group_id;
			self := L;
			self := [];
		End;

		ds_BHG := join(dist_bh, dist_SG, left.bdid = right.bdid, buildBHG(left, right), local);

		//*** Initializing the BDL with BDID, and transforming the records to BDL layout form.
		Layout_BDL2 trfBH_Base(Layout_BH_GID l) := transform
				self.bdl  := l.bdid; 
				self      := l;
				self      := [];
		end;

		pBH_BDL := project(ds_BHG, trfBH_Base(left));
		//***************  End - Building the new input file for BDL2 Process ********
		
		//***********************************************
		// Join the Group_ID to the previous month's BDL file by BDID.
		dist_BDL2 := distribute(pBDL2, hash(bdid));
		
		Layout_BDL2_ext := record
		   Layout_BDL2;
			 unsigned6 new_bdl;
		end;
		
	  Layout_BDL2_ext getGIDs(Layout_BDL2 l, dist_SG r) := transform
		    self.group_id := r.group_id;
				self.new_bdl  := l.bdl;
				self := l;
		end;
		
		BDL_w_corrected_gids := join(dist_BDL2, dist_SG, left.bdid = right.bdid, getGIDs(left,right), local);
		
		// Account for any possible Group_ID movement by reassigning BDLs to equal the lowest BDID in a
		// Group_Id - BDL group.
		dBDL_w_corrected_gids := distribute(BDL_w_corrected_gids, hash(group_id, bdl, bdid));
		srt_dBDL_w_corrected_gids := sort(dBDL_w_corrected_gids, group_id, bdl, bdid, local);
		
		Layout_BDL2_ext trfIter(Layout_BDL2_ext l, Layout_BDL2_ext r) := transform
		   self.new_bdl := if(l.group_id = r.group_id and l.bdl = r.bdl 
		                      ,l.new_bdl, r.bdid 
									       );
		   self         := r;
		end;
		 
		reassigned_bdls := iterate(srt_dBDL_w_corrected_gids, trfIter(left,right));
		
		Layout_BDL2 dropOldBDL(Layout_BDL2_ext l) := transform
		    self.bdl := l.new_bdl;
				self     := l;
		end;
		
		patched_BDL 				:= project(reassigned_bdls, dropOldBDL(left));
		
		//*** Distributing, sort and deduping the patched_BDL file on BDID to keep the unique BDID's 
		d_patched_BDL				:= distribute(patched_BDL, hash(bdid));

		d_ded_patched_BDL		:= dedup(sort(d_patched_BDL, bdid, local), bdid, local);
		
		//*** Joining the new BH_super group file with the previous groupid patched BDL base file to retain the
		//*** old BDL's
		Layout_BDL2 getBDLs(pBH_BDL l, d_ded_patched_BDL r) := transform
		   self.BDL := if(r.BDL <> 0, r.BDL, l.BDL);
			 self     := l;
		end;
		
		Out_BDL := join(pBH_BDL, d_ded_patched_BDL, left.bdid = right.bdid, getBDLs(left,right),left outer, local) : persist(_dataset().thor_cluster_persists +'persist::Business_header::BDL2_Input');
		
		//***********************************************
   
		return if (firstRun, pBH_BDL, Out_BDL);
end;