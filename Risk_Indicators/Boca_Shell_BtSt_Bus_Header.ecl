﻿/*2016-01-08T01:08:11Z (Andi Koenen)
RR: 192631: CBD 5.0 new attributes
*/
/*
Used in the BTST shell
Bill To Ship To Identity-Business Association (st_addr_is_bt_business_addr) - whether the ship-to address is associated with a business which is associated with the bill-to identity.
*Additional Commercial Insights are below:
btst_bt_bip_addr_ct - Number of unique business entities at the BT address
btst_st_bip_addr_ct -	Number of unique business entities at the ST address
btst_bt_addr_bip_match - whether or not searching the Business Header by the BT inputs returns a matching business entity
btst_st_addr_bip_match - whether or not searching the Business Header by the ST inputs returns a matching business entity
*/

import BIPV2, MDR, Header, riskwise, risk_indicators, doxie;

export Boca_Shell_BtSt_Bus_Header(grouped dataset(Risk_Indicators.layout_ciid_btst_Output) input,
	unsigned1 glb, unsigned1 dppa, string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
	string50 DataPermission = risk_indicators.iid_constants.default_DataPermission,
	doxie.IDataAccess mod_access) := FUNCTION

bus_input := ungroup(input);
isFCRA := false;

layout_bocashell_btst_out_working := record
	risk_indicators.layout_bocashell_btst_out;
  unsigned6 powid;
  unsigned6 proxid;
  unsigned6 seleid;
  unsigned6 orgid;
  unsigned6 ultid;
	UNSIGNED4 seq;
	string6 dt_first_seen;
	string50 company_status_derived;
end;

//since only sending in address information that is ALL we will match on.
//we may need to do post filtering if we don't like the fuzzy address matching
	BIPV2.IDFunctions.rec_SearchInput prepBIP_BTInput(Risk_Indicators.layout_ciid_btst_Output le) := TRANSFORM
		SELF.prim_range := le.Bill_To_Output.Prim_Range;
		SELF.prim_name := le.Bill_To_Output.Prim_Name;
		SELF.zip5 := le.Bill_To_Output.Z5;
		SELF.sec_range := le.Bill_To_Output.Sec_Range;
		SELF.city := le.Bill_To_Output.p_city_name;
		SELF.state := le.Bill_To_Output.St;
		SELF.acctno := (STRING)le.Bill_To_Output.Seq;	
		SELF := [];
	END;

	BIPV2.IDFunctions.rec_SearchInput prepBIP_STInput(Risk_Indicators.layout_ciid_btst_Output le) := TRANSFORM
		SELF.prim_range := le.Ship_To_Output.Prim_Range;
		SELF.prim_name := le.Ship_To_Output.Prim_Name;
		SELF.zip5 := le.Ship_To_Output.Z5;
		SELF.sec_range := le.Ship_To_Output.Sec_Range;
		SELF.city := le.Ship_To_Output.p_city_name;
		SELF.state := le.Ship_To_Output.st;
		SELF.acctno := (STRING)le.Ship_To_Output.Seq;	
		SELF := [];
	END;

	BT_input := project(bus_input(Bill_To_Output.seq != 0), prepBIP_BTInput(LEFT));
	ST_input := project(bus_input(Ship_To_Output.seq != 0), prepBIP_STInput(LEFT));
	
	BIPSearchInput := BT_input + ST_input;
	BIPSearchInput_fltrd := BIPSearchInput(prim_range != '');

	LinkIDsRaw := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(BIPSearchInput_fltrd).SearchKeyData(mod_access);
	Risk_Indicators.iid_constants.MAC_IsBusinessRestricted(LinkIDsRaw, LinkIDsRaw_out, source, vl_id, 
		dt_first_seen, dppa, glb, DataRestriction, isFCRA);	
	
	layout_bocashell_btst_out_working add_business_header(Risk_Indicators.layout_ciid_btst_Output l, recordof(LinkIDsRaw) r) := transform
		self.ultid := r.ultid;
		self.orgid := r.orgid;
		self.seleId := r.seleId;
		self.proxid := r.proxid;
		self.powid := r.powid;
		self.seq := (unsigned6) r.acctno;
		self.Bill_To_Out := l.Bill_To_Output;
		self.Ship_To_Out := l.Ship_To_Output;
		self.dt_first_seen := ((STRING)r.dt_first_seen)[1..6];
		self.company_status_derived := r.company_status_derived;
		self := [];
	end;
		
	bt_with_bus_addr_jnd :=	join(bus_input(Bill_To_Output.seq != 0), LinkIDsRaw_out,
		(unsigned6) LEFT.Bill_To_Output.seq = (unsigned6) RIGHT.acctno and
			left.Bill_To_Output.prim_range = right.prim_range and
			left.Bill_To_Output.prim_name = right.prim_name and
			left.Bill_To_Output.sec_range = right.sec_range and
			left.Bill_To_Output.z5 = right.zip and
			left.Bill_To_Output.st = right.st,
			add_business_header(left, right), atmost(riskwise.max_atmost*2),
			keep(riskwise.max_atmost), left outer);
	bt_with_bus_addr := join(bus_input(Bill_To_Output.seq != 0), bt_with_bus_addr_jnd,
			(unsigned6) LEFT.Bill_To_Output.seq = (unsigned6) RIGHT.seq and	
		right.dt_first_seen < ((STRING)left.bill_to_output.historydate)[1..6] and 
			trim(StringLib.StringToUpperCase(right.company_status_derived)) = Risk_Indicators.iid_constants.ActiveText,
		transform(right), left outer);
		
	bt_with_bus_addr_dp := dedup(sort(bt_with_bus_addr, seq, seleid),seq, seleid);
	//get counts for 1A.7 for Bill To
	tbl_bt_with_bus_addr_dp := table(bt_with_bus_addr_dp, {seq, seleIdCnt := count(group)}, seq);

	bt_bus_info := JOIN(bus_input, tbl_bt_with_bus_addr_dp,
		LEFT.Bill_To_Output.Seq = Right.seq,
		transform(risk_indicators.layout_bocashell_btst_out, 
			BTInputPopulated := if(left.Bill_To_Output.prim_range != '' or left.Bill_To_Output.prim_name != '' 
			or left.Bill_To_Output.sec_range != '' or left.Bill_To_Output.z5 != '' or left.Bill_To_Output.st != '', true, false);
			
			self.btst_bt_bip_addr_ct := if(BTInputPopulated, right.seleIdCnt, -1);
			self.btst_bt_addr_bip_match := if(right.seleIdCnt > 0, true, false);	
			self.Bill_To_Out.Shell_Input := left.Bill_To_Output;
			self.Ship_To_Out.Shell_Input := left.Ship_To_Output;
			self.Bill_To_Out := left.Bill_To_Output;
			self.Ship_To_Out := left.Ship_To_Output;
			self := left;
			self := []), atmost(riskwise.max_atmost), left outer);

	st_with_bus_addr_jnd := join(bus_input(Ship_To_Output.seq != 0), LinkIDsRaw_out, 
		(unsigned6) LEFT.Ship_To_Output.seq = (unsigned6) RIGHT.acctno and 
			left.Ship_To_Output.prim_range = right.prim_range and
			left.Ship_To_Output.prim_name = right.prim_name and
			left.Ship_To_Output.sec_range = right.sec_range and
			left.Ship_To_Output.z5 = right.zip and
			left.Ship_To_Output.st = right.st, 
			add_business_header(left, right), atmost(riskwise.max_atmost*2),
			keep(riskwise.max_atmost), left outer);
			
	st_with_bus_addr := join(bus_input(Ship_To_Output.seq != 0), st_with_bus_addr_jnd,
			(unsigned6) LEFT.Ship_To_Output.seq = (unsigned6) RIGHT.seq and	
		right.dt_first_seen < ((STRING)left.Ship_To_Output.historydate)[1..6] and 
			trim(StringLib.StringToUpperCase(right.company_status_derived)) = Risk_Indicators.iid_constants.ActiveText,
		transform(right), left outer);
		
	st_with_bus_addr_dp := dedup(sort(st_with_bus_addr, seq, seleid), seq, seleid);
	//get counts for 1A.7 for Ship To
	tbl_st_with_bus_addr_dp := table(st_with_bus_addr_dp, {seq, seleIdCnt := count(group)}, seq);

	btst_bus_info := JOIN(bt_bus_info, tbl_st_with_bus_addr_dp,
		LEFT.Bill_To_Out.Seq = Right.seq - 1,
		transform(risk_indicators.layout_bocashell_btst_out,
			STInputPopulated := if(left.Ship_To_Out.Shell_Input.prim_range != '' or left.Ship_To_Out.Shell_Input.prim_name != '' 
				or left.Ship_To_Out.Shell_Input.sec_range != '' or left.Ship_To_Out.Shell_Input.z5 != '' or left.Ship_To_Out.Shell_Input.st != '', true, false);
			self.btst_st_bip_addr_ct := if(STInputPopulated, right.seleIdCnt, -1);
			self.btst_st_addr_bip_match := if(right.seleIdCnt > 0, true, false);
			self := left, 
			self := []), keep(1), left outer);
	//1A.4 BusinessLink
	bothSeleIds := join(bt_with_bus_addr_dp, st_with_bus_addr_dp,
		(unsigned6) left.seq = (unsigned6) right.seq - 1 and 
		left.seleID = right.SeleID,
		transform(left), atmost(riskwise.max_atmost));

	tbl_SeleCounts := table(bothSeleIds, {seq, seleIdCnt := count(group)}, seq);

	postBusHeader_TMP :=	join(btst_bus_info, tbl_SeleCounts,
			left.bill_to_out.seq = right.seq,
			transform(risk_indicators.layout_bocashell_btst_out, 
				self.btst_businesses_in_common := if(left.Bill_To_Out.did != 0 and left.Ship_To_Out.did != 0 and
					left.Ship_To_Out.did != left.Bill_To_Out.did, right.seleIdCnt, -1);
				STInputandBTdid := if((left.Ship_To_Out.Shell_Input.prim_range != '' or left.Ship_To_Out.Shell_Input.prim_name != '' or 
					left.Ship_To_Out.Shell_Input.sec_range != '' or left.Ship_To_Out.Shell_Input.z5 != '' or 
					left.Ship_To_Out.Shell_Input.st != '' ) and left.Bill_To_Out.did != 0, true, false); 
				self.st_addr_is_bt_business_addr := if(STInputandBTdid, if(right.seleIdCnt >0, 1, 0), -1); //-1 but this field is logical!
				self := left), left outer, keep(1));
	postBusHeader := GROUP(	postBusHeader_TMP, bill_to_out.seq);
		//outputs for debugging			
		// output(LinkIDsRaw, named('LinkIDsRaw'));
		// OUTPUT(bt_with_bus_addr, NAMED('bt_with_bus_addr'));
		// OUTPUT(bt_with_bus_addr_dp, NAMED('bt_with_bus_addr_dp'));
		// OUTPUT(tbl_bt_with_bus_addr_dp, NAMED('tbl_bt_with_bus_addr_dp'));
		// OUTPUT(bt_bus_info, NAMED('bt_bus_info'));
		// OUTPUT(st_with_bus_addr, NAMED('st_with_bus_addr'));
		// OUTPUT(tbl_st_with_bus_addr_dp, NAMED('tbl_st_with_bus_addr_dp'));
		// OUTPUT(btst_bus_info, NAMED('btst_bus_info'));
		// OUTPUT(bothSeleIds, NAMED('bothSeleIds'));
		// OUTPUT(postBusHeader, NAMED('postBusHeader'));
		// output(bus_input, named('bus_input'));
		// OUTPUT(input, named('input'));
		// output(LinkIDsRaw, named('LinkIDsRaw'));
		// output(LinkIDsRaw_out, named('LinkIDsRaw_out'));
		// OUTPUT(bt_with_bus_addr, NAMED('bt_with_bus_addr'));
		// output(bt_with_bus_addr_dp, named('bt_with_bus_addr_dp'));
		// OUTPUT(postBusHeader_TMP, NAMED('postBusHeader_TMP'));
		// output(tbl_st_with_bus_addr_dp, named('tbl_st_with_bus_addr_dp'));

	return postBusHeader;

end;