import header_services,paw;

Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
 string15 bdid; 
 string2 source; 
 string8 sic_code; 
 string2 eor;
end;

header_services.Supplemental_Data.mac_verify('file_sic_inj.txt', Drop_Header_Layout, attr);

Base_File_Append_In := attr();

Layout_SIC_Code reformat_layout(Base_File_Append_In L) := 
 transform
  self.bdid := (unsigned6) L.bdid;
  self := L;
 end;
 
other_sic := project(Base_File_Append_In, reformat_layout(left)); 

//========
pPersistname := business_header.persistnames().BHBDIDSIC + '::sickey'; 

dpawinactives := paw.fCorpInactives(pPersistname := paw.persistnames.f_CorpInactives + '::sickey');

base := Business_Header.BH_BDID_SIC(pPersistname := pPersistname,pInactiveCorps := dpawinactives);

Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('sic_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashVal := header_services.Supplemental_Data.layout_out;

temp_rec := record
Layout_SIC_Code;
rHashVal;
end;

temp_rec tHash_vals(Layout_SIC_Code l) := transform                            
 self.hval := hashmd5(intformat(l.bdid,12,1));
 self := l;
end;

temp := project(base, tHash_vals(left));

Layout_SIC_Code tSuppress(Temp l, dSuppressedIn r) := transform
 self := l;
end;

rs := join(temp,dSuppressedIn,
            left.hval=right.hval,
						tSuppress(left,right),
						left only,all);

//========
f := base; 

layout_sic_index := record
f.bdid;
f.sic_code;
end;

fprep := table(f, layout_sic_index);
fdedup := dedup(fprep, all);

export Key_Prep_SIC_Code := index(
	fdedup, {bdid}, {sic_code},
	'~thor_data400::key::business_header.SIC_Code' + thorlib.wuid());