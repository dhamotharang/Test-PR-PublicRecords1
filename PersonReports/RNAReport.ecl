IMPORT doxie, iesp, AutoStandardI,address,AddressReport_Services;

out_rec := iesp.rnareport.t_RNAReport;

EXPORT out_rec RNAReport (
  dataset (doxie.layout_references) dids,
  PersonReports.input._rnareport param,
  boolean IsFCRA = false) := FUNCTION

  mod_access := $.functions.GetDataAccessModulePersonReports (param);

  // DID should be atmost one (do we keep layout_references for legacyt reasons?)
  did := dids[1].did;
	
  // person records 
  pers := Person_records (dids, module (project (param, input.personal, opt)) end, IsFCRA);
	
  p_relatives  := choosen (pers.RelativesSlim, iesp.Constants.BR.MaxRelatives);
  // p_neighbors  := choosen (pers.neighbors_slim, iesp.constants.BR.MaxNeighborhood);
  p_associates := choosen (pers.AssociatesSlim, iesp.constants.BR.MaxAssociates);


  // Service spec: only neighbors at the neighborhood specified by input address should be returned, if any

  // translate required address components
  AI := AutoStandardI.InterfaceTranslator;
  clean_addr	:=ai.clean_address.val (project (param, AI.clean_address.params));
  split_addr:=Address.CleanFields(clean_addr);



  //************************************
  // Neighbor Records
  //************************************
			
	doxie.layout_nbr_targets into_srch() := transform
			self.prim_range 	:= split_addr.prim_range;
			self.predir     	:= split_addr.predir;
			self.prim_name	 	:= split_addr.prim_name;
			self.suffix 	 	:= split_addr.addr_suffix;
			self.postdir 	 	:= split_addr.postdir;
			self.sec_range  	:= split_addr.sec_range;
			self.zip		 	:= split_addr.zip;
			self				:=[];
		end;

		nbr_input:=dataset([into_srch()]);
		boolean glb_ok_val  := mod_access.isValidGLB();
		boolean dppa_ok_val := mod_access.isValidDPPA();
		
		Neighbors_recs_all:=doxie.nbr_records(
										nbr_input,
										'C',
										1,
										iesp.constants.BR.RNANbrProximityRadius,
										iesp.constants.BR.RNANbrProximityRadius,
										iesp.constants.BR.RNANbrProximityRadius,
										true,
										true,
										iesp.constants.BR.RNANbrProximityRadius,
                    ,
                    mod_access);
	
	p_neighbors := doxie.compliance.MAC_FilterOutMinors (Neighbors_recs_all, , dob, mod_access.show_minors);
	nbr_mod := 	module(project(AutoStandardI.GlobalModule(), AddressReport_Services.input._addressreport, opt))
								export glb_ok := glb_ok_val;
								export dppa_ok := dppa_ok_val;
							end;
	Neighbors_recs:=AddressReport_Services.transform_neighbors(p_neighbors,true,param.include_criminalindicators, nbr_mod);
	iesp.bpsreport.t_NeighborSlim SetNeighbors (Neighbors_recs l) := transform
	   
	  Self.NeighborAddresses := choosen(l.NeighborAddresses,param.neighbors_per_address);
	  self.SubjectAddress:=[]; // intentionally blanked.
	END;
	nbrs_selected:=project(Neighbors_recs,SetNeighbors(LEFT));
	
  // Combine all them together
  out_rec Format () := TRANSFORM
    Self.UniqueId := intformat (did, 12, 1);
    Self.Relatives   := IF (param.include_relatives,  GLOBAL (p_relatives));
    Self.Neighbors   := IF (param.include_neighbors,  GLOBAL (nbrs_selected));
    Self.Associates  := IF (param.include_associates, GLOBAL (p_associates));
  END;
	 
  // is supposed to produce one row only (usebestdid = true)
  return dataset ([Format ()]);
END;
