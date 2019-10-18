/*--SOAP--
<message name="Biz_Header_Service_2">
<part name="SELEID" type="unsignedInt"/>
<part name="DataRestrictionMask" type="xsd:string"/>
<part name="ShowRawHeaderData" type="xsd:boolean"/>
</message>
*/

EXPORT svcStatus := MACRO
import ut,BIPV2,bipv2_DevZone;

inSele := 18226841 : stored('SELEID');
boolean ShowRawHeaderData := FALSE : stored('ShowRawHeaderData');

inputs := 
project(
	dataset([{1}], {unsigned a}),
  transform(
    BIPV2.IDfunctions.rec_SearchInput,
    self.inSeleid := (string)inSele,
    self := []
  )
);

selebest := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(inputs).selebest;
seleslim := table(selebest, {ultid, orgid, seleid, company_name, prim_range, prim_name, zip, v_city_name, st, company_status_derived, isActive, isDefunct});
output(seleslim, named('selebest'));

fornew := project(seleslim, transform({seleslim.seleid, seleslim.company_status_derived}, self.company_status_derived := '', self:= left));
output(bipv2_DevZone.mac_AddStatus(fornew), named('status_new'));

key_Status_unsorted := BIPV2.key_Status.kfetch(project(//ut.ds_oneRecord, 
																	dataset([{1}], {unsigned a}),
																	transform(BIPV2.IDlayouts.l_xlink_ids, self.seleid := inSele, self := [])));
key_Status_noprox := dedup(project(key_Status_unsorted, transform({{key_Status_unsorted} - [proxid]}, self := left)), all);
key_Status := sort(key_Status_noprox, -dt_last_seen, dt_first_seen, -dt_vendor_last_reported, source);

output(table(key_Status, {key_Status, source_decoded := mdr.sourceTools.fTranslateSource(source)}), named('key_Status'));

output(if(ShowRawHeaderData, bipv2_testing.show.seleidf(inSele)), named('Raw_Header_Data'));

ENDMACRO;