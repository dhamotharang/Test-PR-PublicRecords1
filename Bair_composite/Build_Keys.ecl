import doxie, VersionControl,Bair_ExternalLinkKeys, Bair_ExternalLinkKeys_V2;

export Build_Keys := module

	export Build_Keys_mo_phone(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := module

				VersionControl.macBuildNewLogicalKey(bair_composite.Keys(pversion,pUseProd,pUseDelta).mo_phone.New, BuildMoPhone,true);
																			  
				shared full_build :=
					sequential(
						BuildMoPhone,
						bair_composite.Promote.Promote_Mo_Phone(pversion,pUseProd,pUseDelta).buildfiles.New2Built,
						bair_composite.Promote.Promote_Mo_Phone(pversion,pUseProd,pUseDelta).buildfiles.Built2QA
						
					);
		
				export mo_phone_key := full_build;
	end;
	
	export Build_Keys_mo_v2_phone(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := module

				VersionControl.macBuildNewLogicalKey(bair_composite.Keys(pversion,pUseProd,pUseDelta).mo_v2_phone.New, BuildMoPhone,true);
																			  
				shared full_build :=
					sequential(
						BuildMoPhone,
						bair_composite.Promote.Promote_Mo_v2_Phone(pversion,pUseProd,pUseDelta).buildfiles.New2Built,
						bair_composite.Promote.Promote_Mo_v2_Phone(pversion,pUseProd,pUseDelta).buildfiles.Built2QA
						
					);
		
				export mo_phone_v2_key := full_build;
	end;
	
	export Build_Keys_mo_eid(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := module

				VersionControl.macBuildNewLogicalKey(bair_composite.Keys(pversion,pUseProd,pUseDelta).mo_eid.New, BuildMoEid,true);
																			  
				shared full_build :=
					sequential(
						BuildMoEid,
						bair_composite.Promote.Promote_Mo_Eid(pversion,pUseProd,pUseDelta).buildfiles.New2Built,
						bair_composite.Promote.Promote_Mo_Eid(pversion,pUseProd,pUseDelta).buildfiles.Built2QA
					);
		
				export mo_eid_key := full_build;
	end;
	
	export Build_Keys_mo_v2_eid(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := module

				VersionControl.macBuildNewLogicalKey(bair_composite.Keys(pversion,pUseProd,pUseDelta).mo_v2_eid.New, BuildMoEid,true);
																			  
				shared full_build :=
					sequential(
						BuildMoEid,
						bair_composite.Promote.Promote_Mo_v2_Eid(pversion,pUseProd,pUseDelta).buildfiles.New2Built,
						bair_composite.Promote.Promote_Mo_v2_Eid(pversion,pUseProd,pUseDelta).buildfiles.Built2QA
					);
		
				export mo_eid_v2_key := full_build;
	end;
	
	export Build_keys_ext(string pversion, boolean pUseDelta = false) := Module
	
		export Bair_Ext_keys := Bair_ExternalLinkKeys.Proc_GoExternal(pversion,pUseDelta).Proc_GoExternal1;
	
	end;
	
	export Build_keys_ext_v2(string pversion, boolean pUseDelta = false) := Module
	
		export Bair_Ext_keys_v2 := Bair_ExternalLinkKeys_V2.Proc_GoExternal(pversion,pUseDelta).Proc_GoExternal1;
		
	end;
	
	export Build_keys_wdbody(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := Module
				
				VersionControl.macBuildNewLogicalKey(bair_composite.keys(pversion,pUseProd,pUseDelta).wd_body.New, Buildwdbody,true);
																			  
				shared full_build :=
					sequential(
						Buildwdbody,
						bair_composite.Promote.Promote_Wd_Body(pversion,pUseProd,pUseDelta).buildfiles.New2Built,
						bair_composite.Promote.Promote_Wd_Body(pversion,pUseProd,pUseDelta).buildfiles.Built2QA
						
					);
		
				export wd_body_key := full_build;
		
	end;
	
	export Build_keys_wdmake(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := Module
				
				VersionControl.macBuildNewLogicalKey(bair_composite.keys(pversion,pUseProd,pUseDelta).wd_make.New, Buildwdmake,true);
																			  
				shared full_build :=
					sequential(
						Buildwdmake,
						bair_composite.Promote.Promote_Wd_make(pversion,pUseProd,pUseDelta).buildfiles.New2Built,
						bair_composite.Promote.Promote_Wd_make(pversion,pUseProd,pUseDelta).buildfiles.Built2QA
						
					);
		
				export wd_make_key := full_build;
		
	end;
	
	export Build_keys_wdmodel(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := Module
				
				VersionControl.macBuildNewLogicalKey(bair_composite.keys(pversion,pUseProd,pUseDelta).wd_model.New, Buildwdmodel,true);
																			  
				shared full_build :=
					sequential(
						Buildwdmodel,
						bair_composite.Promote.Promote_Wd_model(pversion,pUseProd,pUseDelta).buildfiles.New2Built,
						bair_composite.Promote.Promote_Wd_model(pversion,pUseProd,pUseDelta).buildfiles.Built2QA
						
					);
		
				export wd_model_key := full_build;
		
	end;
	
	export Build_keys_wdveh(string pversion, boolean pUseProd = false, boolean pUseDelta = false) := Module
				
				VersionControl.macBuildNewLogicalKey(bair_composite.keys(pversion,pUseProd,pUseDelta).wd_veh.New, Buildwdveh,true);
																			  
				shared full_build :=
					sequential(
						Buildwdveh,
						bair_composite.Promote.Promote_Wd_Veh(pversion,pUseProd,pUseDelta).buildfiles.New2Built,
						bair_composite.Promote.Promote_Wd_Veh(pversion,pUseProd,pUseDelta).buildfiles.Built2QA
						
					);
		
				export wd_veh_key := full_build;
		
	end;
	
end;