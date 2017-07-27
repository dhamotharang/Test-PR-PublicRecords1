export party_type_named(STRING1 src, STRING1 ptype) := 
map(
			src='A' and ptype='O' => 'Assessee',
			src='A' and ptype='C' => 'Care Of',
			src='A' and ptype='S' => 'Seller',
			src='A' and ptype='P' => 'Property',
			
			src='D' and ptype='O' => 'Buyer',
			src='D' and ptype='S' => 'Seller',
			src='D' and ptype='C' => 'Care Of',
			src='D' and ptype='B' => 'Borrower',
			src='D' and ptype='P' => 'Property',
			''
);