/*--SOAP--
<message name="ProxidCompareService">
<part name="ProxidOne" type="xsd:string"/>
<part name="ProxidTwo" type="xsd:string"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT ProxidCompareService_v1() := function
IMPORT SALT24,BIPV2_ProxID,ut,tools, zz_mstemp;
STRING50 Proxidonestr := ''  : STORED('ProxidOne');
STRING20 Proxidtwostr := '*'  : STORED('Proxidtwo');
Integer  uniqueId := 0  : STORED('UniqueID');
UNSIGNED8 Proxidone0 := (UNSIGNED8)ut.Word(Proxidonestr,1); // Allow for two token on a line input
UNSIGNED8 Proxidtwo0 := (UNSIGNED8)(IF(Proxidtwostr='*',ut.Word(Proxidonestr,2),Proxidtwostr));
UNSIGNED8 Proxidone := IF( Proxidone0>Proxidtwo0, Proxidone0, Proxidtwo0 );
UNSIGNED8 Proxidtwo := IF( Proxidone0>Proxidtwo0, Proxidtwo0, Proxidone0 );
BFile := BIPV2_ProxID.In_DOT_Base;
odl := PROJECT(CHOOSEN(BIPV2_ProxID.Keys(BFile).Candidates(Proxid=Proxidone),100000),BIPV2_ProxID.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(BIPV2_ProxID.Keys(BFile).Candidates(Proxid=ProxidTwo),100000),BIPV2_ProxID.match_candidates(BFile).layout_candidates);
k := BIPV2_ProxID.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,BIPV2_ProxID.Layout_Specificities.R)[1]);
odlv := BIPV2_ProxID.Debug(BFile,s).RolledEntities(odl);
odrv := BIPV2_ProxID.Debug(BFile,s).RolledEntities(odr);
BIPV2_ProxID.match_candidates(BFile).layout_attribute_matches ainto(BIPV2_ProxID.Keys(BFile).Attribute_Matches le) := TRANSFORM
SELF := le;
END;
am := PROJECT(BIPV2_ProxID.Keys(BFile).Attribute_Matches(Proxid1=Proxidone,Proxid2=Proxidtwo)+BIPV2_ProxID.Keys(BFile).Attribute_Matches(Proxid1=Proxidtwo,Proxid2=Proxidone),ainto(LEFT));
mtch := BIPV2_ProxID.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Proxidone,Proxidtwo,0,0}],BIPV2_ProxID.match_candidates(BFile).layout_matches),am);
// Put out easy to read versions of the 4944704 data
tools.mac_LayoutTools(recordof(mtch),layouttools,false,false,'^(?!.*?(left|right|skipped).*).*$',true);
mtch_score := project(mtch,layouttools.layout_record);
	return project(mtch, transform(zz_mstemp.prox_didcmp_layout, 
																			self.uniqueid := uniqueid,
																			self.left_cnp_name := trim(left.left_corp_legal_name),
																			self.right_cnp_name := trim(left.right_corp_legal_name),
																			self.left_cnp_adr := trim(left.left_company_prim_range) + ' ' + trim(left.left_company_prim_name) + ' ' + trim(left.left_company_sec_range) + ' ' + trim(left.left_company_v_city_name) + ' ' + trim(left.left_company_st) + ' ' + trim(left.left_company_zip5) ,
																			self.right_cnp_adr := trim(left.right_company_prim_range) + ' ' + trim(left.right_company_prim_name) + ' ' + trim(left.right_company_sec_range) + ' ' + trim(left.right_company_v_city_name) + ' ' + trim(left.right_company_st) + ' ' + trim(left.right_company_zip5), 
																			self.left_fein := trim(left.left_company_fein),
																			self.right_fein := trim(left.right_company_fein),
																			self.left_foreign_corp :=  trim(left.left_foreign_corp_key),
																			self.right_foreign_corp := trim(left.right_foreign_corp_key),
																			self.left_legal_corp := trim(left.left_corp_legal_name), 
																			self.right_legal_corp := trim(left.right_corp_legal_name), 
																			self.left_contact_name := trim(left.left_contact_fname) + ' ' + trim(left.left_contact_mname) + ' ' + trim(left.left_contact_lname),
																			self.right_contact_name := trim(left.right_contact_fname) + ' ' + trim(left.right_contact_mname) + ' ' + trim(left.right_contact_lname),
																			self := left, self := [] ));
end;
