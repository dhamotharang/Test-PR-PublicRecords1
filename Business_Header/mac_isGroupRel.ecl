export mac_isGroupRel(
	pInput,
	nodca = false
) :=
macro

(
	not pInput.rel_group
	and	(
						pInput.corp_charter_number
				or	pInput.business_registration
				or	pInput.duns_number
				or	pInput.edgar_cik
				or	pInput.name_address
				or	pInput.name_phone
				or	pInput.fbn_filing
				or	pInput.mail_addr
				or	pInput.dca_company_number
				or	(not nodca and pInput.dca_hierarchy)
				or	pInput.abi_number
				or	pInput.abi_hierarchy
				or	(				pInput.bankruptcy_filing 
							and (			pInput.name
										or	pInput.name_phone
									)
						) 
				or	(			pInput.ucc_filing
							and (
												pInput.name 
										or	pInput.name_phone
									)
						)
				or	(			pInput.fein
							and (			pInput.name 
										or	pInput.addr
										or	pInput.phone
									)
						)
			)
)

endmacro;