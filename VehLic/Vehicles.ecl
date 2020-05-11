import VehLic, business_header, business_header_ss, did_add, VehicleCodes;

veh_zero := Vehicles_Contacts_Undid;
veh_slim_rec := layout_slim_vehreg_v3;

//****** DID as before
matchset := ['A','D','S'];

did_Add.MAC_Match_Flex
	(veh_zero, matchset,						//see above
	 feid_ssn, dob, fname, mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, zip5, st, junk,
	 DID,
	 veh_slim_rec,
	 false, DID_Score_field,	//these should default to zero in definition
	 75,
	 outf1)		//try the dedup DIDing


outf1_psist := outf1 : persist('persist::vehlic_after_did');

business_header.MAC_Source_Match(outf1_psist,outf2,
							false,bdid,
							false,'MV',
							false,foo,
							company_name,
							prim_range,prim_name,sec_range,zip5,
							false,foo,
							false,foo);

o2_hasBDID := outf2(bdid != 0);
o2_noBDID := outf2(bdid = 0);
bmatch := ['A'];

business_header_ss.MAC_Match_Flex(o2_nobdid,bmatch,
						company_name,
						prim_range, prim_name, zip5,
						sec_range, st,
						foo,foo,
						bdid,
						veh_slim_rec,
						false,foo,
						outfile);

#if(VehLic.BuildType = VehLic.BuildType_Accurint)
  veh_matched := outfile(did > 0 or bdid > 0) + o2_hasBDID : persist('persist::vehreg_DID_before_ssn');
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
  veh_matched := outfile(did > 0 or bdid > 0) + o2_hasBDID : persist('persist::matrix_mv_did_before_ssn');
#end

veh_did := veh_matched(did > 0);

rVerySlimRecord
 :=
  record
    veh_did.rec_source;		//make this 'own_1'..'reg_2'
	veh_did.seq_no;
	veh_did.did;
	veh_did.ssn;
  end
 ;

rVerySlimRecord tSlimItDown(veh_slim_rec pInput)
 :=
  transform
	self := pInput;
  end
 ;

dVerySlim := project(veh_did,tSlimItDown(left));

//****** Get SSN from headers where we don't have it
//did_add.MAC_Add_SSN_By_DID(veh_did, did, ssn, veh_did_out)	//v0.2
did_add.MAC_Add_SSN_By_DID(dVerySlim, did, ssn, dVerySlimOut)	//v0.2

veh_slim_rec tPutItBack(veh_slim_rec pOrig, rVerySlimRecord pSlim)
 :=
  transform
	self.SSN	:= pSlim.SSN;
	self		:= pOrig;
  end
 ;

veh_did_out := join(veh_did,dVerySlimOut,
					 left.seq_no     = right.seq_no
				 and left.rec_source = right.rec_source,
					 tPutItBack(left,right)
					);


veh_did_bdid_out := veh_did_out + veh_matched(did = 0);


#if(VehLic.BuildType = VehLic.BuildType_Accurint)
  veh_contact_did_bdid := veh_did_bdid_out : persist('Persist::VehReg_Vehicles_Contacts');
#end
#if(VehLic.BuildType = VehLic.BuildType_Matrix)
  veh_contact_did_bdid := veh_did_bdid_out : persist('Persist::Matrix_MV_Vehicles_Contacts');
#end

//****** Put back to orig format
vehlic.layout_vehicles_bdid add_bdid_fields(vehlic.vehicles_undid L) := transform
	self.own_1_bdid := '';
	self.own_2_bdid := '';
	self.reg_1_bdid := '';
	self.reg_2_bdid := '';
	self := L;
end;

vund := project(vehlic.Vehicles_Undid, add_bdid_fields(LEFT));

vehlic.mac_Slim_to_V3(veh_contact_did_bdid, vund, veh_vin_out)					//v1.2

VehLic.Layout_Vehicles_bdid tSetupMatrixSearchFields(VehLic.Layout_Vehicles_bdid pInput)
 :=
  transform
	self.Best_Make_Code			:= if(pInput.NCIC_Make<>'',pInput.NCIC_Make,	pInput.MAKE_CODE);
	self.Best_Series_Code		:= if(pInput.VINA_Series<>'',pInput.VINA_Series,pInput.MODEL);
	self.Best_Model_Code		:= pInput.VINA_Model;  // we don't keep this separate from state
	self.Best_Body_Code			:= if(pInput.VINA_Body_Style<>'',pInput.VINA_Body_Style,pInput.BODY_CODE);
	self.Best_Model_Year		:= if(pInput.Model_Year<>'',pInput.Model_Year,pInput.Year_Make);
	self.Best_Major_Color_Code	:= VehicleCodes.StateColorToNCICColor(pInput.ORIG_STATE,pInput.MAJOR_COLOR_CODE);
	self.Best_Minor_Color_Code	:= VehicleCodes.StateColorToNCICColor(pInput.ORIG_STATE,pInput.MINOR_COLOR_CODE);
	self 						:= pInput;
  end
 ;

lMatrixSearchPatched := project(Veh_VIN_Out,tSetupMatrixSearchFields(left));

export Vehicles := lMatrixSearchPatched;
