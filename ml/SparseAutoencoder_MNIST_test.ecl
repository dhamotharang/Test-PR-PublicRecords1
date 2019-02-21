IMPORT ML;
IMPORT ML.Types AS Types;
IMPORT PBblas;
Layout_Cell := PBblas.Types.Layout_Cell;
//Number of neurons in the last layer is number of output assigned to each sample
INTEGER4 hl := 10;//number of nodes in the hiddenlayer
INTEGER4 f := 784;//number of input features

//input data

value_record := RECORD
real	f1	;
real	f2	;
real	f3	;
real	f4	;
real	f5	;
real	f6	;
real	f7	;
real	f8	;
real	f9	;
real	f10	;
real	f11	;
real	f12	;
real	f13	;
real	f14	;
real	f15	;
real	f16	;
real	f17	;
real	f18	;
real	f19	;
real	f20	;
real	f21	;
real	f22	;
real	f23	;
real	f24	;
real	f25	;
real	f26	;
real	f27	;
real	f28	;
real	f29	;
real	f30	;
real	f31	;
real	f32	;
real	f33	;
real	f34	;
real	f35	;
real	f36	;
real	f37	;
real	f38	;
real	f39	;
real	f40	;
real	f41	;
real	f42	;
real	f43	;
real	f44	;
real	f45	;
real	f46	;
real	f47	;
real	f48	;
real	f49	;
real	f50	;
real	f51	;
real	f52	;
real	f53	;
real	f54	;
real	f55	;
real	f56	;
real	f57	;
real	f58	;
real	f59	;
real	f60	;
real	f61	;
real	f62	;
real	f63	;
real	f64	;
real	f65	;
real	f66	;
real	f67	;
real	f68	;
real	f69	;
real	f70	;
real	f71	;
real	f72	;
real	f73	;
real	f74	;
real	f75	;
real	f76	;
real	f77	;
real	f78	;
real	f79	;
real	f80	;
real	f81	;
real	f82	;
real	f83	;
real	f84	;
real	f85	;
real	f86	;
real	f87	;
real	f88	;
real	f89	;
real	f90	;
real	f91	;
real	f92	;
real	f93	;
real	f94	;
real	f95	;
real	f96	;
real	f97	;
real	f98	;
real	f99	;
real	f100	;
real	f101	;
real	f102	;
real	f103	;
real	f104	;
real	f105	;
real	f106	;
real	f107	;
real	f108	;
real	f109	;
real	f110	;
real	f111	;
real	f112	;
real	f113	;
real	f114	;
real	f115	;
real	f116	;
real	f117	;
real	f118	;
real	f119	;
real	f120	;
real	f121	;
real	f122	;
real	f123	;
real	f124	;
real	f125	;
real	f126	;
real	f127	;
real	f128	;
real	f129	;
real	f130	;
real	f131	;
real	f132	;
real	f133	;
real	f134	;
real	f135	;
real	f136	;
real	f137	;
real	f138	;
real	f139	;
real	f140	;
real	f141	;
real	f142	;
real	f143	;
real	f144	;
real	f145	;
real	f146	;
real	f147	;
real	f148	;
real	f149	;
real	f150	;
real	f151	;
real	f152	;
real	f153	;
real	f154	;
real	f155	;
real	f156	;
real	f157	;
real	f158	;
real	f159	;
real	f160	;
real	f161	;
real	f162	;
real	f163	;
real	f164	;
real	f165	;
real	f166	;
real	f167	;
real	f168	;
real	f169	;
real	f170	;
real	f171	;
real	f172	;
real	f173	;
real	f174	;
real	f175	;
real	f176	;
real	f177	;
real	f178	;
real	f179	;
real	f180	;
real	f181	;
real	f182	;
real	f183	;
real	f184	;
real	f185	;
real	f186	;
real	f187	;
real	f188	;
real	f189	;
real	f190	;
real	f191	;
real	f192	;
real	f193	;
real	f194	;
real	f195	;
real	f196	;
real	f197	;
real	f198	;
real	f199	;
real	f200	;
real	f201	;
real	f202	;
real	f203	;
real	f204	;
real	f205	;
real	f206	;
real	f207	;
real	f208	;
real	f209	;
real	f210	;
real	f211	;
real	f212	;
real	f213	;
real	f214	;
real	f215	;
real	f216	;
real	f217	;
real	f218	;
real	f219	;
real	f220	;
real	f221	;
real	f222	;
real	f223	;
real	f224	;
real	f225	;
real	f226	;
real	f227	;
real	f228	;
real	f229	;
real	f230	;
real	f231	;
real	f232	;
real	f233	;
real	f234	;
real	f235	;
real	f236	;
real	f237	;
real	f238	;
real	f239	;
real	f240	;
real	f241	;
real	f242	;
real	f243	;
real	f244	;
real	f245	;
real	f246	;
real	f247	;
real	f248	;
real	f249	;
real	f250	;
real	f251	;
real	f252	;
real	f253	;
real	f254	;
real	f255	;
real	f256	;
real	f257	;
real	f258	;
real	f259	;
real	f260	;
real	f261	;
real	f262	;
real	f263	;
real	f264	;
real	f265	;
real	f266	;
real	f267	;
real	f268	;
real	f269	;
real	f270	;
real	f271	;
real	f272	;
real	f273	;
real	f274	;
real	f275	;
real	f276	;
real	f277	;
real	f278	;
real	f279	;
real	f280	;
real	f281	;
real	f282	;
real	f283	;
real	f284	;
real	f285	;
real	f286	;
real	f287	;
real	f288	;
real	f289	;
real	f290	;
real	f291	;
real	f292	;
real	f293	;
real	f294	;
real	f295	;
real	f296	;
real	f297	;
real	f298	;
real	f299	;
real	f300	;
real	f301	;
real	f302	;
real	f303	;
real	f304	;
real	f305	;
real	f306	;
real	f307	;
real	f308	;
real	f309	;
real	f310	;
real	f311	;
real	f312	;
real	f313	;
real	f314	;
real	f315	;
real	f316	;
real	f317	;
real	f318	;
real	f319	;
real	f320	;
real	f321	;
real	f322	;
real	f323	;
real	f324	;
real	f325	;
real	f326	;
real	f327	;
real	f328	;
real	f329	;
real	f330	;
real	f331	;
real	f332	;
real	f333	;
real	f334	;
real	f335	;
real	f336	;
real	f337	;
real	f338	;
real	f339	;
real	f340	;
real	f341	;
real	f342	;
real	f343	;
real	f344	;
real	f345	;
real	f346	;
real	f347	;
real	f348	;
real	f349	;
real	f350	;
real	f351	;
real	f352	;
real	f353	;
real	f354	;
real	f355	;
real	f356	;
real	f357	;
real	f358	;
real	f359	;
real	f360	;
real	f361	;
real	f362	;
real	f363	;
real	f364	;
real	f365	;
real	f366	;
real	f367	;
real	f368	;
real	f369	;
real	f370	;
real	f371	;
real	f372	;
real	f373	;
real	f374	;
real	f375	;
real	f376	;
real	f377	;
real	f378	;
real	f379	;
real	f380	;
real	f381	;
real	f382	;
real	f383	;
real	f384	;
real	f385	;
real	f386	;
real	f387	;
real	f388	;
real	f389	;
real	f390	;
real	f391	;
real	f392	;
real	f393	;
real	f394	;
real	f395	;
real	f396	;
real	f397	;
real	f398	;
real	f399	;
real	f400	;
real	f401	;
real	f402	;
real	f403	;
real	f404	;
real	f405	;
real	f406	;
real	f407	;
real	f408	;
real	f409	;
real	f410	;
real	f411	;
real	f412	;
real	f413	;
real	f414	;
real	f415	;
real	f416	;
real	f417	;
real	f418	;
real	f419	;
real	f420	;
real	f421	;
real	f422	;
real	f423	;
real	f424	;
real	f425	;
real	f426	;
real	f427	;
real	f428	;
real	f429	;
real	f430	;
real	f431	;
real	f432	;
real	f433	;
real	f434	;
real	f435	;
real	f436	;
real	f437	;
real	f438	;
real	f439	;
real	f440	;
real	f441	;
real	f442	;
real	f443	;
real	f444	;
real	f445	;
real	f446	;
real	f447	;
real	f448	;
real	f449	;
real	f450	;
real	f451	;
real	f452	;
real	f453	;
real	f454	;
real	f455	;
real	f456	;
real	f457	;
real	f458	;
real	f459	;
real	f460	;
real	f461	;
real	f462	;
real	f463	;
real	f464	;
real	f465	;
real	f466	;
real	f467	;
real	f468	;
real	f469	;
real	f470	;
real	f471	;
real	f472	;
real	f473	;
real	f474	;
real	f475	;
real	f476	;
real	f477	;
real	f478	;
real	f479	;
real	f480	;
real	f481	;
real	f482	;
real	f483	;
real	f484	;
real	f485	;
real	f486	;
real	f487	;
real	f488	;
real	f489	;
real	f490	;
real	f491	;
real	f492	;
real	f493	;
real	f494	;
real	f495	;
real	f496	;
real	f497	;
real	f498	;
real	f499	;
real	f500	;
real	f501	;
real	f502	;
real	f503	;
real	f504	;
real	f505	;
real	f506	;
real	f507	;
real	f508	;
real	f509	;
real	f510	;
real	f511	;
real	f512	;
real	f513	;
real	f514	;
real	f515	;
real	f516	;
real	f517	;
real	f518	;
real	f519	;
real	f520	;
real	f521	;
real	f522	;
real	f523	;
real	f524	;
real	f525	;
real	f526	;
real	f527	;
real	f528	;
real	f529	;
real	f530	;
real	f531	;
real	f532	;
real	f533	;
real	f534	;
real	f535	;
real	f536	;
real	f537	;
real	f538	;
real	f539	;
real	f540	;
real	f541	;
real	f542	;
real	f543	;
real	f544	;
real	f545	;
real	f546	;
real	f547	;
real	f548	;
real	f549	;
real	f550	;
real	f551	;
real	f552	;
real	f553	;
real	f554	;
real	f555	;
real	f556	;
real	f557	;
real	f558	;
real	f559	;
real	f560	;
real	f561	;
real	f562	;
real	f563	;
real	f564	;
real	f565	;
real	f566	;
real	f567	;
real	f568	;
real	f569	;
real	f570	;
real	f571	;
real	f572	;
real	f573	;
real	f574	;
real	f575	;
real	f576	;
real	f577	;
real	f578	;
real	f579	;
real	f580	;
real	f581	;
real	f582	;
real	f583	;
real	f584	;
real	f585	;
real	f586	;
real	f587	;
real	f588	;
real	f589	;
real	f590	;
real	f591	;
real	f592	;
real	f593	;
real	f594	;
real	f595	;
real	f596	;
real	f597	;
real	f598	;
real	f599	;
real	f600	;
real	f601	;
real	f602	;
real	f603	;
real	f604	;
real	f605	;
real	f606	;
real	f607	;
real	f608	;
real	f609	;
real	f610	;
real	f611	;
real	f612	;
real	f613	;
real	f614	;
real	f615	;
real	f616	;
real	f617	;
real	f618	;
real	f619	;
real	f620	;
real	f621	;
real	f622	;
real	f623	;
real	f624	;
real	f625	;
real	f626	;
real	f627	;
real	f628	;
real	f629	;
real	f630	;
real	f631	;
real	f632	;
real	f633	;
real	f634	;
real	f635	;
real	f636	;
real	f637	;
real	f638	;
real	f639	;
real	f640	;
real	f641	;
real	f642	;
real	f643	;
real	f644	;
real	f645	;
real	f646	;
real	f647	;
real	f648	;
real	f649	;
real	f650	;
real	f651	;
real	f652	;
real	f653	;
real	f654	;
real	f655	;
real	f656	;
real	f657	;
real	f658	;
real	f659	;
real	f660	;
real	f661	;
real	f662	;
real	f663	;
real	f664	;
real	f665	;
real	f666	;
real	f667	;
real	f668	;
real	f669	;
real	f670	;
real	f671	;
real	f672	;
real	f673	;
real	f674	;
real	f675	;
real	f676	;
real	f677	;
real	f678	;
real	f679	;
real	f680	;
real	f681	;
real	f682	;
real	f683	;
real	f684	;
real	f685	;
real	f686	;
real	f687	;
real	f688	;
real	f689	;
real	f690	;
real	f691	;
real	f692	;
real	f693	;
real	f694	;
real	f695	;
real	f696	;
real	f697	;
real	f698	;
real	f699	;
real	f700	;
real	f701	;
real	f702	;
real	f703	;
real	f704	;
real	f705	;
real	f706	;
real	f707	;
real	f708	;
real	f709	;
real	f710	;
real	f711	;
real	f712	;
real	f713	;
real	f714	;
real	f715	;
real	f716	;
real	f717	;
real	f718	;
real	f719	;
real	f720	;
real	f721	;
real	f722	;
real	f723	;
real	f724	;
real	f725	;
real	f726	;
real	f727	;
real	f728	;
real	f729	;
real	f730	;
real	f731	;
real	f732	;
real	f733	;
real	f734	;
real	f735	;
real	f736	;
real	f737	;
real	f738	;
real	f739	;
real	f740	;
real	f741	;
real	f742	;
real	f743	;
real	f744	;
real	f745	;
real	f746	;
real	f747	;
real	f748	;
real	f749	;
real	f750	;
real	f751	;
real	f752	;
real	f753	;
real	f754	;
real	f755	;
real	f756	;
real	f757	;
real	f758	;
real	f759	;
real	f760	;
real	f761	;
real	f762	;
real	f763	;
real	f764	;
real	f765	;
real	f766	;
real	f767	;
real	f768	;
real	f769	;
real	f770	;
real	f771	;
real	f772	;
real	f773	;
real	f774	;
real	f775	;
real	f776	;
real	f777	;
real	f778	;
real	f779	;
real	f780	;
real	f781	;
real	f782	;
real	f783	;
real	f784	;
INTEGER Label  ;
END;

input_data_tmp := DATASET('~online::maryam::mytest::MNIST_60000sa', value_record, CSV);
ML.AppendID(input_data_tmp, id, input_data);
OUTPUT  (input_data, NAMED ('input_data'));

Sampledata_Format := RECORD
input_data.id;
input_data.f1	;
input_data.f2	;
input_data.f3	;
input_data.f4	;
input_data.f5	;
input_data.f6	;
input_data.f7	;
input_data.f8	;
input_data.f9	;
input_data.f10	;
input_data.f11	;
input_data.f12	;
input_data.f13	;
input_data.f14	;
input_data.f15	;
input_data.f16	;
input_data.f17	;
input_data.f18	;
input_data.f19	;
input_data.f20	;
input_data.f21	;
input_data.f22	;
input_data.f23	;
input_data.f24	;
input_data.f25	;
input_data.f26	;
input_data.f27	;
input_data.f28	;
input_data.f29	;
input_data.f30	;
input_data.f31	;
input_data.f32	;
input_data.f33	;
input_data.f34	;
input_data.f35	;
input_data.f36	;
input_data.f37	;
input_data.f38	;
input_data.f39	;
input_data.f40	;
input_data.f41	;
input_data.f42	;
input_data.f43	;
input_data.f44	;
input_data.f45	;
input_data.f46	;
input_data.f47	;
input_data.f48	;
input_data.f49	;
input_data.f50	;
input_data.f51	;
input_data.f52	;
input_data.f53	;
input_data.f54	;
input_data.f55	;
input_data.f56	;
input_data.f57	;
input_data.f58	;
input_data.f59	;
input_data.f60	;
input_data.f61	;
input_data.f62	;
input_data.f63	;
input_data.f64	;
input_data.f65	;
input_data.f66	;
input_data.f67	;
input_data.f68	;
input_data.f69	;
input_data.f70	;
input_data.f71	;
input_data.f72	;
input_data.f73	;
input_data.f74	;
input_data.f75	;
input_data.f76	;
input_data.f77	;
input_data.f78	;
input_data.f79	;
input_data.f80	;
input_data.f81	;
input_data.f82	;
input_data.f83	;
input_data.f84	;
input_data.f85	;
input_data.f86	;
input_data.f87	;
input_data.f88	;
input_data.f89	;
input_data.f90	;
input_data.f91	;
input_data.f92	;
input_data.f93	;
input_data.f94	;
input_data.f95	;
input_data.f96	;
input_data.f97	;
input_data.f98	;
input_data.f99	;
input_data.f100	;
input_data.f101	;
input_data.f102	;
input_data.f103	;
input_data.f104	;
input_data.f105	;
input_data.f106	;
input_data.f107	;
input_data.f108	;
input_data.f109	;
input_data.f110	;
input_data.f111	;
input_data.f112	;
input_data.f113	;
input_data.f114	;
input_data.f115	;
input_data.f116	;
input_data.f117	;
input_data.f118	;
input_data.f119	;
input_data.f120	;
input_data.f121	;
input_data.f122	;
input_data.f123	;
input_data.f124	;
input_data.f125	;
input_data.f126	;
input_data.f127	;
input_data.f128	;
input_data.f129	;
input_data.f130	;
input_data.f131	;
input_data.f132	;
input_data.f133	;
input_data.f134	;
input_data.f135	;
input_data.f136	;
input_data.f137	;
input_data.f138	;
input_data.f139	;
input_data.f140	;
input_data.f141	;
input_data.f142	;
input_data.f143	;
input_data.f144	;
input_data.f145	;
input_data.f146	;
input_data.f147	;
input_data.f148	;
input_data.f149	;
input_data.f150	;
input_data.f151	;
input_data.f152	;
input_data.f153	;
input_data.f154	;
input_data.f155	;
input_data.f156	;
input_data.f157	;
input_data.f158	;
input_data.f159	;
input_data.f160	;
input_data.f161	;
input_data.f162	;
input_data.f163	;
input_data.f164	;
input_data.f165	;
input_data.f166	;
input_data.f167	;
input_data.f168	;
input_data.f169	;
input_data.f170	;
input_data.f171	;
input_data.f172	;
input_data.f173	;
input_data.f174	;
input_data.f175	;
input_data.f176	;
input_data.f177	;
input_data.f178	;
input_data.f179	;
input_data.f180	;
input_data.f181	;
input_data.f182	;
input_data.f183	;
input_data.f184	;
input_data.f185	;
input_data.f186	;
input_data.f187	;
input_data.f188	;
input_data.f189	;
input_data.f190	;
input_data.f191	;
input_data.f192	;
input_data.f193	;
input_data.f194	;
input_data.f195	;
input_data.f196	;
input_data.f197	;
input_data.f198	;
input_data.f199	;
input_data.f200	;
input_data.f201	;
input_data.f202	;
input_data.f203	;
input_data.f204	;
input_data.f205	;
input_data.f206	;
input_data.f207	;
input_data.f208	;
input_data.f209	;
input_data.f210	;
input_data.f211	;
input_data.f212	;
input_data.f213	;
input_data.f214	;
input_data.f215	;
input_data.f216	;
input_data.f217	;
input_data.f218	;
input_data.f219	;
input_data.f220	;
input_data.f221	;
input_data.f222	;
input_data.f223	;
input_data.f224	;
input_data.f225	;
input_data.f226	;
input_data.f227	;
input_data.f228	;
input_data.f229	;
input_data.f230	;
input_data.f231	;
input_data.f232	;
input_data.f233	;
input_data.f234	;
input_data.f235	;
input_data.f236	;
input_data.f237	;
input_data.f238	;
input_data.f239	;
input_data.f240	;
input_data.f241	;
input_data.f242	;
input_data.f243	;
input_data.f244	;
input_data.f245	;
input_data.f246	;
input_data.f247	;
input_data.f248	;
input_data.f249	;
input_data.f250	;
input_data.f251	;
input_data.f252	;
input_data.f253	;
input_data.f254	;
input_data.f255	;
input_data.f256	;
input_data.f257	;
input_data.f258	;
input_data.f259	;
input_data.f260	;
input_data.f261	;
input_data.f262	;
input_data.f263	;
input_data.f264	;
input_data.f265	;
input_data.f266	;
input_data.f267	;
input_data.f268	;
input_data.f269	;
input_data.f270	;
input_data.f271	;
input_data.f272	;
input_data.f273	;
input_data.f274	;
input_data.f275	;
input_data.f276	;
input_data.f277	;
input_data.f278	;
input_data.f279	;
input_data.f280	;
input_data.f281	;
input_data.f282	;
input_data.f283	;
input_data.f284	;
input_data.f285	;
input_data.f286	;
input_data.f287	;
input_data.f288	;
input_data.f289	;
input_data.f290	;
input_data.f291	;
input_data.f292	;
input_data.f293	;
input_data.f294	;
input_data.f295	;
input_data.f296	;
input_data.f297	;
input_data.f298	;
input_data.f299	;
input_data.f300	;
input_data.f301	;
input_data.f302	;
input_data.f303	;
input_data.f304	;
input_data.f305	;
input_data.f306	;
input_data.f307	;
input_data.f308	;
input_data.f309	;
input_data.f310	;
input_data.f311	;
input_data.f312	;
input_data.f313	;
input_data.f314	;
input_data.f315	;
input_data.f316	;
input_data.f317	;
input_data.f318	;
input_data.f319	;
input_data.f320	;
input_data.f321	;
input_data.f322	;
input_data.f323	;
input_data.f324	;
input_data.f325	;
input_data.f326	;
input_data.f327	;
input_data.f328	;
input_data.f329	;
input_data.f330	;
input_data.f331	;
input_data.f332	;
input_data.f333	;
input_data.f334	;
input_data.f335	;
input_data.f336	;
input_data.f337	;
input_data.f338	;
input_data.f339	;
input_data.f340	;
input_data.f341	;
input_data.f342	;
input_data.f343	;
input_data.f344	;
input_data.f345	;
input_data.f346	;
input_data.f347	;
input_data.f348	;
input_data.f349	;
input_data.f350	;
input_data.f351	;
input_data.f352	;
input_data.f353	;
input_data.f354	;
input_data.f355	;
input_data.f356	;
input_data.f357	;
input_data.f358	;
input_data.f359	;
input_data.f360	;
input_data.f361	;
input_data.f362	;
input_data.f363	;
input_data.f364	;
input_data.f365	;
input_data.f366	;
input_data.f367	;
input_data.f368	;
input_data.f369	;
input_data.f370	;
input_data.f371	;
input_data.f372	;
input_data.f373	;
input_data.f374	;
input_data.f375	;
input_data.f376	;
input_data.f377	;
input_data.f378	;
input_data.f379	;
input_data.f380	;
input_data.f381	;
input_data.f382	;
input_data.f383	;
input_data.f384	;
input_data.f385	;
input_data.f386	;
input_data.f387	;
input_data.f388	;
input_data.f389	;
input_data.f390	;
input_data.f391	;
input_data.f392	;
input_data.f393	;
input_data.f394	;
input_data.f395	;
input_data.f396	;
input_data.f397	;
input_data.f398	;
input_data.f399	;
input_data.f400	;
input_data.f401	;
input_data.f402	;
input_data.f403	;
input_data.f404	;
input_data.f405	;
input_data.f406	;
input_data.f407	;
input_data.f408	;
input_data.f409	;
input_data.f410	;
input_data.f411	;
input_data.f412	;
input_data.f413	;
input_data.f414	;
input_data.f415	;
input_data.f416	;
input_data.f417	;
input_data.f418	;
input_data.f419	;
input_data.f420	;
input_data.f421	;
input_data.f422	;
input_data.f423	;
input_data.f424	;
input_data.f425	;
input_data.f426	;
input_data.f427	;
input_data.f428	;
input_data.f429	;
input_data.f430	;
input_data.f431	;
input_data.f432	;
input_data.f433	;
input_data.f434	;
input_data.f435	;
input_data.f436	;
input_data.f437	;
input_data.f438	;
input_data.f439	;
input_data.f440	;
input_data.f441	;
input_data.f442	;
input_data.f443	;
input_data.f444	;
input_data.f445	;
input_data.f446	;
input_data.f447	;
input_data.f448	;
input_data.f449	;
input_data.f450	;
input_data.f451	;
input_data.f452	;
input_data.f453	;
input_data.f454	;
input_data.f455	;
input_data.f456	;
input_data.f457	;
input_data.f458	;
input_data.f459	;
input_data.f460	;
input_data.f461	;
input_data.f462	;
input_data.f463	;
input_data.f464	;
input_data.f465	;
input_data.f466	;
input_data.f467	;
input_data.f468	;
input_data.f469	;
input_data.f470	;
input_data.f471	;
input_data.f472	;
input_data.f473	;
input_data.f474	;
input_data.f475	;
input_data.f476	;
input_data.f477	;
input_data.f478	;
input_data.f479	;
input_data.f480	;
input_data.f481	;
input_data.f482	;
input_data.f483	;
input_data.f484	;
input_data.f485	;
input_data.f486	;
input_data.f487	;
input_data.f488	;
input_data.f489	;
input_data.f490	;
input_data.f491	;
input_data.f492	;
input_data.f493	;
input_data.f494	;
input_data.f495	;
input_data.f496	;
input_data.f497	;
input_data.f498	;
input_data.f499	;
input_data.f500	;
input_data.f501	;
input_data.f502	;
input_data.f503	;
input_data.f504	;
input_data.f505	;
input_data.f506	;
input_data.f507	;
input_data.f508	;
input_data.f509	;
input_data.f510	;
input_data.f511	;
input_data.f512	;
input_data.f513	;
input_data.f514	;
input_data.f515	;
input_data.f516	;
input_data.f517	;
input_data.f518	;
input_data.f519	;
input_data.f520	;
input_data.f521	;
input_data.f522	;
input_data.f523	;
input_data.f524	;
input_data.f525	;
input_data.f526	;
input_data.f527	;
input_data.f528	;
input_data.f529	;
input_data.f530	;
input_data.f531	;
input_data.f532	;
input_data.f533	;
input_data.f534	;
input_data.f535	;
input_data.f536	;
input_data.f537	;
input_data.f538	;
input_data.f539	;
input_data.f540	;
input_data.f541	;
input_data.f542	;
input_data.f543	;
input_data.f544	;
input_data.f545	;
input_data.f546	;
input_data.f547	;
input_data.f548	;
input_data.f549	;
input_data.f550	;
input_data.f551	;
input_data.f552	;
input_data.f553	;
input_data.f554	;
input_data.f555	;
input_data.f556	;
input_data.f557	;
input_data.f558	;
input_data.f559	;
input_data.f560	;
input_data.f561	;
input_data.f562	;
input_data.f563	;
input_data.f564	;
input_data.f565	;
input_data.f566	;
input_data.f567	;
input_data.f568	;
input_data.f569	;
input_data.f570	;
input_data.f571	;
input_data.f572	;
input_data.f573	;
input_data.f574	;
input_data.f575	;
input_data.f576	;
input_data.f577	;
input_data.f578	;
input_data.f579	;
input_data.f580	;
input_data.f581	;
input_data.f582	;
input_data.f583	;
input_data.f584	;
input_data.f585	;
input_data.f586	;
input_data.f587	;
input_data.f588	;
input_data.f589	;
input_data.f590	;
input_data.f591	;
input_data.f592	;
input_data.f593	;
input_data.f594	;
input_data.f595	;
input_data.f596	;
input_data.f597	;
input_data.f598	;
input_data.f599	;
input_data.f600	;
input_data.f601	;
input_data.f602	;
input_data.f603	;
input_data.f604	;
input_data.f605	;
input_data.f606	;
input_data.f607	;
input_data.f608	;
input_data.f609	;
input_data.f610	;
input_data.f611	;
input_data.f612	;
input_data.f613	;
input_data.f614	;
input_data.f615	;
input_data.f616	;
input_data.f617	;
input_data.f618	;
input_data.f619	;
input_data.f620	;
input_data.f621	;
input_data.f622	;
input_data.f623	;
input_data.f624	;
input_data.f625	;
input_data.f626	;
input_data.f627	;
input_data.f628	;
input_data.f629	;
input_data.f630	;
input_data.f631	;
input_data.f632	;
input_data.f633	;
input_data.f634	;
input_data.f635	;
input_data.f636	;
input_data.f637	;
input_data.f638	;
input_data.f639	;
input_data.f640	;
input_data.f641	;
input_data.f642	;
input_data.f643	;
input_data.f644	;
input_data.f645	;
input_data.f646	;
input_data.f647	;
input_data.f648	;
input_data.f649	;
input_data.f650	;
input_data.f651	;
input_data.f652	;
input_data.f653	;
input_data.f654	;
input_data.f655	;
input_data.f656	;
input_data.f657	;
input_data.f658	;
input_data.f659	;
input_data.f660	;
input_data.f661	;
input_data.f662	;
input_data.f663	;
input_data.f664	;
input_data.f665	;
input_data.f666	;
input_data.f667	;
input_data.f668	;
input_data.f669	;
input_data.f670	;
input_data.f671	;
input_data.f672	;
input_data.f673	;
input_data.f674	;
input_data.f675	;
input_data.f676	;
input_data.f677	;
input_data.f678	;
input_data.f679	;
input_data.f680	;
input_data.f681	;
input_data.f682	;
input_data.f683	;
input_data.f684	;
input_data.f685	;
input_data.f686	;
input_data.f687	;
input_data.f688	;
input_data.f689	;
input_data.f690	;
input_data.f691	;
input_data.f692	;
input_data.f693	;
input_data.f694	;
input_data.f695	;
input_data.f696	;
input_data.f697	;
input_data.f698	;
input_data.f699	;
input_data.f700	;
input_data.f701	;
input_data.f702	;
input_data.f703	;
input_data.f704	;
input_data.f705	;
input_data.f706	;
input_data.f707	;
input_data.f708	;
input_data.f709	;
input_data.f710	;
input_data.f711	;
input_data.f712	;
input_data.f713	;
input_data.f714	;
input_data.f715	;
input_data.f716	;
input_data.f717	;
input_data.f718	;
input_data.f719	;
input_data.f720	;
input_data.f721	;
input_data.f722	;
input_data.f723	;
input_data.f724	;
input_data.f725	;
input_data.f726	;
input_data.f727	;
input_data.f728	;
input_data.f729	;
input_data.f730	;
input_data.f731	;
input_data.f732	;
input_data.f733	;
input_data.f734	;
input_data.f735	;
input_data.f736	;
input_data.f737	;
input_data.f738	;
input_data.f739	;
input_data.f740	;
input_data.f741	;
input_data.f742	;
input_data.f743	;
input_data.f744	;
input_data.f745	;
input_data.f746	;
input_data.f747	;
input_data.f748	;
input_data.f749	;
input_data.f750	;
input_data.f751	;
input_data.f752	;
input_data.f753	;
input_data.f754	;
input_data.f755	;
input_data.f756	;
input_data.f757	;
input_data.f758	;
input_data.f759	;
input_data.f760	;
input_data.f761	;
input_data.f762	;
input_data.f763	;
input_data.f764	;
input_data.f765	;
input_data.f766	;
input_data.f767	;
input_data.f768	;
input_data.f769	;
input_data.f770	;
input_data.f771	;
input_data.f772	;
input_data.f773	;
input_data.f774	;
input_data.f775	;
input_data.f776	;
input_data.f777	;
input_data.f778	;
input_data.f779	;
input_data.f780	;
input_data.f781	;
input_data.f782	;
input_data.f783	;
input_data.f784	;
END;

sample_table := TABLE(input_data,Sampledata_Format);
OUTPUT  (sample_table, NAMED ('sample_table'));

ML.ToField(sample_table, indepDataC);
OUTPUT  (indepDataC, NAMED ('indepDataC'));


//define the parameters for the Sparse Autoencoder
//ALPHA is learning rate
//LAMBDA is weight decay rate
REAL8 sparsityParam  := 0.1;
REAL8 BETA := 0.1;
REAL8 ALPHA := 0.1;
REAL8 LAMBDA :=0.1;
UNSIGNED2 MaxIter :=2;
UNSIGNED4 prows:=0;
UNSIGNED4 pcols:=0;
UNSIGNED4 Maxrows:=0;
UNSIGNED4 Maxcols:=0;
//initialize weight and bias values for the Back Propagation algorithm
IntW := ML.DeepLearning.Sparse_Autoencoder_IntWeights(f,hl);
Intb := ML.DeepLearning.Sparse_Autoencoder_IntBias(f,hl);
output(IntW, named ('IntW'));
output(IntB, named ('IntB'));
//trainer module
SA :=ML.DeepLearning.Sparse_Autoencoder(prows, pcols, Maxrows,  Maxcols);

LearntModel := SA.LearnC(indepDataC,IntW, Intb,BETA, sparsityParam, LAMBDA, ALPHA, MaxIter);
mout := max(LearntModel,id);
output(LearntModel(id=1));

// MatrixModel := SA.Model (LearntModel);
// output(MatrixModel, named ('MatrixModel'));

// Out := SA.SAOutput (indepDataC, LearntModel);
// output(Out, named ('Out'));


