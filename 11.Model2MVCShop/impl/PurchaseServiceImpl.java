package com.model2.mvc.service.purchase.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	@Qualifier("purchaseDaoImpl")
	PurchaseDao purchaseDao;
	
	public PurchaseServiceImpl() {
		System.out.println(":: "+getClass()+" default 생성자 호출...");
	}
	
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		System.out.println("::"+".setPurchaseDao 생성자호출");
		this.purchaseDao = purchaseDao;
	}

//	@Override
//	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {
//		return purchaseDao.getPurchaseList(search, buyerId);
//	}
	
	@Override
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {
		 
		List<Purchase> list = purchaseDao.getPurchaseList(search, buyerId);
		List<String> arrived = new ArrayList<String>();
		List<String> state = new ArrayList<String>();
		String productArrive = "";
		String tranState = "";
		
		for (int i = 0; i < list.size(); i++) {
			String tranCode = (list.get(i).getTranCode() ).trim();
			System.out.println("_"+tranCode+"_");
			
			if( tranCode.equals("1") ) {
				tranState = "구매완료상태";
				productArrive = "";
			}else if(tranCode.equals("2")) {
				
				tranState = "배송중상태";
				productArrive = "물건도착";
			}else if(tranCode.equals("3")) {
				tranState = "배송완료상태";
				productArrive = "";
			}
			state.add(tranState);
			arrived.add(productArrive);
			System.out.println("확인:"+state.get(i));
		}
		
		int totalRow = purchaseDao.getPurchaseTotalRow(buyerId);
		
		Map<String, Object>map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("totalRow", totalRow);
		map.put("arrived", arrived);
		map.put("state", state);
		
		return map;
	}

	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		return purchaseDao.findPurchase(tranNo);
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}

	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		return purchaseDao.getSaleList(search);
	}

	@Override
	public void addPurchase(Purchase purchase) throws Exception {
		purchaseDao.insertPurchase(purchase);
	}

	@Override
	public void updateTranCode(int tranNo, String tranCode) throws Exception {
		purchaseDao.updateTranCode(tranNo, tranCode);
	}

}
