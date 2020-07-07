/*--SOAP--
  <message name = 'AddrHistReport'>
    <part name = 'Buyer1DID'  type = 'xsd:string'/>
    <part name = 'Buyer2DID'  type = 'xsd:string'/>
    <part name = 'Seller1DID' type = 'xsd:string'/>
    <part name = 'Seller2DID' type = 'xsd:string'/>
    <part name = 'Addr'    type = 'xsd:string'/>
    <part name = 'City'    type = 'xsd:string'/>
    <part name = 'State'   type = 'xsd:string'/>
    <part name = 'Zip'     type = 'xsd:string'/>
    <part name = 'Zip4'    type = 'xsd:string'/>
    <part name = 'GLBPurpose'  type = 'xsd:byte'/>
    <part name = 'DPPAPurpose' type = 'xsd:byte'/>
    <part name = 'ApplicationType' type='xsd:string'/>
    <part name = 'LnBranded'    type = 'xsd:boolean'/>
    <part name = 'ProbationOverride' type = 'xsd:boolean'/>
    <part name="DataRestrictionMask" type="xsd:string"/>
    <part name="DataPermissionMask"  type="xsd:string"/>
  </message>
*/
/*--INFO-- This Service does Address History */

export AddressHistory_Report_Service() := macro

IMPORT Location_Services, Doxie, AutoStandardI, Royalty;

gm_mod := AutoStandardI.GlobalModule();
string200 addr   := '' : stored('addr');
string25  city   := '' : stored('city');
string2   state  := '' : stored('state');
string5   zip    := gm_mod.zip;
string4   zip4   := '' : stored('zip4');
string14  buyer1   := '' : stored('buyer1did');
string14  buyer2   := '' : stored('buyer2did');
string14  seller1  := '' : stored('seller1did');
string14  seller2  := '' : stored('seller2did');
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(gm_mod);

location_services.Layout_AddrHistory_In into_in() := transform
  self.buyer_did := (integer)buyer1;
  self.buyer2_did := (integer)buyer2;
  self.seller_did := (integer)seller1;
  self.seller2_did := (integer)seller2;
  self.addr1 := addr;
  self.city := city;
  self.state := state;
  self.zip := zip;
  self.zip4 := zip4;
end;

inf := DATASET([into_in()]);

outf := location_services.AddrHistory_Function(inf, mod_access);

Royalty.RoyaltyFares.MAC_SetC(outf(do_royal=TRUE), outf(do_royal=FALSE), royalties);


output(outf,NAMED('Results'));
output(royalties,named('RoyaltySet'));

endmacro;
// AddressHistory_Report_Service()
