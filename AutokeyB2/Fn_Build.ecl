/*
see documentation on gforge->ecl->docs->autokeys
https://gforge.seisint.com/docman/?group_id=21#
*/

import autokeyi,autokey,business_header;

export Fn_Build := 
MODULE

	export params := AutoKeyI.InterfaceForBuild;	//including the L_ivisitor interfaces here is currently unsported (nested interfaces)


	//***** SOME PREP WORK ON THE INCOMING DATASET

	shared Prep(params in_mod) :=
	MODULE

		//***** SEE IF WE NEED TO USE FAKE IDS
		recordof(in_mod.L_indata) fixDID(in_mod.L_indata l) := transform
			self.inp.DID  := l.FakeID;
			self.inp.BDID := l.FakeID;
			self := l;
		end;

		export WithFakeID := 
		if(
			in_mod.L_useFakeIDs and in_mod.L_useOnlyRecordIDs,
			PROJECT(in_mod.L_indata, fixDID(left)), 
			in_mod.L_indata
		);
		
		shared needsaddcontactaddr := 
			(WithFakeID.inp.bprim_name <> '' and WithFakeID.inp.bprim_name <> WithFakeID.inp.prim_name);

		//****** CREATE ADDITIONAL PERSON ADDRESSES FROM COMPANY ADDRESS ******
		shared recordof(in_mod.L_indata) addcontactaddr(WithFakeID l) := transform
			self.inp.prim_name := l.inp.bprim_name;
			self.inp.prim_range := l.inp.bprim_range;
			self.inp.st := l.inp.bst;
			self.inp.city_name := l.inp.bcity_name;
			self.inp.zip := l.inp.bzip;
			self.inp.sec_range := l.inp.bsec_range;
			self := l;
		end;

		export withaddcontactaddr := 
		if(in_mod.L_skipaddrnorm,WithFakeID,
			WithFakeID + 
			project(WithFakeID(needsaddcontactaddr), addcontactaddr(left)));
	
	END;


	//***** BUILD THE PERSON MODULE

	shared makePmod(params in_mod) :=
	FUNCTION
	
		indataset := in_mod.L_indata;
		wtihFakeID := Prep(in_mod).WithFakeID;
		withaddcontactaddr := Prep(in_mod).withaddcontactaddr;


		//****** ADD ADDITIONAL CITY ACCORDING TO THE ZIP CODE, IF ANY ******
		autokey.MAC_Add_Cities (withaddcontactaddr, inp.zip, inp.city_name, /*p.city_code,*/ withcities); 
		withcities_if := 
		if(
			in_mod.L_AddCities
			AND NOT in_mod.L_skipB2behavior, 
			withcities, 
			withaddcontactaddr
		);


		//***** NORMALIZE COMPOUND NAMES 
		autokeyB2.MAC_NormalizeCompoundNames(withcities_if, withcompoundnames, inp.lname);
		withcompoundnames_if := 
		if(
			in_mod.L_processCompoundNames,
			withcompoundnames,
			withcities_if
		);

		//****** BUILD AND MOVE THE PERSON KEYS ******
		return module(project(in_mod, AutoKeyI.InterfaceForBuild))
			export dataset(autokey.layouts.master) L_indata := 
				AutoKey.fn_DeriveFields(
					withcompoundnames_if,
					in_mod.L_UseNewPreferredFirst,
					in_mod.L_useLiteralLookupsValue
				);
		end;	
		
	END;
	

	//***** BUILD THE BUSINESS MODULE
	
	shared makeBmod(params in_mod) :=
	FUNCTION
	
		wtihFakeID := Prep(in_mod).WithFakeID;
		withaddcontactaddr_if := 
		if(
			in_mod.L_skipB2behavior,
			Prep(in_mod).withaddcontactaddr,
			wtihFakeID
		);
		
			// ======= ADD ADDITIONAL CITY FOR BUSINESS ACCORDING TO THE ZIP CODE, IF ANY ========
		autokey.MAC_Add_Cities (withaddcontactaddr_if, inp.bzip, inp.bcity_name, /*b.city_code,*/ withcities);
		withcities_if := 
		if(
			in_mod.L_AddCities
			AND NOT in_mod.L_skipB2behavior, 
			withcities, 
			withaddcontactaddr_if
		);
		
		withcities_if split_company_names(withcities_if l, integer C) := transform
			name := choose(C,l.inp.bname, l.inp.bname[5..length(l.inp.bname)]);
			SELF.inp.bname := name;
			// SELF.b.cname_indic := business_header.CompanyCleanFields(name, true).indicative; 
			// SELF.b.cname_sec := business_header.CompanyCleanFields(name, true).secondary;	
			SELF := l;
		END;		
		
		normalizecompanynameswith_the := normalize(withcities_if,if(left.inp.bname[1..4]='THE ',2,1),split_company_names(left,counter));


		//****** BUILD AND MOVE THE BUSINESS KEYS ******
		return module(project(in_mod, AutoKeyI.InterfaceForBuild))
			export dataset(autokey.layouts.master) L_indata := 
				AutoKey.fn_DeriveFields(
					normalizecompanynameswith_the,
					in_mod.L_UseNewPreferredFirst,
					in_mod.L_useLiteralLookupsValue
				);
		end;	

	END;
	
	export _Build(
		params in_mod, 
		AutoKeyI.BuildI_Indv.IBuild L_ivisitor = AutoKeyI.BuildI_Indv.DoBuild,
		AutoKeyI.BuildI_Biz.IBuild L_ivisitorb = AutoKeyI.BuildI_Biz.DoBuild) :=
	FUNCTION
		pmod := makePmod(in_mod);
		bmod := MakeBmod(in_mod);
		
		dopkeys := parallel(parallel(
			if('A' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_Address_keybuild(pmod)),
			if('I' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_CityStName_keybuild(pmod)),
			if('N' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_Name_keybuild(pmod)),
			L_ivisitor.BuildI_Indv_Custom1_keybuild(pmod),
			L_ivisitor.BuildI_Indv_Custom2_keybuild(pmod),
			L_ivisitor.BuildI_Indv_Custom3_keybuild(pmod),
			L_ivisitor.BuildI_Indv_Custom4_keybuild(pmod),
			L_ivisitor.BuildI_Indv_Custom5_keybuild(pmod)),
			sequential(//this sequential is a workaround for bug 35317
			if(
				'P' in in_mod.L_build_skip_set, 
				output('AUTOKEY BUILD: Phone key skipped'),
				L_ivisitor.BuildI_Indv_Phone_keybuild(pmod)
			),
			if(
				'S' in in_mod.L_build_skip_set,
				output('AUTOKEY BUILD: SSN key skipped'),
				L_ivisitor.BuildI_Indv_SSN_keybuild(pmod)
			),
			if('T' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_StName_keybuild(pmod)),
			if('Z' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_Zip_keybuild(pmod)),
			if(
				'-' in in_mod.L_build_skip_set,
				L_ivisitor.BuildI_Indv_ZipPRLname_keybuild(pmod)
			))
			
			);
		dobkeys := parallel(
			if('D' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Address_keybuild(bmod)),
			if('J' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_CityStName_keybuild(bmod)),
			if('M' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Name_keybuild(bmod)),
			if('W' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_NameWords_keybuild(bmod)),
			if('Q' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Phone_keybuild(bmod)),
			if('F' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_FEIN_keybuild(bmod)),
			if('U' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_StName_keybuild(bmod)),
			if('Y' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Zip_keybuild(bmod)),
			L_ivisitorb.BuildI_Biz_Custom1_keybuild(bmod),
			L_ivisitorb.BuildI_Biz_Custom2_keybuild(bmod),
			L_ivisitorb.BuildI_Biz_Custom3_keybuild(bmod),
			L_ivisitorb.BuildI_Biz_Custom4_keybuild(bmod),
			L_ivisitorb.BuildI_Biz_Custom5_keybuild(bmod)
			);
			
		return 
		PARALLEL(  //build
			if('C' not in in_mod.L_build_skip_set, dopkeys),																	
			if('B' not in in_mod.L_build_skip_set, dobkeys)
		);
		
	END;
	
	
	export MoveToBuilt(
		params in_mod, 
		AutoKeyI.BuildI_Indv.IBuild L_ivisitor = AutoKeyI.BuildI_Indv.DoBuild,
		AutoKeyI.BuildI_Biz.IBuild L_ivisitorb = AutoKeyI.BuildI_Biz.DoBuild) :=
	FUNCTION
		pmod := makePmod(in_mod);
		bmod := MakeBmod(in_mod);
		
		mvpkeys := parallel(
			if('A' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_Address_keymove(pmod)),
			if('I' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_CityStName_keymove(pmod)),
			if('N' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_Name_keymove(pmod)),
			if(
				'P' in in_mod.L_build_skip_set, 
				output('AUTOKEY MOVE: Phone key skipped'),
				L_ivisitor.BuildI_Indv_Phone_keymove(pmod)
			),
			if(
				'S' in in_mod.L_build_skip_set,
				output('AUTOKEY MOVE: SSN key skipped'),
				L_ivisitor.BuildI_Indv_SSN_keymove(pmod)
			),
			if('T' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_StName_keymove(pmod)),
			if('Z' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_Zip_keymove(pmod)),
			if(
				'-' in in_mod.L_build_skip_set,
				L_ivisitor.BuildI_Indv_ZipPRLname_keymove(pmod)
			),
			L_ivisitor.BuildI_Indv_Custom1_keymove(pmod),
			L_ivisitor.BuildI_Indv_Custom2_keymove(pmod),
			L_ivisitor.BuildI_Indv_Custom3_keymove(pmod),
			L_ivisitor.BuildI_Indv_Custom4_keymove(pmod),
			L_ivisitor.BuildI_Indv_Custom5_keymove(pmod)
			);

		mvbkeys := parallel(
			if('D' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Address_keymove(bmod)),
			if('J' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_CityStName_keymove(bmod)),
			if('M' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Name_keymove(bmod)),
			if('W' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_NameWords_keymove(bmod)),
			if(
				'Q' in in_mod.L_build_skip_set, 
				output('AUTOKEYB2 MOVE: Phone key skipped'),
				L_ivisitorb.BuildI_Biz_Phone_keymove(bmod)
			),
			if(
				'F'in in_mod.L_build_skip_set, 
				output('AUTOKEYB2 MOVE: FEIN key skipped'),
				L_ivisitorb.BuildI_Biz_FEIN_keymove(bmod)
			),
			if('U' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_StName_keymove(bmod)),
			if('Y' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Zip_keymove(bmod)),
			L_ivisitorb.BuildI_Biz_Custom1_keymove(bmod),
			L_ivisitorb.BuildI_Biz_Custom2_keymove(bmod),
			L_ivisitorb.BuildI_Biz_Custom3_keymove(bmod),
			L_ivisitorb.BuildI_Biz_Custom4_keymove(bmod),
			L_ivisitorb.BuildI_Biz_Custom5_keymove(bmod)
			);
			
		return 
		PARALLEL(  //move to built
			if('C' not in in_mod.L_build_skip_set, mvpkeys),
			if('B' not in in_mod.L_build_skip_set, mvbkeys)
		);
		
	END;

	export MoveToQA(
		params in_mod, 
		AutoKeyI.BuildI_Indv.IBuild L_ivisitor = AutoKeyI.BuildI_Indv.DoBuild,
		AutoKeyI.BuildI_Biz.IBuild L_ivisitorb = AutoKeyI.BuildI_Biz.DoBuild) :=
	FUNCTION
		pmod := makePmod(in_mod);
		bmod := MakeBmod(in_mod);
		mvpkeys := parallel(
			if('A' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_Address_keymoveQA(pmod)),
			if('I' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_CityStName_keymoveQA(pmod)),
			if('N' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_Name_keymoveQA(pmod)),
			if(
				'P' in in_mod.L_build_skip_set, 
				output('AUTOKEY MOVEQA: Phone key skipped'),
				L_ivisitor.BuildI_Indv_Phone_keymoveQA(pmod)
			),
			if(
				'S' in in_mod.L_build_skip_set,
				output('AUTOKEY MOVEQA: SSN key skipped'),
				L_ivisitor.BuildI_Indv_SSN_keymoveQA(pmod)
			),
			if('T' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_StName_keymoveQA(pmod)),
			if('Z' not in in_mod.L_build_skip_set, L_ivisitor.BuildI_Indv_Zip_keymoveQA(pmod)),
			if(
				'-' in in_mod.L_build_skip_set,
				L_ivisitor.BuildI_Indv_ZipPRLname_keymoveQA(pmod)
			),
			L_ivisitor.BuildI_Indv_Custom1_keymoveQA(pmod),
			L_ivisitor.BuildI_Indv_Custom2_keymoveQA(pmod),
			L_ivisitor.BuildI_Indv_Custom3_keymoveQA(pmod),
			L_ivisitor.BuildI_Indv_Custom4_keymoveQA(pmod),
			L_ivisitor.BuildI_Indv_Custom5_keymoveQA(pmod)
			);

		mvbkeys := parallel(
			if('D' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Address_keymoveQA(bmod)),
			if('J' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_CityStName_keymoveQA(bmod)),
			if('M' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Name_keymoveQA(bmod)),
			if('W' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_NameWords_keymoveQA(bmod)),
			if(
				'Q'in in_mod.L_build_skip_set, 
				output('AUTOKEYB2 MOVEQA: Phone key skipped'),
				L_ivisitorb.BuildI_Biz_Phone_keymoveQA(bmod)
			),
			if(
				'F'in in_mod.L_build_skip_set, 
				output('AUTOKEYB2 MOVEQA: FEIN key skipped'),
				L_ivisitorb.BuildI_Biz_FEIN_keymoveQA(bmod)
			),
			if('U' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_StName_keymoveQA(bmod)),
			if('Y' not in in_mod.L_build_skip_set, L_ivisitorb.BuildI_Biz_Zip_keymoveQA(bmod)),
			L_ivisitorb.BuildI_Biz_Custom1_keymoveQA(bmod),
			L_ivisitorb.BuildI_Biz_Custom2_keymoveQA(bmod),
			L_ivisitorb.BuildI_Biz_Custom3_keymoveQA(bmod),
			L_ivisitorb.BuildI_Biz_Custom4_keymoveQA(bmod),
			L_ivisitorb.BuildI_Biz_Custom5_keymoveQA(bmod)
			);
			
		return 
		PARALLEL(  //move to built
			if('C' not in in_mod.L_build_skip_set, mvpkeys),
			if('B' not in in_mod.L_build_skip_set, mvbkeys)
		);
		
	END;

	export Do(
		params in_mod, 
		AutoKeyI.BuildI_Indv.IBuild L_ivisitor = AutoKeyI.BuildI_Indv.DoBuild,
		AutoKeyI.BuildI_Biz.IBuild L_ivisitorb = AutoKeyI.BuildI_Biz.DoBuild) :=
	FUNCTION
	
		return 
		SEQUENTIAL(
			_Build			(in_mod, L_ivisitor, L_ivisitorb),
			MoveToBuilt	(in_mod, L_ivisitor, L_ivisitorb)
		);
	

	END;
	
	export DoQA(
		params in_mod, 
		AutoKeyI.BuildI_Indv.IBuild L_ivisitor = AutoKeyI.BuildI_Indv.DoBuild,
		AutoKeyI.BuildI_Biz.IBuild L_ivisitorb = AutoKeyI.BuildI_Biz.DoBuild) :=
	FUNCTION
	
		return 
		SEQUENTIAL(
			Do					(in_mod, L_ivisitor, L_ivisitorb),
			MoveToQA		(in_mod, L_ivisitor, L_ivisitorb)
		);
	

	END;

END;