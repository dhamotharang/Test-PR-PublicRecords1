import ares, std;

rcodes := file_gpcod2;

ddp_gpcod2 := dedup(sort(rcodes, routing_code),routing_code);
bacs_prod_code := std.str.splitwords(ares.files.ds_product(count(summary.names(value='BACS'))>0)[1].resource, '/') [3];
ach_prod_code := std.str.splitwords(ares.files.ds_product(count(summary.names(value='ACH'))>0)[1].resource, '/') [3];
fedwire_prod_code := std.str.splitwords(ares.files.ds_product(count(summary.names(value='Fedwire'))>0)[1].resource, '/') [3];
fedwiresec_prod_code := std.str.splitwords(ares.files.ds_product(count(summary.names(value='FedwireSec'))>0)[1].resource, '/') [3];
flat_routing_codes := Ares.file_routingcodes_flat;

gpcod2_w_flatrcodes_layout := recordof(ddp_gpcod2) or {recordof(flat_routing_codes) - rank};

gpcod2_w_flatrcodes_layout xform_j_rcodes(ddp_gpcod2 l, flat_routing_codes r) := transform
	self := l;
	self := r;
end;

gpcod2_w_flatrcodes := join(ddp_gpcod2, flat_routing_codes, left.routing_code = right.codeValue, xform_j_rcodes(left,right), left outer, keep(1));

w_routeVia := project(gpcod2_w_flatrcodes(count(paymentsystems(routeVia.href != ''))>0), 
											transform(recordof(gpcod2_w_flatrcodes) or {string routeVia_href},
																self.routeVia_href := std.str.splitwords(left.paymentsystems(routeVia.href != '')[1].routeVia.href,'/')[3], self := left));
																

w_override_code_layout := record(recordof(w_routeVia))
	string override_code := '';
	string overrid_code_alt := '';
end;

w_override_code_layout xform_override_code(w_routeVia l, flat_routing_codes r) := transform
	self.override_code := r.codeAlternateForms(form_type='tfp_legacy')[1].form;
	self.overrid_code_alt := r.codeValue;
	self := l;
end;
 
w_override_code1 := join(	w_routeVia, 
			flat_routing_codes(count(codeAlternateForms(form_type='tfp_legacy'))>0),
			left.routeVia_href = right.id,
			xform_override_code(left, right),
			left outer,
			keep(1));
			
w_routeVia_no_override :=  project(gpcod2_w_flatrcodes(count(paymentsystems(routeVia.href != ''))=0), 
											transform(w_override_code_layout,
																self.routeVia_href := '', 
																self.override_code := '',
																self := left));
																
w_override_code := w_override_code1 + w_routeVia_no_override;

routing_normed_layout := recordof(w_override_code) or {string payment_product} or recordof(w_override_code.paymentSystems);
 routing_normed_layout xform_routing_normed(recordof(w_override_code.paymentSystems) l, w_override_code r) := transform
	self.payment_product := std.str.splitwords(l.product.href,'/')[3];
	self.product.href := l.product.href;
	self.product.rel := l.product.rel;
	self.useCodeForm := l.useCodeForm;
	self.codesystemmembership := l.codesystemmembership;
	self.codesystemstatus := l.codesystemstatus;
	self.dateBegan := regexreplace('-', l.dateBegan,'');
	self.dateEnded := regexreplace('-', l.dateEnded,'');
	self.routeVia := l.routeVia;
	self.attributes := l.attributes;
	self := r;
 end;
 
 routing_normed := normalize(	w_override_code, left.paymentSystems, 
															xform_routing_normed(right, left));

 
 w_clearing_code_layout := record(recordof(routing_normed))
	string clearing_code :='';
	string paysys_tfpid := '';
 end;
 
 w_clearing_code_layout xform_w_clearing_code(routing_normed l, ares.files.ds_product r) := transform
	self.clearing_code := r.summary.names(type='Display Name')[1].value;
	self.paysys_tfpid := r.tfpid;
	self := l;
 end;
 //Get clearing code from product code.  Will have to get additional for BACS
 w_clearing_code := join(routing_normed, ares.files.ds_product, 
													left.payment_product = right.id,
													xform_w_clearing_code(left,right), 
													left outer);
w_clearing_code(payment_product = 'ce5fe383-b408-4791-af43-6b4c6eb626e2').paymentSystems;					
// output(w_clearing_code,named('w_clearing_code'));
bacs_codes := w_clearing_code(payment_product = bacs_prod_code);
not_bacs_codes := w_clearing_code(payment_product != bacs_prod_code);

w_bacs_codes_layout := w_clearing_code_layout;
 w_bacs_codes_layout xform_w_bacs_codes(recordof(bacs_codes.PaymentSystems.attributes) l, bacs_codes r) := transform
	self.clearing_code := l.name;
	self := r;
 end;
 
 w_bacs_codes_normed := normalize(	bacs_codes, left.PaymentSystems.attributes, 
															xform_w_bacs_codes(right, left));
 
 
bacs_decode_layout := record
	string id;
	string paymentsystem;
	string tfpid;
end;
bacs_decoded := project(ares.files.ds_lookup(fid='PAYMENT_SYSTEM_ATTRIBUTE')[1].categories(paymentsystem = 'BACS'),
												transform(bacs_decode_layout,
																	self.id := left.id,
																	self.paymentsystem := left.paymentsystem,
																	self.tfpid := left.entries(id = 'true')[1].tfpid));
w_bacs_clearing_codes := join(w_bacs_codes_normed, bacs_decoded, left.clearing_code = right.id, 
															transform(recordof(w_bacs_codes_normed),
																				self.clearing_code := right.paymentsystem + ' ' + right.tfpid,
																				self := left));

recombined := not_bacs_codes + bacs_codes + w_bacs_clearing_codes;
// /routingCode/paymentSystems/paymentSystem/product→/product/summary/names/name[type='Display Name']/value

// Also

// /routingCode/paymentSystems/paymentSystem[product/link/@href=$BACS]/attributes/attribute[name=(some-names)]/name

// Also some logic on the HK systems if that has to be consistent

// Also something for Swizterland if SIC/EUR have to be consistent
////////////////////////////////////////////////////////////////////////
Ares.layout_gpatt2 xform_final(recombined l) := Transform
	self.Update_Flag := 'A';
	self.Override_Routing_Code := l.override_code;
	self.Override_Routing_Code_Alternate_Presentation := l.overrid_code_alt;
	self.Clearing_System := l.clearing_code;
	self.Membership_Type := l.codesystemmembership;
	self.Routing_Type_Additional_Information := if (l.codetype = 'ABA', l.codeSubtype, '');
	self.Routing_Code_Status := map(l.codetype!='ABA'=>'', 
																	l.codestatus='active'=>'A', 
																	l.codestatus='inactive'=>'R', 
																	l.codestatus='pending'=>'P', 
																	l.codestatus='awaiting'=>'W',
																	'');
	self.ACH_Flag := if (l.payment_product = ach_prod_code, 
											 if(l.codeSystemMembership = 'online', 'Y', 'N'),
											 'N');
													
	self.Fedwire_Funds_Status := map(	l.codetype != 'ABA' => '', 
																		l.payment_product != fedwire_prod_code => 'I',
																		l.codeSystemMembership = 'online' => 'Y',
																		l.codeSystemMembership = 'offline' => 'N',
																		'I');
																		
	self.Fedwire_Securities_Status :=  map(	l.codetype != 'ABA' => '', 
																		l.payment_product != fedwiresec_prod_code => 'I',
																		l.codeSystemMembership = 'online' => 'Y',
																		l.codeSystemMembership = 'offline' => 'N',
																		'I');
	self.Wire_Transaction_Code := map(	l.codetype != 'ABA' => '', 
																		l.payment_product != fedwire_prod_code => '',
																		l.attributes(name='Settlement Only')[1].value = 'true' => 'S',
																		'');
	self.Attribute_Effective_Date := l.dateBegan;
	self.Attribute_Deactivation_Date := l.dateEnded;
	self := l;
End;

final := Project(recombined, xform_final(left));

EXPORT file_gpatt2 := final : persist('persist::ares::routingattributes');