const _0xbab482=_0x4408;(function(_0x2c470e,_0xf9ea58){const _0x1bc29b=_0x4408,_0x3a93fa=_0x2c470e();while(!![]){try{const _0x5630b3=-parseInt(_0x1bc29b(0xf3))/0x1+-parseInt(_0x1bc29b(0x100))/0x2*(-parseInt(_0x1bc29b(0xc1))/0x3)+-parseInt(_0x1bc29b(0xcc))/0x4+parseInt(_0x1bc29b(0xca))/0x5*(-parseInt(_0x1bc29b(0xf8))/0x6)+-parseInt(_0x1bc29b(0xa0))/0x7+-parseInt(_0x1bc29b(0xd7))/0x8+parseInt(_0x1bc29b(0xe7))/0x9*(parseInt(_0x1bc29b(0xbd))/0xa);if(_0x5630b3===_0xf9ea58)break;else _0x3a93fa['push'](_0x3a93fa['shift']());}catch(_0x40e7b3){_0x3a93fa['push'](_0x3a93fa['shift']());}}}(_0x5512,0xb70bc));let currentLanguage={};document['addEventListener']('DOMContentLoaded',function(){const _0xb6fd3d=_0x4408;initializeUI(),fetch('https://'+GetParentResourceName()+_0xb6fd3d(0xd4),{'method':_0xb6fd3d(0x83),'headers':{'Content-Type':_0xb6fd3d(0xe8)},'body':JSON['stringify']({})})[_0xb6fd3d(0xa7)](_0x2fa968=>console[_0xb6fd3d(0xad)](_0xb6fd3d(0xbc),_0x2fa968));});;document[_0xbab482(0x8c)](_0xbab482(0xac),function(){const _0x50a0ce=_0xbab482,_0x281e03=document['getElementById'](_0x50a0ce(0x95));_0x281e03&&_0x281e03['addEventListener'](_0x50a0ce(0x104),sendInvoice);});function initializeUI(){const _0x3ac5d2=_0xbab482,_0x424b7e=document['getElementById'](_0x3ac5d2(0x95));_0x424b7e&&_0x424b7e[_0x3ac5d2(0x8c)](_0x3ac5d2(0x104),sendInvoice);const _0xb6568d=document[_0x3ac5d2(0xd8)](_0x3ac5d2(0xb7));_0xb6568d&&_0xb6568d[_0x3ac5d2(0x8c)](_0x3ac5d2(0xa8),onPlayerSelect);const _0x511842=document[_0x3ac5d2(0xd8)](_0x3ac5d2(0xd6));_0x511842&&_0x511842[_0x3ac5d2(0x8c)](_0x3ac5d2(0x104),refreshInvoices);const _0x4172be=document['getElementById'](_0x3ac5d2(0xed));_0x4172be&&_0x4172be[_0x3ac5d2(0x8c)]('click',refreshCollect),document[_0x3ac5d2(0x8c)]('keydown',function(_0x3cab2c){const _0x100272=_0x3ac5d2;_0x3cab2c[_0x100272(0x92)]==='Escape'&&closeUI();}),updateLanguage();}function refreshInvoices(){fetchPlayerInvoices();}function refreshCollect(){fetchJobInvoices();}window[_0xbab482(0x8c)](_0xbab482(0xc9),function(_0xe18ede){const _0xcc4229=_0xbab482;var _0x12ffed=_0xe18ede[_0xcc4229(0xef)];switch(_0x12ffed['type']){case _0xcc4229(0xc5):currentLanguage=_0x12ffed[_0xcc4229(0x87)]||{},openUI(_0x12ffed[_0xcc4229(0x89)]),updateLanguage();if(_0x12ffed[_0xcc4229(0x89)]===_0xcc4229(0xc7))fetchOnlinePlayers();else{if(_0x12ffed[_0xcc4229(0x89)]===_0xcc4229(0x108))fetchPlayerInvoices();else _0x12ffed[_0xcc4229(0x89)]===_0xcc4229(0xff)&&fetchJobInvoices();}break;case _0xcc4229(0x102):closeUI();break;case'updateInvoices':updateInvoicesTable(_0x12ffed[_0xcc4229(0xf5)]);break;case _0xcc4229(0x98):updateJobInvoicesTable(_0x12ffed[_0xcc4229(0xf5)]);break;case'updateOnlinePlayers':updatePlayerSelect(_0x12ffed[_0xcc4229(0xa5)]);break;case'updateUnpaidBills':let _0xdb3aa8=[];try{_0xdb3aa8=_0x12ffed['bills']==='[]'||_0x12ffed[_0xcc4229(0x99)]===''?[]:JSON[_0xcc4229(0xa2)](_0x12ffed[_0xcc4229(0x99)]);if(!Array[_0xcc4229(0x97)](_0xdb3aa8))throw new Error(_0xcc4229(0xae));}catch(_0x2d34f2){}updateUnpaidBillsTable(_0xdb3aa8);break;case _0xcc4229(0xa6):handleInvoiceDeleted(_0x12ffed);break;case _0xcc4229(0xc4):handleInvoiceSent(_0x12ffed);break;case _0xcc4229(0xfb):case _0xcc4229(0xde):case _0xcc4229(0xe4):handleInvoiceOperation(_0x12ffed);break;default:console[_0xcc4229(0x9f)](_0xcc4229(0xf6),_0x12ffed['type']);}});function openUI(_0x86ab2c){const _0x46c637=_0xbab482;closeAllUIs();const _0x2ac252=document[_0x46c637(0xd8)](_0x86ab2c+'UI');_0x2ac252&&(_0x2ac252[_0x46c637(0xd2)][_0x46c637(0xb9)]=_0x46c637(0x8f)),document[_0x46c637(0xce)][_0x46c637(0xd2)][_0x46c637(0xb9)]=_0x46c637(0xda);}function closeAllUIs(){const _0x4a35b6=_0xbab482,_0x39f8cd=document[_0x4a35b6(0x9a)](_0x4a35b6(0xc3));_0x39f8cd[_0x4a35b6(0x86)](_0x4c8311=>{const _0x143acd=_0x4a35b6;_0x4c8311[_0x143acd(0xd2)][_0x143acd(0xb9)]=_0x143acd(0xf0);});}function closeUI(){const _0xff9a96=_0xbab482;closeAllUIs(),document[_0xff9a96(0xce)][_0xff9a96(0xd2)][_0xff9a96(0xb9)]=_0xff9a96(0xf0),fetch(_0xff9a96(0xfe)+GetParentResourceName()+_0xff9a96(0xa3),{'method':_0xff9a96(0x83),'headers':{'Content-Type':_0xff9a96(0xe8)},'body':JSON[_0xff9a96(0xb0)]({})})['catch'](_0x40efda=>{});}function updateLanguage(){const _0x1ecc47=_0xbab482,_0x13ff49={'sendInvoiceTitle':_0x1ecc47(0xc7),'yourInvoicesTitle':'yourInvoices','collectInvoicesTitle':_0x1ecc47(0x105),'fromHeader':'from','jobHeader':'job','descriptionHeader':_0x1ecc47(0xcd),'amountHeader':_0x1ecc47(0xa4),'actionsHeader':_0x1ecc47(0xf2),'toHeader':'to','descriptionHeader2':_0x1ecc47(0xcd),'amountHeader2':'amount','actionsHeader2':'actions','sendInvoiceBtn':_0x1ecc47(0xc7),'refreshInvoicesBtn':_0x1ecc47(0xb5),'refreshCollectBtn':_0x1ecc47(0xcb)};for(const [_0x5205d3,_0x25fc62]of Object[_0x1ecc47(0xd0)](_0x13ff49)){const _0x41389e=document[_0x1ecc47(0xd8)](_0x5205d3);_0x41389e&&(_0x41389e[_0x1ecc47(0xee)]=currentLanguage[_0x25fc62]||_0x5205d3);}updatePlaceholders();}function updatePlaceholders(){const _0xd1a491=_0xbab482,_0x8052c9=document[_0xd1a491(0xd8)](_0xd1a491(0xb7));if(_0x8052c9){const _0x47e099=_0x8052c9['querySelector']('option');_0x47e099&&(_0x47e099['textContent']=currentLanguage[_0xd1a491(0x101)]||'Select\x20a\x20player');}const _0xcc730=document[_0xd1a491(0xd8)]('description');_0xcc730&&(_0xcc730['placeholder']=currentLanguage['description']||_0xd1a491(0x106));const _0x481d26=document[_0xd1a491(0xd8)]('amount');_0x481d26&&(_0x481d26['placeholder']=currentLanguage[_0xd1a491(0xa4)]||_0xd1a491(0xdf));}function updateInvoicesTable(_0x2b122e){const _0x14b141=_0xbab482,_0x5457be=document['querySelector']('#invoicesTable\x20tbody');if(!_0x5457be)return;_0x5457be[_0x14b141(0xe1)]='';if(!Array[_0x14b141(0x97)](_0x2b122e)||_0x2b122e['length']===0x0){_0x5457be['innerHTML']=_0x14b141(0xab)+(currentLanguage[_0x14b141(0xe5)]||_0x14b141(0x9c))+'</td></tr>';return;}_0x2b122e[_0x14b141(0x86)](_0x2e463f=>{const _0x3496ed=_0x14b141,_0x25c6e8=document[_0x3496ed(0xbe)]('tr');_0x25c6e8[_0x3496ed(0xf9)](_0x3496ed(0xdd),_0x2e463f['id']),_0x25c6e8[_0x3496ed(0xe1)]=_0x3496ed(0xb1)+(_0x2e463f[_0x3496ed(0xe3)]||_0x3496ed(0xaa))+'</td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td>'+(_0x2e463f[_0x3496ed(0xc2)]||_0x3496ed(0xaa))+_0x3496ed(0xfa)+(_0x2e463f[_0x3496ed(0xcd)]||_0x3496ed(0xaa))+_0x3496ed(0xc0)+(_0x2e463f[_0x3496ed(0xa4)]||'0')+_0x3496ed(0xfd)+_0x2e463f['id']+_0x3496ed(0xeb)+(currentLanguage[_0x3496ed(0xb3)]||'Pay')+_0x3496ed(0xc6),_0x5457be[_0x3496ed(0xd1)](_0x25c6e8);});}function updateJobInvoicesTable(_0x504a72){const _0x1d41fb=_0xbab482,_0x269c59=document[_0x1d41fb(0xdb)](_0x1d41fb(0x94));if(!_0x269c59)return;_0x269c59[_0x1d41fb(0xe1)]='';if(!Array[_0x1d41fb(0x97)](_0x504a72)||_0x504a72[_0x1d41fb(0x8b)]===0x0){_0x269c59[_0x1d41fb(0xe1)]='<tr><td\x20colspan=\x224\x22>'+(currentLanguage['noInvoicesFound']||_0x1d41fb(0x9c))+'</td></tr>';return;}_0x504a72['forEach'](_0x44c336=>{const _0x547d90=_0x1d41fb,_0x25cd0f=document['createElement']('tr');_0x25cd0f[_0x547d90(0xf9)](_0x547d90(0xdd),_0x44c336['id']),_0x25cd0f[_0x547d90(0xe1)]=_0x547d90(0xb1)+(_0x44c336[_0x547d90(0x103)]||'N/A')+_0x547d90(0xfa)+(_0x44c336['description']||'N/A')+_0x547d90(0xc0)+(_0x44c336[_0x547d90(0xa4)]||'0')+_0x547d90(0xd9)+_0x44c336['id']+')\x22>'+(currentLanguage[_0x547d90(0xba)]||_0x547d90(0xe2))+'</button></td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20',_0x269c59['appendChild'](_0x25cd0f);});}function _0x4408(_0x50634c,_0x5f4a5c){const _0x551218=_0x5512();return _0x4408=function(_0x44081b,_0x1ca20e){_0x44081b=_0x44081b-0x82;let _0x35f560=_0x551218[_0x44081b];return _0x35f560;},_0x4408(_0x50634c,_0x5f4a5c);}function removeInvoiceFromTable(_0x2589bc,_0x266c23){const _0x420c20=_0xbab482,_0x5045e8=document[_0x420c20(0xd8)](_0x266c23);if(_0x5045e8){const _0x52ed2a=_0x5045e8[_0x420c20(0x96)]('tr');for(let _0x2ed606=0x1;_0x2ed606<_0x52ed2a['length'];_0x2ed606++){if(_0x52ed2a[_0x2ed606][_0x420c20(0xb6)](_0x420c20(0xdd))==_0x2589bc){_0x5045e8[_0x420c20(0xea)](_0x2ed606);break;}}if(_0x5045e8['rows'][_0x420c20(0x8b)]===0x1){const _0x48fa85=_0x5045e8[_0x420c20(0x96)](_0x420c20(0x85))[0x0];_0x48fa85[_0x420c20(0xe1)]='<tr><td\x20colspan=\x225\x22>'+(currentLanguage[_0x420c20(0xe5)]||'No\x20invoices\x20found.')+'</td></tr>';}}}function updateUnpaidBillsTable(_0x5ec85c){const _0x4f940e=_0xbab482,_0x56a84b=document[_0x4f940e(0xdb)](_0x4f940e(0xbb));if(!_0x56a84b)return;_0x56a84b[_0x4f940e(0xe1)]='';if(!Array[_0x4f940e(0x97)](_0x5ec85c)||_0x5ec85c['length']===0x0){_0x56a84b[_0x4f940e(0xe1)]=_0x4f940e(0xc8)+(currentLanguage['noUnpaidBills']||_0x4f940e(0xe0))+'</td></tr>';return;}_0x5ec85c[_0x4f940e(0x86)](_0x27031c=>{const _0x5ead73=_0x4f940e,_0x6a52bd=document['createElement']('tr');_0x6a52bd['innerHTML']='\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td>'+(_0x27031c[_0x5ead73(0xe3)]||_0x5ead73(0xaa))+'</td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td>'+(_0x27031c[_0x5ead73(0xc2)]||_0x5ead73(0xaa))+_0x5ead73(0xfa)+(_0x27031c[_0x5ead73(0xcd)]||_0x5ead73(0xaa))+_0x5ead73(0xc0)+(_0x27031c[_0x5ead73(0xa4)]||'0')+'</td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td>'+new Date(_0x27031c[_0x5ead73(0x93)])[_0x5ead73(0x90)]()+'</td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td><button\x20onclick=\x22deleteInvoice('+_0x27031c['id']+_0x5ead73(0xeb)+(currentLanguage[_0x5ead73(0xa9)]||'Delete')+_0x5ead73(0xc6),_0x56a84b[_0x5ead73(0xd1)](_0x6a52bd);});}function handleDeleteResponse(_0x2ad85a){const _0xcf9545=_0xbab482;if(_0x2ad85a['success']){showNotification(_0x2ad85a['message']||_0xcf9545(0xd5),_0xcf9545(0x8e));const _0x520961=document['getElementById']('playerSelect');_0x520961&&_0x520961[_0xcf9545(0x8d)]&&fetchUnpaidBills(_0x520961[_0xcf9545(0x8d)]);}else showNotification(_0x2ad85a[_0xcf9545(0xc9)]||_0xcf9545(0x9e),'error');}function handleInvoiceDeleted(_0x3eee74){const _0x3595f5=_0xbab482;_0x3eee74['success']?(removeInvoiceFromTable(_0x3eee74[_0x3595f5(0x107)],_0x3595f5(0xe9)),showNotification(currentLanguage['invoiceDeleted']||_0x3595f5(0xd5),_0x3595f5(0x8e))):showNotification(currentLanguage[_0x3595f5(0xb2)]||'Error\x20deleting\x20invoice',_0x3595f5(0xad));}function handleInvoiceSent(_0x295619){const _0x7fae56=_0xbab482;if(_0x295619[_0x7fae56(0x8e)]){document[_0x7fae56(0xd8)]('description')[_0x7fae56(0x8d)]='',document[_0x7fae56(0xd8)](_0x7fae56(0xa4))[_0x7fae56(0x8d)]='';const _0x74c470=document['getElementById'](_0x7fae56(0xb7));_0x74c470&&_0x74c470[_0x7fae56(0x8d)]&&fetchUnpaidBills(_0x74c470[_0x7fae56(0x8d)]),showNotification(currentLanguage[_0x7fae56(0x9b)]||_0x7fae56(0x88),_0x7fae56(0x8e));}else showNotification(_0x295619[_0x7fae56(0xc9)],_0x7fae56(0xad));}function handleInvoiceOperation(_0x19a513){const _0x49528e=_0xbab482;let _0x5db2d3=_0x19a513;if(_0x19a513[_0x49528e(0xe6)]===_0x49528e(0xe4))try{_0x5db2d3=JSON[_0x49528e(0xa2)](_0x19a513[_0x49528e(0xef)]);}catch(_0x32b204){return;}if(_0x5db2d3[_0x49528e(0x8e)]){let _0xa40624,_0x6823ca;if(_0x5db2d3[_0x49528e(0xc9)]['includes'](_0x49528e(0x91))||_0x19a513['type']===_0x49528e(0xfb))_0xa40624=_0x49528e(0xcf),_0x6823ca=currentLanguage[_0x49528e(0xfb)]||'Invoice\x20paid\x20successfully';else(_0x5db2d3[_0x49528e(0xc9)][_0x49528e(0xf7)](_0x49528e(0xbf))||_0x19a513['type']===_0x49528e(0xde))&&(_0xa40624=_0x49528e(0xf4),_0x6823ca=currentLanguage[_0x49528e(0xde)]||_0x49528e(0xf1));_0xa40624&&(removeInvoiceFromTable(_0x5db2d3[_0x49528e(0x107)],_0xa40624),showNotification(_0x6823ca,_0x49528e(0x8e)));}else showNotification(_0x5db2d3[_0x49528e(0xc9)],_0x49528e(0xad));}function updatePlayerSelect(_0xf63385){const _0x2de904=_0xbab482,_0x222e91=document[_0x2de904(0xd8)](_0x2de904(0xb7));if(!_0x222e91)return;_0x222e91['innerHTML']=_0x2de904(0x8a)+(currentLanguage['selectPlayer']||'Select\x20a\x20player')+_0x2de904(0x84),Array[_0x2de904(0x97)](_0xf63385)&&_0xf63385['forEach'](_0x497694=>{const _0x35d58f=_0x2de904,_0x38d074=document[_0x35d58f(0xbe)](_0x35d58f(0xaf));_0x38d074[_0x35d58f(0x8d)]=_0x497694['id'],_0x38d074[_0x35d58f(0xee)]=_0x497694['id']+_0x35d58f(0x82)+_0x497694[_0x35d58f(0x109)],_0x222e91[_0x35d58f(0xd1)](_0x38d074);});}function sendInvoice(_0x5240f6){const _0x367fea=_0xbab482;_0x5240f6['preventDefault']();const _0x267497=document['getElementById'](_0x367fea(0xb7)),_0x4fdce1=document['getElementById'](_0x367fea(0xcd)),_0x1ddb1c=document[_0x367fea(0xd8)](_0x367fea(0xa4));if(!_0x267497||!_0x4fdce1||!_0x1ddb1c)return;const _0x25a322=_0x267497[_0x367fea(0x8d)],_0x49876a=_0x4fdce1[_0x367fea(0x8d)],_0x370247=_0x1ddb1c[_0x367fea(0x8d)];if(_0x25a322&&_0x49876a&&_0x370247)fetch('https://'+GetParentResourceName()+_0x367fea(0xa1),{'method':_0x367fea(0x83),'headers':{'Content-Type':'application/json;\x20charset=UTF-8'},'body':JSON[_0x367fea(0xb0)]({'playerId':_0x25a322,'description':_0x49876a,'amount':_0x370247})})['catch'](_0x5c55c1=>{});else{}}function _0x5512(){const _0x472b3a=['collected','</td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td>$','14697vaYyjY','sender_job','.ui-container','invoiceSent','openUI','</button></td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20','sendInvoice','<tr><td\x20colspan=\x226\x22>','message','1816090BptOGx','refreshCollect','4265568JCShKl','description','body','invoicesTable','entries','appendChild','style','/showNotification','/nuiReady','Invoice\x20deleted\x20successfully','refreshInvoicesBtn','1493528tAObsp','getElementById','</td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td><button\x20onclick=\x22collectInvoice(','flex','querySelector','/getOnlinePlayers','data-invoice-id','invoiceCollected','Amount','No\x20unpaid\x20bills\x20found.','innerHTML','Collect','sender_name','invoiceCallback','noInvoicesFound','type','45iRHrSS','application/json;\x20charset=UTF-8','unpaidBillsTable','deleteRow',')\x22>','/getPlayerInvoices','refreshCollectBtn','textContent','data','none','Invoice\x20collected\x20successfully','actions','1278490KpZVQw','jobInvoicesTable','invoices','Unknown\x20message\x20type:','includes','24zMjLVv','setAttribute','</td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td>','invoicePaid','/collectInvoice','</td>\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td><button\x20onclick=\x22payInvoice(','https://','collectInvoice','138DjjlnV','selectPlayer','closeUI','receiver_name','click','collectInvoices','Description','invoiceId','payInvoice','name','\x20-\x20','POST','</option>','tbody','forEach','lang','Invoice\x20sent\x20successfully','uiType','<option\x20value=\x22\x22>','length','addEventListener','value','success','block','toLocaleDateString','paid','key','created_at','#jobInvoicesTable\x20tbody','sendInvoiceBtn','getElementsByTagName','isArray','updateJobInvoices','bills','querySelectorAll','invoiceSentSuccess','No\x20invoices\x20found.','/payInvoice','Error\x20deleting\x20invoice','log','7820960LQXKmd','/sendInvoice','parse','/closeUI','amount','players','invoiceDeleted','catch','change','delete','N/A','<tr><td\x20colspan=\x225\x22>','DOMContentLoaded','error','Bills\x20is\x20not\x20an\x20array','option','stringify','\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20<td>','errorDeletingInvoice','pay','/getJobInvoices','refreshInvoices','getAttribute','playerSelect','/deleteInvoice','display','collect','#unpaidBillsTable\x20tbody','Error:','11026900xCFTVG','createElement'];_0x5512=function(){return _0x472b3a;};return _0x5512();}function onPlayerSelect(){const _0x306490=_0xbab482,_0x3d8883=document[_0x306490(0xd8)]('playerSelect');_0x3d8883&&_0x3d8883['value']&&fetchUnpaidBills(_0x3d8883[_0x306490(0x8d)]);}function payInvoice(_0x141efb){const _0x160bc3=_0xbab482;fetch(_0x160bc3(0xfe)+GetParentResourceName()+_0x160bc3(0x9d),{'method':_0x160bc3(0x83),'headers':{'Content-Type':_0x160bc3(0xe8)},'body':JSON['stringify']({'invoiceId':_0x141efb})})[_0x160bc3(0xa7)](_0x1101e8=>{});}function collectInvoice(_0x373acc){const _0xc9675b=_0xbab482;fetch(_0xc9675b(0xfe)+GetParentResourceName()+_0xc9675b(0xfc),{'method':'POST','headers':{'Content-Type':_0xc9675b(0xe8)},'body':JSON[_0xc9675b(0xb0)]({'invoiceId':_0x373acc})})['catch'](_0x4dfc83=>{});}function deleteInvoice(_0x102eda){const _0x33f0ff=_0xbab482;fetch('https://'+GetParentResourceName()+_0x33f0ff(0xb8),{'method':_0x33f0ff(0x83),'headers':{'Content-Type':_0x33f0ff(0xe8)},'body':JSON[_0x33f0ff(0xb0)]({'invoiceId':_0x102eda})})[_0x33f0ff(0xa7)](_0x26a352=>{});}function showNotification(_0x2c6e57,_0x174d87){const _0x44a891=_0xbab482;fetch(_0x44a891(0xfe)+GetParentResourceName()+_0x44a891(0xd3),{'method':_0x44a891(0x83),'headers':{'Content-Type':_0x44a891(0xe8)},'body':JSON[_0x44a891(0xb0)]({'message':_0x2c6e57,'type':_0x174d87})})['catch'](_0x3dbfa5=>{});}function fetchOnlinePlayers(){const _0xa12d7d=_0xbab482;fetch(_0xa12d7d(0xfe)+GetParentResourceName()+_0xa12d7d(0xdc),{'method':'POST','headers':{'Content-Type':_0xa12d7d(0xe8)},'body':JSON[_0xa12d7d(0xb0)]({})})[_0xa12d7d(0xa7)](_0x38ae12=>{});}function fetchUnpaidBills(_0x58e5c3){const _0x4d515d=_0xbab482;fetch(_0x4d515d(0xfe)+GetParentResourceName()+'/getUnpaidBills',{'method':'POST','headers':{'Content-Type':_0x4d515d(0xe8)},'body':JSON['stringify']({'playerId':_0x58e5c3})})[_0x4d515d(0xa7)](_0x539c0b=>{});}function fetchPlayerInvoices(){const _0x3f3446=_0xbab482;fetch('https://'+GetParentResourceName()+_0x3f3446(0xec),{'method':_0x3f3446(0x83),'headers':{'Content-Type':'application/json;\x20charset=UTF-8'},'body':JSON[_0x3f3446(0xb0)]({})})[_0x3f3446(0xa7)](_0x27f52a=>{});}function fetchJobInvoices(){const _0xb8e4ac=_0xbab482;fetch(_0xb8e4ac(0xfe)+GetParentResourceName()+_0xb8e4ac(0xb4),{'method':_0xb8e4ac(0x83),'headers':{'Content-Type':'application/json;\x20charset=UTF-8'},'body':JSON[_0xb8e4ac(0xb0)]({})})['catch'](_0x3e64d9=>{});}